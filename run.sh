#!/bin/bash -x
source /etc/sysconfig/grafana-server
if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then
  OLDIFS=$IFS
  IFS=','
  for plugin in ${GF_INSTALL_PLUGINS}; do
#   grafana-cli --pluginsDir /usr/share/grafana/data/plugins plugins install ${plugin}
    grafana-cli --pluginsDir ${PLUGINS_DIR}                  plugins install ${plugin}
  done
  IFS=$OLDIFS
fi
cd /usr/share/grafana
/usr/sbin/grafana-server \
--config=${CONF_FILE} \
--pidfile=${PID_FILE} \
cfg:default.paths.logs=${LOG_DIR} \
cfg:default.paths.data=${DATA_DIR} \
cfg:default.paths.plugins=${PLUGINS_DIR}
