#include "start.h"
#include "ClientConnect.h"
#include "conio.h"

#define serverPort 8888

using namespace std;

int main() {
	WSADATA thisWSAData;
	if(WSAStartup(MAKEWORD(2,2),&thisWSAData)!=0)
	{
		perror("Failed init WSA");
		WSACleanup();
		return 1;
	}
	SOCKET server = INVALID_SOCKET; 
	server = socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);
	if(server<0){
		perror("Failed create server socket");
		WSACleanup();
		return 1;
	}

	sockaddr_in serverInfo;
	ZeroMemory(&serverInfo,sizeof(serverInfo));	
	serverInfo.sin_family = AF_INET;
	serverInfo.sin_port = htons(serverPort);
	if(inet_pton(AF_INET, "127.0.0.1", &serverInfo.sin_addr)<=0)
    {
        printf("\nInvalid address/ Address not supported \n");
        return -1;
    }
	int addrlen=sizeof(serverInfo);

	if(bind(server,(LPSOCKADDR)&serverInfo,addrlen)==SOCKET_ERROR){
		fprintf(stderr,"%d",WSAGetLastError(),"on call bind()");
		WSACleanup();
		return 1;
	}

	if(listen(server,20)<0){
		fprintf(stderr,"failed listen()");
		WSACleanup();
		return 1;
	}

	
	//List of Client Handlers
	ClientConnect client_socket[10];
	bool initTime[10] = {0};
	int nConnections = 0;
	WSAEVENT serverEvent;
	serverEvent = WSACreateEvent();
	WSAEventSelect(server,serverEvent,FD_ACCEPT);

	while(true){
		//Accept phase
		if(nConnections<10){ 
			int iEvtServer = WSAWaitForMultipleEvents(1,&serverEvent,FALSE,0,FALSE);
			if(iEvtServer != WSA_WAIT_TIMEOUT && iEvtServer != WSA_WAIT_FAILED){
				WSANETWORKEVENTS currentEvents;
				int errorrr = WSAEnumNetworkEvents(server,serverEvent,&currentEvents);
				if((currentEvents.lNetworkEvents & FD_ACCEPT) == FD_ACCEPT){
					if(currentEvents.iErrorCode[FD_ACCEPT_BIT]==0){
						SOCKET temp = accept(server,NULL,NULL);
						for(int i=0;i<10;i++){
							if(!client_socket[i].getConnectState()){
								client_socket[i].Init(temp);
								initTime[i] = true;
								break;
							}
						}
						nConnections++;
						printf("Adding client ...");
						printf("Current %d/%d\r\n",nConnections,10);
						continue;
					}else
					{
						printf("Accept failed %d\r\n",WSAGetLastError());
						break;
					}
				}
			}
		}
		for(int i=0;i<10;i++)
		{
			if(client_socket[i].getConnectState()){
				if(initTime[i]) {
					client_socket[i].startTimingConn();
					initTime[i] = false;
				}
				int newNumOfConnections = client_socket[i].run(nConnections);
				if(newNumOfConnections < nConnections){
					nConnections--;
					printf("Disconnecting client %d ...",i+1);
					printf("Current %d/%d\r\n",nConnections,10);
				}
			}
		}
	}
	system("pause");
	closesocket(server);
	WSACleanup();
	return 0;
}
