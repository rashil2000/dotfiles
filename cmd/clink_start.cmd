@echo OFF

:: Completions loaded with `clink installscripts` command

:: Some variables
set ClinkReadlineHistory=%LocalAppData%\clink\clink_history
set ClinkInit=%LocalAppData%\clink\clink_start.cmd
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b

:: Aliases and functions
doskey :q=exit
doskey h=cd /d %UserProfile%
doskey d=cd /d %UserProfile%\Desktop
doskey ghd=cd /d %UserProfile%\GitHub
doskey acd=cd /d %UserProfile%\Documents\Academics
doskey dir=exa -la --icons --git --group-directories-first $*
doskey msvc="%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
doskey msys=%UserProfile%\GitHub\rashil2000\Scripts\msys-env.bat $1 $2
doskey nvs=%UserProfile%\.nvs\nvs.cmd $*
doskey mkcd=mkdir $1 $T cd /d $1
doskey gccd=git clone git@github.com:$1/$2.git $T cd $2
