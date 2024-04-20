import serial
import time
import threading

from termcolor import colored

class Microcontroller:
    def __init__(self, port="COM8", baudrate=9600, timeout=0.1):
        self.port = port
        self.baudrate = baudrate
        self.timeout = timeout
        self.send_buffer = []
        self.receive_buffer = []
        self.microcontroller = serial.Serial(port=self.port, baudrate=self.baudrate, timeout=self.timeout)
        self.thread = threading.Thread(target=self._loop_start)

    def _send(self, data):
        self.microcontroller.write((data + "\r").encode())

    def _receive(self):
        data = "".join([chr(c) for c in self.microcontroller.readline() if chr(c) not in "\n"])
        if len(data) > 0:
            print(colored("Microcontroller: " + data, "light_blue"))
        self.receive_buffer.append(data)


    def _loop_start(self):
        while True:
            for i in range(len(self.send_buffer)):
                cmd = self.send_buffer.pop(0)
                self._send(cmd)
            self._receive()
            

    def send(self, data):
        self.send_buffer.append(data)
    
    def receive(self):
        t = self.receive_buffer.pop()
        return t

    def receive_all(self):
        t = self.receive_buffer
        self.receive_buffer = []
        return t

    def loop_start(self):
        self.thread.start()

    
