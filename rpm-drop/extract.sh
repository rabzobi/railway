#!/bin/bash

# TODO: Run AdvErrLogViewer.pl to get traces (currently I use smaf)


set -e

rm -rf Session_Session01 *.tar.gz Session01.merge
ls -t /var/tmp/AdvCollectedTraces.*.tar | head -1
tar xf `ls -t /var/tmp/AdvCollectedTraces.*.tar | head -1`
ls -al
tar zxf `ls -S *.tar.gz | head -1`
ls -al Session_Session01
mv Session_Session01/Session01.merge .
rm -rf *.tar.gz Session_Session01
grep pl.nsn.railway Session01.merge > pl.nsn.railway-traces-`date +%s`
ls -al


