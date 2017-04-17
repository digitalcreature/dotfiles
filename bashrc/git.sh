
# shell git aliases
alias gs='git status'

# git aliases
git config --global alias.grog "log --pretty=format:\"%s%n%C(black bold)commit %C(dim green)%h%Creset %C(black bold) by %C(white dim)%an%C(auto)%d\" --graph"
git config --global alias.checkrepo '!bash -c "git rev-parse --is-inside-work-tree &> /dev/null"'
