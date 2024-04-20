# After make test and some configuration:-
    # we need to add the logic of configuration screen
    # we need to uncommect some lines here
    # i prefer to delete the password part in the configuration screen

import tkinter as tk
import qrcode
import main_backend as m
from termcolor import colored
import winsound


def play_tone():
    # Frequency is set to 500Hz and duration to 100 milliseconds
    winsound.Beep(500, 100)

def play_error_tone():
    # Frequency is set to 300Hz and duration to 300 milliseconds
    winsound.Beep(300, 300)




def _show_lets_go_scn():
    play_tone()
    _hide_all_scn()  # Hide all screens
    lets_go_lbl.pack()
    lets_go_btn.pack()
    lets_go_scn.pack()  # Show next screen
    
def _show_register_scn():
    play_tone()
    _hide_all_scn()
    register_back_btn.pack()
    register_password_lbl.pack()
    register_password_entry.pack()
    register_register_btn.pack()
    register_scn.pack()  

def _save_password():
    backend.owner_password = register_password_entry.get()
    backend.loop_start() # uncomment this line /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    _show_main_scn()

def _show_main_scn():
    play_tone()
    _hide_all_scn()
    main_connect_btn.pack()
    main_configure_btn.pack()
    main_scn.pack()

def _show_login_scn(next_scn):
    play_tone()
    global after_login
    after_login = next_scn
    _hide_all_scn()
    login_back_btn.pack()
    login_password_lbl.pack()
    login_password_entry.pack()
    login_login_btn.pack()
    login_scn.pack()

def _choose_connect_configure_scn():
    if login_password_entry.get() == backend.owner_password:
        login_password_entry.delete(0, tk.END)
        if after_login == "conn":
            _show_connect_scn()
        elif after_login == "conf":
            _show_configure_scn()
    else:
        play_error_tone()
    
def _create_qr_code():
    qr_data = "#".join([backend.broker_name, str(backend.broker_port), backend.get_basicTopic()])
    # print(qr_data)
    qr = qrcode.make(qr_data)
    qr.save("my_qr_code.png")

def _show_connect_scn():
    play_tone()
    backend.gsm.publish((backend.get_basicTopic() + "TOPIC_CONNECT"), "connect") # uncomment this line//////////////////////////////////////////////////////////////////////
    _create_qr_code()
    new_img = tk.PhotoImage(file="my_qr_code.png")
    connect_qrCode_img.configure(image=new_img)
    _hide_all_scn()
    connect_back_btn.pack()
    connect_qrCode_img.pack()
    connect_barcode_lbl.pack()
    connect_scn.pack()

def _show_configure_scn():
    play_tone()
    _hide_all_scn()
    configure_back_btn.pack()
    configure_name_lbl.pack()
    configure_name_entry.pack()
    configure_mobile_lbl.pack()
    configure_mobile_entry.pack()
    configure_passwoprd_lbl.pack()
    configure_password_entry.pack()
    configure_autoLock_checkButton.pack()
    # configure_autoLockTime_lbl.pack()
    # configure_autoLockTime_entry.pack()
    configure_faceUnlock_checkButton.pack()
    # configure_saveFace_btn.pack()
    configure_saveConfigurations_btn.pack()
    configure_scn.pack()

def _show_save_face_scn():
    play_tone()
    _hide_all_scn()
    saveFace_back_btn.pack()
    saveFace_instructions_lbl.pack()
    save_face_scn.pack()

def _hide_all_scn():
    for scn in screens:
        scn.pack_forget()

def _auto_lock_changed():
    play_tone()
    # Get the checkbox value
    checkbox_value = auto_lock_var.get()
    if checkbox_value == True:
        configure_autoLockTime_lbl.pack()
        configure_autoLockTime_entry.pack()
    else:
        configure_autoLockTime_lbl.pack_forget()
        configure_autoLockTime_entry.pack_forget()

def _face_unlock_changed():
    play_tone()
    # Get the checkbox value
    checkbox_value = face_unlock_var.get()
    if checkbox_value == True:
        configure_saveFace_btn.pack()
    else:
        configure_saveFace_btn.pack_forget()










