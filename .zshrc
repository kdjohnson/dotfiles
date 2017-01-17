precmd () {
	#Set options
	setopt PROMPT_SUBST 	#Used to set certain variables without recreating prompt
	setopt correctall	#Spelling corrections for commands and arguments
	setopt histignoredups	#Ignore duplicate commands in storing commands
	setopt extendedglob	#weird & wacky pattern matching

	vcs_info
}

#Zsh History information
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

#Auto completion
autoload -Uz compinit && compinit

#Prompt
autoload -U promptinit && promptinit; 
prompt fade red

#VC info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st git-remotebranch

### Display the existence of files not yet known to VCS

### git: Show marker (T) if there are untracked files in repository
# Make sure you have added staged to your 'formats':  %c

function +vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='%F{215}...%f'
    fi
}
### Compare local changes to remote changes

### git: Show +N/-N when your local branch is ahead-of or behind remote HEAD.
# Make sure you have added misc to your 'formats':  %m
function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "%F{green}+${ahead}%f" )

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "%F{red}-${behind}%f" )

    hook_com[misc]+="%F{cyan}${(j:/:)%fgitstatus}"
}

### git: Show remote branch name for remote-tracking branches

function +vi-git-remotebranch() {
    local remote

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    # The first test will show a tracking branch whenever there is one. The
    # second test, however, will only show the remote branch's name if it
    # differs from the local one.
    if [[ -n ${remote} ]] ; then
    #if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
        hook_com[branch]="${hook_com[branch]} [${remote}]"
    fi
}

zstyle ':vcs_info:*' stagedstr ' ✚ '
zstyle ':vcs_info:*' unstagedstr ' ● '
zstyle ':vcs_info:*' formats '%b %m%u%c'
zstyle ':vcs_info:*' actionformats '%b %m%u%c'


#Prompt
#Right hand side of prompt
RPROMPT='${vcs_info_msg_0_}'
#Left hand side of prompt
PS1='%B%K{208}%F{black}%n@%m%k%f:%K{green}%F{black}%~%k%f %% '


fpath=($HOME/.shellutils/zsh-completions $fpath)


source $HOME/Extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/Extras/zsh-history-substring-search/zsh-history-substring-search.zsh

# aliases
alias vim="vim -p"
alias ls="ls --color"
alias grep="grep --colour"
alias tree="tree -C"
#alias webapp=~/uportal/uportal/bin/webapp_cntl.sh
#
cd() {
    builtin cd "$@";
    ls --color;
}

#############
## zsh-history-bstring-search
##############
## bind UP and DOWN arrow keys
#zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
## bind UP and DOWN arrow keys (compatibility fallback
## for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
## bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
## ignore dups
setopt HIST_IGNORE_ALL_DUPS
##############



#############
#
#  WORK STUFF
#
#############


#export M2_HOME=/home/kajuan/uportal/maven
#export M2=$M2_HOME/bin
#export PATH=$M2:$PATH

#export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
#export PATH=$JAVA_HOME/bin:$PATH

#export ANT_HOME=/home/kajuan/uportal/ant
#export PATH=$PATH:$ANT_HOME/bin

#export TOMCAT_HOME=/home/kajuan/uportal/tomcat
#export PATH=$PATH:$TOMCAT_HOME
#export JAVA_OPTS="-server -XX:MaxPermSize=512m -Xms1024m -Xmx2048m"


#export GOPATH=/home/kajuan/GOPATH
#export GOBIN=$GOPATH/bin
#export PATH=$PATH:$GOBIN

# tomcat
#
#function tomcat {
#for i in "$@"; do
#    if [[ $i == "start" ]]; then
#        $TOMCAT_HOME/bin/startup.sh
#        tail -f $TOMCAT_HOME/logs/catalina.out
#    elif [[ $i == "stop" ]]; then
#        ps -ef | grep 'tomcat' | grep -v grep | awk '{print $2}' | xargs kill
#        kill -9 $(ps aux | grep 'tomcat' | awk '{print $2}')
#    elif [[ $i == "restart" ]]; then
#        ps -ef | grep 'tomcat' | grep -v grep | awk '{print $2}' | xargs kill
#        $TOMCAT_HOME/bin/startup.sh
#    elif [[ $i == "clean" ]]; then
#        rm -rf $TOMCAT_HOME/webapps/*
#        rm -rf $TOMCAT_HOME/work/Catalina/localhost/*
#        rm -rf $TOMCAT_HOME/temp/*
#        rm -rf $TOMCAT_HOME/logs/*.log
#        rm -rf $TOMCAT_HOME/logs/*.log*
#        rm -rf $TOMCAT_HOME/logs/*.txt
#        rm -rf $TOMCAT_HOME/logs/portal/*
#    elif [[ $i == "kill" ]]; then
#        ps -ef | grep 'tomcat' | grep -v grep | awk '{print $2}' | xargs kill
#    elif [[ $i == "status" ]]; then
#        ps aux | grep 'tomcat'
#    elif [[ $i == "webapps" ]]; then
#        cd $TOMCAT_HOME/webapps
#    elif [[ $i == "logs" ]]; then
#        cd $TOMCAT_HOME/logs
#    else
#        echo "whachu tryna do"
#    fi
#done
#}

# build uportal
#function uportal {
#for i in "$@"; do
#    if [[ $i == "start" ]]; then
#        tomcat stop
#        tomcat clean
#        cd $HOME/uportal/uportal
#        ant clean initportal && tomcat start
#    elif [[ $i == "base" ]]; then
#       cd $HOME/uportal/uportal
#   elif [[ $i == "pom" ]]; then
#        cd $HOME/uportal/uportal
#        vim pom.xml
#    else
#        echo "whachu tryna do"
#    fi
#done
#}

# M2
#function repo {
#for i in "$@"; do
#    if [[ $i == "clean" ]]; then
#        rm -rf $HOME/.m2/repository/*
#    else
#        echo "Wrong command"
#    fi
#done
#} 
