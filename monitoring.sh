#!/bin/bash
arc=$(uname -a)
pcpu=$(nproc --all)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
tot_ram=$(free -m --si | grep Mem | awk '{print $2}')
used_ram=$(free -m --si | grep Mem | awk '{print $3}')
perc_ram=$(free -m --si |grep Mem | awk '{printf("%.2f%%"), $3/$2*100}')
tot_disk=$(df -h --total | grep total | sed 's/G//g' | awk '{print$2}')
used_disk=$(df -h --total | grep total | sed 's/G//g' | awk '{print$3}')
perc_disk=$(df -h --total | grep total | sed 's/G//g' | awk '{printf("%d%%"), $3/$2*100}')
cpu_load=$(top -bn1 | grep '%Cpu' | awk -F' ' '{print 100 - $8}')
last_boot=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvmu=$(if (lsblk | grep "lvm" | wc -l) > 0; then echo yes; else echo no; fi)
tcp=$(ss -H | grep tcp | wc -l)
users=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
cmds=$(journalctl _COMM=sudo | grep COMMAND | wc -l) 
wall "#Architecture: $arc
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $used_ram/${tot_ram}MB ($perc_ram)
	#Disk Usage: $used_disk/${tot_disk}Gb ($perc_disk)
	#CPU load: $cpu_load%
	#Last boot: $last_boot
	#LVM use: $lvmu
	#Connections TCP: $tcp ESTABLISHED
	#User log: $users
	#Network: IP $ip ($mac)
	#Sudo: $cmds cmd" 