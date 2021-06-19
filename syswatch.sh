#chmod +x syswatch.sh -- to make this file executable

#VARIABLES required
THRESHOLD_PRECENTAGE=20
LIST_OF_FILES_TO_IGNORE="floppy|proc|cdrom|C"

sendEmailAboutDiskUsageIfNecessary(){
    THRESHOLD_PRECENTAGE=$1
    LIST_OF_FILES_TO_IGNORE=$2
    #df -H display disk usage in human redable form or in GB
    #GREP -e is used to pattern match, so to do not match pattern doing grep -ve
    #awk to print the 5th column in the text here
    #Make sure to use double quotes when trying to replace the list of files to ignore variable. If you use single quotes the variable will
    #be treated literally
    df -H | grep -vE "^Filesystem|$LIST_OF_FILES_TO_IGNORE" | awk '{ print $5 " "  $1 " " $6 }' | while read OUTPUT;
     free -m | grep -vE "^FileSystem|$LIST_OF_FILES_TO_IGNORE" | awk '${ print $2 " " $4 }' | while read OUTPUT;
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

        if [ $PERCENTAGE_USED -ge $THRESHOLD_PRECENTAGE ]; then
            echo "System is running out of space ${CURRENT_DISK_BEINGANALYZED} mounted as $MOUNTED_AS ($PERCENTAGE_USED%) on server ${HOST_NAME}, ${CURRENT_DATE_TIME}"
        fi
    done
}

print_freeAndTotalSpace() {
    echo $(free)
}


print_freeAndTotalSpace


sendEmailAboutDiskUsageIfNecessary ${THRESHOLD_PRECENTAGE} ${LIST_OF_FILES_TO_IGNORE}


printNumberOfActiveUsersInTheSystem (){
    
}

#if [ ${DISK_USAGE} -ge ${THRESHOLD_PRECENTAGE} ]

#https://www.cyberciti.biz/tips/shell-script-to-watch-the-disk-space.html
