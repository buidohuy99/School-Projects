#pragma once
#include <chrono>
#include <string>
#include "start.h"

class ClientConnect
{
	SOCKET client;
	WSAEVENT clientEvent;
	SOCKET internet;
	WSAEVENT internetEvent;
	
	double timeOut;
	std::string currentHost;
	std::chrono::steady_clock::time_point start;
	char *response;

	int recv_line(char* buffer, int bufLen, bool isClient=true);
	int recv_length(char* buffer, int length, bool isClient=true);
	int recv_chunks(char* buffer, int bufLen, bool isClient= true);
	int send_to(char* buffer, bool isClient=true);
	int send_binary(char* buffer, int bufLen, bool isClient=true);
	//Ham empty phan recv o socket
	int emptyRecv(char* bufferHelp, int bufferHelpLen, bool isClient=true);
	bool checkForBlock(std::string fileName, std::string host);

	int connection_to_internet(sockaddr_in hostTo);
	
	void close_connection_client();
	void close_connection_internet();
	void shutdown_connection_client();
	void shutdown_connection_internet();
public:
	ClientConnect(void);
	~ClientConnect(void);

	void Init(SOCKET client);
	void startTimingConn();
	int run(int nConnections);
	bool getConnectState();
};

