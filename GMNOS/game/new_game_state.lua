local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")


local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write("NEW GAME!", 1)
	data.new_game()
	return states.BETWEEN_ROUNDS
end

function M.handle_command(command)
	return states.NEW_GAME
end

return M