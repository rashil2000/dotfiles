@echo OFF

:: Some variables
set WTSettings=C:\Users\RashilGandhi\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json
set ClinkReadlineHistory=C:\Users\RashilGandhi\AppData\Local\clink\clink_history
set ClinkSettings=C:\Users\RashilGandhi\AppData\Local\clink\clink_settings
set ClinkInit=C:\Users\RashilGandhi\AppData\Local\clink\clink_start.cmd
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set ESC=%%b

:: Aliases and functions
doskey :q=exit
doskey h=cd /d C:\Users\RashilGandhi
doskey ghd=cd /d D:\Data\GitHub
doskey prd=cd /d D:\Data\Projects
doskey acd=cd /d D:\Data\Documents\Academics\Semester 6
doskey dir=exa -la --icons --git --group-directories-first $*
doskey msvc="C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
