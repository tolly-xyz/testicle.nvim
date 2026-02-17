local Testicle = {}

---@class TesticleOpts
---@field runners? table<string, TesticleRunnerModule> Custom runners by filetype

---@type TesticleOpts
Testicle.config = {}

-- Setup the plugin with user-defined options.
---@param user_opts TesticleOpts | nil The user options.
Testicle.setup = function(user_opts)
    require("testicle.config").setup(user_opts)
end

return Testicle
