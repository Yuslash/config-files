function WrapSelectedWithColumn()
  local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local selected_text = table.concat(lines, "\n")

  local wrapped_text = string.format("Column(\n children: [\n %s\n], \n)", selected_text)
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, { wrapped_text })
end

vim.api.nvim_create_user_command("WrapWithColumn", function()
  WrapSelectedWithColumn()
end, {})
