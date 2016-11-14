function u3d {
	local usage="usage: u3d <verb> [args]"
	local verb=$1
	shift
	if [ $verb ]; then
		if type "_u3d_$verb" &> /dev/null; then
			eval "_u3d_$verb $@"
		else
			echo $usage
			echo "unknown verb $verb"
			return 1
		fi
	else
		echo $usage
		return 1
	fi
}

function _u3d_template {
	local usage="usage: u3d template <template> <path> [name]"
	local template=$1
	local path=$2
	local name=$3
	if [[ $template && $path ]]; then
		template="$BASHRCD/templates/$template.u3d"
		if [ -f $template ]; then
			if [[ ! $name ]]; then
				name=${path%.*}
				name=${name##*/}
			fi
			cat $template | sed -e "s/\$NAME/$name/g" > $path
			return 0
		else
			echo $usage
			echo "no template $template found"
			return 1
		fi
	else
		echo $usage
		return 1
	fi
}

function _u3d_mb {
	local usage="usage: u3d mb <path>"
	local path=$1
	if [[ $path ]]; then
		if [[ ! $path =~ .*\.cs ]]; then
			path=$path.cs
		fi
		u3d template mb $path
	else
		echo $usage
		return 1
	fi
}
