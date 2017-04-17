
# generate new files from templates
# template <template> <path> [name]
# templates are stored in $TEMPLATES_HOME/
function template {
	local template=$1	# name of template to use
	local path=$2		# path of new file to create
	local name=$3		# optional 'name' (template dependant; taken as filename without the extension if absent)
	local usage=${usage:-"template <template> <path> [name]"}
	# local variables to export to template
	local exports="
		path
		name
		fname
		dir
	"
	if [[ $template && $path ]]; then
		template=`echo $TEMPLATES_HOME/$template*` # find first match in templates directory
		if [[ $template && -f $template ]]; then
			local fname=${path##*/}						# trim directories to get filename
			local extension=${fname##*.}				# trim filename, leaving extension (without the .)
			if [[ $extension == $fname ]]; then
				# if there is no extension specified, use the one on the template
				extension=${template##*.}
			fi
			local dir="."							# directory for new file
			if [[ $fname != $path ]]; then
				# if it isn't pwd, get it from the path by lopping off the fname
				# (the bit after the last /)
				dir=${path%/*}
			fi
			if [[ ! $name ]]; then
				# if user didn't define a name, use fname without the extension
				name=${fname%.*}
			fi
			fname=${fname%.*}.$extension		# use proper extension
			path=$dir/$fname						# reconstruct path
			for var in $exports; do			# export locals
				local gvar=$var			# global name
				local tvar=_tmp_$var		# temp name (for whatever values was in the global, just in case)
				export $tvar=${!gvar}
				export $gvar=${!var}
			done
			if [ $dir ]; then
				# make parent directories, if necessary
				mkdir -p $dir
			fi
			cat $template | envsubst > $path	# do the thing! substitute enviroment variables in template
			echo $path
			for var in $exports; do			# un-export locals and put everything back where it belongs
				local gvar=$var
				local tvar=_tmp_$var
				export $gvar=${!tvar}
				export $tvar=""
			done
			return 0
		else
			echo "usage: $usage"
			echo "no such template"
			return 1
		fi
	else
		echo "usage: $usage"
		return 1
	fi
}

# generate list of existing templates
# usable with compgen
function _templategen {
	local query=$2
	find $TEMPLATES_HOME -type f |
		sed -r 's?'$TEMPLATES_HOME'/??; s/\.[^\.]*$//' |
		grep -P '^'$query
}

# template tab completetion
function _comp_template {
	compopt +o default
	case $COMP_CWORD in
		1)
			COMPREPLY=(`_templategen "$@"`)
			return 0
			;;
		2)
			compopt -o default
			COMPREPLY=()
			return 0
			;;
		3)
			compopt -o bashdefault
			COMPREPLY=()
			return 0
			;;
		*)
			COMPREPLY=()
			return 0
			;;
	esac
}

complete -F _comp_template template
