#!/bin/sh

DIR_REL=`dirname $0`
cd $DIR_REL
DIR=`pwd`

. "$DIR/set-pentaho-env.sh"

. "$DIR/env.txt"

################################################################################
# localization
if [ "$TZ" = "" ]; then
  TZ=`cat /etc/timezone`
  if [ "$TZ" = "" ]; then
    TZ="America/Fortaleza"
  fi
fi
if [ "$COUNTRY" = "" ]; then
  COUNTRY="BR"
fi
if [ "$LANGUAGE" = "" ]; then
  LANGUAGE="pt"
fi
export TZ
LOCALEENV="-Duser.timezone=$TZ -Duser.country=$COUNTRY -Duser.language=$LANGUAGE"
################################################################################

# wait to install
while true; do
  # se instalacao acabou
  if [ ! -f "/opt/pentaho/pentaho-server/tomcat/temp/install" ]; then
    break;
  else
    # gerar sql
    /base/init/initdb.sh > /opt/pentaho/pentaho-server/tomcat/temp/init.sql.tmp
    mv /opt/pentaho/pentaho-server/tomcat/temp/init.sql.tmp /opt/pentaho/pentaho-server/tomcat/temp/init.sql
  fi
done

# custom variables
# read -r ENXVVARS << EOF
# -Dclusterid=$CLUSTERID                             \
# -Ddb.jcrhost=$JCR_HOST                             \
# -Ddb.jcrport=$JCR_PORT                             \
# -Ddb.jcrdb=$JCR_DB                                 \
# -Ddb.jcruser=$JCR_USER                             \
# -Ddb.jcrpass=$JCR_PW                               \
# -Ddb.jcrsgdb=$JCR_SGDB                             \
# -Ddb.jcrdriver=$JCR_DRIVER                         \
# -Ddb.jcrvq=\"$JCR_VQ\"                             \
# -Ddb.jcrdialect=$JCR_DIALECT                       \
# -Ddb.jcrpersistencemanager=$JCR_PERSISTENCEMANAGER \
# -Ddb.hibhost=$HIB_HOST                             \
# -Ddb.hibport=$HIB_PORT                             \
# -Ddb.hibdb=$HIB_DB                                 \
# -Ddb.hibuser=$HIB_USER                             \
# -Ddb.hibpass=$HIB_PW                               \
# -Ddb.hibsgdb=$HIB_SGDB                             \
# -Ddb.hibdriver=$HIB_DRIVER                         \
# -Ddb.hibvq=\"$HIB_VQ\"                             \
# -Ddb.hibdialect=$HIB_DIALECT                       \
# -Ddb.qtzhost=$QUARTZ_HOST                          \
# -Ddb.qtzport=$QUARTZ_PORT                          \
# -Ddb.qtzdb=$QUARTZ_DB                              \
# -Ddb.qtzuser=$QUARTZ_USER                          \
# -Ddb.qtzpass=$QUARTZ_PW                            \
# -Ddb.qtzsgdb=$QUARTZ_SGDB                          \
# -Ddb.qtzdriver=$QUARTZ_DRIVER                      \
# -Ddb.qtzvq=\"$QUARTZ_VQ\"                          \
# -Ddb.qtzdialect=$QUARTZ_DIALECT
# EOF
#ENVVARS=$(echo $ENXVVARS)

ENVVARS="-Dclusterid=$CLUSTERID -Ddb.jcrhost=$JCR_HOST -Ddb.jcrport=$JCR_PORT -Ddb.jcrdb=$JCR_DB -Ddb.jcruser=$JCR_USER -Ddb.jcrpass=$JCR_PW -Ddb.jcrsgdb=$JCR_SGDB -Ddb.jcrdriver=$JCR_DRIVER -Ddb.jcrvq=\"$JCR_VQ\" -Ddb.jcrdialect=$JCR_DIALECT -Ddb.jcrpersistencemanager=$JCR_PERSISTENCEMANAGER -Ddb.hibhost=$HIB_HOST -Ddb.hibport=$HIB_PORT -Ddb.hibdb=$HIB_DB -Ddb.hibuser=$HIB_USER -Ddb.hibpass=$HIB_PW -Ddb.hibsgdb=$HIB_SGDB -Ddb.hibdriver=$HIB_DRIVER -Ddb.hibvq=\"$HIB_VQ\" -Ddb.hibdialect=$HIB_DIALECT -Ddb.qtzhost=$QUARTZ_HOST -Ddb.qtzport=$QUARTZ_PORT -Ddb.qtzdb=$QUARTZ_DB -Ddb.qtzuser=$QUARTZ_USER -Ddb.qtzpass=$QUARTZ_PW -Ddb.qtzsgdb=$QUARTZ_SGDB -Ddb.qtzdriver=$QUARTZ_DRIVER -Ddb.qtzvq=\"$QUARTZ_VQ\" -Ddb.qtzdialect=$QUARTZ_DIALECT"

setPentahoEnv "$DIR/jre"

DI_HOME="$DIR"/pentaho-solutions/system/kettle

errCode=0
if [ -f "$DIR/promptuser.sh" ]; then
  sh "$DIR/promptuser.sh"
  errCode="$?"
  rm "$DIR/promptuser.sh"
fi
if [ "$errCode" = 0 ]; then
  cd "$DIR/tomcat/bin"
  CATALINA_OPTS="$LOCALEENV $ENVVARS -Xms2048m -Xmx6144m -XX:MaxPermSize=256m -Dsun.rmi.dgc.client.gcInterval=3600000 -Dsun.rmi.dgc.server.gcInterval=3600000 -Dfile.encoding=utf8 -DDI_HOME=\"$DI_HOME\""
  export CATALINA_OPTS
  JAVA_HOME=$_PENTAHO_JAVA_HOME
  sh startup.sh
fi
