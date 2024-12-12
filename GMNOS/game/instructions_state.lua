local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("INSTRUCTIONS PAGE ONE:          ", 2)

	display_buffer.write_line("IN THIS GAME, YOU PLAY A NUMBER GUESSER IN THE WORLD OF SPLORR!!", 1)
	display_buffer.write_line("THE NUMBER TO GUESS IS BETWEEN  1 AND 100 INCLUSIVE.", 1)
	display_buffer.write_line("YOU WILL GET FEEDBACK ON IF YER GUESS IS TOO LOW OR TOO HIGH.", 1)
	display_buffer.write_line("WHEN YOU GUESS CORRECTLY, YOU   GET PAID BASED ON HOW MANY      GUESSES YOU TOOK. FEWER GUESSES MEANS MORE PAY.", 1)
	display_buffer.write_line("WHILE GUESSING, YOU ARE GETTING HUNGRIER, AND WILL EVENTUALLY   STARVE TO DEATH.", 1)
		
	display_buffer.write_line(" ", 1)
	display_buffer.write("1)", 2)
	display_buffer.write_line("NEXT", 1)
	return states.INSTRUCTIONS
end

function M.handle_command(command)
	if command == commands.ONE then
		return states.INSTRUCTIONS2
	end
	return states.INSTRUCTIONS
end

return M