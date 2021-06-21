#! /bin/bash
#chmod +x syswatch.sh -- to make this file executable

#VARIABLES required
THRESHOLD_PRECENTAGE=20
LIST_OF_FILES_TO_IGNORE="floppy|proc|cdrom|total|buffer"
NUM_OF_ACTIVE_USERS_THRESHOLD=1

sendEmailAboutDiskUsageIfNecessary(){
    THRESHOLD_PRECENTAGE=$1
    LIST_OF_FILES_TO_IGNORE=$2

    #df -H display disk usage in human redable form or in GB
    #GREP -e is used to pattern match, so to do not match pattern doing grep -ve
    #awk to print the 5th column in the text here
    #Make sure to use double quotes when trying to replace the list of files to ignore variable.
    #If you use single quotes the variable will
    #be treated literally
    df -H | grep -vE "^Filesystem|$LIST_OF_FILES_TO_IGNORE" | awk '{ print $5 " " $1 " " $6 }' | while read OUTPUT;
    do
        #echo $OUTPUT
        PERCENTAGE_USED=$(echo $OUTPUT | awk '{ print $1 }' | cut -d"%" -f1)
        CURRENT_DISK_BEINGANALYZED=$(echo $OUTPUT | awk '{ print $2 }')
        MOUNTED_AS=$(echo $OUTPUT | awk '{ print $3 }')
        HOST_NAME=$(hostname)
        CURRENT_DATE_TIME=$(date)
        #echo $PERCENTAGE_USED
        echo $CURRENT_DISK_BEINGANALYZED
        #echo ${CURRENT_DATE_TIME}

        if [ $PERCENTAGE_USED -gt $THRESHOLD_PRECENTAGE ]; then
            BODY="System is running out of space ${CURRENT_DISK_BEINGANALYZED} mounted as $MOUNTED_AS ($PERCENTAGE_USED%) on server ${HOST_NAME}, ${CURRENT_DATE_TIME}"

           echo $BODY
            sendEmail "root" "Warning : Almost out of disk usage (%)" "$BODY"
        fi
    done
}

print_freeAndTotalSpace() {
    LIST_OF_FILES_TO_IGNORE=$1
    free -m | grep -vE "^FileSystem|Swap|$LIST_OF_FILES_TO_IGNORE" | awk '{ print $2 " " $4 }' | while read OUTPUT;
    do
      TOTAL_SPACE=$(echo $OUTPUT | awk '{ print $1 }')
      USED_SPACE=$(echo $OUTPUT | awk '{ print $2 }')
      echo "Free/Total Memory : ${USED_SPACE}/${TOTAL_SPACE} MB"
    done
}


print_freeAndTotalSwapSpace() {
    LIST_OF_FILES_TO_IGNORE=$1
    free -m | grep -vE "^FileSystem|Mem|$LIST_OF_FILES_TO_IGNORE" | awk '{ print $2 " " $4 }' | while read OUTPUT;
    do
      TOTAL_SPACE=$(echo $OUTPUT | awk '{ print $1 }')
      USED_SPACE=$(echo $OUTPUT | awk '{ print $2 }')
      echo "Free/Total Swap : ${USED_SPACE}/${TOTAL_SPACE} MB"
    done
}



print_numberOfActiveUsers(){
  ACTIVE_USERS_THRESHOLD=$1
  NUMBER_OF_ACTIVE_USERS=$(who | wc -l)
  #Index starts at 0 so adding +1
  NUMBER_OF_ACTIVE_USERS = $(( $NUMBER_OF_ACTIVE_USERS + 1))	
  if [ $NUMBER_OF_ACTIVE_USERS -ge $ACTIVE_USERS_THRESHOLD ]; then
     echo "User count is at ${NUMBER_OF_ACTIVE_USERS}"
     UPTIME=$(uptime | tr "," " " | cut -f6-8 -d" ")
     SYSTEM_LOAD=$(uptime | awk -F': ' '{print $2}')
     echo "The system has been up for ${UPTIME} with a system load average of : ${SYSTEM_LOAD}"
  fi
}


sendEmail(){
 RECEIVER=$1
 SUBJECT=$2
 BODY=$3
 echo "$BODY" | mail -s "${SUBJECT}" $RECEIVER

}


print_numberOfActiveUsers ${NUM_OF_ACTIVE_USERS_THRESHOLD}
print_freeAndTotalSwapSpace ${LIST_OF_FILES_TO_IGNORE}
print_freeAndTotalSpace ${LIST_OF_FILES_TO_IGNORE}


sendEmailAboutDiskUsageIfNecessary ${THRESHOLD_PRECENTAGE} ${LIST_OF_FILES_TO_IGNORE}
