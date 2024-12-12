local display_buffer = require("display_buffer.display_buffer")
local states = require("game.states")
local commands = require("game.commands")
local data = require("game.data")

local M = {}

local cursor_cell = 144

function M.update(dt)
	display_buffer.clear(97)
	for _,message in ipairs(data.get_messages()) do
		display_buffer.write_line(message, 1)
	end
	display_buffer.write("YER GUESS? ", 1)
	display_buffer.write(data.get_guess_buffer(), 1)
	display_buffer.write_cell(cursor_cell)
	cursor_cell = cursor_cell + 16
	if cursor_cell>256 then
		cursor_cell=144
	end
	return states.MAKE_GUESS
end

function M.handle_command(command)
	if command==commands.ZERO then
		if data.get_guess_buffer() ~= "" then
			data.set_guess_buffer(data.get_guess_buffer().."0")
		end
	elseif command==commands.ONE then
		data.set_guess_buffer(data.get_guess_buffer().."1")
	elseif command==commands.TWO then
		data.set_guess_buffer(data.get_guess_buffer().."2")
	elseif command==commands.THREE then
		data.set_guess_buffer(data.get_guess_buffer().."3")
	elseif command==commands.FOUR then
		data.set_guess_buffer(data.get_guess_buffer().."4")
	elseif command==commands.FIVE then
		data.set_guess_buffer(data.get_guess_buffer().."5")
	elseif command==commands.SIX then
		data.set_guess_buffer(data.get_guess_buffer().."6")
	elseif command==commands.SEVEN then
		data.set_guess_buffer(data.get_guess_buffer().."7")
	elseif command==commands.EIGHT then
		data.set_guess_buffer(data.get_guess_buffer().."8")
	elseif command==commands.NINE then
		data.set_guess_buffer(data.get_guess_buffer().."9")
	elseif command==commands.ENTER and data.get_guess_buffer()~="" then
		return data.process_guess()
	elseif command==commands.BACKSPACE then
		if #(data.get_guess_buffer()) > 1 then
			data.set_guess_buffer(string.sub(data.get_guess_buffer(),1,#data.get_guess_buffer()-1))
		else
			data.set_guess_buffer("")
		end
	elseif command==commands.DELETE then
		data.set_guess_buffer("")
	end
	return states.MAKE_GUESS
end

return M