#!/usr/bin/env -S pwsh -nop

if (!($IsWindows -or $PSVersionTable.PSVersion.Major -le 5)) { exit 1 }

$DotDir = "E:\GitHub\rashil2000\dotfiles"
$DocDir = [Environment]::GetFolderPath('MyDocuments')

$dryrun = $true

# Download dotfiles
if (!(Test-Path $DotDir)) {
    New-Item $DotDir -ItemType Directory -Force -WhatIf:$dryrun
    if (Get-Command git -ErrorAction Ignore) {
        git clone https://github.com/rashil2000/dotfiles $DotDir
    } else {
        Write-Warning "Git not found"
        exit 1
    }
}

# Setup Scoop
if (!(Get-Command scoop -ErrorAction Ignore)) {
    if ($Env:SCOOP) { Write-Host "Installing Scoop to $Env:SCOOP..." }
    Invoke-WebRequest get.scoop.sh -UseBasicParsing | Invoke-Expression
}

# Install apps
scoop install fd ripgrep bat bottom vifm ncspot neovim delta python fzf gdu gh gsudo clangd clink clink-completions busybox-lean nodejs-lts

# Setup configuration files
@{
    "$Env:AppData\bat\config"                                                              = "$DotDir\bat\config"
    "$Env:AppData\bottom\bottom.toml"                                                      = "$DotDir\bottom\bottom.toml"
    "$Env:AppData\ncspot\config.toml"                                                      = "$DotDir\ncspot\config.toml"
    "$Env:AppData\Vifm\vifmrc"                                                             = "$DotDir\vifm\vifmrc"
    "$Env:LocalAppData\clink\.inputrc"                                                     = "$DotDir\.inputrc"
    "$Env:LocalAppData\clink\clink_settings"                                               = "$DotDir\cmd\clink_settings"
    "$Env:LocalAppData\clink\clink_start.cmd"                                              = "$DotDir\cmd\clink_start.cmd"
    "$Env:LocalAppData\nvim\init.vim"                                                      = "$DotDir\nvim\init.vim"
    "$Env:LocalAppData\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState" = "$DotDir\wt"
#   "$Env:UserProfile\.bashrc"                                                             = "$DotDir\bash\.bashrc"
    "$Env:UserProfile\.config\git\config"                                                  = "$DotDir\git\config"
    "$Env:UserProfile\.config\starship.toml"                                               = "$DotDir\starship\starship.toml"
    "$Env:UserProfile\.config\tmux\tmux.conf"                                              = "$DotDir\tmux\tmux.conf"
    "$DocDir\PowerShell\coc.vim_profile.ps1"                                               = "$DotDir\pwsh\Microsoft.PowerShell_profile.ps1"
    "$DocDir\PowerShell\Microsoft.PowerShell_profile.ps1"                                  = "$DotDir\pwsh\Microsoft.PowerShell_profile.ps1"
    "$DocDir\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"                           = "$DotDir\pwsh\Microsoft.PowerShell_profile.ps1"
}.GetEnumerator() | ForEach-Object {
    # Check symbolic link health
    if ((Test-Path $_.Name) `
        -and ((Get-Item $_.Name).LinkType -eq 'SymbolicLink') `
        -and ((Get-Item $_.Name).Target -eq $_.Value)) {
            continue
    }

    # Check parent directory
    if (!(Test-Path (Split-Path $_.Name))) {
        New-Item (Split-Path $_.Name) -ItemType Directory -Force -WhatIf:$dryrun
    }

    New-Item -Type SymbolicLink $_.Name -Target $_.Value -Force -WhatIf:$dryrun
}

@{
#   "$Env:UserProfile\.profile"             = "$DotDir\bash\.profile"
    "$DocDir\PowerShell\Profile.ps1"        = "$DotDir\pwsh\profile.ps1"
    "$DocDir\WindowsPowerShell\Profile.ps1" = "$DotDir\pwsh\profile.ps1"
}.GetEnumerator() | ForEach-Object {
    if (!(Test-Path $_.Name)) {
        Copy-Item $_.Value $_.Name -WhatIf:$dryrun
    }
}

# Setup Neovim
if (!(Test-Path "$Env:LocalAppData\nvim-data\site\autoload\plug.vim")) {
    Invoke-WebRequest raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -UseBasicParsing |`
        New-Item "$Env:LocalAppData\nvim-data\site\autoload\plug.vim" -Force -WhatIf:$dryrun
}

# Setup Starship
if (Get-Command starship -ErrorAction Ignore) {
    if (!(Test-Path "$Env:UserProfile\.local\share")) {
        New-Item "$Env:UserProfile\.local\share" -ItemType Directory -Force -WhatIf:$dryrun
    }

    if (!(Test-Path "$Env:UserProfile\.local\share\starship.ps1")) {
        starship init powershell --print-full-init | Out-File "$Env:UserProfile\.local\share\starship.ps1" -WhatIf:$dryrun
    }

    if (!(Test-Path "$Env:LocalAppData\clink\starship.lua")) {
        starship init cmd | Out-File "$Env:LocalAppData\clink\starship.lua" -WhatIf:$dryrun
    }
}

# Random
if (Get-Command npm -ErrorAction Ignore) {
    npm install -g neovim markserv
}
if (Get-Command pip -ErrorAction Ignore) {
    pip install pynvim wheel pipdeptree
    pip install git+https://github.com/imba-tjd/pip-autoremove@ups
}
if (Get-Command clink -ErrorAction Ignore) {
    $scoopdir = if ($Env:SCOOP) { $Env:SCOOP } else { "$Env:UserProfile\Scoop" }
    clink autorun set "\`"$scoopdir\apps\clink\current\clink.bat\`" inject --autorun --quiet"
}
