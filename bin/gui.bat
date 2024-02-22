@echo off
@setlocal

REM Before running this script update the host variable below
REM Also let other devs/qa know you are going to deploy to that env

REM Normally just drop ear into gui pod
REM Wildfly runs out of memory after 5 deploys so this script needs to be re-run if deploy fails
REM If deploy fails, restart gui pod first from applicable SND node: k delete pod `k get pods | grep rlwy-gui | cut -d' ' -f1`
REM Then re-run this script, it will re-setup ssh key and copy ear (without running build as you already have an ear)
REM The very first time this script is run, run it twice (one day I will fix this)

set host=10.46.87.156

ssh -o StrictHostKeyChecking=no -p 32120 jboss@%host% echo "SSH key test"
if %errorlevel% == 0 goto sshOk

echo Removing host key...
ssh-keygen -R [%host%]:32120
echo Adding auth key to server...
type C:\Users\Rob\.ssh\id_rsa.pub | ssh -o StrictHostKeyChecking=no -p 32120 jboss@%host% "cat >> authorized_keys; mkdir .ssh; chmod 700 .ssh; mv authorized_keys .ssh; chmod 600 .ssh/authorized_keys"

REM If we needed to add key, pod was just restarted and we don't need to rebuild can use same ear again
goto skipbuild

:sshOk

call gradlew build -p management -x test
if %errorlevel% neq 0 goto end

:skipbuild

echo Copying ear to %host%...
scp  -o StrictHostKeyChecking=no -P 32120 C:\Users\Rob\Projects\Railway-Product\management\rwGuiEar\build\libs\rwGuiEar.ear jboss@%host%:
echo Copying deploy script...
scp -o StrictHostKeyChecking=no -P 32120 C:\Users\Rob\rpm-drop\deploy-gui.sh jboss@%host%:
ssh -o StrictHostKeyChecking=no -p 32120 jboss@%host% bash /opt/jboss/deploy-gui.sh

:end
