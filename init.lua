vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.o.scrolloff = 4

vim.cmd [[set termguicolors]]
vim.g.termguicolors=true

-- Configuração padrão para folding
vim.opt.foldmethod = "indent"  -- Define o método de folding como indentação
vim.opt.foldlevelstart = 99    -- Mantém todos os folds abertos ao abrir o arquivo
vim.opt.foldenable = true      -- Habilita folding
vim.opt.foldcolumn = "1"  -- Mostra uma coluna com indicadores de folding

-- Remove Italics from bones colorschemes
-- Apply custom highlights on colorscheme change.
-- Must be declared before executing ':colorscheme'.
grpid = vim.api.nvim_create_augroup('custom_highlights', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = grpid,
  pattern = '*bones',
  command = 'hi Comment  gui=NONE |' ..
            'hi Constant gui=NONE'
})

-- Neovide
vim.g.neovide_fullscreen = true
vim.o.guifont = "BitstromWera Nerd Font:h14"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
		}, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
	-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {"shaunsingh/nord.nvim"},
    {"edeneast/nightfox.nvim"},
    {
        "https://gitlab.com/bartekjaszczak/luma-nvim",
        priority = 1000,
        config = function()
            require("luma").setup({
                theme = "dark",     -- "dark" or "light" theme
                contrast = "medium" -- "low", "medium" or "high" contrast
            })
        end
    },
    {"xero/miasma.nvim"},
    {"rose-pine/neovim", name = "rose-pine"},
    {"zaldih/themery.nvim"},
    {"atelierbram/Base4Tone-nvim"},
    {"bgwdotdev/gleam-theme-nvim"},
    {"PinpongTp/comic"},
    {"slugbyte/lackluster.nvim"},
    {"cryptomilk/nightcity.nvim"},
    {"sainnhe/gruvbox-material"},
    {"maxmx03/solarized.nvim"},
    {"gmr458/cold.nvim"},
    {"dzfrias/noir.nvim"},
    {"comfysage/evergarden"},
    {
        "zenbones-theme/zenbones.nvim",
        -- Optionally install Lush. Allows for more configuration or extending the colorscheme
        -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
        -- In Vim, compat mode is turned on as Lush only works in Neovim.
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
	--config = function ()
	--	vim.api.nvim_set_hl(0, "Comment", { italic = false })
        --	vim.api.nvim_set_hl(0, "String", { italic = false })
	--	vim.g.zenbones_darken_comments = 45
	--end
        -- you can set set configuration options here
        -- config = function()
        --     vim.g.zenbones_darken_comments = 45
        --     vim.cmd.colorscheme('zenbones')
        -- end
    },
    {"ramojus/mellifluous.nvim"},
    {"olivercederborg/poimandres.nvim"},
    {"neanias/everforest-nvim"},
    {"sho-87/kanagawa-paper.nvim"},
    {"kvrohit/substrata.nvim"},
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "Telescope",
    },
    {"nvim-treesitter/nvim-treesitter"},
    {"neovim/nvim-lspconfig"},
    {"hrsh7th/nvim-cmp"},  -- Plugin de autocompletar
    {"hrsh7th/cmp-nvim-lsp"},  -- Fonte para o LSP
    {"hrsh7th/cmp-buffer"},    -- Fonte para palavras no buffer
    {"hrsh7th/cmp-path"},      -- Fonte para autocompletar caminhos
    {"hrsh7th/cmp-cmdline"},   -- Fonte para autocompletar comandos
    {"L3MON4D3/LuaSnip"},      -- Snippets engine (opcional)
    {"saadparwaiz1/cmp_luasnip"}, -- Fonte de snippets
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
        },
    },
    {'mg979/vim-visual-multi'}, -- Multiplos cursores (Ctrl + N e Ctrl+Up ou Down 
    --{'uga-rosa/ccc.nvim'},
    { "windwp/nvim-autopairs", config = function()
	    require('nvim-autopairs').setup{}
    	end
    },
    {
	"lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        "xiyaowong/nvim-transparent",
        config = function()
            require("transparent").setup({
                enable = true,  -- Habilitar transparência
                extra_groups = { "NormalFloat", "NormalNC" }, -- Grupos adicionais que você pode querer tornar transparentes
                exclude = {},  -- Grupos que você não quer que fiquem transparentes
            })
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
        config = function()
        	require("nvim-tree").setup({
		view = {
			side = "right",
		},
	})
        end,
    },
    {'matze/vim-move'},
    {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate").configure({
                providers = { "lsp", "treesitter", "regex" }, -- Configura os métodos de destaque
                delay = 120,  -- Tempo de atraso para iluminar, em milissegundos
                filetypes_denylist = { "NvimTree", "packer" }, -- Lista de tipos de arquivo para ignorar
                under_cursor = true, -- Destaque a palavra abaixo do cursor
            })
        end,
    },
  },
  install = { colorscheme = { "rose-pine" } },
  -- automaticamente verifica atualizações dos plugins
  checker = { enabled = true },
})

vim.cmd([[colorscheme nord]])

--require("ccc").setup()

vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false  -- Aqui desativamos o itálico
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

-- Carregar o esquema de cores
require('nord').set()

--local customline = require'lualine.themes.iceberg_dark'
require('lualine').setup {
  options = { theme  = 'ashes' },
}

-- Habilitar Transparencia
vim.api.nvim_set_keymap("n", "<F5>", ":TransparentToggle<CR>", { noremap = true, silent = true })

