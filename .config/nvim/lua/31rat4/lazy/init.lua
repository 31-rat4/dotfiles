return {
	"xiyaowong/transparent.nvim",
	-- FUNNY
	"eandrju/cellular-automaton.nvim",
	-- Identation
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
		config = function()
		require('ibl').setup()
		end

	},
	"nvim-lua/plenary.nvim",
	-- LSP STUFF
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},

}
