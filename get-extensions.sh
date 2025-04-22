#!/bin/bash

read -p "What is your first name? " firstName
echo

read -p "What is your surname? " lastName
echo

PS3="What type of phone do you want? "
select phoneType in headset handheld; do
	echo "You use a ${phoneType} phone"
	break
done
echo

PS3="What department are you in? "
select department in finance sales "customer service" engineering do
	echo "You are in the ${department} department"
	break
done
echo

read -N 4 -p "What is your extension number? " extensionNum
echo
read -N 4 -s -p "What is your 4-digit access code? " accessCode
echo

echo "${firstName},${lastName},${extensionNum},${accessCode},${phoneType},${department}" >> extensions.csv