-- Desativar o status de inserção
vim.cmd [[
  augroup DisableInsertModeStatus
    autocmd!
    autocmd InsertEnter * set noshowmode
  augroup END
]]

-- Configurações do Themery (Theme switcher)
require("themery").setup({
  themes = {"gruvbox-material", "nightcity", "mellifluous","cold", "comic",
	    "everforest", "evergarden", "lackluster", "noir", "poimandres",
	    "substrata", "luma", "rose-pine", "miasma", "kanagawa-paper",
	    "zenbones", "zenwritten", "tokyobones", "solarized", "nord", "nightfox"}, -- Your list of installed colorschemes.
  livePreview = true, -- Apply theme while picking. Default to true.
})

-- Configuração do nvim-tree
require("nvim-tree").setup {
    view = {
        width = 30,              -- Largura da árvore
        side = "right",           -- Lado onde a árvore ficará (left ou right)
        mappings = {
            -- Key mappings para o nvim-tree
	    ["<C-m>"] = ":NvimTreeToggle<CR>", -- Alterna a árvore
            ["<leader>e"] = ":NvimTreeToggle<CR>", -- Abre a árvore com <leader>e
            ["<leader>r"] = ":NvimTreeRefresh<CR>", -- Atualiza a árvore
            --["<leader>f"] = ":NvimTreeFocus<CR>", -- Encontra o arquivo atual na árvore
        },
    },
    renderer = {
        highlight_git = true,   -- Destaque arquivos do Git
        icons = {
            git_placement = "signcolumn", -- Coloca os ícones do Git na coluna de sinal
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    filters = {
        dotfiles = false, -- Mostrar arquivos ocultos
    },
}

-- Bufferline
require("bufferline").setup{
  options = {
    numbers = "ordinal", -- Mostra números dos buffers (ou "none" para desativar)
    diagnostics = "nvim_lsp", -- Integração com LSP
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center" }
    },
    show_buffer_icons = true, -- Mostra ícones dos arquivos
    show_buffer_close_icons = true, -- Mostra botão para fechar buffers
    separator_style = "slant", -- "slant", "thick", "thin", etc.
  }
}
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
-- Fecha o buffer atual com Tab + Q
vim.keymap.set('n', 'q<Tab>', '<Cmd>bdelete<CR>', { noremap = true, silent = true })

-- Adicionando keymaps adicionais
vim.api.nvim_set_keymap("n", "<C-m>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })

require 'nvim-treesitter.install'.prefer_git = false
require 'nvim-treesitter.install'.compilers = {"zig", "gcc"}
require("nvim-treesitter.configs").setup {
  ensure_installed = "all", -- Instala todas as linguagens suportadas
  auto_install = true,
  highlight = {
    enable = true,            -- Ativa o destaque de sintaxe
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,            -- Habilita indentação automática
  },
}

-- Configurar LSPs
local cmp = require('cmp')
--local lspconfig = require('lspconfig')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- Necessário para suporte a snippets
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Confirma o primeiro item de autocompletar
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- Fonte de autocompletar do LSP
    { name = 'luasnip' },   -- Fonte para snippets
  }, {
    { name = 'buffer' },    -- Fonte para palavras no buffer
  })
})

-- Configurar o LSP para usar o `nvim-cmp`
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Capabilities para integração com nvim-cmp (autocomplete)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- LSPs padrão com capabilities
lspconfig.pyright.setup {
  cmd = { "./AppData/Roaming/npm/pyright-langserver.cmd", "--stdio" },
  capabilities = capabilities,
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
}

lspconfig.cssls.setup {
  capabilities = capabilities,
}

lspconfig.html.setup {
  capabilities = capabilities,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
}

lspconfig.gopls.setup {
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unreachable = true,
      },
      staticcheck = true,
    },
  },
}

-- Emmet LSP (caso ainda não exista no configs)
if not configs.ls_emmet then
  configs.ls_emmet = {
    default_config = {
      cmd = { 'ls_emmet', '--stdio' },
      filetypes = {
        'html', 'css', 'scss', 'javascriptreact', 'typescriptreact',
        'haml', 'xml', 'xsl', 'pug', 'slim', 'sass', 'stylus', 'less',
        'sss', 'hbs', 'handlebars',
      },
      root_dir = function(fname)
        return vim.loop.cwd()
      end,
      settings = {},
    },
  }
end

lspconfig.ls_emmet.setup {
  capabilities = capabilities,
}
-- Configuração do HTML
--lspconfig.html.setup{}
---- Configuração do CSS
--lspconfig.cssls.setup{}

-- Desativa smartindent e autoindent para HTML
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt_local.smartindent = false
    vim.opt_local.autoindent = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Mapear atalhos para os comandos do Telescope
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true, silent = true })

--vim.api.nvim_set_hl(0, "String", { italic = false })

-- Fullscreen
local fullscreen_enabled = false

-- Função para alternar entre fullscreen e windowed
function ToggleFullscreen()
    if fullscreen_enabled then
        vim.g.neovide_fullscreen = false -- Sair do modo fullscreen
    else
        vim.g.neovide_fullscreen = true -- Entrar no modo fullscreen
    end
    fullscreen_enabled = not fullscreen_enabled -- Alterna o estado
end

-- Atalho para alternar fullscreen/windowed
--vim.api.nvim_set_keymap("n", "<F5>", ":lua ToggleFullscreen()<CR>", { noremap = true, silent = true })


vim.keymap.set('n', '<leader>b', vim.diagnostic.open_float, { noremap = true, silent = true })
