#!/bin/bash
# Script to add a user to Linux system create public_html folder 
if [ $(id -u) -eq 0 ]; then
	read -p "Enter username : " username
	read -s -p "Enter password : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
                mkdir -p /home/$username/public_html
                echo "public_html created"
                chmod ugo+x /home/$username
                echo "chmod username" 
                chmod ugo+x /home/$username/public_html 
                echo "chmod public_html"
                chown -R $username:$username /home/$username/public_html
                echo "chown public_html"
                echo "User and folders  ok login with ftp "
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi
