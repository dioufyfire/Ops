## PROCESSUS
ps -o ppid= -p XXXX -> Find the Parent Process ID of a Running Process
pstree $PPID -> PS tree

## CRON
for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l; done -> list all cron on system

## USERS & GROUPS
adduser USER_TO_ADD -u UID
usermod -s /bin/false USER_TO_ADD -> Change shell 
chsh -s /bin/false username -> Alternative

## NETWORK
curl ifconfig.me -> IP Public
host IP_ADDRESS -> Reverse IP lookup

## STAORAGE
du -a /mysql --exclude=/{proc,sys,dev} |  sort -n -r | head -n 20  


## VAR_ENV
printenv
printenv SHELL
set -> variables de shell, variables d’environnement, variables locales et fonctions de shell
export TEST_VAR
unset TEST_VAR

## SYSTEM
Kernel version
- uname -r
- cat /proc/version