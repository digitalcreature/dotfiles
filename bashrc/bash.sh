source template.sh

function template {
	local usage="template <template> <path> [name]"
	_template $@
}

function _comp_template {
	local cur=$2
	compopt +o default
	case $COMP_CWORD in
		1)
			COMPREPLY=(`_templategen $cur`)
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
