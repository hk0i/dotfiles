#!/bin/sh

#
# Add extra JVM options here
#
OPTS="-Xms64m -Xmx256m"

LINKPATH=$(dirname $(which $0))
SCRIPTPATH=$LINKPATH/$(dirname $(readlink $(which $0)))

java $OPTS -Djava.ext.dirs=$SCRIPTPATH/lib org.carrot2.labs.smartsprites.SmartSprites "$@"
