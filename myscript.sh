#chmod +x myscript.sh -- to make this file executable
#which bash to figure out where the bash is for this computer
#use ./myscript.sh to run the file

# use the shabang character to specify where to find the bash

#! /usr/bin/bash

#ECHO COMMAND -- Works like a print command
echo Hello World! 

#VARIABLES
#Uppercase by convention
#Letters, numbers and underscores
NAME="Sahil"
echo "My name is ${NAME}"


# USER INPUT
read -p "Enter your name: " NAME
echo "Hello ${NAME}, nice to meet you!"


#Simple IF Statement
#Note the space has to be there 😐
# if [ "${NAME}" == "SAHIL" ]
# then
#     echo "Your name is Sahil"
# else
#     echo "Your name is not Sahil"
# fi

#ELSE-IF (elif)
if [ "${NAME}" == "Sahil" ]
then
    echo "Your name is Sahil"
elif [ "${NAME}" == "Jack" ]
then
    echo "Your name is Jack"
else
    echo "Your name is not Sahil or Jack"
fi

#Comparision
########
# val1 -eq val2 Returns true if the values are equal
# val1 -ne val2 Returns true if the values are not equal
# val1 -gt val2 Returns true if val1 is greater than val2
# val1 -ge val2 Returns true if val1 is greater than or equal to val2
# val1 -lt val2 Returns true if val1 is less than val2
# val1 -le val2 Returns true if val1 is less than or equal to val2
########