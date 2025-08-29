vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.o.scrolloff = 4

vim.cmd [[set termguicolors]]
vim.g.termguicolors=true

-- indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"

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
    {"zaldih/themery.nvim"},
    {"idr4n/github-monochrome.nvim"},
    {"e-ink-colorscheme/e-ink.nvim"},
    {"silverneko/tachyon.vim"},
    {"lightnolimit/cosmic-latte-nvim"},
    {"anAcc22/sakura.nvim"},
    {"kdheepak/monochrome.nvim"},
    {"ficd0/ashen.nvim"},
    {"darkvoid-theme/darkvoid.nvim"},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
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
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
		require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
		require("mason-lspconfig").setup {
			ensure_installed = { "lua_ls", "pyright", "html", "cssls" },
			automatic_setup = true,
		}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(_, bufnr)
				local opts = { noremap=true, silent=true, buffer=bufnr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			end

			local servers = { "lua_ls", "pyright", "html", "cssls", "ts_ls" }
			for _, server in ipairs(servers) do
			lspconfig[server].setup {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			end
		end,
	},
    {"saadparwaiz1/cmp_luasnip"},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip", -- snippets
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
				},
				mapping = {
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							-- only when luasnip available
							local luasnip = require("luasnip")
							if luasnip and luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()  -- normal tab usage
							end
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							local luasnip = require("luasnip")
							if luasnip and luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"monkoose/neocodeium",
		event = "VeryLazy",
		config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
			vim.keymap.set("i", "<A-f>", neocodeium.accept)
		end,
	},
	{'matze/vim-move'},
	{
		"RRethy/vim-illuminate",
		config = function()
		    require("illuminate").configure({
			providers = { "lsp", "treesitter", "regex" },
			delay = 120,
			filetypes_denylist = { "NvimTree", "packer" },
			under_cursor = true, 
		    })
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
		},
	},
	{'mg979/vim-visual-multi'}, -- Multiple Cursors (Ctrl + N and Ctrl+Up or Down)
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
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- themery - theme switcher
require("themery").setup({
  themes = {"ashen", "darkvoid", "e-ink", "github-monochrome", "habamax", "monochrome", "tachyon"},
  livePreview = true, -- Apply theme while picking. Default to true.
})

-- Bufferline
local bufferline = require("bufferline")
bufferline.setup{
  options = {
    style_preset = bufferline.style_preset.no_italic,
    numbers = "ordinal", -- buffer numbers
    diagnostics = "nvim_lsp", -- lsp integration
    offsets = {
      { filetype = "NvimTree", text = "File Explorer", text_align = "center" }
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    separator_style = "thick", -- "slant", "thick", "thin", etc
  }
}
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
-- Close current buffer Tab + Q
vim.keymap.set('n', 'q<Tab>', '<Cmd>bdelete<CR>', { noremap = true, silent = true })

-- nvim-tree config
require("nvim-tree").setup {
    view = {
        width = 30,              -- tree width
        side = "right",           -- side of the tree
    },
    renderer = {
        highlight_git = true,
        icons = {
            git_placement = "signcolumn", -- git icon on the sign column
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    filters = {
        dotfiles = false, -- show hidden files
    },
}

-- Open file tree
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Remove selected text
vim.api.nvim_set_keymap("n", "<F2><CR>", ":noh", { noremap = true, silent = true })

-- Telescope keymaps
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>b', vim.diagnostic.open_float, { noremap = true, silent = true })
