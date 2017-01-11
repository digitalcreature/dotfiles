# github shell functions
source verbs.sh
source secrets.sh

function github {
	local user
	local secret
	_verb github $@
}

# init current directory as a github repo
# github init [repo]
# [repo] defaults to name of current directory
function _github_init {
	local usage="$parent init [repo]"
	local repo=$1
	if [[ ! $repo ]]; then
		repo=${PWD%/}
		repo=${repo##*/}
	fi
	if ! git checkrepo; then
		git init
	fi
	_github_new $repo &&
	_github_remote $repo
}

# create a new github repo
# github new <repo>
function _github_new {
	local usage="$parent new <repo>"
	repo=$1
	if [[ $repo ]]; then
		__github_auth
		echo "Creating GitHub repo $user/$repo"
		echo '{ "name": "'$repo'" }' | __github_api /user/repos POST | jq '{"name": .full_name, "url": .html_url, "error": .message}'
	else
		echo "usage: $usage"
		return 1
	fi
}

# delete a github repo
# github delete <repo>
# requires user to enter password
function _github_delete {
	local usage="$parent delete <repo>"
	repo=$1
	if [[ $repo ]]; then
		echo "You are trying to delete GitHub repo '$repo'."
		__github_auth_requirepassword
		echo '{}' | __github_api /repos/$user/$repo DELETE | jq '{"error": .message}'
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
		echo "No authentication found, using login '$user' as GitHub username."
	fi
	repo="git@github.com:$user/$repo"
	local cmd="git remote add $remote $repo"
	echo ' $ '$cmd
	eval $cmd
}

# make a github api call
# __github_api <uri> [method]
# [method] defaults to GET
function __github_api {
	local url="https://api.github.com"$1
	local method=${2:-"GET"}
	curl -u $user:$secret -X $method -H "Content-Type: application/json" --data @- $url 2> /dev/null
}

# authenticate user using secret file
# writes username to $user and secret to $secret (declared local in root function)
function __github_auth {
	_tryloadsecret "GitHub"
}

# authenticate user using secret file, but require manual password entry
# used for dangerous stuff like deleting repos so that i dont fuck up and delete things by mistake
function __github_auth_requirepassword {
	if __github_auth; then
		secret=
		echo "Manual authentication required. Enter GitHub password for user $user:"
		while [[ ! $secret ]]; do
			read -rsp "Password: " secret
			echo
		done
	fi
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
