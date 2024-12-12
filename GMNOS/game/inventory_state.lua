local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("INVENTORY:                      ", 2)
	display_buffer.write_line("JOOLS: "..data.get_jools(), 1)
	if data.get_rations()>0 then
		display_buffer.write_line("RATIONS: "..data.get_rations(), 1)
	end
	if data.get_potions()>0 then
		display_buffer.write_line("POTIONS: "..data.get_potions(), 1)
	end
	display_buffer.write_line(" ", 1)
	if data.get_rations()>0 then
		display_buffer.write("1)", 2)
		display_buffer.write_line("EAT RATIONS", 1)
	end
	if data.get_potions()>0 then
		display_buffer.write("2)", 2)
		display_buffer.write_line("DRINK POTION", 1)
	end
	display_buffer.write("0)", 2)
	display_buffer.write_line("DONE", 1)
	return states.INVENTORY
end

function M.handle_command(command)
	if command == commands.ZERO then
		return states.BETWEEN_ROUNDS
	elseif command == commands.ONE and data.get_rations()>0 then
		data.eat_rations()
		return states.BETWEEN_ROUNDS
	elseif command == commands.TWO and data.get_potions()>0 then
		data.drink_potion()
		return states.BETWEEN_ROUNDS
	end
	return states.INVENTORY
end

return M