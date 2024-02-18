return {
  "nvim-neotest/neotest",
  dependencies = {
    "haydenmeade/neotest-jest",
  },
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
  opts = function(_, opts)
    table.insert(
      opts.adapters,
      require("neotest-jest")({
        jestCommand = "npm test --",
        jestConfigFile = "custom.jest.config.ts",
        env = { CI = true },
        cwd = function()
          return vim.fn.getcwd()
        end,
      })
    )
  end,
}
