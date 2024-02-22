REM This script isn't finished, I hack it every time I need to copy my key to a different server
REM One day I will make it marvellous: deploy my key to every snd and proc pod with one command ;-)

set host=10.46.80.52
set port=31138
set user=root
echo "Copy keys to %user% at %host% port %port%"

ssh-keygen -R [%host%]:%port%
type C:\Users\Rob\.ssh\id_rsa.pub | ssh -o StrictHostKeyChecking=no -p %port% %user%@%host% "cat >> authorized_keys; mkdir .ssh; chmod 700 .ssh; mv authorized_keys .ssh; chmod 600 .ssh/authorized_keys"
