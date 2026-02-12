return {
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"html",
				"pyright",
			}
		},
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "neovim/nvim-lspconfig" },
		}
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.2.1",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
		}
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path"
		},
		opts = function()
			vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			local cmp = require("cmp")
			return {
				auto_brackets = {},
				completion = { completopt = "menu,menuone,noinsert,noselect" },
				preselect = cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.selectbehavior.select }),
					["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.selectbehavior.select }),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "lazydev" },
				})
			}

		end
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local cnl = require('cmp_nvim_lsp')
			vim.lsp.config("*", {
				capabilities = cnl.default_capabilities()
			})
		end
	}
}
