# tgrehawi's shell shenanigans
my custom shell aliases n stuff

## dependencies
available through apt and most other package managers:
- git
- bash

manual install only:
- [jq](https://stedolan.github.io/jq/)
- [bash-it](https://github.com/Bash-it/bash-it)

## installation
1. install dependencies
2. `$ git clone git@github.com:tgrehawi/dotfiles ~/.dotfiles`
3. add the following to the end of `~/.bashrc`:
```bash
export DOTFILES_HOME="$HOME/.dotfiles"
source $DOTFILES_HOME/bootstrap
```

## secrets
certain functions require secrets or access tokens in order to use certain apis (such as the github functions). in order to use such functions, make sure the secret required is present in the enviroment in the following form:
```
SERVICE_SECRET = <your secret/token/auth here>
```
where `SERVICE` is the name of the service/api (`GITHUB_SECRET` for github, `TUMBLR_SECRET` for tumblr, etc.)

if `secrets.sh` is present in the `$DOTFILES_HOME` (e.g. the root of the local repository), it will be sourced before all other dotfiles, and will be ignored by git.
