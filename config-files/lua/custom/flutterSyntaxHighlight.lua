vim.cmd([[
  highlight CustomHighlightWord guifg=#FF0000 gui=bold
]])

local words_to_highlight = {
  "Widget",
  "setState",
  "State",
  "Scaffold",
  "Build",
}

for _, word in ipairs(words_to_highlight) do
  vim.fn.matchadd("CustomHighlightWord", "\\<" .. word .. "\\>")
end
