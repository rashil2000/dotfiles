if ($PSVersionTable.PSVersion.Major -le 5) { $OutputEncoding = New-Object System.Text.UTF8Encoding }

<# Aliases and Functions #>
Remove-Item -Force -ErrorAction Ignore Alias:lp, Alias:sc, Alias:curl, Alias:wget, `
  Alias:fc, Alias:dir, Alias:sort, Alias:write, Alias:where, `
  Alias:h, Alias:r, Alias:ls, Alias:cp, Alias:mv, Alias:ps, Alias:rm, Alias:man, Alias:pwd, Alias:cat, Alias:kill, Alias:diff, Alias:clear, Alias:mount, Alias:sleep
Set-Alias pls PowerColorLS
Set-Alias mcm Measure-Command
Function :q { exit }
Function h { Set-Location ~ }
Function ghd { Set-Location $Env:DATA_DIR\GitHub }
Function prd { Set-Location $Env:DATA_DIR\Projects }
Function acd { Set-Location $Env:DATA_DIR\Documents\Academics }
Function dir { Get-ChildItem -Attributes !System -Force @args }
Function msvc {
  Import-Module "${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\BuildTools\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
  Enter-VsDevShell 0a68dd02 -DevCmdArguments '-arch=x64'
  Write-Host "[Enter-VsDevShell] Environment initialized for: 'x64'"
}
Function msys {
  & "$Env:DATA_DIR\Projects\Scripts\msys-env.ps1" @args
}

<# Line Editing Options #>
Set-PSReadLineOption `
  -EditMode Emacs `
  -PredictionSource History `
  -MaximumHistoryCount 10000 `
  -HistorySearchCursorMovesToEnd `
  -Colors @{ ListPredictionSelected = "$([char]0x1b)[48;5;243m" }
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
"~/Scoop/apps/ripgrep/current/complete/_rg.ps1", `
"~/Scoop/apps/hyperfine/current/_hyperfine.ps1", `
"~/Scoop/apps/fd/current/_fd.ps1", `
"~/Scoop/apps/bottom/current/completion/_btm.ps1", `
"~/Scoop/apps/mdcat/current/completions/_mdcat.ps1", `
"~/.local/share/starship.ps1", `
"$Env:DATA_DIR/Projects/Scripts/Completions/_starship.ps1" `
  | ForEach-Object { if (Test-Path $_) { & $_ } }
Invoke-Expression (Get-Content "$Env:DATA_DIR/Projects/Scripts/Completions/_gh.ps1" -Raw)

<# Import Modules #>
Import-Module Terminal-Icons, scoop-completion, npm-completion, posh-cargo, posh-git, kmt.winget.autocomplete -ErrorAction Ignore
