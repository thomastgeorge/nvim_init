require("ibl").setup()
require "ibl".overwrite {
        scope = {
            enabled = true,
            show_start = false,
            show_end = false
        },
    enabled = true,
	exclude = { filetypes = {"dashboard", "NvimTree", "terminal"} }
}
