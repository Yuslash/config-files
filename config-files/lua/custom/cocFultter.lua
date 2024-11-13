local function remove_flutter_text_widget()
  local current_line = vim.api.nvim_get_current_line()
  if string.match(current_line, "Text%(%s*%)") then
    vim.api.nvim_command("normal! dd")
  end
end

vim.api.nvim_create_user_command("RemoveText", remove_flutter_text_widget, {})

vim.api.nvim_set_keymap("n", "<leader>rt", ":RemoveText<CR>", { noremap = true, silent = true })

--This is code will Remoev the Text widget yes
