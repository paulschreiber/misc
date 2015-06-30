SRCDIR=${HOME}/.dev

function srcup ()
{
	pushd `pwd`
	for i in $( ls ${SRCDIR} )
	do
		cd ${SRCDIR}/$i
		pwd
		if [ -d .git ]; then
      git fetch --all
			git pull
			git submodule update --recursive
			git remote prune origin
		fi
		if [ -d .svn ]; then
			svn upgrade
			svn update
		fi
	done
	popd
}

function toolsup()
{
  if [[ $EUID -ne 0 ]]; then
     echo "This script must be run as root."
     return
  fi

  npm update -g
  pear update-channels
  pear upgrade-all
  gem update --system
  gem update
  gem cleanup
  pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}