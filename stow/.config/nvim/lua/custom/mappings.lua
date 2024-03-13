local M = {}

--M.general = {
--  n = {
--    ["<C-h>"] = {"<cmd> TmuxNavigatorLeft<CR>", "Window Left"},
--    ["<C-l>"] = {"<cmd> TmuxNavigatorRight<CR>", "Window Right"},
--    ["<C-j>"] = {"<cmd> TmuxNavigatorDown<CR>", "Window Down"},
--    ["<C-k>"] = {"<cmd> TmuxNavigatorUp<CR>", "Window Up"},
--  }
--}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Toggle Breakpoint"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open Debugging Sidebar"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function ()
        require('dap-go').debug_test()
      end,
      "Debug Go Test"
    },
    ["<leader>dgl"] = {
      function ()
        require('dap-go').debug_last()
      end,
      "Debug Last Go Test"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function ()
        require('dap-python').test_method()
      end
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add JSON Struct Tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add YAMLS Struct Tags"
    }
  }
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "Update Crates"
    }
  }
}

return M
