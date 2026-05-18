local M = {}

DEFAULT_RUNNER = 'cargo'

M.default = DEFAULT_RUNNER

---@type TesticleRunner
M.cargo = {
    pkg = function()
        local pkgid, _ = vim.system({ 'cargo', 'pkgid' }, { cwd = vim.fn.expand '%:h', text = true }):wait().stdout:gsub('\n', '')
        return pkgid
    end,
    single = function(pkg, func, opts) return table.concat({ 'cargo', 'test', opts.args, '--package', pkg, func }, ' ') end,
    all = function(pkg, opts) return table.concat({ 'cargo', 'test', opts.args, '--package', pkg }, ' ') end,
}

return M
