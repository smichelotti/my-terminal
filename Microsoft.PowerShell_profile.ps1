Set-Alias -name k -value kubectl
Set-Alias -name tf -value terraform

function Import-Module-With-Measure {  
    param ($ModuleName)
    $import = Measure-Command {
        Import-Module $ModuleName
    }
    Write-Host "$ModuleName import $($import.TotalMilliseconds) ms"
}


Import-Module-With-Measure Terminal-Icons
Import-Module-With-Measure PSReadLine
Import-Module-With-Measure z


$env:AZ_ENABLED = $false
oh-my-posh --init --shell pwsh --config ~/Dropbox/utils/terminal/paradox-michelotti.omp.json | Invoke-Expression

### PSReadLine options ###

#dotnet completion
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {  
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}


### PSReadLine Options below ###

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# menu complete using TAB instead of CTRL+SPACE
#Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete  

# This key handler shows the entire or filtered history using Out-GridView. The
# typed text is used as the substring pattern for filtering. A selected command
# is inserted to the command line without invoking. Multiple command selection
# is supported, e.g. selected by Ctrl + Click.
Set-PSReadLineKeyHandler -Key F7 `
                         -BriefDescription History `
                         -LongDescription 'Show command history' `
                         -ScriptBlock {
    $pattern = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$pattern, [ref]$null)
    if ($pattern)
    {
        $pattern = [regex]::Escape($pattern)
    }

    $history = [System.Collections.ArrayList]@(
        $last = ''
        $lines = ''
        foreach ($line in [System.IO.File]::ReadLines((Get-PSReadLineOption).HistorySavePath))
        {
            if ($line.EndsWith('`'))
            {
                $line = $line.Substring(0, $line.Length - 1)
                $lines = if ($lines)
                {
                    "$lines`n$line"
                }
                else
                {
                    $line
                }
                continue
            }

            if ($lines)
            {
                $line = "$lines`n$line"
                $lines = ''
            }

            if (($line -cne $last) -and (!$pattern -or ($line -match $pattern)))
            {
                $last = $line
                $line
            }
        }
    )
    $history.Reverse()

    $command = $history | Out-GridView -Title History -PassThru
    if ($command)
    {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert(($command -join "`n"))
    }
}

### Azure functions for Windows Terminal ###

function Set-AzureCloud() {
  param([string]$cloud, [string]$img)

  az cloud set --name $cloud

  # Set background for Windows Terminal
  $settingsPath = "$env:LocalAppData\Packages\Microsoft.WindowsTerminalPreview_*\LocalState\settings.json"
  $json = (Get-Content $settingsPath -Raw) | ConvertFrom-Json -Depth 32
  $psProfile = $json.profiles.list.Where({$_.name -eq 'PowerShell'})
  $($psProfile).backgroundImage = "$home\Dropbox\utils\terminal\$img"
  $json | ConvertTo-Json -Depth 32 | Set-Content (Get-Item $settingsPath).FullName
}

function Set-AzPublic {
  Set-AzureCloud 'AzureCloud' 'azure-tr-236x225.png'
}

function Set-AzGov {
  Set-AzureCloud 'AzureUSGovernment' 'ages-tr-236x225.png'
}


### git utility functions ###

function gac() {
    git add .
    git commit -m $args[0]
}

function openrepo() {
    $repourl = git remote get-url --all origin
    start-process $repourl
}

function cpdirpath() {
    $dir = get-location
    set-clipboard $dir.path
}
