return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function ()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end
    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,{ desc = "Add to harpoon" })
    vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,{ desc = "show harpoon list" })
    vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end, { desc = "open harpoon in telescope" })

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,{desc="open 1st entry on harpoon"})
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,{desc="open 2nd entry on harpoon"})
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,{desc="open 3rd entry on harpoon"})
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,{desc="open 4th entry on harpoon"})

    vim.keymap.set("n", "<leader><C-1>", function() harpoon:list():replace_at(1) end,{desc="replace 3rd entry on harpoon"})
    vim.keymap.set("n", "<leader><C-2>", function() harpoon:list():replace_at(2) end,{desc="replace 3rd entry on harpoon"})
    vim.keymap.set("n", "<leader><C-3>", function() harpoon:list():replace_at(3) end,{desc="replace 3rd entry on harpoon"})
    vim.keymap.set("n", "<leader><C-4>", function() harpoon:list():replace_at(4) end,{desc="replace 3rd entry on harpoon"})
  end
}
