local Testicle = {}

---@param opts table
function Testicle.setup(opts) end

-- vim.api.nvim_create_user_command("YourTestCommand", function(opts)
--     local Internal = require("testicle.internal")
--
--     local run_all = opts.bang
--     if run_all then
--         Internal.run_all_tests(opts)
--     else
--         Internal.run_test_under_cursor(opts)
--     end
-- end, {
--     nargs = "*",
--     bang = true,
--     count = true,
-- })

return Testicle
