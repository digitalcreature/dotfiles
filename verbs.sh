function _verb {
	local parent=$1
	local verb=$2
	shift 2
	parent=${parent// /_}
	if [ $verb ]; then
		local call="_$parent""_$verb"
		if type $call &> /dev/null; then
			eval $call $@
		else
			echo "usage: $usage"
			echo "unknown verb '$verb'"
			return 1
		fi
	else
		echo "usage: $usage"
		return 1
	fi
}
