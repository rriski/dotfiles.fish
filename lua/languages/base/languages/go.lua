local languages_setup = require("languages.base.utils")
local gopls_config = require("languages.base.languages._configs").go({ "go", "gomod" }, "go")
local dap = require("dap")

local language_configs = {}

language_configs["dependencies"] = { "gopls", "delve", "golangci-lint" }

language_configs["lsp"] = function()
    languages_setup.setup_languages({
        ["language"] = "go",
        ["dap"] = { "delve" },
        ["gopls"] = { "gopls", gopls_config },
        ["dependencies"] = {
            "golangci-lint",
        },
    })
end

language_configs["dap"] = function()
    dap.adapters.go = function(callback)
        local handle
        local port = 38697
        handle = vim.loop.spawn("dlv", {
            args = { "dap", "-l", "127.0.0.1:" .. port },
            detached = true,
        }, function(code)
            handle:close()
        end)
        vim.defer_fn(function()
            callback({ type = "server", host = "127.0.0.1", port = port })
        end, 100)
    end
    dap.configurations.go = {
        {
            type = "go",
            name = "Launch",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
        },
        {
            type = "go",
            name = "Launch test",
            request = "launch",
            mode = "test",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
        },
    }
end

return language_configs
