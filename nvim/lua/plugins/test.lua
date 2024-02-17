return {
  "nvim-neotest/neotest",
  keys = {
    {
      "<leader>tb",
      function()
        require("neotest").run.run({ vim.fn.expand("%"), extra_args = { "-bench=." } })
      end,
      desc = "Run Benchmark",
    },
    {
      "<leader>tc",
      function()
        require("neotest").run.run({ vim.fn.expand("%"), extra_args = { "-cover" } })
      end,
      desc = "Run Coverage",
    },
  },
}
