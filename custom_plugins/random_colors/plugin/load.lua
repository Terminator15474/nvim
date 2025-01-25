vim.api.nvim_create_user_command('RandomColors', function()
require("random_colors").set_random_color()
end, {})
