local wezterm = require 'wezterm';

local M = {}

M.bindings = {
  -- Shortcuts
  {
    key = ',',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.config_dir,
      args = { 'nvim', wezterm.config_file },
    },
  },
  {
    key = '.',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'pwsh', "-nop", "-c", "cd (Split-Path $PROFILE); nvim $PROFILE.CurrentUserAllHosts" },
    },
  },
  {
    key = '/',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { "nvim", "-c", "edit $MYVIMRC | lcd %:p:h" },
    },
  },
  {
    key = "'",
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'spotify_player' },
    },
  },
  {
    key = ';',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'k9s' },
    },
  },
  {
    key = '[',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'yazi' },
    },
  },
  {
    key = ']',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      args = { 'btm' },
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
}

M.mouse_bindings = {
  -- Select output of entire command when triple-clicking
  {
    event = { Down = { streak = 3, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
  },
}

return M