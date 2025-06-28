# Created by newuser for 5.9

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt inc_append_history
setopt hist_ignore_space      # ignore commands that start with space

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  atload"unalias gf" \
  OMZP::git \
  OMZP::dotenv


# sharkdp/fd
zinit ice as"command" from"gh-r" sbin"fd"
zinit light sharkdp/fd

# sharkdp/bat
zinit ice as"command" from"gh-r" sbin"bat"
zinit light sharkdp/bat

# ogham/exa, replacement for ls
zinit ice wait"0" lucid from"gh-r" as"program" bpick"*linux*x86_64*" mv"bin/exa* -> exa" sbin"exa" atload"alias ls='exa --icons --group-directories-first'"
zinit light ogham/exa

zinit ice wait"0" lucid from"gh-r" as"program" ver"v13.0.0-alpha.0" sbin"tokei"
zinit light XAMPPRocky/tokei

zinit ice wait"0" lucid from"gh-r" as"program" atclone"./zoxide init zsh > init.zsh;" atpull"%atclone" src"init.zsh" sbin"zoxide"
zinit light ajeetdsouza/zoxide

zinit ice as"command" from"gh-r" mv"sd* -> sd" sbin"sd"
zinit light chmln/sd

zinit ice as"command" from"gh-r" sbin"rg"
zinit light BurntSushi/ripgrep

zinit ice as"command" from"gh-r" sbin"btm"
zinit light ClementTsang/bottom

zinit ice wait"0" lucid from"gh-r" as"program" atclone"./fnm env > init.zsh" atpull"%atclone" src"init.zsh" sbin"fnm"
zinit light Schniz/fnm

zinit ice as"command" from"gh-r" sbin"uv"
zinit light astral-sh/uv

zinit ice from"gh-r" as"command" atclone"./starship init zsh > init.zsh; ./starship completions zsh > _sharship" \
	atpull"%atclone" src"init.zsh" sbin"starship"
zinit light starship/starship

zinit ice from"gh-r" as"command" sbin"zellij"
zinit light zellij-org/zellij

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit snippet OMZP::per-directory-history/per-directory-history.zsh

export DEEPSEEK_API_KEY=sk-9a56dc5697e248348ca809b12b64cc6c
export PATH="$HOME/.foundry/bin:$HOME/.local/share/solana/install/active_release/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.ghcup/bin:$PATH"
export EDITOR=nvim

if [[ $(uname) == "Darwin" ]]; then
  # pnpm
  export PNPM_HOME="/Users/alanwang/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end
else
  # pnpm
  export PNPM_HOME="/home/alan/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end
fi
