source verbs.sh
source template.sh

# unity3d utils

# root command
function u3d {
	local usage="u3d <verb> [args]"
	_verb u3d $@
}

# create new monobehaviour from template
function _u3d_monobehaviour {
	local usage="$parent monobehaviour <path>"
	_template unity3d/monobehaviour $1
}

# tab completion
function _comp_u3d {
	compopt -o default
	case $COMP_CWORD in
		1)
			COMPREPLY=(`_verbgen "$@"`)
			;;
		*)
			COMPREPLY=()
			;;
	esac
	return 0
}

complete -F _comp_u3d u3d
