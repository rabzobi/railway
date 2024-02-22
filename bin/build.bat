@echo off

REM I use this script to build all rpms
REM Before running this script open a winscp connection to the proc pod 
REM My broadband and vpn is stable enough to keep the ssh connection open
REM Once you start this batch, you can immediately go run deploy.sh in the proc pod
REM This will save you a minute or two by running things in parallel 
REM It will wait for your upload of the rpm's (done manually)
REM Also let other devs/qa know you are going to deploy to that env
REM Once the files are uploaded, hit enter in the running deploy.sh in the proc pod
REM You can also do this:
REM   1. Run this batch file
REM   2. Upload the files to the proc pod
REM   3. Run in proc pod: deploy.sh -nopause
REM NOTE: You should be in Railway-Product-railway-advantage when you run this batch file


echo Killing gradle to remove filesystem locks else clean fails
taskkill /f /im java.exe /t
call gradlew clean build unifiedPackage production:collectRpms -x test
if %errorlevel% neq 0 goto end

call collect.bat
goto end

:error
echo Build failed, not copying rpms

:end
