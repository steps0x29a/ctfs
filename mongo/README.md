Install Debian 12 in Virtual Box

Install SSH

ssh into the machine as any user, then `su`.

Install docker

Password for victim user is Qald]b!Z_d5Kn

Import users.json (./dev/mongo/users.json) with compass from host machine (easiest)

----

Victim VM Setup

Alpine linux on sda

user: victim:Qald]b!Z_d5Kn
root: root:??????????

apk add --update docker docker-compose openrc sudo nano
rc-update add docker boot
service docker start
