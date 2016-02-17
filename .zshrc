# colors
cyan=%{$fg[cyan]%}
red=%{$fg[red]%}
green=%{$fg[green]%}
blue=%{$fg[blue]%}
# attributes

# aliases
alias vim="vim -p"
alias ls="ls -G"
alias grep="grep --colour"

cd() {
    builtin cd "$@";
    ls;
}

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source ~/Extras/zsh-git-prompt/zshrc.sh

source ~/Extras/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

precmd() {

    PROMPT="${cyan}%n@%m${red}%~ %{$reset_color%}$(git_super_status) ${green}%*%f
        ${blue}> "

}

export M2_HOME=/Users/kajuan/uportal/maven
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home"
export PATH=$JAVA_HOME/bin:$PATH

export ANT_HOME=/Users/kajuan/uportal/ant
export PATH=$PATH:$ANT_HOME/bin

export TOMCAT_HOME=/Users/kajuan/uportal/tomcat
export PATH=$PATH:$TOMCAT_HOME
export JAVA_OPTS="-server -XX:MaxPermSize=512m -Xms1024m -Xmx2048m"

# tomcat
function tomcat {
for i in "$@"; do
    if [[ $i == "start" ]]; then
        $TOMCAT_HOME/bin/startup.sh
    elif [[ $i == "stop" ]]; then
        kill -9 $(ps aux | grep 'tomcat' | awk '{print $2}')
        sleep 5
    elif [[ $i == "restart" ]]; then
        kill -9 $(ps aux | grep 'tomcat' | awk '{print $2}') &&
        sleep 10
        $TOMCAT_HOME/bin/startup.sh
    elif [[ $i == "clean" ]]; then
        rm -rf $TOMCAT_HOME/webapps/*
        rm -rf $TOMCAT_HOME/work/Catalina/localhost/*
        rm -rf $TOMCAT_HOME/temp/*
    elif [[ $i == "kill" ]]; then
        ps -ef | grep "tomcat" | awk '{print $2}' | grep -v 'grep' | xargs kill
    elif [[ $i == "status" ]]; then
        ps aux | grep 'tomcat'
    else
        echo "whachu tryna do"
    fi
done
}

# M2
function repo {
for i in "$@"; do
    if [[ $i == "clean" ]]; then
        rm -rf $HOME/.m2/repository/*
    else
        echo "Wrong command"
    fi
done
} 

source ~/Extras/zsh-history-substring-search/zsh-history-substring-search.zsh
