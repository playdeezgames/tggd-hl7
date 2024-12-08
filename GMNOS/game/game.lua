local states = require("game.states")

local M = {}

local current_state = states.TITLE
local game_states={}
game_states[states.TITLE] = require("game.title_state")
game_states[states.NEW_GAME] = require("game.new_game_state")
game_states[states.INSTRUCTIONS] = require("game.instructions_state")

function M.update(dt)
	current_state = game_states[current_state].update(dt)
end

function M.handle_command(command)
	current_state = game_states[current_state].handle_command(command)
	print(current_state)
end

return M