#! /bin/bash

# v 0.1
# Ensure that all windows shares are available and mounted locally first.
# May require use of libnss-winbind package for cifs mounting
# Requires rsync and ssmtp (if using email)
# You can use the -d flag for testing your file paths. This will run rsync in dry-run mode so no data will be moved.

# Get variables from config
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
source settings.cfg

# Send all output to log file
exec >> $logfile

echo "$(date) - Starting script..."

# Check if the destination folder exists
if [ ! -d "$dest" ]; then
	echo "$(date) - $dest does not exist; please check config and try again"
	exit 1
else
	echo "$(date) - $dest exists"
fi

# And check if the source folder exists
if [ ! -d "$source" ]; then
	echo "$(date) - $source does not exist; please check config and try again"
	exit 1
else
	echo "$(date) - $source exists"
fi

# Pushbullet function
push (){
	if [ "$3" != "-d" ] && [ "$apikey" != "" ]; then
		curl --header 'Access-Token:'"$apikey" https://api.pushbullet.com/v2/pushes --request POST --header 'Content-Type:application/json' --data-binary '{"body":"'"$2"'","title":"'"$1"'","type":"note"}' -s > /dev/null
	else
		echo "$(date) - Push function disabled during testing"
	fi
}

echo
echo "$(date) - Beginning sync..."

# Send pushbullet push
push "Rsync started" "Copying $source to $dest" "$1"

if [ "$1" != "-d" ]; then
	temp=$(rsync -avzhP --stats "$source" "$dest") 
else
	echo "$(date) - Debug mode on; doing a dry run"
	temp=$(rsync -avzhP --stats "$source" "$dest" --dry-run)
	echo
fi

echo "$temp"
echo "$(date) - Sync complete"

push "Completed sync" "" "$1"
echo

# Send the email if an address is given
# First create the mail.txt file
#summary=$(echo "$temp" | sed '0,/^$/d')
if [ "$email_to" != "" ]; then
	newline=$'\n'
	mail_output="To: ${email_to}${newline}From: ${email_from}${newline}Subject: PiBack sync complete${newline}${newline}${temp}"
	echo "$mail_output">mail.txt

	# Then send it using file redirection
	/usr/sbin/ssmtp "$email_to"<mail.txt
	echo "$(date) - Email sent"
else
	echo "$(date) - No email address given for recipient; not sending email report"
fi
echo "$(date) - Script exiting"
