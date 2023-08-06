#!/bin/bash
# This simple script collects users details dynamically and adds them to our MySQL Database
# MAINTAINER: CHukwudinma Akabuogu - DevOps Engineer

# Variables, edit as desired before running the script
API_URL="http://52.170.17.0:5000/create"
JSON_DATA='{"name":"$name","email":"$email","pwd":"$password1"}'

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

if (( $password1 == $password2 ))
then
echo "Your details are being added to our database."
sleep 2

# Perform POST request using curl
sudo curl -X POST -H "Content-Type: application/json" -d "$JSON_DATA" "$API_URL"

echo "Your details have beed added successfully."
echo "Thank you. Have a great day."

else
echo "Your password does not match. Please try again."
fi

# Remember to add an executable permission to the script before running.
