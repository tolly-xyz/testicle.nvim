if vim.g.testicle_loaded == 1 then return end
vim.g.testicle_loaded = 1

local Runners = require 'testicle.runners'
local Util = require 'testicle.util'

local augroup = vim.api.nvim_create_augroup('Testicle', { clear = true })

---@param runners TesticleRunnerModule
local function run(runners)
    ---@param opts vim.api.keyset.create_user_command.command_args
    return function(opts)
        local Internal = require 'testicle.internal'
        local runner = runners[runners.default]

        Internal.run(runner, opts)
    end
end

vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    callback = function(args)
        local filetype = args.match
        local file_runners = Runners.get_runners(filetype)
        if file_runners == nil then return end

        Util.debug(args)
        vim.api.nvim_buf_create_user_command(
            args.buf,
            'Testicle',
            run(file_runners),
            { bang = true, count = true, nargs = '*' }
        )
    end,
})
