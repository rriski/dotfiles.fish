local icons = require("configs.base.ui.icons")

local config = {}

config.mason_nvim = function()
    vim.api.nvim_create_user_command(
        "LvimInstallLangDependencies",
        "lua require('languages.base.utils').install_all_packages()",
        {}
    )
    vim.api.nvim_create_user_command("LspHover", "lua vim.lsp.buf.hover()", {})
    vim.api.nvim_create_user_command("LspRename", "lua vim.lsp.buf.rename()", {})
    vim.api.nvim_create_user_command("LspFormat", "lua vim.lsp.buf.format {async = true}", {})
    vim.api.nvim_create_user_command("LspCodeAction", "lua vim.lsp.buf.code_action()", {})
    vim.api.nvim_create_user_command(
        "LspShowDiagnosticCurrent",
        "lua require('languages.base.utils.show_diagnostic').line()",
        {}
    )
    vim.api.nvim_create_user_command(
        "LspShowDiagnosticNext",
        "lua require('languages.base.utils.show_diagnostic').goto_next()",
        {}
    )
    vim.api.nvim_create_user_command(
        "LspShowDiagnosticPrev",
        "lua require('languages.base.utils.show_diagnostic').goto_prev()",
        {}
    )
    vim.api.nvim_create_user_command("LspDefinition", "lua vim.lsp.buf.definition()", {})
    vim.api.nvim_create_user_command("LspTypeDefinition", "lua vim.lsp.buf.type_definition()", {})
    vim.api.nvim_create_user_command("LspDeclaration", "lua vim.lsp.buf.declaration()", {})
    vim.api.nvim_create_user_command("LspReferences", "lua vim.lsp.buf.references()", {})
    vim.api.nvim_create_user_command("LspImplementation", "lua vim.lsp.buf.implementation()", {})
    vim.api.nvim_create_user_command("LspSignatureHelp", "lua vim.lsp.buf.signature_help()", {})
    vim.api.nvim_create_user_command("LspDocumentSymbol", "lua vim.lsp.buf.document_symbol()", {})
    vim.api.nvim_create_user_command("LspWorkspaceSymbol", "lua vim.lsp.buf.workspace_symbol()", {})
    vim.api.nvim_create_user_command("LspCodeLensRefresh", "lua vim.lsp.codelens.refresh()", {})
    vim.api.nvim_create_user_command("LspCodeLensRun", "lua vim.lsp.codelens.run()", {})
    vim.api.nvim_create_user_command("LspAddToWorkspaceFolder", "lua vim.lsp.buf.add_workspace_folder()", {})
    vim.api.nvim_create_user_command("LspRemoveWorkspaceFolder", "lua vim.lsp.buf.remove_workspace_folder()", {})
    vim.api.nvim_create_user_command("LspListWorkspaceFolders", "lua vim.lsp.buf.list_workspace_folders()", {})
    vim.api.nvim_create_user_command("LspIncomingCalls", "lua vim.lsp.buf.incoming_calls()", {})
    vim.api.nvim_create_user_command("LspOutgoingCalls", "lua vim.lsp.buf.outgoing_calls()", {})
    vim.api.nvim_create_user_command("LspClearReferences", "lua vim.lsp.buf.clear_references()", {})
    vim.api.nvim_create_user_command("LspDocumentHighlight", "lua vim.lsp.buf.document_highlight()", {})
    vim.api.nvim_create_user_command(
        "LspShowDiagnosticCurrent",
        "lua require('languages.base.utils.show_diagnostic').line()",
        {}
    )
    vim.api.nvim_create_user_command(
        "LspShowDiagnosticNext",
        "lua require('languages.base.utils.show_diagnostic').goto_next()",
        {}
    )
    vim.api.nvim_create_user_command(
        "LspShowDiagnosticPrev",
        "lua require('languages.base.utils.show_diagnostic').goto_prev()",
        {}
    )
    vim.api.nvim_create_user_command("DAPLocal", "lua require('languages.base.utils').dap_local()", {})
    vim.keymap.set("n", "<C-c><C-l>", function()
        vim.cmd("DAPLocal")
    end, { noremap = true, silent = true, desc = "DAPLocal" })
    vim.keymap.set("n", "dc", function()
        vim.cmd("LspShowDiagnosticCurrent")
    end, { noremap = true, silent = true, desc = "LspShowDiagnosticCurrent" })
    vim.keymap.set("n", "dn", function()
        vim.cmd("LspShowDiagnosticNext")
    end, { noremap = true, silent = true, desc = "LspShowDiagnosticNext" })
    vim.keymap.set("n", "dp", function()
        vim.cmd("LspShowDiagnosticPrev")
    end, { noremap = true, silent = true, desc = "LspShowDiagnosticPrev" })
    vim.keymap.set("n", "dl", function()
        vim.diagnostic.setloclist()
    end, { noremap = true, silent = true, desc = "LspShowDiagnosticInLocList" })
    local mason_status_ok, mason = pcall(require, "mason")
    if not mason_status_ok then
        return
    end
    mason.setup({
        ui = {
            icons = icons.mason,
        },
    })
    require("languages.base.utils").setup_diagnostic()
