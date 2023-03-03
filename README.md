# Born2beRoot
4th project of 42 cursus
----------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


-----------------------
INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says password requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, ----------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


---------------------------------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


-----------------------
INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says pas----------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


-----------------------
INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says password requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION
- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for summary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary information of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), subtracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username
-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username
sword requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION
- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for summary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary information of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), subtracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username
-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username

INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says password requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION
- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for summary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary info----------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


-----------------------
INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says password requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION
- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for s----------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open----------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


-----------------------
INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says password requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION
- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for summary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary information of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), subtracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username
-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username
 again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


-----------------------
INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says password requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION----------
CREATING A VM IN VIRTUALBOX
- launch virtualbox and click on new
- name Born2beRoot and store it in /sgoinfre/goinfre/Perso/your-login
- choose Linux and debian
- set RAM size to 1024MB
- create a virual hard disk now then select VDI
- select dynamically allocated
- allocate 10 to 13 GB of memory (enough for both mandatory and bonus parts)


------------
INSTALLING DEBIAN 
- before starting the machine, select settings, then storage, and then the empty controller. 
Then, in attributes, click on the disk icon and choose a disk file.
Select the debian.iso file previously downloaded.
- start the machine
- select debian install (not graphical)
- choose language, area and keyboard settings
hostname must be your login followed by 42
- domain name can be empty
- choose s
How the student being evaluated set up their
----------
PARTITIONING THE DISK - bonus part 

-partition disks - select manual partition
-select the available disk (SCSI (0,0,0) (sda)) and then YES
-select the partition just created (which says free space) and then
create a new partition
- create 2 partitions, the first will be for an unencrypted /boot partition, the other for the encrypted logical volumes :

    pri/log xxGB FREE SPACE >> Create a new partition >> 500 MB >> Primary >> Beginning >> Mount point >> /boot >> Done.
    pri/log xxGB FREE SPACE >> Create a new partition >> max >> Logical >> Mount point >> Do not mount it >> Done.

---------------
ENCRYPTING THE DISK
-now the main partitionPepina2020 has been set up. select configure encrypted volumes
-select yes then creaPepina2020te encrypted volume.
-Choose sda5 ONLY to encrypt. We DO NOT want to encrypt the sda /boot partition. 
-Select done, finish and then yes
-The data erasing process can be cancelled
-set encryption passphrase

----------------
LOGICAL VOLUME MANAGER 
-configure logical volume manager and select YES.
-now we need to create the volume groups specified in the subject.
-Create Volume Group >> LVMGroup >> /dev/mapper/sda5_crypt
Create Logical Volumes:

How the student being evaluated set up theire Logical Volume >> LVMGroup >> swap >> 1G
    Create Logical Volume >> LVMGroup >> tmp >> 2G
    Create Logical VolPepina2020unt points for each logical volume:

    Under "LV home", #1 xxGB >> Use as >> Ext4 >> Mount point >> /home >> Done
    Under "LV root", #1 xxGB >> Use as >> Ext4 >> Mount point >> / >> Done
    Under "LV swap", #1 xxGB >> Use as >> swap area >> Done
    Under "LV srv", #1 3GB >> Use as >> Ext4 >> Mount point >> /srv >> Done
    Under "LV tmp", #1 3GB >> Use as >> Ext4 >> Mount point >> /tmp >> Done
    Under "LV var", #1 3GB >> Use as >> Ext4 >> Mount point >> /var >> Done
    Under "LV var-log", #1 4GB >> Use as >> Ext4 >> Mount point >> Enter manually >> /var/log >> Done

Scroll down & Finish partitioning and write changes to disk. Yes.

------------------
FINISH INSTALLATION
- no need to scan
- chose country and mirror
- leave proxy field blan
How the student being evaluated set up theirk
- no need to participate in study
- when asked to install additional programs, deselect everything and continue.
- yes, install GRUB on /dev/sda
-continue.



