function readWordsFromFile(filename)
  local file, err = io.open(filename, "r")
  if not file then
    return nil, "file not found" .. err
  end

  local content = file:read("*all")
  file:close()

  local words = {}
  for word in content:gmatch('"([^"]+)"') do
    table.insert(words, word)
  end

  return words
end

local filenname = os.getenv("HOME") .. "/.config/nvim/lua/custom/flutter_widgets.txt"

local words_to_highlight, err = readWordsFromFile(filenname)

if words_to_highlight then
  vim.cmd([[
    highlight CustomWidgets guifg=#33fa19 gui=bold
  ]])

  for _, word in ipairs(words_to_highlight) do
    vim.fn.matchadd("CustomWidgets", "\\<" .. word .. "\\>")
  end
else
  print("Error reading file", err)
end
