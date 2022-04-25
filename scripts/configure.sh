#!/bin/sh
set -euo pipefail
cp /var/www/html/lib/config.template.php /var/www/html/lib/config.php
sed -i \
  -e "s|base_url = 'https://watchtower.dev'|base_url = '${WATCHTOWER_URL:=https:\://watchtower.example.org}'|g" \
  -e "s|dbHost = '127.0.0.1'|dbHost = '${MYSQL_HOST:=127.0.0.1}'|g" \
  -e "s|dbPassword = 'watchtower'|dbPassword = '${MYSQL_PASSWORD:=watchtower}|g" \
  -e "s|beanstalkServer = '127.0.0.1'|beanstalkServer = '${BEANSTALK_SERVER:=127.0.0.1}'|g" \
  /var/www/html/lib/config.php
