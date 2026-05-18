local runners = require 'testicle.runners'

_TesticleConfigurationValues = _TesticleConfigurationValues or {}

local config = {}
config.settings = _TesticleConfigurationValues

---@type TesticleOpts
local default_opts = {
    debug = false,
    runners = {
        rust = runners.rust.cargo,
    },
}

-- Updates the buffer-local options for the plugin based on the input.
---@param base_opts TesticleOpts The base options that will be used for configuration
---@param new_opts TesticleOpts | nil The new options to potentially override the base options.
---@return TesticleOpts options The merged options.
local function merge_opts(base_opts, new_opts)
    new_opts = new_opts or {}
    return vim.tbl_deep_extend('force', base_opts, new_opts)
end

-- Setup the global user options for all files.
---@param user_opts TesticleOpts | nil The user-defined options to be merged with default_opts.
function config.setup(user_opts)
    -- Overwrite default options with user-defined options, if they exist
    require('testicle.util').debug(user_opts)
    config.settings = merge_opts(default_opts, user_opts)
end

return config
