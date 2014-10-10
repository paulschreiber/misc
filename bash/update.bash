SRCDIR=${HOME}/.dev

function srcup ()
{
	pushd `pwd`
	for i in $( ls ${SRCDIR} )
	do
		cd ${SRCDIR}/$i
		pwd
		if [ -d .git ]; then
			git pull
			git remote prune origin
		fi
		if [ -d .svn ]; then
			svn update
		fi
	done
	popd
}
