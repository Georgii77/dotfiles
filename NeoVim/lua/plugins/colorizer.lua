return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup()
    end,
  },
}
