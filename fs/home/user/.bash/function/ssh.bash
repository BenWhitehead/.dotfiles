#!/bin/bash

function sshtmp {
	ssh -o "IdentitiesOnly yes" -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" $@
}

function scptmp {
	scp -o "IdentitiesOnly yes" -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" $@
}

