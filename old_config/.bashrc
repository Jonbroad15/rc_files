# ~/.bashrc: executed by bash(1) for non-login shells
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
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
function jbqsub {
    qsub -m beas -M jbroadbent@oicr.on.ca -cwd -V -P simpsonlab -l h_vmem=8G -l h_rt=2:0:0:0 "$@"
}
function peqsub {
    qsub -m beas -M jbroadbent@oicr.on.ca -cwd -V -P simpsonlab -l h_vmem=2G -pe smp 8 -l h_rt=2:0:0:0 "$@"
}
function grch38 {
    samtools faidx ~/simpsonlab/data/references/GRCh38_no_alt_analysis_set.GCA_000001405.15.fna $1:$2-$3
}
function grch37 {
    samtools faidx ~/simpsonlab/data/references/hg19.fa $1:$2-$3
}
function sum_cols {
    awk '{for(i=1;i<=NF;i++)$i=(a[i]+=$i)}END{print}' "$@"
}
function scp_oicr {
    scp simpsonlab-hn.hpc.oicr.on.ca:$@ .
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/.mounts/labs/simpsonlab/users/jbroadbent/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/.mounts/labs/simpsonlab/users/jbroadbent/miniconda/etc/profile.d/conda.sh" ]; then
        . "/.mounts/labs/simpsonlab/users/jbroadbent/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/.mounts/labs/simpsonlab/users/jbroadbent/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/.mounts/labs/simpsonlab/users/jbroadbent/miniconda/etc/profile.d/mamba.sh" ]; then
    . "/.mounts/labs/simpsonlab/users/jbroadbent/miniconda/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
if [ -e /.mounts/labs/simpsonlab/etc/lab.bashrc ]; then
    source /.mounts/labs/simpsonlab/etc/lab.bashrc
fi


# Aliases
alias SSH="ssh simpsonlab-hn.hpc.oicr.on.ca"
alias qrshdefault="qrsh -P simpsonlab -l h_rt=20:00:00:00 -l h_vmem=8G  -V -l h_stack=32M"
alias buildnode="qrsh -P simpsonlab -l h_rt=20:00:00:00 -l h_vmem=8G -V -q u18build"
alias printpath="sed 's/:/\n/g' <<< "$PATH""
alias vim="nvim"
alias ll="ls -lh"
export NANOPORE_CFDNA="/.mounts/labs/simpsonlab/users/jbroadbent/code/cfdna/nanopore_cfdna/"
export NF_DEV="/.mounts/labs/simpsonlab/users/jbroadbent/code/cfdna/nf_dev/"
export NFWORKDIR="/scratch2/groups/simpsonlab/jbroadbent/nfworkdirs"
export ATLASES="/.mounts/labs/simpsonlab/users/jbroadbent/projects/methylation_deconvolution/atlases"
export REFERENCE="mounts/labs/simpsonlab/data/references/GRCh38_no_alt_analysis_set.GCA_000001405.15.fna"


#PATH
export PATH="/.mounts/labs/simpsonlab/users/jbroadbent/bin:$PATH"
export PATH="/.mounts/labs/simpsonlab/users/jbroadbent/bin/bin:$PATH"
export PATH="/.mounts/labs/simpsonlab/users/jbroadbent/projects/methylation_deconvolution/atlases:$PATH"
export PATH="/.mounts/labs/simpsonlab/users/jbroadbent/code/cfdna/nfdev/scripts:$PATH"
export PATH="$PATH:~/.bin"
export PATH="$PATH:/.mounts/labs/simpsonlab/users/jbroadbent/bin/devtainer/bin/.local/bin/"
export PATH="/.mounts/labs/simpsonlab/users/jbroadbent/bin/ctags-5.8:$PATH"


#More Paths
export PKG_CONFIG_PATH="$HOME/lib/pkgconfig:$PKG_CONFIG_PATH"

# Prompt
export PS1="\h:\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
. "/.mounts/labs/simpsonlab/users/jbroadbent/downloads/~/jbroadbent/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
/.mounts/labs/simpsonlab/users/jbroadbent/bin/devtainer/bin/.local/bin/ta

# Module
conda activate py39

