local wezterm = require 'wezterm'

local M = {}

-- Cache for right status segments
local cache = {
  spotify = '',
  kube = '',
  memory = '',
  last_update_ms = 0,
}

local function is_process_running_windows(image)
  -- CSV output and no header; filter is ONE arg
  local ok, stdout, stderr = wezterm.run_child_process{
    "tasklist",
    "/FI", ("IMAGENAME eq %s"):format(image),
    "/NH",
    "/FO", "CSV",
  }

  if not ok or not stdout then
    return false, stderr
  end

  -- first line, then first comma-separated token, then equality check
  local first = (stdout:match("([^\r\n]+)") or ""):match("^([^,]+)") or ""
  return first:lower() == ('"' .. image .. '"'):lower()
end

local function is_process_running_unix(image)
  -- -x: exact match of the process name
  local ok, _, _ = wezterm.run_child_process{
    "pgrep",
    "-x",
    image,
  }

  return ok
end

local function is_process_running(image)
  if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    return is_process_running_windows(image .. '.exe')
  end
  return is_process_running_unix(image)
end

local function get_playback_status()
  -- Check if spotify_player process is running
  if not is_process_running('spotify_player') then
      return ''
  end

  local success, result, _ = wezterm.run_child_process{
    'spotify_player',
    'get',
    'key',
    'playback'
  }

  if not success or not result then
      return "1N/A"
  end

  -- Trim whitespace
  result = result:gsub("^%s*(.-)%s*$", "%1")

  if result == "null" then
    return "2N/A"
  end

  local status_data = wezterm.json_parse(result)
  local is_playing, track_name = status_data.is_playing, status_data.item.name

  -- Handle track name (nil if not found or null)
  if not track_name or track_name == "null" or track_name == "" then
      track_name = nil
  end

  if is_playing == nil and track_name == nil then
      return "󰎊"
  elseif is_playing == false and track_name then
      return "󰏤 " .. track_name
  elseif is_playing == true and track_name then
      return "󰐊 " .. track_name
  else
      return ""
  end
end

local function get_memory_usage()
  -- the below command will give us the following output:
  --  13GiB/24GiB
  local pcall_ok, success, output, _ = pcall(wezterm.run_child_process, {
    'starship',
    'module',
    'memory_usage'
  })

  if not pcall_ok then
    return ''
  end

  if not success or not output or output == "" then
    return "1N/A"
  end

  -- Remove ANSI escape sequences (pattern matches ESC[ followed by any characters until 'm')
  output = output:gsub("\27%[[0-9;]*m", "")
  -- Trim whitespace from both ends
  output = output:match("^%s*(.-)%s*$")

  return output
end

local function get_current_kube_context()
  -- the below command will give us the following output:
  -- saas-qa01-aks\n
  local pcall_ok, success, output, _ = pcall(wezterm.run_child_process, {
    'kubectl',
    'config',
    'current-context'
  })

  if not pcall_ok then
    return ''
  end

  if not success or not output or output == "" then
    return "1N/A"
  end

  -- Trim whitespace from both ends
  return '󱃾 ' .. output:match("^%s*(.-)%s*$")
end

-- Returns true if we should refresh based on the effective status update interval
local function is_stale(window)
  local now_ms = os.time() * 1000
  local interval_ms = window:effective_config().status_update_interval
  return (now_ms - cache.last_update_ms) >= interval_ms
end

local function refresh_cache()
  -- Update synchronously; this runs at most as often as status_update_interval
  cache.spotify = get_playback_status() or ''
  cache.memory = get_memory_usage() or ''
  cache.kube = get_current_kube_context() or ''
  cache.last_update_ms = os.time() * 1000
end

function M.get_right_status_segments(window, pane)
  local domain = pane:get_domain_name()
  local custom_title = pane:get_user_vars().WIN_TITLE
  local items = {}
  -- we can use `cols` to do conditional rendering of segments
  -- local cols = window:mux_window():active_tab():get_size().cols

  if domain == 'local' or domain == 'default' then
    local domain_display = ''
    if domain == 'default' then
      domain_display = 'MUX'
    end

    if is_stale(window) then
      refresh_cache()
    end

    items = {
      cache.spotify,
      cache.kube,
      cache.memory,
      domain_display,
      custom_title
    }
  else
    local m = pane:get_metadata() or {}
    local ms = m.since_last_response_ms or ''

    items = {
      " ".. ms .. "ms",
      domain,
      custom_title
    }
  end

  -- Build segments and filter out empty values to avoid duplicate checks
  local result = {}
  for _, v in ipairs(items) do
    if v and v ~= '' then
      table.insert(result, v)
    end
  end
  return result
end

return M


