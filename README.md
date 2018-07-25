# Frank's Personal Dotfiles
**warning**: this is currently in **early development** with unstable commits being added to master until the end of July 2018. Use at your own risk. With that being said, this documentation is also heavily in flux, so please check back often!

## What is this?
`dots` is my collection of configuration files and scripts for setting up my personal software development environment/interface using a fresh **Manjaro i3 Community Edition** installation as a base.

## Dirty
![Dirty](dirty_dots.png)
## Clean
![Clean](clean_dots.png)

## Why are these docs so damn VERBOSE? I hate reading!
I wrote this documentation with **casual** browsers of reddit.com/r/unixporn in mind, who (at least from my perspective/in my opinion) seem to be high-school/early college aged people studying something technical (not necessarily CS, but mostly CS) OR longtime programmers who've primarily used Windows/Mac/Ubuntu/Fedora/RHEL/CentOS through their career, just started getting their feet wet with rolling their own desktop, and would appreciate reading why I made certain decisions and not just how this works.

My own entry into the greater Linux/software engineering world started off more than 12 years ago (my high school years) with writing similar post install scripts for Ubuntu Minimal and Debian in the hope of having a unique/better/safer/faster-than-Windows gaming/media center setup. An entire career in software/computer engineering kinda sprouted out of that. Ain't that neat?

This documentation is **NOT** targeted towards people with lots of experience with Arch Linux and/or rolling their own Linux Desktop, and will probably flow like molasses to that crowd. **Sorry.**

## Design Goals:
1. **Keep all internals as simple as possible**, where simple is defined by the Arch Linux principle "without unnecessary additions or modifications." Only the minimal number of packages needed to get my work done should be included in these scripts. Anything else can potentially introduce external variables that I may not be aware of during my work that may cause bugs and/or waste time.

2. **All open windows should either maximize all available space or monopolize all available attention**. To clarify: open programs should either tile to fill all available workspace, or, in the case of small windows such as dialogs, wizards, preferences, or nag screens, float above everything else and grab all your available attention in an urgent manner. No small thing should be left unattended without being resolved for too long, as this contributes to mental clutter, which may cause bugs and/or waste time.

3. **All UX should feel as comfortable as possible while prioritizing celerity of use over ease of use.** This operating system configuration is not meant to appeal to the masses, its meant for me to get my work done as efficiently and freely as possible. Affordances such as menus, buttons, and dialogs will be sacrificed if a task can be done in less time with slightly more memorization. Memorization shall be facilitated with easy access to relevant documentation.

4. **All UI should be minimal, yet rich and well animated. All theming should be automatic and universal across all applications in a single action.** Finicky customization bugs (can't read things because conflicting colors, colors not being applied consistently, etc.) should not hinder productivity, and should be minimized automatically. I want to get things done and look good doing it -- who doesn't?

5. **The best tool will always be used for the job, regardless of aesthetics or computational efficiency.** GUI tools will be used over terminal-based tools if I can use them more efficiently and vice versa. I disregard the internet's jerking about "hurr durr electron is bloat" and "uuuhhhh muh optimizashuns." It ain't the naughts no more - unless you're the type of person to spend less than $500 on a work machine, your performance bottleneck while writing code is more than likely your internet connection, and not someone's code reuse techniques. Fighting internet fights is a major source of emotional distress, which may cause bugs and/or waste time.

6. **Each development environment shall be treated like cattle, not like a pet. They must be destructible at any time, for any reason, intentional or otherwise.** Any configuration change to my development environment I deem worthwhile shall be committed and backed up in this repository. I should be able to get a new development environment ready to work again, fully functional and configured should something happen to the machine I'm working on with zero heartbreak. This is possible because all my useful work should be committed, all the configured options of my operating system are committed, and its deployment is automated.

## Alright, Frank, I read your silly design manifesto, and I want to code with your setup. How?

1. Do a fresh install of the **Manjaro i3 Community Edition**.

2. When the install is finished and you've rebooted into the new install, run as a **non-root user**:   

   `sh -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/master/postInstall.sh -O -)"`

   This command downloads and installs everything needed.

   **Coming Soon™**: If you are using a monitor with a resolution lower than 2560x1440, use this instead:

   `sh -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/laptop/postInstall.sh -O -)"`

   This doesn't work yet, (duh, it's **Coming Soon™**), but once I finish it, will install a version of my interface with slightly smaller fonts and more compact elements. I do my development work primarily on single 30+ inch 4k monitors (multiple monitor setups are overstimulating/distracting to me,) but I also write code on my couch on a 15 inch Thinkpad with a 1080p screen.

