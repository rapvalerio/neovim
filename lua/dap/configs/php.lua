-- Import the 'dap' module
local dap, dapui = require 'dap', require 'dapui'
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

Config = function()
  vim.keymap.set('n', '<F1>', dap.continue)
  vim.keymap.set('n', '<F2>', dap.step_into)
  vim.keymap.set('n', '<F3>', dap.step_over)
  vim.keymap.set('n', '<F4>', dap.step_out)
  vim.keymap.set('n', '<F6>', dap.step_back)
  vim.keymap.set('n', '<F12>', dap.restart)
end

-- Configure the debugger adapter for PHP
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {
    require('mason-registry').get_package('php-debug-adapter'):get_install_path() .. '/extension/out/phpDebug.js',
  },
}

-- Debug configurations specific to PHP
dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Laravel',
    port = 9003,
    pathMappings = {
      ['/var/www/app'] = '${workspaceFolder}',
    },
  },
  {
    type = 'php',
    request = 'launch',
    name = 'Symfony',
    port = 9003,
    pathMappings = {
      ['/app'] = '${workspaceFolder}',
    },
  },
  {
    name = 'Launch currently open script',
    type = 'php',
    request = 'launch',
    program = '${file}',
    port = 9003,
    cwd = '${workspaceFolder}',
    console = 'integratedTerminal',
  },
}
