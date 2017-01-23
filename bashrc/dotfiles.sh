source verbs.sh

alias dotfiles="_verb dotfiles"

function _dotfiles_update {
	local usage="$parent dotfiles update"
	cd $DOTFILES_HOME
	git pull
	cd - &> /dev/null
}

# tab completion
function _comp_dotfiles {
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

complete -F _comp_dotfiles dotfiles
