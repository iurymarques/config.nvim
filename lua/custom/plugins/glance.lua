return {
  {
    "dnlhc/glance.nvim",
    opts = {
      hooks = {
        before_open = function(results, open, jump, _)
          if #results == 1 then
            jump(results[1]) -- argument is optional
          else
            open(results) -- argument is optional
          end
        end,
      },
    },
  },
}
