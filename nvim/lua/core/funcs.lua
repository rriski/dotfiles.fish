local global = require("core.global")

local M = {}

M.merge = function(tbl1, tbl2)
    if type(tbl1) == "table" and type(tbl2) == "table" then
        for k, v in pairs(tbl2) do
            if type(v) == "table" and type(tbl1[k] or false) == "table" then
                M.merge(tbl1[k], v)
            else
                tbl1[k] = v
            end
        end
    end
    return tbl1
end

M.sort = function(tbl)
    local arr = {}
    for key, value in pairs(tbl) do
        arr[#arr + 1] = { key, value }
    end
    for ix, value in ipairs(arr) do
        tbl[ix] = value
    end
    return tbl
end

M.keymaps = function(mode, opts, keymaps)
    for _, keymap in ipairs(keymaps) do
        vim.keymap.set(mode, keymap[1], keymap[2], opts)
    end
end

M.configs = function()
    local base_configs = require("configs.base")
    local user_configs = require("configs.user")
    local unsort_configs = M.merge(base_configs, user_configs)
    local configs = M.sort(unsort_configs)
    for _, func in pairs(configs) do
        if type(func) == "function" then
            func()
        end
    end
end

M.file_exists = function(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

M.dir_exists = function(path)
    return M.file_exists(path)
end

M.write_file = function(f, content)
    local file = io.open(f, "w")
    if file ~= nil then
        file:write(content)
        file:close()
    end
end

M.delete_file = function(f)
    os.remove(f)
end

M.delete_packages_file = function()
    local lvim_packages_file = global.cache_path .. ".lvim_packages"
    os.remove(lvim_packages_file)
end

M.change_path = function()
    return vim.fn.input("Path: ", vim.fn.getcwd() .. "/", "file")
end

M.set_global_path = function()
    local path = M.change_path()
    vim.api.nvim_command("silent :cd " .. path)
end

M.set_window_path = function()
    local path = M.change_path()
    vim.api.nvim_command("silent :lcd " .. path)
end

M.file_size = function(size, options)
    local si = {
        bits = { "b", "Kb", "Mb", "Gb", "Tb", "Pb", "Eb", "Zb", "Yb" },
        bytes = { "B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" },
    }
    local function isNan(num)
        return num ~= num
    end

    local function roundNumber(num, digits)
        local fmt = "%." .. digits .. "f"
        return tonumber(fmt:format(num))
    end

    local o = {}
    for key, value in pairs(options or {}) do
        o[key] = value
    end
    local function setDefault(name, default)
        if o[name] == nil then
            o[name] = default
        end
    end

    setDefault("bits", false)
    setDefault("unix", false)
    setDefault("base", 2)
    setDefault("round", o.unix and 1 or 2)
    setDefault("spacer", o.unix and "" or " ")
    setDefault("suffixes", {})
    setDefault("output", "string")
    setDefault("exponent", -1)
    assert(not isNan(size), "Invalid arguments")
    local ceil = (o.base > 2) and 1000 or 1024
    local negative = (size < 0)
    if negative then
        size = -size
    end
    local result
    if size == 0 then
        result = {
            0,
            o.unix and "" or (o.bits and "b" or "B"),
        }
    else
        if o.exponent == -1 or isNan(o.exponent) then
            o.exponent = math.floor(math.log(size) / math.log(ceil))
        end
        if o.exponent > 8 then
            o.exponent = 8
        end
        local val
        if o.base == 2 then
            val = size / math.pow(2, o.exponent * 10)
        else
            val = size / math.pow(1000, o.exponent)
        end
        if o.bits then
            val = val * 8
            if val > ceil then
                val = val / ceil
                o.exponent = o.exponent + 1
            end
        end
        result = {
            roundNumber(val, o.exponent > 0 and o.round or 0),
            (o.base == 10 and o.exponent == 1) and (o.bits and "kb" or "kB")
                or si[o.bits and "bits" or "bytes"][o.exponent + 1],
        }
        if o.unix then
            result[2] = result[2]:sub(1, 1)

            if result[2] == "b" or result[2] == "B" then
                result = {
                    math.floor(result[1]),
                    "",
                }
            end
        end
    end
    assert(result)
    if negative then
        result[1] = -result[1]
    end
    result[2] = o.suffixes[result[2]] or result[2]
    if o.output == "array" then
        return result
    elseif o.output == "exponent" then
        return o.exponent
    elseif o.output == "object" then
        return {
            value = result[1],
            suffix = result[2],
        }
    elseif o.output == "string" then
        local value = tostring(result[1])
        value = value:gsub("%.0$", "")
        local suffix = result[2]
        return value .. o.spacer .. suffix
    end
end

M.get_highlight = function(hlname)
    local hl = vim.api.nvim_get_hl_by_name(hlname, true)
    setmetatable(hl, {
        __index = function(t, k)
            if k == "fg" then
                return t.foreground
            elseif k == "bg" then
                return t.background
            elseif k == "sp" then
                return t.special
            else
                return rawget(t, k)
            end
        end,
    })
    return hl
end

_G.LVIM_COLORS = function()
    return {
        color_01 = M.get_highlight("CursorLineNr").fg,
        color_02 = M.get_highlight("DiagnosticError").fg,
        color_03 = M.get_highlight("DiagnosticWarn").fg,
        color_04 = M.get_highlight("DiagnosticHint").fg,
        color_05 = M.get_highlight("DiagnosticInfo").fg,
        status_line_bg = M.get_highlight("StatusLine").bg,
        status_line_fg = M.get_highlight("StatusLine").fg,
        status_line_nc_bg = M.get_highlight("StatusLineNC").bg,
        status_line_nc_fg = M.get_highlight("StatusLineNC").fg,
    }
end

return M
