<h1 align="center">
  <img src="https://raw.githubusercontent.com/PowerShell/PowerShell/master/assets/Powershell_black_64.png" alt="Project">
  <br />
  PowerShell
</h1>

<p align="center"><b>This is the snap for PowerShell</b>, <i>"PowerShell for every system"</i>. It works on Ubuntu, Fedora, Debian, and other major Linux
distributions.</p>

<!-- Uncomment and modify this when you are provided a build status badge
<p align="center">
<a href="https://build.snapcraft.io/user/snapcrafters/fork-and-rename-me"><img src="https://build.snapcraft.io/badge/snapcrafters/fork-and-rename-me.svg" alt="Snap Status"></a>
</p>
-->

## Install

```sh
sudo snap install powershell --classic
```

```sh
sudo snap install powershell-preview --classic
```

([Don't have snapd installed?](https://snapcraft.io/docs/core/install))

<!-- Uncomment and modify this when you have a screenshot
![my-snap-name](screenshot.png?raw=true "my-snap-name")
-->

<p align="center">Published for <img src="http://anything.codes/slack-emoji-for-techies/emoji/tux.png" align="top" width="24" /> with :gift_heart: by Snapcrafters</p>

## Known Issues

- Some people have reported that the auto-alias of `powershell-preview` to `pwsh-preview` is not working.  I have reported this to Canonical.
  - See Alias Troubleshooting

## Alias Troubleshooting

- Run `whereis pwsh-preview` if, `/snap/bin/pwsh` or `/snap/bin/pwsh-preview` is not returned, Snap has not created the alias.
- If Snap has created the alias, and it is not working, you may need to reboot (or logout and back in) before it will work.
- If Snap has not created the alias, you can create the alias with `sudo snap alias <packagename> <aliasname>`
