#!/bin/bash
mongoimport --host mongo --db exploit --collection users --type json --file /tmp/users.json --jsonArray