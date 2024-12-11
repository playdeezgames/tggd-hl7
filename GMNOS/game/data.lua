local states = require("game.states")

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

function M.set_satiety(value)
	data.satiety = math.min(M.get_maximum_satiety(),math.max(0, value))
end

function M.set_health(value)
	data.health = math.min(M.get_maximum_health(),math.max(0, value))
end

function M.process_hunger()
	if M.get_satiety()>0 then
		M.set_satiety(M.get_satiety()-1)
		M.add_message("-1 SATIETY")
	elseif M.get_health()>0 then
		M.set_health(M.get_health()-1)
		M.add_message("STARVING! -1 HEALTH")
		if M.get_health()<=0 then
			M.add_message("YER DEAD!")
		end
	end
end

function M.prompt_guess()
	M.add_message("SATIETY: "..M.get_satiety().."/"..M.get_maximum_satiety())
	M.add_message("HEALTH: "..M.get_health().."/"..M.get_maximum_health())
	M.add_message("GUESS MY NUMBER(1-100)")
end

function M.is_dead()
	return M.get_health()<=0
end

function M.process_guess()
	M.clear_messages()
	M.process_hunger()
	if M.is_dead() then
		return states.DEAD
	end
	local guess = tonumber(data.guess_buffer)
	data.guess_buffer=""
	data.guess_count=data.guess_count+1
	if guess<1 or guess>100 then
		M.add_message("INVALID GUESS!")
		M.prompt_guess()
	elseif guess<data.target then
		M.add_message(guess.." IS TOO LOW!")
		M.prompt_guess()
	elseif guess>data.target then		
		M.add_message(guess.." IS TOO HIGH!")
		M.prompt_guess()
	else
		M.add_message(guess.." IS CORRECT!")
		local jools = math.floor(10/data.guess_count)
		M.add_message("YOU DID IT! +"..jools.." JOOLS!")
		M.set_jools(M.get_jools()+jools)
		M.add_message("YOU TOOK "..data.guess_count.." GUESSES.")
		M.finish_round()
		return states.BETWEEN_ROUNDS
	end
	return states.MAKE_GUESS
end

function M.new_round()
	data.guess_count=0
	data.target=math.random(1,100)
	data.guess_buffer=""
end

function M.start_round()
	M.clear_messages()
	M.prompt_guess()
end

function M.new_game()
	data.total_guesses=0
	data.total_games=0
	data.maximum_health = 10
	data.health = data.maximum_health
	data.maximum_satiety = 10
	data.satiety = data.maximum_satiety
	data.jools = 0
	M.new_round()
end

function M.get_jools()
	return data.jools
end

function M.set_jools(value)
	data.jools = math.max(0, value)
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
	return data.satiety
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
