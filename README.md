# Frank's Personal Work Environment
## What is this?
`dots` is my collection of configuration files and scripts for setting up my personal software development environment/interface using a fresh **Manjaro i3 Community Edition** installation as a base.

[Cheat sheet/User Manual.](CHEATS.md)

["FAQ"](FAQ.md)

[Screenshots](screens.md)

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
- Any non-default configuration file is **source controlled** using `git` and `stow`. Thus, to update this setup, all one needs to do is pull, which updates all included configuration files and run an included script (`updateDots`) that installs any new packages.
- All interface theming is handled by an original set of `wal` and `oomox` powered scripts so that **all UI retheming can be handled in a single command, always with perfect color coordination, either according to a builtin theme, or an input image.** (`retheme-by-theme` and `retheme-by-image`)
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
- `LXAppearance` is not symlink friendly. A wrapper, `dots-lxappearance` is included and PATHed. Use that instead to keep gtk symlinks intact. You shouldn't really need to use it anyway, as the retheme-by-... commands should handle everything.
- Cursors still aren't fully cooperating with set settings.
- There's an issue I'm experiencing in the Atom editor on my 4k resolution Virtualbox setup where sections of the window will not render. Don't know what exactly is causing this yet, but a workaround is to either use multiple windows, or to have terminal open in the same workspace.

## Roadmap of Definite Upcoming Changes (in priority order)
1. Better WebDev tools/configurations, such as linters and other utilities.
2. Weather Widget
3. Intellij Idea configurations for Java/Scala/Kotlin development, as well as `wal` integration.
4. `updateDots` optimizations.
5. Improve Firefox theme handling, automatically handle extensions
6. Improve Atom and Intellij color themes and Compton config.
7. Switch Base to either straight Arch Linux or Manjaro-Architect.
8. Prettier bootup process.
9. Multiple (human) user login setups/login manager




## Special Thanks
I'd like to thank all the Manjaro/Arch Linux maintainers out there, especially [Bernhard Landauer](https://github.com/oberon-manjaro), aka "oberon", the primary maintainer of the Manjaro i3 Community Edition.

I'd like to thank [Dylan Araps](https://github.com/dylanaraps) for building `wal`, the centerpiece powering this setup's grand retheming abilities.

I'd also like to thank all the artists and designers who've contributed fonts and icons to open source, and thus this work, including [Keefer Rourke](https://krourke.org/) who contributed the default icons and cursors I'm using, and [Pawel Nolbert](http://nolbert.com/), who took the picture I'm using as the default background and posted it openly to [Unsplash](https://unsplash.com/), who also get some thanks.

Also, the folks on the [GitHub](https://github.com/) team for providing their platform and the [Atom Editor](https://atom.io/), which are just such pleasures to work with (actually!)

Lastly, to my Alyssa -- to think there's actually someone on this planet willing to deal with my antics on a daily basis is an impossible thought, but she's an impossibly great person.

I'd thank every single person out there who contributed something to this, but that would turn this into a credits doc, and nobody wants to actually read that. Considering all the people who've contributed to Linux, Arch, and Manjaro over the years, how does one even write that?

(If there are, however, any actual licensing/recognition issues, let me know.)
