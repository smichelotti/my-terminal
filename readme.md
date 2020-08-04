# my-terminal

This repo contains everything I used to set up my customized [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab) with [PowerShell Core](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7).

## Windows Terminal Setup

### Baseline oh-my-posh install

Install [posh-git](https://github.com/dahlbyk/posh-git) and [oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh) by following the excellent instructions [here by Scott Hanselman](https://www.hanselman.com/blog/HowToMakeAPrettyPromptInWindowsTerminalWithPowerlineNerdFontsCascadiaCodeWSLAndOhmyposh.aspx).

### Customizations

#### Custom Posh Theme

Locate your PowerShell profile file by running `$profile` at a PowerShell prompt. Note the directory - it will be something like: `C:\Users\<username>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`. Copy the `PoshThemes` folder (which contains paradox-michelotti.psm1) into this folder - so you'll have something like this:
`C:\Users\<username>\Documents\PowerShell\PoshThemes\paradox-michelotti.psm1`.

#### PowerShell $profile file

In your Microsoft.PowerShell_profile.psm1 file, make sure you have:

`Set-Theme Paradox-Michelotti`

Also, make sure `$DefaultUser` is assigned. Example can be seen [here](Microsoft.PowerShell_profile.ps1).

#### Windows Terminal settings.json file

Windows Terminal [settings.json file here](settings.json).

### Git Aliases

```shell
alias.l=log --graph --decorate --pretty=oneline --abbrev-commit
alias.new=!git init && git symbolic-ref HEAD refs/heads/main
alias.co=checkout
```

### AutoHotKey

The following snippet uses [AutoHotKey](https://www.autohotkey.com/) to focus the terminal on-demand using Alt+Z.

```shell
;***********************************************************
; *** Alt+Z to start (or re-focus) Windows Terminal ***
!z::
if WinExist("ahk_exe WindowsTerminal.exe")
{
    WinActivate
}
else
{
    Run "C:\Users\stemi\AppData\Local\Microsoft\WindowsApps\wt.exe"
}
return
```
