# oh-my-zsh Bureau Theme

### NVM

ZSH_THEME_NVM_PROMPT_PREFIX="%B⬡%b "
ZSH_THEME_NVM_PROMPT_SUFFIX=""

### Git [±master ▾●]

ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[green]%}±%{$reset_color%}%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

bureau_git_info () {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

bureau_git_status() {
  local result gitstatus
  gitstatus="$(command git status --porcelain -b 2>/dev/null)"

  # check status of files
  local gitfiles="$(tail -n +2 <<< "$gitstatus")"
  if [[ -n "$gitfiles" ]]; then
    if [[ "$gitfiles" =~ $'(^|\n)[AMRD]. ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_STAGED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n).[MTD] ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNSTAGED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n)\\?\\? ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    fi
    if [[ "$gitfiles" =~ $'(^|\n)UU ' ]]; then
      result+="$ZSH_THEME_GIT_PROMPT_UNMERGED"
    fi
  else
    result+="$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi

  # check status of local repository
  local gitbranch="$(head -n 1 <<< "$gitstatus")"
  if [[ "$gitbranch" =~ '^## .*ahead' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if [[ "$gitbranch" =~ '^## .*behind' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if [[ "$gitbranch" =~ '^## .*diverged' ]]; then
    result+="$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  # check if there are stashed changes
  if command git rev-parse --verify refs/stash &> /dev/null; then
    result+="$ZSH_THEME_GIT_PROMPT_STASHED"
  fi

  echo $result
}

bureau_git_prompt() {
  # check git information
  local gitinfo=$(bureau_git_info)
  if [[ -z "$gitinfo" ]]; then
    return
  fi

  # quote % in git information
  local output="${gitinfo:gs/%/%%}"

  # check git status
  local gitstatus=$(bureau_git_status)
  if [[ -n "$gitstatus" ]]; then
    output+=" $gitstatus"
  fi

  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${output}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}


_PATH=" %{$fg_bold[black]%}%~ "

if [[ $EUID -eq 0 ]]; then
  _USERNAME=" %{$fg_bold[red]%}%n "
#  _LIBERTY="%{$fg[red]%}#"
  _LIBERTY="#"
else
  _USERNAME=" %{$fg_bold[black]%}%n "
#  _LIBERTY="%{$fg[green]%}$"
  _LIBERTY="$"
fi
_USERNAME="$_USERNAME%{$reset_color%}%{$bg[yellow]%}%{$fg_bold[black]%} %m %{$reset_color%}"
#_LIBERTY="$_LIBERTY%{$reset_color%}"

get_space () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=$(( COLUMNS - LENGTH - ${ZLE_RPROMPT_INDENT:-1} ))

  (( SPACES > 0 )) || return
  printf '─%.0s' {1..$SPACES}
}

_1LEFT="%{$bg[black]$fg[white]%}░▓%{$bg[white]%}$_USERNAME%{$reset_color%}%{$bg[cyan]%}$_PATH%{$bg[black]$fg[cyan]%}▓░%{$reset_color%}"
#_1RIGHT="[%*]"
_1RIGHT_A="%{$bg[black]$fg[cyan]%}░▓"
_1RIGHT_B="%{$bg[yellow]$fg_bold[black]%} %l %{$bg[black]$fg[yellow]%}▓░%{$reset_color%}"

DAATA='%l'

bureau_precmd () {

_ZSH_BAT_CAP=$(cat /sys/class/power_supply/*/capacity)
_ZSH_BAT_STAT=$(cat /sys/class/power_supply/*/status)
[[ $_ZSH_BAT_CAP -ge 0 && $_ZSH_BAT_CAP -lt 10 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰂎 "
[[ $_ZSH_BAT_CAP -ge 10 && $_ZSH_BAT_CAP -lt 20 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰁺 "
[[ $_ZSH_BAT_CAP -ge 20 && $_ZSH_BAT_CAP -lt 30 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰁻 "
[[ $_ZSH_BAT_CAP -ge 30 && $_ZSH_BAT_CAP -lt 40 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰁼 "
[[ $_ZSH_BAT_CAP -ge 40 && $_ZSH_BAT_CAP -lt 50 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰁽 "
[[ $_ZSH_BAT_CAP -ge 50 && $_ZSH_BAT_CAP -lt 60 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰁾 "
[[ $_ZSH_BAT_CAP -ge 60 && $_ZSH_BAT_CAP -lt 70 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰁿 "
[[ $_ZSH_BAT_CAP -ge 70 && $_ZSH_BAT_CAP -lt 80 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰂀 "
[[ $_ZSH_BAT_CAP -ge 80 && $_ZSH_BAT_CAP -lt 90 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰂁 "
[[ $_ZSH_BAT_CAP -ge 90 && $_ZSH_BAT_CAP -lt 100 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰂂 "
[[ $_ZSH_BAT_CAP -eq 100 && "$_ZSH_BAT_STAT" == "Discharging" ]] && _ZSH_BAT_PRE="󰁹"
[[ $_ZSH_BAT_CAP -ge 0 && $_ZSH_BAT_CAP -lt 10 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰢟 "
[[ $_ZSH_BAT_CAP -ge 10 && $_ZSH_BAT_CAP -lt 20 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰢜 "
[[ $_ZSH_BAT_CAP -ge 20 && $_ZSH_BAT_CAP -lt 30 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰂆 "
[[ $_ZSH_BAT_CAP -ge 30 && $_ZSH_BAT_CAP -lt 40 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰂇 "
[[ $_ZSH_BAT_CAP -ge 40 && $_ZSH_BAT_CAP -lt 50 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰂈 "
[[ $_ZSH_BAT_CAP -ge 50 && $_ZSH_BAT_CAP -lt 60 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰢝 "
[[ $_ZSH_BAT_CAP -ge 60 && $_ZSH_BAT_CAP -lt 70 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰂉 "
[[ $_ZSH_BAT_CAP -ge 70 && $_ZSH_BAT_CAP -lt 80 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰢞 "
[[ $_ZSH_BAT_CAP -ge 80 && $_ZSH_BAT_CAP -lt 90 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰂊 "
[[ $_ZSH_BAT_CAP -ge 90 && $_ZSH_BAT_CAP -lt 100 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰂋 "
[[ $_ZSH_BAT_CAP -eq 100 && "$_ZSH_BAT_STAT" == "Charging" ]] && _ZSH_BAT_PRE="󰂅"

_ZSH_BAT="%{$bg[cyan]$fg_bold[black]%} $_ZSH_BAT_PRE$_ZSH_BAT_CAP%% %{$reset_color%}"
 _1SPACES=`get_space ------$_1LEFT$_1RIGHT_A$_1RIGHT_B`


[[ "$_ZSH_BAT_CAP" == "" ]] && _ZSH_BAT="" && _1RIGHT_A="%{$bg[black]$fg[yellow]%}░▓" && _1SPACES=`get_space $_1LEFT$_1RIGHT_A$_1RIGHT_B`

  print
  print -rP "$_1LEFT%{$fg_bold[yellow]%}$_1SPACES$_1RIGHT_A$_ZSH_BAT$_1RIGHT_B"
}

_STAT="%(?:%{$fg_bold[green]%}$_LIBERTY > :%{$fg_bold[red]%}$_LIBERTY > )%{$reset_color%}"

setopt prompt_subst
PROMPT='$_STAT'
RPROMPT='$(nvm_prompt_info) $(bureau_git_prompt) %(?:%{$fg_bold[green]%}%?:%{$fg_bold[red]%}%?)%{$fg_bold[white]%}|%! %{$bg[black]%}%{$fg_bold[yellow]%}󰥔 %D{%L:%M:%S %p}%{$reset_color%}'

autoload -U add-zsh-hook
add-zsh-hook precmd bureau_precmd
