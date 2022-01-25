<# Aliases and Functions #>
Set-Alias mcm Measure-Command
Set-Alias nvs ~/.nvs/nvs.ps1
Function :q { exit }
Function h { Set-Location ~ }
Function d { Set-Location ~/Desktop }
Function ghd { Set-Location ~/GitHub }
Function acd { Set-Location ~/Documents/Academics }
Function dir { Get-ChildItem -Attributes !System -Force @args }
Function msvc {
  Import-Module "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
  Enter-VsDevShell 0a68dd02 -DevCmdArguments '-arch=x64'
  Write-Host "[Enter-VsDevShell] Environment initialized for: 'x64'"
}
Function msys { . "~\GitHub\rashil2000\scripts\msys-env.ps1" @args }
Function mkcd {
  New-Item @args -ItemType Directory -Force
  Set-Location @args
}
Function gccd {
  git clone "git@github.com:$args.git"
  if ($?) { Set-Location $args.Split('/')[1] }
}

<# Line Editing Options #>
Set-PSReadLineOption `
  -EditMode Emacs `
  -PredictionSource History `
  -MaximumHistoryCount 50000 `
  -ExtraPromptLineCount 2 `
  -HistorySearchCursorMovesToEnd `
  -Colors @{ ListPredictionSelected = "$([char]0x1b)[48;5;243m" } `
  -AddToHistoryHandler {
    Param([string]$line)
    $line -notin 'exit', 'dir', ':q', 'cls', 'history', 'Get-PSReadLineOption', '$PWD', '$PSVersionTable', '$Host.UI.RawUI.WindowSize'
  }
if ($Host.UI.RawUI.WindowSize.Width -lt 54 -or $Host.UI.RawUI.WindowSize.Height -lt 15) {
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
if (Test-Path "~/GitHub/rashil2000/scripts/completions" -PathType Container) {
  Get-ChildItem "~/GitHub/rashil2000/scripts/completions/_*.ps1" `
    | ForEach-Object { . $_ }
}

<# Miscellaneous Settings #>
if ($PSVersionTable.PSVersion.Major -gt 5) {
  Set-MarkdownOption `
    -LinkForegroundColor "[5;4;38;5;117m" `
    -ItalicsForegroundColor "[3m"
}
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

<# Enable Starship prompt #>
if (Test-Path "~/.local/share/starship.ps1" -PathType Leaf) {
  . "~/.local/share/starship.ps1"
}

<# Import Modules #>
Import-Module Terminal-Icons, scoop-completion, npm-completion, posh-cargo, posh-git, kmt.winget.autocomplete -ErrorAction Ignore
