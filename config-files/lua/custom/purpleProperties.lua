vim.cmd([[
  highlight CustomPurple guifg=#b84fff gui=bold
]])

local words_of_list = {
  "MainAxisSize",
  "children",
  "MainAxisAlignment",
  "BottomNavigationBarItem",
  "push",
  "Image",
  "EdgeInsets",
  "Colors",
  "Color",
  "currentIndex",
  "BorderSide",
  "BuildContext",
  "context",
  "top",
  "left",
  "right",
  "bottom",
  "Icons",
  "CrossAxisAlignment",
  "widget",
  "TextStyle",
  "required",
}

for _, word in ipairs(words_of_list) do
  vim.fn.matchadd("CustomPurple", "\\<" .. word .. "\\>")
end
