local ok, notify = pcall(require, "notify")
if not ok then
    return
end

---@diagnostic disable-next-line: unused-function, unused-local
notify.setup { stages = "fade_in_slide_out", timeout = 5000 }
vim.notify = notify
