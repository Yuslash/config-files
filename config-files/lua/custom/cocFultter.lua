local function open_simple_panel()
  local width = 30
  local height = 6
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "Options Menu:",
    "1. Print Hello",
    "2 Print Goodbye",
    "3 print how are you",
    "Press Enter to Select an Option.",
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

  local function handle_choice(choice)
    if choice == "1" then
      print("hello")
    elseif choice == "2" then
      print("Goodbye")
    elseif choice == "3" then
      print("How are you?")
    end
    vim.api.nvim_win_close(win_id, true)
  end

  local function select_option()
    local line = vim.api.nvim_win_get_cursor(win_id)[1]

    if line == 2 then
      handle_choice("1")
    elseif line == 3 then
      handle_choice("2")
    elseif line == 4 then
      handle_choice("3")
    end
  end

  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", ":lua select_option()<CR>", { noremap = true, silent = true })

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"
end

vim.api.nvim_create_user_command("OptionPanel", open_simple_panel, {})
