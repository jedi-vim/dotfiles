local ok, zone = pcall(require, "zone")
if not ok then
    return
end

zone.setup{
    after = 10,
    style = "epilepsy",
}
