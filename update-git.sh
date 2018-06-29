#!/usr/bin/env bash

set -e -o pipefail

function update() {
	# Kill it with fire
	rm -rf gluon
	git clone "$GLUON_GIT" -b "$GLUON_BRANCH" gluon
}

(
	if ! [[ -e gluon ]]; then
		update
		exit 0
	fi

	REMOTE_REF=$(git ls-remote -qht "$GLUON_GIT" | grep "$GLUON_BRANCH" | cut -f1)
	LOCAL_REF=$(git rev-parse -C gluon HEAD)

	set +e

	if [[ $? -ne 0 || $REMOTE_REF != $LOCAL_REF ]]; then
		echo "$REMOTE_REF != $LOCAL_REF, updating"
		update
	fi
)
