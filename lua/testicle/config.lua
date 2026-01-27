local M = {}

function M.get_default_config()
    local Runners = require("testicle.runners")
    return {
        runners = Runners.get_default_runners(),
    }
end

return M
