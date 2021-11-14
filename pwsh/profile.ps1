if ($PSVersionTable.PSVersion.Major -le 5) { $OutputEncoding = [System.Text.Encoding]::UTF8 }

Remove-Item -Force -ErrorAction Ignore Alias:lp, Alias:sc, Alias:curl, Alias:wget, `
  Alias:fc, Alias:dir, Alias:sort, Alias:write, Alias:where, `
  Alias:h, Alias:r, Alias:ls, Alias:cp, Alias:mv, Alias:ps, Alias:rm, Alias:man, Alias:pwd, Alias:cat, Alias:kill, Alias:diff, Alias:clear, Alias:mount, Alias:sleep

$Env:FZF_ALT_C_COMMAND  = 'fd -H -L -E .git -t d'
$Env:FZF_ALT_C_OPTS     = '--preview "exa -a --icons --group-directories-first --color=always {}"'
$Env:FZF_CTRL_T_COMMAND = 'fd -H -L -E .git -t f'
$Env:FZF_CTRL_T_OPTS    = '--preview "bat --color=always --line-range=:500 {}"'
$Env:FZF_DEFAULT_OPTS   = '--exact --no-sort --reverse --cycle --height 40%'

