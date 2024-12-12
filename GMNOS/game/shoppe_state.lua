local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

function M.update(dt)
	display_buffer.clear(97)
	display_buffer.write_line("SHOPPE:                         ", 2)
	display_buffer.write_line("RATIONS: "..data.get_rations_price().." JOOLS", 1)
	display_buffer.write_line("POTION: "..data.get_potion_price().." JOOLS", 1)
	--display_buffer.write_line("", 1)
	--display_buffer.write_line("", 1)
	--display_buffer.write_line(" ", 1)
	if data.can_afford_rations() then
		display_buffer.write("1)", 2)
		display_buffer.write_line("BUY RATIONS", 1)
	end
	if data.can_afford_potion() then
		display_buffer.write("2)", 2)
		display_buffer.write_line("BUY POTION", 1)
	end
	display_buffer.write("0)", 2)
	display_buffer.write_line("DONE", 1)
	display_buffer.write_line("JOOLS: "..data.get_jools(), 1)
	if data.get_rations()>0 then
		display_buffer.write_line("RATIONS: "..data.get_rations(), 1)
	end
	if data.get_potions()>0 then
		display_buffer.write_line("POTIONS: "..data.get_potions(), 1)
	end
	return states.SHOPPE
end

function M.handle_command(command)
	if command == commands.ZERO then
		return states.BETWEEN_ROUNDS
	elseif command==commands.ONE and data.can_afford_rations() then
		data.buy_rations()
		return states.SHOPPE
	elseif command==commands.TWO and data.can_afford_potion() then
		data.buy_potion()
		return states.SHOPPE
	end
	return states.SHOPPE
end

return M