local M = {}

M.default = {
  -- general
  create_commands = true,
  filetype_in_preview = true,
  -- default togglable options
  two_step = false,
  all_on_line = true,
  preview = true,
  cwd = false,
  files = '**/*',
  -- keymaps
  keys = {
    close = 'q',
    toggle_side = '<Tab>',
    toggle_options_focus = '<C-s>',
    toggle_option_under_cursor = '<CR>',
    scroll_preview_up = '<Up>',
    scroll_preview_down = '<Down>',
    do_replace = '<CR>',
    do_undo = '<localleader>u',
    do_redo = '<localleader>r',
  },
  -- ui sizes
  patterns_width = 30,
  patterns_height = 10,
  options_width = 20,
  preview_height = 12,
  -- options order in ui
  order = {
    'buffer',
    'dir',
    'files',
    'two_step',
    'all_on_line',
    'preview',
  },
  -- highlights used for options ui
  hl = {
    options = {
      on = '@string',
      off = '@variable.builtin',
    },
    preview = {
      cwd = {
        path = 'Comment',
        lnum = 'Number',
      },
    },
  },
}

M.update = function(opts)
  M.default = vim.tbl_deep_extend('force', M.default, opts)
end

M.values = {}

M.populate = function(opts)
  for name, value in pairs(M.default) do
    if M.values[name] == nil or opts.fresh then
      M.values[name] = value
    end
  end
  M.values.range = opts.range
  M.values.buffer = vim.api.nvim_get_current_buf()
  M.values.dir = vim.fn.getcwd()
  M.values.ft = vim.api.nvim_get_current_buf()
  M.values.total_width = 2 * M.values.patterns_width + M.values.options_width + 4
  M.values.total_height = M.values.patterns_height + M.values.preview_height + 4
end

return M
