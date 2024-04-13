# Author  : ONJANIAINA Henintsoa Stephana
# Created : 13/04/24 11:40:57
# Repo : henintsoa98/dotfiles.debian12
# File : pl10k_patch.bash

sed -i "s/# battery/battery/" ~/.p10k.zsh
sed -i "s%typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}%# typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}%" ~/.p10k.zsh
sed -i "s%typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2%typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=7%" ~/.p10k.zsh
sed -i "s%typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0%typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=4%" ~/.p10k.zsh
sed -i "s%typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=2%typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=7%" ~/.p10k.zsh
sed -i "s%typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=0%typeset -g POWERLEVEL9K_STATUS_OK_PIPE_BACKGROUND=4%" ~/.p10k.zsh
