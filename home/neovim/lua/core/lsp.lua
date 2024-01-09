local P = {}

function P.setup(options)
	-- setup languageservers using mason and lspconfig
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = options.language_servers,
		automatic_installation = true,
	})

	-- setup formatters and linters using mason and null-ls
	require("mason-null-ls").setup({
		ensure_installed = options.null_ls_sources,
		automatic_installation = true,
	})

	-- setup syntax highlighting using treesitter
	require("nvim-treesitter.configs").setup({
		ensure_installed = options.ts_languages,
		highlight = { enable = true }
	})

	-- configure formatters and linters using null-ls
	local null = require("null-ls")
	null.setup({
		sources = {
			null.builtins.formatting.stylua,
			null.builtins.completion.spell,
			null.builtins.formatting.prettierd,
		},
	})

	-- configure language servers with lspconfig
	local lspconfig = require("lspconfig")
	
	-- setup cmp
	local cmp = require("cmp")
	cmp.setup({
		formatting = {
		fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })
				kind.kind = " " .. (strings[1] or "") .. " "
				kind.menu = "    (" .. (strings[2] or "") .. ")"

				return kind
			end,
		},
		window = {
			completion = {
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
				col_offset = -3,
				side_padding = 0,
			},
		},
		-- format = require("lspkind").cmp_format({
		-- 	mode = "symbol_text",
		-- 	maxwidth = 50,
		-- 	ellipsis_char = "...",
		-- }),
		sorting = {
			priority_weight = 2,
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		mapping = cmp.mapping.preset.insert({
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-d>"] = cmp.mapping.scroll_docs(4),
			["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
			["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-Space>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "nvim_lsp", group_index = 2 },
			{ name = "luasnip",  group_index = 2 },
			{ name = "path",     group_index = 2 },
		},
	})

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- setup tsserver
	lspconfig.tsserver.setup({
		capabilities = capabilities,
		on_attach = function(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
	})

end

return P
