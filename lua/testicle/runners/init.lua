---@class TesticleRunner
---@field pkg fun(): string
---@field single fun(pkg: string, func: string, opts: vim.api.keyset.create_user_command.command_args): string
---@field all fun(pkg: string, opts: vim.api.keyset.create_user_command.command_args): string

local M = {
    rust = require 'testicle.runners.rust',
}

---@class TesticleRunnerModule
---@field default string
---@field [string] TesticleRunner

---@param filetype string
---@return TesticleRunnerModule?
function M.get_runners(filetype)
    local success, runner = pcall(require, 'testicle.runners.' .. filetype)
    return success and runner or nil
end

---@param filetype string
---@return TesticleRunner | nil
function M.get_default_runner(filetype)
    local runners = M.get_runners(filetype)
    return runners and runners[runners.default]
end

return M
