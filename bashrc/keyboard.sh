source verbs.sh

# functions to enable/disable laptop keyboard
# these are only tested on ubuntu and my own toshiba satellite laptop

# prompt user with device list
# stores chosen device in $device
function _prompt_device {
	xinput --list
	echo
	while true; do
		read -rp "Choose device: " device
		if xinput --list-props $device &> /dev/null; then
			break
		else
			echo "Invalid device '$device'."
		fi
	done
}

alias keyboard="_verb keyboard"

# disable laptop keyboard
function _keyboard_disable {
	local device
	_prompt_device
	xinput --disable $device
}

# enable laptop keyboard
function _keyboard_enable {
	local device
	_prompt_device
	xinput --enable $device
}

# tab completion
function _comp_keyboard {
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

complete -F _comp_keyboard keyboard
