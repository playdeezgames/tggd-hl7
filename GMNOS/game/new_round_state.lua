local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write("NEW ROUND", 1)
	data.new_round()
	data.start_round()
	return states.MAKE_GUESS
end

function M.handle_command(command)
	return states.NEW_ROUND
end

return M