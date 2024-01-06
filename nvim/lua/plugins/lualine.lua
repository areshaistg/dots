-- https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua
local conditions = {
    buffer_not_empty = function()
	return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
	return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
	local filepath = vim.fn.expand("%:p:h")
	local gitdir = vim.fn.finddir(".git", filepath .. ';')
	return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "rebelot/kanagawa.nvim" },
    config = function()
	local palette = require("kanagawa.colors").setup().palette
	local colors = {
	    bg = palette.dragonBlack1,
	    fg = palette.dragonWhite0,
	    yellow = palette.dragonYellow,
	    cyan = palette.Teal,
	    darkblue = palette.dragonBlue,
	    green = palette.dragonGreen2,
	    orange = palette.dragonOrange,
	    violet = palette.dragonViolet,
	    magenta = palette.dragonViolet,
	    blue = palette.dragonBlue,
	    red = palette.dragonRed,
	}

	local lualine = require("lualine")

	local config = {
	    options = {
		component_separators = '',
		section_separators = '',
		theme = {
		    normal = {
			c = { fg = colors.fg, bg = colors.bg }
		    },
		    inactive = {
			c = { fg = colors.fg, bg = colors.bg }
		    }
		}
	    },
	    sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	    },
	    inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	    }
	}

	local function ins_left(component)
	    table.insert(config.sections.lualine_c, component)
	end
	local function ins_right(component)
	    table.insert(config.sections.lualine_x, component)
	end

	ins_left {
	    function()
		return '▊'
	    end,
	    color = { fg = colors.blue },
	    padding = { left = 0, right = 1 }
	}

	ins_left {
	    function()
		-- return ''
		return "●"
	    end,
	    color = function()
		local mode_color = {
		    n = colors.red,
		    i = colors.green,
		    v = colors.blue,
		    [''] = colors.blue,
		    V = colors.blue,
		    c = colors.magenta,
		    no = colors.red,
		    s = colors.orange,
		    S = colors.orange,
		    [''] = colors.orange,
		    ic = colors.yellow,
		    R = colors.violet,
		    Rv = colors.violet,
		    cv = colors.red,
		    ce = colors.red,
		    r = colors.cyan,
		    rm = colors.cyan,
		    ['r?'] = colors.cyan,
		    ['!'] = colors.red,
		    t = colors.red,
		}
		return { fg = mode_color[vim.fn.mode()] }
	    end,
	    padding = { right = 1 },
	}

	ins_left {
	    'filename',
	    cond = conditions.buffer_not_empty,
	    color = { fg = colors.magenta, gui = 'bold' },
	}

	ins_left {
	    function()
		return "%="
	    end
	}

	ins_right {
	    'fileformat',
	    fmt = string.upper,
	    icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	    color = { fg = colors.green, gui = 'bold' },
	}

	ins_right {
	    function()
		return '▊'
	    end,
	    color = { fg = colors.blue },
	    padding = { left = 1 },
	}

	lualine.setup(config)
	vim.opt.showmode = false
    end,
}
