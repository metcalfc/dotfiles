local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
})

-- Auto compile when there are changes in plugins.lua
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

    use({
        "akinsho/bufferline.nvim",
        tag = "*",
        requires = "nvim-tree/nvim-web-devicons",
        after = "catppuccin",
        config = function()
            require("bufferline").setup({
                highlights = require("catppuccin.groups.integrations.bufferline").get(),
            })
        end,
    })

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    use({ "folke/neodev.nvim" })

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        -- or                            , branch = '0.1.x',
        requires = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    undo = {
                        -- telescope-undo.nvim config, see below
                    },
                },
            })
            require("telescope").load_extension("undo")
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
        end,
    })
    use("jremmen/vim-ripgrep")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional
        },
    })

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "dev-v3",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { -- Optional
                "williamboman/mason.nvim",
                run = ":MasonUpdate", -- :MasonUpdate updates registry contents
            },
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" }, -- Required
        },
    })

    use({ "jose-elias-alvarez/null-ls.nvim" })

    use({
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require("dashboard").setup({
                theme = "hyper",
                config = {
                    header = require("metcalfc.config.dashboard"),
                    shortcut = {
                        {
                            desc = " Telescope",
                            group = "DashboardShortCut",
                            key = "t",
                            action = "Telescope find_files",
                        },
                        {
                            desc = " Plugins",
                            group = "DashboardShortCut",
                            key = "p",
                            action = "e ~/src/dotfiles/nvim/lua/metcalfc/plugins.lua",
                        },
                        {
                            desc = " GitHub",
                            group = "DashboardShortCut",
                            key = "g",
                            action = "silent !open https://github.com/metcalfc/dotfiles &> /dev/null &",
                        },
                        {
                            desc = "󰿟 Daytona",
                            group = "DashboardShortCut",
                            key = "d",
                            action = "silent !open https://daytona.io &> /dev/null &",
                        },
                    },
                    footer = { [[]], [[ Focus on what matters.]] },
                },
            })
        end,
        requires = { "nvim-tree/nvim-web-devicons" },
    })

    use({ "lewis6991/gitsigns.nvim" })

    use({
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    })

    use("tpope/vim-fugitive")

    use({
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")

            nvim_tmux_nav.setup({
                disable_when_zoomed = true, -- defaults to false
            })

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
            vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
            vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
        end,
    })

    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                },
            })
        end,
    })

    use({
        "ellisonleao/glow.nvim",
        config = function()
            require("glow").setup()
        end,
    })

    use({ "catppuccin/nvim", as = "catppuccin" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
