# Genome
Here you can find the dotfiles for my latest setup on the latest qtile-git. Feel free to create an issue if I'm missing something

NOTE: These dots are intended for my setup. If you wish to use them (and feel free to take them and tinker around), you will have to make specific modifications
for your own machine. I'll do my best to answer questions related to parameters that may need to be changed

## Info
- OS: Arch
- WM: Bspwm (Previously [Qtile-git](https://github.com/qtile/qtile))
- Terminal: Alacritty
- Shell: zsh
- Bar: Polybar
- Browser: Chromium
  - Startpage: [nightTab](https://github.com/zombieFox/nightTab)
- Fonts: FiraCode [Nerd Font](https://github.com/ryanoasis/nerd-fonts) for general text and [Font Awesome 5 Free](https://fontawesome.com/) for icons
- Player: Spotify with slightly modified [Dribblish](https://github.com/morpheusthewhite/spicetify-themes/tree/master/Dribbblish) theme
- Gtk: [Nordic-darker](https://github.com/EliverLara/Nordic)
- File manager: Nautilus
- Editor: [Code](https://github.com/microsoft/vscode) and Neovim
- Email: Geary
- Calendar: Pantheon Calendar
- Tasks: Taskwarrior with [ptask](https://wpitchoune.net/ptask/) frontend
- Chat: Discord with [BetterDiscord](https://github.com/rauenzi/BetterDiscordApp) and Polari irc client
- Fetch: Neofetch
- Widgets: [Eww](https://github.com/elkowar/eww)
- Blurring wallpaper: ngynLk's fork of [feh-blur](https://github.com/ngynLk/feh-blur-wallpaper)
- Notifications: Dunst with scripts for a rofi based notification center (see [here](https://github.com/Barbarossa93/Genome/blob/4a08d3cfd0900807aefaa9f9241a6dbf926c549b/.config/dunst/dunstrc#L77), [here](https://github.com/Barbarossa93/Genome/blob/main/.local/bin/dunst_logger.sh) and [here](https://github.com/Barbarossa93/Genome/blob/main/.local/bin/rofi_notif_center.sh))
- Compositor: Jonaburg's fork of [Picom](https://github.com/jonaburg/picom)
- Display Manager/ Lockscreen: Xinit with [i3lock-color](https://github.com/Raymo111/i3lock-color)
- Colorscheme: [Nord](https://www.nordtheme.com/) with extra dark color #242831

## FAQ

### How are you getting space around your qtile bar widgets?
I use eww windows that run along the top and bottom of the bar to cover up the fact that the widget backgrounds extend the entire bar. See ~/.config/eww.xml and ~/.config/qtile/autostart.sh for the relevant sections

### Why did you stop using Qtile?
Unfortunately I found Qtile to be lacking features from what I've come to expect a window manager to be capable of. Before Qtile, I used BSPWM for some time and was quite accustomed to what it could do. Qtile simply isn't on the same level in terms of window management. Someday, when I have more time, I'd like to come back to Qtile and make it work the way I want.

<img src="https://raw.githubusercontent.com/Barbarossa93/Genome/main/out.png" alt="img" align="center" width="900px">
