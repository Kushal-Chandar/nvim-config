local M = {}

M.config = function()
  require("dressing").setup {
    select = {
      enabled = true,
      backend = "built-in",
    },
  }
end

return M
