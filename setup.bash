# Author  : ONJANIAINA Henintsoa Stephana
# Created : 20/03/24 23:12:45
# Repo : henintsoa98/dotfiles.debian12
# File : setup.bash

source BIN/color

CONFIG=$HOME/.config
BIN=/usr/local/bin

PARAM ()
{
	case "$1" in
		"kitty")
			mkdir -p $CONFIG/kitty
			cp CONFIG/kitty.conf $CONFIG/kitty;;
		"wofi")
			mkdir -p $CONFIG/wofi
			cp CONFIG/wofi.css $CONFIG/wofi/style.css;;
		"waybar")
			mkdir -p $CONFIG/waybar
			cp CONFIG/waybar.conf $CONFIG/waybar/config
			cp CONFIG/waybar.css $CONFIG/waybar/style.css
			sudo cp BIN/hyprland-workspace $BIN
			sudo cp BIN/hyprland-diskio $BIN
			sudo chmod a+x $BIN/hyprland-workspace
			sudo chmod a+x $BIN/hyprland-diskio;;
		"light")
			sudo usermod -aG video $USER
			sudo chgrp video /sys/class/backlight/*/brightness
			sudo chmod 664 /sys/class/backlight/*/brightness
			sudo light -N 1
			light -N 1;;
		"pcmanfm")
			INSTALL lxappearance LXDE GTK+ ${BYellow}theme switcher${Reset};;
		"zsh")
			INSTALL REC git \(zsh dependencies\) fast, scalable, distributed ${BYelow}revision control system${Reset}
			INSTALL REC figlet \(zsh dependencies\) Make ${BYellow}large character ASCII banners${Reset} out of ordinary text
			INSTALL REC lolcat \(zsh dependencies\) ${BYellow}colorful cat${Reset}
			sudo mkdir -p /usr/share/figlet/
			sudo cp SOURCE/*.flf /usr/share/figlet/
			#oh-my-zsh
			[[ -f "$HOME/.zshrc" ]] && mv $HOME/.zshrc $HOME/.zshrc$DATE
			[[ -d "$HOME/.oh-my-zsh" ]] && mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh$DATE
			git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
			cp $HOME/.oh-my-zsh/templates/zshrc.zsh-template $HOME/.zshrc
			#plugins
			git clone --depth 1 https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
			sed -i 's#source#fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src\nsource#' $HOME/.zshrc
			git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
			git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
			#theme
			git clone --depth 1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
			echo -ne "${BRed}Select theme [1|powerlevel|'default'|Y|y or 2|henintsoa|'other' ] : ${BRed}"
			read ANS
			echo -e ${Reset}
			case $ANS in
				""|"Y"|"y"|"powerlevel"|"default"|"1")
					sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="powerlevel10k/powerlevel10k"#' $HOME/.zshrc;;
				*)
					sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="bureau-henintsoa"#' $HOME/.zshrc;;
			esac
			sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting web-search command-not-found dirhistory timer)/' $HOME/.zshrc
			chsh -s $(which zsh)
			[[ -f "$HOME/.CUSTOMRC" ]] && cp $HOME/.CUSTOMRC $HOME/.CUSTOMRC$DATE
			cp CONFIG/CUSTOMRC $HOME/.CUSTOMRC
			cp CONFIG/bureau-henintsoa.zsh-theme $HOME/.oh-my-zsh/custom/themes/
			echo "source \$HOME/.CUSTOMRC" >> $HOME/.zshrc;;
		"vim")
			vimplug ()
			{
				LINK=$1
				if [[ "$2" ]]; then
					CLASS="$2"
					mkdir -p $HOME/.vim/pack/$CLASS/start
				else
					CLASS="defaults"
				fi
				REPO=$(echo "$1" | sed "s#/# #" | awk '{print $2}')
				DIR="$HOME/.vim/pack/$CLASS/start/$REPO"
				if [ -d "$DIR" ]; then
					echo "$REPO already exist in $CLASS"
				else
					git clone --depth 1 https://github.com/$LINK $HOME/.vim/pack/$CLASS/start/$REPO
				fi
			}
			[[ -f "$HOME/.vimrc" ]] && mv $HOME/.vimrc $HOME/.vimrc$DATE
			[[ -d "$HOME/.vim" ]] && mv $HOME/.vim $HOME/.vim$DATE
			mkdir -p $HOME/.vim/pack
			cp CONFIG/vimrc $HOME/.vimrc
			# BASE
			vimplug vim-airline/vim-airline look
			vimplug preservim/nerdtree look
			vimplug ryanoasis/vim-devicons look
			vimplug ctrlpvim/ctrlp.vim look
			vimplug mg979/vim-visual-multi dev
			vimplug preservim/tagbar dev
			vimplug preservim/vim-markdown look
			# RUST
			vimplug rust-lang/rust.vim rust
			vimplug vim-syntastic/syntastic rust
			# SNIPPET
			vimplug honza/vim-snippets snippets
			vimplug garbas/vim-snipmate snippets
			vimplug MarcWeber/vim-addon-mw-utils snippets
			vimplug tomtom/tlib_vim snippets;;
		"emacs")
			cp CONFIG/emacs $HOME/.emacs
			mkdir -p $HOME/.emacs.snippets
			cp -r CONFIG/emacs.snippets/* $HOME/.emacs.snippets
			echo -e "${BPurple}after running emacs for first time, it will install some package, and wait until it finished."
			echo -e "exit it and copy CONFIG/doom-henintsoa-theme.el to .emacs.d/elpa/doom-themes-<some date>/"
			echo -e "<alt-x> customize-themes, and select this theme, and save to next session${Reset}";;
		"network-manager")
			INSTALL REC iw \(network-manager dependencies\) tool "for" ${BYellow}configuring${Reset} Linux ${BYellow}wireless devices${Reset}
			INSTALL REC wireless-tools \(network-manager dependencies\) Tools "for" manipulating Linux ${BYellow}Wireless Extensions${Reset};;
		"MINIMAL")
			INSTALL REC alsa-utils \(MINIMAL dependencies\) Utilities "for" configuring and using ${BYellow}ALSA${Reset}
			
			INSTALL asciinema \(MINIMAL dependencies\) ${BYellow}Record and share your terminal sessions${Reset}, the right way
			
			INSTALL REC command-not-found \(MINIMAL dependencies\) ${BYellow}Suggest installation of packages${Reset} in interactive bash sessions
			
			INSTALL REC curl \(MINIMAL dependencies\) command line tool "for" transferring data with URL syntax

			INSTALL mdp \(MINIMAL dependencies\) command-line based ${BYellow}Markdown presentation tool${Reset}
			
			INSTALL REC network-manager \(MINIMAL dependencies\) ${BYellow}network management${Reset} framework \(daemon and userspace tools\)
			
			INSTALL REC ssh \(MINIMAL dependencies\) ${BYellow}secure shell${Reset} client and server \(metapackage\)
			
			INSTALL REC sshfs \(MINIMAL dependencies\) filesystem client based on ${BYellow}SSH File Transfer${Reset} Protocol
			
			INSTALL REC tealdeer \(MINIMAL dependencies\) ${BYellow}simplified, example${Reset} based and community-driven ${BYellow}man pages${Reset}
			
			INSTALL REC unzip \(MINIMAL dependencies\) ${BYellow}De-archiver "for" .zip${Reset} files	
			
			INSTALL REC progress \(MINIMAL dependencies\) Coreutils ${BYellow}Progress Viewer${Resset} \(formerly known as cv\)
			;;
	esac
}

INSTALL ()
{
	if [[ "$1" == "REC" ]]; then
		APP="$2"
		DES=$(echo "$@" |sed "s/^REC $APP//")
		REC="${BCyan}[RECOMMANDED] ${BYellow}>${Reset}"
	else
		APP="$1"
		DES=$(echo "$@" |sed "s/$APP//")
		REC="${BYellow}>${Reset}"
	fi

	EXIST=$(cat .apt-installed | grep "^$APP$")
	if [[ "$EXIST" ]]; then
		echo -e "${BCyan}$APP${Reset} already installed.\n"
		if [[ "$STATE" == "UPDATE" ]]; then
			PARAM $APP
		fi
	else
		echo -ne "${BRed}$APP ${REC}$DES (yn) : ${BRed}"

		read ANS
		echo -e ${Reset}
		case $ANS in
			""|"Y"|"y")
				if [[ "$APP" == "MINIMAL" ]]; then
					echo "Go !!!"
				else
					sudo apt install $APP
				fi
				PARAM $APP;;
		esac
	fi

}

echo -e "${BPurple}Select some package to make Hyprland more useful 😉${Reset}"

cd SOURCE
mkdir -p $HOME/.fonts
tar -xJf CodeNewRoman.tar.xz
mv *.otf $HOME/.fonts
cd ..

sudo cp BIN/{wifi,modem,color,apt-installed} $BIN
sudo chmod +x $BIN/{wifi,modem,color,apt-installed}

apt-installed > .apt-installed

if [[ "$1" == "update" ]]; then
	STATE="UPDATE"
fi
DATE=$(date -u "+%Y_%m_%d_%H_%M")

INSTALL REC kitty fast, featureful, GPU based ${BYellow}terminal emulator${Reset}

INSTALL REC wofi ${BYellow}application launcher${Reset} for wlroots based wayland compositors

INSTALL REC waybar Highly customizable ${BYellow}Wayland bar${Reset} for Sway and Wlroots based compositors

INSTALL REC grim command-line utility to make ${BYellow}screenshots${Reset} of Wayland desktops

INSTALL REC wf-recorder Utility program "for" ${BYelow}screen recording${Reset} of wlroots-based compositors

INSTALL REC light control ${BYellow}display backlight${Reset} controllers and LEDs

INSTALL REC fonts-noto-color-emoji ${BYellow}color emoji${Reset} font from Google

INSTALL REC firefox-esr Mozilla Firefox ${BYellow}web browser${Reset} - Extended Support Release \(ESR\)

INSTALL REC vlc ${BYellow}multimedia player${Reset} and streamer

INSTALL REC pcmanfm extremely fast and lightweight ${BYellow}file manager${Reset}

INSTALL REC swayimg ${Byellow}image viewer${Reset} "for" Sway/Wayland

INSTALL REC swaybg ${BYellow}Wallpaper${Reset} utility "for" Wayland compositors

INSTALL gdu Pretty fast ${BYellow}disk usage analyzer${Reset}

INSTALL REC gparted GNOME ${BYellow}partition editor${Reset}

INSTALL REC zsh ${BYellow}shell${Reset} with lots of features

INSTALL REC vim Vi IMproved - ${BYellow}enhanced vi editor${Reset}

INSTALL neofetch Shows Linux ${BYellow}System Information${Reset} with Distribution Logo

INSTALL emacs GNU Emacs ${BYellow}editor${Reset} \(metapackage\)

INSTALL REC MINIMAL ${BPurple}IMPORTANT PACKAGE \(alsa-utils asciinema command-not-found mdp modemmanager network-manager ssh sshfs vim\)${Reset}

rm -f .apt-installed

echo -e "${BRed}now, launch Hyprland you install this, or run this command again if you forget to install some package"
echo -e "${BCyan}You can test zsh now\n"
echo -e "${BRed}This setup come with some command located at /usr/local/bin"
echo -e "${BRed}You can switch terminal theme between powerlevel and my theme by using zsh_switch_theme"
echo -e "${BRed}You can use other command inside ~/.CUSTOMRC, like github1, github0, mytmate"
echo -e "${Cyan}With zsh, you can edit an asciiart text in ~/.CUSTOMRC, by editing the text in _HELLOWORD=\"${BRed}#> hello <# .henintsoa. _#]* 98 *[#_${Cyan}\", or ${BYellow}set it to _HELLOWORD=\"\", if you don't want this asciiart${Reset}\n"
echo -e "${BYellow}Have FUN 😉${Reset}"
