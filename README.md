# Frank's Personal Work Environment

## What is this?
`dots` is my collection of configuration files and scripts for setting up my personal software development environment/interface using a fresh **Manjaro i3 Community Edition** installation as a base.

## Design Goals
1. **Keep all internals as simple as possible**, where simple is defined by the Arch Linux principle "without unnecessary additions or modifications." Only the minimal number of packages needed to get my work done should be included in these scripts. Anything else can potentially introduce external variables that I may not be aware of during my work that may cause bugs and/or waste time.

2. **All open windows should either maximize all available space or monopolize all available attention**. To clarify: open programs should either tile to fill all available workspace, or, in the case of small windows such as dialogs, wizards, preferences, or nag screens, float above everything else and grab all your available attention in an urgent manner. No small thing should be left unattended without being resolved for too long, as this contributes to mental clutter, which may cause bugs and/or waste time.

3. **All UX should feel as comfortable as possible while prioritizing celerity of use over ease of use.** This operating system configuration is not meant to appeal to the masses, its meant for me to get my work done as efficiently and freely as possible. Affordances such as menus, buttons, and dialogs will be sacrificed if a task can be done in less time with slightly more memorization. Memorization shall be facilitated with easy access to relevant documentation.

4. **All UI should be minimal, yet rich and well animated. All theming should be automatic and universal across all applications in a single action.** Finicky customization bugs (can't read things because conflicting colors, colors not being applied consistently, etc.) should not hinder productivity, and should be minimized automatically. I want to get things done and look good doing it -- who doesn't? Worrying about slight imperfections in the color scheme of your 'bike shed' also contributes to mental clutter, which may cause bugs and/or waste time.

5. **The best tool will always be used for the job, regardless of aesthetics or computational efficiency.** GUI tools will be used over terminal-based tools if I can use them more efficiently and vice versa. I disregard the internet's quibbling about "hurr durr electron is bloat" and "uuuhhhh muh optimizashunized sistemz." It ain't the naughts no more - unless you're the type of person to spend less than $500 on a work machine, your performance bottleneck while writing code is more than likely your internet connection, and not someone's code reuse techniques. Fighting internet fights is a major source of emotional distress, which may cause bugs and/or waste time.

6. **Each development environment shall be treated like cattle, not like a pet. They must be destructible at any time, for any reason, intentional or otherwise.** Any configuration change to my development environment I deem worthwhile shall be committed and backed up in this repository. I should be able to get a new development environment ready to work again, fully functional and configured should something happen to the machine I'm working on with zero heartbreak. This is possible because all my useful work should be committed, all of my secrets/keys are backed up in a system featuring multi-factor authentication, all the configured options of my operating system are committed, and the deployment of all of this should be automated.

**Any additions and changes to this setup process will be motivated by these goals.**

## Primary Features
- Tiling Window Manager **(i3)**
- Any non-default configuration file is **source controlled** using `git` and `stow`.
- All interface theming is handled by an original set of `wal` and `oomox` powered scripts so that **all UI retheming can be handled in a single command, always with perfect color coordination, either according to a builtin theme, or an input image.**
- With the above being said, Firefox, in this environment, is set up to ignore all system themes when rendering pages so that any pages displayed are shown exactly as the author intended. **No more unreadable textboxes in your browser while using dark themes!**
- Simple, single command setup (assuming you know how to use Manjaro/i3 in the first place.)

## Alright, Frank, I read your silly design manifesto, and I want to code with your setup. How?

#### **WARNING**: This process was designed with *FRESH* installs in mind. If you run this on an already running system, you WILL have a bad time. If you want to just try this out, use a VM or a secondary machine.

1. Do a fresh install of the **Manjaro i3 Community Edition**.

2. When the install is finished and you've rebooted into the new install, run as a **non-root user**:   

   `sh -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/master/postInstall.sh -O -)"`

   This command downloads and installs everything needed, then reboots again.

3. **GET SOMETHING DONE!**

**Using a laptop? Smaller screen?**: If you are using a monitor with a resolution lower than 2560x1440, use this instead:

`sh -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/laptop/postInstall.sh -O -)"`

This is an alternate branch with slightly different default configs built specifically for a 1080p screen in mind.

## Known Issues
- Generally speaking, this is **always going to be a work in progress.** I'll do my best to only merge in completed, separate feature branches, but small fixes will be added directly to master from time to time.
- LXAppearance is not symlink friendly. Stowed configs will be used as defaults, but once you make a change inside LXAppearance, any GTK-related symlink will become a copy instead. Copy these back into the `dots` directory if you make a change using LXAppearance.
- There's an issue I'm experiencing in the Atom editor on my 4k resolution Virtualbox setup where sections of the window will not render. Don't know what exactly is causing this yet, but a workaround is to either use multiple windows, or to have terminal open in the same workspace.

## Roadmap of Upcoming Changes (in priority order)
1. Better WebDev tools/configurations, such as linters and other utilities.
2. Intellij Idea configurations for Java/Scala/Kotlin development, as well as `wal` integration.
3. `updateDots.sh` optimizations.
4. Switch Base to either straight Arch Linux or Manjaro-Architect.
5. Prettier bootup process.
6. Multiple (human) user login setups.



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



## My machine has 3 different network interfaces and 3 monitors - why doesn't this work/why does this look weird?
Because this isn't for that. As stated above, these are my configuration files for me to get my work done. I do not work on multi-monitor setups, and thus won't dedicate time to fixing any issues there unless I start working on multi-monitor setups, and the machines I work with have, at most, a wired and wireless interface, and no more than that. If I am working on a machine with more than that, it's a server and I'm not running this on servers.
## I want to improve on this. How?
Please create issues and/or write pull requests! Any merges will ultimately be up to me, but if it follows the manifesto at the beginning of this doc, I should be down.
## I want to use this, but I want to make and maintain little tweaks of it for myself. How?
Fork this, and do it big! If you do anything really cool though, please share it as a possible pull request.

## Special Thanks
I'd like to thank all the Manjaro/Arch Linux maintainers out there, especially [Bernhard Landauer](https://github.com/oberon-manjaro), aka "oberon", the primary maintainer of the Manjaro i3 Community Edition.

I'd like to thank [Dylan Araps](https://github.com/dylanaraps) for building `wal`, the centerpiece powering this setup's grand retheming abilities.

I'd also like to thank all the artists and designers who've contributed fonts and icons to open source, and thus this work, including [Keefer Rourke](https://krourke.org/) who contributed the default icons and cursors I'm using, and [Pawel Nolbert](http://nolbert.com/), who took the picture I'm using as the default background and posted it openly to [Unsplash](https://unsplash.com/), who also get some thanks.

Also, the folks on the [GitHub](https://github.com/) team for providing their platform and the [Atom Editor](https://atom.io/), which are just such pleasures to work with (actually!)

Lastly, to my Alyssa -- to think there's actually someone on this planet willing to deal with my antics on a daily basis is an impossible thought, but she's an impossibly great person.

I'd thank every single person out there who contributed something to this, but that would turn this into a credits doc, and nobody wants to actually read that. Considering all the people who've contributed to Linux, Arch, and Manjaro over the years, how does one even write that?

(If there are, however, any actual licensing/recognition issues, let me know.)
