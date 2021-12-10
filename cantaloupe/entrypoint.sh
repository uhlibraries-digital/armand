#!/bin/bash

groupadd -r cantaloupe
useradd -r -s /bin/false -g cantaloupe cantaloupe

chown -R cantaloupe:cantaloupe /cantaloupe
chown cantaloupe:cantaloupe /dev/stdout

gosu cantaloupe:cantaloupe java -Dcantaloupe.config=/cantaloupe/cantaloupe.properties $JAVA_OPTS -jar /cantaloupe/cantaloupe.war