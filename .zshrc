# colors
cyan=%{$fg[cyan]%}
red=%{$fg[red]%}
green=%{$fg[green]%}
blue=%{$fg[blue]%}
# attributes

#aliases
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

precmd() {

    PROMPT="${cyan}%n@%m${red}%~ %{$reset_color%}$(git_super_status) ${green}%*%f
        ${blue}> "

}

source ~/Extras/zsh-history-substring-search/zsh-history-substring-search.zsh
