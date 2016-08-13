#!/bin/bash
# Author: Nick Zwart
# Date: 2016aug12
# Brief: Pull from an svn repo and push to a protected git branch using
#        git-svn.  The git branch should only be used for cherry picking
#        commits to update other git branches.  This assumes the subversion
#        and git keys are set up to be automatic.

set -e
#set -x

date

SVN_REMOTE_URL=$1
GIT_REMOTE_URL=$2
GIT_REMOTE_BRANCH=$3

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WORKING_DIR=$DIR
echo "moving to $DIR"
cd $WORKING_DIR

# rebase from svn
LOCAL_REPO=`basename $SVN_REMOTE_URL`
if [ ! -d "${LOCAL_REPO}" ];
then
    echo "Doing initial setup of repo, this could take a while..."
    git svn clone ${SVN_REMOTE_URL} --prefix svn/ ${LOCAL_REPO}
    cd ${LOCAL_REPO}
    git config core.fileMode false
    git config core.autocrlf false
    git remote add origin ${GIT_REMOTE_URL}
else
    echo "Existing repo found..."
    echo "pulling changes from svn"
    cd ${LOCAL_REPO}
    git svn rebase
fi

echo "git push to $GIT_REMOTE_URL $GIT_REMOTE_BRANCH"
git push origin master:${GIT_REMOTE_BRANCH}
