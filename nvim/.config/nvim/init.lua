-- Set <space> as the leader key See `:help mapleadersearch files
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.opt.scrollbind = false
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
-- vim.o.tabstop = 4
-- vim.o.expandtab = false
-- vim.o.softtabstop = 4
-- vim.o.shiftwidth = 4
-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 400

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.api.nvim_create_user_command('Here', function(opts)
  local original_wd = vim.fn.getcwd()
  local parent_path = vim.fn.expand '%:h'
  vim.cmd('lcd ' .. parent_path)
  vim.cmd('!' .. opts.args)
  vim.cmd('lcd ' .. original_wd)
end, { nargs = '+' })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- Set jj as ESC in insert mode
vim.keymap.set('i', 'jj', '<Esc>', { nowait = true, desc = 'Quick esc in insert' })

-- lsp restart bind
vim.keymap.set('n', '<leader>lr', '<cmd>LspRestart<cr>', { desc = 'Restart LSP' })

-- normal mode signature help
vim.keymap.set('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

-- edit current directory
vim.keymap.set('n', '<leader>C', '<cmd>e %:p:h/<cr>', { desc = 'Edit current directory relative to open buffer' })

-- better copy paste
vim.keymap.set('v', '<leader>p', '"_dP', { desc = 'Replace selection by pasting current', noremap = true })
vim.keymap.set('n', '<leader>P', '"+p', { desc = 'Paste from system clipboard', noremap = true })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy/yank to system clipboard', noremap = true })
vim.keymap.set('n', '<leader>Y', 'gg"+yG', { desc = 'Copy/yank whole file to system clipboard', noremap = true })

-- tmux stuff
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww -n "sessionizer" " tmux-sessionizer"<CR>', { desc = 'Run tmux sessionizer on new tmux pane' })
vim.keymap.set('n', '<C-x>', function()
  local term_program = os.getenv 'TERM_PROGRAM'
  if term_program ~= 'tmux' then
    vim.cmd [[:silent !tmux attach \; choose-session]]
  else
    vim.cmd [[:silent !tmux choose-session]]
  end
end, { desc = 'Conditionally attach or choose tmux session based on TERM_PROGRAM' })

-- Create moving up and down keymaps
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, desc = 'Move selection up' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Add executable to currect file
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true, desc = 'Make file executable via chmod' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', '<cmd>:cclose<CR>', { desc = 'close quickfix window' })
vim.keymap.set('v', '<leader>q', '<cmd>:cclose<CR>', { desc = 'close quickfix window' })
vim.keymap.set('n', ']c', '<cmd>:cnext<CR>', { desc = 'previous quickfix' })
vim.keymap.set('n', '[c', '<cmd>:cprev<CR>', { desc = 'next quickfix' })

-- Make <C-w>hjkl resize because simple <C-hjkl> is used for navigation
vim.keymap.set('n', '<C-w>h', '<C-w>>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>j', '<C-w>+', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>k', '<C-w>-', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>l', '<C-w><', { noremap = true, silent = true })

-- Open undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle undotree' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Angular shortcuts

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          -- configure to use ripgrep
          vimgrep_arguments = {
            'rg',
            '--follow', -- Follow symbolic links
            '--hidden', -- Search for hidden files
            '--no-heading', -- Don't group matches by each file
            '--with-filename', -- Print the file path with the matched lines
            '--line-number', -- Show line numbers
            '--column', -- Show column numbers
            '--smart-case', -- Smart case search

            -- Exclude some patterns from search
            '--glob=!**/.git/*',
            '--glob=!**/.idea/*',
            '--glob=!**/.vscode/*',
            '--glob=!**/build/*',
            '--glob=!**/dist/*',
            '--glob=!**/yarn.lock',
            '--glob=!**/package-lock.json',
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = {
              'rg',
              '--files',
              '--hidden',
              '--glob=!**/.git/*',
              '--glob=!**/.idea/*',
              '--glob=!**/.vscode/*',
              '--glob=!**/build/*',
              '--glob=!**/dist/*',
              '--glob=!**/yarn.lock',
              '--glob=!**/package-lock.json',
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          local function filterDuplicates(array)
            local uniqueArray = {}
            for _, tableA in ipairs(array) do
              local isDuplicate = false
              for _, tableB in ipairs(uniqueArray) do
                if vim.deep_equal(tableA, tableB) then
                  isDuplicate = true
                  break
                end
              end
              if not isDuplicate then
                table.insert(uniqueArray, tableA)
              end
            end
            return uniqueArray
          end

          -- Then in your LspAttach callback, replace the gd mapping with:
          map('gd', function()
            local function on_list(options)
              -- Filter duplicates before showing in Telescope
              options.items = filterDuplicates(options.items)

              -- If there's only one result, jump directly to it
              if #options.items == 1 then
                vim.fn.setqflist({}, ' ', options)
                vim.cmd 'cfirst'
                return
              end

              require('telescope.pickers')
                .new({}, {
                  prompt_title = 'LSP Definitions',
                  finder = require('telescope.finders').new_table {
                    results = options.items,
                    entry_maker = function(entry)
                      return {
                        value = entry,
                        display = entry.filename .. ':' .. entry.lnum,
                        ordinal = entry.filename .. ':' .. entry.lnum,
                        filename = entry.filename,
                        lnum = entry.lnum,
                        col = entry.col,
                      }
                    end,
                  },
                  sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
                  previewer = require('telescope.previewers').vim_buffer_cat.new {},
                  attach_mappings = function(prompt_bufnr)
                    require('telescope.actions').select_default:replace(function()
                      require('telescope.actions').close(prompt_bufnr)
                      local selection = require('telescope.actions.state').get_selected_entry()
                      vim.cmd(string.format('edit +%d %s', selection.lnum, selection.filename))
                      vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
                    end)
                    return true
                  end,
                })
                :find()
            end

            -- Call definition with custom handler
            vim.lsp.buf.definition { on_list = on_list }
          end, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          local function code_action_with_cursor_adjustment()
            local cursor = vim.api.nvim_win_get_cursor(0)
            local row, col = cursor[1], cursor[2]
            local line = vim.api.nvim_get_current_line()

            -- Check if at start of a word or whitespace
            local move_cursor = (col == 0) or (line:sub(col + 1, col + 1):match '%s' == nil)

            if move_cursor then
              vim.api.nvim_win_set_cursor(0, { row, col + 1 })
            end

            vim.lsp.buf.code_action()

            if move_cursor then
              vim.api.nvim_win_set_cursor(0, { row, col })
            end
          end

          map('<leader>ca', code_action_with_cursor_adjustment, '[C]ode [A]ction')
          vim.api.nvim_create_autocmd('BufLeave', {
            pattern = { 'DiffviewFilePanel', 'DiffviewFiles' },
            callback = function()
              -- Give a small delay to ensure buffer switching has completed
              vim.defer_fn(function()
                -- Recreate your code action binding if needed
                vim.keymap.set('n', '<leader>ca', code_action_with_cursor_adjustment, { desc = '[C]ode [A]ction' })
              end, 10)
            end,
          })
          -- vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = 'LSP: [C]ode [A]ction' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --
        vtsls = {
          enabled = true,
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {},
              },
            },
            typescript = {
              preferences = {
                includePackageJsonAutoImports = 'on',
              },
            },
          },
          before_init = function(params, config)
            -- ENABLE FOR .vue files
            -- TODO: make it so this won't make my editor lag if not vue is opened
            local vuePluginConfig = {
              name = '@vue/typescript-plugin',
              location = require('mason-registry').get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server',
              languages = { 'vue' },
              configNamespace = 'typescript',
              enableForWorkspaceTypeScriptVersions = true,
            }
            table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)

            local sveltePluginConfig = {
              name = 'typescript-svelte-plugin',
              location = require('mason-registry').get_package('svelte-language-server'):get_install_path() .. '/node_modules/typescript-svelte-plugin',
              languages = { 'svelte' },
              configNamespace = 'typescript',
              enableForWorkspaceTypeScriptVersions = true,
            }
            table.insert(config.settings.vtsls.tsserver.globalPlugins, sveltePluginConfig)
          end,
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        emmet_language_server = {
          filetypes = { 'css', 'eruby', 'html', 'javascriptreact', 'less', 'sass', 'scss', 'pug', 'typescriptreact', 'php', 'vue', 'svelte' },
          init_options = {
            includeLanguages = {},
            excludeLanguages = {},
            extensionsPath = {},
            preferences = {},
            showAbbreviationSuggestions = true,
            showExpandedAbbreviation = 'always',
            showSuggestionsAsSnippets = false,
            syntaxProfiles = {},
            variables = {},
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'staticcheck',
        'astro-language-server',
        'html-lsp',
        'gopls',
        'biome',
        'css-lsp',
        'angular-language-server',
        'gofumpt',
        'lua-language-server',
        'prettierd',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            if server_name == 'html' then
              server.on_attach = function(client)
                -- Disable formatting for HTML LSP
                client.server_capabilities.document_formatting = false
                client.server_capabilities.document_range_formatting = false
              end
            end
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        html = { 'prettier' },
        typescript = { 'biome' },
        vue = { 'prettier', 'biome' },
        svelte = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        astro = { 'prettier' },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Insert },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_float_style = 'dim'
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.completion').setup {
        -- 10 ^ 7 to disable completion (source: help file)
        delay = { completion = 10000000 },
        lsp_completion = { auto_setup = false },
        window = { info = { border = 'solid' }, signature = { border = 'solid' } },
      }
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  { 'ThePrimeagen/vim-be-good' },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      -- Basic folding settings
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] -- arrow stuff
      vim.o.foldlevel = 99 -- Using ufo provider need a large value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- from: https://github.com/AstroNvim/AstroNvim/blob/271c9c3f71c2e315cb16c31276dec81ddca6a5a6/lua/astronvim/autocmds.lua#L98-L120
      -- reddit: https://old.reddit.com/r/neovim/comments/18mr2fq/how_to_make_folds_persist_in_neovim_with_lazyvim/ke5w3ad/
      -- added diff checking so it works well with diffview.nvim
      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd
      local view_group = augroup('auto_view', { clear = true })

      -- Function to check if current tab has a DiffviewFilePanel
      local function is_in_diffview_tab()
        local current_tab = vim.api.nvim_get_current_tabpage()
        local windows = vim.api.nvim_tabpage_list_wins(current_tab)

        for _, win in ipairs(windows) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_buf_get_name(buf)
          if buf_name:match 'DiffviewFilePanel' then
            return true
          end
        end

        return false
      end

      autocmd({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
        desc = 'Save view with mkview for real files',
        group = view_group,
        callback = function(args)
          -- Check if current window is in diff mode
          local is_diff = vim.wo.diff
          -- Check if in diffview tab
          local in_diffview = is_in_diffview_tab()

          if is_diff or in_diffview then
            return
          end

          if vim.b[args.buf].view_activated then
            vim.cmd.mkview { mods = { emsg_silent = true } }
          end
        end,
      })

      autocmd('BufWinEnter', {
        desc = 'Try to load file view if available and enable view saving for real files',
        group = view_group,
        callback = function(args)
          -- Check if current window is in diff mode
          local is_diff = vim.wo.diff
          -- Check if in diffview tab
          local in_diffview = is_in_diffview_tab()

          if is_diff or in_diffview then
            return
          end

          if not vim.b[args.buf].view_activated then
            local filetype = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
            local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })
            local ignore_filetypes = { 'gitcommit', 'gitrebase', 'svg', 'hgcommit' }

            if buftype == '' and filetype and filetype ~= '' and not vim.tbl_contains(ignore_filetypes, filetype) then
              vim.b[args.buf].view_activated = true
              vim.cmd.loadview { mods = { emsg_silent = true } }
            end
          end
        end,
      })

      -- Keymaps for folding
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'zK', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        else
          vim.api.nvim_win_set_option(winid, 'winblend', 0)
        end
      end, { desc = 'Peek fold' })

      -- Custom handler to show line count toolocal handler = function(virtText, lnum, endLnum, width, truncate)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ('… %d lines'):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end
      -- Setup with treesitter as main provider
      require('ufo').setup {
        fold_virt_text_handler = handler,
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
      }
    end,
  },
  {
    'joeveiga/ng.nvim',
    lazy = true,
    ft = { 'typescript', 'html', 'typescriptreact' },
    config = function()
      local ng = require 'ng'

      vim.keymap.set('n', '<leader>at', function()
        ng.goto_template_for_component { reuse_window = true }
      end, { noremap = true, silent = true, desc = 'Angular: Go to template' })

      vim.keymap.set('n', '<leader>ac', function()
        ng.goto_component_with_template_file { reuse_window = true }
      end, { noremap = true, silent = true, desc = 'Angular: Go to component' })

      vim.keymap.set('n', '<leader>aT', function()
        ng.get_template_tcb { reuse_window = true }
      end, { noremap = true, silent = true, desc = 'Angular: Get template TCB' })
    end,
  },
  {
    'jellydn/hurl.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    ft = 'hurl',
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = 'split',
      -- Default formatter
      formatters = {
        json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          '--parser',
          'html',
        },
        xml = {
          'tidy', -- Make sure you have installed tidy in your system, e.g: brew install tidy-html5
          '-xml',
          '-i',
          '-q',
        },
      },
      -- Default mappings for the response popup or split views
      mappings = {
        close = 'q', -- Close the response popup or split view
        next_panel = '<C-n>', -- Move to the next response popup window
        prev_panel = '<C-p>', -- Move to the previous response popup window
      },
    },
    keys = {
      -- Run API request
      { '<leader>A', '<cmd>HurlRunner<CR>', desc = 'Run All requests' },
      -- { '<leader>a', '<cmd>HurlRunnerAt<CR>', desc = 'Run Api request' },
      { '<leader>te', '<cmd>HurlRunnerToEntry<CR>', desc = 'Run Api request to entry' },
      { '<leader>tE', '<cmd>HurlRunnerToEnd<CR>', desc = 'Run Api request from current entry to end' },
      { '<leader>tm', '<cmd>HurlToggleMode<CR>', desc = 'Hurl Toggle Mode' },
      { '<leader>tv', '<cmd>HurlVerbose<CR>', desc = 'Run Api in verbose mode' },
      { '<leader>tV', '<cmd>HurlVeryVerbose<CR>', desc = 'Run Api in very verbose mode' },
      -- Run Hurl request in visual mode
      { '<leader>h', ':HurlRunner<CR>', desc = 'Hurl Runner', mode = 'v' },
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      keymaps = {
        ['<C-h>'] = false,
        ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a horizontal split' },
        ['<C-l>'] = false,
      },
    },
    -- Optional dependencies
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      resetting_keys = {
        ['1'] = { 'n', 'x' },
        ['2'] = { 'n', 'x' },
        ['3'] = { 'n', 'x' },
        ['4'] = { 'n', 'x' },
        ['5'] = { 'n', 'x' },
        ['6'] = { 'n', 'x' },
        ['7'] = { 'n', 'x' },
        ['8'] = { 'n', 'x' },
        ['9'] = { 'n', 'x' },
        ['c'] = { 'n' },
        ['C'] = { 'n' },
        ['d'] = { 'n' },
        ['x'] = { 'n' },
        ['X'] = { 'n' },
        ['y'] = { 'n' },
        ['Y'] = { 'n' },
        ['p'] = { 'n' },
        ['P'] = { 'n' },
        ['.'] = { 'n' },
        ['='] = { 'n' },
        ['<'] = { 'n' },
        ['>'] = { 'n' },
        ['J'] = { 'n' },
        ['gJ'] = { 'n' },
        ['~'] = { 'n' },
        ['g~'] = { 'n' },
        ['gu'] = { 'n' },
        ['gU'] = { 'n' },
        ['gq'] = { 'n' },
        ['gw'] = { 'n' },
        ['g?'] = { 'n' },
      },
      restricted_keys = {
        ['h'] = { 'n', 'x' },
        ['j'] = { 'n', 'x' },
        ['w'] = { 'n', 'x' },
        ['b'] = { 'n', 'x' },
        ['k'] = { 'n', 'x' },
        ['l'] = { 'n', 'x' },
        ['-'] = { 'n', 'x' },
        ['+'] = { 'n', 'x' },
        ['gj'] = { 'n', 'x' },
        ['gk'] = { 'n', 'x' },
        ['<CR>'] = { 'n', 'x' },
        ['<C-M>'] = { 'n', 'x' },
        ['<C-N>'] = { 'n', 'x' },
        ['<C-P>'] = { 'n', 'x' },
      },
    },
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    opts = {}, -- your configuration
  },
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>do', '<cmd>DiffviewOpen<CR>', desc = 'Open diffview' },
      { '<leader>dx', '<cmd>DiffviewClose<CR>', desc = 'Close diffview' },
    },
    config = function()
      require('diffview').setup {
        view = {
          default = {
            disable_diagnostics = true,
          },
          file_history = {
            disable_diagnostics = true,
          },
        },
      }
    end,
  },
  {
    'robitx/gp.nvim',
    config = function()
      local conf = {
        providers = {
          copilot = {
            endpoint = 'https://api.githubcopilot.com/chat/completions',
            secret = dofile(vim.fn.stdpath 'config' .. '/gp-config.lua'),
          },
        },
        agents = {
          {
            provider = 'copilot',
            name = 'ChatCopilot',
            chat = true,
            command = false,
            model = { model = 'claude-3.7-sonnet', temperature = 1.1, top_p = 1 },
            system_prompt = [[
You are an AI programming assistant embedded into NeoVim text editor.
Follow the user's requirements carefully & to the letter. Keep your answers short and impersonal. You are a general AI assistant. Ask question if you need clarification to provide better answer. Follow the user's requirements carefully & to the letter. The user may provide Markdown code blocks as extra context, treat the codes as they are and respect their language types defined next to the three backticks.
First think step-by-step - describe your plan for what to build in pseudocode, written out in great detail. Then output the code in a single code block. Minimize any other prose. Use Markdown formatting in your answers. Make sure to include the programming language name at the start of the Markdown code blocks. Avoid wrapping the whole response in triple backticks. 
            ]],
          },
        },
        default_command_agent = 'copilot',
        default_chat_agent = 'copilot',
        whisper = {
          disable = true,
        },
        image = {
          disable = true,
        },
        -- For customization, refer to Install > Configuration in the Documentation/Readme
      }
      require('gp').setup(conf)
    end,
    keys = {
      { 'gp', ':GpChatToggle<CR>', mode = 'n' },
      { 'gp', ':<C-U>echo execute("\'<,\'>GpChatPaste")<CR>', mode = 'v' },
    },
  },
  { 'mbbill/undotree', lazy = false },
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'html',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'okuuva/auto-save.nvim',
    cmd = 'ASToggle',
    enabled = false,
    event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
    opts = {
      debounce_delay = 3000,
      condition = function(buf)
        local fn = vim.fn

        if fn.getbufvar(buf, '&buftype') ~= '' then
          return false
        end
        return true
      end,
    },
  },
  { 'lambdalisue/vim-suda' },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup {
        lsp_cfg = false,
      }
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'kimabrandt-flx/harpoon',
    branch = 'fix_marks_index',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon'):setup()
    end,
    keys = {
      {
        '<leader>a',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'harpoon file',
      },
      {
        '<leader>H',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'harpoon open window',
      },
      {
        '<leader>3',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'harpoon to file 1 (3 for easier reach)',
      },
      {
        '<leader>4',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'harpoon to file 2 (4 for easier reach)',
      },
      {
        '<leader>5',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'harpoon to file 3 (5 for easier reach)',
      },
      {
        '<leader>8',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'harpoon to file 4 (8 for easier reach)',
      },
      {
        '<leader>9',
        function()
          require('harpoon'):list():select(5)
        end,
        desc = 'harpoon to file 5 (9 for easier reach)',
      },
      {
        '<leader>0',
        function()
          require('harpoon'):list():select(6)
        end,
        desc = 'harpoon to file 6 (0 for easier reach)',
      },
      {
        '<C-p>',
        function()
          require('harpoon'):list():prev()
        end,
        desc = 'harpoon previous',
      },
      {
        '<C-n>',
        function()
          require('harpoon'):list():next()
        end,
        desc = 'harpoon next',
      },
    },
  },
  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- go setup
require('lspconfig').gopls.setup {
  settings = {
    gopls = {
      -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      analyses = {
        unreachable = true,
        nilness = true,
        unusedparams = true,
        useany = true,
        unusedwrite = true,
        ST1003 = true,
        undeclaredname = true,
        fillreturns = true,
        nonewvars = true,
        fieldalignment = false,
        shadow = true,
      },
      codelenses = {
        generate = false,
        gc_details = false,
        test = true,
        tidy = true,
        vendor = true,
        regenerate_cgo = true,
        upgrade_dependency = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      matcher = 'fuzzy', -- Ensure lowercase for matcher
      diagnosticsDelay = '500ms',
      symbolMatcher = 'fuzzy', -- Ensure lowercase for symbolMatcher
      semanticTokens = true,
      gofumpt = true,
    },
  },
}

-- Things to care about in the future: some kind of surround, multi cursor or learn macros at least (https://vonheikemen.github.io/devlog/tools/how-to-survive-without-multiple-cursors-in-vim/), some fun keybinds from videos (bnext, dap, ctrl-^), learn more emmet, do more diffview.nvim, make things actually lazy load (for example with cmd = )
-- Fix icon width for Nerd Fonts v3.2.1.

vim.cmd [[
  augroup ft_js_settings
    autocmd!
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 noexpandtab
  augroup END
]]

vim.cmd [[
  augroup css_settings
    autocmd!
    autocmd FileType css setlocal tabstop=2 shiftwidth=2 noexpandtab
  augroup END
]]
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'svelte',
  callback = function()
    -- Add angle brackets to matchpairs
    vim.opt_local.matchpairs:append '<:>'

    -- Set up matchit for HTML tags in Svelte files
    -- This pattern matches HTML tags like <tag> and </tag>
    vim.b.match_words =
      '<:>,<\\@<=[ou]l\\>[^>]*\\%(>\\|$\\):<\\@<=li\\>:<\\@<=/[ou]l>,<\\@<=dl\\>[^>]*\\%(>\\|$\\):<\\@<=d[td]\\>:<\\@<=/dl>,<\\@<=\\([^/][^ \\t>]*\\)[^>]*\\%(>\\|$\\):<\\@<=/\\1>'
  end,
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
