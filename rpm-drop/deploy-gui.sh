#!/bin/bash

DEPDIR=/opt/jboss/wildfly/standalone/deployments

rm -rf $DEPDIR/rwGuiEar.*
cp /opt/jboss/rwGuiEar.ear $DEPDIR/

echo -n "Waiting for deploy.."
while [ 1 ] ; do
 ls $DEPDIR/ | grep rwGuiEar.ear.deployed
 if [ $? -eq 0 ]; then
 	echo "Deployed"
 	exit
 fi
  ls $DEPDIR/ | grep rwGuiEar.ear.failed
 if [ $? -eq 0 ]; then
 	echo "Failed"
 	exit
 fi
 echo -n "."
 sleep 1
done