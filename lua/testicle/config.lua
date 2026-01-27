local Runners = require("testicle.runners")
local M = {}

function M.get_default_config()
    return {
        runners = Runners.get_default_runners(),
    }
end

return M
