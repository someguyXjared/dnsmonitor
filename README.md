# dnsmonitor
Monitor private/personal domains.

This is a hard coded sript where you change the TLD of the domain you are monitoring by IP address. 
Usefull if you have FW ACLs you have routes that are on Dynamic IP ranges.

IE: google.com

Then change all the DNS# variables to all the sub domains. 

The script will then use dig and pull the information for that sub.domain.com, and only find that one line that contains that record.

Notification:
![image](https://user-images.githubusercontent.com/67975247/228658993-9d041bdc-0465-41da-aa0c-469c0c32858e.png)
