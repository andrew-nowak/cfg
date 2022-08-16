require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "typescript", "tsx", "scala", "json", "css", "html", "markdown", "markdown_inline" },

  sync_install = true,

  auto_install = true,

  highlight = {
    enable = true
  }
}
