# PiBackup

## What
A small script using a raspberry pi to automatically copy files from a computer to an external drive plugged into the pi
Written with copying files from a windows share to an external harddrive plugged into the pi with the idea of having the script run at boot to make the sync as easy as possible once set up.

## Why
Because having an external backup for things like family photos is important. Using a pi and unpowered external harddrive is a compact and easily portable way to do this, and having the system be plug and play makes it easy for non-technologically inclined people (such as parents)

## How

**Set up**

Clone the repo and edit the settings.cfg to match your source and destination for file syncing.
Please note that you must first ensure any separate disks or network shares are mounted before trying to run the script.
Once you have edited the settings, run the script
`./piback.sh`

The script will then begin running. When complete it will send an email detailing its operation. 

**Note** In order for email to work, ssmtp must be set up and configured properly. 

