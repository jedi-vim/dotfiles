local ok, spectre = pcall(require, "spectre")
if not ok then
  return
end

spectre.setup{}
local spectre_custom_open = function ()
  local utils = require"utils"
  spectre.open{
    cwd = utils.find_git_root_dir()
  }
end

vim.keymap.set("n", "<Leader>e", spectre_custom_open, {desc="Sp[e]ctre"})
