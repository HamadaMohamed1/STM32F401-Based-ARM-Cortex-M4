import serial
import time
from random import choices, randint
from string import ascii_uppercase, digits
import threading
from termcolor import colored
from datetime import datetime


class GsmSim800l:
    def __init__(self,
                 uart_port, broker_domain_name, broker_port, network_apn, network_username, network_password, 
                 uart_baudrate=9600, uart_timeout=0.4):
        self.uart_port = uart_port
        self.uart_baudrate = uart_baudrate
        self.uart_timeout = uart_timeout
        self.network_apn = network_apn
        self.network_username = network_username
        self.network_password = network_password
        self.broker_domain_name = broker_domain_name
        self.broker_port = broker_port
        self.send_buffer = []
        self.receive_buffer = []
        self.phone_number = ""
        # try:
        #     self._gsm = serial.Serial(self.uart_port, baudrate=self.uart_baudrate, timeout=self.uart_timeout)
        # except:
        #     print(colored("can't start serial", "light_red"))
        self._gsm = serial.Serial(self.uart_port, baudrate=self.uart_baudrate, timeout=self.uart_timeout)
        self.thread = threading.Thread(target=self._loop_start)

    def _str_to_hex(self, s:str):
        return s.encode().hex()

    def _int_to_hex(self, num:int):
        return hex(num)[2:]

    def _fill_with_zeros(self, hexa:str, n:int):
        result = ("0" * (n - len(hexa))) + hexa
        return result
    
    def _calc_remaning_length(self, length:int):  # you need to make implemenatation for three and four bytes
        if length <= 127:
            return self._fill_with_zeros(self._int_to_hex(length), 2)
        elif length <= 16383:
            length = list(bin(length).replace("0b", ""))
            length.reverse()
            length.insert(7,"1")
            length.reverse()
            length = self._fill_with_zeros((hex(int(("".join(length)), 2)).replace("0x", "")), 4)
            return length[2:4] + length[0:2]

    def _generate_connect_packet(self, protocol="MQTT", level=4, flag=2, keep_alive=60, client_id="".join(choices(ascii_uppercase + digits, k=5))):
        client_id = "my_test"
        start_connect_packet = self._fill_with_zeros("10", 2)
        protocol_length      = self._fill_with_zeros(self._int_to_hex(len(protocol)), 4)
        protocol_name        = self._fill_with_zeros(self._str_to_hex(protocol), (len(protocol) * 2))
        level                = self._fill_with_zeros(self._int_to_hex(level), 2) # similar name may make error
        flag                 = self._fill_with_zeros(self._int_to_hex(flag), 2)
        keep_alive           = self._fill_with_zeros(self._int_to_hex(keep_alive), 4)
        client_id_length     = self._fill_with_zeros(self._int_to_hex(len(client_id)), 4)
        client_id            = self._fill_with_zeros(self._str_to_hex(client_id), (len(client_id) * 2))
        remaning_length      = self._calc_remaning_length(len(protocol_length + protocol_name + level + flag + keep_alive + client_id_length + client_id) // 2)
        send_packet          = self._fill_with_zeros("1A", 2)
        return start_connect_packet + remaning_length + protocol_length + protocol_name + level + flag + keep_alive + client_id_length + client_id + send_packet

    def _generate_pub_packet(self, topic, message):
        start_pub_packet = self._fill_with_zeros("33", 2)
        topic_length     = self._fill_with_zeros(self._int_to_hex(len(topic)), 4)
        topic_name       = self._fill_with_zeros(self._str_to_hex(topic), (len(topic) * 2))
        message          = self._fill_with_zeros(self._str_to_hex(message), (len(message) * 2))
        remaning_length  = self._calc_remaning_length(len(topic_length + topic_name + message) // 2)
        send_packet      = self._fill_with_zeros("1A", 2)
        return start_pub_packet + remaning_length + topic_length + topic_name + message + send_packet

    def _generate_sub_packet(self, topic, packet_id=randint(1, 65534), QoS=0, NoLocal=0, Retain_As_Published=0, Retain_Handling=0):
        start_sub_packet = self._fill_with_zeros("82", 2)
        packet_id        = self._fill_with_zeros(self._int_to_hex(packet_id), 4)
        proprites        = ""
        topic_length     = self._fill_with_zeros(self._int_to_hex(len(topic)), 4)
        topic_name       = self._fill_with_zeros(self._str_to_hex(topic), (len(topic) * 2))
        QoS              = self._fill_with_zeros("00", 2)
        remaning_length  = self._calc_remaning_length(len(packet_id + topic_length + topic_name + QoS) // 2)
        send_packet      = self._fill_with_zeros("1A", 2)
        return start_sub_packet + remaning_length + packet_id + topic_length + topic_name + QoS + send_packet

    def _send_command(self, command:str, expected_response:str, response_timeout:float=0.4, type:str="str"):
        self.uart_timeout = response_timeout
        self._check_for_message()
        if type == "str":
            self._gsm.write((command + "\r").encode())
            return self._get_response(command, expected_response)
        elif type == "hex":
            self._gsm.write(bytes.fromhex(command))
            return self._get_response(command, expected_response, type="hex")
        self.uart_timeout = 0.4
        
        

    def _get_response(self,expected_command:str, expected_response:str, type:str="str"):
        # every expected response must contain number of (\n) equal to number of response lines
        no_respones_lines = expected_response.count("\n")
        
        if no_respones_lines == 0:
            print(colored("There is an Error: no_response_lines = 0 >>> the error command in the next line >>> software change the no_responses_lines to 1","light_red"))
        
        real_command = "".join([chr(c) for c in self._gsm.read_until(b'\r\n') if chr(c) not in "\r\n"])
        real_response = ""
        for i in range(no_respones_lines * 2 - 1):
            real_response += "".join([chr(c) for c in self._gsm.read_until(b'\r\n') if chr(c) not in "\r\n"])
        print(colored((real_command + " ### " + real_response), "light_grey"))

        if type == "hex":
            return real_response
        elif type == "str":
            return self._check_response(real_command, expected_command, real_response, expected_response.replace("\n", ""))

    def _check_response(self,real_command:str, expected_command:str, real_response:str, expected_response:str):
        if real_command != expected_command:
            self._check_for_message(real_command)
        if real_response != expected_response:
            self._check_for_message(real_response)
            return False
        return True

    # def _check_gsm_network(self):
    #     print("Start Checking Module .....")
    #     if self._send_command("AT", "OK\n"): # this line sometimes work uncorrectly
    #         if self._send_command("AT+CREG?", "+CREG: 0,1\nOK\n"):
    #             if self._send_command("AT+CGATT?", "+CGATT: 1\nOK\n"):
    #                 if self._send_command("AT+CSTT?", "+CSTT: \"" + self.network_apn + "\",\"" + self.network_username + "\",\"" + self.network_password + "\"\nOK\n"):
    #                     return True
    #     return False  # you should switch module off then switch module on

    def init(self): # make this function can restart the module if the init is can completed correctly
        # Try this way to initialize gsm
        # // Set the module to text mode
        # Serial.println("AT+CMGF=1");
        # delay(1000);
        # // Connect to GPRS network
        # Serial.println("AT+SAPBR=3,1,\"CONTYPE\",\"GPRS\"");
        # delay(1000);
        # Serial.println("AT+SAPBR=3,1,\"APN\",\"your_apn\"");
        # delay(1000);
        # Serial.println("AT+SAPBR=1,1");
        # delay(1000);
        send_at = self._send_command("AT", "OK\n")
        while not send_at:
            print(colored("AT Failed", "light_red"))
            send_at = self._send_command("AT", "OK\n")

        print(colored("Starting Initialization .....", "light_green"))

        send_at = self._send_command("AT+CGATT?", "+CGATT: 1\nOK\n")
        while not send_at:
            print(colored("AT+CGATT=1 Failed", "light_red"))
            send_at = self._send_command("AT+CGATT=1", "OK\n")

        send_at = self._send_command("AT+CSTT=" + self.network_apn + "," + self.network_username + "," + self.network_password, "OK\n")
        send_at = self._send_command("AT+CSTT?", "+CSTT: \"" + self.network_apn + "\",\"" + self.network_username + "\",\"" + self.network_password + "\"\nOK\n")
        while not send_at:
            print(colored("AT+CSTT=internet.vodafone.net,internet,internet Failed", "light_red"))
            send_at = self._send_command("AT+CSTT=" + self.network_apn + "," + self.network_username + "," + self.network_password, "OK\n")

        self._send_command("AT+CIICR", "OK\n", response_timeout=2) # This command is very important
        self._send_command("AT+CIFSR", "OK\n", response_timeout=2) # This command is very important

        # return self._check_gsm_network()

    def _connect(self):
        print(colored("Start connecting .....", "light_green"))
        # self._send_command("AT", "OK\n")
        self._send_command("AT+CIPSTART=TCP," + self.broker_domain_name + "," + str(self.broker_port), "OK\nCONNECT \nOK\n")
        self._send_command("AT+CIPSEND", "> \n")
        self._send_command(self._generate_connect_packet(), "SEND OK\n   \n", type="hex")


    def _check_connection(self):
        if self._send_command("AT+CIPSTATUS", "OK\nSTATE: CONNECT OK\n"):
            return True
        else:
            return False

    def _publish(self, topic:str, message:str):
        print(colored("Start Publishing .....", "light_green"))
        # self._send_command("AT", "OK\n")
        self._send_command("AT+CIPSEND", "> \n")
        self._send_command(self._generate_pub_packet(topic, "  " + message), "SEND OK\n   \n", type="hex")
        return True

    def _subscribe(self, topic:str):
        print(colored("Start Subscribing .....", "light_green"))
        # self._send_command("AT", "OK\n")
        self._send_command("AT+CIPSEND", "> \n")
        response = self._send_command(self._generate_sub_packet(topic), "SEND OK\n   \n", type="hex")
        # print(response)
        for d in self.receive_buffer:
            if d["T"] in response:
                d["M"].append(response.split(topic)[-1]) # make this -1
                break
        else:
            print(colored("Error: can't find the Topic in list or the returned message is empty", "light_yellow"))
            return False
        return True

    def _call(self):
        if self.phone_number != "" and len(self.send_buffer) == 0:
            num = self.phone_number
            self.phone_number = ""
            print(colored("Start Calling .....", "light_green"))
            # self._send_command("AT", "OK\n")
            self._send_command("ATD+ " + num + ";", "OK\n")
            time.sleep(3)
            return True
    
    def call(self, codePhone:str):
        self.phone_number = codePhone

    def send_sms(self, message:str, phone:str, country_code:str="+20"):
        print(colored("Start Sending SMS message .....", "light_green"))
        # self._send_command("AT", "OK\n")
        self._send_command("AT+CMGF=1", "OK\n")
        send_status = self._send_command("AT+CMGS=\"" + country_code + phone + "\"", "> \n")
        while not send_status:
            send_status = self._send_command("AT+CMGS=\"" + country_code + phone + "\"", "> \n")
        self._send_command(bytes.fromhex(self._str_to_hex(message) + "1A").decode("ASCII"), "+CMGS: xx\nOK\n")
        return True
    
    def publish(self, topic:str, message:str):
        if message == "":
            if {"T":topic, "M":message} not in self.send_buffer:
                self.send_buffer.append({"T":topic, "M":message})
        else:
            self.send_buffer.append({"T":topic, "M":message})
    def subscribe(self, topic:str):
        for d in self.receive_buffer:
            if d["T"] == topic:
                break
        else:
            self.receive_buffer.append({"T":topic, "M":[]})

    def get_message(self, topic:str):
        for d in self.receive_buffer:
            if d["T"] == topic:
                if len(d["M"]) > 0:
                    m = d["M"].pop(0)
                    return m
        return None

    def _loop_start(self):
        # time.sleep(10) # Time for first run
        # self.init()
        while True:
            print(colored("gsm Loop starts @ " + str(datetime.now()), "light_green"))
            print(colored(self.send_buffer, "light_green"))
            print(colored(self.receive_buffer, "light_green"))
            self._check_for_message()
            if self._check_connection():
                for i in range(len(self.send_buffer)):
                    d = self.send_buffer.pop(0)
                    self._publish(d["T"], d["M"])
            else:
                self._connect()
                for d in self.receive_buffer:
                    self._subscribe(d["T"])
            self._call()
            print(colored("gsm Loop ended  @ " + str(datetime.now()), "light_green"))
            
            time.sleep(0.1)


    def loop_start(self):
        self.thread.start()
    
    def _check_for_message(self, old_response:str=""):
        response = old_response + ("".join([chr(c) for c in self._gsm.read_all() if chr(c) not in "\r\n"]))
        if len(response) > 0:
            time.sleep(0.05)
            while self._gsm.in_waiting > 0:
                response += "".join([chr(c) for c in self._gsm.read_all() if chr(c) not in "\r\n"])
                time.sleep(0.05)
            print(colored(">>>>>>>>>>>>>>>>>>>>>>>>>>>>" + response, "light_yellow"))
            for d in self.receive_buffer:
                topic = d["T"]
                if topic in response:
                    res = response.split(topic)[1:]
                    d["M"] += res
                    print(colored(d, "light_yellow"))

            if ("NO CARRIER" in response) or ("BUSY" in response):
                self._send_command("ATH", "OK\n")




    
    # Mean that this problem is still undiscussed
    ## Mean that this problem is not fixed yet
    ### Mean that this problem is fixed

    # to be sure if publish messages is arrived correctly, subscribe to same topic and check if last message is exist, then unsubscribe from the topic
    # you need to improve the _check_for_message
    # after subscribe, if the recived message is get_location: publish dot(.) message to topic 
    # make init function can restart the module if the init function is can't complete correctly
    # if you receive a message when publish or subscribe...every thing don't complete correctly
    # you must enhance the connect and publish and subscribe functions ... if the operation failed it redo it or add it again to buffers 
    # The function loop_forever should start a new thread to do operations without stopping the main code (search about: loop_srtart function in paho mqtt python library)
    # you can make "unsubscribe" function (if needed)
    ## connect to our cluster:-
    ''' Cluster need TCP-SSL connection
        Public broker need TCP connection
        Our module (sim 800l) can't establish TCP-SSL connection 
        There are three solutions:-
            1- updating the firmware of our module (AT+CGMR --> 1418B04SIM800L24)
            2- using other module such as (sim800H)
            3- using the public broker  '''
    
    # review all the code and make every thing is realiable
    # search about QoS and edit it in the three packets
    # when module go to sleep mode and how wake up?
    # if the moule is disattached from GPRs after some time, improve the init function and make it happen with every action(publish & subscribe)
    # make "loop_forever" function that publish a collection of messages and subscribe for some topics and return these messages into list(or python dictionary)
    # check the parameters of "generate connect packet" function
    # edit the parameters of connect packet
    # change the client_id
    ### what is the difference between MQTT v 3.1.1 and MQTT v 5.0, what should i use?
    ''' The choice of which version to use depends on your use case and requirements. 
        MQTT v 5.0 offers more features and flexibility for IoT development, 
        especially for cloud-based deployments and complex systems13. 
        However, MQTT v 3.1.1 is still widely used and supported by many brokers and clients, 
        and it may be sufficient for simple and reliable IoT communication14.   '''
    ### why we use MQTT?
    ''' *MQTT can keep a persistent session between the car and the cloud, 
            which means that the connection is not lost when the car moves through areas with poor network coverage.
            The persistent session feature is still available even if the connection is closed and reopened, 
            as long as the client uses the same clientId and sets the cleanSession flag to 0 when reconnecting. 
            This way, the broker can identify the client and resume the previous session state, 
            including the subscriptions and the messages.
        *MQTT can support a request-response pattern, 
            which allows the mobile application to request the location of the car and receive a response from the car using a correlation data property.
        *MQTT can reduce the network bandwidth and power consumption of the car, 
            as it uses a minimal header and a binary payload, 
            and can also use topic aliases to replace long topic names with short identifiers.
        *MQTT can enable real-time messaging and broadcasting, which means that the car can send its status and other data to the cloud and the mobile application at a high frequency and low latency. '''
    # edit the parameters of publish packet
    # edit the parameters of subscribe packet
    # complete "_calc_remaning_length" function (Third and fourth bytes)
    # Topic name should be combination of (car name, car model , ID of engine, Id of body, password of user) separated by "_"
    # you can use (AT+CSQ) to check signal strength and bit error rate then you can make (keep alive time) dynamically, you can use foil to simulate weak connection
    # try using the other antenna
    ## Try to find the location of gsm without gps, use these commands:-
    ''' AT+SAPBR=4,1
        AT+SAPBR=3,1,Contype,GPRS
        AT+SAPBR=3,1,APN,internet.vodafone.net
        AT+SAPBR=3,1,USER,internet
        AT+SAPBR=3,1,PWD,internet
        AT+SAPBR=1,1
        AT+CIPGSMLOC=1,1
        but the response have incorrect location: +CIPGSMLOC: 0,0.000000,0.000000,2024/01/28,18:27:24'''
    # To get the time and date use this command only (AT+CUSD=1,"*100##",15)

