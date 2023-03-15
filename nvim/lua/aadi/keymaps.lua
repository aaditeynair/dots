local function remap(mode, map, cmd)
    vim.keymap.set(mode, map, cmd, { silent = true })
end

-- easier keys to return to normal mode
remap("i", "jk", "<ESC>")
remap("t", "jk", "<C-\\><C-n>")

-- remove any clutter
remap({ "n", "i" }, "<ESC>", function()
    vim.cmd.nohl()
    vim.cmd.echo()
end)

-- misc
remap("n", "<leader>z", "<CMD>ZenMode<CR>")
remap("n", "<leader>q", "<CMD>Bdelete<CR>")

-- sidebar toggles
remap("n", "<leader>w", function()
    vim.cmd("Neotree close")
    vim.cmd("SidebarNvimToggle")
end)
remap("n", "<leader>e", "<CMD>Neotree focus reveal toggle<CR>")
remap("n", "<leader>u", "<CMD>UndotreeToggle<CR>")

-- enter blanklines
remap("n", "<leader>o", "mzo<Esc>`z")
remap("n", "<leader>O", "mzO<Esc>`z")

-- sessions
remap("n", "<leader>rs", "<CMD>PossessionLoad<CR>")
remap("n", "<leader>ss", "<CMD>Telescope possession list<CR>")

-- better navigation
remap("n", "<C-d>", "<C-d>zz")
remap("n", "<C-u>", "<C-u>zz")
remap("n", "n", "nzzzv")
remap("n", "N", "Nzzzv")

-- move lines in visual mode
remap("v", "J", "<CMD>m '>+1<CR>gv=gv")
remap("v", "K", "<CMD>m '<-2<CR>gv=gv")

-- no idea. copy paster from somewhere
remap("x", "x", '"_x')
remap("x", "<leader>p", '"_dP')
remap("n", "<leader>d", '"_d')
remap("v", "<leader>d", '"_d')

-- increment and descrement numbers
remap("n", "<leader>+", "<C-a>")
remap("n", "<leader>-", "<C-x>")

-- splits
remap("n", "<leader>sv", "<C-w>v")
remap("n", "<leader>sh", "<C-w>s")
remap("n", "<leader>se", "<C-w>=")
remap("n", "<leader>sx", "<CMD>close<CR>")

-- window resize
remap("n", "<S-Up>", "<CMD>resize +2<CR>")
remap("n", "<S-Down>", "<CMD>resize -2<CR>")
remap("n", "<S-Left>", "<CMD>vertical resize +2<CR>")
remap("n", "<S-Right>", "<CMD>vertical resize -2<CR>")

-- tabs
remap("n", "<leader>to", "<CMD>tabnew<CR>")
remap("n", "<leader>tx", "<CMD>tabclose<CR>")
remap("n", "<leader>h", "gT")
remap("n", "<leader>l", "gt")

-- buffers navigation
remap("n", "<A-j>", "<CMD>bnext<CR>")
remap("n", "<A-k>", "<CMD>bprev<CR>")

-- telescope
remap("n", "<leader><leader>", "<CMD>Telescope find_files<CR>")
remap("n", "<leader>fs", "<CMD>Telescope live_grep<CR>")
remap("n", "<leader>fc", "<CMD>Telescope grep_string<CR>")
remap("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
remap("n", "<leader>fh", "<CMD>Telescope help_tags<CR>")
remap("n", "<leader>ff", "<CMD>Telescope file_browser<CR>")

-- identing something
remap("v", "<", "<gv")
remap("v", ">", ">gv")

-- disable arrow keys for line navigation
remap("n", "<up>", "<nop>")
remap("n", "<down>", "<nop>")
remap("n", "<left>", "<nop>")
remap("n", "<right>", "<nop>")

-- trouble
remap("n", "<leader>xx", "<CMD>TroubleToggle<CR>")
remap("n", "<leader>xw", "<CMD>TroubleToggle workspace_diagnostics<CR>")
remap("n", "<leader>xd", "<CMD>TroubleToggle document_diagnostics<CR>")
