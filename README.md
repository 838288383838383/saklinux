# 🌸 SakLinux - Sakura's Subsystem for Linux

**Your own custom Linux subsystem, powered by Sakura.**

SakLinux is a custom Linux environment that runs on Windows via WSL2, but branded and configured as Sakura's own subsystem. Think of it as "Sakura's version of WSL" — your own distro, your own tools, your own rules.

## What is SakLinux?

- A custom-built Linux rootfs optimized for development
- Pre-configured with Sakura theming (pink prompts, cherry blossom art)
- Integrates with the Sakura package manager (`sak`)
- Runs on WSL2 but branded as **SakLinux**
- Auto-installs dev tools on first launch
- Your own subsystem, not Microsoft's

## Install

```powershell
sak install saklinux
```

It will ask:
```
  Install SakLinux within WSL2? [Y/n]: y

  Which desktop environment?
  → [1] None (headless, minimal)
    [2] GNOME
    [3] KDE Plasma
    [4] XFCE (lightweight)

  Install Sakura package manager in SakLinux? [Y/n]: y
```

## Launch

```powershell
saklinux                    # via shim
wsl -d SakLinux            # direct
```

## Features

- 🌸 Full Sakura theming
- 📦 Built-in `sak` package manager
- 🔧 Pre-installed: git, node, python, rust, go
- 🎨 Custom prompt with cherry blossom colors
- 🐧 Runs any Linux binary via WSL2
- 🔄 Auto-updates with `sak updt`
- 📁 Access Windows files from `/mnt/c`

## Build

```powershell
# Build the rootfs
.\build.ps1

# Creates saklinux-rootfs.tar.gz
```

## License

MIT - Free to use and modify.
