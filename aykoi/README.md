Arduino class assignment

# aykoi
The client of an [A]rduino [Y]ùn [K]eyboard [O]ver [I]nternet. A simple CLI client sending your keys presses (or string) over UDP, understandable for the Arduino.

## download
If you only want the client : [x64 Client](https://github.com/NamiGYJ/aykoi/raw/master/client/x64/aykoi.exe), [x86 client](https://github.com/NamiGYJ/aykoi/raw/master/client/x86/aykoi.exe)

## Installation
Make sure your yun is connected to a wifi, or that your computer is connected to the yun's wifi.
Copy udpreadprint.py in /usr/bin/ of the linino.
You can either use scp or ncat. for example :
```sh
$ scp user@myyun:/usr/bin/udpreadprint.py udpreadprint.py
```
or winscp on windows.

Compile & upload the sketch.ino on the arduino.

If you weren't able to connect to a wifi AP for some reason, and you don't want to completely reset the yùn, you can do the following : upload the sketch first, configure a mobile hotspot with as SSID "lourd", and password "ubuntu69". You should then be able to see the ip address of the connected devices to your AP and SCP the .py on it aswell as send the key presses to it.
## Usage
Default ip is 192.168.1.26, default port is 10222. The port should be the same as the one in 'udpreadprint.py'
You can send 3 types of data to the Arduino : up to 3 key presses, an entire string, or a delay (putting the arduino in wait() for the amount of the delay).
```
$ aykoi.exe C A D
$ aykoi.exe -a 192.168.1.14 -p 8839 -s "Hello, World!"
```

Use the ``-l or --list`` parameter for a list of the non-alphabetical keys and how to pass them to the client.

If no key, string or delay is passed on, then you enter in interactive mode. In this mode, you can use the ``list`` command (which will display the same as --list parameter) or ``exit`` to leave. Simply type out the keys like parameters (with a space separating each key) for example :
```
> C A D
```
