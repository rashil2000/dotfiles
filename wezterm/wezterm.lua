local wezterm = require 'wezterm';
local segments = require 'segments';
local colors = require 'colors';
local keys = require 'keys';
local config = wezterm.config_builder();

local function is_appearance_dark()
  local appearance = (wezterm.gui and wezterm.gui.get_appearance()) or 'Light'
  return appearance:find("Dark")
end

local function get_title(tab, fg_color, bg_color, wg_bg_color, max_width)
  -- Figure out what title to show
  local pane = tab.active_pane
  local raw_title = tab.tab_title
  if raw_title == '' then
    raw_title = pane.title
    if string.match(raw_title, '[%.][eE][xX][eE]$') then
      raw_title = string.gsub(raw_title, '(.*[/\\])(.*)', '%2'):gsub('[%.][eE][xX][eE]$', '')
    end
  end
  if raw_title == '' then
    raw_title = pane.user_vars.WEZTERM_CMD
  end
  if raw_title == '' or raw_title == nil then
    raw_title = 'pwsh'
  end

  -- If there is progress, show that as well
  local foreground = fg_color
  local progress = pane.progress or 'None'
  if progress ~= 'None' then
      local color = 'green'
      local status
      if progress.Percentage ~= nil then
         status = string.format("%d%%", progress.Percentage)
      elseif progress.Error ~= nil then
         status = string.format("%d%%", progress.Error)
        color = 'red'
      elseif progress == 'Indeterminate' then
        status = '~'
      else
        status = wezterm.serde.json_encode(progress)
      end
      foreground = color
      raw_title = status .. ' ' .. raw_title
    end

  -- Ensure that the titles fit in the available space,
  local title_cells = max_width - 3 -- (leading space + trailing space + wedge)
  if title_cells < 0 then title_cells = 0 end
  local title = wezterm.truncate_right((tab.tab_index + 1) .. ': ' .. raw_title, title_cells)

  return {
    { Background = { Color = bg_color } },
    { Foreground = { Color = foreground } },
    { Text = ' ' .. title .. ' ' },

    { Background = { Color = wg_bg_color } },
    { Foreground = { Color = bg_color } },
    { Text = '' },
  }
end

wezterm.on('format-tab-title',
  function(tab, tabs, _, econfig, _, max_width)
    local color_scheme = econfig.resolved_palette
    local edge_background = color_scheme.tab_bar.background

    -- Build a gradient across the number of tabs
    local base_bg = wezterm.color.parse(color_scheme.background)
    local gradient_to, gradient_from = base_bg, base_bg
    if is_appearance_dark() then
      gradient_from = gradient_to:lighten(0.15)
    else
      gradient_from = gradient_to:darken(0.15)
    end
    local gradient = wezterm.color.gradient(
      {
        orientation = 'Horizontal',
        colors = { gradient_to, gradient_from },
      },
      #tabs > 0 and #tabs or 1
    )

    -- Use the tab index (0-based) to pick the colour for this tab
    local total_tabs = #tabs > 0 and #tabs or 1
    local current_index0 = tab.tab_index or 0
    local background = gradient[current_index0 + 1]
    local foreground = color_scheme.foreground

    -- Make the right wedge blend into the NEXT tab's background color
    local next_index0 = current_index0 + 1
    local next_background
    if next_index0 < total_tabs then
      next_background = gradient[next_index0 + 1]
    end

    return get_title(tab, foreground, background, next_background or edge_background, max_width)
  end
)

wezterm.on('update-status',
  function(window, pane)
    local segs = segments.get_right_status_segments(window, pane)
    local color_scheme = window:effective_config().resolved_palette

    -- wezterm.color.parse returns a Color object, which we can
    -- lighten or darken (amongst other things).
    local bg = wezterm.color.parse(color_scheme.background)
    local fg = color_scheme.foreground

    local gradient_to, gradient_from = bg, bg
    if is_appearance_dark() then
      gradient_from = gradient_to:lighten(0.15)
    else
      gradient_from = gradient_to:darken(0.15)
    end
    local gradient = wezterm.color.gradient(
      {
        orientation = 'Horizontal',
        colors = { gradient_from, gradient_to },
      },
      #segs -- as many colours as no. of segments
    )

    -- Build up the elements to send to wezterm.format
    local elements = {}

    for i, seg in ipairs(segs) do
      local is_first = i == 1

      if is_first then
        table.insert(elements, { Background = { Color = 'none' } })
      end
      table.insert(elements, { Foreground = { Color = gradient[i] } })
      table.insert(elements, { Text = '' })

      table.insert(elements, { Foreground = { Color = fg } })
      table.insert(elements, { Background = { Color = gradient[i] } })
      table.insert(elements, { Text = ' ' .. seg .. ' ' })
    end
    window:set_right_status(wezterm.format(elements))
  end
)

local colors_object
if is_appearance_dark() then
  colors_object = colors.theme_config.dark
else
  colors_object = colors.theme_config.light
end
config.colors = colors_object
config.command_palette_bg_color = colors_object.tab_bar.active_tab.bg_color
config.command_palette_fg_color = colors_object.tab_bar.active_tab.fg_color
config.keys = keys.bindings
config.mouse_bindings = keys.mouse_bindings
config.default_prog = { 'pwsh', '-l' }
config.initial_cols = 120
config.initial_rows = 40
config.scrollback_lines = 10000
config.max_fps = 120
config.switch_to_last_active_tab_when_closing_tab = true
config.window_decorations = "RESIZE"
config.enable_scroll_bar = true
config.font = wezterm.font("Cascadia Code")
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.status_update_interval = 10000
config.set_environment_variables = {
  POWERSHELL_UPDATECHECK= "Off",
}
config.unix_domains = {
  { name = "default" }
}

return config;
