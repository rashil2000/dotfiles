local wezterm = require 'wezterm';
local segments = require 'segments';
local colors = require 'colors';
local keys = require 'keys';
local config = wezterm.config_builder();

local updated_path = os.getenv('PATH')

if wezterm.target_triple == 'aarch64-apple-darwin' then
  updated_path = wezterm.home_dir .. '/.cargo/bin:' ..
                 wezterm.home_dir .. '/.local/bin:' ..
                 '/opt/homebrew/bin:' ..
                 '/opt/homebrew/sbin:' ..
                 '/usr/local/bin:' ..
                 updated_path
end

local function is_appearance_dark()
  local appearance = (wezterm.gui and wezterm.gui.get_appearance()) or 'Light'
  return appearance:find("Dark")
end

wezterm.on('format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local color_scheme = config.resolved_palette
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
    local next_background = nil
    if next_index0 < total_tabs then
      next_background = gradient[next_index0 + 1]
    end

    local raw_title = tab.tab_title
    if raw_title == '' then
      local pane = tab.active_pane
      if pane.title == '' then
        raw_title = string.gsub(pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
      else
        raw_title = pane.title
      end
    end

    -- Ensure that the titles fit in the available space,
    local title_cells = max_width - 3 -- (leading space + trailing space + wedge)
    if title_cells < 0 then title_cells = 0 end
    local title = wezterm.truncate_right((tab.tab_index + 1) .. ': ' .. raw_title, title_cells)

    return {
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = ' ' .. title .. ' ' },

      { Background = { Color = next_background or edge_background } },
      { Foreground = { Color = background } },
      { Text = '' },
    }
  end
)

wezterm.on('update-status',
  function(window, _)
    local segments = segments.get_right_status_segments(window)
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
      #segments -- as many colours as no. of segments
    )

    -- Build up the elements to send to wezterm.format
    local elements = {}

    for i, seg in ipairs(segments) do
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

if is_appearance_dark() then
  config.colors = colors.theme_config.dark
else
  config.colors = colors.theme_config.light
end
config.keys = keys.bindings
config.default_prog = { 'pwsh', '-l' }
config.initial_cols = 90
config.initial_rows = 30
config.switch_to_last_active_tab_when_closing_tab = true
config.window_decorations = "RESIZE"
config.enable_scroll_bar = true
config.font = wezterm.font("Cascadia Code")
config.font_size = 13.0
config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.status_update_interval = 10000
config.set_environment_variables = {
  POWERSHELL_UPDATECHECK= "Off",
  PATH = updated_path,
}

return config;
