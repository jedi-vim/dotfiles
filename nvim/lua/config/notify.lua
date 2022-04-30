---@diagnostic disable-next-line: unused-function, unused-local
local function setup_notify()
    require("notify").setup { stages = "fade_in_slide_out", timeout = 5000 }
end

-- Notifications
-- vim.notify = require("notify")
