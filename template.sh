
function _template {
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
		local _template=`compgen -f $TEMPLATES_HOME/$template*`
		if [[ $_template && -f $_template ]]; then
			template=$_template
			local fname=${path##*/}
			local extension=${fname##*.}
			if [[ $extension == $fname ]]; then
				extension=${template##*.}
			fi
			local dir="."
			if [[ $fname != $path ]]; then
				dir=${path%/*}
			fi
			if [[ ! $name ]]; then
				name=${fname%.*}
			fi
			fname=${fname%.*}.$extension
			path=$dir/$fname
			for var in $exports; do
				local gvar=$var
				local tvar=_tmp_$var
				export $tvar=${!gvar}
				export $gvar=${!var}
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
			echo "no template '$template' found"
			return 1
		fi
	else
		echo "usage: $usage"
		return 1
	fi
}

function _templategen {
	local template=$1
	find $TEMPLATES_HOME -type f | (
		while read line; do
			line=${line#$TEMPLATES_HOME/}
			line=${line%.*}
			if [[ $line =~ ^$template ]]; then
				echo $line
			fi
		done
	)
}
