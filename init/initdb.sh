#!/bin/bash

CWD=$(realpath `dirname $0`)

# env
. $CWD/../env.txt

if [ "$JCR_SGDB" = "postgresql" ]; then
  cat $CWD/create_jcr_postgresql.sql | sed -e 's/JCR_PW/'"$JCR_PW"'/g' | sed -e 's/JCR_DB/'"$JCR_DB"'/g' | sed -e 's/JCR_USER/'"$JCR_USER"'/g'
elif [ "$JCR_SGDB" = "mysql" ]; then
  cat $CWD/create_jcr_mysql.sql | sed -e 's/JCR_PW/'"$JCR_PW"'/g' | sed -e 's/JCR_DB/'"$JCR_DB"'/g' | sed -e 's/JCR_USER/'"$JCR_USER"'/g'
fi

if [ "$HIB_SGDB" = "postgresql" ]; then
  cat $CWD/create_repository_postgresql.sql | sed -e 's/HIB_PW/'"$HIB_PW"'/g' | sed -e 's/HIB_DB/'"$HIB_DB"'/g' | sed -e 's/HIB_USER/'"$HIB_USER"'/g'
elif [ "$HIB_SGDB" = "mysql" ]; then
  cat $CWD/create_repository_mysql.sql | sed -e 's/HIB_PW/'"$HIB_PW"'/g' | sed -e 's/HIB_DB/'"$HIB_DB"'/g' | sed -e 's/HIB_USER/'"$HIB_USER"'/g'
fi

if [ "$QUARTZ_SGDB" = "postgresql" ]; then
  cat $CWD/create_quartz_postgresql.sql | sed -e 's/QUARTZ_PW/'"$QUARTZ_PW"'/g' | sed -e 's/QUARTZ_DB/'"$QUARTZ_DB"'/g' | sed -e 's/QUARTZ_USER/'"$QUARTZ_USER"'/g'
elif [ "$QUARTZ_SGDB" = "mysql" ]; then
  cat $CWD/create_quartz_mysql.sql | sed -e 's/QUARTZ_PW/'"$QUARTZ_PW"'/g' | sed -e 's/QUARTZ_DB/'"$QUARTZ_DB"'/g' | sed -e 's/QUARTZ_USER/'"$QUARTZ_USER"'/g'
fi
