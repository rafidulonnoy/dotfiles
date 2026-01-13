if [ "$(tty)" = "/dev/tty1" ]; then
  exec start-hyprland
fi

# executing fastfetch on kitty startup
# if command -v fastfetch &> /dev/null; then
#   fastfetch --load-config ~/.config/fastfetch/arch.jsonc
# fi

# ohmyposh
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/atomic_mod.omp.json)"

# Starship
# eval "$(starship init zsh)"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

# Only changing the escape key to `jk` in insert mode, we still
# keep using the default keybindings `^[` in other modes
# ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^H' backword-kill-word

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Set the default editor
export EDITOR=nvim
export VISUAL=nvim
export PATH="/usr/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/share/bin:$HOME/.local/share/zinit/polaris/bin:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
export MANPATH="/usr/share/man:$MANPATH"

# Node Version Manager Uncomment it when needed
 export NVM_DIR="$HOME/.nvm"
# if !command -v nvm &> /dev/null; then
#   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# fi
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]]; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect AUR wrapper
if pacman -Qi paru &>/dev/null; then
  aurhelper="paru"
elif pacman -Qi yay &>/dev/null; then
  aurhelper="yay"
fi

function in {
  local -a inPkg=("$@")
  local -a arch=()
  local -a aur=()

  for pkg in "${inPkg[@]}"; do
    if pacman -Si "${pkg}" &>/dev/null; then
      arch+=("${pkg}")
    else
      aur+=("${pkg}")
    fi
  done

  if [[ ${#arch[@]} -gt 0 ]]; then
    sudo pacman -S "${arch[@]}"
  fi

  if [[ ${#aur[@]} -gt 0 ]]; then
    ${aurhelper} -S "${aur[@]}"
  fi
}

# Helpful aliases
alias  c='clear' # clear terminal
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all sorted
alias la='eza -a --icons=auto' # long list all
alias lt='eza --icons=auto --tree' # list folder as tree
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
# alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code' # gui code editor
alias n='nvim' # neovim
alias date='date "+%A, %d %B %Y %I:%M:%S %p"'
alias lf=yazi
alias vim=nvim
alias open='xdg-open'
alias td='glow ~/obsidian/2-MainNotes/Todo.md' # todo list
# alias fastfetch='fastfetch --load-config ~/.config/fastfetch/arch.jsonc'
pa() { $aurhelper -Ss --color=always "$@" | awk '/^[^[:space:]]/{if(b)a[i++]=b;b=$0;next}{b=b ORS $0}END{if(b)a[i++]=b;while(i--)print a[i]}'; }

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

# Shell integrations
# eval "$(fzf --zsh)"

# zoxide
eval "$(zoxide init zsh)"

# Automatically do an ls after each cd, z, or zoxide
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}

# Copy the contents of a file to the clipboard
copy()
{
  cat $1 | wl-copy
}
# Extracts any archive(s) (if unp isn't installed)
function extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# GitHub Titus Additions
function gcom() {
	git add .
	git commit -m "$1"
}
function lazyg() {
	git add .
	git commit -m "$1"
	git push
}
export NEXTCLOUD_PHP_CONFIG=/etc/webapps/nextcloud/php.ini
