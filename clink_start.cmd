@echo OFF

:: Some variables
set ClinkReadlineHistory=%LocalAppData%\clink\clink_history
set ClinkInit=%LocalAppData%\clink\clink_start.cmd
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b

:: Aliases and functions
doskey :q=exit
doskey h=cd /d %UserProfile%
doskey ghd=cd /d %DATA_DIR%\GitHub
doskey prd=cd /d %DATA_DIR%\Projects
doskey acd=cd /d %DATA_DIR%\Documents\Academics
doskey dir=exa -la --icons --git --group-directories-first $*
doskey msvc="%ProgramFiles(x86)%\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
doskey msys=%DATA_DIR%\Projects\Scripts\msys-env.bat $1 $2