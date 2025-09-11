local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = vim.fn.argc(-1) > 0 and now or later

-- Theme =====================================================================
now(function()
	add("shaunsingh/nord.nvim")
	vim.cmd("colorscheme nord")
end)

-- Tree-sitter (advanced syntax parsing, highlighting, textobjects) ===========
now_if_args(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "main",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	add({
		source = "nvim-treesitter/nvim-treesitter-textobjects",
		checkout = "main",
	})

	require("nvim-treesitter.configs").setup({
		-- A list of parser names, or "all" (the listed parsers MUST always be installed)
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		-- List of parsers to ignore installing (or "all")
		ignore_install = { "javascript" },

		---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
		-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

		highlight = {
			enable = true,

			-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
			-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
			-- the name of the parser)
			-- list of language that will be disabled
			disable = { "c", "rust" },
			-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
	})
end)

-- Install LSP/formatting/linter executables ==================================
later(function()
	add("mason-org/mason.nvim")
	require("mason").setup()
end)

-- Formatting =================================================================
later(function()
	add("stevearc/conform.nvim")

	require("conform").setup({
		-- Map of filetype to formatters
		formatters_by_ft = {
			go = { "gofumpt", "goimports", "golines" },
			javascript = { "prettier" },
			json = { "prettier" },
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format" },
		},

		formatters = {},

		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	})
end)

-- Language server configurations =============================================
later(function()
	-- Enable LSP only on Neovim>=0.11 as it introduced `vim.lsp.config`
	if vim.fn.has("nvim-0.11") == 0 then
		return
	end

	add("neovim/nvim-lspconfig")

	-- All language servers are expected to be installed with 'mason.vnim'
	vim.lsp.enable({
		"gopls",
		"lua_ls",
		"pyright",
		"ts_ls",
	})
end)

-- Better built-in terminal ===================================================
later(function()
	add("kassio/neoterm")

	-- Enable bracketed paste
	vim.g.neoterm_bracketed_paste = 1

	-- Default python REPL
	vim.g.neoterm_repl_python = "ipython"

	-- Default R REPL
	vim.g.neoterm_repl_r = "radian"

	-- Don't add extra call to REPL when sending
	vim.g.neoterm_direct_open_repl = 1

	-- Open terminal to the right by default
	vim.g.neoterm_default_mod = "vertical"

	-- Go into insert mode when terminal is opened
	vim.g.neoterm_autoinsert = 1

	-- Scroll to recent command when it is executed
	vim.g.neoterm_autoscroll = 1

	-- Don't automap keys
	pcall(vim.keymap.del, "n", ",tt")

	-- Change default shell to zsh (if it is installed)
	vim.g.neoterm_shell = vim.fn.executable("nu") == 1 and "nu" or (vim.fn.executable("zsh") == 1 and "zsh" or "bash")
end)

-- Snippet collection =========================================================
later(function()
	add("rafamadriz/friendly-snippets")
end)

-- Documentation generator ====================================================
later(function()
	add("danymat/neogen")
	require("neogen").setup({
		snippet_engine = "mini",
		languages = {
			lua = { template = { annotation_convention = "emmylua" } },
			python = { template = { annotation_convention = "numpydoc" } },
		},
	})
end)

-- Test runner ================================================================
later(function()
	add({ source = "vim-test/vim-test", depends = { "tpope/vim-dispatch" } })
	vim.cmd([[let test#strategy = 'neoterm']])
	vim.cmd([[let test#python#runner = 'pytest']])
end)

-- Filetype: csv ==============================================================
later(function()
	vim.g.disable_rainbow_csv_autodetect = true
	add("mechatroner/rainbow_csv")
end)

-- Filetype: markdown =========================================================
later(function()
	local build = function()
		vim.fn["mkdp#util#install"]()
	end
	add({
		source = "iamcco/markdown-preview.nvim",
		hooks = {
			post_install = function()
				later(build)
			end,
			post_checkout = build,
		},
	})

	-- Do not close the preview tab when switching to other buffers
	vim.g.mkdp_auto_close = 0
end)

-- AI =====================================================================
later(function()
	add("supermaven-inc/supermaven-nvim")
	require("supermaven-nvim").setup({ keymaps = {
		accept_suggestion = "<c-a>",
	} })
end)
