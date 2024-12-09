local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("NUMBER GUESSER OF SPLORR!!", 2)
	display_buffer.write_line("A PRODUCTION OF THEGRUMPYGAMEDEV", 1)
	display_buffer.write_line("FOR HONEST JAM VII", 1)
	display_buffer.write_line("DECEMBER 2024", 1)
	display_buffer.write_line(" ", 1)
	display_buffer.write("1)", 2)
	display_buffer.write_line("NEW GAME", 1)
	display_buffer.write("2)", 2)
	display_buffer.write_line("INSTRUCTIONS", 1)
	return states.TITLE
end

function M.handle_command(command)
	if command == commands.ONE then
		return states.NEW_GAME
	elseif command == commands.TWO then
		return states.INSTRUCTIONS
		end
	return states.TITLE
end

return M