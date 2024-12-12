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
	data.maximum_health = 100
	data.health = data.maximum_health
	data.maximum_satiety = 100
	data.satiety = data.maximum_satiety
	data.jools = 0
	data.rations = 0
	data.potions = 0
	data.rations_price = 1
	data.potion_price = 5
	M.new_round()
end

function M.get_rations_price()
	return data.rations_price
end

function M.set_rations_price(value)
	data.rations_price = value
end

function M.get_potion_price()
	return data.potion_price
end

function M.set_potion_price(value)
	data.potion_price = value
end

function M.can_afford_rations()
	return M.get_jools()>=M.get_rations_price()
end

function M.can_afford_potion()
	return M.get_jools()>=M.get_potion_price()
end

function M.get_jools()
	return data.jools
end

function M.get_rations()
	return data.rations
end

function M.set_rations(value)
	data.rations = value
end

function M.get_potions()
	return data.potions
end

function M.set_potions(value)
	data.potions = value
end

function M.buy_rations()
	M.set_rations(M.get_rations()+1)
	M.set_jools(M.get_jools()-M.get_rations_price())
	M.set_rations_price(M.get_rations_price()+1)
end

function M.buy_potion()
	M.set_potions(M.get_potions()+1)
	M.set_jools(M.get_jools()-M.get_potion_price())
	M.set_potion_price(M.get_potion_price()+1)
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

function M.can_enter_shoppe()
	return M.get_jools()>0
end

function M.has_inventory()
	return M.get_rations() > 0 or M.get_potions() > 0
end

function M.eat_rations()
	if M.get_rations()>0 then
		M.clear_messages()
		M.add_message("-1 RATIONS")
		M.set_rations(M.get_rations()-1)
		M.add_message("+25 SATIETY")
		M.set_satiety(M.get_satiety()+25)
	end
end

function M.drink_potion()
	if M.get_potions()>0 then
		M.clear_messages()
		M.add_message("-1 POTION")
		M.set_potions(M.get_potions()-1)
		M.add_message("+25 HEALTH")
		M.set_health(M.get_health()+25)
	end
end

M.new_game()

return M
