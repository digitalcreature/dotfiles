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
		auth=`awk '$1 == "'$service'" {print; exit}' $SECRETS_PATH`
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
		read -ersp "Secret: " secret
	done
	echo
}
