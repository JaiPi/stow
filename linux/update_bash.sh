#!/bin/bash

function update () {
	diff $file $HOME/$file > /dev/null 2>&1
	status=$?
	case $status in
  		0)
    			echo $file up to date
  		;;
  		1)
			mkdir -p $HOME/.bak
			mv $HOME/$file $HOME/.bak/$file$(date '+%Y%m%d%H%M').bak
    			cp $file $HOME/$file
			echo $file backed up
  		;;
  		2)
			cp $file $HOME/$file
    			echo $file added
  		;;
	esac
}

file=".bash_logout"
echo $(update)

file=".bashrc"
echo $(update)

file=".profile"
echo $(update)

file=".bash_profile"
if [ -f $HOME/$file ]; then
	mv $HOME/$file $HOME/.bak/$file$(date '+%Y%m%d%H%M').bak
	echo $file backed up
fi

for file in .bashrc.d/*;do
	mkdir -p $HOME/.bashrc.d
	mkdir -p $HOME/.bak/.bashrc.d
	echo $(update)
done
