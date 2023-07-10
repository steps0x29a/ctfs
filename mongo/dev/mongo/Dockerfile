FROM mongo:4.4.18
COPY users.json /tmp/users.json
RUN mongo --eval 'db.createCollection("exploit.users")'
RUN mongo --eval 'exploit.users.insertMany(JSON.parse(cat("/tmp/users.json")))'