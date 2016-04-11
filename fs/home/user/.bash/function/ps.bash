#!/bin/bash

function killAll {
  local signal=${2:-"-9"}
  ps aux | grep "${1}" | grep -v grep | awk '{print $2}' | xargs kill ${signal}
}

