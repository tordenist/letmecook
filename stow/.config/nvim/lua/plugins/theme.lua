return {
  'EdenEast/nightfox.nvim',
  lazy = false, -- Load it during startup
  priority = 1000, -- Ensure it's loaded before other plugins that might modify colors
  config = function()
    require('nightfox').setup {
      options = {
        compile_path = vim.fn.stdpath 'cache' .. '/nightfox',
        compile_file_suffix = '_compiled',
        transparent = true,
        terminal_colors = true,
        dim_inactive = false,
        module_default = true,
        colorblind = {
          enable = false,
          simulate_only = false,
          severity = { protan = 0, deutan = 0, tritan = 0 },
        },
        styles = {
          comments = 'italic', -- Try 'italic' for comments for a nicer feel
          keywords = 'bold', -- Bold keywords make the code stand out
          functions = 'italic,bold', -- Functions in italic and bold for emphasis
          variables = 'NONE',
          strings = 'NONE',
          numbers = 'NONE',
        },
        inverse = {
          match_paren = false,
          visual = true, -- Highlight visual mode for clarity
          search = true, -- Highlight search matches for visibility
        },
        modules = {}, -- You can enable/disable modules like LSP, treesitter here
      },
    }

    -- Activate the colorscheme
    vim.cmd 'colorscheme carbonfox'
  end,
}
