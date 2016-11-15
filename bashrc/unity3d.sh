source verbs.sh
source template.sh

function u3d {
	local usage="u3d <verb> [args]"
	_verb u3d $@
}

function _u3d_monobehaviour {
	local usage="$parent monobehaviour <path>"
	_template unity3d/monobehaviour $1
}

function _comp_u3d {
	local func=$1
	local cur=$2
	compopt -o default
	case $COMP_CWORD in
		1)
			COMPREPLY=(`_verbgen $func $cur`)
			;;
		*)
			COMPREPLY=()
			;;
	esac
	return 0
}

complete -F _comp_u3d u3d
