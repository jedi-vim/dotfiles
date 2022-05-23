local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local utils = require("telescope.utils")
local conf = require("telescope.config").values
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

local set_opts_cwd = function(opts)
  if opts.cwd then
    opts.cwd = vim.fn.expand(opts.cwd)
  else
    opts.cwd = vim.loop.cwd()
  end

  -- Find root of git directory and remove trailing newline characters
  local git_root, ret = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, opts.cwd)
  local use_git_root = utils.get_default(opts.use_git_root, true)

  if ret ~= 0 then
        local in_worktree = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" }, opts.cwd)
        local in_bare = utils.get_os_command_output({ "git", "rev-parse", "--is-bare-repository" }, opts.cwd)

        if in_worktree[1] ~= "true" and in_bare[1] ~= "true" then
          error(opts.cwd .. " is not a git directory")
        elseif in_worktree[1] ~= "true" and in_bare[1] == "true" then
          opts.is_bare = true
        end
  else
    if use_git_root then
      opts.cwd = git_root[1]
    end
  end
end

function m_entry(entry)
    local split = vim.split(entry, ":")
    local rel_filepath = split[1]
    local abs_filepath = vim.fn.getcwd() .. "/" .. rel_filepath
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
    local search = escape_chars(prompt)
    return flatten {'ag', '--vimgrep', search}
end

local M = {}
M.search = function(opts)
    opts = opts or {}
    set_opts_cwd(opts)
    pickers.new(opts, {
           prompt_title='Silver Searcher',
           finder=finders.new_job(fn_command, m_entry, nil, opts.cwd),
           previewer=conf.grep_previewer(opts)
    }):find()
end
M.search()
-- return M
