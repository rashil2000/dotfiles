-- Set some variables
os.setenv('WTSettings', 'C:\\Users\\RashilGandhi\\AppData\\Local\\Packages\\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\\LocalState\\settings.json')
os.setenv('ClinkReadlineHistory', 'C:\\Users\\RashilGandhi\\AppData\\Local\\clink\\clink_history')
os.setenv('ClinkInit', 'D:\\Data\\Projects\\Scripts\\init.lua')

-- Enable Starship prompt
local custom_prompt = clink.promptfilter(5)
function custom_prompt:filter(prompt)
  return io.popen("C:\\Users\\RashilGandhi\\scoop\\shims\\starship.exe prompt"):read("*a")
end

-- Enable aliases/functions
os.execute('doskey /macrofile=C:\\Users\\RashilGandhi\\macros.doskey')
