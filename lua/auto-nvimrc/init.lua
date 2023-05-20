local M = {}

---@param nvimrc_path string[]
local function maybe_execute_nvimrc(nvimrc_path)
	local file_content = vim.secure.read(nvimrc_path)

	if file_content == nil then
		-- The user did not trust the file. Ignoring
		return
	end

	vim.cmd("source " .. nvimrc_path)
end

---@return string[]
local function get_nvimrcs()
	---@type string[]
	local nvimrcs = vim.fn.findfile(".nvimrc", ".;", -1)
	---@type string[]
	local lua_nvimrcs = vim.fn.findfile(".nvimrc.lua", ".;", -1)

	local combined_nvimrcs = vim.list_extend(nvimrcs, lua_nvimrcs)

	return vim.tbl_map(function(nvimrc)
		return vim.fn.fnamemodify(nvimrc, ":p")
	end, combined_nvimrcs)
end

--- Resets the trust information about nvimrcs
--- and re-executes them.
function M.reset()
	local nvimrcs = get_nvimrcs()

	for _, nvimrc_path in ipairs(nvimrcs) do
		vim.secure.trust({
			action = "remove",
			path = nvimrc_path,
		})

		maybe_execute_nvimrc(nvimrc_path)
	end
end

function M.execute_nvimrcs()
	local nvimrcs = get_nvimrcs()

	for _, nvimrc_path in ipairs(nvimrcs) do
		maybe_execute_nvimrc(nvimrc_path)
	end
end

return M
