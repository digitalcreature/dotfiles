# github shell functions
source verbs.sh
source secrets.sh

alias github="_verb github"

# init current directory as a github repo
# github init [repo]
# [repo] defaults to name of current directory 

# create a new github repo
# github new <repo>
function _github_new {
	local usage="$parent new <repo>"
	repo=$1
	if [[ $repo ]]; then
		echo '{ "name": "'$repo'" }' | __github_api /user/repos POST
	else
		echo "usage: $usage"
		return 1
	fi
}

# add <repo> as a remote of the current repo
# github remote [remote] <repo>
# [remote] defaults to "origin"
function _github_remote {
	local usage="$parent remote [remote] <repo>"
	local remote="origin"
	local repo
	if [[ $2 ]]; then
		remote=$1
		repo=$2
	elif [[ $1 ]]; then
		repo=$1
	else
		echo "usage: $usage"
		return 1
	fi
	local user
	local secret
	if ! _loadsecret "GitHub"; then
		user=`whoami`
	fi
	git remote add $remote git@github.com:$user/$repo
}

function __github_api {
	local user
	local secret
	_tryloadsecret "GitHub"
	local url="https://api.github.com"$1
	local method=${2:-"GET"}
	local cmd='curl -u $user:$secret -X $method -H "Content-Type: application/json" --data @- $url'
	eval $cmd
}

# tab completion
function _comp_github {
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

complete -F _comp_github github
