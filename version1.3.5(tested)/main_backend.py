# we need to uncomment some lines here
''' 
we need to change the logic of publishing from multi topic to single topic(TOPIC_STATE), 
so you usually will need a global dictionary (or ant data structure) to store the last state to send it to gsm as a collection of data
'''



import gsm_sim800l as g
import microcontroller as mc
import gps as gp
import face
import time
from datetime import datetime
import threading
import math

class MainBackend:
    def __init__(self) -> None:
        self.car_name = "BMW"
        self.car_model = "S20"
        self.body_id = "926426"
        self.engine_id = "234898"
        self.owner_password = "" # from gui


        self.users = "Abdulrahman" # from gui

        self.broker_name = "broker.hivemq.com"
        self.broker_port = 1883
        self.networkApn = "internet.vodafone.net"
        self.networkUsername = "internet"
        self.networkPassword = "internet"


        self.monitor_data = {"emergencyMode":"", "lockState":"", "motorState":"", "warning":"", "location":""}
        self.old_monitor_data = {"emergencyMode":"", "lockState":"", "motorState":"", "warning":"", "location":""}



        self.gsm = g.GsmSim800l("COM8", 
                                broker_domain_name=self.broker_name, 
                                broker_port=self.broker_port, 
                                network_apn=self.networkApn, 
                                network_username=self.networkUsername, 
                                network_password=self.networkPassword)
        

        self.controller = mc.Microcontroller(port="COM10", baudrate=9600)
        self.gps = gp.Gps(port="COM9")
        self.thread = threading.Thread(target=self._loop_start)




    def _loop_start(self):
        self.gsm.subscribe((self.get_basicTopic() + "TOPIC_REQUEST"))
        self.gsm.loop_start()
        self.controller.loop_start()
        self.controller.send("get car state")
        while True:
            time.sleep(1)

            # check received data from microcontroller and process it
            mc_data = self.controller.receive_all()
            # we need to make a higher priority for face_recogntion
            for d in mc_data:
                match d:
                    case "take a picture":
                        print("take a picture")
                        person = face.check_person()
                        if person == self.users:
                            self.controller._send("face ok")
                        else: 
                            self.controller._send("face not ok")

                    case "engine is on":
                        print("engine on")
                        self.monitor_data["motorState"] = "active"

                    case "engine is off":
                        print("engine off")
                        self.monitor_data["motorState"] = "inactive"

                    case "door is open":
                        print("door open")
                        self.monitor_data["lockState"] = "open"

                    case "door is closed":
                        print("door closed")
                        self.monitor_data["lockState"] = "close"

                    case "emergency mode is on":
                        print("emergency mode on")
                        self.monitor_data["emergencyMode"] = "emergency"

                    case "emergency mode is on and call":
                        print("emergency mode on")
                        self.monitor_data["emergencyMode"] = "emergency"
                        self.gsm.call("+201065840434")

                    case "emergency mode is off":
                        print("emergency mode off")
                        self.monitor_data["emergencyMode"] = "normal"

                    case "send a notification":
                        print("send notifiocation")
                        self.monitor_data["warning"] = "3 incorrect attempts to open the car @ " + (str(datetime.now())[:str(datetime.now()).index(".")])

                    case "the door was opened by mobile":
                        print("the door is opened by mobile")
                        self.monitor_data["warning"] = "The door is opened by mobile @ " + (str(datetime.now())[:str(datetime.now()).index(".")])

                    case "the door was opened by face":
                        print("the door is opened by face")
                        self.monitor_data["warning"] = "The door is opened by face @ " + (str(datetime.now())[:str(datetime.now()).index(".")])
                
  

            # check received data from gsm and process it
            m = self.gsm.get_message((self.get_basicTopic() + "TOPIC_REQUEST"))
            if m != None:
                print("In main >>> m = " + m)
                if "open_lock" in m:
                    self.controller.send("open the door")
                    print("open the door")
                elif "close_lock" in m:
                    self.controller.send("close the door") # Not supported yet
                    print("close the door")
                elif "normal_mode" in m:
                    self.controller.send("close emergency mode")
                    print("close emergency mode")

                self.gsm.publish((self.get_basicTopic() + "TOPIC_REQUEST"),"") # publish empty message to make the topic  is empty (important)


            self.update_location()
            self.publish_monitor_data()


    def update_location(self):
        if self.calc_distance(self.gps.get_coordinate(), self.monitor_data["location"]) > 100: # check if the location change 100 meters
            self.monitor_data["location"] = self.gps.get_coordinate()


    def calc_distance(self, coor1:str, coor2:str):
        if (len(coor1) < 5) or (len(coor2) < 5):
            return -1
        
        lat1 = float(coor1.split(",")[0])
        lon1 = float(coor1.split(",")[1])
        lat2 = float(coor2.split(",")[0])
        lon2 = float(coor2.split(",")[1])

        # Radius of the Earth in km
        R = 6371.0
        
        # Convert decimal degrees to radians
        phi1 = math.radians(lat1)
        phi2 = math.radians(lat2)
        delta_phi = math.radians(lat2 - lat1)
        delta_lambda = math.radians(lon2 - lon1)
        
        # Haversine calculation
        a = math.sin(delta_phi / 2)**2 + math.cos(phi1) * math.cos(phi2) * math.sin(delta_lambda / 2)**2
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
        
        # Distance in meters
        distance = R * c * 1000
        
        return distance


    def publish_monitor_data(self):
        if self.monitor_data != self.old_monitor_data:
            self.monitor_data["location"] = self.gps.get_coordinate() # get the last location
            self.gsm.publish((self.get_basicTopic() + "TOPIC_STATE"), ("#".join(self.monitor_data.values())))
            self.old_monitor_data = self.monitor_data.copy()


    def get_basicTopic(self):
        return ("_".join([self.car_name, self.car_model, self.body_id, self.engine_id, self.owner_password])+ "/")


    def loop_start(self):
        self.thread.start()


































































        












