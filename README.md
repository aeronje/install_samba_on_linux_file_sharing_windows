# install_samba_on_linux_file_sharing_windows
Install Samba on Linux for file sharing with Windows  

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
