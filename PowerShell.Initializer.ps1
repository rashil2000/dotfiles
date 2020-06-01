"This script will install some basic utilities and tools in PowerShell."
"Only run it once after installing PowerShell."

"`nUpdating Help content. This will take some time on the first run."
Update-Help
"Done."

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

'`nInstalling posh-git...'
Install-Module -Name posh-git -Scope CurrentUser
"Done."

'`nInstalling oh-my-posh...'
Install-Module -Name oh-my-posh -Scope CurrentUser
"Done."

'`nInstalling Terminal-Icons...'
Install-Module -Name Terminal-Icons -Scope CurrentUser
"Done."

'`nInstalling PSReadline...'
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
"Done."

'`nInstalling PSUnixUtilCompleters...'
Install-Module -Name Microsoft.PowerShell.UnixCompleters -Scope CurrentUser
"Done."

$TelemetryOption = Read-Host "Do you want to opt out of telemetry? Telemetry means collection of OS version and PowerShell version. [y/n]"
if ($TelemetryOption -eq 'y'){
  if (Test-Path ~/.zshrc){
    "`nWriting to .zshrc"
    Add-Content ~/.zshrc "export POWERSHELL_TELEMETRY_OPTOUT=1"
    "Done."
  }
  elseif (Test-Path ~/.bashrc){
    "`nWriting to .bashrc"
    Add-Content ~/.bashrc "export POWERSHELL_TELEMETRY_OPTOUT=1"
    "Done."
  }
}

if (!(Test-Path -Path $PROFILE )) {
  New-Item -Type File -Path $PROFILE -Force
}

$DefaultProfileOptions = "Function ContentAliasFunc {Get-ChildItem -Force}
Set-Alias -Name gci -Value ContentAliasFunc -Force
Set-Alias -Name dir -Value ContentAliasFunc -Option AllScope
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-Prompt
Import-Module -Name Terminal-Icons"

Add-Content $PROFILE $DefaultProfileOptions

"`nTo see the list of available themes, Run 'Get-Theme'. Select the theme name from there (case-sensitive)."
"Then Run 'Add-Content `$PROFILE 'Set-Theme <the name you selected above>''."

"`nSome modules/scripts use the 'Sort' alias. This however will not work on *nix systems because 'sort' is a built-in command there."
"If you want this to work, Run 'Add-Content `$PROFILE 'Set-Alias Sort Sort-Object''."
"To reset this, Run 'Add-Content `$PROFILE 'Remove-Alias Sort''."

"`nExit pwsh now, source your .bashrc/.zshrc, and restart by doing 'pwsh -nol'."
