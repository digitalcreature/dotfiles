source template.sh

function template {
	local usage="template <template> <path> [name]"
	_template $@
}

function _comp_template {
	local cur=${COMP_WORDS[COMP_CWORD]}
	case $COMP_CWORD in
		1)
			local templates=$(
				find $TEMPLATES_HOME -type f | (
					while read line; do
						line=${line#$TEMPLATES_HOME/}
						line=${line%.*}
						echo $line
					done
				)
			)
			COMPREPLY=(`compgen -W "$templates" -- $cur`)
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
			compopt +o default
			;;
	esac
}

complete -F _comp_template template
