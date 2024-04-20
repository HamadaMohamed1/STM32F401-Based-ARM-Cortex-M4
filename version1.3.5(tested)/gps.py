import serial
import time
import threading

from termcolor import colored

class Gps:
    def __init__(self, port="COM8"):
        self.port = port
        self.latitude = ""
        self.longitude = ""
        self.last_path = [] # you will use it to save the last path
        self.gps = serial.Serial(port=self.port, baudrate=9600, timeout=0.1)
        self.thread = threading.Thread(target=self._receive)
        self.thread.start()

    def _receive(self):
        while True:
            data = "".join([chr(c) for c in self.gps.readline() if chr(c) not in "\r\n"])
            match data.split(",")[0]:
                case "$GPRMC":
                    pass
                case "$GPVTG":
                    pass
                case "$GPGGA":
                    pass
                case "$GPGSA":
                    pass
                case "$GPGSV":
                    pass
                case "$GPGLL":
                    # add condition (don't do process in data if not exist) ... use this condition to save the last location if the connection og gps is lossed
                    # $GPGLL,2959.70211,N,03113.97305,E,184109.00,A,A*66
                    data = data.split(",")
                    if not (data[1] == data[2] == data[3] == data[4] == ""):
                        self.latitude = self._DMM2DD(data[1], data[2])
                        self.longitude = self._DMM2DD(data[3], data[4])
                        # print("time: " + data[5])


    def _DMM2DD(self, value:str, direction:str):
        if value != "" and direction != "":
            degrees = int(value[:value.index(".")-2])
            minutes = eval(value[value.index(".")-2:])
            value = degrees + minutes/60
            if direction in "SW":
                value = value * -1
            return str(value)
        
    def get_coordinate(self):
        return self.latitude + "," + self.longitude
    
    def get_location_url(self):
        # https://www.google.com/maps/search/?api=1&query=47.5951518%2C-122.3316393
        url = "https://www.google.com/maps/search/?api=1" + "&query=" + self.latitude + "%2C" + self.longitude
        print(colored(url, "light_magenta"))
        return url

    def get_path_url(self):
        pass

