local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end
-- Get list of available colorschemes
local colors = vim.fn.getcompletion('', 'color')

-- Function to get the next colorscheme
function NextColor()
  local idx = vim.fn.index(colors, vim.g.colors_name)
  return colors[idx + 2]
end
vim.g.NextColor = function()
  local color = NextColor()
  vim.cmd.colorscheme(color)
  print('Changing to colorScheme "' .. color .. '"')
end

vim.cmd [[command! NextColors lua NextColors()]]
-- Function to get the previous colorscheme
function PrevColor()
  local idx = vim.fn.index(colors, vim.g.colors_name)
  return colors[idx]
end
vim.g.PrevColor = function()
  local color = PrevColor()
  vim.cmd.colorscheme(color)
  print('Changing to colorScheme "' .. color .. '"')
end

-- Map <C-n> to switch to the next colorscheme
-- vim.api.nvim_set_keymap('n', '<C-n>', ':execute "colo " .. NextColors()<CR>', { noremap = true })
vim.keymap.set('n', '<C-n>', vim.g.NextColor)

-- Map <C-p> to switch to the previous colorscheme
vim.keymap.set('n', '<C-p>', vim.g.PrevColor)
-- My colors
vim.opt.termguicolors = true
vim.cmd 'colorscheme tokyonight-moon'
vim.cmd('highlight LineNr guifg=#990000')
