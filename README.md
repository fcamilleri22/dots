# Frank's Personal Dotfiles
**warning**: this is currently in **early development** with unstable commits being added to master until the end of July 2018. Use at your own risk.

## What is this?
**dots** is my collection of configuration files and scripts for setting up my personal software development environment/interface using a fresh **Manjaro i3 Community Edition** installation as a base.

## Design Goals:
1. **Keep all internals as simple as possible**, where simple is defined by the Arch Linux principle "without unnecessary additions or modifications." Only the minimal number of packages needed to get my work done should be included in these scripts. Anything else can potentially introduce external variables that I may not be aware of during my work that may cause bugs and/or waste time.

2. **All open windows should either maximize all available space or monopolize all available attention**. To clarify: open programs should either tile to fill all available workspace, or, in the case of small windows such as dialogs, wizards, preferences, or nag screens, float above everything else and grab all your available attention in an urgent manner. No small thing should be left unattended without being resolved for too long, as this contributes to mental clutter, which may cause bugs and/or waste time.

3. **All UX should feel as comfortable as possible while prioritizing celerity of use over ease of use.** This operating system configuration is not meant to appeal to the masses, its meant for me to get my work done as efficiently and freely as possible. Affordances such as menus, buttons, and dialogs will be sacrificed if a task can be done in less time with slightly more memorization. Memorization shall be facilitated with easy access to relevant documentation.

4. **All UI should be minimal, yet rich and well animated. All theming should be automatic and universal across all applications in a single action.** Finicky customization bugs (can't read things because conflicting colors, colors not being applied consistently, etc.) should not hinder productivity, and should be minimized automatically. I want to get things done and look good doing it -- who doesn't?

5. **The best tool will always be used for the job, regardless of aesthetics or computational efficiency.** GUI tools will be used over terminal-based tools if I can use them more efficiently and vice versa. I disregard the internet's jerking about "hurr durr electron is bloat" and "uuuhhhh muh optimizashuns." It's 2018, unless you're the type of person to spend less than $500 on a work machine, your performance bottleneck while writing code is more than likely your internet connection, and not someone's code reuse techniques. Fighting internet fights is a major source of emotional distress, which may cause bugs and/or waste time.

6. **Each development environment shall be treated like cattle, not like a pet. They must be destructible at any time, for any reason, intentional or otherwise.** Any configuration change to my development environment I deem worthwhile shall be committed and backed up in this repository. I should be able to get a new development environment ready to work again, fully functional and configured should something happen to the machine I'm working on with zero heartbreak. This is possible because all my useful work should be committed, all the configured options of my operating system are committed, and its deployment is automated.

## Alright, Frank, I read your silly manifesto, and I want to code in your environment. How?

1. Do a fresh install of the **Manjaro i3 Community Edition**.

2. When the install is finished and you've rebooted into the new install, run as a **non-root user**:   

   `sh -c "$(wget https://raw.githubusercontent.com/fcamilleri22/dots/master/postInstall.sh -O -)"`

   This command downloads and installs everything needed.

3. When the script is finished, reboot one more time.

4. **GET SOMETHING DONE!**

## Well, how does this all work? What's it made out of?
**SECTION COMING SOON -- DID I MENTION THIS IS IN EARLY DEVELOPMENT?**
