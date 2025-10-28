local wezterm = require 'wezterm';

local M = {}
local system_shell = { 'cmd' }
local bash_env = 'MINGW64'
if wezterm.target_triple == 'aarch64-apple-darwin' then
  system_shell = { 'zsh', '-l' }
  bash_env = ''
end

M.bindings = {
  -- Shortcuts
  {
    key = '<',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'nvim', '-c', 'edit '..wezterm.config_file..' | cd %:p:h' },
    },
  },
  {
    key = '>',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'pwsh', '-nop', '-c', 'nvim -c "edit $($PROFILE.CurrentUserAllHosts) | cd %:p:h"' },
    },
  },
  {
    key = '?',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'nvim', '-c', 'edit $MYVIMRC | cd %:p:h' },
    },
  },
  {
    key = '2',
    mods = 'ALT|CTRL',
    action = wezterm.action.SpawnCommandInNewTab {
      args = system_shell,
    },
  },
  {
    key = '3',
    mods = 'ALT|CTRL',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'bash', '-l' },
      set_environment_variables = { MSYSTEM = bash_env },
    },
  },
  {
    key = '4',
    mods = 'ALT|CTRL',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'nvim' },
    },
  },
  {
    key = '5',
    mods = 'ALT|CTRL',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'yazi' },
    },
  },
  {
    key = '6',
    mods = 'ALT|CTRL',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'btm' },
    },
  },
  {
    key = '7',
    mods = 'ALT|CTRL',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'spotify_player' },
    },
  },
  {
    key = '8',
    mods = 'ALT|CTRL',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'k9s' },
    },
  },
  -- Sends ESC + b and ESC + f sequence, which is used
  -- for telling your shell to jump back/forward.
  {
    key = 'LeftArrow',
    mods = 'META',
    action = wezterm.action.SendString '\x1bb',
  },
  {
    key = 'RightArrow',
    mods = 'META',
    action = wezterm.action.SendString '\x1bf',
  },
  -- Scroll up/down to previous/next prompt
  {
    key = 'UpArrow',
    mods = 'SHIFT',
    action = wezterm.action.ScrollToPrompt(-1)
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT',
    action = wezterm.action.ScrollToPrompt(1)
  },
  {
    key = '`',
    mods = 'CTRL',
    action = wezterm.action.ActivateLastTab,
  },
  {
    key = 'D',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.DetachDomain 'CurrentPaneDomain',
  },
  {
    key = 'H',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.Search { CaseInSensitiveString = '' },
  },
}

M.mouse_bindings = {
  -- Select output of entire command when triple-clicking
  {
    event = { Down = { streak = 3, button = 'Left' } },
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
  },
}

return M