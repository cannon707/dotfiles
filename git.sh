##############
# Gup
##############

# pull, rebase, prune, fetch, clean up old branches
alias gup=$'git pull --rebase && git remote update origin --prune && git fetch -p -t -P && for branch in $(git for-each-ref \'%(refname) %(upstream:track)\' refs/heads | awk \'$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}\'); do git branch -D $branch; done'

# Creat the branch and set the upstream
gnew() {
  local branchName=$1
  git checkout -b $branchName
  git push --set-upstream origin $branchName
}

alias gs="git status"
alias grb="git rebase -i"
alias gcp="git cherry-pick -x"
alias gb="git branch"
alias co="git checkout"


