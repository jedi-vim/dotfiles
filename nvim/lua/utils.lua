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

M.move_buf = function(n)
  if n == 0 then return end -- if n = 0 then no shifts are needed
  local bufs = vim.api.nvim_list_bufs() -- make temp variable
  for i, bufnr in ipairs(bufs) do -- loop to find current buffer
    if bufnr == vim.api.nvim_get_current_buf() then -- found index of current buffer
      for _ = 0, (n % #bufs) - 1 do -- calculate number of right shifts
        local new_i = i + 1 -- get next i
        if i == #bufs then -- if at end, cycle to beginning
          new_i = 1 -- next i is actually 1 if at the end
          local val = bufs[i] -- save value
          table.remove(bufs, i) -- remove from end
          table.insert(bufs, new_i, val) -- insert at beginning
        else -- if not at the end,then just do an in place swap
          bufs[i], bufs[new_i] = bufs[new_i], bufs[i]
        end
        i = new_i -- iterate i to next value
      end
      break
    end
  end
  vim.t.bufs = bufs -- set buffers
  vim.cmd.redrawtabline() -- redraw tabline
end

return M
