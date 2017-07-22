#!/bin/bash

# validate_site.sh checks if the site.conf is valid json

GLUON_SITEDIR="." lua5.1 tests/site_config.lua

P=$(pwd)

echo "validating $P/make-release.sh ..."
bash -n $P/make-release.sh 

echo "validating $P/modules ..."
source $P/modules
testpath=/tmp/site-validate
rm -Rf $testpath
mkdir -p $testpath/packages
cd $testpath/packages
for feed in $GLUON_SITE_FEEDS; do
  echo "checking PACKAGES_${feed^^}_REPO ..."
  repo_var=$(echo PACKAGES_${feed^^}_REPO)
  commit_var=$(echo PACKAGES_${feed^^}_COMMIT)
  branch_var=$(echo PACKAGES_${feed^^}_BRANCH)
  repo=${!repo_var}
  commit=${!commit_var}
  branch=${!branch_var}
  if [ "$repo" == "" ]; then
    echo "repo $repo_var missing"
    exit 1
  fi
  if [ "$commit" == "" ]; then
    echo "commit $commit_var missing"
    exit 1
  fi
	if [ "$branch" == "" ]; then
    echo "branch $branch_var missing"
    exit 1
  fi
  git clone $(echo $repo) $feed
  cd $feed
  git checkout $(echo $branch)
  git checkout $(echo $commit)
  cd -
done
cd $testpath
git clone https://github.com/freifunk-gluon/gluon
cd gluon
git checkout v2016.2.6
cp -a package/ $testpath/packages
cd $testpath/packages/package
# remove standard packages:
rm -Rf iwinfo iptables haveged

echo "validating GLUON_SITE_PACKAGES from $P/site.mk ..."
sed '/GLUON_RELEASE/,$d' $P/site.mk | egrep -v '(#|G)'> $testpath/site.mk.sh
sed -i 's/\s\\$//g;/^$/d' $testpath/site.mk.sh
cat $testpath/site.mk.sh |
while read packet; do
  echo "check $packet ..."
  if [ "$(find $testpath/packages/ -type d -name "$packet")" '!=' '' ]; then
    : find found something
  else
    echo "ERROR: $packet missing"
    exit 1
  fi
done
