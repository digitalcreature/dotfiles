# tgrehawi's shell shenanigans
My custom shell aliases n' stuff

## Dependencies
Available through apt and most other package managers:
- git
- bash

Manual install only:
- [jq](https://stedolan.github.io/jq/)
- [bash-it](https://github.com/Bash-it/bash-it)

## Installation
1. Install dependencies
2. `$ git clone git@github.com:tgrehawi/dotfiles ~/.dotfiles`
3. Add the following to the end of `~/.bashrc`:
```bash
export DOTFILES_HOME="$HOME/.dotfiles"
source $DOTFILES_HOME/bootstrap
```

## Authentication
Certain functions require secrets or access tokens in order to use certain APIs (such as the GitHub functions). In order to use such functions, authentication information must be supplied in a configuration file.

By default, this secrets file will be expected at `$DOTFILES_HOME/secrets`. If present in the default location, it will be ignored by git. If you want your secrets somewhere else, simply set `$SECRETS_PATH` to its location.

### Secrets File Format
Each service requiring authentication should be listed in the secrets file one per line, as follows:
```
service username secret
```
Example:
```
github tgrehawi i63q7wygufsda8f6n7yao397no8fyg32
gitlab tgrehawi i63q7wygufsda8f6n7yao397no8fyg32
tumblr tgrehawi iugkfhsdkg97boyq8328gfwifno2ryui
twitter tgrehawi oaiugkhsfjdghunkhmdfgniskuhdfgni
```
(Those are just keysmashes btw don't bother trying them)
