#!/bin/bash

if [ "${1:0:1}" = '-' ]; then
    set -- sensu-client "$@"
fi

if [ ! -z "$INSTALL_PLUGINS" ]
then
    for plugin in $INSTALL_PLUGINS
        do sensu-install -p $plugin
    done
fi

exec "$@"
