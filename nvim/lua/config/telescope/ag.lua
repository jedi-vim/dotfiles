local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require "telescope.sorters"
local utils = require("telescope.utils")
local conf = require("telescope.config").values
local make_entry = require"telescope.make_entry"
local flatten = vim.tbl_flatten

local escape_chars = function(string)
  return string.gsub(string, "[%(|%)|\\|%[|%]|%-|%{%}|%?|%+|%*|%^|%$|%.]", {
    ["\\"] = "\\\\",
    ["-"] = "\\-",
    ["("] = "\\(",
    [")"] = "\\)",
    ["["] = "\\[",
    ["]"] = "\\]",
    ["{"] = "\\{",
    ["}"] = "\\}",
    ["?"] = "\\?",
    ["+"] = "\\+",
    ["*"] = "\\*",
    ["^"] = "\\^",
    ["$"] = "\\$",
    ["."] = "\\.",
  })
end

-- Find root of git directory and remove trailing newline characters
function find_git_root_dir(opts)
  local git_root, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, opts.cwd)
  if ret ~= 0 then
    return nil
  else
    return git_root[1]
  end
end

local set_opts_cwd = function(opts)
  if opts.cwd then
    opts.cwd = vim.fn.expand(opts.cwd)
  else
    opts.cwd = vim.loop.cwd()
  end
  local git_root = find_git_root_dir(opts)
  if not git_root then
      error(opts.cwd .. " is not a git directory")
  end
  opts.cwd = git_root
end

function m_entry(entry)
    local split = vim.split(entry, ":")
    local rel_filepath = split[1]
    local git_root = find_git_root_dir({})
    local abs_filepath = git_root .. "/" .. rel_filepath
    local line_num = tonumber(split[2])
    return {
        value = entry,
        display = function(display_entry)
                        local hl_group
                        local display = utils.transform_path({}, display_entry.value)
                        display, hl_group = utils.transform_devicons(display_entry.path, display, false)
                        if hl_group then
                            return display, { { { 1, 3 }, hl_group } }
                        else
                            return display
                        end
                   end,
        ordinal = rel_filepath,
        filename = rel_filepath,
        path = abs_filepath,
        lnum = line_num,
    }
end

function fn_command(prompt)
    if prompt =="" then
        return nil
    elseif #prompt < 4 then
        return nil
    end
    local search = escape_chars(prompt)
    return flatten {'ag', search}
end

local M = {}
M.search = function(opts)
    opts = opts or {}
    set_opts_cwd(opts)
    pickers.new(opts, {
           prompt_title='Silver Searcher',
           finder=finders.new_job(fn_command, m_entry, nil, opts.cwd),
           previewer=conf.grep_previewer(opts),
           sorter = sorters.highlighter_only(opts),
    }):find()
end
-- M.search()
return M
