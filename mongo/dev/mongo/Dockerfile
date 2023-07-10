FROM mongo:4.4.18
COPY users.json /tmp/users.json
#RUN apt update && apt install -y wget
#RUN wget https://fastdl.mongodb.org/tools/db/mongodb-database-tools-debian11-x86_64-100.7.3.deb -o /tmp/mongodb-database-tools-debian11-x86_64-100.7.3.deb
#RUN apt install /tmp/mongodb-database-tools-debian11-x86_64-100.7.3.deb
#RUN mongoimport mongodb://localhost:27017 --db exploit --collection users /tmp/users.json
#RUN mongoimport --db exploit --collection users --file /tmp/users.json --jsonArray
# RUN mongo --eval 'db.exploit.users.insertMany( [ { "username": "admin", "password": "admin", "email": "admin@localhost" } ] )'
RUN mongoimport --host mongo --db exploit --collection users --type json --file /tmp/users.json --jsonArray