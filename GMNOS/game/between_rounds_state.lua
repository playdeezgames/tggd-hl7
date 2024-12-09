local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	for _,message in ipairs(data.get_messages()) do
		display_buffer.write_line(message, 1)
	end
	display_buffer.write_line("ROUNDS PLAYED: "..data.get_total_games(), 1)
	display_buffer.write_line("TOTAL GUESSES: "..data.get_total_guesses(), 1)
	--TODO: guesses per round average
	--display_buffer.write_line("SATIETY: "..data.get_satiety().."/"..data.get_maximum_satiety(), 1)
	--display_buffer.write_line("HEALTH: "..data.get_health().."/"..data.get_maximum_health(), 1)
	display_buffer.write_line(" ", 1)
	display_buffer.write("1)", 2)
	display_buffer.write_line("NEXT ROUND", 1)
	display_buffer.write("0)", 2)
	display_buffer.write_line("RETIRE", 1)
		return states.BETWEEN_ROUNDS
end

function M.handle_command(command)
	if command == commands.ONE then
		return states.NEW_ROUND
	elseif command == commands.ZERO then
		return states.TITLE
	end
	return states.BETWEEN_ROUNDS
end

return M