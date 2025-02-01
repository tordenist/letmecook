return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  commit = "29be0919b91fb59eca9e90690d76014233392bef",
  opts = {
    indent = {
      char = '▏',
    },
    scope = {
      show_start = false,
      show_end = false,
      show_exact_scope = false,
    },
    exclude = {
      filetypes = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
      },
    },
  },
}
