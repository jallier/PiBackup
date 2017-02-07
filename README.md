# PiBackup

## What
A small bash script using a raspberry pi to automatically copy files from a computer to an external drive plugged into the pi using rsync. Written with copying files from a windows share to an external harddrive plugged into the pi with the idea of having the script run at boot to make the sync as easy as possible once set up.

## Why
Because having an external backup for things like family photos is important. Using a pi and unpowered external harddrive is a compact and easily portable way to do this, and having the system be plug and play makes it easy for non-technologically inclined people (such as parents)

## How

**Set up**

First you may want to set up the mount points for the disks.
See here for help with the windows cifs shares: [Ubuntu wiki](https://wiki.ubuntu.com/MountWindowsSharesPermanently)
You may need to use 
`sudo mount.cifs //source/ /dest -o username=uname,password=psswd`

**Clone the repo**

```
git clone https://github.com/jallier/PiBackup.git
```

**Edit the settings**

Edit the settings.cfg to match your source and destination for file syncing.
Please note that you must first ensure any separate disks or network shares are mounted before trying to run the script.

**Run it**
```
./piback.sh
```
If you want to test out your source/dest locations, use:
```
./piback.sh -d
```
This will run rsync in dry-run mode which will only simulate a run and will not touch any data.

The script will then begin running. When complete it will send an email detailing its operation. 

**Note** In order for email to work, ssmtp must be set up and configured properly.

# Suggestions
I have likely made a few rookie bash mistakes here, so feel free to comment or PR with anything I might have missed


