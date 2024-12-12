local states = require("game.states")

local M = {}

local current_state = states.TITLE
local game_states={}
game_states[states.TITLE] = require("game.title_state")
game_states[states.NEW_GAME] = require("game.new_game_state")
game_states[states.INSTRUCTIONS] = require("game.instructions_state")
game_states[states.INSTRUCTIONS2] = require("game.instructions2_state")
game_states[states.BETWEEN_ROUNDS] = require("game.between_rounds_state")
game_states[states.NEW_ROUND] = require("game.new_round_state")
game_states[states.MAKE_GUESS] = require("game.make_guess_state")
game_states[states.DEAD] = require("game.dead_state")
game_states[states.SHOPPE] = require("game.shoppe_state")
game_states[states.INVENTORY] = require("game.inventory_state")

function M.update(dt)
	current_state = game_states[current_state].update(dt)
end

function M.handle_command(command)
	current_state = game_states[current_state].handle_command(command)
	print(current_state)
end

return M