The system will reboot. Check partition settings with lsblk

NOTE once installation is finished, on VirtualBox the IDE secondary device becomes empty, as it is the 
installation disk - which we no longer need

----------------------
INSTALLING SUDO

- Switch to root via command su -
- apt install sudo
- verify whether install was successful via the command dpkg -l | grep sudo
- add user to sudo group: adduser username sudo (alternatively use usermod -aG sudo username)
- check that user was added to sudo group via getent group sudo
- rebootPepina2020-
CONFIGURING SUDO
- create folder for logging all commands via sudo mkdir /var/log/sudo
- create sudo.log file in the above directory
- type sudo visudo to see sudoers file, and edit it as follows:
	- limit authentication to 3 attempts: Defaults	passwd_tries=3
	- add a custom error message in the case of an incorrect password: 
	Default	badpass_message="custom error message"
	- log all sudo commands to a file called sudo.log:
	Defaults logfile="/var/log/sudo/sudo.log"
	- archive all sudo inputs and ouputs to the sudo.log file:
	Defaults log_input,log_output
	-to require ttyp
	Defaults requiretty
	-finally, to set sudo paths
	Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"

----------------------
CREATING A NEW USER AND ASSIGNING THEM TO A GROUP
-check all local users via cut -d: -f1 /etc/passwd
- user has to belong to the sudo and to the user42 groups. 
-create a new group: sudo addgroup user42
-add the user to the user42 group: sudo adduser username user42
-check existing users of group user42: getent group user42

-----------------------
INSTALLING AND CONFIGURING SSH 
Secure Shell Host
- type sudo apt install openssh-server
- check status via sudo systmctl status ssh
- install vim to see and edit config file: sudo apt install vim -Y 
- open ssh config file by typing sudo vim /etc/ssh/sshd_config
- change port to 4242 and remove the hash symbol, then save and close
- type sudo grep Port /etc/ssh/sshd_config to check port settings
- restart ssh service via sudo service ssh restart
- to disable ssh login as root, open again the sshd_config file and change
  the line which says #permitRootLogin to
  permitRootLogin	no
- check again the status via sudo service ssh status (or systemctl status ssh)


-----------------------
INSTALLING UFW
Uncomplicated firewall, blocks all connections by default so we need to 
specify which ports Pepina2020udo apt install ufw 
- enable it via sudo ufw enable
- check the status via sudo ufw status numbered
- type sudo ufw allow ssh
- enable port 4242 via sudo ufw allow 4242
- check existing rules via sudo ufw status numbered
- to delete rules that enable other ports, run sudo ufw delete {number of rule}


SETTING UP PASSWORD POLICY 
- install the password quality checking library via 
 sudo apt-get install libpam-pwquality
- open config file via sudo vim /etc/pam.d/common-password
- find line which says password requisite pam_pwquality.so retries=3 and add the
following rule: 
`minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root` 
-save and exit
- type sudo vim etc/login.defs 
- change pass_max_days to 30 and pass_min_days to 2, save and exit
-sudo reboot 

----------------------
CONNECTING TO SERVER 
- to find the ip address of the VM, type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION
- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for summary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary information of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), subtracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username
-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username

- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for summary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary information of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), subtracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username
-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username
ummary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary information of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), subtracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username
-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username
rmation of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), subtracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username
-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username
type hostname -I in the VM terminal
- Open an Iterm terminal or similar.
- SSH into the VM using port 4242 via
	ssh username@ip-address -p 4242


----------------------
CRONTAB CONFIGURATION
- install netstat tools via apt-get install -y net-tools
- cd into /usr/local/bin/
- type sudo touch monitoring.sh
- type sudo chmod 777 monitoring.sh to run the monitoring script for all users
- to set the script to be displayed every 10 min, type
sudo crontab -u root -e
and replace line 23 with 
23 */10 * * * * sh /path/to/script

