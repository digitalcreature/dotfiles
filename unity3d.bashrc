source verbs.sh

function u3d {
	local usage="u3d <verb> [args]"
	_verb u3d $@
}

function _u3d_template {
	local usage="$parent template <template> <path> [name]"
	local template=$1
	local path=$2
	local name=$3
	local exports="
		path
		name
		fname
		dir
	"
	if [[ $template && $path ]]; then
		template="$BASHRCD/templates/$template.sht"
		if [ -f $template ]; then
			local fname=${path##*/}
			local dir=""
			if [[ $fname != $path ]]; then
				dir=${path%/*}
			fi
			if [[ ! $name ]]; then
				name=${fname%.*}
			fi
			for var in $exports; do
				echo $var = ${!var}
				local gvar=$var
				local tvar=_tmp_$var
				export $tvar=${!gvar}
				export $gvar=${!var}
				echo $var = ${!var}
			done
			if [ $dir ]; then
				mkdir -p $dir
			fi
			cat $template | envsubst > $path
			for var in $exports; do
				local gvar=$var
				local tvar=_tmp_$var
				export $gvar=${!tvar}
				export $tvar=""
			done
			return 0
		else
			echo "usage: $usage"
			echo "no template $template found"
			return 1
		fi
	else
		echo "usage: $usage"
		return 1
	fi
}

function _u3d_mb {
	local usage="$parent mb <path>"
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
