#!/bin/bash

function mesosFrameworkTeardown {(
  MASTER_BASE_URL=${MASTER_BASE_URL:-"http://localhost:5050"}
  http --print=HhBb --form POST ${MASTER_BASE_URL}/master/teardown frameworkId=${1}
)}

function onEachSlave {(
  MASTER_BASE_URL=${MASTER_BASE_URL:-"http://localhost:5050"}
  for h in $(http ${MASTER_BASE_URL}/master/state.json | jq -r '.slaves[].hostname' | sort);do 
    echo "[SLAVE] -- $h ----------" >&2 
#    ssh -i ${PRIVATE_KEY:-"~/.ssh/mesosphere"} "${SSH_USER:-"core"}@$h" -C "$@"
    ssh $h "$@"
  done
)}

