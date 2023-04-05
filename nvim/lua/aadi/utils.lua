vim.api.nvim_create_user_command("SLoadCwd", function()
    local cwd = vim.fn.getcwd()
    local sessions = require("possession.session").list()
    for _, session in pairs(sessions) do
        if cwd == session.cwd then
            require("possession.session").load(session.name)
            break
        end
    end
end, { nargs = 0 })
