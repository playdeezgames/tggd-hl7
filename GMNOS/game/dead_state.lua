local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.clear(97)
	for _,message in ipairs(data.get_messages()) do
		display_buffer.write_line(message, 1)
	end
	display_buffer.write("1)", 2)
	display_buffer.write_line("MAIN MENU", 1)
	return states.DEAD
end

function M.handle_command(command)
	if command == commands.ONE then
		return states.TITLE
	end
	return states.DEAD
end

return M