end

config.null_ls_nvim = function()
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
        return
    end
    local generators = require("null-ls.generators")
    local methods = require("null-ls.methods")
    null_ls.setup({
        debug = false,
        on_attach = function(client, bufnr)
            if client.server_capabilities.documentFormattingProvider then
                local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
                local method = methods.internal.FORMATTING
                local available = generators.get_available(filetype, method)
                if next(available) then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            if _G.LVIM_SETTINGS.autoformat == true then
                                vim.lsp.buf.format()
                            end
                        end,
                        group = "LvimIDE",
                    })
                end
            end
        end,
    })
end

config.neotest = function()
    local neotest_status_ok, neotest = pcall(require, "neotest")
    if not neotest_status_ok then
        return
    end
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
        virtual_text = {
            format = function(diagnostic)
                local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                return message
            end,
        },
    }, neotest_ns)
    neotest.setup({
        adapters = {
            require("neotest-phpunit"),
            require("neotest-rust"),
            require("neotest-go"),
            require("neotest-python")({
                dap = { justMyCode = false },
                args = { "--log-level", "DEBUG" },
                runner = "pytest",
            }),
            require("neotest-haskell"),
            require("neotest-elixir"),
            require("neotest-dart")({
                command = "flutter",
                use_lsp = true,
            }),
        },
    })
    vim.api.nvim_create_user_command("NeotestRun", function()
        require("neotest").run.run()
    end, {})
    vim.api.nvim_create_user_command("NeotestRunCurrent", function()
        require("neotest").run.run(vim.fn.expand("%"))
    end, {})
    vim.api.nvim_create_user_command("NeotestRunDap", function()
        require("neotest").run.run({ strategy = "dap" })
    end, {})
    vim.api.nvim_create_user_command("NeotestStop", function()
        require("neotest").run.stop()
    end, {})
    vim.api.nvim_create_user_command("NeotestAttach", function()
        require("neotest").run.attach()
    end, {})
    vim.api.nvim_create_user_command("NeotestOutput", function()
        require("neotest").output.open()
    end, {})
    vim.api.nvim_create_user_command("NeotestSummary", function()
        require("neotest").summary.toggle()
    end, {})
end

config.inc_rename_nvim = function()
    local inc_rename_status_ok, inc_rename = pcall(require, "inc_rename")
    if not inc_rename_status_ok then
        return
    end
    inc_rename.setup()
    vim.keymap.set("n", "gE", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, desc = "IncRename" })
end

config.glance_nvim = function()
    local glance = require("glance")
    local actions = glance.actions
    glance.setup({
        zindex = 20,
        border = {
            enable = true,
            top_char = " ",
            bottom_char = " ",
        },
        list = {
            width = 0.4,
        },
        theme = {
            enable = false,
        },
        indent_lines = {
            enable = true,
            icon = "▏",
        },
        mappings = {
            list = {
                ["j"] = actions.next,
                ["k"] = actions.previous,
                ["<Tab>"] = actions.next_location,
                ["<S-Tab>"] = actions.previous_location,
                ["<C-u>"] = actions.preview_scroll_win(5),
                ["<C-d>"] = actions.preview_scroll_win(-5),
                ["v"] = actions.jump_vsplit,
                ["s"] = actions.jump_split,
                ["t"] = actions.jump_tab,
                ["<CR>"] = actions.jump,
                ["o"] = actions.jump,
                ["<C-h>"] = actions.enter_win("preview"), -- Focus preview window
                ["<Esc>"] = actions.close,
                ["q"] = actions.close,
            },
            preview = {
                ["q"] = actions.close,
                ["<Tab>"] = actions.next_location,
                ["<S-Tab>"] = actions.previous_location,
                ["<C-l>"] = actions.enter_win("list"), -- Focus list window
            },
        },
        hooks = {
            before_open = function(results, open, jump, _)
                local uri = vim.uri_from_bufnr(0)
                if #results == 1 then
                    local target_uri = results[1].uri or results[1].targetUri
                    if target_uri == uri then
                        jump(results[1])
                    else
                        open(results)
                    end
                else
                    open(results)
                end
            end,
        },
    })
    vim.keymap.set("n", "gpd", "<Cmd>Glance definitions<CR>")
    vim.keymap.set("n", "gpr", "<Cmd>Glance references<CR>")
    vim.keymap.set("n", "gpt", "<Cmd>Glance type_definitions<CR>")
    vim.keymap.set("n", "gpi", "<Cmd>Glance implementations<CR>")
