_G.remove_flutter_text_widget = function()
  local buffer = vim.api.nvim_get_current_buf()
  local start_line = vim.fn.line(".") - 1
  local total_lines = vim.api.nvim_buf_line_count(buffer)

  local current_line_text = vim.api.nvim_get_current_line()
  if not current_line_text:match("^%s*Text%s*%(") then
    print("No Text Widget found on the current line")
    return
  end

  local open_bracket = 1
  local end_line = start_line

  while end_line < total_lines and open_bracket > 0 do
    local line_text = vim.api.nvim_buf_get_lines(buffer, end_line, end_line + 1, false)[1]

    open_bracket = open_bracket + select(2, line_text:gsub("%(", ""))
    open_bracket = open_bracket - select(2, line_text:gsub("%)", ""))

    end_line = end_line + 1
  end

  vim.api.nvim_buf_set_lines(buffer, start_line, end_line, false, {})
  print("Text Widget Removed")

  vim.api.nvim_command("wincmd p")

  if _G.win_id and vim.api.nvim_win_is_valid(win_id) then
    vim.api.nvim_win_close(_G.win_id, true)
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

  _G.win_id = win_id

  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "<CR>",
    string.format("lua vim.api.nvim_win_close(%d, true)<CR><Cmd>lua _G.remove_flutter_text_widget()<CR>", win_id),
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
