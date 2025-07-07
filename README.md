# install_samba_on_linux_file_sharing_windows

Install Samba on Linux for file sharing with Windows (Linux will host the shared folder)**

NOTE: You will see several mentions of 'donnadell' in this guide. That is just the name of my machine — replace it with your own username or directory name.

1. sudo apt update

2. sudo apt install samba -y

3. cd /home/donnadell

/*
This is just a sample directory, please specify the directory you wish to share with windows
*/

4. sudo chown nobody:nogroup /home/donnadell

5. sudo chmod 0775 /home/donnadell

6. sudo nano /etc/samba/smb.conf

/*
look for the parameter that has $print or print$ then next to that is to insert the below sample definition and parameters
*/

[donnadell]
   path = /home/donnadell
   browseable = yes
   read only = no
   writable = yes
   guest ok = yes
   force user = nobody

7. sudo systemctl restart smbd

8. sudo ufw allow 'Samba'

/*
you should probably get some output here
--Rules updated
--Rules updated (v6)
--as long as the output is not an error then you are good
*/

9. testparm

--if there are no errors then you are good

10. sudo reboot


Access the linux shared directory from your windows machine

/*
\\hostname_or_your_ip_address\donnadell
--the hostname can be the ip address of your linux machine in your local network or could be the hostname itself if machine is connected to a dedicated public domain hosting service
--if none of these works then move to next steps
*/

11. sudo chown -R nobody:nogroup /home/donnadell

12. sudo chmod -R 0775 /home/donnadell

13. sudo chown -R donnadell:donnadell /home/donnadell

14. sudo nano /etc/samba/smb.conf

--look for the parameter that has $print or print$ then next to that is to insert the below sample definition and parameters

/*
[donnadell]
   path = /home/donnadell
   browseable = yes
   read only = no
   writable = yes
   guest ok = yes
   force user = donnadell
   create mask = 0664
   directory mask = 0775
   delete readonly = yes
*/

15. sudo systemctl restart smbd

--run testparm
--if no errors then start back and forth file sharing together with file changes from windows machine


Install Samba on Linux for file sharing with Windows (Windows will host the shared folder)**

1. Prepare the Windows machine
   Boot up your Windows machine, log in, and create a shared folder. Once this step is complete, proceed to your Linux machine and continue with the instructions below.

2. sudo apt update && sudo apt install smbclient -y

/*
Since the situation here is the reverse of the typical Samba setup (Windows is the host, and Linux is the client), smbclient is sufficient as Linux will be accessing the shared folder from the Windows host.
*/

3. smbclient //192.168.137.97/donnadell -U donna

/*
'smbclient' is a constant in the command.
'192.168.137.97' is the hostname or IP address of your Windows machine. This can be a local IP in your LAN or a publicly hosted IP—update it as needed.
'donnadell' refers to the name of the shared folder, which should match what you created in step 1.
'-U' is a constant flag, and 'donna' is the **Windows** username that has access to the shared folder. Make sure this is not your Linux username.
Upon executing this command, you will be prompted to enter the password for the Windows username.
*/


4. Run 'ls' command to confirm access

/*
Example output from a tested machine:

donna@DONNAHP C:\Users\donna>client_loop: send disconnect: Broken pipe
root@donnadell:/home/donnadell/Desktop# smbclient //192.168.137.97/donnadell -U donna
Password for [WORKGROUP\donna]:
Try "help" to get a list of possible commands.
smb: \> ls
  .                                   D        0  Sun Jul  6 21:07:22 2025
  ..                                  D        0  Sun Jul  6 21:07:22 2025
  api_testing_101.txt                 A      325  Fri May 30 00:55:10 2025

38925116 blocks of size 4096. 31347239 blocks available

This output confirms that access and connectivity are working. If your output is similar, you may proceed to step 5. Otherwise, revisit your shared folder settings in Windows to ensure sharing permissions were set correctly in step 1.
*/


5. sudo mkdir /home/donnadell/Desktop/donnadell

/*
This creates a directory where the Windows shared folder will be mounted. You can change the path to wherever you would like the mount point to reside.
*/

6. sudo mount -t cifs //192.168.137.97/donnadell /home/donnadell/Desktop/donnahp -o 'username=donna,password=password,vers=3.0'

/*
This command mounts the Windows shared folder to the directory you created in step 5.
Use the same username and password from step 1.
'vers=3.0' was used in a system running Windows 10 Home. You may need to try '2.0' or '2.1' depending on compatibility with your version of Windows.
*/







