# Frank's Personal Dotfiles
**warning**: this is currently in **early development** with unstable commits being added to master until the end of August 2018. Use at your own risk. With that being said, this documentation is also heavily in flux, so please check back often!

## What is this?
`dots` is my collection of configuration files and scripts for setting up my personal software development environment/interface using a fresh **Manjaro i3 Community Edition** installation as a base.

## Dirty
![Dirty](dirty_dots.png)
## Clean
![Clean](clean_dots.png)

## Design Goals:
**Disclaimer: These are GOALS, not FEATURES. Hopefully soon, they will all be features.**

1. **Keep all internals as simple as possible**, where simple is defined by the Arch Linux principle "without unnecessary additions or modifications." Only the minimal number of packages needed to get my work done should be included in these scripts. Anything else can potentially introduce external variables that I may not be aware of during my work that may cause bugs and/or waste time.

2. **All open windows should either maximize all available space or monopolize all available attention**. To clarify: open programs should either tile to fill all available workspace, or, in the case of small windows such as dialogs, wizards, preferences, or nag screens, float above everything else and grab all your available attention in an urgent manner. No small thing should be left unattended without being resolved for too long, as this contributes to mental clutter, which may cause bugs and/or waste time.

3. **All UX should feel as comfortable as possible while prioritizing celerity of use over ease of use.** This operating system configuration is not meant to appeal to the masses, its meant for me to get my work done as efficiently and freely as possible. Affordances such as menus, buttons, and dialogs will be sacrificed if a task can be done in less time with slightly more memorization. Memorization shall be facilitated with easy access to relevant documentation.

4. **All UI should be minimal, yet rich and well animated. All theming should be automatic and universal across all applications in a single action.** Finicky customization bugs (can't read things because conflicting colors, colors not being applied consistently, etc.) should not hinder productivity, and should be minimized automatically. I want to get things done and look good doing it -- who doesn't? Worrying about slight imperfections in the color scheme of your 'bike shed' also contributes to mental clutter, which may cause bugs and/or waste time.

5. **The best tool will always be used for the job, regardless of aesthetics or computational efficiency.** GUI tools will be used over terminal-based tools if I can use them more efficiently and vice versa. I disregard the internet's jerking about "hurr durr electron is bloat" and "uuuhhhh muh optimizashuns." It ain't the naughts no more - unless you're the type of person to spend less than $500 on a work machine, your performance bottleneck while writing code is more than likely your internet connection, and not someone's code reuse techniques. Fighting internet fights is a major source of emotional distress, which may cause bugs and/or waste time.

6. **Each development environment shall be treated like cattle, not like a pet. They must be destructible at any time, for any reason, intentional or otherwise.** Any configuration change to my development environment I deem worthwhile shall be committed and backed up in this repository. I should be able to get a new development environment ready to work again, fully functional and configured should something happen to the machine I'm working on with zero heartbreak. This is possible because all my useful work should be committed, all of my secrets/keys are backed up in a system featuring multi-factor authentication, all the configured options of my operating system are committed, and the deployment of all of this should be automated.

## Alright, Frank, I read your silly design manifesto, and I want to code with your setup. How?

1. Do a fresh install of the **Manjaro i3 Community Edition**.

2. When the install is finished and you've rebooted into the new install, run as a **non-root user**:   

   `sh -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/master/postInstall.sh -O -)"`

   This command downloads and installs everything needed.

3. When the script is finished, reboot one more time.

4. **GET SOMETHING DONE!**

**Coming Soon™**: If you are using a monitor with a resolution lower than 2560x1440, use this instead:

`sh -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/laptop/postInstall.sh -O -)"`

This doesn't work yet, (duh, it's **Coming Soon™**), but once I finish it, will install a version of my interface with slightly smaller fonts and more compact elements. I do my development work primarily on single 30+ inch 4k monitors (multiple monitor setups are overstimulating/distracting to me,) but I also write code on my couch on a 15 inch Thinkpad with a 1080p screen.

### **WARNING**: This process was designed with *FRESH* installs in mind. If you run this on an already running system, you WILL have a bad time. If you want to just try this out, feel free to simply copy/paste the configuration files included in this repository.

## Known Issues
- Generally speaking, this is **unfinished.**
- Installer is USA-centric. Edit the `sudo pacman-mirrors -c ...` line if you're not in North America.
- Polybar's network monitors can't automatically tell the correct name of the primary network interface, whether wired or wireless.
- There's an issue in Atom where windows above about 4mil pixels (larger than 1440p) will have unrendered patches.
  - Temp. Workaround: use multiple Atom windows.
- Initial font configuration is still not automatic, and some fonts are not yet consistent.
- There's no cheat sheet for controls/custom functions.
- The volume slider does not mute sound; it simply sets it really really really really low.
- Theming is not yet universal (i.e. you still have to change Atom/X/GTK themes separately.)
- These docs only really cover the installation process. **There is no user manual yet.**
- Did I mention that this is still in active early development with hot commits still being made onto master? If you're not me, I wouldn't use this (yet.)