end

config.neodev_nvim = function()
    local neodev_status_ok, neodev = pcall(require, "neodev")
    if not neodev_status_ok then
        return
    end
    neodev.setup({
        library = {
            enabled = true,
            runtime = true,
            types = true,
            plugins = false,
        },
    })
end

config.go_nvim = function()
    local go_status_ok, go = pcall(require, "go")
    if not go_status_ok then
        return
    end
    go.setup({
        lsp_inlay_hints = {
            enable = false,
        },
    })
end

config.flutter_tools_nvim = function()
    local languages_setup = require("languages.base.utils")
    local navic = require("nvim-navic")
    local flutter_tools_status_ok, flutter_tools = pcall(require, "flutter-tools")
    if not flutter_tools_status_ok then
        return
    end
    flutter_tools.setup({
        ui = {
            notification_style = "plugin",
        },
        debugger = {
            enabled = true,
            run_via_dap = false,
            exception_breakpoints = {},
            register_configurations = function(paths)
                local dap = require("dap")
                dap.adapters.dart = {
                    type = "executable",
                    command = "dart",
                    args = { "debug_adapter" },
                }
                dap.adapters.flutter = {
                    type = "executable",
                    command = "flutter",
                    args = { "debug_adapter" },
                }
                dap.configurations.dart = {
                    {
                        type = "dart",
                        name = "Launch Dart",
                        request = "launch",
                        dartSdkPath = paths["dart_sdk"],
                        flutterSdkPath = paths["flutter_sdk"],
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "flutter",
                        name = "Launch Flutter",
                        request = "launch",
                        dartSdkPath = paths["dart_sdk"],
                        flutterSdkPath = paths["flutter_sdk"],
                        program = function()
                            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                        end,
                        cwd = "${workspaceFolder}",
                    },
                }
            end,
        },
        closing_tags = {
            prefix = icons.common.separator .. " ",
            highlight = "LspInlayHint",
        },
        lsp = {
            on_attach = function(client, bufnr)
                languages_setup.keymaps(client, bufnr)
                languages_setup.omni(client, bufnr)
                languages_setup.tag(client, bufnr)
                languages_setup.document_highlight(client, bufnr)
                languages_setup.document_formatting(client, bufnr)
                languages_setup.inlay_hint(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end,
            capabilities = languages_setup.get_capabilities(),
        },
    })
end

config.typescript_nvim = function()
    local typescript_status_ok, typescript = pcall(require, "typescript")
    if not typescript_status_ok then
        return
    end
    typescript.setup()
end

config.nvim_lightbulb = function()
    local nvim_lightbulb_status_ok, nvim_lightbulb = pcall(require, "nvim-lightbulb")
    if not nvim_lightbulb_status_ok then
        return
    end
    nvim_lightbulb.setup({
        sign = {
            enabled = false,
            priority = 10,
        },
        virtual_text = {
            enabled = true,
            text = "",
            hl_mode = "combine",
        },
        autocmd = {
            enabled = true,
        },
    })
end

config.nvim_treesitter = function()
    local nvim_treesitter_configs_status_ok, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
    if not nvim_treesitter_configs_status_ok then
        return
    end
    nvim_treesitter_configs.setup({
        ensure_installed = "all",
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false,
            keybindings = {
                toggle_query_editor = "o",
                toggle_hl_groups = "i",
                toggle_injected_languages = "t",
                toggle_anonymous_nodes = "a",
                toggle_language_display = "I",
                focus_language = "f",
                unfocus_language = "F",
                update = "R",
                goto_node = "<CR>",
                show_help = "?",
            },
        },
        highlight = {
            enable = true,
            disable = { "markdown" },
            additional_vim_regex_highlighting = { "org" },
        },
        indent = {
            enable = true,
        },
        autopairs = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
        rainbow = {
            enable = true,
        },
        context_commentstring = {
            enable = true,
            config = {
                javascriptreact = {
                    style_element = "{/*%s*/}",
                },
            },
        },
    })
