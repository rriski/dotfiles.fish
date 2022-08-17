local custom_input = require("nui.input")
local event = require("nui.utils.autocmd").event
local popup_reference = nil

local calculate_popup_width = function(default, prompt)
    local result = 40
    if prompt ~= nil then
        result = #prompt + 40
    end
    if default ~= nil then
        if #default + 40 > result then
            result = #default + 40
        end
    end
    return result
end

local function nui_input(opts, on_confirm)
    assert(popup_reference == nil, "Sorry")
    local popup_options = {
        relative = "cursor",
        position = {
            row = 1,
            col = 0,
        },
        size = {
            width = calculate_popup_width(opts.default, opts.prompt),
        },
        border = {
            highlight = "NuiBorder",
            style = { " ", " ", " ", " ", " ", " ", " ", " " },
            text = {
                top = opts.prompt,
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:NuiBody",
        },
    }
    popup_reference = custom_input(popup_options, {
        prompt = "➤ ",
        default_value = opts.default,
        on_close = function()
            popup_reference = nil
        end,
        on_submit = function(value)
            on_confirm(value)
            popup_reference = nil
        end,
    })
    if popup_reference ~= nil then
        popup_reference:mount()
        popup_reference:map("n", "<esc>", popup_reference.input_props.on_close, { noremap = true })
        popup_reference:map("n", "q", popup_reference.input_props.on_close, { noremap = true })
        popup_reference:map("i", "<esc>", popup_reference.input_props.on_close, { noremap = true })
        popup_reference:on(event.BufLeave, popup_reference.input_props.on_close, { once = true })
    end
end

return nui_input