## How does that magical single command installation work?
After installing the **Manjaro i3 Community Edition**, which provides all our base prerequisites, we run our "main" script, **postInstall.sh** as a **non-root** user by downloading it straight from GitHub's raw files (`wget https://raw.githubusercontent.com/fcamilleri22/dots/master/postInstall.sh`) as a single file (`-O`) dumped right to the standard output (`-`), which is then immediately read and invoked by your shell (`sh -c "$(wget...)"`,) where the `"$(...)""` indicates a command substitution. In this case, the command being substituted in is our entire script! Ain't that dandy? This script runs in 4 phases:

1. **Ensure we're not running as root, and prepare system level configurations.** Namely, we make sure we're grabbing system software from the closest mirror possible (omitting known slow ones) and making some configuration changes to `pacman` and `nano`, the Arch Linux system package manager, and a dandy terminal text editor, respectively. Why not as root? We want to let the script control permissions on its own as needed, in case any of its parts need to call some third party code, such as `yaourt,` the AUR package manager.

2. **Install software from repositories.** First, we get any system software from the Manjaro repositories and the AUR, then we get other packages from other package managers, such as Atom plugins for atom, some nodejs cli utilities from npm, and any others.

3. **Create Projects Directory, clone `dots` repository, and swap in my config files.** I keep all git repositories that I'm actively contributing to inside `~/Projects/`, including this repository. In this phase, I make said directory, clone this entire repository to that directory. Lastly, using `stow`, a GNU symlink manager, I remove any configuration file I have a replacement for in the repository, and replace them with symlinks to configuration files contained within `dots`. This enables me to quickly commit any changes I may make to those configurations in the future, since they are all available in one central location

4. **Initialize software that needs initial setup, and configure remaining loose ends** In this last section, we initialize anything that needs initialization, including our `mariadb` instance, and we perform any small one off configurations that don't warrant dotfiles, such a small firefox theme fix, and changing the shell to `zsh`, my preferred default terminal shell.


## What exactly am I during this process. Why?

#### From the official Manjaro Repositories:

- `base-devel`: prereq for Yaourt -- essentially a C/C++ toolchain.
- `yaourt`: a secondary package manager for Arch Linux User Repository (AUR) packages.
- `bind-tools`: dns tools such as 'dig' and 'host.'
- `zsh`: a standards-compliant alternate bash-like shell with nice plugins.
- `stow`: a tool for managing bundles of symlinks. This enables us to link my custom configs to their programs and update them more easily.
- `gucharmap`: GUI Character map, useful for working with fonts with icons and
 non-standard Unicode icons.
- `mariadb`: a MySQL-compatible server for MySQL development.
- `mysql-workbench`: a (honestly quite bad, someone please suggest a replacement) GUI for MySQL.
- `nodejs`, `npm`: runtime and package management for NodeJS development
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



#### From the Arch User Repository (AUR):

- `smartgit`: a really good Git GUI. Requires paid license, but can be used for free. Please send these people your money. They deserve it.
- `oh-my-zsh-git`: plugin manager for zsh, from github.com/robbyrussell/oh-my-zsh.
- `nerd-fonts-fira-code`: AKA 'Fura Code' - font I use in editors/other code not inside live terminals. Includes emojis and icons, as well as programming ligatures.
- `oomox`: a sexual act performed among consenting Ferengi. Also, a GTK theme generator that works wonderfully in conjunction with python-pywal in order to make sure that our UI stays uniformly themed.
- 'rxvt-unicode-better-wheel-scrolling-unicode3': a patched version of the popular terminal "urxvt" that allows for glyphs and mouse scrolling.

**Coming Soon**: additions for Kotlin/Scala development. I want to get the Theming/JS/Node things done before I start thinking about autotheming Intellij. I love my JVM languages, but I hate Java - its typing is TOO strict, and I don't want to write 20 different wrapper interfaces to reuse a small chunk of code.

## What about Gaming?
Aside from a few small Linux native Steam games I keep installed on my laptop for when I'm traveling, **I do not game with this setup.** All machines I use at work are exactly that: work machines. My primary computer at home is a Windows machine with tons of memory and an 8-core hyperthreaded AMD Ryzen processor (16 cores!), which I built with virtualizing clusters of small Linux machines and simulating distributed systems in mind. If I'm gaming, it's happening in Windows.

With all that being said, if you still want to game with this, look into:
- [Wine](https://www.winehq.org/): A Windows compatibility layer for Linux.
- [DXVK](https://github.com/doitsujin/dxvk): A DX11 compatibility layer for Vulkan.
- [Lutris](https://lutris.net/): A modern game manager/installer with compatibility scripts.

Don't ask me for help with the above - I haven't tried to run games in Linux since 2010.

## My machine has 3 different network interfaces and 3 monitors - why doesn't this work/why does this look weird?
Because this isn't for that. As stated above, these are my configuration files for me to get my work done. I do not work on multi-monitor setups, and thus won't dedicate time to fixing any issues there unless I start working on multi-monitor setups, and the machines I work with have, at most, a wired and wireless interface, and no more than that. If I am working on a machine with more than that, it's a server and I'm not running this on servers. If you want that functionality, feel free to contribute or fork.