after_login = ""
try:
    backend = m.MainBackend()
except Exception as e:
    print(colored("Can't create object of the mainBackend class", "light_red"))
    print(colored(e, "red"))
    exit()


root = tk.Tk()
root.title("VSS")
# root.attributes('-fullscreen', True) # uncomment this line /////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Create screens (frames) for each view
lets_go_scn = tk.Frame(root)
register_scn = tk.Frame(root)
main_scn = tk.Frame(root)
login_scn = tk.Frame(root)
connect_scn = tk.Frame(root)
configure_scn = tk.Frame(root)
save_face_scn = tk.Frame(root)
screens = [lets_go_scn, register_scn, main_scn, login_scn, connect_scn, configure_scn, save_face_scn]


# let's go screen
lets_go_lbl = tk.Label(lets_go_scn, text="Welcome to VSS")
lets_go_btn = tk.Button(lets_go_scn, text="Let's Go", command=_show_register_scn)

# register screen
register_back_btn = tk.Button(register_scn, text="<--", command=_show_lets_go_scn)
register_password_lbl = tk.Label(register_scn, text="Enter Your Password")
register_password_entry = tk.Entry(register_scn)
register_register_btn = tk.Button(register_scn, text="Register", command=_save_password)


# main screen
main_connect_btn = tk.Button(main_scn, text="Connect", command=lambda: _show_login_scn("conn"))
main_configure_btn = tk.Button(main_scn, text="Configure", command=lambda: _show_login_scn("conf"))

# login screen
login_back_btn = tk.Button(login_scn, text="<--", command=_show_main_scn)
login_password_lbl = tk.Label(login_scn, text="Enter Your Password")
login_password_entry = tk.Entry(login_scn)
login_login_btn = tk.Button(login_scn, text="Login", command=_choose_connect_configure_scn)

# connect screen
qr = qrcode.make("") # to create an image for first one running the program
qr.save("my_qr_code.png")

img = tk.PhotoImage(file="my_qr_code.png")
connect_back_btn = tk.Button(connect_scn, text="<--", command=_show_main_scn)
connect_qrCode_img = tk.Label(connect_scn, image=img)
connect_barcode_lbl = tk.Label(connect_scn, text="Don't share this barcode")

# configure screen
auto_lock_var = tk.BooleanVar()
face_unlock_var = tk.BooleanVar()
configure_back_btn = tk.Button(configure_scn, text="<--", command=_show_main_scn)
configure_name_lbl = tk.Label(configure_scn, text="Name")
configure_name_entry = tk.Entry(configure_scn)
configure_mobile_lbl = tk.Label(configure_scn, text="Mobile Number")
configure_mobile_entry = tk.Entry(configure_scn)
configure_passwoprd_lbl = tk.Label(configure_scn, text="Password")
configure_password_entry = tk.Entry(configure_scn)
configure_autoLock_checkButton = tk.Checkbutton(configure_scn, text="Auto lock", command=_auto_lock_changed, variable=auto_lock_var)
configure_autoLockTime_lbl = tk.Label(configure_scn, text="Auto_lock Time")
configure_autoLockTime_entry = tk.Entry(configure_scn)
configure_faceUnlock_checkButton = tk.Checkbutton(configure_scn, text="Face Unlock", command=_face_unlock_changed, variable=face_unlock_var)
configure_saveFace_btn = tk.Button(configure_scn, text="Save Face", command=_show_save_face_scn)
configure_saveConfigurations_btn = tk.Button(configure_scn, text="Save Configurations", command=_show_main_scn)

# save face screen
saveFace_back_btn = tk.Button(save_face_scn, text="<--", command=_show_configure_scn)
saveFace_instructions_lbl = tk.Label(save_face_scn, 
                                            text="Go out your car and look at camera\n"+
                                            "green light mean: Saved successfully\n"+
                                            "red light mean: Not saved successfully\n"+
                                            "white light mean: Not saved yet")





_show_lets_go_scn()

root.mainloop()