3. When the script is finished, reboot one more time.

4. **GET SOMETHING DONE!**

## Known Issues
- Installer is USA-centric. Edit the `sudo pacman-mirrors -c ...` line if you're not in North America.
- Polybar's network monitors can't automatically tell the correct name of the primary network interface, whether wired or wireless.
- Initial font configuration is still not automatic, and some fonts are not yet consistent.
- There's no cheat sheet for controls/custom functions.
- Theming is not yet universal (i.e. you still have to change Atom/X/GTK themes separately.)
- These docs only really cover the installation process. **There is no user manual yet.**
- Did I mention that this is still in active early development with hot commits still being made onto master?

# **WARNING: currently, the installation process DELETES certain default configuration files, as it was written with *FRESH* installs in mind.**

### But Frank, I don't want to permanently install this yet -- I just want to try it out!
**Coming Soon™**: I will be writing functionality such that your old configurations will be preserved and revertible in a single command. For now, you can just clone this repository, and copy each included config file manually.

## Well, how does this all work?
After installing the **Manjaro i3 Community Edition**, which provides all our base prerequisites, we run our "main" script, **postInstall.sh** as a **non-root** user by downloading it straight from GitHub's raw files (`wget https://raw.githubusercontent.com/fcamilleri22/dots/master/postInstall.sh`) as a single file (`-O`) dumped right to the standard output (`-`), which is then immediately read and invoked by your shell (`sh -c "$(wget...)"`,) where the `"$(...)""` indicates a command substitution. In this case, the command being substituted in is our entire script! Ain't that dandy? This script runs in 5 phases:

1. **Ensure we're not running as root, and prepare system level configurations.** We need to run the script as a regular user so that each individual part of the script can elevate privileges only as needed. (see the section **On Security** for why.) We then update our package manager's mirror list (`pacman`, the program that downloads and installs our other programs.) to ensure that we can download our programs in the shortest amount of time. Lastly, we edit (rather than maintain/copy/paste) system level configurations. I've opted to edit system level configurations (in our case, for `pacman` and `nano`, a very basic terminal text editor) using sed, instead of maintaining our own config files in the repo. This decreases the chance of being caught with broken system level configurations in case a major configuration change by the Manjaro or Arch Linux maintainers occurs.

2. **Install packages from the Official Manjaro Repository and the Arch User Repository.** First we update our local knowledge about what software packages and their versions are available, aka the `pacman` database. We then download/install packages from the official repositories, then repeat the process using `yaourt`, a wrapper for `pacman` that also includes functionality for handling packages on the AUR in an automated fashion. See the section **What exactly am I installing? Why?** for more information on the software we will install.

3. **Perform initial setup on installed packages that require it, including installing third party plugins.** In this step, we handle things like running `mysql_secure_installation` in order to make sure that we have a working MySQL server for database development, `apm install` to set up Atom Editor's plugins, and `npm install -g` to set up additional tools for NodeJS development, such as `eslint` (checks for errors in NodeJS/JavaScript code) and `underscore-cli` (useful terminal utilities written in NodeJS.)

4. **Create our "Projects" directory, get the rest of the files in `dots`, and replace any Manjaro i3 default configurations that may conflict with our configurations with symlinks (aka shortcuts) to the configuration files kept in `dots`.** I keep all git repositories that I'm actively contributing to inside `~/Projects/`, including this repository. In this phase, I make said directory, clone this entire repository to that directory. Lastly, using `stow`, a GNU symlink manager, I remove any configuration file I have a replacement for in the repository, and replace them with symlinks to configuration files contained within `dots`. This enables me to quickly commit any changes I may make to those configurations in the future, since they are all available in once central location

