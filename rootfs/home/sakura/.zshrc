# 🌸 SakLinux ZSH Config

# Prompt
PROMPT='%F{213}🌸 %F{206}%n%F{251}@%F{213}saklinux%F{251}:%F{141}%~%F{251}$%f '

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Aliases
alias ls='eza --icons 2>/dev/null || ls --color=auto'
alias ll='eza -la --icons 2>/dev/null || ls -la --color=auto'
alias cat='bat --paging=never 2>/dev/null || cat'
alias find='fd 2>/dev/null || find'
alias grep='rg 2>/dev/null || grep'
alias cd='z 2>/dev/null || cd'
alias sak='sakura'

# Plugins
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide
eval "$(zoxide init zsh 2>/dev/null)"

# FZF
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=bg+:#3b254f,bg:#1a1a2e,spinner:#FF69B4,hl:#FF1493,fg:#FFB7C5,pointer:#FF69B4'

# Welcome
echo ""
echo -e "\e[38;5;213m  🌸 Welcome to SakLinux!\e[0m"
echo ""
