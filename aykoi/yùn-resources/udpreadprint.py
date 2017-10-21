import socket
import sys

# create socket
skt = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# bind the socket
server_address = ('', 10222)
skt.bind(server_address)
data, address = skt.recvfrom(1024)

#    print 'from: %s (%s Bytes)' % (address, len(data))
print data

if data:
    send = skt.sendto(data, address)
exit
