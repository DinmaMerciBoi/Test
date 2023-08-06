#!/bin/bash
# This simple script collects users details dynamically and adds them to our MySQL Database
# MAINTAINER: CHukwudinma Akabuogu - DevOps Engineer

# Variables, edit as desired before running the script
API_URL="http://40.88.200.103/create"

echo "Welcome to the process of adding your details to our database."
echo "Please enter your full name..."
read name
sleep 1

echo "Enter your email address..."
read email
sleep 1

echo "Enter your password..."
read -s password1
echo "Enter your password again..."
read -s password2
sleep 1

if [ $password1 == $password2 ]
then
echo "Your details are being added to our database."
sleep 2

NAME=$name
EMAIL=$email
PWD=$password1

JSON_DATA="{\"name\":\"$NAME\",\"email\":\"$EMAIL\",\"pwd\":\"$PWD\"}"

# Perform POST request using curl
curl -X POST -H "Content-Type: application/json" -d "$JSON_DATA" "$API_URL"

echo "Your details have beed added successfully."
echo "Thank you. Have a great day."

else
echo "Your password does not match. Please try again."
fi

# Remember to add an executable permission to the script before running.
