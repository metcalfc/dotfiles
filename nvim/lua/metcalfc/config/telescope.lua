local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

function vim.find_files_from_project_git_root()
    local function is_git_repo()
      vim.fn.system("git rev-parse --is-inside-work-tree")
      return vim.v.shell_error == 0
    end
    local function get_git_root()
      local dot_git_path = vim.fn.finddir(".git", ".;")
      return vim.fn.fnamemodify(dot_git_path, ":h")
    end
    local opts = {}
    if is_git_repo() then
      opts = {
        cwd = get_git_root(),
      }
    end
    require("telescope.builtin").find_files(opts)
end

vim.keymap.set('n', '<leader>pf', vim.find_files_from_project_git_root, {})
