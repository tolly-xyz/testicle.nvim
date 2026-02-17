local M = {}

---@type TesticleOpts
M.default_opts = {}

-- Setup the global user options for all files.
---@param user_opts TesticleOpts | nil The user-defined options to be merged with default_opts.
M.setup = function(user_opts)
    -- Overwrite default options with user-defined options, if they exist
    M.user_opts = M.merge_opts(M.default_opts, user_opts)
end

-- Updates the buffer-local options for the plugin based on the input.
---@param base_opts TesticleOpts The base options that will be used for configuration
---@param new_opts TesticleOpts | nil The new options to potentially override the base options.
---@return options The merged options.
M.merge_opts = function(base_opts, new_opts)
    new_opts = new_opts or {}
    local opts = vim.tbl_deep_extend("force", base_opts, M.translate_opts(new_opts))
    return opts
end

function M.get_default_config()
    local Runners = require("testicle.runners")
    return {
        -- runners = Runners.get_default_runners(),
    }
end

return M
