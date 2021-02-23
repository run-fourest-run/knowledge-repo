#!/usr/bin/env bash

echo
echo "Setting up server"
echo "--------"
echo

# Exit script if any command returns a non-zero status
set -e

if [ ! -d "/app/knowledge-repo" ]; then
	echo "Cloning research repo "

	cd /app/
	if [ -z "$(ls -A knowledge-repo)" ]; then
		echo "clone here"
#		This will need to be the PAT for the knowledge repo github account
		git clone https://67d38e435c7af79f051289fd65642d1a0b0cbed2@github.com/run-fourest-run/knowledge-repo.git
	fi
fi
echo Runtime context "local"

echo
cd /app/
if [ "${RUNTIME_CONTEXT}" == "local" ]; then
    echo Starting local server
    echo ---
    python scripts/knowledge_repo --repo ./knowledge-repo --debug runserver --config ./server_config.py --port 80
else
    echo Starting remote server
    echo ---
    python scripts/knowledge_repo --repo ./knowledge-repo runserver --config ./server_config.py --port 80

fi
