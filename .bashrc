# Prompt
export PS1='\[\e[96m\]\W \[\e[92m\]\\$ \[\e[0m\]'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -lha --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Functions
function pretty_csv {
        column -t -s, -n "$@"| less -F -S -X -K
    }
function pretty_tsv {
	    column -t -s $'\t' -n "$@" | less -F -S -X -K
    }
function pretty_json {
	python -m json.tool "$@" | less
}
function sum_cols {
    awk '{for(i=1;i<=NF;i++)$i=(a[i]+=$i)}END{print}' "$@"
}
