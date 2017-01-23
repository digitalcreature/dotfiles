
# general utility stuff

# ao: 'atom open'
# usage: <command> | ao
# opens all files listed by output of <command> in atom
# 	(very useful when using template.sh; `template lua/class Foo | ao`
# 	will create a new file from the 'lua.class' template and open it)
alias ao="xargs atom"
