# PRE-INSTALLATION
```bash
git clone --depth 1 https://github.com/henintsoa98/dotfiles.debian12
cd dotfiles.debian12
```
## CAUTION
NEVER RUN COMMAND AS ROOT, it use sudo itself. \
$USER is generally in sudo group, but if not, run :
```bash
bash sudo.bash
```
# INSTALLATION
This command will help you to install some package, with their configuration. \
Accept recommanded if you want to get better experience, or if you are from [hyprland.debian12](https://github.com/henintsoa98/hyprland.debian12) \
Just run :
```bash
bash setup.bash
```
If you don't like all of this stuff, you can explore some script or config in BIN, CONFIG.
# AFTER INSTALLATION
** Edit the file **~/.CUSTOMRC** on **_HELLOWORD** to edit the ASCIIART on login text, if you don't like set variable to **_HELLOWORD=""**
If you want to update config file for zsh, vim, ... , run :
```bash
bash setup.bash update
```
