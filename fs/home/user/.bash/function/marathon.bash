#!/bin/bash

function marathonServiceLocate {
	MARATHON_HOST=${MARATHON_HOST:-localhost}
	MARATHON_PORT=${MARATHON_PORT:-8080}
  APP_PORT_INDEX=${APP_PORT_INDEX:-0}
	http --json GET http://$MARATHON_HOST:$MARATHON_PORT/v2/apps/$1/tasks | jq -r "[.tasks[] | .host + \":\" + (.ports[$APP_PORT_INDEX] | tostring)]"
}

function marathonKillDeployments {
  MARATHON_HOST=${MARATHON_HOST:-localhost}
	MARATHON_PORT=${MARATHON_PORT:-8080}
  local ids=""
  if [ $# -eq 0 ]; then
    ids=$(http --json ${MARATHON_HOST}:${MARATHON_PORT}/v2/deployments | jq -r '.[].id')
  else
    ids=$@
  fi

  for id in ${ids} ; do
    http --print=Hh DELETE http://${MARATHON_HOST}:${MARATHON_PORT}/v2/deployments/${id}?force=true;
  done
}

