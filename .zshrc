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

alias clang-format=clang-format-4.0
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

    hook_com[misc]+="${(j:/:)gitstatus}"
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

zstyle ':vcs_info:*' stagedstr ' %F{034}✚%f '
zstyle ':vcs_info:*' unstagedstr ' %F{196}●%f '
zstyle ':vcs_info:*' formats '%F{069}%b%f %u%c'
zstyle ':vcs_info:*' actionformats '%F{069}%b%f %u%c'


#Prompt
#Right hand side of prompt
RPROMPT='${vcs_info_msg_0_}'
#Left hand side of prompt
PS1='%B%K{064}%F{white}%n@%m%k%f:%K{064}%F{white}%~%k%f
λ '


fpath=($HOME/Extras/zsh-completions/src $fpath)


source $HOME/Extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/Extras/zsh-history-substring-search/zsh-history-substring-search.zsh

# aliases
alias vim="vim -p"
alias ls="ls --color"
alias grep="grep --colour"
alias tree="tree -C"
alias webapp=~/uportal/uportal/bin/webapp_cntl.sh
alias nvim=~/nvim.appimage
#
cd() {
    builtin cd "$@";
    exa;
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


export M2_HOME=/home/kajuan/uportal/maven
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export PATH=$JAVA_HOME/bin:$PATH

export ANT_HOME=/home/kajuan/uportal/ant
export PATH=$PATH:$ANT_HOME/bin

export CATALINA_HOME=/home/kajuan/uportal/tomcat
export PATH=$PATH:$CATALINA_HOME

export TOMCAT_HOME=/home/kajuan/uportal/tomcat
export PATH=$PATH:$TOMCAT_HOME
export JAVA_OPTS="-server -XX:MaxPermSize=512m -Xms1024m -Xmx2048m"


export GOPATH=/home/kajuan/GOPATH
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/opt/gradle/gradle-4.0.1/bin

export PORTAL_HOME=~/portal

#########
# tomcat
#########

function tomcat {
  for i in "$@"; do
    if [[ $i == "start" ]]; then
      $TOMCAT_HOME/bin/startup.sh
      tail -f $TOMCAT_HOME/logs/catalina.out
    elif [[ $i == "stop" ]]; then
      for pid in $(ps -ef | grep "[t]omcat" | awk '{print $2}'); do kill -9 $pid; done
    elif [[ $i == "clean" ]]; then
      for pid in $(ps -ef | grep "[t]omcat" | awk '{print $2}'); do kill -9 $pid; done
          rm -rf $TOMCAT_HOME/logs/* 
          rm -rf $TOMCAT_HOME/webapps/*
          rm -rf $TOMCAT_HOME/work/*
          rm -rf $TOMCAT_HOME/temp/*
    elif [[ $i == "status" ]]; then
      ps aux | grep -v 'grep' | grep '[t]omcat'
    elif [[ $i == "logs" ]]; then
      cd ~/uportal/tomcat/logs
    elif [[ $i == 'webapps' ]]; then
      cd ~/uportal/tomcat/webapps
    elif [[ $i == "kill" ]] then
      for pid in $(ps -ef | grep "[t]omcat" | awk '{print $2}'); do kill -9 $pid; done
    else
      echo "please type start, stop, clean, or status"
    fi  
  done
}


#########
# uportal
#########

function uportal {
  for i in "$@"; do
    if [[ $i == "start" ]]; then
      tomcat kill
      tomcat clean
      cd $HOME/uportal/uportal
      ant -logger org.apache.tools.ant.listener.AnsiColorLogger clean initportal && tomcat start
    elif [[ $i == "home" ]]; then
      cd $HOME/uportal/uportal
    elif [[ $i == "pom" ]]; then
      cd $HOME/uportal/uportal
      vim pom.xml
    else
      echo "whachu tryna do"
    fi
  done
}


function portlets {
    for i in "$@"; do
        if [[ $i == "home" ]]; then
            cd $HOME/uportal/portlets 
        elif [[ $i == "courses" ]]; then
            cd $HOME/uportal/portlets/CoursesPortlet
        elif [[ $i == "mydetails" ]]; then
            cd $HOME/uportal/portlets/MyDetailsPortlet
        elif [[ $i == "ptod" ]]; then
            cd $HOME/uportal/portlets/progress-to-degree
        else
            echo "whachu tryna do"
        fi
    done
}

#########
# repo
#########

function repo {
for i in "$@"; do
    if [[ $i == "clean" ]]; then
        rm -rf $HOME/.m2/repository/*
    else
        echo "Wrong command"
    fi
done
} 


##############
# quickDeploy
##############
function quickDeploy {
  if mvn clean package -Dfilters.file=/home/$USER/uportal/uportal/filters/local.properties; then
      sleep 5
      WARPATH=`readlink -f $(find . -name '*.war' -type f)`
      cd ~/uportal/uportal
      sleep 5
      ant deployPortletApp -DportletApp=$WARPATH
      cd -   
  fi
}

function gradleDeploy {
  if gradle clean build -Dfilters=/home/$USER/uportal/uportal/filters/local.properties; then 
    sleep 1
    WARPATH=`readlink -f $(find . -name '*.war' -type f)`
    cd ~/uportal/uportal
    sleep 1
    ant deployPortletApp -DportletApp=$WARPATH
    echo $WARPATH
    cd -   
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
