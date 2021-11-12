;= @echo OFF

;= :: Completions loaded with `clink installscripts` command

;= :: Some variables
;= set ClinkReadlineHistory=%LocalAppData%\clink\clink_history
;= set ClinkInit=%LocalAppData%\clink\clink_start.cmd
;= for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b

;= :: Aliases and functions
;= doskey /macrofile=%0%
;= goto end

:q=exit
h=cd /d %UserProfile%
d=cd /d %UserProfile%\Desktop
ghd=cd /d %UserProfile%\GitHub
acd=cd /d %UserProfile%\Documents\Academics
dir=exa -la --icons --git --group-directories-first $*
msvc="%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
msys=%UserProfile%\GitHub\rashil2000\Scripts\msys-env.bat $1 $2
nvs=%UserProfile%\.nvs\nvs.cmd $*
mkcd=mkdir $1 $T cd /d $1
gccd=git clone git@github.com:$1/$2.git $T cd $2

;= :end
;=
