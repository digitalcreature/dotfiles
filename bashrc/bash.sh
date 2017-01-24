
# general utility stuff

# ao: 'atom open'
# usage: <command> | ao
# opens all files listed by output of <command> in atom
# 	(very useful when using template.sh; `template lua/class Foo | ao`
# 	will create a new file from the 'lua.class' template and open it)
alias ao="xargs atom"

# create a new empty file, and all parent directories if necessary
# usage: mk <path>
function mk {
	local usage="mk <path>"
	local path=$1
	if [[ $path ]]; then
		if [ -e $path ]; then
			echo "error: file already exists at $path"
			return 1
		else
			mkdir -p $path
			rmdir $path
			touch $path
			return 0
		fi
	else
		echo "usage: $usage"
		return 1
	fi

}

# an: 'atom new'
# usage: an <path>
# create a new file at <path> and open it in atom
function an {
	local usage="an <path>"
	local path=$1
	if [[ $path ]]; then
		mk $path
		atom $path
	else
		echo "usage: $usage"
		return 1
	fi
}
