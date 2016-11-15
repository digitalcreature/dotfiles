source verbs.sh
source template.sh

function u3d {
	local usage="u3d <verb> [args]"
	_verb u3d $@
}

function _u3d_mb {
	local usage="$parent mb <path>"
	_template unity/mb $1
}
