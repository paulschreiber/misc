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
  pear upgrade pear
  pear upgrade-all
  gem update --system
  gem update
  gem cleanup

  # Avoid pip cache permission warnings by manually creating the cache and chown-ing it:
  #     The directory '/Users/Asif/Library/Caches/pip/http' or its parent directory is
  #     not owned by the current user and the cache has been disabled. Please check the
  #     permissions and owner of that directory. If executing pip with sudo, you may want the -H flag.
  if [ `uname` == 'Darwin' ]; then
    PIP_CACHEDIR=${HOME}/Library/Caches
  else
    PIP_CACHEDIR=${HOME}/.cache
  fi

  mkdir -p ${PIP_CACHEDIR}/pip/http
  chown -R root ${PIP_CACHEDIR}/pip
  pip install --upgrade pip
  pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
}