# # we need to uncomment some lines here
# ''' 
# we need to change the logic of publishing from multi topic to single topic(TOPIC_STATE), 
# so you usually will need a global dictionary (or ant data structure) to store the last state to send it to gsm as a collection of data
# '''



# import gsm_sim800l as g
# import microcontroller as mc
# import gps as gp
# import face
# import time
# from datetime import datetime
# import threading

# class MainBackend:
#     def __init__(self) -> None:
#         self.car_name = "BMW"
#         self.car_model = "S20"
#         self.body_id = "926426"
#         self.engine_id = "234898"
#         self.owner_password = "qove38" # from gui


#         self.users = "Abdulrahman" # from gui

#         self.broker_name = "broker.emqx.io"
#         self.broker_port = 1883
#         self.networkApn = "internet.vodafone.net"
#         self.networkUsername = "internet"
#         self.networkPassword = "internet"




#         self.gsm = g.GsmSim800l("COM8", 
#                                 broker_domain_name=self.broker_name, 
#                                 broker_port=self.broker_port, 
#                                 network_apn=self.networkApn, 
#                                 network_username=self.networkUsername, 
#                                 network_password=self.networkPassword)
#         self.gsm.subscribe((self.get_basicTopic() + "TOPIC_REQUEST"))
#         self.gsm.loop_start()

#         # self.controller = mc.Microcontroller(port="COM9", baudrate=9600)
#         # self.controller.loop_start()

#         # self.gps = gp.Gps(port="COM7")
#         self.thread = threading.Thread(target=self._loop_start)




#     def _loop_start(self):
#         while True:
#             time.sleep(0.1)

#             # check received data from microcontroller and process it
#             mc_data = self.controller.receive_all()
#             # we need to make a higher priority for face_recogntion
#             for d in mc_data:
#                 match d:
#                     case "take a picture":
#                         person = face.check_person()
#                         if person == self.users:
#                             self.controller._send("face ok")
#                         else: 
#                             self.controller._send("face not ok")
#                     case "engine is on":
#                         print("engine on")
#                         self.gsm.publish((self.get_basicTopic() + "MOTOR_STATE"), "on")
#                     case "engine is off":
#                         print("engine off")
#                         self.gsm.publish((self.get_basicTopic() + "MOTOR_STATE"), "off")
#                     case "door is open":
#                         print("door open")
#                         self.gsm.publish((self.get_basicTopic() + "LOCK_STATE"), "on")
#                     case "door is closed":
#                         print("door closed")
#                         self.gsm.publish((self.get_basicTopic() + "LOCK_STATE"), "off")
#                     case "emergency mode is on":
#                         print("emergency mode on")
#                         self.gsm.publish((self.get_basicTopic() + "EMERGENCY_STATE"), "emergency")
#                     case "emergency mode is on and call":
#                         print("emergency mode on")
#                         self.gsm.publish((self.get_basicTopic() + "EMERGENCY_STATE"), "emergency")
#                         self.gsm.call("+201065840434")
#                     case "emergency mode is off":
#                         print("emergency mode off")
#                         self.gsm.publish((self.get_basicTopic() + "EMERGENCY_STATE"), "normal")
#                     case "send a notification":
#                         print("send notifiocation")
#                         self.gsm.publish((self.get_basicTopic() + "WARNING_STATE"), "3 incorrect attempts to open the car @ " + (str(datetime.now())[:str(datetime.now()).index(".")]))
#                     case "the door is opened by mobile":
#                         print("the door is opened by mobile")
#                         self.gsm.publish((self.get_basicTopic() + "WARNING_STATE"), "The door is opened by mobile @ " + (str(datetime.now())[:str(datetime.now()).index(".")]))
#                     case "the door is opened by face":
#                         print("the door is opened by mobile")
#                         self.gsm.publish((self.get_basicTopic() + "WARNING_STATE"), "The door is opened by face @ " + (str(datetime.now())[:str(datetime.now()).index(".")]))
                    




#             # check received data from gsm and process it
#             m = self.gsm.get_message((self.get_basicTopic() + "TOPIC_REQUEST"))
#             if m != None:
#                 print("In main >>> m = " + m)
#                 if "refresh_request" in m:
#                     self.gsm.publish((self.get_basicTopic() + "LOCATION_STATE"), self.gps.get_location_url())
#                     self.controller.send("get car state")
#                 elif "open_lock" in m:
#                     self.controller.send("open the door")
#                 elif "close_lock" in m:
#                     self.controller.send("close the door") # Not supported yet
#                 elif "normal_mode" in m:
#                     self.controller.send("close emergency mode")

#                 self.gsm.publish((self.get_basicTopic() + "TOPIC_REQUEST"),"") # publish empty message to make the topic  is empty (important)






#     def get_basicTopic(self):
#         return ("_".join([self.car_name, self.car_model, self.body_id, self.engine_id, self.owner_password])+ "/")

#     def loop_start(self):
#         self.thread.start()





