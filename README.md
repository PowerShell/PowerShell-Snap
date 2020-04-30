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

## Known Issues

- Ubuntu 20.04 is not working with the `powershell` package.
  - The work around is to use the `powershell-preview` package.
- Some native libaries cause incompatible libarires to be loaded.  Because the snap file system the readonly, there is no real workaround for this.
  - `libmi` always causes for this type of issue and is responsible for:
    - PowerShell remoting commands that don't invole `-Hostname`

## Alias Troubleshooting

- Run `whereis pwsh-preview` if, `/snap/bin/pwsh-preview` is not returned, Snap has not created the alias.
- If Snap has created the alias, and it is not working, you may need to reboot (or logout and back in) before it will work.
- If Snap has not created the alias, you can create the alias with `sudo snap alias <packagename> <aliasname>`
