local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("INSTRUCTIONS PAGE TWO:          ", 2)

	display_buffer.write_line("IN THE SHOPPE, YOU CAN BUY      RATIONS AND HEALTH POTIONS.", 1)
	display_buffer.write_line("THE PRICES OF THESE ITEMS WILL  GRADUALLY INCREASE. INFLATION   HIT SPLORR!! TOO.", 1)

	display_buffer.write_line(" ", 1)
	display_buffer.write("0)", 2)
	display_buffer.write_line("DONE", 1)
	return states.INSTRUCTIONS2
end

function M.handle_command(command)
	if command == commands.ZERO then
		return states.TITLE
	end
	return states.INSTRUCTIONS
end

return M