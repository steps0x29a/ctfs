FROM mongo:4.4.18
COPY users.json /tmp/users.json
# RUN mongoimport --host mongo --db exploit --collection users --type json --file /tmp/users.json --jsonArray