end

config.nvim_navic = function()
    local nvim_navic_status_ok, nvim_navic = pcall(require, "nvim-navic")
    if not nvim_navic_status_ok then
        return
    end
    nvim_navic.setup({
        icons = icons.lsp,
        highlight = true,
        separator = " " .. icons.common.separator,
    })
    vim.g.navic_silence = true
end

config.nvim_navbuddy = function()
    local nvim_navbuddy_status_ok, nvim_navbuddy = pcall(require, "nvim-navbuddy")
    if not nvim_navbuddy_status_ok then
        return
    end
    nvim_navbuddy.setup({
        window = {
            border = "single",
            size = "80%",
            position = "50%",
            sections = {
                left = {
                    size = "33%",
                    border = nil,
                },
                mid = {
                    size = "34%",
                    border = nil,
                },
                right = {
                    size = "33%",
                    border = nil,
                },
            },
        },
        icons = icons.navbuddy,
        lsp = { auto_attach = true },
    })
    vim.keymap.set("n", "<C-c>v", function()
        vim.cmd("Navbuddy")
    end, { noremap = true, silent = true, desc = "Navbuddy" })
end

config.any_jump_nvim = function()
    vim.g.any_jump_disable_default_keybindings = 1
    vim.g.any_jump_list_numbers = 1
    vim.keymap.set("n", "<A-u>", ":AnyJump<CR>", { noremap = true, silent = true, desc = "AnyJump" })
    vim.keymap.set("v", "<A-u>", ":AnyJumpVisual<CR>", { noremap = true, silent = true, desc = "AnyJumpVisual" })
end

config.symbols_outline_nvim = function()
    local symbols_outline_status_ok, symbols_outline = pcall(require, "symbols-outline")
    if not symbols_outline_status_ok then
        return
    end
    symbols_outline.setup({
        symbols = icons.outline,
        highlight_hovered_item = true,
        show_guides = true,
    })
    vim.keymap.set("n", "<A-v>", function()
        vim.cmd("SymbolsOutline")
    end, { noremap = true, silent = true, desc = "SymbolsOutline" })
end

