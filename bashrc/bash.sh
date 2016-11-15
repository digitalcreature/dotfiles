source template.sh

# general utility stuff

# generate new file from template
# template files are stored in $TEMPLATES_HOME/
function template {
	local usage="template <template> <path> [name]"
	_template $@
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
