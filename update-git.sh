#!/usr/bin/env bash

GLUON_GIT="$1"
GLUON_BRANCH="$2"

echo "$1"
echo "$2"

function update() {
	# Kill it with fire
	rm -rf gluon
	git clone "$GLUON_GIT" -b "GLUON_BRANCH" gluon
}

(
	if ! [[ -e gluon ]]; then
		update
		exit 0
	fi

	REMOTE_REF=$(git ls-remote -D gluon -qht "$GLUON_GIT" | grep "$GLUON_BRANCH" | cut -f1)
	LOCAL_REF=$(git rev-parse -D gluon HEAD)

	if [[ $REMOTE_REF != $LOCAL_REF ]]; then
		update
	fi
)
