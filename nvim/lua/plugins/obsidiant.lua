return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
    { "<leader>oT", "<cmd>ObsidianTomorrow<cr>", desc = "Obsidian Tomorrow" },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian New" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/mnt/d/obsidiant/brain",
      },
    },
  },
}
