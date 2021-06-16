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



#Another way to read user input taught in college
echo Enter a filename to examine:
read FNAME
echo The number of lines in $FNAME is:
wc -l $FNAME
echo THe number of words in $FNAME is:
wc -w $FNAME
echo End of processing for $FNAME





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


NUM1=3
NUM2=5

if [ "${NUM1}" -gt "${NUM2}" ]
then
    echo "${NUM1} is greater than ${NUM2}"
else
    echo "${NUM1} is less than ${NUM2}"
fi










#HOW STUFF EXECURES -- These commands are interpreted and not compiled

# 1) The script is launched from within the user's login shell by typing the name of the shell script on the command line ./myscript
# 2) The user's login shell reads the first line of the script.
# 3) The shell which is named on the first line is executed and the name of the script is passed on to the new shell.
# 4) The new shell executes each line of the script file in an interpreted fashion.
# 5) The new shell exits at the end of the script.
# 6) Control is then returned to the user's original login shell which is still running.
