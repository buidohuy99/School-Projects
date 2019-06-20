//
//  main.cpp
//  Crack
//
//  Created by Gia Huy on 5/11/19.
//  Copyright © 2019 GIA HUY. All rights reserved.
//

#include <stdio.h>
#include <string>
#include <iostream>
#include <stdint.h>
#include <string.h>
#include <bitset>
using namespace std;

bool getFirstBit(unsigned int a) {
	std::cout<<"Most Left Byte: "<<((a>>31)&0x1)<<endl;
	return (a>>31)&0x1;
}

unsigned int transformBit(unsigned int a) {
	string bin = bitset<32>(a).to_string();
	for (int i = 0; i < bin.length(); i++) {
		if (bin[i] == '1') bin[i] = '0';
		else bin[i] = '1';
	}
	unsigned int result = bitset<32>(bin).to_ulong();
	return result;
}

int main(int argc,char* argv[]) {
    int i;
	unsigned int key = 574;
	string input;
	int len = 0;

	//Nhập username
	while (input.length() <= 4) {

		cout << "Nhap username: ";
		getline(cin, input);

	}
	if(input.length() > 6) len = 6;
	else len = input.length();

	for(i=0;i<len;i++){
		unsigned char checkChar = input[i];
		unsigned int thuong = checkChar / 5 ;
		key = key * thuong;
		key = key + checkChar;	
	}

	//Kiem tra xem can dau tru hay khong
	bool needDauTruDangTruoc = false;
	if( getFirstBit(key) == 1) {
		key--;
		key = transformBit(key);
		needDauTruDangTruoc = true;
	} 

	//Gan bien tam a = key
	unsigned int a = key;

	//Mang chia la ket qua cuoi cung
	string mangchia;
	do {
	// div by 10 (he 10)
	unsigned int bientam = a;
	a = bientam / 10;
	unsigned char b = bientam % 10 + '0';
	mangchia +=b;
	} while( a>0);

	if(needDauTruDangTruoc) mangchia+= '-';

	reverse(mangchia.begin(),mangchia.end());

	std::cout<<mangchia<<std::endl;
	system("pause");
}
