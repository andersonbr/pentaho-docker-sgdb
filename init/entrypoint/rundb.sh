#!/bin/bash

while true; do
  # instalacao
  if [ -f "/schemabase/install" ]; then

    # install exists, wait for generate sql file
    echo "install waiting for sql file"

    # sql file ok, run
    if [ -f "/schemabase/init.sql" ]; then
      cat /schemabase/init.sql | mysql -uroot -p"${MYSQL_ROOT_PASSWORD}"
      # delete files
      rm -f /schemabase/install /schemabase/init.sql
    fi

    sleep 1
  else
    echo "install ok..."
    sleep 1
    break
  fi
done
