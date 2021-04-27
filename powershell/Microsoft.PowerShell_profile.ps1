<# Some variables #>
$WTSettings = 'C:\Users\RashilGandhi\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json'
$PSReadlineHistory = 'C:\Users\RashilGandhi\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt'

<# Change to a safe location #>
# if ((Get-Location).Path -in 'D:\Data\Projects\Scripts', 'C:\Program Files\WindowsApps\Microsoft.WindowsTerminalPreview_1.6.10272.0_x64__8wekyb3d8bbwe') { Set-Location 'C:\Users\RashilGandhi' }

<# Aliases and Functions #>
Remove-Item -Force Alias:fc, Alias:sc, Alias:dir, Alias:curl, Alias:sort, Alias:write, Alias:where
Remove-Item -Force Alias:h, Alias:r, Alias:ls, Alias:cp, Alias:lp, Alias:mv, Alias:ps, Alias:rm, Alias:man, Alias:pwd, Alias:cat, Alias:kill, Alias:wget, Alias:diff, Alias:sleep
Set-Alias pls PowerColorLS
Set-Alias mcm Measure-Command
Set-Alias bash 'C:\Users\RashilGandhi\.local\bin\bash.exe' # Override WSL Bash
Function p { colortool -q powershell.ini }
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

<# PSReadLine Options #>
Set-PSReadLineOption -EditMode Emacs -PredictionSource History -MaximumHistoryCount 10000 -HistorySearchCursorMovesToEnd # -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord

<# Import Completions and Modules #>
# C:\Users\RashilGandhi\scoop\apps\ripgrep\current\complete\_rg.ps1
# C:\Users\RashilGandhi\scoop\apps\hyperfine\current\_hyperfine.ps1
# C:\Users\RashilGandhi\scoop\apps\bottom\current\completion\_btm.ps1
# D:\Data\Projects\Scripts\_starship.ps1
# D:\Data\Projects\Scripts\_spt.ps1
Import-Module Terminal-Icons, scoop-completion, npm-completion, posh-cargo, posh-git
C:\Users\RashilGandhi\.local\share\starship.ps1
# Import-Module "PowerTab" -ArgumentList "C:\Users\RashilGandhi\Documents\WindowsPowerShell\PowerTabConfig.xml"
