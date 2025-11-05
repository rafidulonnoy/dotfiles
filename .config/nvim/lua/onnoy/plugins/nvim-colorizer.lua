return{
  'norcalli/nvim-colorizer.lua',
  -- Attaches to every FileType mode
  config = function ()
    require"colorizer".setup()
  end,
}
