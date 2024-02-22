@echo off

REM Before running this update paths below
REM I use: C:\Users\Rob\Projects\Railway-Product>dir /b/s | grep INTPsurw
REM to get them quickly

REM collect.bat Copies files to the directory where I have winscp open: I use C:\Users\Rob\rpm-drop
REM Must open connection before running deploy.sh which will close ssh port to proc pod
REM NOTE: When application is stopped proc pod closes ssh port but it doesn't drop open connections (sneaky)
REM Hint: Add this script to your path

del C:\Users\Rob\rpm-drop\*.rpm

REM Active Active deploy
copy C:\Users\Rob\Projects\Railway-Product\railway\application\build\INTPsurwa-23.1.2-*-SNAPSHOT.rpm C:\Users\Rob\rpm-drop
copy C:\Users\Rob\Projects\Railway-Product\railway\integrants\build\INTPsurwi-23.1.2-*-SNAPSHOT.rpm C:\Users\Rob\rpm-drop
copy C:\Users\Rob\Projects\Railway-Product\railway\grkeepalive\build\INTPsurwk-23.1.2-*-SNAPSHOT.rpm C:\Users\Rob\rpm-drop
rem copy C:\Users\Rob\Projects\Railway-Product\railway\grmonitor\build\INTPsurwz-23.1.2-*-SNAPSHOT.rpm C:\Users\Rob\rpm-drop

goto done

REM TRV Deploy
copy C:\Users\Rob\Projects\Railway-Product\swe-trv\application\build\INTPsurwa-23.1.4-*-swe-trv-SNAPSHOT.rpm C:\Users\Rob\rpm-drop
copy C:\Users\Rob\Projects\Railway-Product\swe-trv\callservice\base\build\INTPsurwb-23.1.4-*-swe-trv-SNAPSHOT.rpm C:\Users\Rob\rpm-drop
copy C:\Users\Rob\Projects\Railway-Product\swe-trv\callservice\sms\build\INTPsurwm-23.1.4-*-swe-trv-SNAPSHOT.rpm C:\Users\Rob\rpm-drop
copy C:\Users\Rob\Projects\Railway-Product\swe-trv\callservice\speech\build\INTPsurws-23.1.4-*-swe-trv-SNAPSHOT.rpm C:\Users\Rob\rpm-drop
copy C:\Users\Rob\Projects\Railway-Product\swe-trv\integrants\build\INTPsurwi-23.1.4-*-swe-trv-SNAPSHOT.rpm C:\Users\Rob\rpm-drop

REM For Aus Deploy
copy C:\Users\Rob\Projects\Railway-Product\aus-vir\application\build\INTPsurwa-*-aus-vir*.rpm C:\Users\Rob\rpm-drop 
copy C:\Users\Rob\Projects\Railway-Product\aus-vir\integrants\build\INTPsurwi-*-aus-vir*.rpm C:\Users\Rob\rpm-drop 
copy C:\Users\Rob\Projects\Railway-Product\aus-vir\callservice\notifier\build\INTPsurwn-*-aus-vir*.rpm C:\Users\Rob\rpm-drop 
copy C:\Users\Rob\Projects\Railway-Product\aus-vir\callservice\speech\build\INTPsurws-*-aus-vir*.rpm C:\Users\Rob\rpm-drop 
copy C:\Users\Rob\Projects\Railway-Product\aus-vir\callservice\base\build\INTPsurwb-*-aus-vir*.rpm C:\Users\Rob\rpm-drop
copy C:\Users\Rob\Projects\Railway-Product\aus-vir\callservice\sms\build\INTPsurwm-*-aus-vir*.rpm C:\Users\Rob\rpm-drop

:done