------------------
MONITORING
Copy and paste not possible in the VM environment, so easiest to create the script through
a remote connection.
Monitoring.sh is located in the folder /usr/local/bin/
The purpose of virtual machines.
The script monitoring.sh (developed in bash) is used to collect information that will be 
broadcast on all terminals every 10 minutes. The dollar sign is used to create variables.
The script includes the following commands:portuguese keyboardease number of OS (-r), 
system name (-s), OS version (-v).
- command nproc --all displays the number of physical CPUs;
- command cat /proc/cpuinfo with grep looks for lines which include processor, counts and
returns the number of lines containing processor
- command free -m or --mebi displays the amount of free memory (RAM) in memibytes. Additional flag 
  --si Use power of 1000 (KB, MB, GB, etc.) instead of power of 1024 (KiB, MiB, GiB, etc.),
that is, it formats the output in megabytes. This is followed by command awk, which searches 
for word "Mem:" in the first column ($1 == "Mem:") and then prints to the result (tram) the 
contents of the second column of the line containing Mem: (i.e., the total RAM available)
- free -m --si and awk also used to find and return the amount of used RAM (third column)
- df shows information about disk memory; -h formats the output in readable format, and --total is
used to show an additional line for summary stats. awk is used to look for word total in first col, and 
select cols 2 (size), 3 (used) and 5 (Use %).portuguese keyboard
- top command shows the summary information of the system and the list of processes or threads 
which are currently managed by the Linux Kernel. Flag -b is used to run in batch mode, that is, without accepting
command-line input, -n1 to update display once and then exit. Then grep is used to look for row containing %Cpu, 
and finally awk -F is used to set the input field separator (in this case we need spaces because of the format
of the output of top), and to return the contents of the 8th col (idle time), sub-----------------------
DELETING A USER
-sudo userdel user_name
-sudo groupdel group_name
-getent group to check that group was deleted
tracted from 
100 to get the percentage usage.
- command who with flag -b is used to display info about system usage, specifically the last 
boot date and time. Awk used to look for the row containing system and print the contents of
the third and fourth cols
- if (and fi) are used to get info about whether lvm is active. If lsblk returns more than 0 
lines, return yes. Otherwise, return no.
- ss command used to get socket statistics. Sockets are pseudo-files that represent a network
connection; a socket identifies both the remote host and the port that it connects to so that 
data can be sent between the systems bidirectionally. Without flags, ss lists all the established
connections. Flag -H removes the headeportuguese keyboardr, and output is filtered by state established. Grep is
used to list only TCP connections, and wc to count the number of lines
- users command used to list active users; wc -w to count the n of words
- IP found with command hostname -I;
- MAC address found with ip link show
- command journalctl used to look at log of actions. all messages logged by different components 
in a systemd-enabled Linux system. This includes kernel and boot mportuguese keyboardessages, messages coming from 
syslog, or different services. _COMM=sudo to select only lines including sudo and grep to show only
sudo commands.
-wall is used to broadcast the message across all terminals.


---------------------
SIGNATURE TXT
-TURN OFF VIRTUAL MACHINE;
-open Iterm and type cd cd sgoinfre/students/<your_intra_username>/VirtualBox VMs
-type shasum Born2beRoot.vdi (name of the machine). This may take up to several minutes
-copy output number, create a signature.txt file and paste that number in the file. 
- submit the signature.txt file with the output number in it 
----------------
EVALUATION
---------------

---------------------
CREATING A NEW USER
-create a new group: sudo addgroup evaluation
-create a username: sudo adduser new_username-----------------------
DELETING A USER
-sudo userdel user_name
-sudo groupdel group_name
-getent group to check that group was deleted

-add the new username to a new group: sudo usermod -aG evaluation new_username 
OR: sudo adduser new_username evaluation
-check that the user was correctly assigned to the group: getent group evaluation
-to change password: passwd username. Insert old passwd and then new one
-check that password rules are working for the new user: chage -l new_username

-----------------------
DELETING A USER
-sudo userdel user_name
-sudo groupdel group_name
-getent group to check that group was deleted
