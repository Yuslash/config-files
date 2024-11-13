_G.remove_flutter_text_widget = function()
  vim.api.nvim_command("wincmd p")

  local current_line = vim.api.nvim_get_current_line()
  if string.match(current_line, "Text%(%s*.*%s*%)") then
    vim.api.nvim_command("normal! dd")
  else
    print("No Text Widget found on the current line")
  end
end

local function open_simple_panel()
  local width = 30
  local height = 5
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "Remove Text",
  })

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"

  local win_id = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "<CR>",
    string.format("<Cmd>lua _G.remove_flutter_text_widget()<CR> | lua vim.api.nvim_win_close(%d, true)<CR>", win_id),
    {
      noremap = true,
      silent = true,
    }
  )
end

vim.api.nvim_create_user_command("ActionPanel", open_simple_panel, {})

vim.api.nvim_create_user_command("RemoveText", _G.remove_flutter_text_widget, {})

vim.api.nvim_set_keymap("n", "<leader>rt", ":RemoveText<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ap", ":ActionPanel<CR>", { noremap = true, silent = true })
