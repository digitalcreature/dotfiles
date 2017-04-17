# tgrehawi's shell shenanigans
My custom shell aliases n' stuff

## Dependencies
- git
- bash
- [jq](https://stedolan.github.io/jq/)
- python3

## Installation
1. Install dependencies
2. Clone this repo anywhere you want
3. Enter the repo, and run `install.sh`
4. You are done! `exec bash` to reload.

## Updates
To update local dotfiles, simply run:
```bash
$ dotfiles update
```
And reload bash via `$ exec bash`.

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
