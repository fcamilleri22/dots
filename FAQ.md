
## How does that super dandy single command installation work?
After installing the **Manjaro i3 Community Edition**, which provides all our base prerequisites, we run our "main" script, **postInstall.sh** as a **non-root** user by downloading it straight from GitHub's raw files (`wget https://raw.githubusercontent.com/fcamilleri22/dots/master/postInstall.sh`) as a single file (`-O`) dumped right to the standard output (`-`), which is then immediately read and invoked by your shell (`sh -c "$(wget...)"`,) where the `"$(...)""` indicates a command substitution. In this case, the command being substituted in is our entire script! Ain't that dandy? This script runs in 4 phases:

1. **Ensure we're not running as root, and prepare system level configurations.** Namely, we make sure we're grabbing system software from the closest mirror possible (omitting known slow ones) and making some configuration changes to `pacman` and `nano`, the Arch Linux system package manager, and a dandy terminal text editor, respectively. Why not as root? We want to let the script control permissions on its own as needed, in case any of its parts need to call some third party code, such as when `yay,` the AUR package manager, needs to run a PKGBUILD.

2. **Install software from repositories.** First, we get any system software from the Manjaro repositories and the AUR, then we get other packages from other package managers, such as Atom plugins for atom, some nodejs cli utilities from npm, and any others.

3. **Create Projects Directory, clone `dots` repository, and swap in my config files.** I keep all git repositories that I'm actively contributing to inside `~/Projects/`, including this repository. In this phase, I make said directory, clone this entire repository to that directory. Lastly, using `stow`, a GNU symlink manager, I remove any configuration file I have a replacement for in the repository, and replace them with symlinks to configuration files contained within `dots`. This enables me to quickly commit any changes I may make to those configurations in the future, since they are all available in one central location

4. **Initialize software that needs initial setup, and configure remaining loose ends** In this last section, we initialize anything that needs initialization, including our `mariadb` instance, and we perform any small one off configurations that don't warrant dotfiles, such a small firefox theme fix, setting a default theme and wallpaper, and changing the shell to `zsh`, my preferred default terminal shell. Also, any other installations that require user intervention are pushed to this section.


## What exactly am I installing during this process. Why?

#### From the official Manjaro Repositories:

- `yay`: an alternative to `pacman`
- `bind-tools`: useful dns tools such as 'dig' and 'host.'
- `zsh`: a standards-compliant alternate bash-like shell with nice plugins.
- `stow`: a tool for managing bundles of symlinks. This enables us to link my custom configs to their programs and update them more easily.
- `gucharmap`: GUI Character map, useful for working with fonts with icons and
 non-standard Unicode icons.
- `mariadb`: a MySQL-compatible server for MySQL development.
- `mysql-workbench`: a (honestly quite bad, someone please suggest a replacement) GUI for MySQL.
- `nodejs`, `npm`: runtime and package management for NodeJS development (I'm experimenting with trying to not use `nvm` -- this is probably temporary)
- `atom`, `apm`: Modern text editor developed by GitHub similar to Notepad++ or Sublime text and its associated package (plugin) manager.
- `git`: Everyone's favorite source control!
- `firefox-developer-edition`: fast web browser with great dev tools.
- `python-pywal`: script used for facilitating custom UI theme creation.
- `polybar`: the "taskbar" that occupies the top of the screen and supplies useful information.
- `rofi`: a minimalist application launcher, similar to dmenu.
- `terraform`: an infrastructure-as-code tool compatible with all major cloud services providers (AWS, Digital Ocean, etc.)
- `nerd-fonts-terminus`: font I use in live terminals, patched with emojis and icons.
- `ttf-ubuntu-font-family`: systemwide default sans-serif fonts. They're pretty.
- `libmpdclient` and `jsoncpp` are prerequisites of certain Polybar plugins.
- `manjaro-pulse, pa-applet, pavucontrol` are for audio support and control.



#### From the Arch User Repository (AUR):

- `smartgit`: a really good Git GUI. Requires paid license, but can be used for free. Please send these people your money. They deserve it.
- `oh-my-zsh-git`: plugin manager for zsh, from github.com/robbyrussell/oh-my-zsh.
- `nerd-fonts-fira-code`: AKA 'Fura Code' - font I use in editors/other code not inside live terminals. Includes emojis and icons, as well as programming ligatures.
- `oomox`: a sexual act performed among consenting Ferengi. Also, a GTK theme generator that works wonderfully in conjunction with python-pywal in order to make sure that our UI stays uniformly themed.
- `rxvt-unicode-better-wheel-scrolling-unicode3`: a patched version of the popular terminal "urxvt" that allows for glyphs and mouse scrolling.
- `la-capitaine` cursors and icon themes: a wonderful set of colorful icons and cursors that go well with pretty much any ui colorscheme you can think of.

#### Also, a few Python, Node.js, and Atom Editor packages and plugins.

## My machine has 10 different network interfaces and 6 monitors - why doesn't this work/why does this look weird?
Because this isn't for that. As stated above, these are my configuration files for me to get my work done. I do not work on multi-monitor setups, and thus won't dedicate time to fixing any issues there unless I start working on multi-monitor setups, and the machines I work with have, at most, a wired and wireless interface, and no more than that. If I am working on a machine with more than that, it's a server and I'm not running this on servers. If you want to contribute a feature that's useful and doesn't alter how I use my setup, such as the above, feel free to make a pull request.

## I want to improve on this. How?
Please create issues and/or write pull requests! Any merges will ultimately be up to me, but if it follows the manifesto at the beginning of this doc, I should be down.

## I want to use this, but I want to make and maintain little tweaks of it for myself. How?
Fork this, and do it big! If you do anything really cool though, please share it as a possible pull request.
