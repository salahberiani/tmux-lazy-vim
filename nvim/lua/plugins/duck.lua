return {
  "tamton-aquib/duck.nvim",
  config = function()
    vim.keymap.set("n", "<leader>dd", function()
      require("duck").hatch("🦆", 10)
    end, {}) -- A pretty fast duck
    vim.keymap.set("n", "<leader>dc", function()
      require("duck").hatch("🐈", 5)
    end, {}) -- Quite a mellow cat
    vim.keymap.set("n", "<leader>dk", function()
      require("duck").cook()
    end, {})
  end,
}
