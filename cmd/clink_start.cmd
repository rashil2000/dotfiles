;= @echo OFF

;= :: Completions loaded with `clink installscripts` command

;= :: Some variables
;= set ClinkReadlineHistory=%LocalAppData%\clink\clink_history
;= set ClinkInit=%LocalAppData%\clink\clink_start.cmd
;= set FZF_ALT_C_COMMAND=fd -H -L -E .git -t d
;= set FZF_ALT_C_OPTS=--preview "eza -a --icons --group-directories-first --color=always {}"
;= set FZF_CTRL_T_COMMAND=fd -H -L -E .git -t f
;= set FZF_CTRL_T_OPTS=--preview "bat --color=always --line-range=:500 {}"
;= set FZF_DEFAULT_OPTS=--exact --no-sort --reverse --cycle --height 40%%
;= for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b

;= :: Aliases and functions
;= doskey /macrofile=%0%
;= goto end

:q=exit
h=cd /d %UserProfile%
d=cd /d %UserProfile%\Desktop
ghd=cd /d %UserProfile%\GitHub
acd=cd /d %UserProfile%\Documents\Academics
dir=eza -la --icons --git --group-directories-first $*
msvc="%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" -arch=x64
msys=%UserProfile%\GitHub\rashil2000\Scripts\msys-env.bat $1 $2
nvs=%UserProfile%\.nvs\nvs.cmd $*
mkcd=mkdir $1 $T cd /d $1
gccd=git clone git@github.com:$1.git && (for /f "tokens=1-2 delims=/" %a in ("$1") do @cd %b)

;= :end
;=
