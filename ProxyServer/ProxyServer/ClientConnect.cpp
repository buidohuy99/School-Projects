#include "ClientConnect.h"
#include <fstream>

using namespace std;

const char* error400 = 
	"<html><head><title>400 Bad request</title></head>"
	"<body><p>Request is bad, proxy can't process!</p></body></html>";
const char* error408 =
	"<html><head><title>408 Connection TimedOut</title></head>"
	"<body><p>Connection timed-Out, closing Connection</p></body></html>";
const char* error503 =
	"<html><head><title>503 Service unavailable</title></head>"
	"<body><p>Oh my, cannot fetch from the website your requesting</p></body></html>";
const char* error403 =
	"<html><head><title>403 Forbidden</title></head>"
	"<body><p>Oh my, the proxy blocked this website :(((( so sed</p></body></html>";
const char* temp200 = 
	"<html><head><title>200 Connected to Proxy</title></head>"
	"<body><p>Connect successful</p></body></html>";
const char* pageNotSupported =
	"<html><head><title>Can't load page :(((</title></head>"
	"<body><p>Hm, it seems the proxy is too incompetent to handle this webpage. Such a stupid proxy right? Change to a new one :))))</p></body></html>";
const char* resourceTooBig=
	"<html><head><title>Can't load resource :(((</title></head>"
	"<body><p>Hm, it seems the proxy is too incompetent to handle this enormous ass resource T.T</p></body></html>";

void toLowerACStr(char* str){
	for(int i = 0; str[i]!='\0'; i++){
		str[i] = tolower(str[i]);
	}
}

void toUpperACStr(char* str){
	for(int i = 0; str[i]!='\0'; i++){
		str[i] = toupper(str[i]);
	}
}

char *trimwhitespace(char *str)
{
  char *end;

  // Trim leading space
  while(isspace((unsigned char)*str)) str++;

  if(*str == 0)  // All spaces?
    return str;

  // Trim trailing space
  end = str + strlen(str) - 1;
  while(end > str && isspace((unsigned char)*end)) end--;

  // Write new null terminator character
  end[1] = '\0';

  return str;
}

ClientConnect::ClientConnect(void)
{
	client = INVALID_SOCKET;
	internet = INVALID_SOCKET;
	clientEvent = WSA_INVALID_EVENT;
	internetEvent = WSA_INVALID_EVENT;
	response = new char[2000000];
}

ClientConnect::~ClientConnect(void)
{
	delete[] response;
}

void ClientConnect::Init(SOCKET client){
	this->client = client;
	timeOut = 5.0f;
	clientEvent = WSACreateEvent();
	WSAEventSelect(client,clientEvent,FD_READ|FD_CLOSE);
	currentHost = "";
}

void ClientConnect::startTimingConn(){
	start = chrono::steady_clock::now();
}

void ClientConnect::close_connection_client(){
	if(clientEvent!=WSA_INVALID_EVENT){
		WSACloseEvent(clientEvent);
		clientEvent = WSA_INVALID_EVENT;
	}
	if(client!=INVALID_SOCKET){
		closesocket(client);
		client=INVALID_SOCKET;
	}
}

void ClientConnect::close_connection_internet(){
	if(internetEvent!=WSA_INVALID_EVENT) {
		WSACloseEvent(internetEvent);
		internetEvent = WSA_INVALID_EVENT;
	}
	if(internet!=INVALID_SOCKET) {
		closesocket(internet);
		internet=INVALID_SOCKET;
	}
}

void ClientConnect::shutdown_connection_client()
{
	if(client!=INVALID_SOCKET) shutdown(client,SD_SEND);
}
	
void ClientConnect::shutdown_connection_internet()
{
	if(internet!=INVALID_SOCKET) shutdown(internet,SD_SEND);
}

bool ClientConnect::getConnectState(){
	if(client==INVALID_SOCKET) return false;
	return true;
}

bool ClientConnect::checkForBlock(std::string fileName, std::string host){
	ifstream Fin;
	Fin.open(fileName);
	if (Fin.fail())
		printf("Failed to open file!\r\n");

	std::string temp;
	while (std::getline(Fin,temp))
	{
		if (temp.compare(host)==0){
			Fin.close();
			return true;
		}
	}

	Fin.close();
	return false;
}

