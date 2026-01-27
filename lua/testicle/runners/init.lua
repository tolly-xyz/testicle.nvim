---@class TesticleRunner
---@field pkg fun(): string
---@field single fun(pkg: string, func: string, opts: vim.api.keyset.create_user_command.command_args): string|string[]
---@field all fun(pkg: string, opts: vim.api.keyset.create_user_command.command_args): string|string[]

---@class TesticleRunnerCommand
---@field args fun(p: string, f: string): string[]
---@field opts fun(): vim.SystemOpts

local M = {}

---@class TesticleRunnerModule
---@field default TesticleRunner
---@field [string] TesticleRunner

---@param filetype string
---@return TesticleRunnerModule
local function get_runner_module(filetype)
    local modname = string.format("testicle.runners.%s", filetype)
    return require(modname)
end

---@param lang string
---@return TesticleRunnerModule
function M.get_runners(lang)
    return get_runner_module(lang)
end

---@param filetype string
---@return TesticleRunner
function M.get_default_runner(filetype)
    return get_runner_module(filetype).default
end

return M
