local Testicle = {}

---@class TesticleOpts
---@field runners? table<string, TesticleRunnerModule> Custom runners by filetype

---@type TesticleOpts
Testicle.config = {}

---@param opts? TesticleOpts
function Testicle.setup(opts)
    Testicle.config = vim.tbl_deep_extend("force", Testicle.config, opts or {})
end

return Testicle
