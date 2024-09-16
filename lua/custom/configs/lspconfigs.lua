local on_attach = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.congis.lspconfig').capabilities

local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { gopls },
  filetype = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
}
