local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- better indent handling
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- paste preserves primal yanked piece
keymap('v', 'p', '"_dP', opts)

-- removes highlighting after escaping vim search
keymap('n', '<Esc>', '<Esc>:noh<CR>', opts)

-- call vscode commands from neovim

-- general keymaps
keymap({ 'n', 'v' }, '<leader>t', "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({ 'n', 'v' }, '<leader>b', "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap({ 'n', 'v' }, '<leader>d', "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({ 'n', 'v' }, '<leader>a', "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({ 'n', 'v' }, '<leader>sp', "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({ 'n', 'v' }, '<leader>cn', "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
keymap({ 'n', 'v' }, '<leader>ff', "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ 'n', 'v' }, '<leader>cp', "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap({ 'n', 'v' }, '<leader>pr', "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({ 'n', 'v' }, '<leader>fd', "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
keymap({ 'n', 'v' }, '<leader>ai', "<cmd>lua require('vscode').action('vscode.editorChat.start')<CR>")

-- harpoon keymaps
keymap({ 'n', 'v' }, '<leader>ha', "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({ 'n', 'v' }, '<leader>ho', "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({ 'n', 'v' }, '<leader>he', "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
keymap({ 'n', 'v' }, '<leader>h1', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
keymap({ 'n', 'v' }, '<leader>h2', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
keymap({ 'n', 'v' }, '<leader>h3', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
keymap({ 'n', 'v' }, '<leader>h4', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
keymap({ 'n', 'v' }, '<leader>h5', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
keymap({ 'n', 'v' }, '<leader>h6', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
keymap({ 'n', 'v' }, '<leader>h7', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
keymap({ 'n', 'v' }, '<leader>h8', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
keymap({ 'n', 'v' }, '<leader>h9', "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

-- project manager keymaps
keymap({ 'n', 'v' }, '<leader>pa', "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
keymap({ 'n', 'v' }, '<leader>po', "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
keymap({ 'n', 'v' }, '<leader>pe', "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")

-- AUTOCOMMANDS

-- - Command to open a floating terminal window
vim.keymap.set('n', '<leader>T', function()
  -- Open a PowerShell terminal as an editor tab
  vim.fn.VSCodeNotify('workbench.action.terminal.newWithProfile', {
    profileName = 'PowerShell',
    location = 'editor',
  })

  -- Wait 200 ms, then open new window
  vim.defer_fn(function()
    vim.fn.VSCodeNotify 'workbench.action.moveEditorToNewWindow'
    -- Wait to send settings commands
    vim.defer_fn(function()
      vim.fn.VSCodeNotify 'workbench.action.enableWindowAlwaysOnTop'
      vim.fn.VSCodeNotify 'workbench.action.enableCompactAuxiliaryWindow'
    end, 100) 
  end, 200)
end, {
  noremap = true,
  silent = true,
  desc = 'Open PowerShell in editor then detach into new window',
})