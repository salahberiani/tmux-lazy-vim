return {
  {
    "nullishamy/autosave.nvim",
    opts = {
      events = {
        register = true,
        triggers = {
          "BufLeave",
          "InsertLeave",
          "TabLeave",
        },
      },
      debounce = {
        enabled = true,
        delay = 100,
      },
    },
  },
}
