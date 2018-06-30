#!/usr/bin/env bash

set -e -o pipefail

function update() {
	# Kill it with fire
	rm -rf gluon
	git clone "$GLUON_GIT" -b "$GLUON_BRANCH" gluon
}

(
	if ! [[ -e gluon ]]; then
		echo "gluon dir nonexistent, updating"
		update
		exit 0
	fi

	REMOTE_REF=$(git ls-remote -qht "$GLUON_GIT" | grep "$GLUON_BRANCH" | cut -f1)

	cd gluon
	set +e
	LOCAL_REF=$(git rev-parse HEAD)
	GIT_EXIT=$?
	set -e
	cd ..

	if [[ $GIT_EXIT -ne 0 || $REMOTE_REF != "$LOCAL_REF" ]]; then
		echo "$REMOTE_REF != $LOCAL_REF, updating"
		update
	fi
)
