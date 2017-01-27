#!/bin/bash
echo "Choose a number to connect to a server:
1) Run Server
2) gcloud init
3) Install php component for app engine
"
read OPTION

case $OPTION in
        1)
          dev_appserver.py --admin_host=192.168.33.10 --host=192.168.33.10 --php_executable_path=/usr/bin/php5-cgi app.yml
        ;;

        2)
          gcloud init
        ;;

        3)
          gcloud components install app-engine-php
        ;;
esac