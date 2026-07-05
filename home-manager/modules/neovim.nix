{ pkgs, ... }: {

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # 1. TODOS OS TEUS PLUGINS INSTALADOS VIA NIX
    plugins = with pkgs.vimPlugins; [
      # Interface e Tema
      base16-nvim
      transparent-nvim
      lualine-nvim
      nvim-web-devicons
      
      # UI de Mensagens e Atalhos
      noice-nvim
      nui-nvim
      nvim-notify
      which-key-nvim

      # Navegação e Fuzzy Finder
      nvim-tree-lua
      fzf-lua

      # Sintaxe e Utilitários (Coleção Mini)
      nvim-treesitter.withAllGrammars
      mini-nvim
    ];

    # Executáveis externos necessários no PATH
    extraPackages = with pkgs; [
      gcc
      ripgrep
      fd
    ];

    # 2. TODAS AS CONFIGURAÇÕES UNIFICADAS EM LUA
    initLua = ''
      -----------------------------------------------------------------
      -- GLOBALS (Líderes de Mapeamento)
      -----------------------------------------------------------------
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -----------------------------------------------------------------
      -- OPTIONS (Configurações Nativas do Editor)
      -----------------------------------------------------------------
      -- Opções Básicas
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.cursorline = true
      vim.opt.scrolloff = 10
      vim.opt.sidescrolloff = 8
      vim.opt.wrap = false
      vim.opt.cmdheight = 1
      vim.opt.spelllang = { "en", "br" }

      -- Indentação e Tabulação
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.softtabstop = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.autoindent = true
      vim.opt.grepprg = "rg --vimgrep"
      vim.opt.grepformat = "%f:%l:%c:%m"

      -- Configurações de Busca
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.hlsearch = false
      vim.opt.incsearch = true

      -- Definições Visuais e Estilo
      vim.opt.termguicolors = true
      vim.opt.signcolumn = "yes"
      vim.opt.colorcolumn = "120"
      vim.opt.showmatch = true
      vim.opt.matchtime = 2
      vim.opt.completeopt = "menuone,noinsert,noselect"
      vim.opt.showmode = false
      vim.opt.pumheight = 10
      vim.opt.winblend = 0
      vim.opt.conceallevel = 0
      vim.opt.concealcursor = ""
      vim.opt.lazyredraw = false
      vim.opt.redrawtime = 10000
      vim.opt.maxmempattern = 20000
      vim.opt.synmaxcol = 300

      -- Manipulação de Ficheiros e Buffers
      vim.opt.backup = false
      vim.opt.writebackup = false
      vim.opt.swapfile = false
      vim.opt.undofile = true
      vim.opt.updatetime = 300
      vim.opt.timeoutlen = 500
      vim.opt.ttimeoutlen = 0
      vim.opt.autoread = true
      vim.opt.autowrite = false
      vim.opt.diffopt:append("vertical")
      vim.opt.diffopt:append("algorithm:patience")
      vim.opt.diffopt:append("linematch:60")

      -- Diretório de Undo Histórico
      local undodir = "~/.local/share/nvim/undodir"
      vim.opt.undodir = vim.fn.expand(undodir)
      local undodir_path = vim.fn.expand(undodir)
      if vim.fn.isdirectory(undodir_path) == 0 then
        vim.fn.mkdir(undodir_path, "p")
      end

      -- Comportamentos Gerais
      vim.opt.errorbells = false
      vim.opt.backspace = "indent,eol,start"
      vim.opt.autochdir = false
      vim.opt.iskeyword:append("-")
      vim.opt.path:append("**")
      vim.opt.selection = "inclusive"
      vim.opt.mouse = "a"
      vim.opt.clipboard:append("unnamedplus")
      vim.opt.modifiable = true
      vim.opt.encoding = "UTF-8"
      vim.opt.wildmenu = true
      vim.opt.wildmode = "longest:full,full"
      vim.opt.wildignorecase = true

      -- Aparência do Cursor
      vim.opt.guicursor = {
        "n-v-c:block",
        "i-ci-ve:block",
        "r-cr:hor20",
        "o:hor50",
        "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
        "sm:block-blinkwait175-blinkoff150-blinkon175",
      }

      -- Dobragem de Código (Folding via TreeSitter)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldlevel = 99

      -- Comportamento de Divisão de Janelas
      vim.opt.splitbelow = true
      vim.opt.splitright = true

      -----------------------------------------------------------------
      -- KEYMAPS (Atalhos Gerais)
      -----------------------------------------------------------------
      -- Centralizar ecrã nas buscas e navegação
      vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
      vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
      vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
      vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

      -- Navegação de Buffers
      vim.keymap.set("n", "<leader>bn", "<Cmd>bnext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<leader>bp", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })

      -- Movimentação entre Janelas
      vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
      vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
      vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
      vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

      -- Divisão e Redimensionamento de Splits
      vim.keymap.set("n", "<leader>sv", "<Cmd>vsplit<CR>", { desc = "Split window vertically" })
      vim.keymap.set("n", "<leader>sh", "<Cmd>split<CR>", { desc = "Split window horizontally" })
      vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase window height" })
      vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease window height" })
      vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
      vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase window width" })

      -- Indentação inteligente no Modo Visual
      vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
      vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

      -- Comportamento do J (Mantém a posição do cursor ao juntar linhas)
      vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

      -- Atalho rápido para editar as configurações (Redirecionado para o teu ficheiro Nix)
      vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/home-manager/home.nix<CR>", { desc = "Edit Home Manager config" })

      -- Explorador de Ficheiros (NvimTree)
      vim.keymap.set("n", "<leader>m", "<Cmd>NvimTreeFocus<CR>", { desc = "Focus on File Explorer" })
      vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

      -----------------------------------------------------------------
      -- AUTO-COMMANDS (Eventos Automáticos)
      -----------------------------------------------------------------
      -- Restaurar a última posição do cursor ao reabrir um ficheiro
      local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
      vim.api.nvim_create_autocmd("BufReadPost", {
        group = last_cursor_group,
        callback = function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end
      })

      -- Destacar texto copiado (Yank) por 200ms
      local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
      vim.api.nvim_create_autocmd("TextYankPost", {
        group = highlight_yank_group,
        pattern = "*",
        callback = function()
          vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 200,
          })
        end
      })

      -----------------------------------------------------------------
      -- CONFIGURAÇÕES DOS PLUGINS
      -----------------------------------------------------------------
      -- BASE16 & MATUGEN
      local ok, matugen = pcall(require, 'matugen')
      if ok then matugen.setup() end

      -- TRANSPARENT
      require("transparent").setup({
        extra_groups = { "NormalFloat", "NvimTreeNormal" },
      })

      -- LUALINE
      require("lualine").setup({
        options = {
          theme = 'base16',
          icons_enabled = true,
          section_separators = { left = "", right = "" },
          component_separators = "|",
        },
        sections = {
          lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
          lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
        },
      })

      -- NVIM-WEB-DEVICONS
      require("nvim-web-devicons").setup({})

      -- NOICE & NOTIFY
      local notify = require("notify")
      notify.setup({ background_colour = "#000000" })
      vim.notify = notify

      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })

      -- WHICH-KEY
      require("which-key").setup({})
      vim.keymap.set("n", "<leader>?", function()
        require("which-key").show({ global = false })
      end, { desc = "Buffer Local Keymaps (which-key)" })

      -- NVIM-TREE
      require("nvim-tree").setup({
        filters = { dotfiles = false },
        view = { adaptive_size = true },
      })

      -- FZF-LUA
      require("fzf-lua").setup({})
      vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "FZF Files" })
      vim.keymap.set("n", "<leader>fg", function() require("fzf-lua").live_grep() end, { desc = "FZF Live Grep" })
      vim.keymap.set("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "FZF Buffers" })
      vim.keymap.set("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "FZF Help Tags" })
      vim.keymap.set("n", "<leader>fx", function() require("fzf-lua").diagnostics_document() end, { desc = "FZF Diagnostics Document" })
      vim.keymap.set("n", "<leader>fX", function() require("fzf-lua").diagnostics_workspace() end, { desc = "FZF Diagnostics Workspace" })
      vim.keymap.set("n", "<leader>fs", function() require("fzf-lua").lsp_document_symbols() end, { desc = "FZF Document Symbols" })
      vim.keymap.set("n", "<leader>fS", function() require("fzf-lua").lsp_workspace_symbols() end, { desc = "FZF Workspace Symbols" })

      -- MINI.NVIM
      require("mini.ai").setup({})
      require("mini.comment").setup({})
      require("mini.move").setup({})
      require("mini.surround").setup({})
      require("mini.cursorword").setup({})
      require("mini.indentscope").setup({})
      require("mini.pairs").setup({})
      require("mini.trailspace").setup({})
      require("mini.bufremove").setup({})
    '';
  };
}
