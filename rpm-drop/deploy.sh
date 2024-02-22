#!/bin/bash
#
# NOTE: Please update path below: /root/rob
#
# This script was born out of frustration with a very long deployment
# process. It still requires a lot of manual labour:
#  1. Start a local gradle build in your dev env (I like to clean too), I use build.bat
#  2. Make sure you have winscp open (proc pod ssh port gets closed when Appl is off)
#  3. Start this script on server (stopping Appl in parallel saves a minute or two)
#  4. Copy rpms to server
#  5. Push enter
#  6. Go play with robot
# Rinse/repeat

# If you want to just install the rpms without waiting use -nopause (if they're already there)

WAIT=true
if [ "$1" = "-nopause" ] ; then
   echo "Will not wait for rpm upload"
   WAIT=false
fi

set -e

cd /root/rob

sudo -u adv /opt/SMAW/INTP/bin/AdvNodeControl.sh stopAppl

if [ "$WAIT" = "true" ] ; then
   echo "Push enter once you have uploaded new rpms."
   read
fi

ls -al INTPsurw*.rpm

# Only uninstall the rpms we have uploaded
rpm -e --nodeps  `ls INTPsurw*rpm | cut -d- -f1`

rpm -ivh --nodeps INTPsurw*.rpm

/advdata/advisref/AdvInstall.pl -c -m runSteps STOP_APPL STOP_DB 3100-7500

sudo -u adv /opt/SMAW/INTP/bin/AdvNodeControl.sh statusAppl

