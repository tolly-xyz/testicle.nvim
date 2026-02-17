print("LOADED")
if vim.g.loaded_testicle == 1 then
    return
end
vim.g.loaded_testicle = 1

local augroup = vim.api.nvim_create_augroup("Testicle", { clear = true })

---@param runners TesticleRunnerModule
local function run(runners)
    ---@param opts vim.api.keyset.create_user_command.command_args
    local function user_command(opts)
        local Internal = require("testicle.internal")
        local runner = runners.default

        local run_all = opts.bang
        if run_all then
            Internal.run_all_tests(runner, opts)
        else
            Internal.run_test_under_cursor(runner, opts)
        end
    end
    return user_command
end

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    callback = function(args)
        local filetype = args.match
        local success, runners = pcall(require, "testicle.runners." .. filetype)
        if not success then
            return
        end

        vim.api.nvim_buf_create_user_command(
            args.buf,
            "Testicle",
            run(runners),
            { bang = true, count = true, nargs = "*" }
        )
    end,
})
