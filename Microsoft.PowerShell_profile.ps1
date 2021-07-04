<# Some variables #>
if ($PSVersionTable.PSVersion.Major -le 5) { $OutputEncoding = New-Object System.Text.UTF8Encoding }
$WTSettings = 'C:\Users\RashilGandhi\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json'
$PSReadlineHistory = 'C:\Users\RashilGandhi\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt'

<# Aliases and Functions #>
if ($PSVersionTable.PSVersion.Major -le 5) { Remove-Item -Force Alias:lp, Alias:sc, Alias:curl, Alias:wget }
Remove-Item -Force Alias:fc, Alias:dir, Alias:sort, Alias:write, Alias:where
Remove-Item -Force Alias:h, Alias:r, Alias:ls, Alias:cp, Alias:mv, Alias:ps, Alias:rm, Alias:man, Alias:pwd, Alias:cat, Alias:kill, Alias:diff, Alias:clear, Alias:mount, Alias:sleep
Set-Alias pls PowerColorLS
Set-Alias mcm Measure-Command
Set-Alias msys D:\Data\Projects\Scripts\msys-env.ps1
Function :q { exit }
Function h { Set-Location 'C:\Users\RashilGandhi' }
Function ghd { Set-Location 'D:\Data\GitHub' }
Function prd { Set-Location 'D:\Data\Projects' }
Function acd { Set-Location 'D:\Data\Documents\Academics\Semester 6' }
Function dir { Get-ChildItem -Attributes !System -Force @args }
Function msvc {
  Import-Module "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
  Enter-VsDevShell 0a68dd02 -DevCmdArguments '-arch=x64'
  Write-Host "[Enter-VsDevShell] Environment initialized for: 'x64'"
}

<# Line Editing Options #>
Set-PSReadLineOption -EditMode Emacs -PredictionSource History -MaximumHistoryCount 10000 -HistorySearchCursorMovesToEnd -Colors @{ListPredictionSelected="$([char]0x1b)[48;5;243m"}
if ($false) {
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
} else {
  Set-PSReadLineOption -PredictionViewStyle ListView
  Set-PSReadlineKeyHandler -Key Escape -Function Undo
}
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord

<# Import Completions #>
C:\Users\RashilGandhi\scoop\apps\ripgrep\current\complete\_rg.ps1
C:\Users\RashilGandhi\scoop\apps\hyperfine\current\_hyperfine.ps1
C:\Users\RashilGandhi\scoop\apps\fd\current\_fd.ps1
C:\Users\RashilGandhi\scoop\apps\bottom\current\completion\_btm.ps1
D:\Data\Projects\Scripts\Completions\_starship.ps1
D:\Data\Projects\Scripts\Completions\_procs.ps1
D:\Data\Projects\Scripts\Completions\_mdcat.ps1
Invoke-Expression (Get-Content D:\Data\Projects\Scripts\Completions\_gh.ps1 -Raw)

<# Import Modules #>
Import-Module Terminal-Icons, scoop-completion, npm-completion, posh-cargo, posh-git, kmt.winget.autocomplete
C:\Users\RashilGandhi\.local\share\starship.ps1
