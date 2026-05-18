local M = {}

local util = require("testicle.util")

--- @return string? - The name of the test function under the cursor, if it exists
local function current_test()
    local query = vim.treesitter.query.get(vim.bo.filetype, "testicle")
    if query == nil then
        vim.api.nvim_echo({ { "No Testicle query found for file type: " }, { vim.bo.filetype } }, true, { err = true })
        return
    end

    local cursor_row = vim.fn.line(".") - 1
    local tree = vim.treesitter.get_parser():parse()[1]

    local test_name = nil
    for id, node, _, _ in query:iter_captures(tree:root(), 0) do
        if query.captures[id] ~= "test_func" then
            goto continue
        end

        local start_row, _, end_row, _ = node:range()
        if cursor_row <= end_row and cursor_row >= start_row then
            local name_node = node:field("name")[1]
            test_name = vim.treesitter.get_node_text(name_node, 0)
            break
        end
        ::continue::
    end

    if test_name == nil then
        return
    end
    return test_name
end

local DEFAULT_MODS = "botright"
local DEFAULT_SIZE = 15

---@param cmd string
---@param opts vim.api.keyset.create_user_command.command_args
local function term(cmd, opts)
    util.debug(opts)
    local mods = opts.mods == "" and DEFAULT_MODS or opts.mods -- window creation mods
    local size = opts.count <= 0 and DEFAULT_SIZE or opts.count -- height, or width if vertical
    vim.cmd(string.format("%s %d new", mods, size))
    vim.fn.jobstart(cmd, { term = true, cwd = vim.fn.expand("%:h") })

    vim.cmd("normal! G") -- go to bottom so window follows command output
    vim.cmd("wincmd p") -- go back to original window
end

---@param runner TesticleRunner
---@param opts vim.api.keyset.create_user_command.command_args
---@return boolean -- whether the command was successful
function M.run(runner, opts)
    local package_name = runner.pkg()
    local cmd
    if opts.bang then
        cmd = runner.all(package_name, opts)
    else
        local test_name = current_test()
        if test_name == nil then
            vim.api.nvim_echo(
                { { "No test function was found under cursor. Please add ! to command if you want to run all tests" } },
                true,
                { err = true }
            )
            return false
        end
        cmd = runner.single(package_name, test_name, opts)
    end
    return pcall(term, cmd, opts)
end

return M
