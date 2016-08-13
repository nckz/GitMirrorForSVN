# GitMirrorForSVN
A cronable script for updating a git mirror of an svn repo without access to
svn hooks.

## Requirements
* git
* git-svn
* saved svn authentication (so the script can run w/o auth)
* ssh keys for git (so the script can run w/o auth)

## Example
The following cron example will check for updates the subversion project trunk
every minute and push those updates to a branch called `trunk_svn` in the
remote git repo.  From there, any new commits can be cherry picked into the
git-native development branches.

`* * * * * /home/foo/update_git.sh http://svn.apache.org/repos/asf/subversion/trunk/ git@gitlab.com:asf/subversion.git trunk_svn`