5. **Wrap up: change settings such as default shell, fonts, apply any unofficial modifications/hacks, delete any cruft, and reboot.** Essentially, any loose ends get tied here, and any trash gets cleaned up. **NOTE:** I might eliminate this step in the near future, and roll its parts into previous steps. Still thinking about it.

## What exactly am I installing? Why?

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
- `nerd-fonts-terminus`: font I use in live terminals, patched with emojis and icons.
- `ttf-ubuntu-font-family`: systemwide default sans-serif fonts. They're pretty.
- `libmpdclient` and `jsoncpp` are improperly linked prerequisites of polybar. They're required for some of the plugins included in `polybar` that I'm not using here, and not listed as prerequisites for `polybar`, but `polybar` will not launch properly without them regardless.

#### From the Arch User Repository (AUR):

- `smartgit`: a really good Git GUI. Requires paid license, but can be used for free. Please send these people your money. They deserve it.
- `oh-my-zsh-git`: plugin manager for zsh, from github.com/robbyrussell/oh-my-zsh.
- `nerd-fonts-fira-code`: AKA 'Fura Code' - font I use in editors/other code not inside live terminals. Includes emojis and icons, as well as programming ligatures.
- `oomox`: a sexual act performed among consenting Ferengi. Also, a GTK theme generator that works wonderfully in conjunction with python-pywal in order to make sure that our UI stays uniformly themed.


## On Security
I'm not a security engineer, a penetration tester, or a computer cracker. I'm putting faith in the people contributing to the Linux Kernel, Arch Linux, and Manjaro as far as the security of the base system goes.

As far as the security of the parts I am responsible for, namely, this installation process, we ensure that we are not running the entire install script as root mainly because AUR package build scripts, aka PKGBUILDs, are user submitted and maintained. Any person can submit and maintain an AUR PKGBUILD. Due to this simple fact, there is always a chance of an unknown party adding malicious code to a PKGBUILD -- most times something like this has happened, however, it has been purely accidental (yet still destructive.)

e.g.: a PKGBUILD ends with a cleanup script to delete files created in a normally sensitive area, such as /tmp/some_package_name. What if the maintainer accidentally typos in a space after one of the slashes and ends up invoking `rm -rf / tmp/some_package_name` instead? Can you say *"Oooof?"*

In recent memory, however, there have been [cases of deliberate malicious code inside PKGBUILDS](https://www.bleepingcomputer.com/news/security/malware-found-in-arch-linux-aur-package-repository/). To defend against something more sophisticated like this, I've made sure to only grab only the minimum number of packages from the AUR - just four. If you're super paranoid about this vector, you may read the contents of each PKGBUILD at the [AUR website](aur.archlinux.org) or in a prompt that pops up during the installation process. Look especially for lines that invoke programs such as `curl` or `wget`. Most times, these are fine, as these scripts need some mechanism for fetching their code from wherever said code actually lives. Double check the addresses that these commands are pointing to. If you see something suspicious, SAY SOMETHING!

Other potential attack vectors include random script copypasta from the internet -- please read and understand any code you paste and run in your terminal -- and from other non-centrally maintained package managers with open publishing standards such as `npm`. Ultimately, it is up to the user to **BE VIGILANT!**

## **HEY!** In the introduction to this obscenely long doc, you mentioned mentioned the word "GAMING?" How do I game with this?
Aside from a few small Linux native Steam games I keep installed on my laptop for when I'm traveling, **I do not game with this setup.** All machines I use at work are exactly that: work machines. My primary computer at home is a Windows machine with tons of memory and an 8-core hyperthreaded AMD Ryzen processor (16 cores!), which I built with virtualizing clusters of small Linux machines and simulating distributed systems in mind. If I'm gaming, it's happening in Windows.

**You definitely CAN** play more graphically intensive games with this setup with some additional work, but **I'm not writing anything here to facilitate that.**
