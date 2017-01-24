# load secret for service from secrets file
# _loadsecret <service>
# if successful, stores username as $user and secret as $secret
# when calling, be sure to declare those variables local beforehand so the values dont leak
function _loadsecret {
	local service=$1
	if [[ ! $SECRETS_PATH ]]; then
		SECRETS_PATH="$DOTFILES_HOME/secrets"
	fi
	if [ -f $SECRETS_PATH ]; then
		auth=`awk 'tolower($1) == tolower("'$service'") {print; exit}' $SECRETS_PATH`
		if [[ $auth ]]; then
			user=`awk '{print $2}' <<< $auth`
			secret=`awk '{print $3}' <<< $auth`
			return 0
		fi
	fi
	return 1
}

# prompt user for username and secret for service
# same usage as _loadsecret
function _promptsecret {
	echo "Authenticate for $1:"
	user=
	secret=
	while [[ ! $user ]]; do
		read -erp "Username: " user
	done
	while [[ ! $secret ]]; do
		read -rsp "Secret: " secret
	done
	echo
}

# try to load the secret useing _loadsecret. on failure, prompt user using _promptsecret.
# same usage as those functions
# returns failed if secret had to be entered manually
function _tryloadsecret {
	if ! _loadsecret $@; then
		echo "Couldn't find authentication information for $1."
		echo "See $DOTFILES_HOME/README.md for details."
		_promptsecret $@
		return 1
	fi
	return 0
}
