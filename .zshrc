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
alias tree="tree -C"
alias webapp=~/uportal/uportal/bin/webapp_cntl.sh

cd() {
    builtin cd "$@";
    ls;
}

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source ~/Extras/zsh-git-prompt/zshrc.sh

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

precmd() {

    PROMPT="${cyan}%n@%n${red}%~ %{$reset_color%}$(git_super_status) ${green}%*%f
    ${blue}> "

}

export M2_HOME=/Users/kajuan/uportal/maven
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home"
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
        tail -f $TOMCAT_HOME/logs/catalina.out
    elif [[ $i == "stop" ]]; then
        ps -ef | grep 'tomcat' | grep -v grep | awk '{print $2}' | xargs kill
        kill -9 $(ps aux | grep 'tomcat' | awk '{print $2}')
    elif [[ $i == "restart" ]]; then
        ps -ef | grep 'tomcat' | grep -v grep | awk '{print $2}' | xargs kill
        $TOMCAT_HOME/bin/startup.sh
    elif [[ $i == "clean" ]]; then
        rm -rf $TOMCAT_HOME/webapps/*
        rm -rf $TOMCAT_HOME/work/Catalina/localhost/*
        rm -rf $TOMCAT_HOME/temp/*
        rm -rf $TOMCAT_HOME/logs/*.log
        rm -rf $TOMCAT_HOME/logs/*.log*
        rm -rf $TOMCAT_HOME/logs/*.txt
        rm -rf $TOMCAT_HOME/logs/portal/*
    elif [[ $i == "kill" ]]; then
        ps -ef | grep 'tomcat' | grep -v grep | awk '{print $2}' | xargs kill
    elif [[ $i == "status" ]]; then
        ps aux | grep 'tomcat'
    elif [[ $i == "webapps" ]]; then
        cd $TOMCAT_HOME/webapps
    elif [[ $i == "logs" ]]; then
        cd $TOMCAT_HOME/logs
    else
        echo "whachu tryna do"
    fi
done
}

# build uportal
function uportal {
for i in "$@"; do
    if [[ $i == "start" ]]; then
        tomcat stop
        tomcat clean
        cd $HOME/uportal/uportal
        ant clean initportal && tomcat start
    elif [[ $i == "base" ]]; then
        cd $HOME/uportal/uportal
    elif [[ $i == "pom" ]]; then
        cd $HOME/uportal/uportal
        vim pom.xml
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

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
