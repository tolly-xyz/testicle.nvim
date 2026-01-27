local M = {}

DEFAULT_RUNNER = "cargo"

---@type TesticleRunner
M.cargo = {
    pkg = function()
        local pkgid, _ = vim.system({ "cargo", "pkgid" }, { cwd = vim.fn.expand("%:h"), text = true })
            :wait().stdout
            :gsub("\n", "")
        return pkgid
    end,
    single = function(pkg, func, opts)
        return { "cargo", opts.args, "test", "--package", pkg, func }
    end,
    all = function(pkg, opts)
        return { "cargo", opts.args, "test", "--package", pkg }
    end,
}

M.default = M[DEFAULT_RUNNER]

return M
