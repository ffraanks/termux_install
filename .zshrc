source "$HOME"/.aliases # My Aliases

# Powerlevel10k
#source ~/.projects/powerlevel10k/powerlevel10k.zsh-theme

# History ZSH
HISTFILE=~/.zhistory # My zsh history
HIST_SIVE=1000 # Size history list
SAVEHIST=500 # Size history list

# Plugins
#PLUGIN=(zsh-completion)
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh     # Plugin Syntax
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh      # Plugin Autosuggestions
source /data/data/com.termux/files/home/.projects/zsh-async/async.plugin.zsh

# Configurations
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]= r:|=' 'l:|=* r:|=*'
zstyle :compinstall filename '/data/data/com.termux/files/home'

autoload -Uz compinit
autoload -Uz async && async
compinit

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=true

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

# Functions
_my_prompt() {
	async_init

	# cache variable
	typeset -Ag prompt_data

	# section for dir
	function prompt_dir() {
		echo '%F{blue}%0~%f'
	}

	# section for git branch
	function prompt_git() {
		cd -q $1
		getbranch
	}

	# refresh prompt with new data
	prompt_refresh() {
		PROMPT="$prompt_data[prompt_git]$prompt_data[prompt_dir] %(?..%F{red})\$ %f"
		# Redraw the prompt.
		zle && zle .reset-prompt
	}

	prompt_callback() {
		local job=$1 code=$2 output=$3 exec_time=$4
		prompt_data[$job]=$output
		prompt_refresh
	}

	# Start async worker
	async_start_worker 'prompt' -n
	# Register callback function for the workers completed jobs
	async_register_callback 'prompt' prompt_callback

	# start async jobs before cmd
	prompt_precmd() {
		async_job 'prompt' prompt_dir
		async_job 'prompt' prompt_git $PWD # required
	}

	# Setup
	zmodload zsh/zle
	autoload -Uz add-zsh-hook
	add-zsh-hook precmd prompt_precmd
}

# entering calculator mode
bindkey -s '^a' 'bc -l\n'

# you can put as many files do you want
0x0() {
for i in "$@"; do
    curl -F file=@$i http://0x0.st
done
}

# you can put as many files do you want
envs() {
for i in "$@"; do
    curl -F file=@$i https://envs.sh/
done
}

# download file based on the clipboard
down() {
    aria2c "$(wl-paste 2>/dev/null || xclip -o 2>/dev/null)"
}

usage() {
    for p in "$@" ; do
        if pidof $p >/dev/null ; then
            RAM=$(echo $(ps -A --sort -rsz -o comm,rss | grep $p | sed -n 1p | sed 's/.* //g') / 1000 | bc)
            PRAM=$(ps -A --sort -rsz -o comm,pmem | grep $p | sed -n 1p | sed 's/.* //g')
            PCPU=$(ps -A --sort -rsz -o comm,pcpu | grep $p | sed -n 1p | sed 's/.* //g')
            echo "$p is using ${RAM}mb of RAM (${PRAM}%) and ${PCPU}% of CPU"
        else
            echo "$p is not running"
        fi
    done
}

printf "Bem vindo(a) ao zsh!!!\n"
