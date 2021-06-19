#VARIABLES required
THRESHOLD_PRECENTAGE=20



#df -H display disk usage in human redable form or in GB
#GREP -e is used to pattern match, so to do not match pattern doing grep -ve
#awk to print the 5th column in the text here

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " "  $1 }' | while read OUTPUT;
do
    #echo $OUTPUT
    PERCENTAGE_USED=$(echo $OUTPUT | awk '{ print $1 }')
    CURRENT_DISK_BEINGANALYZED=$(echo $OUTPUT | awk '{ print $2 }') | cut -d"%" -f1

    echo $PERCENTAGE_USED
    echo $CURRENT_DISK_BEINGANALYZED

    # if [$OUTPUT -ge THRESHOLD_PRECENTAGE]; then
    #      echo "System is running out of space ${CURRENT_DISK_BEINGANALYZED} mounted as $CURRENT_DISK_BEINGANALYZED (%) on server cs345.svsu.edu, Sun Apr 12 23:49:14 EDT 2015"
    # fi
done

#if [ ${DISK_USAGE} -ge ${THRESHOLD_PRECENTAGE} ]

#https://www.cyberciti.biz/tips/shell-script-to-watch-the-disk-space.html