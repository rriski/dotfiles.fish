_G.LVIM_NVIM_VERSION = vim.version()
if _G.LVIM_NVIM_VERSION.major == 0 and _G.LVIM_NVIM_VERSION.minor < 9 then
    print("LVIM IDE requires Neovim >= 0.9.0")
elseif not vim.g.vscode then
    require("core")
end
