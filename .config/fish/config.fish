set -g fish_greeting

if status is-interactive
    starship init fish | source
end

if command -v fastfetch &> /dev/null 
  fastfetch
end

# Detect AUR wrapper
if pacman -Qi paru >/dev/null 2>&1
    set -g aurhelper paru
else if pacman -Qi yay >/dev/null 2>&1
    set -g aurhelper yay
end

# Package installation function
function in --description 'Install packages from Arch repos or AUR'
    set -l inPkg $argv
    set -l arch
    set -l aur

    for pkg in $inPkg
        if pacman -Si $pkg >/dev/null 2>&1
            set -a arch $pkg
        else
            set -a aur $pkg
        end
    end

    if test (count $arch) -gt 0
        sudo pacman -S $arch
    end

    if test (count $aur) -gt 0
        $aurhelper -S $aur
    end
end

# List Directory
alias ls="exa --icons=auto" # short list
alias  l='eza -lh  --icons=auto' # long list
alias la='eza -a --icons=auto' # long list all
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all sorted
alias lt='eza --icons=auto --tree' # list folder as tree
alias n=nvim
alias c=clear
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

function cat
    # if file extension ends with .md or .mdx, use glow
    if string match -q "*.md" $argv
        glow $argv
    else if file --mime $argv | grep "png" || file --mime $argv | grep 'jpeg'
        kitty icat $argv
    # if it is a directory, use exa
    else if test -d $argv
        exa --icons -l $argv
    else
        bat --style=plain --theme ansi $argv
    end
end

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'