int ClientConnect::run(int nConnections){
	char *connectionClose = "Connection: close\r\n";
	char *connectionKA = "Connection: Keep-Alive\r\n";
	char request[500] = {0}, header[500] = {0};
	memset(response,0,2000000);
	int keepConnection = -1;
	auto updateSessionTime = [&]()->int{
		//Update session time
		double dur = chrono::duration<double>(chrono::steady_clock::now() - start).count();
		timeOut-= dur;
		if(timeOut <= 0.0f) {
			printf("Connection Timeout\r\n");
			sprintf(response,"HTTP/1.1 408 Connection Timed-Out\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(error408), error408);
			send_to(response);
			//Gracefully shutdown
			shutdown_connection_client();
			//Close connection
			close_connection_client();
			shutdown_connection_internet();
			close_connection_internet();
			return nConnections - 1;
		}
		start = chrono::steady_clock::now();
		return nConnections;
	}; 

	//Wait client event
	int recvStas = WSAWaitForMultipleEvents(1,&clientEvent,FALSE,0,FALSE);
	if (recvStas == WSA_WAIT_TIMEOUT){
		int retCons = updateSessionTime();
		return retCons;
	} else if (recvStas == WSA_WAIT_FAILED){
		printf("Wait failed not in recv: %d\r\n", WSAGetLastError());
		shutdown_connection_client();
		close_connection_client();
		shutdown_connection_internet();
		close_connection_internet();
		return nConnections - 1;
	}

	timeOut = 5.0f;
	char* reqst = response;
	int reqLength = 0;
	//Get request
		int getRequest = recv_line(request,500);
		switch(getRequest){
			case -400: case -413:  //Reset
				{int Connnn = emptyRecv(response,2000000);
				if(Connnn == 0){
					shutdown_connection_client();
					//Close connection
					close_connection_client();
					shutdown_connection_internet();
					close_connection_internet();
					return nConnections-1;
				}
				sprintf(response,"HTTP/1.1 400 Bad Request\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionKA, strlen(error400), error400);
				send_to(response);
				start = chrono::steady_clock::now();
				return nConnections;}
			case -408 : case -3:
				printf("Shutting down connection gracefully: %d\r\n",abs(getRequest));
				//Send error to client
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 408 Request Timeout\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(error408), error408);
				send_to(response);
				//Gracefully shutdown
				shutdown_connection_client();
				//Close connection
				close_connection_client();
				shutdown_connection_internet();
				close_connection_internet();
				return nConnections-1;
			case -2: //Connection error, close connection right away
				//Get failed because of connections reasons, close the session
				printf("Error!!!!!\r\n");
				close_connection_client();
				close_connection_internet();
				return nConnections-1;
		};
		if(getRequest < 2 || request[getRequest-1] != '\n' || request[getRequest-2] != '\r'){
				//Get failed because of logic reasons, retry next time
				printf("Request Corrupted\r\n");
				//Send 400 to client
				int Connnn = emptyRecv(response,2000000);
				if(Connnn == 0){
					shutdown_connection_client();
					//Close connection
					close_connection_client();
					shutdown_connection_internet();
					close_connection_internet();
					return nConnections-1;
				}
				sprintf(response,"HTTP/1.1 400 Bad Request\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionKA, strlen(error400), error400);
				send_to(response);
				start = chrono::steady_clock::now();
				return nConnections;
		};
	//Parse request
	char* requestType, *protocolType, *link;
	requestType = strtok(request," ");
	toUpperACStr(requestType);
	link = strtok(NULL," ");
	protocolType = strtok(NULL,"\r");

	//Parse protocol Type And Version
	char* protTemp = protocolType;
	char* protocol = strtok(protTemp,"/");
	char* majorVer = strtok(NULL,".");
	char* minorVer = strtok(NULL,"\0");

	//Check eligible protocol
	if(strcmp(protocol,"HTTP")!=0) {
		fprintf(stdout,"requestProtocol %s not HTTP protocol\r\n",protocol);
		//400
		int Connnn = emptyRecv(response,2000000);
		if(Connnn == 0){
			shutdown_connection_client();
			//Close connection
			close_connection_client();
			shutdown_connection_internet();
			close_connection_internet();
			return nConnections-1;
		}
		sprintf(response,"HTTP/1.1 400 Bad Request\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionKA, strlen(error400), error400);
		send_to(response);
		start = chrono::steady_clock::now();
		return nConnections;
	}
		
	//Supported calls only
	if(strcmp(requestType,"GET")!=0 && strcmp(requestType,"POST")!=0 && strcmp(requestType,"HEAD")!=0){
		fprintf(stdout,"requestType not supported: %s\r\n",requestType);
		//501
		int Connnn = emptyRecv(response,2000000);
		if(Connnn == 0){
			shutdown_connection_client();
			//Close connection
			close_connection_client();
			shutdown_connection_internet();
			close_connection_internet();
			return nConnections-1;
		}
		sprintf(response,"HTTP/1.1 501 Method Not Supported\r\nServer: Proxy server in C\r\n\r\n");
		send_to(response);
		start = chrono::steady_clock::now();
		return nConnections;
	}
	int rqCall = -1;
	if(strcmp(requestType,"GET")==0) rqCall=0;
	else if(strcmp(requestType,"POST")==0) rqCall=1;
	else if(strcmp(requestType,"HEAD")==0) rqCall=2;
		
	//Supported HTTP 1.0 and 1.1
	int major = atoi(majorVer);
	if(major>=2) {
		fprintf(stdout,"majorVer not supported: %s\r\n",majorVer);
		//505
		int Connnn = emptyRecv(response,2000000);
		if(Connnn == 0){
			shutdown_connection_client();
			//Close connection
			close_connection_client();
			shutdown_connection_internet();
			close_connection_internet();
			return nConnections-1;
		}
		sprintf(response,"HTTP/1.1 505 Version Not Supported\r\nServer: Proxy server in C\r\n\r\n");
		send_to(response);
		start = chrono::steady_clock::now();
		return nConnections;
	}
	//Wrong minor ver
	int minor = atoi(minorVer);
	if(minor>=2) {
		fprintf(stdout,"minorVer unavailable: %s\r\n",minorVer);
		//505
		int Connnn = emptyRecv(response,2000000);
		if(Connnn == 0){
			shutdown_connection_client();
			//Close connection
			close_connection_client();
			shutdown_connection_internet();
			close_connection_internet();
			return nConnections-1;
		}
		sprintf(response,"HTTP/1.1 505 Version Not Supported\r\nServer: Proxy server in C\r\n\r\n");
		send_to(response);
		start = chrono::steady_clock::now();
		return nConnections;
	}

	//Parse host
	//Remove http://
	string strLink(link);
	int startURL= strLink.find_first_of(":") + 3;
	strLink = strLink.substr(startURL);
	
	//Get host and directory
	int foundDir = strLink.find_first_of("/");
	string host;
	{
		string dir;
		if(foundDir!=string::npos){ 
			host = strLink.substr(0,foundDir);
			dir = strLink.substr(foundDir);
		}else
		{
			host = strLink;
			dir = string("/");
		}
		{
			string rephrasedReq;
			rephrasedReq += string(requestType) + " "; rephrasedReq+= dir + " "; 
			rephrasedReq += string(protocol) + "/"; rephrasedReq+= string(majorVer) + ".";
			rephrasedReq += string(minorVer) + "\r\n";
			rephrasedReq += "Host: "; rephrasedReq += host; rephrasedReq += "\r\n";
			if(reqLength + rephrasedReq.length() > 2000000){
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 500 Internal Server Error\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(resourceTooBig), resourceTooBig);
				send_to(response);
				shutdown_connection_client();
				//Close connection
				close_connection_client();
				shutdown_connection_internet();
				close_connection_internet();
				start = chrono::steady_clock::now();
				return nConnections-1;
			}
			memcpy(reqst,rephrasedReq.c_str(),rephrasedReq.length());
			printf("Request:\r\n+++++%s",reqst);
			reqst += rephrasedReq.length();
			reqLength += rephrasedReq.length();
		}
	}

	bool checkIfBlocked = checkForBlock("blacklist.conf",host);
	if(checkIfBlocked){
		memset(response,0,2000000);
		sprintf(response,"HTTP/1.1 403 Forbidden\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(error403), error403);
		send_to(response);
		shutdown_connection_client();
		//Close connection
		close_connection_client();
		shutdown_connection_internet();
		close_connection_internet();
		start = chrono::steady_clock::now();
		return nConnections-1;
	}

	int clientContentLength=-1;
	bool useChunked = false;
	//Get headers
		while(true){
			memset(header,0,500);
			int getHeader = recv_line(header,500);
			switch(getHeader){
			   case -400: case -413:  //Reset
					{int Connnn = emptyRecv(response,2000000);
					if(Connnn == 0){
						shutdown_connection_client();
						//Close connection
						close_connection_client();
						shutdown_connection_internet();
						close_connection_internet();
						return nConnections-1;
					}
					sprintf(response,"HTTP/1.1 400 Bad Request\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionKA, strlen(error400), error400);
					send_to(response);
					start = chrono::steady_clock::now();
					return nConnections;}
				case -408 : case -3:
					//Send error to client
					memset(response,0,2000000);
					sprintf(response,"HTTP/1.1 408 Connection Timed-Out\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(error408), error408);
					send_to(response);
					 //Gracefully shutdown
					shutdown_connection_client();
					//Close connection
					close_connection_client();
					shutdown_connection_internet();
					close_connection_internet();
					return nConnections-1;
				case -2: //Connection error, close connection right away
					//Get failed because of connections reasons, close the session
					close_connection_client();
					close_connection_internet();
					return nConnections-1;
			};
			if(getHeader < 2 || header[getHeader-1] != '\n' || header[getHeader-2] != '\r'){
					//Get failed because of logic reasons, retry next time
					printf("Request Corrupted\r\n");
					//Send 400 to client
					int Connnn = emptyRecv(response,2000000);
					if(Connnn == 0){
						shutdown_connection_client();
						//Close connection
						close_connection_client();
						shutdown_connection_internet();
						close_connection_internet();
						return nConnections-1;
					}
					sprintf(response,"HTTP/1.1 400 Bad Request\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionKA, strlen(error400), error400);
					send_to(response);
					start = chrono::steady_clock::now();
					return nConnections;
			};
			if(getHeader==2) {
				if(reqLength + strlen(header) > 2000000){
					memset(response,0,2000000);
					sprintf(response,"HTTP/1.1 500 Internal Server Error\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(resourceTooBig), resourceTooBig);
					send_to(response);
					shutdown_connection_client();
					//Close connection
					close_connection_client();
					shutdown_connection_internet();
					close_connection_internet();
					start = chrono::steady_clock::now();
					return nConnections-1;
				}
				memcpy(reqst,header,strlen(header));
				reqst+= strlen(header);
				reqLength+= strlen(header);
				break;
			}
			char* getHeaderTag,* getHeaderContent;
			getHeaderTag = strtok(header,":");
			getHeaderContent = strtok(NULL,"\r");
			getHeaderTag = trimwhitespace (getHeaderTag);
			getHeaderContent = trimwhitespace (getHeaderContent);
			toLowerACStr(getHeaderTag);
			toLowerACStr(getHeaderContent);
			if(strcmp(getHeaderTag,"proxy-connection")==0 || strcmp(getHeaderTag,"connection")==0){
				if(strcmp(getHeaderContent,"close")==0){
					keepConnection = 0;
				}else if(strcmp(getHeaderContent,"keep-alive")==0){
					keepConnection = 1;
				}
			}
			if(strcmp(getHeaderTag,"content-length")==0){
				clientContentLength = atoi(getHeaderContent);
			}
			if(strcmp(getHeaderTag,"transfer-encoding")==0){
				useChunked = true;
			}
			if(strcmp(getHeaderTag,"host")==0) continue;
			string rephrasedHeader;
			if(strcmp(getHeaderTag,"proxy-connection")==0){
				rephrasedHeader+= "Connection";
			}else rephrasedHeader += string(getHeaderTag);
			rephrasedHeader += ": "; 
			rephrasedHeader += string(getHeaderContent);
			rephrasedHeader += "\r\n";
			if(reqLength + rephrasedHeader.length() > 2000000){
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 500 Internal Server Error\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(resourceTooBig), resourceTooBig);
				send_to(response);
				shutdown_connection_client();
				//Close connection
				close_connection_client();
				shutdown_connection_internet();
				close_connection_internet();
				start = chrono::steady_clock::now();
				return nConnections-1;
			}
			memcpy(reqst,rephrasedHeader.c_str(),rephrasedHeader.length());
			printf("%s",reqst);
			reqLength+= rephrasedHeader.length();
			reqst+= rephrasedHeader.length();
		}
	
	if(keepConnection == -1){
		if(minor == 0){
			keepConnection = 0;
		}else
		{
			keepConnection = 1;
		}
	}

	string connectionStr;
	if(keepConnection == 0){
		connectionStr = "close";
	}else if(keepConnection == 1){
		connectionStr = "keep-alive";
	}
	
	//Send the made request
	bool sameHost = false;
	LPHOSTENT toWebServer = gethostbyname(host.c_str());
	if(toWebServer == NULL){
		memset(response,0,2000000);
		sprintf(response,"HTTP/1.1 500 Internal Server Error\r\nServer: Proxy server in C\r\n%s\r\n",connectionClose);
		send_to(response);
		//Gracefully shutdown
		shutdown_connection_client();
		//Close connection
		close_connection_client();
		shutdown_connection_internet();
		close_connection_internet();
		return nConnections-1;
	}
	if(currentHost.length()==0) currentHost = host;
	else
	{
		if(currentHost.compare(host) == 0) sameHost = true;
		else {currentHost = host; keepConnection = -1;}
	}
	sockaddr_in WSAddrs;
	ZeroMemory(&WSAddrs,sizeof(WSAddrs));	
	WSAddrs.sin_family = AF_INET;
	WSAddrs.sin_port = htons(80);
	WSAddrs.sin_addr = *(LPIN_ADDR)(toWebServer->h_addr_list[0]);
	
	if(!sameHost){
		shutdown_connection_internet();
		close_connection_internet();
		internet = socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);
		internetEvent = WSACreateEvent();
		WSAEventSelect(internet,internetEvent,FD_CONNECT|FD_READ|FD_CLOSE);
		//Connect to web server
		int checkConnect = connection_to_internet(WSAddrs);
		if(checkConnect<=0){
			memset(response,0,2000000);
			sprintf(response,"HTTP/1.%d 503 Service Unavailable\r\nServer: Proxy server in C\r\nConnection: %s\r\nContent-Length: %d\r\nContent-Type: text/html\r\n\r\n%s",minor,connectionStr.c_str(), strlen(error503),error503);
			send_to(response);
			shutdown_connection_client();
			shutdown_connection_internet();
			//Server
			shutdown_connection_internet();
			close_connection_internet();
			start = chrono::steady_clock::now();
			return nConnections-1;
		}
	}
	
	//Sent request
	int checkSent = -1;
	
	if(rqCall == 0 || rqCall == 2){
		checkSent = send_binary(response,reqLength,false);
	}
	else if(rqCall == 1) 
	{
		if(clientContentLength >=0){
			if(reqLength + clientContentLength > 2000000){
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 500 Internal Server Error\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\n%sContent-Length: %d\r\n\r\n%s",connectionKA, strlen(resourceTooBig), resourceTooBig);
				send_to(response);
				shutdown_connection_internet();
				close_connection_internet();
				start = chrono::steady_clock::now();
				return nConnections;
			}
			int retCode = recv_length(reqst,clientContentLength);
			switch(retCode){
				case -408 : case -3:
					//Send error to client
					memset(response,0,2000000);
					sprintf(response,"HTTP/1.1 408 Connection Timed-Out\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(error408), error408);
					send_to(response);
					 //Gracefully shutdown
					shutdown_connection_client();
					//Close connection
					close_connection_client();
					shutdown_connection_internet();
					close_connection_internet();
					return nConnections-1;
				case -2: //Connection error, close connection right away
					//Get failed because of connections reasons, close the session
					close_connection_client();
					close_connection_internet();
					return nConnections-1;
			};
			reqLength+= clientContentLength;
			checkSent = send_binary(response,reqLength,false);
		}else if(useChunked)
		{
			int retCode = recv_chunks(reqst,2000000 - reqLength);
			switch(retCode){
				case -400: case -413: //Reset
					{int Connnn = emptyRecv(response,2000000);
					if(Connnn == 0){
						shutdown_connection_client();
						//Close connection
						close_connection_client();
						shutdown_connection_internet();
						close_connection_internet();
						return nConnections-1;
					}
					sprintf(response,"HTTP/1.1 400 Bad Request\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionKA, strlen(error400), error400);
					send_to(response);
					start = chrono::steady_clock::now();
					return nConnections;}
				case -408 : case -3:
					//Send error to client
					memset(response,0,2000000);
					sprintf(response,"HTTP/1.1 408 Connection Timed-Out\r\nServer: Proxy server in C\r\n%sContent-Length: %d\r\n\r\n%s",connectionClose, strlen(error408), error408);
					send_to(response);
					 //Gracefully shutdown
					shutdown_connection_client();
					//Close connection
					close_connection_client();
					shutdown_connection_internet();
					close_connection_internet();
					return nConnections-1;
				case -2: //Connection error, close connection right away
					//Get failed because of connections reasons, close the session
					close_connection_client();
					close_connection_internet();
					return nConnections-1;
			};
			reqLength+= retCode;
			checkSent = send_binary(response,reqLength,false);
		}
	}
	if(checkSent<=0){
		memset(response,0,2000000);
		sprintf(response,"HTTP/1.%d 503 Service Unavailable\r\nServer: Proxy server in C\r\nConnection: %s\r\nContent-Length: %d\r\nContent-Type: text/html\r\n\r\n%s",minor,connectionStr.c_str(), strlen(error503),error503);
		send_to(response);
		shutdown_connection_client();
		close_connection_client();
		//Server
		shutdown_connection_internet();
		close_connection_internet();
		start = chrono::steady_clock::now();
		return nConnections-1;
	}
	
	//Receive request
	memset(response,0,reqLength);
	char* res = response;
	int contentLength = -1;
	int resSerConn = -1;
	int lenHeaderAndResponse = 0;
	useChunked = false;
	while(true){
		int getRes = recv_line(res,2000000 - lenHeaderAndResponse ,false);
		switch(getRes){
			case -400: case -413: //Reset
				//Send error to client
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 502 Bad Gateway\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error503), error503);
				send_to(response);
				shutdown_connection_internet();
				close_connection_internet();
				if(keepConnection == 0){
					shutdown_connection_client();
					close_connection_client();
					return nConnections - 1;
				}
				start = chrono::steady_clock::now();
				return nConnections;
			case -408 : case -3:
				memset(response,0,2000000);
				printf("Shutting down connection gracefully: %d\r\n",abs(getRes));
				//Send error to client
				sprintf(response,"HTTP/1.1 504 Gateway Timeout\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error408), error408);
				send_to(response);
				shutdown_connection_client();
				close_connection_client();
				shutdown_connection_internet();
				close_connection_internet();
				return nConnections - 1;
			case -2: //Connection error, close connection right away
				//Get failed because of connections reasons, close the session
				printf("Error web server!!!!!\r\n");
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 502 Bad Gateway\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error503), error503);
				send_to(response);
				close_connection_internet();
				if(keepConnection == 0){
					shutdown_connection_client();
					close_connection_client();
					return nConnections - 1;
				}
				start = chrono::steady_clock::now();
				return nConnections;
		};
		if(getRes < 2 || res[getRes-1] != '\n' || res[getRes-2] != '\r'){
				//Get failed because of logic reasons, retry next time
				printf("Request Corrupted\r\n");
				//Send 400 to client
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 502 Bad Gateway\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error503), error503);
				send_to(response);
				shutdown_connection_internet();
				close_connection_internet();
				if(keepConnection == 0){
					shutdown_connection_client();
					close_connection_client();
					return nConnections - 1;
				}
				start = chrono::steady_clock::now();
				return nConnections;
		};
		lenHeaderAndResponse+= getRes;
		if(getRes == 2) {
			res+= getRes;
			break;
		}
		//Process headers
		if(lenHeaderAndResponse - getRes > 0){
			memset(header, 0, 500);
			strcpy_s(header,res);
			char* getHeaderTag,* getHeaderContent;
			getHeaderTag = strtok(header,":");
			getHeaderContent = strtok(NULL,"\r");
			getHeaderTag = trimwhitespace(getHeaderTag);
			getHeaderContent = trimwhitespace(getHeaderContent);
			toLowerACStr(getHeaderTag);
			toLowerACStr(getHeaderContent);
			if(strcmp(getHeaderTag,"content-length")==0){
				contentLength = atoi(getHeaderContent);
			}
			if(strcmp(getHeaderTag,"proxy-connection")==0 || strcmp(getHeaderTag,"connection")==0){
				if(strcmp(getHeaderContent,"close")==0){
					resSerConn = 0;
				}else if(strcmp(getHeaderContent,"keep-alive")==0){
					resSerConn = 1;
				}
			}
			if(strcmp(getHeaderTag,"transfer-encoding")==0){
				useChunked = true;
			}
		}
		res+= getRes;
	}
	
	if(resSerConn == -1){
		resSerConn = keepConnection;
	}
	
	//Get Content from Content length
	int allowedContentLength = 2000000 - lenHeaderAndResponse;
	if(rqCall == 2) goto sendResponseBackToClient;
	if(contentLength != -1){ 	
		if(contentLength > allowedContentLength){
			memset(response,0,2000000);
			sprintf(response,"HTTP/1.1 500 Internal Server Error\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(resourceTooBig), resourceTooBig);
			send_to(response);
			shutdown_connection_internet();
			close_connection_internet();
			if(keepConnection == 0){
				shutdown_connection_client();
				close_connection_client();
				return nConnections - 1;
			}
			start = chrono::steady_clock::now();
			return nConnections;
		}
		
		int retCode = recv_length(res,contentLength,false);
	
		switch(retCode){
				case -408 : case -3:
					memset(response,0,2000000);
					printf("Shutting down connection gracefully: %d\r\n",abs(retCode));
					//Send error to client
					sprintf(response,"HTTP/1.1 504 Gateway Timeout\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error408), error408);
					send_to(response);
					shutdown_connection_internet();
					close_connection_internet();
					shutdown_connection_client();
					close_connection_client();
					return nConnections - 1;
				case -2: //Connection error, close connection right away
					//Get failed because of connections reasons, close the session
					printf("Error web server!!!!!\r\n");
					memset(response,0,2000000);
					sprintf(response,"HTTP/1.1 502 Bad Gateway\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error503), error503);
					send_to(response);
					close_connection_internet();
					if(keepConnection == 0){
						shutdown_connection_client();
						close_connection_client();
						return nConnections - 1;
					}
					start = chrono::steady_clock::now();
					return nConnections;
		};
		lenHeaderAndResponse+= contentLength;
	}
	//else if chunked encoding
	else if(useChunked)
	{
		int retCode = recv_chunks(res,allowedContentLength,false);

		switch(retCode){
			case -400: case -413:
				//Reset
				//Send error to client
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 502 Bad Gateway\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error503), error503);
				send_to(response);
				shutdown_connection_internet();
				close_connection_internet();
				if(keepConnection == 0){
					shutdown_connection_client();
					close_connection_client();
					return nConnections - 1;
				}
				start = chrono::steady_clock::now();
				return nConnections;
			case -408 : case -3:
				memset(response,0,2000000);
				printf("Shutting down connection gracefully: %d\r\n",abs(retCode));
				//Send error to client
				sprintf(response,"HTTP/1.1 504 Gateway Timeout\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error408), error408);
				send_to(response);
				shutdown_connection_internet();
				close_connection_internet();
				shutdown_connection_client();
				close_connection_client();
				return nConnections - 1;
			case -2: //Connection error, close connection right away
				//Get failed because of connections reasons, close the session
				printf("Error web server!!!!!\r\n");
				memset(response,0,2000000);
				sprintf(response,"HTTP/1.1 502 Bad Gateway\r\nServer: Proxy server in C\r\nContent-Type: text/html\r\nConnection: %s\r\nContent-Length: %d\r\n\r\n%s",connectionStr.c_str(), strlen(error503), error503);
				send_to(response);
				close_connection_internet();
				if(keepConnection == 0){
					shutdown_connection_client();
					close_connection_client();
					return nConnections - 1;
				}
				start = chrono::steady_clock::now();
				return nConnections;
		};
		lenHeaderAndResponse+= retCode;
	}
	
	sendResponseBackToClient:
	send_binary(response,lenHeaderAndResponse);

	if(resSerConn == 0){
		printf("\r\nConnection closing\r\n\r\n");
		shutdown_connection_client();
		close_connection_client();
		shutdown_connection_internet();
		close_connection_internet();
		return nConnections - 1;
	}
	start = chrono::steady_clock::now();

	return nConnections;
}

int ClientConnect::recv_length(char* buffer, int length, bool isClient){
	char* res = buffer;
	int contentLength = length;
	int recvContent = 0, retCode = -1;
	double delay = 0.0f;
	chrono::steady_clock::time_point current = chrono::steady_clock::now();
	WSAEVENT* srcEvent = &clientEvent; 
	SOCKET* srcSock = &client;
	if(!isClient) {
		srcEvent = &internetEvent;
		srcSock = &internet;
	}
	while(recvContent < contentLength){
		int recvStas = WSAWaitForMultipleEvents(1,srcEvent,FALSE,0,FALSE);
		if(recvStas == WSA_WAIT_FAILED){
			fprintf(stdout,"Wait failed: %d \r\n",WSAGetLastError());
			retCode = -2;
			break;
		}
		WSANETWORKEVENTS currentEvents;
		int errorrr = WSAEnumNetworkEvents(*srcSock,*srcEvent,&currentEvents);
		if((currentEvents.lNetworkEvents & FD_READ) == FD_READ)
		{
			delay = 0.0f;
			if(currentEvents.iErrorCode[FD_READ_BIT]==0){
				int temp = recv(*srcSock,res,contentLength - recvContent,0);
				if(temp == 0){ 
					retCode =-3; 
					break;
				}
				res+= temp;
				recvContent+= temp;
			}else
			{
				fprintf(stdout,"Read Content error %d\r\n",currentEvents.iErrorCode[FD_READ_BIT]);
				retCode = -2;
				break;
			}
			current = chrono::steady_clock::now();
		}
		else if ((currentEvents.lNetworkEvents & FD_CLOSE) == FD_CLOSE){
			if(currentEvents.iErrorCode[FD_CLOSE_BIT]==0)
			//Closed gracefully
				retCode = -3;
			else
			//Abrupt
				retCode = -2;
			break;
		}else
		{
			delay+= chrono::duration<double>(chrono::steady_clock::now() - current).count();
			current = chrono::steady_clock::now();
			if(delay > 5.0f) {
				fprintf(stdout,"Connection timeout 408: Slow events from source\r\n");
				retCode = -408;
				break;
			}
		}
	}
	return retCode;
}
	
int ClientConnect::recv_chunks(char* buffer,int bufLen, bool isClient){
	char* ptrBuf=buffer;
	int bytesReceived = 0;
	bool foundCarriageReturn = false;
	double delay = 0.0f;
	chrono::steady_clock::time_point current = chrono::steady_clock::now();
	WSAEVENT* srcEvent = &clientEvent; 
	SOCKET* srcSock = &client;
	if(!isClient) {
		srcEvent = &internetEvent;
		srcSock = &internet;
	}
	bool getNum = true;
	bool ending = false;
	string numOfChar; long finalNum = 0; short countChar = 0;
	do{
		int recvStas = WSAWaitForMultipleEvents(1,srcEvent,FALSE,0,FALSE);
		if(recvStas == WSA_WAIT_FAILED){
			fprintf(stdout,"Wait failed: %d \r\n",WSAGetLastError());
			return -2;
		}
		WSANETWORKEVENTS currentEvents;
		int errorrr = WSAEnumNetworkEvents(*srcSock,*srcEvent,&currentEvents);
		if((currentEvents.lNetworkEvents & FD_READ) == FD_READ){
			delay = 0.0f;
			if(currentEvents.iErrorCode[FD_READ_BIT]==0){
				if(bytesReceived >= bufLen) 
				{
					fprintf(stdout,"Line too long, skipping iteration, 413\r\n");
					return -413;
				}
				if(getNum){
					bytesReceived += recv(*srcSock,ptrBuf,1,0);
					if(!foundCarriageReturn){
						if(*ptrBuf == '\r') {
							foundCarriageReturn = true; 
							ptrBuf++;
							continue;
						}
						if(!(*ptrBuf >= '0' && *ptrBuf<='9') && !(*ptrBuf >= 'a' && *ptrBuf<='f') &&
							!(*ptrBuf >= 'A' && *ptrBuf<='F')) {
							fprintf(stdout,"Wrong format, skipping iteration, 400\r\n");
							return -400;
						}
					}else
					{
						if(*ptrBuf == '\n'){
							getNum = false;
							finalNum = strtol(numOfChar.c_str(),NULL,16);
							numOfChar.clear();
							if(finalNum==0) ending = true;
							ptrBuf++;
							foundCarriageReturn = false;
							continue;
						}
						fprintf(stdout,"Wrong format, skipping iteration, 400\r\n");
						return -400;
					}
					numOfChar.push_back(*ptrBuf);
				}else
				{
					if(finalNum == 0){
						if(bytesReceived + 2 - countChar > bufLen){
							fprintf(stdout,"Buflen too small, skipping iteration, 413\r\n");
							return -413;
						} 
						bytesReceived+= recv(*srcSock,ptrBuf,1,0);
						countChar++;
						ptrBuf++;
						if(countChar<2) continue;
						countChar = 0;
						getNum = true;
						if(!ending) continue;
						else break;
					}
					bytesReceived+= recv(*srcSock,ptrBuf,1,0);
					finalNum--;
				}
				ptrBuf++;
			}else
			{
				fprintf(stdout,"Read error %d\r\n",currentEvents.iErrorCode[FD_READ_BIT]);
				return -2;
			}
			current = chrono::steady_clock::now();
		}
		else if((currentEvents.lNetworkEvents & FD_CLOSE) == FD_CLOSE)
		{
			if(currentEvents.iErrorCode[FD_CLOSE_BIT]==0)
			//Closed gracefully
				return -3;
			else
			//Abrupt
				return -2;
		}
		else
		{
			delay+= chrono::duration<double>(chrono::steady_clock::now() - current).count();
			current = chrono::steady_clock::now();
			if(delay > 5.0f) {
				fprintf(stdout,"Connection timeout 408: Slow events from source\r\n");
				return -408;
			}
		}
	} while (true);
	return bytesReceived;
}

int ClientConnect::recv_line(char* buffer, int bufLen, bool isClient){
	char* ptrBuf=buffer;
	int bytesReceived = 0;
	bool foundCarriageReturn = false;
	double delay = 0.0f;
	chrono::steady_clock::time_point current = chrono::steady_clock::now();
	WSAEVENT* srcEvent = &clientEvent; 
	SOCKET* srcSock = &client;
	if(!isClient) {
		srcEvent = &internetEvent;
		srcSock = &internet;
	}
	do{
		int recvStas = WSAWaitForMultipleEvents(1,srcEvent,FALSE,0,FALSE);
		if(recvStas == WSA_WAIT_FAILED){
			fprintf(stdout,"Wait failed: %d \r\n",WSAGetLastError());
			return -2;
		}
		WSANETWORKEVENTS currentEvents;
		int errorrr = WSAEnumNetworkEvents(*srcSock,*srcEvent,&currentEvents);
		if((currentEvents.lNetworkEvents & FD_READ) == FD_READ){
			delay = 0.0f;
			if(currentEvents.iErrorCode[FD_READ_BIT]==0){
				if(bytesReceived >= bufLen -1) 
				{
					fprintf(stdout,"Line too long, skipping iteration, 413\r\n");
					return -413;
				}
				bytesReceived += recv(*srcSock,ptrBuf,1,0);
				if(!foundCarriageReturn){
					if(*ptrBuf == '\r') foundCarriageReturn = true;
					if(*ptrBuf == '\0' || *ptrBuf=='\n') {
						fprintf(stdout,"Wrong format, skipping iteration, 400\r\n");
						return -400;
					}
				}else
				{
					if(*ptrBuf == '\n') break;
					fprintf(stdout,"Wrong format, skipping iteration, 400\r\n");
					return -400;
				}
				ptrBuf++;
			}else
			{
				fprintf(stdout,"Read error %d\r\n",currentEvents.iErrorCode[FD_READ_BIT]);
				return -2;
			}
			current = chrono::steady_clock::now();
		}
		else if((currentEvents.lNetworkEvents & FD_CLOSE) == FD_CLOSE)
		{
			if(currentEvents.iErrorCode[FD_CLOSE_BIT]==0)
			//Closed gracefully
				return -3;
			else
			//Abrupt
				return -2;
		}
		else
		{
			delay+= chrono::duration<double>(chrono::steady_clock::now() - current).count();
			current = chrono::steady_clock::now();
			if(delay > 5.0f) {
				fprintf(stdout,"Connection timeout 408: Slow events from source\r\n");
				return -408;
			}
		}
	} while (true);
	*(++ptrBuf)='\0';
	return strlen(buffer);
}

int ClientConnect::send_binary(char* buffer, int bufLen, bool isClient){
	int sentBytes = 0;
	double delay = 0.0f;
	char* ptrBuf = buffer;
	chrono::steady_clock::time_point current = chrono::steady_clock::now();
	SOCKET* destSock = &client;
	if(!isClient) {
		destSock = &internet;
	}
	while(sentBytes<bufLen){
		int checkSent = send(*destSock, ptrBuf, bufLen - sentBytes, 0);
		if(checkSent == -1) {
			if(WSAGetLastError() != WSAEWOULDBLOCK) return 0;
			delay+= chrono::duration<double>(chrono::steady_clock::now() - current).count();
			if(delay > 5.0f) {
				fprintf(stdout,"Connection timeout 408: Slow events from source\r\n");
				return 0;
			}
		}else {sentBytes+= checkSent;ptrBuf+= checkSent; delay = 0.0f; }
		current = chrono::steady_clock::now();
	}
	return 1;
}

int ClientConnect::send_to(char* buffer, bool isClient){
	int len = strlen(buffer);
	int sentBytes = 0;
	char* ptrBuf = buffer;
	double delay = 0.0f;
	chrono::steady_clock::time_point current = chrono::steady_clock::now();
	SOCKET* destSock = &client;
	if(!isClient) {
		destSock = &internet;
	}
	while(sentBytes<len){
		int checkSent = send(*destSock, ptrBuf, len - sentBytes, 0);
		if(checkSent == -1) {
			if(WSAGetLastError() != WSAEWOULDBLOCK) return 0;
			delay+= chrono::duration<double>(chrono::steady_clock::now() - current).count();
			if(delay > 5.0f) {
				fprintf(stdout,"Connection timeout 408: Slow events from source\r\n");
				return 0;
			}
		}else {sentBytes+= checkSent;ptrBuf+= checkSent; delay = 0.0f; }
		current = chrono::steady_clock::now();
	}
	return 1;
}

int ClientConnect::emptyRecv(char* bufferHelp, int bufferHelpLen, bool isClient){
	SOCKET* destSock = &client;
	if(!isClient) {
		destSock = &internet;
	}
	int retCode = 1;
	while(true){
		retCode = recv(*destSock,bufferHelp,bufferHelpLen,0);
		if(retCode>0) continue;
		if(retCode==0) break;
		retCode = WSAGetLastError();
		if(retCode == WSAEFAULT) retCode = -1;
		if(retCode == WSAEWOULDBLOCK) retCode = 1;
		break;
	}
	if(retCode != 1 && retCode != -1) retCode = 0;
	memset(bufferHelp,0,bufferHelpLen);
	return retCode;
}

int ClientConnect::connection_to_internet(sockaddr_in hostTo){
	double delay = 0.0f;
	chrono::steady_clock::time_point current = chrono::steady_clock::now();
	do{
		int recvStas = WSAWaitForMultipleEvents(1,&internetEvent,FALSE,0,FALSE);
		if(recvStas == WSA_WAIT_FAILED){
			fprintf(stdout,"Wait failed: %d \r\n",WSAGetLastError());
			return -2;
		}
		WSANETWORKEVENTS currentEvents;
		int errorrr = WSAEnumNetworkEvents(internet,internetEvent,&currentEvents);
		int ret = connect(internet,(LPSOCKADDR)&hostTo,sizeof(hostTo));
		if((currentEvents.lNetworkEvents & FD_CONNECT) == FD_CONNECT){
			if(currentEvents.iErrorCode[FD_CONNECT_BIT] == 0){
				return 1;
			}
		}else
		{
			double dur = chrono::duration<double>(chrono::steady_clock::now() - current).count();
			delay+= dur;
			if(delay > 5.0f) {
				fprintf(stdout,"Connection timeout 408: Slow events from client\r\n");
				return 0;
			}
			current = chrono::steady_clock::now();
		}
	}while(true);
}