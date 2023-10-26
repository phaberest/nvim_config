local M = {
  "neovim/nvim-lspconfig",
  commit = "649137cbc53a044bffde36294ce3160cb18f32c7",
  lazy = false,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef",
    },
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
    },
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = {
        lsp = {
          auto_attach = true,
        },
        window = {
          border = "rounded",
          position = { row = "80%", col = "90%" },
        },
      },
    },
  },
}

function M.config()
  local cmp_nvim_lsp = require "cmp_nvim_lsp"

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

  local function lsp_keymaps(bufnr)
    local keymap = vim.api.nvim_buf_set_keymap
    keymap(
      bufnr,
      "n",
      "gD",
      "<cmd>lua vim.lsp.buf.declaration()<CR>",
      { noremap = true, silent = true, desc = "GoTo declaration" }
    )
    keymap(
      bufnr,
      "n",
      "gd",
      "<cmd>lua vim.lsp.buf.definition()<CR>",
      { noremap = true, silent = true, desc = "GoTo definition" }
    )
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true, desc = "Hover" })
    keymap(
      bufnr,
      "n",
      "gI",
      "<cmd>lua vim.lsp.buf.implementation()<CR>",
      { noremap = true, silent = true, desc = "GoTo implementation" }
    )
    keymap(
      bufnr,
      "n",
      "gr",
      "<cmd>Telescope lsp_references<cr>",
      { noremap = true, silent = true, desc = "GoTo references" }
    )
    keymap(
      bufnr,
      "n",
      "gl",
      "<cmd>lua vim.diagnostic.open_float()<CR>",
      { noremap = true, silent = true, desc = "Float diagnostic" }
    )
    keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", { noremap = true, silent = true, desc = "Lsp info" })
    keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", { noremap = true, silent = true, desc = "Mason" })
    keymap(
      bufnr,
      "n",
      "<leader>la",
      "<cmd>lua vim.lsp.buf.code_action()<cr>",
      { noremap = true, silent = true, desc = "Code action" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lj",
      "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>",
      { noremap = true, silent = true, desc = "Next diagnostic" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lk",
      "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
      { noremap = true, silent = true, desc = "Previous diagnostic" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lr",
      "<cmd>lua vim.lsp.buf.rename()<cr>",
      { noremap = true, silent = true, desc = "Rename" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>ls",
      "<cmd>lua vim.lsp.buf.signature_help()<CR>",
      { noremap = true, silent = true, desc = "Signature help" }
    )
    keymap(
      bufnr,
      "n",
      "<leader>lq",
      "<cmd>lua vim.diagnostic.setloclist()<CR>",
      { noremap = true, silent = true, desc = "Setloclist" }
    )
  end

  local lspconfig = require "lspconfig"
  local on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    require("illuminate").on_attach(client)
  end

  for _, server in pairs(require("utils").servers) do
    Opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "settings." .. server)
    if require_ok then
      Opts = vim.tbl_deep_extend("force", conf_opts, Opts)
    end

    lspconfig[server].setup(Opts)
  end

  -- Emmet
  lspconfig.emmet_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      "css",
      "html",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "typescriptreact",
      "svelte",
    },
  }

  require("lspconfig").smarty_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "smarty" },
  }

  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
