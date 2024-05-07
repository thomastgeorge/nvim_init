vim.keymap.set("n", "<F6>", vim.cmd.NvimTreeFindFileToggle, {silent = true})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
})

config = function()
	local nvimtree = require("nvim-tree")
	local api = require("nvim-tree.api")
	local colors = require("util.colors")

	local function on_attach(bufnr)
		local function opts(desc)
			return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
		vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
		vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
		vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
		vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
		vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
		vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
		vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
		vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
		vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
		vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
		vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
		vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
		vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
		vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
		vim.keymap.set('n', 'd', api.fs.remove, opts('Delete')) vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
		vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
		vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
		vim.keymap.set('n', 'm', api.fs.rename, opts('Rename'))
		vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
		vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
		vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
		vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
		vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
		vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
		vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
		vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
		vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
		vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
		vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
		-- vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
		vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
		vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
		vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
		vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
		vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
		vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
		vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
		vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
		vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
		vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
		vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
		vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
		vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
		vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
		vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))

	end

end
	local api = require("nvim-tree.api")
	
	local function tab_win_closed(winnr)
		local tabnr = vim.api.nvim_win_get_tabpage(winnr)
		local bufnr = vim.api.nvim_win_get_buf(winnr)
		local buf_info = vim.fn.getbufinfo(bufnr)[1]
		local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
		local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
		if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
			-- Close all nvim tree on :q
			if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
				api.tree.close()
			end
		else                                                      -- else closed buffer was normal buffer
			if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
				local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
				if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
					vim.schedule(function ()
						if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
							vim.cmd "quit"                                        -- then close all of vim
						else                                                  -- else there are more tabs open
							vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
						end
					end)
				end
			end
		end
	end

	vim.api.nvim_create_autocmd("WinClosed", {
		callback = function ()
			local winnr = tonumber(vim.fn.expand("<amatch>"))
			vim.schedule_wrap(tab_win_closed(winnr))
		end,
		nested = true
	})


