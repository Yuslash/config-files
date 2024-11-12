function readWordFromFile(filename)
  local file = io.open(filename, "r")
  if not file then
    return nil, "File Not Found"
  end

  local content = file:read("*all")
  file:close()

  local words = {}
  for word in content:gmatch('"([^"]+)"') do
    table.insert(words, word)
  end

  return words
end

local filename = os.getenv("HOME") .. "/.config/nvim/lua/custom/flutter_properties.txt"

local words_to_highlight, err = readWordFromFile(filename)

if words_to_highlight then
  vim.cmd([[
    highlight CustomProperties guifg=#ff8c73 gui=bold
  ]])

  for _, word in ipairs(words_to_highlight) do
    vim.fn.matchadd("CustomProperties", "\\<" .. word .. "\\>")
  end
else
  print("Error Reading file...", err)
end
