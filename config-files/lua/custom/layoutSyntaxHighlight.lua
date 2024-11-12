vim.cmd([[
  highlight layoutHighlight guifg=#03ffc4 gui=bold
]])

local words_to_highlight = {
  "Container",
  "Column",
  "Row",
  "Stack",
  "Align",
  "Center",
  "ListView",
  "GridView",
  "CustomScrollView",
  "Flex",
  "Expanded",
  "Flexible",
  "Positioned",
  "Wrap",
  "Flow",
  "AspectRatio",
  "FractionallySizedBox",
  "IntrinsicHeight",
  "IntrinsicWidth",
  "LimitedBox",
  "Offstage",
  "Visibility",
  "SizedBox",
  "Spacer",
}

for _, word in ipairs(words_to_highlight) do
  vim.fn.matchadd("layoutHighlight", "\\<" .. word .. "\\>")
end
