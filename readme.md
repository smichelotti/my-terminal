# my-terminal

This repo contains everything I used to set up my customized [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab) with [PowerShell Core](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7).

## Windows Terminal Setup

### Oh My Posh Install

Install [Oh My Posh](https://ohmyposh.dev/) (I prefer [winget](https://ohmyposh.dev/docs/windows)):

`winget install JanDeDobbeleer.OhMyPosh`

### Install PowerShell modules

These are the PowerShell modules I use that the $profile is dependent on.

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module PSReadLine -AllowPrerelease -Force
Install-Module -Name MagicTooltips -Repository PSGallery
```

### Cascadia Code Font

Download [Caskaydia Cove Nerd Font here](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip) and install the ttf fonts on Windows.

### Custom Oh My Posh Theme

<!-- Locate your PowerShell profile file by running `$profile` at a PowerShell prompt. Note the directory - it will be something like: `C:\Users\<username>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`. Copy the `PoshThemes` folder (which contains paradox-michelotti.psm1) into this folder - so you'll have something like this:
`C:\Users\<username>\Documents\PowerShell\PoshThemes\paradox-michelotti.psm1`. -->

The custom posh theme ([paradox-michelotti.omp.json](paradox-michelotti.omp.json)) is specified in the PowerShell $profile file ([Microsoft.PowerShell_profile](Microsoft.PowerShell_profile)).

Copy Microsoft.PowerShell_profile.ps1 from here to the $profile location:

```powershell
cp .\Microsoft.PowerShell_profile.ps1 $profile
```

Copy paradox-michelotti.omp.json to a shared location (this much match location in $profile):

```powershell
cp .\paradox-michelotti.omp.json ~/Dropbox/utils/terminal/paradox-michelotti.omp.json
```

This must match location in $profile file:

```powershell
oh-my-posh init pwsh --config ~/Dropbox/utils/terminal/paradox-michelotti.omp.json | Invoke-Expression
```

#### Windows Terminal settings.json file

Windows Terminal [settings.json file here](settings.json).

### Git Aliases

```shell
git config --global alias.l "log --graph --decorate --pretty=oneline --abbrev-commit"
git config --global alias.new "!git init && git symbolic-ref HEAD refs/heads/main"
git config --global alias.co checkout
git config --global alias.br branch
```

### AutoHotKey

The following snippet uses [AutoHotKey](https://www.autohotkey.com/) to focus the terminal on-demand using Alt+Z (yes, I know Quake mode exists, but I prefer default behavior).

```shell
;***********************************************************
; *** Alt+Z to start (or re-focus) Windows Terminal ***
!z::
if WinExist("ahk_exe WindowsTerminal.exe")
{
    WinActivate
}
return
```

* Save this AutoHotKey snippet to a file (e.g., ahk-global.ahk) - then create a Windows shortcut for that file
* Win+R -> `shell:startup` - move the shortcut file to this directory so it will run on Windows startup