config.nvim_dap_ui = function()
    local dapui_status_ok, dapui = pcall(require, "dapui")
    if not dapui_status_ok then
        return
    end
    local dap_status_ok, dap = pcall(require, "dap")
    if not dap_status_ok then
        return
    end
    dapui.setup({
        icons = icons.dap_ui.base,
        mappings = {
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        element_mappings = {},
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        force_buffers = true,
        layouts = {
            {
                elements = {
                    { id = "scopes", size = 0.33 },
                    { id = "breakpoints", size = 0.17 },
                    { id = "stacks", size = 0.25 },
                    { id = "watches", size = 0.25 },
                },
                size = 0.33,
                position = "left",
            },
            {
                elements = {
                    { id = "repl", size = 0.45 },
                    { id = "console", size = 0.55 },
                },
                size = 0.27,
                position = "bottom",
            },
        },
        floating = {
            max_height = nil,
            max_width = nil,
            border = "single",
            mappings = {
                ["close"] = { "q", "<Esc>" },
            },
        },
        controls = {
            enabled = vim.fn.exists("+winbar") == 1,
            element = "repl",
            icons = icons.dap_ui.controls,
        },
        render = {
            max_type_length = nil,
            max_value_lines = 100,
            indent = 1,
        },
    })
    vim.fn.sign_define("DapBreakpoint", {
        text = icons.dap_ui.sign.breakpoint,
        texthl = "DapBreakpoint",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
        text = icons.dap_ui.sign.reject,
        texthl = "DapBreakpointRejected",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
        text = icons.dap_ui.sign.condition,
        texthl = "DapBreakpointCondition",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapStopped", {
        text = icons.dap_ui.sign.stopped,
        texthl = "DapStopped",
        linehl = "",
        numhl = "",
    })
    vim.fn.sign_define("DapLogPoint", {
        text = icons.dap_ui.sign.log_point,
        texthl = "DapLogPoint",
        linehl = "",
        numhl = "",
    })
    vim.api.nvim_create_user_command("LuaDapLaunch", 'lua require"osv".run_this()', {})
    vim.api.nvim_create_user_command("DapToggleBreakpoint", 'lua require("dap").toggle_breakpoint()', {})
    vim.api.nvim_create_user_command("DapClearBreakpoints", 'lua require("dap").clear_breakpoints()', {})
    vim.api.nvim_create_user_command("DapRunToCursor", 'lua require("dap").run_to_cursor()', {})
    vim.api.nvim_create_user_command("DapContinue", 'lua require"dap".continue()', {})
    vim.api.nvim_create_user_command("DapStepInto", 'lua require"dap".step_into()', {})
    vim.api.nvim_create_user_command("DapStepOver", 'lua require"dap".step_over()', {})
    vim.api.nvim_create_user_command("DapStepOut", 'lua require"dap".step_out()', {})
    vim.api.nvim_create_user_command("DapUp", 'lua require"dap".up()', {})
    vim.api.nvim_create_user_command("DapDown", 'lua require"dap".down()', {})
    vim.api.nvim_create_user_command("DapPause", 'lua require"dap".pause()', {})
    vim.api.nvim_create_user_command("DapClose", 'lua require"dap".close()', {})
    vim.api.nvim_create_user_command("DapDisconnect", 'lua require"dap".disconnect()', {})
    vim.api.nvim_create_user_command("DapRestart", 'lua require"dap".restart()', {})
    vim.api.nvim_create_user_command("DapToggleRepl", 'lua require"dap".repl.toggle()', {})
    vim.api.nvim_create_user_command("DapGetSession", 'lua require"dap".session()', {})
    vim.api.nvim_create_user_command(
        "DapUIClose",
        'lua require"dap".close(); require"dap".disconnect(); require"dapui".close()',
        {}
    )
    vim.keymap.set("n", "<A-1>", function()
        dap.toggle_breakpoint()
    end, { noremap = true, silent = true, desc = "DapToggleBreakpoint" })
    vim.keymap.set("n", "<A-2>", function()
        dap.continue()
    end, { noremap = true, silent = true, desc = "DapContinue" })
    vim.keymap.set("n", "<A-3>", function()
        dap.step_into()
    end, { noremap = true, silent = true, desc = "DapStepInto" })
    vim.keymap.set("n", "<A-4>", function()
        dap.step_over()
    end, { noremap = true, silent = true, desc = "DapStepOver" })
    vim.keymap.set("n", "<A-5>", function()
        dap.step_out()
    end, { noremap = true, silent = true, desc = "DapStepOut" })
    vim.keymap.set("n", "<A-6>", function()
        dap.up()
    end, { noremap = true, silent = true, desc = "DapUp" })
    vim.keymap.set("n", "<A-7>", function()
        dap.down()
    end, { noremap = true, silent = true, desc = "DapDown" })
    vim.keymap.set("n", "<A-8>", function()
        dap.close()
        dap.disconnect()
        dapui.close()
    end, { noremap = true, silent = true, desc = "DapUIClose" })
    vim.keymap.set("n", "<A-9>", function()
        dap.restart()
    end, { noremap = true, silent = true, desc = "DapRestart" })
    vim.keymap.set("n", "<A-0>", function()
        dap.repl.toggle()
    end, { noremap = true, silent = true, desc = "DapToggleRepl" })
    dap.listeners.after.event_initialized["dapui_config"] = function()
        vim.defer_fn(function()
            dapui.open()
        end, 200)
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

config.nvim_dap_vscode_js = function()
    local global = require("core.global")
    local dap_vscode_js_status_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
    if not dap_vscode_js_status_ok then
        return
    end
    dap_vscode_js.setup({
        node_path = "node",
        debugger_path = global.mason_path .. "/bin/vscode-js-debug",
        debugger_cmd = { "js-debug-adapter" },
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    })
end

config.vim_dadbod_ui = function()
    vim.g.db_ui_show_help = 0
    vim.g.db_ui_win_position = "left"
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_winwidth = 35
    vim.g.db_ui_auto_execute_table_helpers = true
    vim.api.nvim_create_user_command("LspHover", "lua vim.lsp.buf.hover()", {})
end

config.package_info_nvim = function()
    local package_info_status_ok, package_info = pcall(require, "package-info")
    if not package_info_status_ok then
        return
    end
    package_info.setup()
    vim.api.nvim_create_user_command("PackageInfoToggle", "lua require('package-info').toggle()", {})
    vim.api.nvim_create_user_command("PackageInfoDelete", "lua require('package-info').delete()", {})
    vim.api.nvim_create_user_command("PackageInfoChangeVersion", "lua require('package-info').change_version()", {})
    vim.api.nvim_create_user_command("PackageInfoInstall", "lua require('package-info').install()", {})
end

config.crates_nvim = function()
    local crates_status_ok, crates = pcall(require, "crates")
    if not crates_status_ok then
        return
    end
    crates.setup()
    vim.api.nvim_create_user_command("CratesUpdate", "lua require('crates').update()", {})
    vim.api.nvim_create_user_command("CratesReload", "lua require('crates').reload()", {})
    vim.api.nvim_create_user_command("CratesHide", "lua require('crates').hide()", {})
    vim.api.nvim_create_user_command("CratesToggle", "lua require('crates').toggle()", {})
    vim.api.nvim_create_user_command("CratesUpdateCrate", "lua require('crates').update_crate()", {})
    vim.api.nvim_create_user_command("CratesUpdateCrates", "lua require('crates').update_crates()", {})
    vim.api.nvim_create_user_command("CratesUpdateAllCrates", "lua require('crates').update_all_crates()", {})
    vim.api.nvim_create_user_command("CratesUpgradeCrate", "lua require('crates').upgrade_crate()", {})
    vim.api.nvim_create_user_command("CratesUpgradeCrates", "lua require('crates').upgrade_crates()", {})
    vim.api.nvim_create_user_command("CratesUpgradeAllCrates", "lua require('crates').upgrade_all_crates()", {})
    vim.api.nvim_create_user_command(
        "CratesShowPopup",
        "lua require('crates').show_popup() require('crates').focus_popup()",
        {}
    )
    vim.api.nvim_create_user_command(
        "CratesShowVersionsPopup",
        "lua require('crates').show_versions_popup() require('crates').focus_popup()",
        {}
    )
    vim.api.nvim_create_user_command(
        "CratesShowFeaturesPopup",
        "lua require('crates').show_features_popup() require('crates').focus_popup()",
        {}
    )
    vim.api.nvim_create_user_command("CratesFocusPopup", "lua require('crates').focus_popup()", {})
    vim.api.nvim_create_user_command("CratesHidePopup", "lua require('crates').hide_popup()", {})
end

config.pubspec_assist_nvim = function()
    local pubspec_assist_status_ok, pubspec_assist = pcall(require, "pubspec-assist")
    if not pubspec_assist_status_ok then
        return
    end
    pubspec_assist.setup({
        highlights = {
            up_to_date = "PackageInfoUpToDateVersion",
            outdated = "PackageInfoOutdatedVersion",
            unknown = "Include",
        },
    })
end

config.markdown_preview_nvim = function()
    vim.keymap.set("n", "<S-m>", function()
        vim.cmd("MarkdownPreviewToggle")
    end, { noremap = true, silent = true, desc = "MarkdownPreviewToggle" })
end

config.vimtex = function()
    vim.g.vimtex_mappings_prefix = "'"
    vim.g.vimtex_view_method = "zathura"
    vim.g.latex_view_general_viewer = "zathura"
    vim.g.vimtex_compiler_progname = "nvr"
    vim.g.vimtex_compiler_callback_compiling = "nvr"
    vim.g.vimtex_quickfix_open_on_warning = 0
end

config.orgmode = function()
    local orgmode_status_ok, orgmode = pcall(require, "orgmode")
    if not orgmode_status_ok then
        return
    end
    orgmode.setup_ts_grammar()
    orgmode.setup({
        emacs_config = {
            config_path = "~/.emacs.d/early-init.el",
        },
        org_agenda_files = { "~/Org/**/*" },
        org_default_notes_file = "~/Org/refile.org",
    })
end

config.lvim_org_utils = function()
    local lvim_org_utils_status_ok, lvim_org_utils = pcall(require, "lvim-org-utils")
    if not lvim_org_utils_status_ok then
        return
    end
    lvim_org_utils.setup()
end

return config
