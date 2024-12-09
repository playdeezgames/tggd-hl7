local M = {}

local data = {
	messages={}
}

function M.clear_messages()
	data.messages={}
end

function M.add_message(message)
	table.insert(data.messages, message)
end

function M.get_messages()
	return data.messages
end

function M.finish_round()
	data.total_games=data.total_games+1
	data.total_guesses=data.guess_count+data.total_guesses
end

function M.process_guess()
	M.clear_messages()
	local guess = tonumber(data.guess_buffer)
	data.guess_buffer=""
	data.guess_count=data.guess_count+1
	if guess<1 or guess>100 then
		M.add_message("INVALID GUESS!")
		M.add_message("GUESS MY NUMBER(1-100)")
	elseif guess<data.target then
		M.add_message("TOO LOW!")
		M.add_message("GUESS MY NUMBER(1-100)")
	elseif guess>data.target then		
		M.add_message("TOO HIGH!")
		M.add_message("GUESS MY NUMBER(1-100)")
	else
		M.add_message("YOU DID IT!")
		M.add_message("YOU TOOK "..data.guess_count.." GUESSES.")
		M.finish_round()
		return true	
	end
	return false
end

function M.new_round()
	data.guess_count=0
	data.target=math.random(1,100)
	data.guess_buffer=""
end

function M.start_round()
	M.clear_messages()
	M.add_message("GUESS MY NUMBER(1-100)")
end

function M.new_game()
	data.total_guesses=0
	data.total_games=0
	data.maximum_health = 100
	data.health = data.maximum_health
	data.maximum_satiety = 100
	data.satieity = data.maximum_satiety
	M.new_round()
end

function M.get_total_games()
	return data.total_games
end

function M.get_total_guesses()
	return data.total_guesses
end

function M.get_maximum_satiety()
	return data.maximum_satiety
end

function M.get_maximum_health()
	return data.maximum_health
end

function M.get_satiety()
	return data.satieity
end

function M.get_health()
	return data.health
end

function M.get_guess_buffer()
	return data.guess_buffer
end

function M.set_guess_buffer(new_value)
	data.guess_buffer=new_value
end

M.new_game()

return M
