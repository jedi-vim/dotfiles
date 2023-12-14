-- Find root of git directory and remove trailing newline characters
local tl_utils = require("telescope.utils")
local M = {}

M.find_git_root_dir = function()
  local git_root, ret = tl_utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel" }, vim.fn.getcwd())
  if ret ~= 0 then
    return nil
  else
    return git_root[1]
  end
end

return M
