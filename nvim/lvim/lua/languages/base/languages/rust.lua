local global = require("core.global")
local lsp_manager = require("languages.utils.lsp_manager")
local ft = {
    "rust",
}
local nvim_lsp_util = require("lspconfig/util")
local navic = require("nvim-navic")
local default_debouce_time = 150
local dap = require("dap")

local language_configs = {}

local function start_server_tools()
    local rust_tools = require("rust-tools")
    rust_tools.setup({
        tools = {
            inlay_hints = {
                auto = false,
            },
            hover_actions = {
                border = {
                    { "┌", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "┐", "FloatBorder" },
                    { "│", "FloatBorder" },
                    { "┘", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "└", "FloatBorder" },
                    { "│", "FloatBorder" },
                },
            },
        },
        server = {
            flags = {
                debounce_text_changes = default_debouce_time,
            },
            autostart = true,
            filetypes = ft,
            on_attach = function(client, bufnr)
                lsp_manager.keymaps(client, bufnr)
                lsp_manager.omni(client, bufnr)
                lsp_manager.tag(client, bufnr)
                lsp_manager.document_highlight(client, bufnr)
                lsp_manager.document_formatting(client, bufnr)
                lsp_manager.inlay_hint(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end,
            capabilities = lsp_manager.get_capabilities(),
            root_dir = function(fname)
                return nvim_lsp_util.find_git_ancestor(fname) or vim.fn.getcwd()
            end,
        },
    })
end

language_configs["dependencies"] = { "rust-analyzer", "cpptools" }

language_configs["lsp"] = function()
    lsp_manager.setup_languages({
        ["language"] = "rust",
        ["ft"] = ft,
        ["dap"] = { "cpptools" },
        ["rust-analyzer"] = {},
    })

    local function check_status()
        if global.install_proccess == false then
            start_server_tools()
            vim.cmd("LspStart rust_analyzer")
        else
            vim.defer_fn(function()
                check_status()
            end, 3100)
        end
    end

    check_status()
end

language_configs["dap"] = function()
    dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = global.mason_path .. "/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
    }
    dap.configurations.rust = {
        {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = true,
        },
    }
end

return language_configs
