/*
 *		Simple commandline program that sends formatted hotkeys over udp 
 *					credits go to : silver moon.
 *		author : (namigyj)	01/05/2017
 */
#include <stdio.h>
#include <stdlib.h>
#include <WinSock2.h>
#include <string.h>
#include "Keys.h"



#pragma comment(lib, "ws2_32.lib")	//winsock library

#define VERSION "1.01"

#define SERVER "192.168.1.26"	// default ip address of Yùn
#define SPORT 10222				// default port
#define BUFLEN 50				// Max length of buffer

typedef enum { false, true } bool;
typedef enum { P_IP, P_PORT, P_TIME, P_STRING } param_t;
typedef enum { D_NUL, D_K, D_DELAY, D_STR, D_INTER} data_t;


char * server="";
int port;

bool verbose,quiet;


int snd(int s, struct sockaddr_in si_other, char data[]);
int rcv(int s, struct sockaddr_in si_other, char data[]);
int check(const char * args, param_t pt);
int getfree(char* keys[3]);
void makefree(char* keys[3]);
void interactive(int s, struct sockaddr_in si_other);
int ktoc(char *key);
void usage(int i);
void klist();


int main(int argc, char *argv[]) {
	struct sockaddr_in si_other;
	int s, time, nkeys;
	data_t datat = D_NUL;
	WSADATA wsa;
	char *str;
	char buf[BUFLEN];
	char sdata[BUFLEN];
//	char rdata[BUFLEN];	// need to redo the recv
	char* keys[3] = { "","","" };
	
	server = SERVER;	// assign defaults
	port = SPORT;		// assign defaults 

	verbose = false;
	quiet = false;

	//test();
	//printf("number of params : %d", argc);

	int j;
	j = 1;
	if (argc < 2) {
		// no CL arguments -> interactive mode
		datat = D_INTER;
	}
	else {
		while (j < argc) {
			if (argv[j][0] == '-') {	// if an option
				if (!strcmp(argv[j], "-a")) {	// if destination ip
					if (check(argv[++j], P_IP))
						server = argv[j];
					else {
						fprintf(stderr, "Error : %s is an invalid IP address.\n", argv[j]);
						usage(1);
					}
				}
				// destination port
				else if (!strcmp(argv[j], "-p")) {
					if (check(argv[++j], P_PORT))
						port = (int)strtol(argv[j], NULL, 0);
					else {
						fprintf(stderr, "Error: %s is an invalid port number.\n", argv[j]);
						usage(1);
					}
				}
				// delay
				else if (!strcmp(argv[j], "-d") || !strcmp(argv[j], "--delay")) {
					if (check(argv[++j], P_TIME)) {
						if (!datat) {	// combination of incompatible params
							time = (int)strtol(argv[j], NULL, 0);
							datat = D_DELAY;
						}
						else {
							fprintf(stderr, "Error: cannot combine -d, -s, and/or individual keys.\n");
							usage(1);
						}
					}
					else {
						fprintf(stderr, "Error: %s is an invalid delay.\n", argv[j]);
						usage(1);
					}
				}
				else if (!strcmp(argv[j], "-s") || !strcmp(argv[j], "--string")) {
					if (check(argv[++j], P_STRING)) {
						//printf("string format : %c<text>%c", argv[j][0], argv[j][strlen(argv[j]) - 1]);
						if (!datat) {	// combination of incompatible params
							str = argv[j];
							datat = D_STR;
						}
						else {
							fprintf(stderr, "Error: cannot combine -d, -s, and/or individual keys.\n");
							usage(1);
						}
					}
					else {
						fprintf(stderr, "Error: string exceeds authorized size.\n");
						usage(1);
					}

				}
				// help
				else if (!strcmp(argv[j], "-h") || !strcmp(argv[j], "--help")) {
					usage(2);
				}
				// list
				else if (!strcmp(argv[j], "-l") || !strcmp(argv[j], "--list")) {
					klist();
					exit(EXIT_SUCCESS);
				}
				// quiet
				else if (!strcmp(argv[j], "-q") || !strcmp(argv[j], "--quiet")) {
					verbose = false;
					quiet = true;
				}
				// verbose
				else if (!strcmp(argv[j], "-v") || !strcmp(argv[j], "--verbose")) {
					verbose = true;
					quiet = false;
				}
				// version
				else if (!strcmp(argv[j], "--version")) {
					usage(0);
				}
			}
			else {
				if (!datat || datat == D_K){  // dataT != D_NUL
					if (strlen(argv[j]) < 3) {
						int gf = getfree(keys);
						keys[gf] = argv[j];
						datat = D_K;
					}
					else {
						fprintf(stderr, "Error : invalid key %s", argv[j]);
						klist();
						exit(EXIT_FAILURE);
					}
				}
				else {
					fprintf(stderr, "Error: cannot combine -d, -s, and/or individual keys.\n");
					usage(1);
				}
			}
			j++;
		}
	}

	// init WinSock
	if(verbose)
		printf("Initialising Winsock... ");
	if (WSAStartup(MAKEWORD(2, 2), &wsa) != 0) {
		if (!quiet)
			fprintf(stderr, "Failed. Error Code : %d", WSAGetLastError());
		exit(EXIT_FAILURE);
	}
	if (verbose)
		

	// Socket
	if (verbose)
		printf("Creating Socket... ");
	if ((s = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == SOCKET_ERROR) {
		if (!quiet)
			fprintf(stderr, "socket() failed with error code : %d", WSAGetLastError());
		exit(EXIT_FAILURE);
	}

	// check if we need the default server.

	
	// setup address structure
	memset((char *) &si_other, 0, sizeof(si_other));
	si_other.sin_family				= AF_INET;
	si_other.sin_addr.S_un.S_addr	= inet_addr(server);
	si_other.sin_port				= htons(port);	// converts the int in network-byte ordering (big-endian)
	
	if (verbose)
		printf(" %s:%d\n", inet_ntoa(si_other.sin_addr), ntohs(si_other.sin_port));


	if (datat == D_STR) {
		sprintf(sdata, "0:%s.", str);
		// READY TO SEND.
		snd(s, si_other, sdata);
	}
	else if (datat == D_DELAY) {
		sprintf(sdata, "4:%d.", time);

		// READY TO SEND.
		snd(s, si_other, sdata);
	}
	else if (datat == D_K) {
		
		// check if we have at least one keypress to send
		nkeys = getfree(keys);
		if (getfree(keys) > 0) {
			sprintf(sdata, "%d:", nkeys);
			for (int i = 0; i < nkeys; i++) {
				if (i == 0)
					sprintf(buf, "%d", ktoc(keys[0]));
				else
					sprintf(buf, ",%d", ktoc(keys[i]));
				strcat(sdata, buf);
			}
			strcat(sdata, ".");
			// READY TO SEND.
			snd(s, si_other, sdata);
		}
		else {
			fprintf(stderr, "Error : invalid parameters.\n");
			usage(1);
		}
	}
	else {
		interactive(s, si_other);
	}
	
	makefree(keys);
	if (verbose)
		printf("Closing Socket...");
	
	closesocket(s);
	WSACleanup();
	printf("OK!\n");

	return 0;
}

int snd(int s, struct sockaddr_in si_other, char data[]) {
	int sso = sizeof(si_other);
	char buf[BUFLEN];
	strcpy(buf, data);
	//puts(buf);
	if (verbose)
		printf("sent [%s] from %s:%d\n", data, inet_ntoa(si_other.sin_addr), ntohs(si_other.sin_port));
	// Send message
	if (sendto(s, data, strlen(data), 0, (struct sockaddr *) &si_other, sso) == SOCKET_ERROR) {
		if (!quiet)
			fprintf(stderr, "\n(!)Failed to send with error code: %d", WSAGetLastError());
		return -1;
	}

	return rcv(s, si_other, data);
}

int rcv(int s, struct sockaddr_in si_other, char data[]) {
	fd_set fds;
	int n;
	struct timeval tv;
	int sso = sizeof(si_other);
	char buf[BUFLEN];
	char ok[6] = "";


	// Set up the file descriptor set.
	FD_ZERO(&fds);
	FD_SET(s, &fds);

	// set the interval to 1 sec
	tv.tv_sec = 3;
	tv.tv_usec = 0;

	// wait until timeout or data received.
	n = select(s, &fds, NULL, NULL, &tv);
	if (n == 0) {
		fprintf(stderr, "Timeout...\n");
		return 1;
	}
	else if (n == -1) {
		fprintf(stderr, "\n(!)ERROR\n");
		return -2;
	}

	//clear the buffer by filling null, it might have previously received data
	memset(buf, '\0', BUFLEN);

	if (recvfrom(s, buf, BUFLEN, 0, (struct sockaddr *) &si_other, &sso) == SOCKET_ERROR) {
		fprintf(stderr, "recvfrom() failed with error code : %d", WSAGetLastError());
		return -1;
	}

	// print the data.
	if (!quiet) {
		if (!strcmp(data, buf))
			strcpy(ok, "OK");
		printf("%s %s\n", buf, ok);
	}
	else if (verbose) {
		printf("received [%s] from %s:%d\n", buf, inet_ntoa(si_other.sin_addr), ntohs(si_other.sin_port));
	}
	return 0;
}

int check(const char * args, param_t pt) {
	unsigned int i;
	strlen(args);
	// if the next argument is another param we don't bother more and return 0 (false)
	if (args[0] == '-')
		return 0;

	if (pt == P_IP) {
		int dots;
		dots = 0;
		if (strlen(args) > 6) {	// a valid IP addres has at least 7chars
			for (i = 0; i <= strlen(args); i++) {
				// we count the number of dots
				if (args[i] == '.')
					dots++;
			}
			// we consider the string valid if it has 4 dots and at least 8 chars
			if (dots == 3) {
				return 1;
			}
		}
		return 0;	// else we return 0 (false)
	}

	else if (pt == P_PORT) {
		int p;
		// apparently atoi() is shit & useless. Didn't find a strtoi, so I am here casting a string to a long to an int.
		// When I have more time I'll try to fix this.
		p = (int)strtol(args, NULL, 0);
		if (p < 65535 && p > 0)	// I guess there's another way to verify if it fits in 16bits...
			return 1;
		return 0;
	}

	else if (pt == P_TIME) {
		int t;
		// apparently atoi() is shit & useless. Didn't find a strtoi, so I am here casting a string to a long to an int.
		// When I have more time I'll try to fix this.
		t = (int)strtol(args, NULL, 0);
		// prevent delays longer than 30 seconds.
		if (t > 0 && t < 30001)
			return 1;
		return 0;
	}
	else if (pt == P_STRING) {
		// needs to be smaller than buffer len (verifying with 2 brackets)
		if (strlen(args) < 52)
			return 1;
		return 0;
	}
	else
		return 0;
}

// return the index of the first "" string
int getfree(char *keys[3]) {
	int i, r;
	r = 3;
	for (i = 2; i >= 0; i--) {

		if (!strcmp(keys[i], ""))
			r = i;
	}
	return r;
}

// replace all the strings of the array by ""
void makefree(char *keys[3]) {
	int i;
	for (i = 0; i < 3; i++)
		keys[i] = "";
}


void interactive(int s, struct sockaddr_in si_other) {
	char input[BUFLEN + 2],
		sdata[BUFLEN],
		buf[BUFLEN];
	char* keys[3];
	unsigned int i, c;


	//	v printf("Aykoi v%s  ( https://namigyj.github.io/aykoi.html )\n", VERSION);
	printf("Interactive mode.\nUsage:> Key1 [Key2 [Key3]]\n\tEvery key should be separated by a space\n");
	printf("'list' to display all the usable keys. 'exit' for leaving\n");
	
	while (1) {
		printf("> ");
		gets(input);

		if (!strcmp(input, "exit"))
			return;
		else if (!strcmp(input, "list"))
			klist();

		// string mode
		else if (input[0] == '"' && input[strlen(input) - 1] == '"') {
			sscanf(input, "\"%[^\"]\"", buf);
			sprintf(sdata, "0:%s.", buf);
			// READY TO SEND.
			snd(s, si_other, sdata);
		}
		else if (strlen(input) < 9) {
			c = 0;
			for (i = 0; i < strlen(input); i++) {
				if (input[i] == ' ' && i != 0 && i != strlen(input)-1)
					c++;
			}
			if (c == 0) {
				sscanf(input, "%s", &keys[0]);
				sprintf(sdata,"1:%d.", ktoc(&keys[0]));
				// READY TO SEND.
				puts(sdata);
				snd(s, si_other, sdata);
			}
			else if (c == 1) {
				sscanf(input, "%s %s", &keys[0],&keys[1]);
				sprintf(sdata, "2:%d,%d.", ktoc(&keys[0]), ktoc(&keys[1]));
				// READY TO SEND.
				snd(s, si_other, sdata);
			}
			else if (c == 2) {
				sscanf(input, "%s %s %s", &keys[0],&keys[1],&keys[2]);
				sprintf(sdata, "3:%d,%d,%d.", ktoc(&keys[0]), ktoc(&keys[1]), ktoc(&keys[2]));
				// READY TO SEND.
				snd(s, si_other, sdata);
			}
			else {
				fprintf(stderr, "Error. Incorrect input.\n");
			}
		}
		else
			fprintf(stderr, "Error. Incorrect input.\n");
		makefree(keys);
	}
}

int ktoc(char *key) {

	//printf("%c\n", key[0]);
	if (key[0] >= 'a' && key[0] <= 'z')
		return key[0];

	switch (key[0]) {
	case 'C':
		if (strlen(key) < 2)
			return CTRL_LEFT;
		else if (!strcmp(key, "Cr"))
			return CTRL_RIGHT;
		else {
			fprintf(stderr,"Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'S' :
		if (strlen(key) < 2)
			return SHIFT_LEFT;
		else if (!strcmp(key, "Sr"))
			return SHIFT_RIGHT;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'A':
		if (strlen(key) < 2)
			return ALT_LEFT;
		else if (!strcmp(key, "Ag"))
			return ALT_RIGHT;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'G':
		if (strlen(key) < 2)
			return GUI_LEFT;
		else if (!strcmp(key, "Gr"))
			return GUI_RIGHT;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'P' :
		if (strcmp(key,"Pu"))
			return PAGE_UP;
		else if (!strcmp(key, "Pd"))
			return PAGE_UP;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'W' :
		if (!strcmp(key, "Wu"))
			return UP;
		else if (!strcmp(key, "Wd"))
			return DOWN;
		else if (!strcmp(key, "Wl"))
			return LEFT;
		else if (!strcmp(key, "Wd"))
			return RIGHT;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'B' :
		if (strlen(key) < 2)
			return BACKSPACE;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'T' :
		if (strlen(key) < 2)
			return TAB;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'R' :
		if (strlen(key) < 2)
			return RETURN;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'E' :
		if (strlen(key) < 2)
			return ESC;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'I' :
		if (strlen(key) < 2)
			return INSERT;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'D' :
		if (strlen(key) < 2)
			return DEL;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'H' :
		if (strlen(key) < 2)
			return HOME; 
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'N' :
		if (strlen(key) < 2)
			return END;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'L' :
		if (strlen(key) < 2)
			return CAPS_LOCK;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}
	case 'F' :
		if (!strcmp(key, "F1"))
			return F1;
		else if (!strcmp(key, "F2"))
			return F2;
		else if (!strcmp(key, "F3"))
			return F3;
		else if (!strcmp(key, "F4"))
			return F4;
		else if (!strcmp(key, "F5"))
			return F5;
		else if (!strcmp(key, "F6"))
			return F6;
		else if (!strcmp(key, "F7"))
			return F7;
		else if (!strcmp(key, "F8"))
			return F8;
		else if (!strcmp(key, "F9"))
			return F9;
		else if (!strcmp(key, "F10"))
			return F10;
		else if (!strcmp(key, "F11"))
			return F11;
		else if (!strcmp(key, "F12"))
			return F12;
		else {
			fprintf(stderr, "Error : '%s' is an invalid key", key);
			exit(EXIT_FAILURE);
		}		
	default:		
		fprintf(stderr, "Error : '%s' is an invalid key", key);
		exit(EXIT_FAILURE);
				
	}
}


void usage(int i) {
	printf("Aykoi v%s  ( https://namigyj.github.io/aykoi.html )\n", VERSION);
	if (i > 0) {
		printf("Usage: aykoi [options] [-a ip addr] [-p port] k1 [k2 [k3]]\n\t\tk1, k2, k3: hotkey aliases. refer to -l for a complete list.\n");
		printf("       aykoi [options] [-a ip addr] [-p port] -s \"<string>\"\n");
		printf("       aykoi [options] [-a ip addr] [-p port] -d <time-in-seconds>\n");
		printf("       aykoi [options] [-a ip addr] [-p port]\n");

		//printf("       %s [options] [-i ip addr] [-p port] -i file\n", &arg0);
	}
	if (i > 1) {
		printf("\n\t-s, --string \"<string>\"    Prints an entire string instead of individual strings (Max size 50)\n");
		printf("\t-d, --delay <time>         Wait before resending a packe.t (Max 30k)\n");

		printf("\n\t-a <ip addr>               Destination ip address (default 192.168.1.26)\n");
		printf("\t-p <port>                  Destination host port address (default 10222)\n");
		printf("\t-h, --help                 Displays this help screen and exit\n");
		printf("\t-l, --list                 Displays the list of all the usable keys and their alias\n");
		printf("\t-q, --quiet                Quiet\n");
		printf("\t-v, --verbose              Verbose\n");
		printf("\t    --version              Display Aykoi's version information and exit\n");
	}
	else
		printf("\n 'aykoi -h' for more help.\n");
	exit(0);
}

void klist() {
	printf("\nlist of key aliases :\n");
	printf("C  - left Ctrl       Cr - right Ctrl      F1  - F1\n");	//1
	printf("S  - left Shift      Sr - right Shift     F2  - F2\n");
	printf("G  - GUI (super)     Gr - right GUI       F3  - F3\n");   //
	printf("A  - Alt             Ag - Alt Gr          F4  - F4\n");
	printf("Wu - Arro[W] up      Wd - Arro[W] down    F5  - F5\n");   //
	printf("Wl - Arro[W] left    Wr - Arro[W] right   F6  - F6\n");
	printf("Pu - Page up         Pd - Page down       F7  - F7\n");   //
	printf("B  - Backspace       R  - RETURN          F8  - F8\n");
	printf("E  - Escape          T  - Tab             F9  - F9\n");
	printf("I  - Insert          D  - Delete          F10 - F10\n");
	printf("H  - Home            E  - End             F11 - F11\n");
	printf("L  - Caps Lock                            F12 - F12\n");
	return;
}



