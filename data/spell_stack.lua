if file_exists('spellstack_settings/default_settings.lua') then
    include('spellstack_settings/default_settings.lua')
else
    windower.add_to_chat(050,'Default settings file missing, please download spellstack_settings/default_settings.lua')
end

if file_exists('spellstack_settings/custom_settings.lua') then
    include('spellstack_settings/custom_settings.lua')
else
    windower.add_to_chat(050,'Custom settings file missing, please download spellstack_settings/custom_settings.lua')
end

windower.text.create('stackoutput')
windower.text.set_bg_color('stackoutput', output_position_bg_alpha, output_position_bg_r, output_position_bg_g, output_position_bg_b)
windower.text.set_color('stackoutput', output_position_font_alpha, output_position_font_r, output_position_font_g, output_position_font_b)
windower.text.set_font('stackoutput','fixedsys', 'consolas', 'courier new', 'monospace')
windower.text.set_font_size('stackoutput', output_position_font_size)
windower.text.set_text('stackoutput', '')
windower.text.set_visibility('stackoutput', true)
windower.text.set_bg_visibility('stackoutput', true)
windower.text.set_location('stackoutput', output_position_x, output_position_y)

--Holds the ID of the "party target", used for multiboxing, don't set manually
party_target = false
--Dummy function to be overloaded later by custom function in player file
function party_target_change()
end
--Dummy function to be overloaded later by custom function in player file
function handle_ping()
end

--Tier of helix available, based on gifts
--Sort out how many JP spent to determine helix and storms
local schjpdata = windower.ffxi.get_player().job_points.sch.jp_spent

if schjpdata >= 1200 then
	helixAvailable = 2
else
	helixAvailable = 1
end

--Recas time for stratagems (550 JP gift reduces this to 33s for SCH), 48s for SCH main, 60s for /SCH
if player.main_job == 'SCH' then
	maxStratagems = 5

	if schjpdata >= 550 then
		stratagemRecast = 33
	else
		stratagemRecast = 48
	end
else
	stratagemRecast = 120
	maxStratagems = 2
end

--2 charge max for /SCH, 5 charge for SCH main. maxStratagemTime = (max strats-1) * stratagemRecast
maxStratagemTime = (maxStratagems-1)*stratagemRecast

--pinger variables used to iterate the prerender function every 0.5s
pinger = {}
pinger.lastPing = os.clock()
pinger.sendPing = true

local zoneData = windower.ffxi.get_info()

if exclusion_zones:contains(zoneData.zone) then
	pinger.sendPing = false
end

healerID = 0
spellStack = T{}
autoHaste = T{}
autoSpells  =T{}
songs = T{}

partyData = windower.ffxi.get_party()
recastData = windower.ffxi.get_spell_recasts()

function get_spell_from_name(spell_name)
    for i,v in pairs(gearswap.res.spells) do
        if v['en'] ~= nil and spell_name == v['en'] then
            return v
        end
    end
    return false
end

function get_ability_from_name(spell_name)
    for i,v in pairs(gearswap.res.job_abilities) do
        if v['en'] ~= nil and spell_name == v['en'] then
            return v
        end
    end
    return false
end

function get_ws_from_name(spell_name)
    for i,v in pairs(gearswap.res.weapon_skills) do
        if v['en'] ~= nil and spell_name == v['en'] then
            return v
        end
    end
    return false
end

function get_cure_priority(hp)
	hp = 100-tonumber(hp)
	if hp == 0 or hp > 99 then
		returnVal = 0
	else
		returnVal =  (0.0007*hp*hp*hp*hp) + (0.0028*hp*hp*hp) - (0.707*hp*hp) + (2.7944*hp) + 97.323
	end
	return returnVal
end

function party_distances()
	for ai,av in pairs(alliance) do
		if type(av) == 'table' then
			for i,v in pairs(av) do
				if type(v) == 'table' and v.name ~= nil then
					if v.name == player.name then
						healer = v
					end

					if v.buffactive then
						curablePlayer[v.name] = true
					else
						curablePlayer[v.name] = false
					end

					if not priority_players[v.name] then
						priority_players[v.name] = 1
					end

					if allyStatusHeals == true or (allyStatusHeals == false and ai == 1) then
						if type(v.mob) == 'table' then
							if v.mob.distance ~= nil then
								--all ok
							else
								x = tonumber(v.mob.x) - tonumber(healer.mob.x)
								y = tonumber(v.mob.y) - tonumber(healer.mob.y)
								v.mob.distance = math.sqrt((x * x) + (y * y))
							end
						end
					end
				end
			end
		end
	end
end

party_distances()

function party_buff_change(v, buffName, gain)
    if scSchMode or not ptStatusHeals then
        return false
    end
	if gain and v.buffactive and (player.main_job == 'WHM' or player.sub_job == 'WHM' or (player.main_job == 'SCH' and buffactive['Addendum: White'])) and v.mob and v.mob.distance and v.mob.distance < 420 and v.mob.distance ~= 0.089004568755627 then
        buffName = string.lower(buffName)
        if naSpells[buffName] and os.clock()-lastStatus[buffName] > 15 then
            add_by_priority(naSpells[buffName], v.name, {partyCheck=true})
        end

        erasesNeeded = 0

        for iii,vvv in pairs(eraseables) do
            if buffName == vvv then
				erasesNeeded = erasesNeeded + 1
			end
		end

		if player.main_job == 'WHM' and erasesNeeded > 1 and os.clock() - lastStatus['Sacrifice'] > 15 then
			add_by_priority(gearswap.res.spells[94], v.name, {partyCheck=true})
			lastStatus['Sacrifice'] = os.clock()
		elseif erasesNeeded >= 1 and os.clock()-lastStatus['Erase'] > 15 then
			add_by_priority(gearswap.res.spells[143], v.name, {partyCheck=true})
			lastStatus['Erase'] = os.clock()
		end
	elseif not gain and v.buffactive and v.hp > 0 and (player.main_job == 'WHM' or player.sub_job == 'WHM') and naSpells[string.lower(buffName)] and v.hp > 0 then
		rebuildArray(naSpells[string.lower(buffName)], v.name)
	elseif not gain and not buffactive['weakness'] and ignoreProtShellWear and v.hp > 0 and (player.main_job == 'WHM' or player.main_job == 'SCH' or player.main_job == 'RDM') then
		if buffName == 'Protect' then
			if player.main_job == 'WHM' and checkAoERange(v.name) then
				add_to_back(gearswap.res.spells[129], player.name, {partyCheck=true})
			else
				add_to_back(gearswap.res.spells[47], v.name, {partyCheck=true})
			end
		end
		if buffName == 'Haste' then
            if player.main_job == 'RDM' then
                add_by_priority(gearswap.res.spells[511], v.name, {partyCheck=true})
            else
			     add_by_priority(gearswap.res.spells[57], v.name, {partyCheck=true})
            end
		end
		if buffName == 'Shell' then
			if player.main_job == 'WHM' and checkAoERange(v.name) then
				add_to_back(gearswap.res.spells[134], player.name, {partyCheck=true})
			else
				add_to_back(gearswap.res.spells[52], v.name, {partyCheck=true})
			end
		end
	end
end

function cure_process()
	clear_cures()
	curaga_count = 0
	biggest_curaga_weight = 0
	biggest_curaga_weight_index = 0
	best_curaga_tier = 0
	biggest_cure_weight = 0
	biggest_cure_index = 0

	if buffactive['visitant'] then
		thiscure3_threshold = abyssea_cure_3_amount
	else
		thiscure3_threshold = cure_3_amount
	end


	for i,v in pairs(partyData) do
		if type(v) == 'table' then
			if partyData[i].name == player.name then
				healerID = i
			end
			if v.hp ~= nil and partyData[i].hp > 0 then
				if partyData[i].hp > 0 then
					if (partyData[i].hp > 3000) and (partyData[i].hpp < 85) then
						partyData[i].hpp = 99
						print('Detecting darkknight hp buff, ignoring cure')
					end
					partyData[i].healneeded = (partyData[i].hp / ( partyData[i].hpp / 100) )-partyData[i].hp
				end
			end
		end
	end

	for i,v in pairs(partyData) do
		if type(v) == 'table' and v.name ~= nil then
			curaga_weight = 0
			curaga_tier = 0
			curaga_prio = 0
			curaga_healed = 0
			curaga_count = 0

			if i ~= healerID then
				if type(partyData[i].mob) == 'table' then
					--Fix any missing distance values and set 0 to 0.1
					if partyData[i].mob.distance == nil then
						x = tonumber(partyData[i].mob.x) - tonumber(partyData[healerID].mob.x)
						y = tonumber(partyData[i].mob.y) - tonumber(partyData[healerID].mob.y)
						partyData[i].mob.distance = math.sqrt((x * x) + (y * y))
					end
					--Fix any missing distance values and set 0 to 0.1
				end
			else
				if type(partyData[i].mob) == 'table' then
					partyData[i].mob.distance = 0.1
				else
					partyData[i].mob = T{}
					partyData[i].mob.distance = 0.1
				end
			end

			if type(partyData[i].mob) == 'table' and partyData[i].mob.distance ~= nil and partyData[i].mob.x ~= nil and partyData[i].mob.y ~= nil then
				if i:sub(1,1) == 'p' then

					if curablePlayer[partyData[i].name] and partyData[i].hp > 0 and partyData[i].mob.distance < 420 and partyData[i].mob.distance ~= 0.089004568755627 and partyData[i].name ~= 'Kupofried' then
						if (player.main_job == 'WHM' or player.sub_job == 'WHM') then
							for ii,vv in pairs(partyData) do
								if type(vv) == 'table' and type(partyData[ii].mob) == 'table' and ii:sub(1,1) == 'p' then
									if partyData[ii].mob.x ~= nil and partyData[ii].mob.y ~= nil then
										x = tonumber(partyData[i].mob.x) - tonumber(partyData[ii].mob.x)
										y = tonumber(partyData[i].mob.y) - tonumber(partyData[ii].mob.y)

										if partyData[ii].healneeded == nil then
											if partyData[ii].hp > 0 then
												partyData[ii].healneeded = (partyData[ii].hp / ( partyData[ii].hpp / 100) )-partyData[ii].hp
											else
												partyData[ii].healneeded = 0
											end
										end

										if ((x * x) + (y * y)) <= 185 then
											if partyData[ii].healneeded > curaga_2_amount then
												curaga_count = curaga_count + 1
												curaga_prio = curaga_prio + partyData[ii].hpp
												curaga_healed = curaga_healed + partyData[ii].healneeded
											end

											if partyData[ii].healneeded > curaga_5_amount and curaga_tier < 5 then
												curaga_tier = 5
											elseif partyData[ii].healneeded > curaga_4_amount and curaga_tier < 4 then
												curaga_tier = 4
											elseif partyData[ii].healneeded > curaga_3_amount and curaga_tier < 3 then
												curaga_tier = 3
											elseif partyData[ii].healneeded > curaga_2_amount and curaga_tier < 2 then
												curaga_tier = 2
											end
										end
									end
								end
							end

							if curaga_count > 1 and curaga_prio > 0 then
								curaga_weight = get_cure_priority(curaga_prio/curaga_count)*curaga_healed
								if curaga_weight > biggest_curaga_weight then
									biggest_curaga_weight = curaga_weight
									biggest_curaga_weight_index = i
									best_curaga_tier = curaga_tier
								end
							end
						end
					end

					if partyData[i].hp > 0 and partyData[i].healneeded > thiscure3_threshold and partyData[i].mob.distance < 420 then
						if get_cure_priority(partyData[i].hpp)*partyData[i].healneeded > biggest_cure_weight then
							biggest_cure_weight = get_cure_priority(partyData[i].hpp) * partyData[i].healneeded * priority_players[v.name]
							biggest_cure_index = i
						end
					end
				elseif allianceHeal then
					if partyData[i].healneeded == nil and partyData[i].hp > 0 then
						if partyData[i].hp > 0 then
							partyData[i].healneeded = (partyData[i].hp / ( partyData[i].hpp / 100) )-partyData[i].hp
						else
							partyData[i].healneeded = 0
						end
					end
					if partyData[i].hp > 0 and partyData[i].healneeded > thiscure3_threshold and partyData[i].mob.distance < 420 then
						if get_cure_priority(partyData[i].hpp)*partyData[i].healneeded > biggest_cure_weight then
							biggest_cure_weight = get_cure_priority(partyData[i].hpp) * partyData[i].healneeded * priority_players[v.name]
							biggest_cure_index = i
						end
					end
				end
			end
		end
	end

	if player.main_job == 'WHM' then
		if best_curaga_tier >= 2 and biggest_curaga_weight >= biggest_cure_weight then
			if best_curaga_tier == 5 and is_spell_ready('Curaga V') then
				add_to_front(gearswap.res.spells[11], partyData[biggest_curaga_weight_index].name, {partyCheck=true})
                return true
			elseif best_curaga_tier == 4 and is_spell_ready('Curaga IV') then
				add_to_front(gearswap.res.spells[10], partyData[biggest_curaga_weight_index].name, {partyCheck=true})
                return true
			elseif best_curaga_tier == 3 and is_spell_ready('Curaga III') then
				add_to_front(gearswap.res.spells[9], partyData[biggest_curaga_weight_index].name, {partyCheck=true})
                return true
			elseif best_curaga_tier == 2 and is_spell_ready('Curaga II') then
				add_to_back(gearswap.res.spells[8], partyData[biggest_curaga_weight_index].name, {partyCheck=true})
                return true
			end
        end
		if biggest_cure_weight > 0 and partyData[biggest_cure_index] ~= nil then
			if partyData[biggest_cure_index].healneeded > cure_6_amount and is_spell_ready('Cure VI') then
				add_to_front(gearswap.res.spells[6], partyData[biggest_cure_index].name, false)
                return true
			elseif partyData[biggest_cure_index].healneeded > cure_5_amount and is_spell_ready('Cure V') then
				add_to_front(gearswap.res.spells[5], partyData[biggest_cure_index].name, false)
                return true
			elseif partyData[biggest_cure_index].healneeded > cure_4_amount and is_spell_ready('Cure IV') then
				add_to_front(gearswap.res.spells[4], partyData[biggest_cure_index].name, false)
                return true
			elseif partyData[biggest_cure_index].healneeded > thiscure3_threshold and is_spell_ready('Cure III') then
				add_to_back(gearswap.res.spells[3],  partyData[biggest_cure_index].name, false)
                return true
			end
		end
	elseif player.main_job == 'SCH' or player.main_job == 'RDM' then
		if player.sub_job == 'WHM' and best_curaga_tier >= 1 and biggest_curaga_weight >= biggest_cure_weight and is_spell_ready('Curaga II') then
			add_to_back(gearswap.res.spells[8], partyData[biggest_curaga_weight_index].name, {partyCheck=true})
		elseif biggest_cure_weight > 0 and partyData[biggest_cure_index] ~= nil then
			if partyData[biggest_cure_index].healneeded > cure_4_amount and is_spell_ready('Cure IV') then
				add_to_front(gearswap.res.spells[4], partyData[biggest_cure_index].name, false)
			elseif not scSchMode and partyData[biggest_cure_index].healneeded > thiscure3_threshold and is_spell_ready('Cure III') then
				add_to_back(gearswap.res.spells[3],  partyData[biggest_cure_index].name, false)
			end
		end
	elseif player.sub_job == 'WHM' then
		if best_curaga_tier >= 1 and biggest_curaga_weight >= biggest_cure_weight and is_spell_ready('Curaga II') then
			add_to_back(gearswap.res.spells[8], partyData[biggest_curaga_weight_index].name, {partyCheck=true})
		elseif biggest_cure_weight > 0 and partyData[biggest_cure_index] ~= nil then
			if partyData[biggest_cure_index].healneeded > cure_4_amount and is_spell_ready('Cure IV') then
				add_to_front(gearswap.res.spells[4], partyData[biggest_cure_index].name, false)
			elseif partyData[biggest_cure_index].healneeded > thiscure3_threshold and is_spell_ready('Cure III') then
				add_to_back(gearswap.res.spells[3],  partyData[biggest_cure_index].name, false)
			end
		end
	elseif player.main_job == 'PLD' then
		if biggest_cure_weight > 0 and partyData[biggest_cure_index] ~= nil then
			if partyData[biggest_cure_index].healneeded > cure_4_amount and is_spell_ready('Cure IV') then
				add_to_front(gearswap.res.spells[4], partyData[biggest_cure_index].name, false)
			elseif partyData[biggest_cure_index].healneeded > thiscure3_threshold and is_spell_ready('Cure III') then
				add_to_back(gearswap.res.spells[3],  partyData[biggest_cure_index].name, false)
			end
		end
	elseif player.sub_job == 'SCH' or player.sub_job == 'RDM' then
		if biggest_cure_weight > 0 and partyData[biggest_cure_index] ~= nil then
			if partyData[biggest_cure_index].healneeded > thiscure3_threshold and is_spell_ready('Cure III') then
				add_to_back(gearswap.res.spells[3],  partyData[biggest_cure_index].name, false)
			end
		end
	end
end

function handleSpareTime()
	if #spellStack > 0 then
        --Find the first spell that we can actually cast in the list
        for i=1, #spellStack, 1 do
            if spellStack[i] ~= nil and ((spellStack[i].fixed_order and i == 1) or not spellStack[i].fixed_order) and check_spell_is_handleable(spellStack[i].spell) then
                --If the spell is fundamentally castable (no amnesia/silence/omerta etc, and recast is ready)
                if spellStack[i].spell.prefix == '/ra' then
                    windower.send_command('input /ra;')
                    spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                    break
                elseif spellStack[i].spell.prefix == '/song' then
                    if spellStack[i].pianissimo ~= nil and spellStack[i].pianissimo == true and not buffactive['pianissimo'] then
                        windower.send_command('input /ja "Pianissimo" '..player.name..';')
                        break
                    else
                        if spellStack[i]['target'] == 'self' or (spellStack[i]['target'] == player.name and checkRange(spellStack[i]['target'], true)) then
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..player.name..';')
                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                            break
                        elseif spellStack[i]['target'] == 'bt' then
                            if party_target ~= false and check_target_exists(spellStack[i].spell, party_target) then
                                windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..party_target..';')
                            else
                                windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <bt>;')
                            end
                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                        elseif tonumber(spellStack[i]['target']) ~= nil then
                            if check_target_exists(spellStack[i].spell, spellStack[i]['target']) then
                                windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                            else
                                spellStack[i]['failCount'] = 6
                            end
                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                        elseif checkRange(spellStack[i]['target'], true) then
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                            break
                        end
                    end
                elseif (spellStack[i].spell.en == 'Arise' or spellStack[i].spell.en:sub(1,5) == 'Raise') then
                    if checkRaisable(spellStack[i]['target']) then
                        windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                        spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                        break
                    else
                        spellStack[i]['failCount'] = 6
                    end
                elseif spellStack[i].spell.prefix == '/weaponskill' and player.status == 'Engaged' and player.tp >= 1000 then
                    if spellStack[i]['target'] == 't' then
                        windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <t>;')
                        spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                        break
                    elseif spellStack[i]['target'] == 'bt' then
                        if party_target ~= false and check_target_exists(spellStack[i].spell, party_target) then
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..party_target..';')
                        else
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <bt>;')
                        end
                        spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                    elseif tonumber(spellStack[i]['target']) ~= nil then
                        if check_target_exists(spellStack[i].spell, spellStack[i]['target']) then
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                        else
                            spellStack[i]['failCount'] = 6
                        end
                        spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                    elseif spellStack[i]['target'] == player.name or checkRange(spellStack[i]['target'], false) then
                        windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                        spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                        break
                    else
                        spellStack[i]['failCount'] = 6
                    end
                elseif spellStack[i].with_stratagem ~= nil and spellStack[i].with_stratagem ~= false and not buffactive[spellStack[i].with_stratagem] then
                    --If the spell needs a stratagem with it before casting, use the stratagem
                    if is_stratagem_ready(spellStack[i].with_stratagem) then
                        --Only send the command off if we strats are ready
                        windower.send_command('input /ja "'..spellStack[i].with_stratagem..'" '..player.name..';')
                        spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                    end
                    break
                else
                    --No stratagem needs to be paired, or stratagem is already active
                    if spellStack[i]['target'] == 't' then
                        --If the spell is a skillchain step, then we add party chat
                        if spellStack[i].skillchain_step == 1 then
                            local_mobs = windower.ffxi.get_mob_by_target('t')
                            if local_mobs ~= nil and local_mobs.name ~= nil then
                                windower.send_command('input /p Starting '..spellStack[i].skillchain_name..' on '..local_mobs.name..';input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <t>;')
                            else
                                windower.send_command('input /p Starting '..spellStack[i].skillchain_name..';input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <t>;')
                            end
                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                            break
                        elseif spellStack[i].skillchain_step == 2 then
                            if local_mobs ~= nil and local_mobs.name ~= nil then
                                windower.send_command('input /p Closing '..spellStack[i].skillchain_name..' on '..local_mobs.name..';input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <t>;')
                            else
                                windower.send_command('input /p Closing '..spellStack[i].skillchain_name..';input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <t>;')
                            end

                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                            break
                        else
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <t>;')
                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                            break
                        end
                    elseif spellStack[i]['target'] == 'bt' then
                        if party_target ~= false and check_target_exists(spellStack[i].spell, party_target) then
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..party_target..';')
                        else
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" <bt>;')
                        end
                        spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                        break
                    elseif tonumber(spellStack[i]['target']) ~= nil then
                        --If we have a specific target ID, ensure it's valid before casting on it
                        if check_target_exists(spellStack[i].spell, spellStack[i]['target']) then
                            local_mobs = windower.ffxi.get_mob_by_id(spellStack[i]['target'])
                            if spellStack[i].skillchain_step == 1 then
                                if local_mobs ~= nil and local_mobs.name ~= nil then
                                    windower.send_command('input /p Starting '..spellStack[i].skillchain_name..' on '..local_mobs.name..';input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                                end
                                spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                                break
                            elseif spellStack[i].skillchain_step == 2 then
                                if local_mobs ~= nil and local_mobs.name ~= nil then
                                    windower.send_command('input /p Closing '..spellStack[i].skillchain_name..' on '..local_mobs.name..';input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                                end
                                spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                                break
                            else
                                windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                                spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                                break
                            end

                            break
                        else
                            spellStack[i]['failCount'] = 6
                            windower.add_to_chat(055, 'Target '..spellStack[i]['target']..' was determined as invalid')
                        end
                    elseif spellStack[i]['target'] == player.name or checkRange(spellStack[i]['target'], spellStack[i]['partyCheck']) then
                        if spellStack[i].spell.en == 'Arise' or spellStack[i].spell.en:sub(1,5) == 'Raise' then
                            if checkRaisable(spellStack[i]['target']) then
                                windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                                spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                                break
                            else
                                --Remove this spell
                                spellStack[i]['failCount'] = 6
                            end
                        else
                            windower.send_command('input '..spellStack[i].spell.prefix..' "'..spellStack[i].spell.en..'" '..spellStack[i]['target']..';')
                            spellStack[i]['failCount'] = spellStack[i]['failCount'] + 1
                            break
                        end
                    else
                        spellStack[i]['failCount'] = 6
                    end
                end
            end
        end

        for i,v in pairs(spellStack) do
            if v['failCount'] ~= nil and v['failCount'] > 5 then
                rebuildArray(v['spell'], v['target'])
            end
        end
    end
    showArrayContents()
end


function checkRaisable(playerName)
	for i,v in pairs(partyData) do
		if type(v) == 'table' then
			if partyData[i].name ~= nil and partyData[i].name == playerName and partyData[i].hp == 0 and type(partyData[i].mob) == 'table' then
				if partyData[i].mob.distance ~= nil then
					if partyData[i].mob.distance < 420 then
						return true
					else
						return false
					end
				else
					x = tonumber(partyData[i].mob.x) - tonumber(healer.mob.x)
					y = tonumber(partyData[i].mob.y) - tonumber(healer.mob.y)

					if (x * x) + (y * y) < 420 then
						return true
					else
						return false
					end
				end
			end
		end
	end

	return false
end

function checkRange(playerName, partyOnly)
	for i,v in pairs(windower.ffxi.get_party()) do
		if type(v) == 'table' then
			if (allyStatusHeals == true and partyOnly == false) or (partyOnly == true and i:sub(1,1) =='p') or (allyStatusHeals == false and i:sub(1,1) =='p') then
				if v.name ~= nil and v.hp > 0 and v.name == playerName then
					if type(v.mob) == 'table' and v.mob.distance ~= nil and v.mob.distance < 420 and v.mob.distance ~= 0.089004568755627 then
						return true
					else
						return false
					end
				end
			end
		end
	end
	return false
end

function checkRangeAlly(playerName, partyOnly)
	for i,v in pairs(partyData) do
		if type(v) == 'table' then
			if allyStatusHeals == true and i:sub(1,1) =='a' then
				if partyData[i].name ~= nil and partyData[i].hp > 0 and partyData[i].name == playerName then
					if type(partyData[i].mob) == 'table' then
						if partyData[i].mob.distance ~= nil then
							if partyData[i].mob.distance < 420 and partyData[i].mob.distance ~= 0.089004568755627 then
								return true
							else
								return false
							end
						else
							x = tonumber(partyData[i].mob.x) - tonumber(healer.mob.x)
							y = tonumber(partyData[i].mob.y) - tonumber(healer.mob.y)

							if (x * x) + (y * y) < 420 then
								return true
							else
								return false
							end
						end
					else
						return false
					end
				end
			end
		end
	end

	return false
end

function checkInQueue(spellName, spellTarget, spellCommand)
	if type(spellStack) == 'table' then
		for i=1, #spellStack, 1 do
			if type(spellStack[i]) == 'table' then
				if spellStack[i].spell.en == spellName and (spellStack[i]['target'] == spellTarget or (spellTarget == player.name and spellStack[i]['target'] == 'self'))then
					--Spell already in queue
					return true
				end
			end
		end
	else
		return false
	end
end

function check_spell_is_handleable(spell_to_add)
    if  spell_to_add.prefix == '/ra' or
        ( spell_to_add.prefix == '/weaponskill' and not buffactive['impairment'] and not buffactive['amnesia'] and player.tp >= 1000) or
        ( spell_to_add.type ~= nil and spell_to_add.type == 'Scholar' and autoStrat and not buffactive['impairment'] and not buffactive['amnesia'] and not buffactive[spell_to_add.en] and is_stratagem_ready(spell_to_add.en) ) or
        ( (spell_to_add.prefix == '/jobability' or spell_to_add.prefix == '/pet') and not buffactive['impairment'] and not buffactive['amnesia'] and windower.ffxi.get_ability_recasts()[spell_to_add.recast_id] == 0) or
        ( (spell_to_add.prefix == '/magic' or spell_to_add.prefix == '/ninjutsu' or spell_to_add.prefix == '/ninjutsu' or spell_to_add.prefix == '/ninjutsu' or spell_to_add.prefix == '/ninjutsu') and not buffactive['silence'] and not buffactive['omerta'] and recastData[spell_to_add.id] == 0 and player.mp > spell_to_add.mp_cost ) or
        ( spell_to_add.prefix == '/song' and not buffactive['silence'] and not buffactive['omerta'] and recastData[spell_to_add.id] == 0 ) then
        return true
    end
    return false
end

function check_spell_is_addable(spell_to_add)
    if  ( spell_to_add.prefix == '/weaponskill' and not buffactive['impairment'] and not buffactive['amnesia'] ) or
        ( spell_to_add.type ~= nil and spell_to_add.type == 'Scholar' and autoStrat and not buffactive['impairment'] and not buffactive['amnesia'] and not buffactive[spell_to_add.en] and is_stratagem_ready(spell_to_add.en) ) or
        ( (spell_to_add.prefix == '/jobability' or spell_to_add.prefix == '/pet') and not buffactive['impairment'] and not buffactive['amnesia'] and windower.ffxi.get_ability_recasts()[spell_to_add.recast_id] < 5) or
        ( (spell_to_add.prefix == '/magic' or spell_to_add.prefix == '/ninjutsu' or spell_to_add.prefix == '/ninjutsu' or spell_to_add.prefix == '/ninjutsu' or spell_to_add.prefix == '/ninjutsu') and not buffactive['silence'] and not buffactive['omerta'] and recastData[spell_to_add.id] < 500 and player.mp > spell_to_add.mp_cost ) or
        ( spell_to_add.prefix == '/song' and not buffactive['silence'] and not buffactive['omerta'] and recastData[spell_to_add.id] < 500 ) then
        return true
    end
    return false
end

function add_to_back(spell_to_add, spellTarget, extra_args)
    partyCheck = false
    pianissimo = false
    with_stratagem = false
    skillchain_name = ''
    skillchain_step = 0
    fixed_order = false

    if spell_to_add == 'Ranged Attack' then
        spell_to_add = {
            id = 4,
            english = 'Ranged Attack',
            en = 'Ranged Attack',
            prefix = '/ra',
        }
        spellTarget = 't'
    elseif type(spell_to_add) ~= 'table' then
        windower.add_to_chat(055, spell_to_add..' is not a valid spell, find the correct gearswap.res.spells or .job_abilities or .weapon_skills')
    end

    if type(extra_args)== 'table' then
        for key,v in pairs(extra_args) do
            if key == 'partyCheck' and v == true then
                partyCheck = true
            elseif key == "with_stratagem" then
                with_stratagem = v
            elseif key == "skillchain_name" then
                skillchain_name = v
            elseif key == "skillchain_step" then
                skillchain_step = v
            elseif key == "pianissimo" then
                pianissimo = true
            elseif key == "fixed_order" then
                fixed_order = true
            end
        end
    end

	if spell_to_add.prefix == '/ra' or check_spell_is_addable(spell_to_add) then

		currentFail = 0
        hasTargetID = false

        if tonumber(spellTarget) ~= nil then
            if not check_target_exists(spell_to_add, spellTarget) then
                windower.add_to_chat(055, 'Target '..spellTarget..' was determined as invalid')
                return false
            end
            hasTargetID = true
        elseif spellTarget == 'bt' and party_target ~= false then
            spellTarget = party_target
            hasTargetID = true
        end

		if type(spellStack) == 'table' then
			local tempSpellStack = T{}
			j = 1
			for i=1, #spellStack, 1 do
				if type(spellStack[i]) == 'table' then
					if spellStack[i]['target'] == spellTarget and spellStack[i]['spell'].id == spell_to_add.id then
                        --If we're trying to add a spell that's already in the queue, then we don't need to do a thing
                        return true
					else
                        --Preserve all the current spells in queue
                        tempSpellStack[j] = {}
                        table.reassign(tempSpellStack[j], spellStack[i])
						j = j +1
					end
				end
			end

			table.clear(spellStack)
			table.reassign(spellStack, tempSpellStack)
            --Add the new spell to the end of the stack
			spellStack:append({
                    spell=spell_to_add,
                    target=spellTarget,
                    failCount=currentFail,
                    hasTargetID=hasTargetID,
                    partyCheck = partyCheck,
                    with_stratagem = with_stratagem,
                    skillchain_name = skillchain_name,
                    skillchain_step = skillchain_step,
                    pianissimo = pianissimo,
                    fixed_order = fixed_order,
                })
		else
			spellStack = T{}
			spellStack:append({
                    spell=spell_to_add,
                    target=spellTarget,
                    failCount=currentFail,
                    hasTargetID=hasTargetID,
                    partyCheck = partyCheck,
                    with_stratagem = with_stratagem,
                    skillchain_name = skillchain_name,
                    skillchain_step = skillchain_step,
                    pianissimo = pianissimo,
                    fixed_order = fixed_order,
                })
		end
	end
    showArrayContents()
end

function add_by_priority(spell_to_add, spellTarget, extra_args)
    partyCheck = false
    with_stratagem = false
    skillchain_name = ''
    skillchain_step = 0
    pianissimo = false
    fixed_order = false

    if type(extra_args)== 'table' then
        for key,v in pairs(extra_args) do
            if key == 'partyCheck' and v == true then
                partyCheck = true
            elseif key == "with_stratagem" then
                with_stratagem = v
            elseif key == "skillchain_name" then
                skillchain_name = v
            elseif key == "skillchain_step" then
                skillchain_step = v
            elseif key == "pianissimo" then
                pianissimo = true
            elseif key == "fixed_order" then
                fixed_order = true
            end
        end
    end

    if check_spell_is_addable(spell_to_add) then

		currentFail = 0
        hasTargetID = false

        if tonumber(spellTarget) ~= nil then
            if not check_target_exists(spell_to_add, spellTarget) then
                windower.add_to_chat(055, 'Target '..spellTarget..' was determined as invalid')
                return false
            end
            hasTargetID = true
        elseif spellTarget == 'bt' and party_target ~= false then
            spellTarget = party_target
            hasTargetID = true
        end

		if type(spellStack) == 'table' and type(spellStack[1]) == 'table' then
			local tempSpellStack = T{}
			j = 1
			notAdded = true
			for i=1, #spellStack, 1 do
				if type(spellStack[i]) == 'table' then
					--Check each spell for it's target's priority. If it's greater than the new one, leave it in place. If our new spell has higher priority though, we insert before it.
					if (spellStack[i].spell.prefix ~= '/magic' or (spellStack[i].spell.prefix == '/magic' and spellStack[i].spell.id > 11) ) and
                        notAdded and
                        priority_players[spellStack[i]['target']] and
                        priority_players[spellTarget] and
                        priority_players[spellStack[i]['target']] < priority_players[spellTarget]
                        then
						tempSpellStack[j] = {
                                spell = spell_to_add,
                                target = spellTarget,
                                failCount = currentFail,
                                hasTargetID = hasTargetID,
                                partyCheck = partyCheck,
                                with_stratagem = with_stratagem,
                                skillchain_name = skillchain_name,
                                skillchain_step = skillchain_step,
                                pianissimo = pianissimo,
                                fixed_order = fixed_order,
                            }
						j = j + 1
						notAdded = false
					end

                    tempSpellStack[j] = {}
                    table.reassign(tempSpellStack[j], spellStack[i])
					j = j + 1
				end
			end
			if notAdded then
				tempSpellStack[j] = {
                    spell = spell_to_add,
                    target = spellTarget,
                    failCount = currentFail,
                    hasTargetID = hasTargetID,
                    partyCheck = partyCheck,
                    with_stratagem = with_stratagem,
                    skillchain_name = skillchain_name,
                    skillchain_step = skillchain_step,
                    pianissimo = pianissimo,
                    fixed_order = fixed_order,
                }
			end
			table.clear(spellStack)
			table.reassign(spellStack, tempSpellStack)
		else
			table.clear(spellStack)
			spellStack:append({
                spell = spell_to_add,
                target = spellTarget,
                failCount = currentFail,
                hasTargetID = hasTargetID,
                partyCheck = partyCheck,
                with_stratagem = with_stratagem,
                skillchain_name = skillchain_name,
                skillchain_step = skillchain_step,
                pianissimo = pianissimo,
                fixed_order = fixed_order,
            })
		end
	end
    showArrayContents()
end

function add_to_front(spell_to_add, spellTarget, extra_args)
    partyCheck = false
    with_stratagem = false
    skillchain_name = ''
    skillchain_step = 0
    pianissimo = false
    fixed_order = false

    if type(extra_args)== 'table' then
        for key,v in pairs(extra_args) do
            if key == 'partyCheck' and v == true then
                partyCheck = true
            elseif key == "with_stratagem" then
                with_stratagem = v
            elseif key == "skillchain_name" then
                skillchain_name = v
            elseif key == "skillchain_step" then
                skillchain_step = v
            elseif key == "pianissimo" then
                pianissimo = true
            elseif key == "fixed_order" then
                fixed_order = true
            end
        end
    end

    if check_spell_is_addable(spell_to_add) then
        if tonumber(spellTarget) ~= nil then
            if not check_target_exists(spell_to_add, spellTarget) then
                windower.add_to_chat(055, 'Target '..spellTarget..' was determined as invalid')
                return false
            end
            hasTargetID = true
        elseif spellTarget == 'bt' and party_target ~= false then
            spellTarget = party_target
            hasTargetID = true
        end

		if type(spellStack) == 'table' then
			--outputString = ''
			local tempSpellStack = T{}
			tempSpellStack[1] = {
                    spell = spell_to_add,
                    target = spellTarget,
                    failCount = 0,
                    hasTargetID = hasTargetID,
                    partyCheck = partyCheck,
                    with_stratagem = with_stratagem,
                    skillchain_name = skillchain_name,
                    skillchain_step = skillchain_step,
                    pianissimo = pianissimo,
                    fixed_order = fixed_order,
                }
			j = 2
			for i=1, #spellStack, 1 do
				if type(spellStack[i]) == 'table' then
                    if (spell_to_add.type ~= nil and spell_to_add.type == 'Scholar') or spellStack[i]['target'] ~= spellTarget or spellStack[i]['spell'].id ~= spell_to_add.id then
                        --If we're adding a strat, allow multiples because we might be queueing multiple strats with spells
                        tempSpellStack[j] = {}
                        table.reassign(tempSpellStack[j], spellStack[i])
                        j = j +1
                    else
                        --If we're trying to add a spell that's already in the queue, then we don't need to preserve it, since it's now at the front
					end
				end
			end
			table.clear(spellStack)
			table.reassign(spellStack, tempSpellStack)
		else
			spellStack = T{}
			spellStack:append({
                    spell = spell_to_add,
                    target = spellTarget,
                    failCount = 0,
                    hasTargetID = hasTargetID,
                    partyCheck = partyCheck,
                    with_stratagem = with_stratagem,
                    skillchain_name = skillchain_name,
                    skillchain_step = skillchain_step,
                    pianissimo = pianissimo,
                    fixed_order = fixed_order,
                })
		end
	end
    showArrayContents()
end

function remove_party_target_spells(target_id)
    if type(spellStack) == 'table' then
        local tempSpellStack = T{}
        j = 1
        removedSpellOnce = false
        for i=1, #spellStack, 1 do
            if type(spellStack[i]) == 'table' then
                --Dont bring across the spell we're removing to the new table
                if spellStack[i]['target'] ~= target_id then
                    tempSpellStack[j] = {}
                    table.reassign(tempSpellStack[j], spellStack[i])
                    j = j +1
                end
            end
        end
        table.clear(spellStack)
        table.reassign(spellStack, tempSpellStack)
    end
end

function rebuildArray(spell_to_remove, target)
	if type(spellStack) == 'table' then
		local tempSpellStack = T{}
		j = 1
		removedSpellOnce = false
		for i=1, #spellStack, 1 do
			if type(spellStack[i]) == 'table' then
				--Dont bring across the spell we're removing to the new table
                if removedSpellOnce == false and spellStack[i].spell.prefix == spell_to_remove.prefix and spellStack[i].spell.id == spell_to_remove.id and spellStack[i]['target'] == target then
					--Only remove stratagems once, because skillchains require multiple usage of strat
                    if spellStack[i].spell.type ~= nil and spellStack[i].spell.type == 'Scholar' then
                        removedSpellOnce = true
                    end
				else
                    tempSpellStack[j] = {}
                    table.reassign(tempSpellStack[j], spellStack[i])
					j = j +1
				end
			end
		end
		table.clear(spellStack)
		table.reassign(spellStack, tempSpellStack)
	end
end


function showArrayContents()
    outputString = ''
    if type(spellStack) == 'table' and #spellStack > 0 then
	   outputString = 'Pos Spell                Target       Tries\n'
		j = #spellStack
		if j > output_max_lines then
			j = output_max_lines
		end
		for i=1, j, 1 do
			if type(spellStack[i]) == 'table' then
                num = tostring(i)
                target = tostring(spellStack[i]['target'])
				outputString = outputString..num:rpad(' ',3)..' '..spellStack[i].spell.en:rpad(' ',20)..' '..target:rpad(' ',12)..' '..spellStack[i]['failCount'].."\n"
            end
        end
    end

    if type(autoSpells) == 'table' and #autoSpells > 0 then
        if outputString ~= '' then
            outputString = outputString..'-------------------------------------------\n'
        end
        outputString = outputString..'    Repeating Spell      Target       Timer\n'
        for i,v in pairs(autoSpells) do
            if type(v) == 'table' then
                num = tostring(math.round(v['nextCast']-os.clock()))..'s'
                target = tostring(v['target'])
                outputString = outputString..'    '..v.spell.en:rpad(' ',20)..' '..target:rpad(' ',12)..' '..num.."\n"
            end
        end
    end

    windower.text.set_text('stackoutput', outputString)
end

function checkAoERange(playerName)
	for i,v in pairs(partyData) do
		if type(v) == 'table' then
			if i:sub(1,1) =='p' then
				if partyData[i].name ~= nil and partyData[i].name == playerName then
					if type(partyData[i].mob) == 'table' then
						if partyData[i].mob.distance ~= nil then
							if partyData[i].mob.distance < 100 and partyData[i].mob.distance ~= 0.089004568755627 then
								return true
							else
								return false
							end
						else
							x = tonumber(partyData[i].mob.x) - tonumber(healer.mob.x)
							y = tonumber(partyData[i].mob.y) - tonumber(healer.mob.y)

							if ((x * x) + (y * y)) < 100 then
								return true
							else
								return false
							end
						end
					else
						return false
					end
				end
			end
		end
	end
	return false
end

function add_divine_caress()
	if autoCaress and windower.ffxi.get_ability_recasts()[gearswap.res.job_abilities[270].recast_id] == 0 and not buffactive['impairment'] and not buffactive['amnesia'] then
		add_to_back(gearswap.res.job_abilities[270], player.name, false)
	end
end

function process_push_string(message, sender)
	message = string.lower(windower.convert_auto_trans(message))
	if player.main_job == 'BRD' and (message:sub(1,4) == 'sing' or message:sub(1,12) == 'keep singing') and valid_controllers:contains(sender) then
		if message:sub(#message-1,#message) == 'me' and checkRange(sender, true) then
			message = message:sub(1,#message-1)..' '..sender
		end

		windower.send_command('gs c '..message:gsub("[%w ]+","%1"))
		result = false
	elseif stunMode == false then
		local stillTrue = true
        castSaid = false

		if player.main_job == 'SCH' then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_sch(w,sender)
				else
					break
				end
			end
		elseif player.main_job == 'WHM' then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_whm(w,sender)
				else
					break
				end
			end
		elseif player.main_job == 'BRD' then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_brd(w,sender)
				else
					break
				end
			end
		elseif player.main_job == 'RDM' then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_rdm(w,sender)
				else
					break
				end
			end
		elseif player.sub_job == 'DNC' then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_dncsub(w,sender)
				else
					break
				end
			end
		elseif player.sub_job == 'WHM' and player.sub_job_level > 0 then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_whmsub(w,sender)
				else
					break
				end
			end
		elseif player.sub_job == 'RDM' and player.sub_job_level > 0 then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_rdmsub(w,sender)
				else
					break
				end
			end
		elseif player.main_job == 'BLM' then
			process_split_string_blm(message,sender)
		elseif player.main_job == 'PLD' then
			for w in string.gmatch(message, "%w+") do
				if stillTrue then
					stillTrue = process_split_string_pld(w,sender)
				else
					break
				end
			end
		end
	end
end

function process_split_string_rdmsub(message, sender)
	result = false
	fiveSlice = message:sub(1,5)
    if message == player.name:lower() then
        return true
	elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
		if checkRangeAlly(sender, false) then
			add_to_back(gearswap.res.spells[1], sender)
			result = true
		end
	elseif fiveSlice == 'haste' then
		if checkRange(sender, false) then
			add_to_back(gearswap.res.spells[57], sender)
			result = true
		end
	elseif fiveSlice == 'refre' then
		if checkRange(sender, false) then
			add_to_back(gearswap.res.spells[109], sender)
			result = true
		end
	elseif fiveSlice == 'flurr' then
		if checkRange(sender, false) then
			add_to_back(gearswap.res.spells[845], sender)
			result = true
		end
	elseif fiveSlice == 'sneak' and checkRange(sender, true) then
		add_to_back(gearswap.res.spells[137], sender, {partyCheck=true})
		result = true
	elseif fiveSlice == 'invis' and checkRange(sender, true) then
		add_to_back(gearswap.res.spells[136], sender, {partyCheck=true})
		result = true
	elseif fiveSlice == 'raise' and checkRaisable(sender) then
		add_to_back(gearswap.res.spells[12], sender, {partyCheck=true})
		result = true
	end

	if result and #spellStack == 0 and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
		handleSpareTime()
	end
	return result
end

function process_split_string_whmsub(message, sender)
	result = false
	threeSlice = message:sub(1,3)
	fourSlice = message:sub(1,4)
	fiveSlice = message:sub(1,5)
	sixSlice = message:sub(1,6)
	sevenSlice = message:sub(1,7)

    if message == player.name:lower() then
        return true
	elseif fourSlice == 'para' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[15], sender)
			result = true
		end
	elseif fiveSlice == 'blind' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[16], sender)
			result = true
		end
	elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[18], sender, {partyCheck=true})
			result = true
		end
	elseif fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[19], sender, {partyCheck=true})
			result = true
		end
	elseif fiveSlice == 'silen' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[17], sender)
			result = true
		end
	elseif fiveSlice == 'curse' or fourSlice == 'doom' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[20], sender)
			result = true
		end
	elseif fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' then
		if checkRange(sender, true) then
			add_by_priority(gearswap.res.spells[143], sender, {partyCheck=true})
			result = true
		end
	elseif sixSlice == 'poison' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[14], sender)
			result = true
		end
	elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
		if checkRange(sender, true) then
			add_by_priority(gearswap.res.spells[7], sender, {partyCheck=true})
			result = true
		elseif checkRangeAlly(sender, false) then
			add_by_priority(gearswap.res.spells[1], sender)
			result = true
		end
	elseif fiveSlice == 'haste' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[57], sender)
			result = true
		end
	elseif fiveSlice == 'sneak' and checkRange(sender, true) then
		add_to_back(gearswap.res.spells[137], sender, {partyCheck=true})
		result = true
	elseif fiveSlice == 'invis' and checkRange(sender, true) then
		add_to_back(gearswap.res.spells[136], sender, {partyCheck=true})
		result = true
	elseif fiveSlice == 'raise' and checkRaisable(sender) then
		add_by_priority(gearswap.res.spells[12], sender, {partyCheck=true})
		result = true
	end

	if result and #spellStack == 0 and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
		handleSpareTime()
	end
	return result
end

function process_split_string_dncsub(message, sender)
	result = false
	threeSlice = message:sub(1,3)
	fourSlice = message:sub(1,4)
	fiveSlice = message:sub(1,5)
	sixSlice = message:sub(1,6)
	sevenSlice = message:sub(1,7)
	eightSlice = message:sub(1,8)

    if message == player.name:lower() then
        return true
	elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
		if checkRange(sender, true) then
			add_to_back(gearswap.res.job_abilities[195], sender, {partyCheck=true})
			result = true
		end
	elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' or sixSlice == 'poison' or fiveSlice == 'silen' or fiveSlice == 'blind' or fourSlice == 'para' or fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' or fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' then
		if checkRange(sender, true) then
			add_to_back(gearswap.res.job_abilities[194], sender, {partyCheck=true})
			result = true
		end
	end
	if result and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
		handleSpareTime()
	end
	return result
end

function process_split_string_blm(message, sender)
	result = false

    local temp_target = 't'
    if party_target ~= false then
        temp_target = party_target
    end

    if message == player.name:lower() then
        return true
	elseif message == 'fire blm' then
		add_to_back(get_spell_from_name('Pyrohelix'), temp_target)
		add_to_back(get_spell_from_name('Burn'), temp_target)
		add_to_back(get_spell_from_name('Fire II'), temp_target)
		add_to_back(get_spell_from_name('Firaga'), temp_target)
		add_to_back(get_spell_from_name('Fire III'), temp_target)
		add_to_back(get_spell_from_name('Firaga II'), temp_target)
		add_to_back(get_spell_from_name('Fire IV'), temp_target)
		add_to_back(get_spell_from_name('Firaga III'), temp_target)
		add_to_back(get_spell_from_name('Firaja'), temp_target)
		add_to_back(get_spell_from_name('Flare'), temp_target)
	elseif message == 'earth blm' then
		add_to_back(get_spell_from_name('Geohelix'), temp_target)
		add_to_back(get_spell_from_name('Rasp'), temp_target)
		add_to_back(get_spell_from_name('Stone II'), temp_target)
		add_to_back(get_spell_from_name('Stonega'), temp_target)
		add_to_back(get_spell_from_name('Stone III'), temp_target)
		add_to_back(get_spell_from_name('Stonega II'), temp_target)
		add_to_back(get_spell_from_name('Stone IV'), temp_target)
		add_to_back(get_spell_from_name('Stonega III'), temp_target)
		add_to_back(get_spell_from_name('Stoneja'), temp_target)
		add_to_back(get_spell_from_name('Quake'), temp_target)
	elseif message == 'water blm' then
		add_to_back(get_spell_from_name('Hydrohelix'), temp_target)
		add_to_back(get_spell_from_name('Drown'), temp_target)
		add_to_back(get_spell_from_name('Poison'), temp_target)
		add_to_back(get_spell_from_name('Poisonga'), temp_target)
		add_to_back(get_spell_from_name('Poison II'), temp_target)
		add_to_back(get_spell_from_name('Water II'), temp_target)
		add_to_back(get_spell_from_name('Waterga'), temp_target)
		add_to_back(get_spell_from_name('Water III'), temp_target)
		add_to_back(get_spell_from_name('Waterga II'), temp_target)
		add_to_back(get_spell_from_name('Water IV'), temp_target)
		add_to_back(get_spell_from_name('Waterga III'), temp_target)
		add_to_back(get_spell_from_name('Waterja'), temp_target)
		add_to_back(get_spell_from_name('Flood'), temp_target)
	elseif message == 'wind blm' then
		add_to_back(get_spell_from_name('Anemohelix'), temp_target)
		add_to_back(get_spell_from_name('Choke'), temp_target)
		add_to_back(get_spell_from_name('Aero II'), temp_target)
		add_to_back(get_spell_from_name('Aeroga'), temp_target)
		add_to_back(get_spell_from_name('Aero III'), temp_target)
		add_to_back(get_spell_from_name('Aeroga II'), temp_target)
		add_to_back(get_spell_from_name('Aero IV'), temp_target)
		add_to_back(get_spell_from_name('Aeroga III'), temp_target)
		add_to_back(get_spell_from_name('Aeroja'), temp_target)
		add_to_back(get_spell_from_name('Tornado'), temp_target)
	elseif message == 'ice blm' then
		add_to_back(get_spell_from_name('Cryohelix'), temp_target)
		add_to_back(get_spell_from_name('Frost'), temp_target)
		add_to_back(get_spell_from_name('Blizzard II'), temp_target)
		add_to_back(get_spell_from_name('Blizzaga'), temp_target)
		add_to_back(get_spell_from_name('Blizzard III'), temp_target)
		add_to_back(get_spell_from_name('Blizzaga II'), temp_target)
		add_to_back(get_spell_from_name('Blizzard IV'), temp_target)
		add_to_back(get_spell_from_name('Blizzaga III'), temp_target)
		add_to_back(get_spell_from_name('Blizzaja'), temp_target)
		add_to_back(get_spell_from_name('Freeze'), temp_target)
	elseif message == 'lightning blm' then
		add_to_back(get_spell_from_name('Ionohelix'), temp_target)
		add_to_back(get_spell_from_name('Stun'), temp_target)
		add_to_back(get_spell_from_name('Shock'), temp_target)
		add_to_back(get_spell_from_name('Thunder II'), temp_target)
		add_to_back(get_spell_from_name('Thundaga'), temp_target)
		add_to_back(get_spell_from_name('Thunder III'), temp_target)
		add_to_back(get_spell_from_name('Thundaga II'), temp_target)
		add_to_back(get_spell_from_name('Thunder IV'), temp_target)
		add_to_back(get_spell_from_name('Thundaga III'), temp_target)
		add_to_back(get_spell_from_name('Thundaja'), temp_target)
		add_to_back(get_spell_from_name('Burst'), temp_target)
	elseif message == 'light blm' then
		add_to_back(get_spell_from_name('Luminohelix'), temp_target)
	elseif message == 'dark blm' then
		add_to_back(get_spell_from_name('Noctohelix'), temp_target)
		add_to_back(get_spell_from_name('Drain'), temp_target)
		add_to_back(get_spell_from_name('Aspir'), temp_target)
		add_to_back(get_spell_from_name('Bio II'), temp_target)
		add_to_back(get_spell_from_name('Blind'), temp_target)
		add_to_back(get_spell_from_name('Dispel'), temp_target)
	end

	return result
end

function process_split_string_rdm(message, sender)
    result = false
    threeSlice = message:sub(1,3)
    fourSlice = message:sub(1,4)
    fiveSlice = message:sub(1,5)
    sixSlice = message:sub(1,6)
    sevenSlice = message:sub(1,7)

    if message == player.name:lower() then
        return true
    elseif message == 'cast' then
        castSaid = true
        return true
    elseif castSaid then
        if sevenSlice == 'frazzle' then
            if party_target ~= false then
                add_to_back(stack_spells[frazzleAvailable], party_target)
                result = true
            end
        elseif message:sub(1,8) == 'distract' then
            if party_target ~= false then
                add_to_back(stack_spells[distractAvailable], party_target)
                result = true
            end
        elseif fourSlice == 'slow' then
            if party_target ~= false then
                add_to_back(stack_spells[slowAvailable], party_target)
                result = true
            end
        elseif fourSlice == 'para' then
            if party_target ~= false then
                add_to_back(stack_spells[paraAvailable], party_target)
                result = true
            end
        elseif threeSlice == 'dia' then
            if party_target ~= false then
                add_to_back(stack_spells[diaAvailable], party_target)
                result = true
            end
        elseif threeSlice == 'bio' then
            if party_target ~= false then
                add_to_back(stack_spells[bioAvailable], party_target)
                result = true
            end
        elseif fiveSlice == 'blind' then
            if party_target ~= false then
                add_to_back(stack_spells[blindAvailable], party_target)
                result = true
            end
        elseif sevenSlice == 'silence' then
            if party_target ~= false then
                add_to_back(stack_spells['Silence'], party_target)
                result = true
            end
        elseif fiveSlice == 'break' then
            if party_target ~= false then
                add_to_back(stack_spells['Break'], party_target)
                result = true
            end
        elseif fiveSlice == 'sleep' then
            if party_target ~= false then
                add_to_back(stack_spells['Sleep II'], party_target)
                result = true
            end
        elseif sixSlice == 'dispel' then
            if party_target ~= false then
                add_to_back(stack_spells['Dispel'], party_target)
                result = true
            end
        elseif fourSlice == 'grav' then
            if party_target ~= false then
                add_to_back(stack_spells['Gravity II'], party_target)
                result = true
            end
        elseif fiveSlice == 'addle' then
            if party_target ~= false then
                add_to_back(stack_spells[addleAvailable], party_target)
                result = true
            end
        end
    elseif fourSlice == 'prot' then
        if checkRange(sender, true) then
            add_to_back(gearswap.res.spells[47], sender, {partyCheck=true})
            result = true
            end
    elseif fiveSlice == 'shell' then
        if checkRange(sender, true) then
            add_to_back(gearswap.res.spells[52], sender, {partyCheck=true})
            result = true
            end
    elseif fiveSlice == 'haste' then
        if checkRange(sender, false) then
            add_by_priority(gearswap.res.spells[511], sender)
            result = true
        end
    elseif sevenSlice == 'refresh' then
        if checkRange(sender, false) then
            add_by_priority(stack_spells[refreshAvailable], sender)
            result = true
        end
    elseif sixSlice == 'flurry' then
        if checkRange(sender, false) then
            add_by_priority(stack_spells['Flurry II'], sender)
            result = true
        end
    elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
        if checkRangeAlly(sender, false) then
            add_by_priority(gearswap.res.spells[1], sender)
            result = true
        end
    elseif (fiveSlice == 'raise') and checkRaisable(sender) then
        add_by_priority(stack_spells['Raise II'], sender, {partyCheck=true})
        result = true
    elseif player.sub_job == 'SCH' and player.sub_job_level > 0 then
        if buffactive['Addendum: White'] then
            if fourSlice == 'para' then
                if checkRange(sender, false) and queue_white_status() then
                    add_to_back(gearswap.res.spells[15], sender)
                    result = true
                end
            elseif fiveSlice == 'blind' then
                if checkRange(sender, false) and queue_white_status() then
                    add_to_back(gearswap.res.spells[16], sender)
                    result = true
                end
            elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' then
                if checkRange(sender, false) and queue_white_status() then
                    add_to_back(gearswap.res.spells[18], sender, {partyCheck=true})
                    result = true
                end
            elseif fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' then
                if checkRange(sender, false) and queue_white_status() then
                    add_to_back(gearswap.res.spells[19], sender, {partyCheck=true})
                    result = true
                end
            elseif fiveSlice == 'silen' then
                if checkRange(sender, false) then
                    add_to_back(gearswap.res.spells[17], sender)
                    result = true
                end
            elseif fiveSlice == 'curse' or fourSlice == 'doom' then
                if checkRange(sender, false) and queue_white_status() then
                    add_to_back(gearswap.res.spells[20], sender)
                    result = true
                end
            elseif fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' then
                if checkRange(sender, true) and queue_white_status() then
                    add_to_back(gearswap.res.spells[143], sender, {partyCheck=true})
                    result = true
                end
            elseif sixSlice == 'poison' then
                if checkRange(sender, false) and queue_white_status() then
                    add_to_back(gearswap.res.spells[14], sender)
                    result = true
                end
            end
        end
        if message:sub(-5) == 'storm' then
            if checkRange(sender, true) then
                if fourSlice == 'sand' or fiveSlice == 'earth' or sixSlice == 'darude' then
                    add_to_back(gearswap.res.spells[99], sender, {partyCheck=true})
                    result = true
                elseif fourSlice == 'wind' or fourSlice == 'aero' then
                    add_to_back(gearswap.res.spells[114], sender, {partyCheck=true})
                    result = true
                elseif fourSlice == 'rain' or fiveSlice == 'water' then
                    add_to_back(gearswap.res.spells[113], sender, {partyCheck=true})
                    result = true
                elseif fourSlice == 'fire' then
                    add_to_back(gearswap.res.spells[115], sender, {partyCheck=true})
                    result = true
                elseif fourSlice == 'hail' or  fourSlice == 'ice' or fiveSlice == 'blizz' then
                    add_to_back(gearswap.res.spells[116], sender, {partyCheck=true})
                    result = true
                elseif fourSlice == 'thun' then
                    add_to_back(gearswap.res.spells[117], sender, {partyCheck=true})
                    result = true
                elseif fourSlice == 'dark' or fourSlice == 'void' then
                    add_to_back(gearswap.res.spells[118], sender, {partyCheck=true})
                    result = true
                elseif fiveSlice == 'light' or sixSlice == 'aurora' then
                    add_to_back(gearswap.res.spells[119], sender, {partyCheck=true})
                    result = true
                end
            end
        end
    elseif player.sub_job == 'WHM' and player.sub_job_level > 0 then
        if fourSlice == 'para' then
            if checkRange(sender, false) then
                add_by_priority(gearswap.res.spells[15], sender)
                result = true
            end
        elseif fiveSlice == 'blind' then
            if checkRange(sender, false) then
                add_by_priority(gearswap.res.spells[16], sender)
                result = true
            end
        elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' then
            if checkRange(sender, false) then
                add_by_priority(gearswap.res.spells[18], sender, {partyCheck=true})
                result = true
            end
        elseif fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' then
            if checkRange(sender, false) then
                add_by_priority(gearswap.res.spells[19], sender, {partyCheck=true})
                result = true
            end
        elseif fiveSlice == 'silen' then
            if checkRange(sender, false) then
                add_by_priority(gearswap.res.spells[17], sender)
                result = true
            end
        elseif fiveSlice == 'curse' or fourSlice == 'doom' then
            if checkRange(sender, false) then
                add_by_priority(gearswap.res.spells[20], sender)
                result = true
            end
        elseif fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' then
            if checkRange(sender, true) then
                add_by_priority(gearswap.res.spells[143], sender, {partyCheck=true})
                result = true
            end
        elseif sixSlice == 'poison' then
            if checkRange(sender, false) then
                add_by_priority(gearswap.res.spells[14], sender)
                result = true
            end
        end
    end

    if result and #spellStack == 0 and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
        handleSpareTime()
    end

    return result
end

function queue_light_arts()
    if autoStrat then
        if buffactive['Addendum: White'] or buffactive['Light Arts'] then
            return true
        elseif is_ability_ready('Light Arts') then
            direct_push_front(gearswap.res.job_abilities[211], 'ja', player.name, {partyCheck=true})
            return true
        end
    end

    return false
end

function queue_white_status()
	if autoStrat then
		if buffactive['Addendum: White'] then
			return true
		elseif not buffactive['Addendum: White'] and not buffactive['Light Arts'] and is_ability_ready('Light Arts') and is_stratagem_ready('Addendum: White') then
			direct_push_front(gearswap.res.job_abilities[234], 'ja', player.name, {partyCheck=true})
			direct_push_front(gearswap.res.job_abilities[211], 'ja', player.name, {partyCheck=true})
			return true
		elseif not buffactive['Addendum: White'] and buffactive['Light Arts'] and is_stratagem_ready('Addendum: White') then
			direct_push_front(gearswap.res.job_abilities[234], 'ja', player.name, {partyCheck=true})
			return true
		else
			return false
		end
	else
		return false
	end
end

function process_split_string_sch(message, sender)
	result = false
	threeSlice = message:sub(1,3)
	fourSlice = message:sub(1,4)
	fiveSlice = message:sub(1,5)
	sixSlice = message:sub(1,6)
	sevenSlice = message:sub(1,7)
	eightSlice = message:sub(1,8)

    if message == player.name:lower() then
        return true
    elseif message == 'cast' then
        castSaid = true
        return true
	elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
		if checkRangeAlly(sender, false) then
			add_by_priority(gearswap.res.spells[1], sender)
			result = true
		end
	elseif fiveSlice == 'regen' and checkRange(sender, true) then
		if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
			add_to_back(gearswap.res.spells[504], sender, {with_stratagem='Perpetuance'})
			result = true
		else
			add_to_back(gearswap.res.spells[504], sender, {partyCheck=true})
			result = true
		end
	elseif (fiveSlice == 'regai' or fiveSlice == 'adloq') and checkRange(sender, true) then
		if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
			add_to_back(gearswap.res.spells[495], sender, {with_stratagem='Perpetuance'})
			result = true
		else
			add_to_back(gearswap.res.spells[495], sender, {partyCheck=true})
			result = true
		end
	elseif fourSlice == 'prot' and not scSchMode then
		if checkRange(sender, true) then
			if not buffactive['Accession'] and count_stratagems_ready() >= 2 and queue_light_arts() then
				add_to_back(gearswap.res.spells[47], sender, {with_stratagem='Accession', partyCheck=true})
				result = true
			else
				add_to_back(gearswap.res.spells[47], sender, {partyCheck=true})
				result = true
			end
		end
	elseif fiveSlice == 'shell' and not scSchMode then
		if checkRange(sender, true) then
			if not buffactive['Accession'] and count_stratagems_ready() >= 2 and queue_light_arts() then
				add_to_back(gearswap.res.spells[52], sender, {with_stratagem='Accession'})
				result = true
			else
				add_to_back(gearswap.res.spells[52], sender, {partyCheck=true})
				result = true
			end
		end
	elseif message:sub(-5) == 'storm' and schjpdata >= 100 then
		if checkRange(sender, true) then
			if fourSlice == 'sand' or fiveSlice == 'earth' or sixSlice == 'darude' then
				if not scSchMode and buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
					add_to_back(gearswap.res.spells[857], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
				    add_to_back(gearswap.res.spells[857], sender, {partyCheck=true})
                end
				result = true
			elseif fourSlice == 'wind' or fourSlice == 'aero' then
				if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
                    add_to_back(gearswap.res.spells[859], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
                    add_to_back(gearswap.res.spells[859], sender, {partyCheck=true})
				end
				result = true
			elseif fourSlice == 'rain' or fiveSlice == 'water' then
				if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
					add_to_back(gearswap.res.spells[858], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
                    add_to_back(gearswap.res.spells[858], sender, {partyCheck=true})
				end
				result = true
			elseif fourSlice == 'fire' then
				if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
					add_to_back(gearswap.res.spells[860], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
                    add_to_back(gearswap.res.spells[860], sender, {partyCheck=true})
				end
				result = true
			elseif fourSlice == 'hail' or  fourSlice == 'ice' or fiveSlice == 'blizz' then
				if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
					add_to_back(gearswap.res.spells[861], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
                    add_to_back(gearswap.res.spells[861], sender, {partyCheck=true})
				end
				result = true
			elseif fourSlice == 'thun' then
				if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
					add_to_back(gearswap.res.spells[862], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
                    add_to_back(gearswap.res.spells[862], sender, {partyCheck=true})
				end
				result = true
			elseif fourSlice == 'dark' or fourSlice == 'void' then
				if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
					add_to_back(gearswap.res.spells[863], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
                    add_to_back(gearswap.res.spells[863], sender, {partyCheck=true})
				end
				result = true
			elseif fiveSlice == 'light' or sixSlice == 'aurora' then
				if not scSchMode and not buffactive['Perpetuance'] and count_stratagems_ready() >= 2 and queue_light_arts() then
					add_to_back(gearswap.res.spells[864], sender, {partyCheck=true, with_stratagem='Perpetuance'})
                else
                    add_to_back(gearswap.res.spells[864], sender, {partyCheck=true})
				end
				result = true
			end
		end
	elseif player.sub_job == 'WHM' and player.sub_job_level > 0 and not scSchMode then
		if fourSlice == 'para' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[15], sender)
				result = true
			end
		elseif fiveSlice == 'blind' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[16], sender)
				result = true
			end
		elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[18], sender, {partyCheck=true})
				result = true
			end
		elseif fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[19], sender, {partyCheck=true})
				result = true
			end
		elseif fiveSlice == 'silen' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[17], sender)
				result = true
			end
		elseif fiveSlice == 'curse' or fourSlice == 'doom' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[20], sender)
				result = true
			end
		elseif fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' then
			if checkRange(sender, true) then
				add_by_priority(gearswap.res.spells[143], sender, {partyCheck=true})
				result = true
			end
		elseif sixSlice == 'poison' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[14], sender)
				result = true
			end
		elseif fiveSlice == 'haste' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[57], sender)
				result = true
			end
		elseif (fiveSlice == 'raise') and checkRaisable(sender) then
			add_by_priority(gearswap.res.spells[12], sender, {partyCheck=true})
			result = true
		end
	elseif buffactive['Addendum: White'] and not scSchMode then
		if fourSlice == 'para' then
			if checkRange(sender, false) and queue_white_status() then
				add_to_back(gearswap.res.spells[15], sender)
				result = true
			end
		elseif fiveSlice == 'blind' then
			if checkRange(sender, false) and queue_white_status() then
				add_to_back(gearswap.res.spells[16], sender)
				result = true
			end
		elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' then
			if checkRange(sender, false) and queue_white_status() then
				add_to_back(gearswap.res.spells[18], sender, {partyCheck=true})
				result = true
			end
		elseif fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' then
			if checkRange(sender, false) and queue_white_status() then
				add_to_back(gearswap.res.spells[19], sender, {partyCheck=true})
				result = true
			end
		elseif fiveSlice == 'silen' then
			if checkRange(sender, false) then
				add_to_back(gearswap.res.spells[17], sender)
				result = true
			end
		elseif fiveSlice == 'curse' or fourSlice == 'doom' then
			if checkRange(sender, false) and queue_white_status() then
				add_to_back(gearswap.res.spells[20], sender)
				result = true
			end
		elseif fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' then
			if checkRange(sender, true) and queue_white_status() then
				add_to_back(gearswap.res.spells[143], sender, {partyCheck=true})
				result = true
			end
		elseif sixSlice == 'poison' then
			if checkRange(sender, false) and queue_white_status() then
				add_to_back(gearswap.res.spells[14], sender)
				result = true
			end
		elseif (fiveSlice == 'raise') and checkRaisable(sender) then
			if recastData[gearswap.res.spells[140].recast_id] < 500 and queue_white_status() then
				add_to_back(gearswap.res.spells[140], sender, {partyCheck=true})
				result = true
			elseif recastData[gearswap.res.spells[13].recast_id] < 500 and queue_white_status() then
				add_to_back(gearswap.res.spells[13], sender, {partyCheck=true})
				result = true
			elseif recastData[gearswap.res.spells[12].recast_id] < 500 then
				add_to_back(gearswap.res.spells[12], sender, {partyCheck=true})
				result = true
			end
		end
	end

	if result then
		return result
	end

	if player.sub_job == 'RDM' and player.sub_job_level > 0 then
		if fiveSlice == 'haste' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[57], sender)
				result = true
			end
		elseif fiveSlice == 'refre' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[109], sender)
				result = true
			end
		elseif fiveSlice == 'flurry' then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[845], sender)
				result = true
			end
		end
	elseif player.sub_job == 'DNC' and player.sub_job_level > 0 then
		if fourSlice == 'para' or fiveSlice == 'blind' or sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' or fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' or fiveSlice == 'silen' or fiveSlice == 'curse' or fourSlice == 'doom' or fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' or sixSlice == 'poison' then
			if checkRange(sender, false) then
				add_to_back(gearswap.res.job_abilities[194], sender)
				result = true
			end
		elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
			if checkRange(sender, true) then
				add_to_back(gearswap.res.job_abilities[190], sender, {partyCheck=true})
				result = true
			elseif checkRangeAlly(sender, false) then
				add_to_back(gearswap.res.job_abilities[195], sender)
				result = true
			end
		end
	end
	if result and #spellStack == 0 and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
		handleSpareTime()
	end
	return result
end

function process_split_string_brd(message, sender)
	result = false
	fourSlice = message:sub(1,4)
	fiveSlice = message:sub(1,5)

    if message == player.name:lower() then
        return true
    elseif message == 'cast' then
        castSaid = true
        return true
    elseif castSaid then
        if message == 'slow' or message == 'elegy' then
            if party_target ~= false then
                add_to_back(stack_spells['Carnage Elegy'], party_target)
                result = true
            end
        elseif message == 'requiem' then
            if party_target ~= false then
                add_to_back(stack_spells['Foe Requiem VII'], party_target)
                result = true
            end
        elseif message == 'addle' or message == 'nocturne' then
            if party_target ~= false then
                add_to_back(stack_spells['Pining Nocturne'], party_target)
                result = true
            end
        elseif message == 'dispel' or message == 'finale' then
            if party_target ~= false then
                add_to_back(stack_spells['Magic Finale'], party_target)
                result = true
            end
        elseif message == 'lullaby' then
            if party_target ~= false then
                add_to_back(stack_spells['Foe Lullaby II'], party_target)
                result = true
            end
        elseif message == 'hlullaby' or message == 'hordelullaby' then
            if party_target ~= false then
                add_to_back(stack_spells['Horde Lullaby II'], party_target)
                result = true
            end
        elseif message:sub(-8) == 'threnody' and party_target ~= false then
            if message == 'firethrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Fire Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Fire Threnody'], party_target)
                end
                result = true
            elseif message == 'icethrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Ice Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Ice Threnody'], party_target)
                end
                result = true
            elseif message == 'windthrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Wind Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Wind Threnody'], party_target)
                end
                result = true
            elseif message == 'earththrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Earth Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Earth Threnody'], party_target)
                end
                result = true
            elseif message == 'ltngthrenody' or message == 'lightningthrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Ltng. Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Ltng. Threnody'], party_target)
                end
                result = true
            elseif message == 'waterthrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Water Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Water Threnody'], party_target)
                end
                result = true
            elseif message == 'lightthrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Light Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Light Threnody'], party_target)
                end
                result = true
            elseif message == 'darkthrenody' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Dark Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Dark Threnody'], party_target)
                end
                result = true
            end
        elseif message:sub(-5) == 'thren' and party_target ~= false then
            if message == 'firethren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Fire Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Fire Threnody'], party_target)
                end
                result = true
            elseif message == 'icethren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Ice Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Ice Threnody'], party_target)
                end
                result = true
            elseif message == 'windthren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Wind Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Wind Threnody'], party_target)
                end
                result = true
            elseif message == 'earththren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Earth Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Earth Threnody'], party_target)
                end
                result = true
            elseif message == 'ltngthrenody' or message == 'lightningthren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Ltng. Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Ltng. Threnody'], party_target)
                end
                result = true
            elseif message == 'waterthren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Water Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Water Threnody'], party_target)
                end
                result = true
            elseif message == 'lightthren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Light Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Light Threnody'], party_target)
                end
                result = true
            elseif message == 'darkthren' then
                local brdjpdata = windower.ffxi.get_player().job_points.brd.jp_spent
                if brdjpdata >= 100 then
                    add_to_back(stack_spells['Dark Threnody II'], party_target)
                else
                    add_to_back(stack_spells['Dark Threnody'], party_target)
                end
                result = true
            end
        end
	elseif fiveSlice == 'songs' and valid_controllers:contains(sender) then
		if type(resingSongs) == 'table' and resingSongs[sender] ~= nil and checkRange(sender, true) then
			resingSongs[sender].nextSing = 0
		elseif resingSongs[player.name] ~= nil and checkRange(sender, true) then
			resingSongs[player.name].nextSing = 0
		end
	elseif player.sub_job == 'WHM' and player.sub_job_level > 0 then
        process_split_string_whmsub(message,sender)
    elseif player.sub_job == 'RDM' and player.sub_job_level > 0 then
        process_split_string_rdmsub(message,sender)
	elseif player.sub_job == 'DNC' and player.sub_job_level > 0 then
        process_split_string_dncsub(message,sender)
	end

	if result and #spellStack == 0 and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
		handleSpareTime()
	end
	return result
end

function process_split_string_whm(message, sender)
	result = false
	threeSlice = message:sub(1,3)
	fourSlice = message:sub(1,4)
	fiveSlice = message:sub(1,5)
	sixSlice = message:sub(1,6)
	sevenSlice = message:sub(1,7)
	eightSlice = message:sub(1,8)

    if message == player.name:lower() then
        return true
    elseif message == 'cast' then
        castSaid = true
        return true
    elseif castSaid == true then
        if fourSlice == 'slow' then
            if party_target ~= false then
                add_to_back(stack_spells['Slow'], party_target)
                result = true
            end
        elseif fourSlice == 'para' then
            if party_target ~= false then
                add_to_back(stack_spells['Paralyze'], party_target)
                result = true
            end
        elseif threeSlice == 'dia' then
            if party_target ~= false then
                add_to_back(stack_spells['Dia II'], party_target)
                result = true
            end
        elseif sixSlice == 'repose' then
            if party_target ~= false then
                add_to_back(stack_spells['Repose'], party_target)
            end
        elseif sevenSlice == 'silence' then
            if party_target ~= false then
                add_to_back(stack_spells['Silence'], party_target)
            end
        elseif fiveSlice == 'addle' then
            if party_target ~= false then
                add_to_back(stack_spells['Addle'], party_target)
            end
        end
    elseif fourSlice == 'para' then
		if checkRange(sender, false) then
			add_divine_caress()
			add_by_priority(gearswap.res.spells[15], sender)
			result = true
		end
	elseif fourSlice == 'viru' or sevenSlice == 'disease' or sixSlice == 'plague' then
		if checkRange(sender, false) then
			add_divine_caress()
			add_by_priority(gearswap.res.spells[19], sender, {partyCheck=true})
			result = true
		end
	elseif fourSlice == 'slow' or  fourSlice == 'grav' or fiveSlice == 'bound' or sixSlice == 'max hp' or sevenSlice == 'hp down' or sixSlice == 'max mp' or sevenSlice == 'mp down' or threeSlice == 'bio' or threeSlice == 'dia' or fiveSlice == 'erase' then
		if checkRange(sender, true) then
			add_by_priority(gearswap.res.spells[143], sender, {partyCheck=true})
			result = true
		end
	elseif fourSlice == 'devo' and valid_controllers:contains(sender) then
		if windower.ffxi.get_ability_recasts()[stack_job_abilities['Devotion'].recast_id] == 0 and checkRange(sender, true) then
			add_by_priority(stack_job_abilities['Devotion'], sender, {partyCheck=true})
			result = true
		end
	elseif fiveSlice == 'blind' then
		if checkRange(sender, false) then
			add_divine_caress()
			add_by_priority(gearswap.res.spells[16], sender)
			result = true
		end
	elseif fiveSlice == 'silen' then
		if checkRange(sender, false) then
			add_divine_caress()
			add_by_priority(gearswap.res.spells[17], sender)
			result = true
		end
	elseif fiveSlice == 'curse' or fourSlice == 'doom' then
		if checkRange(sender, false) then
			add_divine_caress()
			add_by_priority(gearswap.res.spells[20], sender)
			result = true
		end
	elseif sixSlice == 'poison' then
		if checkRange(sender, false) then
			add_divine_caress()
			add_by_priority(gearswap.res.spells[14], sender)
			result = true
		end
	elseif sixSlice == 'stoned' or fiveSlice == 'stona' or fourSlice == 'petr' then
		if checkRange(sender, false) then
			add_divine_caress()
			add_by_priority(gearswap.res.spells[18], sender, {partyCheck=true})
			result = true
		end
	elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
		if checkRange(sender, true) then
			add_by_priority(gearswap.res.spells[7], sender, {partyCheck=true})
			result = true
		elseif checkRangeAlly(sender, false) then
			add_by_priority(gearswap.res.spells[1], sender)
			result = true
		end
	elseif fiveSlice == 'haste' then
		if checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[57], sender)
			result = true
		end
	elseif fiveSlice == 'flurry' then
		if player.sub_job == 'RDM' and player.sub_job_level > 48 then
			if checkRange(sender, false) then
				add_by_priority(gearswap.res.spells[845], sender)
				result = true
			end
		end
	elseif fourSlice == 'prot' then
		if checkAoERange(sender) then
			add_by_priority(gearswap.res.spells[129], player.name, false)
			result = true
		elseif checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[47], sender)
			result = true
		end
	elseif fiveSlice == 'shell' then
		if checkAoERange(sender) then
			add_by_priority(gearswap.res.spells[134], player.name, false)
			result = true
		elseif checkRange(sender, false) then
			add_by_priority(gearswap.res.spells[52], sender)
			result = true
		end
	elseif fiveSlice == 'sacri' or eightSlive == 'att down' or eightSlive == 'acc down' or sixSlice == 'zombie' then
		if checkRange(sender, true) then
			add_by_priority(gearswap.res.spells[94], sender, {partyCheck=true})
			result = true
		end
	elseif fiveSlice == 'sneak' and checkRange(sender, true) then
		add_by_priority(gearswap.res.spells[137], sender, {partyCheck=true})
		result = true
	elseif fiveSlice == 'invis' and checkRange(sender, true) then
		add_by_priority(gearswap.res.spells[136], sender, {partyCheck=true})
		result = true
	elseif fiveSlice == 'regen' and checkRange(sender, true) then
		add_by_priority(gearswap.res.spells[477], sender, {partyCheck=true})
		result = true
	elseif (fiveSlice == 'raise' or fiveSlice == 'arise') and checkRaisable(sender) then
		if recastData[gearswap.res.spells[494].recast_id] < 500 then
			add_by_priority(gearswap.res.spells[494], sender, {partyCheck=true})
			result = true
		elseif recastData[gearswap.res.spells[140].recast_id] < 500 then
			add_by_priority(gearswap.res.spells[140], sender, {partyCheck=true})
			result = true
		elseif recastData[gearswap.res.spells[13].recast_id] < 500 then
			add_by_priority(gearswap.res.spells[13], sender, {partyCheck=true})
			result = true
		elseif recastData[gearswap.res.spells[12].recast_id] < 500 then
			add_by_priority(gearswap.res.spells[12], sender, {partyCheck=true})
			result = true
		end
	elseif threeSlice == 'bar' then
		if checkAoERange(sender) then
			if fiveSlice == 'barfi' then
				add_to_back(gearswap.res.spells[66], player.name, false)
				result = true
			elseif fiveSlice == 'barwa' then
				add_to_back(gearswap.res.spells[71], player.name, false)
				result = true
			elseif fiveSlice == 'barth' then
				add_to_back(gearswap.res.spells[70], player.name, false)
				result = true
			elseif fiveSlice == 'barst' then
				add_to_back(gearswap.res.spells[69], player.name, false)
				result = true
			elseif fiveSlice == 'barae' or fiveSlice == 'barwi' then
				add_to_back(gearswap.res.spells[68], player.name, false)
				result = true
			elseif sevenSlice == 'barbliz' then
				add_to_back(gearswap.res.spells[67], player.name, false)
				result = true
			elseif fiveSlice == 'barbl' then
				add_to_back(gearswap.res.spells[89], player.name, false)
				result = true
			elseif fiveSlice == 'barsl' then
				add_to_back(gearswap.res.spells[86], player.name, false)
				result = true
			elseif fiveSlice == 'baram' then
				add_to_back(gearswap.res.spells[85], player.name, false)
				result = true
			elseif fiveSlice == 'barpe' then
				add_to_back(gearswap.res.spells[91], player.name, false)
				result = true
			elseif fiveSlice == 'barpo' then
				add_to_back(gearswap.res.spells[87], player.name, false)
				result = true
			elseif fiveSlice == 'barpa' then
				add_to_back(gearswap.res.spells[88], player.name, false)
				result = true
			elseif fiveSlice == 'barsi' then
				add_to_back(gearswap.res.spells[90], player.name, false)
				result = true
			elseif fiveSlice == 'barvi' then
				add_to_back(gearswap.res.spells[10], player.name, false)
				result = true
			end
		end
	elseif fiveSlice == 'auspi' then
		if checkAoERange(sender) then
			add_to_back(gearswap.res.spells[96], player.name, false)
			result = true
		end
	elseif fiveSlice == 'boost' then
		if checkAoERange(sender) then
			if eightSlice == 'booststr' then
				add_to_back(gearswap.res.spells[479], player.name, false)
				result = true
			elseif eightSlice == 'boostdex' then
				add_to_back(gearswap.res.spells[480], player.name, false)
				result = true
			elseif eightSlice == 'boostint' then
				add_to_back(gearswap.res.spells[483], player.name, false)
				result = true
			elseif eightSlice == 'boostagi' then
				add_to_back(gearswap.res.spells[482], player.name, false)
				result = true
			elseif eightSlice == 'boostvit' then
				add_to_back(gearswap.res.spells[481], player.name, false)
				result = true
			elseif eightSlice == 'boostmnd' then
				add_to_back(gearswap.res.spells[484], player.name, false)
				result = true
			elseif eightSlice == 'boostchr' then
				add_to_back(gearswap.res.spells[485], player.name, false)
				result = true
			end
		end
	elseif threeSlice == 'str' and eightSlice ~= 'str down' and sevenSlice ~= 'strange' and checkAoERange(sender) then
		add_to_back(gearswap.res.spells[479], player.name, false)
		result = true
	elseif threeSlice == 'dex' and eightSlice ~= 'dex down' and checkAoERange(sender)  then
		add_to_back(gearswap.res.spells[480], player.name, false)
		result = true
	elseif threeSlice == 'int' and eightSlice ~= 'int down' and checkAoERange(sender)  then
		add_to_back(gearswap.res.spells[483], player.name, false)
		result = true
	elseif threeSlice == 'agi' and eightSlice ~= 'agi down' and checkAoERange(sender)  then
		add_to_back(gearswap.res.spells[482], player.name, false)
		result = true
	elseif threeSlice == 'vit' and eightSlice ~= 'vit down' and checkAoERange(sender)  then
		add_to_back(gearswap.res.spells[481], player.name, false)
		result = true
	elseif threeSlice == 'mnd' and eightSlice ~= 'mnd down' and checkAoERange(sender)  then
		add_to_back(gearswap.res.spells[484], player.name, false)
		result = true
	elseif threeSlice == 'chr' and eightSlice ~= 'chr down' and checkAoERange(sender)  then
		add_to_back(gearswap.res.spells[485], player.name, false)
		result = true
	elseif fourSlice == 'mart' then
		if windower.ffxi.get_ability_recasts()[gearswap.res.job_abilities[153].recast_id] == 0 and checkRange(sender, false) then
			add_by_priority(gearswap.res.job_abilities[153], sender)
			result = true
		end
	elseif player.sub_job == 'RDM' and sevenSlice == 'refresh' then
		if checkRange(sender, true) then
			add_by_priority(gearswap.res.spells[109], sender, {partyCheck=true})
			result = true
		end
	elseif player.sub_job == 'SCH' and message:sub(-5) == 'storm' then
		if checkRange(sender, true) then
			if fourSlice == 'sand' or fiveSlice == 'earth' or sixSlice == 'darude' then
				add_by_priority(gearswap.res.spells[99], sender, {partyCheck=true})
				result = true
			elseif fourSlice == 'wind' or fourSlice == 'aero' then
				add_by_priority(gearswap.res.spells[114], sender, {partyCheck=true})
				result = true
			elseif fourSlice == 'rain' or fiveSlice == 'water' then
				add_by_priority(gearswap.res.spells[113], sender, {partyCheck=true})
				result = true
			elseif fourSlice == 'fire' then
				add_by_priority(gearswap.res.spells[115], sender, {partyCheck=true})
				result = true
			elseif fourSlice == 'hail' or fourSlice == 'ice' or fiveSlice == 'blizz' then
				add_by_priority(gearswap.res.spells[116], sender, {partyCheck=true})
				result = true
			elseif sevenSlice == 'thunder' then
				add_by_priority(gearswap.res.spells[117], sender, {partyCheck=true})
				result = true
			elseif fourSlive == 'dark' or fourSlive == 'void' then
				add_by_priority(gearswap.res.spells[118], sender, {partyCheck=true})
				result = true
			elseif fiveSlive == 'light' or sixSlive == 'aurora' then
				add_by_priority(gearswap.res.spells[119], sender, {partyCheck=true})
				result = true
			end
		end
	elseif message == 'waterbuffs' then
		add_to_back(gearswap.res.spells[129], player.name, false)
		add_to_back(gearswap.res.spells[134], player.name, false)
		add_to_back(gearswap.res.spells[71], player.name, false)
		add_to_back(gearswap.res.spells[87], player.name, false)
		add_to_back(gearswap.res.spells[480], player.name, false)
		add_to_back(gearswap.res.spells[96], player.name, false)
	elseif message == 'firebuffs' then
		add_to_back(gearswap.res.spells[129], player.name, false)
		add_to_back(gearswap.res.spells[134], player.name, false)
		add_to_back(gearswap.res.spells[66], player.name, false)
		add_to_back(gearswap.res.spells[85], player.name, false)
		add_to_back(gearswap.res.spells[480], player.name, false)
		add_to_back(gearswap.res.spells[96], player.name, false)
	elseif message == 'thunderbuffs' then
		add_to_back(gearswap.res.spells[129], player.name, false)
		add_to_back(gearswap.res.spells[134], player.name, false)
		add_to_back(gearswap.res.spells[70], player.name, false)
		add_to_back(gearswap.res.spells[85], player.name, false)
		add_to_back(gearswap.res.spells[480], player.name, false)
		add_to_back(gearswap.res.spells[96], player.name, false)
	elseif message == 'icebuffs' then
		add_to_back(gearswap.res.spells[129], player.name, false)
		add_to_back(gearswap.res.spells[134], player.name, false)
		add_to_back(gearswap.res.spells[67], player.name, false)
		add_to_back(gearswap.res.spells[88], player.name, false)
		add_to_back(gearswap.res.spells[480], player.name, false)
		add_to_back(gearswap.res.spells[96], player.name, false)
	elseif message == 'windbuffs' then
		add_to_back(gearswap.res.spells[129], player.name, false)
		add_to_back(gearswap.res.spells[134], player.name, false)
		add_to_back(gearswap.res.spells[68], player.name, false)
		add_to_back(gearswap.res.spells[90], player.name, false)
		add_to_back(gearswap.res.spells[480], player.name, false)
		add_to_back(gearswap.res.spells[96], player.name, false)
	elseif message == 'stonebuffs' then
		add_to_back(gearswap.res.spells[129], player.name, false)
		add_to_back(gearswap.res.spells[134], player.name, false)
		add_to_back(gearswap.res.spells[69], player.name, false)
		add_to_back(gearswap.res.spells[91], player.name, false)
		add_to_back(gearswap.res.spells[480], player.name, false)
		add_to_back(gearswap.res.spells[96], player.name, false)
	end

	if result and #spellStack == 0 and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
		handleSpareTime()
	end
	return result
end

function process_split_string_pld(message, sender)
	result = false
	fiveSlice = message:sub(1,5)

    if message == player.name:lower() then
        return true
	elseif fiveSlice == 'sleep' or message:sub(1,2) == 'zz' then
		if checkRangeAlly(sender, false) then
			add_by_priority(gearswap.res.spells[1], sender)
			result = true
		end
	elseif fiveSlice == 'raise' and checkRaisable(sender) then
		add_by_priority(gearswap.res.spells[12], sender, {partyCheck=true})
		result = true
	end

	if result and #spellStack == 0 and player.status ~= 'Resting' and check_ready_silent() and player.x == lastx and player.y == lasty then
		handleSpareTime()
	end
	return result
end

windower.raw_register_event("chat message", function(message,sender,mode,gm)
	if mode == 3 or mode == 4 then
		if type(message) == 'string' then
			process_push_string(message, sender)
		end
	end
end)

function direct_push(spellName, spellType, spellTarget, rangeCheck)
	if (rangeCheck and checkRange(spellTarget, false)) or not rangeCheck then
		add_to_back(spellName, spellTarget)
		--showArrayContents()
	end
end

function direct_push_front(spellName, spellType, spellTarget, rangeCheck)
	if (rangeCheck and checkRange(spellTarget, false)) or not rangeCheck then
		add_to_front(spellName, spellTarget)
		--windower.add_to_chat(028,'adding '..spellName..' '..spellTarget)
		--showArrayContents()
	end
end

--Function to reset all resing song recast times. Used in BRD file for when JA are used. That way if JA are used, all players are given the new JA songs
function reset_songs()
	--Reset Aoe Songs first, then do single target songs after
	for i,v in pairs(resingSongs) do
		if type(v) == 'table' and v.target == player.name then
			resingSongs[i].nextSing = os.clock()
			resingSongs[i].fails = 0
		end
	end

	--Only add piano songs now
	local singOffset = 15
	for i,v in pairs(resingSongs) do
		if type(v) == 'table' and v.target ~= player.name then
			resingSongs[i].nextSing = os.clock() + singOffset
			resingSongs[i].fails = 0
			singOffset = singOffset + 15
		end
	end
end

--Function to add any songs that require singing from the song resing queue
function check_songs()
	for i,v in pairs(resingSongs) do
		if type(v) == 'table' and v.nextSing <= os.clock() then
			--time to sing the resing
            if i == 'self' then
                if v.songs ~= nil and #v.songs > 1 then
                    send_command('gs c sing '..v.songs)
                    windower.add_to_chat(027,'Adding songs to queue: ['..v.songs..'] on '..i)
                end
			elseif checkRange(i, true) then
				if v.songs ~= nil and #v.songs > 1 then
					send_command('gs c sing '..v.songs)
					windower.add_to_chat(027,'Adding songs to queue: ['..v.songs..'] on '..i)
				end
			else
				resingSongs[i].nextSing = os.clock()+5
				resingSongs[i].fails = resingSongs[i].fails + 1
				if resingSongs[i].fails > 10 then
					remove_song_from_queue(i)
				elseif resingSongs[i].fails > 3 then
					resingSongs[i].nextSing = os.clock()+60
				end
			end
		end
	end
end

--function to remove a single song from the resing song queue. This happens if the brd has tried to sing a song on a player 4 times over 3 minutes and failed each time.
function remove_song_from_queue(songToRemove)
	if type(resingSongs) == 'table' then
		local tempResingSongs = T{}
		j = 1
		for i=1, #resingSongs, 1 do
			if type(resingSongs[i]) == 'table' and i ~= songToRemove then
				tempResingSongs[j] = {
									nextSing = resingSongs[i].nextSing,
									fails= resingSongs[i].fails,
									songs= resingSongs[i].songs,
									target= resingSongs[i].target
									}
				j = j +1
			end
		end
		table.clear(resingSongs)
		table.reassign(resingSongs, tempResingSongs)
	end
end

function remove_song_by_target(targetToRemove)
	if type(resingSongs) == 'table' then
		local tempResingSongs = T{}
		j = 1
		for i=1, #resingSongs, 1 do
			if type(resingSongs[i]) == 'table' then
				if resingSongs[i].target ~= targetToRemove then
					tempResingSongs[j] = {
										nextSing = resingSongs[i].nextSing,
										fails= resingSongs[i].fails,
										songs= resingSongs[i].songs,
										target= resingSongs[i].target
										}
					j = j +1
				else
					windower.add_to_chat(050, 'Removing ['..string.color("<"..resingSongs[i].target..">",5,158)..'] from resing queue')
				end
			end
		end
		table.clear(resingSongs)
		table.reassign(resingSongs, tempResingSongs)
	end
end

function reset_song_timers()
	table.clear(resingSongs)
end

function check_auto_spell()
	for i,v in pairs(autoSpells) do
		if type(v) == 'table' then
			if v['nextCast'] < os.clock() and checkRange(v['target'], v['partyOnly']) and is_spell_ready(v['spell'].en) then
				add_to_back(v['spell'],v['target'],{partyCheck=v['partyOnly']})
			end
		end
	end
end

function auto_spell_toggle(playerName, spellName)
	--Check spell is available first
	spellToAdd = false
	if mainSpells[player.main_job] then
		for i,v in pairs(mainSpells[player.main_job]) do
			if type(v) == 'table' and v.name:lower() == spellName:lower() then
				spellToAdd = v
			end
		end
	end

	if spellToAdd == false and subSpells[player.sub_job] then
		for i,v in pairs(subSpells[player.sub_job]) do
			if type(v) == 'table' and v.name:lower() == spellName:lower() then
				spellToAdd = v
			end
		end
	end

	--If spellToAdd was set
	if type(spellToAdd) == 'table' then
		--Any target, make sure name exists and autocomplete it
		partyOnly = false
		if spellToAdd.target == 'self' then
			if playerName:lower() == player.name:lower() then
				playerName = player.name
			else
				playerName = ''
			end
		elseif spellToAdd.target == 'any' then
			playerName = checkName(playerName)
		elseif spellToAdd.target == 'party' then
			playerName = checkPartyName(playerName)
			partyOnly = true
		end

		if playerName ~= '' then
			local pFound = false

			local tempAutoSpells = T{}

			for i,v in pairs(autoSpells) do
				if type(v) == 'table' then
					if v['spell'].en == spellToAdd.name and v['target'] == playerName then
						pFound = true
					else
						tempAutoSpells[i] = T{
                            spell=autoSpells[i]['spell'],
                            target=autoSpells[i]['target'],
                            nextCast=autoSpells[i]['nextCast'],
                            recast=autoSpells[i]['recast'],
                            partyOnly=autoSpells[i]['partyOnly']
                        }
					end
				end
			end
			if pFound == false and stack_spells[spellToAdd['name']] then
				tempAutoSpells:insert({
                        spell=stack_spells[spellToAdd['name']],
                        target=playerName,
                        nextCast=0,
                        recast=spellToAdd['recast'],
                        partyOnly=partyOnly
                    })
				windower.add_to_chat(050,"Added "..spellToAdd.name.." on "..playerName)
			else
				windower.add_to_chat(050,"Removed "..spellToAdd.name.." on "..playerName)
			end
			autoSpells:clear()
			table.reassign(autoSpells, tempAutoSpells)
		end
	end
end

function check_spell_completion(target,spellName)
	for i,v in pairs(autoSpells) do
		if type(v) == 'table' then
			if v['spell'].en:lower() == spellName:lower() and v['target']:lower() == target:lower() then
				autoSpells[i]['nextCast'] = os.clock() + v['recast']
			end
		end
	end
end

function clear_cures()
	if type(spellStack) == 'table' then
		local tempSpellStack = T{}
		j = 1
		for i=1, #spellStack, 1 do
			if type(spellStack[i]) == 'table' then
				if spellStack[i].spell.id <= 11 and spellStack[i].spell.id ~= 7 then
					--Dont preserve cures in stack, we're removing them
				else
                    tempSpellStack[j] = {}
                    table.reassign(tempSpellStack[j], spellStack[i])
					j = j +1
				end
			end
		end
		table.clear(spellStack)
		table.reassign(spellStack, tempSpellStack)
	end
end

function clear_spell_stack()
	if #spellStack>= 1 then
		table.clear(spellStack)
	end
    showArrayContents()
end

function spell_stack_replace(baseSong, baseTarget, replaceSong)
	if type(spellStack) == 'table' then
		--outputString = ''
		local dLength = spellStack:length()
		local tempSpellStack = T{}
		for i=1, dLength, 1 do
			if type(spellStack[i]) == 'table' then
				if spellStack[i].spell.en == baseSong and spellStack[i]['target'] == baseTarget then
					spellStack[i].spell = replaceSong
					windower.add_to_chat(028,"Replacing "..spellStack[i].spell.en.." with "..tempSpellStack[j]['spell'])
				end
			end
		end
	end
end

function check_for_target(passed_command)
	targetFound = true
	if passed_command == 'honor' or passed_command == 'hmarch' or passed_command == 'march' or passed_command == 'march1' or passed_command == 'amarch' or passed_command == 'march2' or passed_command == 'vmarch' then
		targetFound = false
	elseif (passed_command == 'prelude' and songs:contains("Hunter's Prelude")) or passed_command == 'prelude1' or passed_command == 'hprelude' then
		targetFound = false
	elseif passed_command == 'prelude' or passed_command == 'prelude2' or passed_command == 'aprelude' then
		targetFound = false
	elseif (passed_command == 'mambo' and songs:contains("Dragonfoe Mambo")) or passed_command == 'mambo1' or passed_command == 'lmambo' then
		targetFound = false
	elseif passed_command == 'mambo' or passed_command == 'mambo2' or passed_command == 'hmambo' then
		targetFound = false
	elseif (passed_command == 'lcarol' and songs:contains("Light Carol II")) or passed_command == 'lcarol1' then
		targetFound = false
	elseif passed_command == 'lcarol' or passed_command == 'lcarol2' then
		targetFound = false
	elseif (passed_command == 'dcarol' and songs:contains("Dark Carol II")) or passed_command == 'dcarol1' then
		targetFound = false
	elseif passed_command == 'dcarol' or passed_command == 'dcarol2' then
		targetFound = false
	elseif (passed_command == 'fcarol' and songs:contains("Fire Carol II")) or passed_command == 'fcarol1' then
		targetFound = false
	elseif passed_command == 'fcarol' or passed_command == 'fcarol2' then
		targetFound = false
	elseif (passed_command == 'ecarol' and songs:contains("Earth Carol II")) or passed_command == 'ecarol1' then
		targetFound = false
	elseif passed_command == 'ecarol' or passed_command == 'ecarol2' then
		targetFound = false
	elseif (passed_command == 'wcarol' and songs:contains("Water Carol II")) or passed_command == 'wcarol1' then
		targetFound = false
	elseif passed_command == 'wcarol' or passed_command == 'wcarol2' then
		targetFound = false
	elseif (passed_command == 'acarol' and songs:contains("Wind Carol II")) or passed_command == 'acarol1' then
		targetFound = false
	elseif passed_command == 'acarol' or passed_command == 'acarol2' then
		targetFound = false
	elseif (passed_command == 'bcarol' and songs:contains("Ice Carol II")) or passed_command == 'bcarol1' then
		targetFound = false
	elseif passed_command == 'bcarol' or passed_command == 'bcarol2' then
		targetFound = false
	elseif (passed_command == 'tcarol' and songs:contains("Lightning Carol II")) or passed_command == 'tcarol1' then
		targetFound = false
	elseif passed_command == 'tcarol' or passed_command == 'tcarol2' then
		targetFound = false
	elseif passed_command == 'madrigal' or passed_command == 'mad' or passed_command == 'mad1' or passed_command == 'smad' or passed_command == 'mad2' or passed_command == 'bmad' then
		targetFound = false
	elseif passed_command == 'scherzo' then
		targetFound = false
	elseif passed_command == 'minuet' or passed_command == 'min' or passed_command == 'min1' or passed_command == 'minuet1' or passed_command == 'min2' or passed_command == 'minuet2' or passed_command == 'min3' or passed_command == 'minuet3' or passed_command == 'min4' or passed_command == 'minuet4' or passed_command == 'min5' or passed_command == 'minuet5' then
		targetFound = false
	elseif passed_command == 'ballad' or passed_command == 'bal' or passed_command == 'bal1' or passed_command == 'ballad1' or passed_command == 'bal2' or passed_command == 'ballad2' or passed_command == 'bal3' or passed_command == 'ballad3' then
		targetFound = false
	elseif passed_command == 'minne' or passed_command == 'minne1' or passed_command == 'minne2' or passed_command == 'minne3' or passed_command == 'minne4' or passed_command == 'minne5' then
		targetFound = false
	elseif passed_command == 'paeon' or passed_command == 'paeon1' or passed_command == 'paeon2' or passed_command == 'paeon3' or passed_command == 'paeon4' or passed_command == 'paeon5' or passed_command == 'paeon6' then
		targetFound = false
	elseif passed_command == 'hymnus' or passed_command == 'mazurka' or passed_command == 'str' or passed_command == 'dex' or passed_command == 'vit' or passed_command == 'agi' or passed_command == 'int' or passed_command == 'mnd' or passed_command == 'chr' then
		targetFound = false
	end

	return targetFound
end

function get_song_from_command(passed_command, song_target)
    local args = {}
    if song_target ~= player.name then
        args = {partyCheck=true, pianissimo=true, fixed_order=true}
    else
        args = {partyCheck=true, fixed_order=true}
    end

	if (passed_command == 'march' and songs:contains("Victory March") and (not has_marsyas or (has_marsyas and songs:contains("Honor March")))) or passed_command == 'march1' or passed_command == 'amarch' then
		add_to_back(get_spell_from_name('Advancing March'), song_target, args)
		songs:append("Advancing March")
    elseif (passed_command == 'march' and (not has_marsyas or (has_marsyas and songs:contains("Honor March")))) or passed_command == 'march2' or passed_command == 'vmarch' then
        add_to_back(get_spell_from_name('Victory March'), song_target, args)
        songs:append("Victory March")
	elseif has_marsyas and (passed_command == 'march' or passed_command == 'honor' or passed_command == 'march3' or passed_command == 'hmarch') then
		add_to_back(get_spell_from_name("Honor March"), song_target, args)
		songs:append('Honor March')
	elseif (passed_command == 'prelude' and songs:contains("Hunter's Prelude")) or passed_command == 'prelude1' or passed_command == 'hprelude' then
		add_to_back(get_spell_from_name("Archer's Prelude"), song_target, args)
		songs:append("Archer's Prelude")
	elseif passed_command == 'prelude' or passed_command == 'prelude2' or passed_command == 'aprelude' then
		add_to_back(get_spell_from_name("Hunter's Prelude"), song_target, args)
		songs:append("Hunter's Prelude")
	elseif (passed_command == 'mambo' and songs:contains("Dragonfoe Mambo")) or passed_command == 'mambo1' or passed_command == 'lmambo' then
		add_to_back(get_spell_from_name("Sheepfoe Mambo"), song_target, args)
		songs:append("Sheepfoe Mambo")
	elseif passed_command == 'mambo' or passed_command == 'mambo2' or passed_command == 'hmambo' then
		add_to_back(get_spell_from_name("Dragonfoe Mambo"), song_target, args)
		songs:append("Dragonfoe Mambo")
	elseif (passed_command == 'lcarol' and songs:contains("Light Carol II")) or passed_command == 'lcarol1' then
		add_to_back(get_spell_from_name("Light Carol"), song_target, args)
		songs:append("Light Carol")
	elseif passed_command == 'lcarol' or passed_command == 'lcarol2' then
		add_to_back(get_spell_from_name("Light Carol II"), song_target, args)
		songs:append("Light Carol II")
	elseif (passed_command == 'dcarol' and songs:contains("Dark Carol II")) or passed_command == 'dcarol1' then
		add_to_back(get_spell_from_name("Dark Carol"), song_target, args)
		songs:append("Dark Carol")
	elseif passed_command == 'dcarol' or passed_command == 'dcarol2' then
		add_to_back(get_spell_from_name("Dark Carol II"), song_target, args)
		songs:append("Dark Carol II")
	elseif (passed_command == 'fcarol' and songs:contains("Fire Carol II")) or passed_command == 'fcarol1' then
		add_to_back(get_spell_from_name("Fire Carol"), song_target, args)
		songs:append("Fire Carol")
	elseif passed_command == 'fcarol' or passed_command == 'fcarol2' then
		add_to_back(get_spell_from_name("Fire Carol II"), song_target, args)
		songs:append("Fire Carol II")
	elseif (passed_command == 'ecarol' and songs:contains("Earth Carol II")) or passed_command == 'ecarol1' then
		add_to_back(get_spell_from_name("Earth Carol"), song_target, args)
		songs:append("Earth Carol")
	elseif passed_command == 'ecarol' or passed_command == 'ecarol2' then
		add_to_back(get_spell_from_name("Earth Carol II"), song_target, args)
		songs:append("Earth Carol II")
	elseif (passed_command == 'wcarol' and songs:contains("Water Carol II")) or passed_command == 'wcarol1' then
		add_to_back(get_spell_from_name("Water Carol"), song_target, args)
		songs:append("Water Carol")
	elseif passed_command == 'wcarol' or passed_command == 'wcarol2' then
		add_to_back(get_spell_from_name("Water Carol II"), song_target, args)
		songs:append("Water Carol II")
	elseif (passed_command == 'acarol' and songs:contains("Wind Carol II")) or passed_command == 'acarol1' then
		add_to_back(get_spell_from_name("Wind Carol"), song_target, args)
		songs:append("Wind Carol")
	elseif passed_command == 'acarol' or passed_command == 'acarol2' then
		add_to_back(get_spell_from_name("Wind Carol II"), song_target, args)
		songs:append("Wind Carol II")
	elseif (passed_command == 'bcarol' and songs:contains("Ice Carol II")) or passed_command == 'bcarol1' then
		add_to_back(get_spell_from_name("Ice Carol"), song_target, args)
		songs:append("Ice Carol")
	elseif passed_command == 'bcarol' or passed_command == 'bcarol2' then
		add_to_back(get_spell_from_name("Ice Carol II"), song_target, args)
		songs:append("Ice Carol II")
	elseif (passed_command == 'tcarol' and songs:contains("Lightning Carol II")) or passed_command == 'tcarol1' then
		add_to_back(get_spell_from_name("Lightning Carol"), song_target, args)
		songs:append("Lightning Carol")
	elseif passed_command == 'tcarol' or passed_command == 'tcarol2' then
		add_to_back(get_spell_from_name("Lightning Carol II"), song_target, args)
		songs:append("Lightning Carol II")
	elseif ((passed_command == 'madrigal' or passed_command == 'mad') and songs:contains("Blade Madrigal")) or passed_command == 'mad1' or passed_command == 'smad' then
		add_to_back(get_spell_from_name("Sword Madrigal"), song_target, args)
		songs:append("Sword Madrigal")
	elseif passed_command == 'madrigal' or passed_command == 'mad' or passed_command == 'mad2' or passed_command == 'bmad' then
		add_to_back(get_spell_from_name("Blade Madrigal"), song_target, args)
		songs:append("Blade Madrigal")
	elseif passed_command == 'scherzo' then
		add_to_back(get_spell_from_name("Sentinel's Scherzo"), song_target, args)
		songs:append("Sentinel's Scherzo")
	elseif ((passed_command == 'minuet' or passed_command == 'min') and songs:contains("Valor Minuet V") and songs:contains("Valor Minuet IV") and songs:contains("Valor Minuet III") and songs:contains("Valor Minuet II")) or passed_command == 'min1' or passed_command == 'minuet1' then
		add_to_back(get_spell_from_name("Valor Minuet"), song_target, args)
		songs:append("Valor Minuet")
	elseif ((passed_command == 'minuet' or passed_command == 'min') and songs:contains("Valor Minuet V") and songs:contains("Valor Minuet IV") and songs:contains("Valor Minuet III")) or passed_command == 'min2' or passed_command == 'minuet2' then
		add_to_back(get_spell_from_name("Valor Minuet II"), song_target, args)
		songs:append("Valor Minuet II")
	elseif ((passed_command == 'minuet' or passed_command == 'min') and songs:contains("Valor Minuet V") and songs:contains("Valor Minuet IV")) or passed_command == 'min3' or passed_command == 'minuet3' then
		add_to_back(get_spell_from_name("Valor Minuet III"), song_target, args)
		songs:append("Valor Minuet III")
	elseif ((passed_command == 'minuet' or passed_command == 'min') and songs:contains("Valor Minuet V")) or passed_command == 'min4' or passed_command == 'minuet4' then
		add_to_back(get_spell_from_name("Valor Minuet IV"), song_target, args)
		songs:append("Valor Minuet IV")
	elseif passed_command == 'minuet' or passed_command == 'min' or passed_command == 'min5' or passed_command == 'minuet5' then
		add_to_back(get_spell_from_name("Valor Minuet V"), song_target, args)
		songs:append("Valor Minuet V")
	elseif ((passed_command == 'ballad' or passed_command == 'bal') and songs:contains("Mage's Ballad III") and songs:contains("Mage's Ballad II")) or passed_command == 'bal1' or passed_command == 'ballad1' then
		add_to_back(get_spell_from_name("Mage's Ballad"), song_target, args)
		songs:append("Mage's Ballad")
	elseif ((passed_command == 'ballad' or passed_command == 'bal') and songs:contains("Mage's Ballad III")) or passed_command == 'bal2' or passed_command == 'ballad2' then
		add_to_back(get_spell_from_name("Mage's Ballad II"), song_target, args)
		songs:append("Mage's Ballad II")
	elseif passed_command == 'ballad' or passed_command == 'bal' or passed_command == 'bal3' or passed_command == 'ballad3' then
		add_to_back(get_spell_from_name("Mage's Ballad III"), song_target, args)
		songs:append("Mage's Ballad III")
	elseif (passed_command == 'minne' and songs:contains("Knight's Minne V") and songs:contains("Knight's Minne IV") and songs:contains("Knight's Minne III") and songs:contains("Knight's Minne II")) or passed_command == 'minne1' then
		add_to_back(get_spell_from_name("Knight's Minne"), song_target, args)
		songs:append("Knight's Minne")
	elseif (passed_command == 'minne' and songs:contains("Knight's Minne V") and songs:contains("Knight's Minne IV") and songs:contains("Knight's Minne III")) or passed_command == 'minne2' then
		add_to_back(get_spell_from_name("Knight's Minne II"), song_target, args)
		songs:append("Knight's Minne II")
	elseif (passed_command == 'minne' and songs:contains("Knight's Minne V") and songs:contains("Knight's Minne IV")) or passed_command == 'minne3'  then
		add_to_back(get_spell_from_name("Knight's Minne III"), song_target, args)
		songs:append("Knight's Minne III")
	elseif (passed_command == 'minne' and songs:contains("Knight's Minne V")) or passed_command == 'minne4' then
		add_to_back(get_spell_from_name("Knight's Minne IV"), song_target, args)
		songs:append("Knight's Minne IV")
	elseif passed_command == 'minne' or passed_command == 'minne5' then
		add_to_back(get_spell_from_name("Knight's Minne V"), song_target, args)
		songs:append("Knight's Minne V")
	elseif (passed_command == 'paeon' and songs:contains("Army's Paeon VI") and songs:contains("Army's Paeon V") and songs:contains("Army's Paeon IV") and songs:contains("Army's Paeon III") and songs:contains("Army's Paeon II")) or passed_command == 'paeon1' then
		add_to_back(get_spell_from_name("Army's Paeon"), song_target, args)
		songs:append("Army's Paeon")
	elseif (passed_command == 'paeon' and songs:contains("Army's Paeon VI") and songs:contains("Army's Paeon V") and songs:contains("Army's Paeon IV") and songs:contains("Army's Paeon III")) or passed_command == 'paeon2' then
		add_to_back(get_spell_from_name("Army's Paeon II"), song_target, args)
		songs:append("Army's Paeon II")
	elseif (passed_command == 'paeon' and songs:contains("Army's Paeon VI") and songs:contains("Army's Paeon V") and songs:contains("Army's Paeon IV")) or passed_command == 'paeon3'  then
		add_to_back(get_spell_from_name("Army's Paeon III"), song_target, args)
		songs:append("Army's Paeon III")
	elseif (passed_command == 'paeon' and songs:contains("Army's Paeon VI") and songs:contains("Army's Paeon V")) or passed_command == 'paeon4' then
		add_to_back(get_spell_from_name("Army's Paeon IV"), song_target, args)
		songs:append("Army's Paeon IV")
	elseif (passed_command == 'paeon' and songs:contains("Army's Paeon VI")) or passed_command == 'paeon4' then
		add_to_back(get_spell_from_name("Army's Paeon V"), song_target, args)
		songs:append("Army's Paeon V")
	elseif passed_command == 'paeon' or passed_command == 'paeon5' or passed_command == 'paeon6' then
		add_to_back(get_spell_from_name("Army's Paeon VI"), song_target, args)
		songs:append("Army's Paeon VI")
	elseif passed_command == 'hymnus' then
		add_to_back(get_spell_from_name("Goddess's Hymnus"), song_target, args)
		songs:append("Goddess's Hymnus")
	elseif passed_command == 'mazurka' then
		add_to_back(get_spell_from_name('Chocobo Mazurka'), song_target, args)
		songs:append("Chocobo Mazurka")
	elseif passed_command == 'str' then
		add_to_back(get_spell_from_name('Herculean Etude'), song_target, args)
		songs:append("Herculean Etude")
	elseif passed_command == 'dex' then
		add_to_back(get_spell_from_name('Uncanny Etude'), song_target, args)
		songs:append("Uncanny Etude")
	elseif passed_command == 'vit' then
		add_to_back(get_spell_from_name('Vital Etude'), song_target, args)
		songs:append("Vital Etude")
	elseif passed_command == 'agi' then
		add_to_back(get_spell_from_name('Swift Etude'), song_target, args)
		songs:append("Swift Etude")
	elseif passed_command == 'int' then
		add_to_back(get_spell_from_name('Sage Etude'), song_target, args)
		songs:append("Sage Etude")
	elseif passed_command == 'mnd' then
		add_to_back(get_spell_from_name('Logical Etude'), song_target, args)
		songs:append("Logical Etude")
	elseif passed_command == 'chr' then
		add_to_back(get_spell_from_name('Bewitching Etude'), song_target, args)
		songs:append("Bewitching Etude")
	end
end

function checkName(nameToCheck)
	local targetFound = ''
	local nameTest = ''
	-- If the target is whitelisted, pass it through.
	if string.len(nameToCheck) > 0 then
		nameToCheck = nameToCheck:lower()
		-- Check party member list for target first
		for i,v in pairs(partyData) do
			if type(v) == 'table'and v.name ~= nil then
				if string.sub(v.name:lower(),1,string.len(nameToCheck)) == nameToCheck then
					targetFound = v.name
				end
			end
		end
		-- If not found yet, scan mob array next
		if targetFound == '' then
			for i,v in pairs(windower.ffxi.get_mob_array()) do
				if v.name ~= nil then
					nameTest = v.name:lower()
					if nameTest ~= '' then
						nameTest = string.sub(nameTest,1,string.len(nameToCheck))
						--windower.add_to_chat(28, v.name:lower()..' returned '..nameTest)
						if nameTest == nameToCheck and (v.valid_target or v.id == player.id) then
							targetFound = v.name
						end
					end
				end
			end
		end
	end

	return targetFound
end

function checkPartyName(nameToCheck)
	local targetFound = false
	local nameTest = ''
	-- If the target is whitelisted, pass it through.
	if string.len(nameToCheck) > 0 then
		nameToCheck = nameToCheck:lower()
		-- Check party member list for target first
		for i,v in pairs(partyData) do
			if type(v) == 'table' and v.name ~= nil then
				if string.sub(v.name:lower(),1,string.len(nameToCheck)) == nameToCheck then
					targetFound = v.name
				end
			end
		end
	end

	return targetFound
end

function checkAftercast(spell)
	if spell.action_type ~= 'Interruption' and player.status ~= 'Resting' then
        if spell.value ~= nil and spell.type == 'CorsairRoll' then
            lastValue = tonumber(spell.value)
        end
        if #spellStack > 0 then
    		check_spell_completion(spell.target.name,spell.english)
            for i=1, #spellStack, 1 do
                if spell.english == spellStack[i].spell.en and
                    (
                        tostring(spell.target.id) == tostring(spellStack[i]['target']) or
                        spellStack[i]['target'] == 't' or
                        spellStack[i]['target'] == 'bt' or
                        spell.target.name == spellStack[i]['target'] or
                        (spellStack[i]['target'] == 'self' and spell.target.name == player.name) or
                        (spellStack[i]['target'] == player.name and spell.target.name == 'Luopan')
                    ) then
                    rebuildArray(spellStack[i]['spell'], spellStack[i]['target'])
                    if jaTypes:contains(spell.type) then
                        pinger.lastPing = os.clock() + 0.6
                    end
                    showArrayContents()
                    break
                elseif spell.type == 'CorsairRoll' and spellStack[i].spell.en == 'Double-Up' then
                    rebuildArray(spellStack[i]['spell'], spellStack[i]['target'])
                    pinger.lastPing = os.clock() + .6
                    showArrayContents()
                    break
    			end
    		end
        end
	end
end

windower.raw_register_event('prerender',function()
	if pinger.sendPing and os.clock()-pinger.lastPing > 0.5 then
		gearswap.refresh_globals(false)
		partyData = windower.ffxi.get_party()
		recastData = windower.ffxi.get_spell_recasts()
		party_distances()

        if party_target ~= false and not check_target_exists(false, party_target) then
            print('removing target '..tostring(party_target))
            remove_party_target_spells(party_target)
            party_target = false
        end

		handle_ping()

		pinger.lastPing = os.clock()
	end
end)

windower.raw_register_event('Zone change',function (new_id, old_id)
	clear_spell_stack()
	reset_song_timers()
	indiOn = false
	geoOn = false
	currentMaxSongs = totalSongs
	pinger.lastPing = os.clock() + 15
    rolling_1 = false
    rolling_2 = false
    lastValue = 0
	if exclusion_zones:contains(new_id) then
		pinger.sendPing = false
		self_command('town on')
	else
		pinger.sendPing = true
		self_command('town off')
	end
    showArrayContents()
end)

windower.raw_register_event('target change',function (targetID)
	if targetID ~= nil and targetID > 0 then
		self_command('tc')
	end
end)

function changePing(state)
	if state then
		pinger.sendPing = true
		windower.add_to_chat(050,'Pinging [ON]')
	else
		pinger.sendPing = false
		windower.add_to_chat(050,'Pinging [OFF]')
	end
end

function is_spell_ready(spellToCheck)
	if stack_spells[spellToCheck] ~= nil and recastData[stack_spells[spellToCheck].recast_id] < 60 and player.mp >= stack_spells[spellToCheck].mp_cost then
		return true
	end

	return false
end

function is_ability_ready(spellToCheck)
	if stack_job_abilities[spellToCheck] ~= nil and windower.ffxi.get_ability_recasts()[stack_job_abilities[spellToCheck].recast_id] == 0 then
		return true
	end

	return false
end

function count_stratagems_ready()
	if autoStrat and stack_job_abilities['Addendum: White'] ~= nil then
		tempRecastTime = windower.ffxi.get_ability_recasts()[stack_job_abilities['Addendum: White'].recast_id]
		if tempRecastTime > maxStratagemTime then
			return 0
		else
			return maxStratagems - math.ceil(tempRecastTime/stratagemRecast)
		end
	end

	return 0
end

function is_stratagem_ready(spellToCheck)
    if stack_job_abilities[spellToCheck] ~= nil and windower.ffxi.get_ability_recasts()[stack_job_abilities[spellToCheck].recast_id] <= maxStratagemTime then
		return true
	end

	return false
end

function stack_command(command)
	command = command:lower()
	if command == 'cures' then
		if doCures then
			windower.add_to_chat(028, 'Party Cures [OFF]')
			doCures = false
		else
			windower.add_to_chat(028, 'Party Cures [ON]')
			doCures = true
		end
		return true
	elseif command == 'ally' then
		if allianceHeal then
			windower.add_to_chat(028, 'Alliance Cures [OFF]')
			allianceHeal = false
		else
			windower.add_to_chat(028, 'Alliance Cures [ON]')
			allianceHeal = true
		end
		return true
	elseif command == 'allystatus' then
		if allyStatusHeals then
			windower.add_to_chat(028, 'Alliance Status Heals [OFF]')
			allyStatusHeals = false
		else
			windower.add_to_chat(028, 'Alliance Status Heals [ON]')
			allyStatusHeals = true
		end
		return true
	elseif command == 'partystatus' then
		if ptStatusHeals then
			windower.add_to_chat(028, 'Party Status Heals [OFF]')
			ptStatusHeals = false
		else
			windower.add_to_chat(028, 'Party Status Heals [ON]')
			ptStatusHeals = true
		end
		return true
	elseif command == 'autoss' then
		if not autoSS then
			autoSS = true
			windower.add_to_chat(028, "Auto SS [ON]")
		else
			autoSS = false
			windower.add_to_chat(028, "Auto SS [OFF]")
		end
		return true
	elseif command == 'autoblink' then
		if not autoBlink then
			autoBlink = true
			windower.add_to_chat(028, "Auto Blink [ON]")
		else
			autoBlink = false
			windower.add_to_chat(028, "Auto Blink [OFF]")
		end
		return true
	elseif command == 'autocaress' then
		if not autoCaress then
			autoCaress = true
			windower.add_to_chat(028, "Auto Divine Caress [ON]")
		else
			autoCaress = false
			windower.add_to_chat(028, "Auto Divine Caress [OFF]")
		end
		return true
	elseif command == 'autosub' or command == 'autosublimation' then
		if not autoSub then
			autoSub = true
			windower.add_to_chat(028, "Auto Sublimation [ON]")
		else
			autoSub = false
			windower.add_to_chat(028, "Auto Sublimation [OFF]")
		end
		return true
	elseif command == 'autophalanx' then
		if not autoPhalanx then
			autoPhalanx = true
			windower.add_to_chat(028, "Auto Phalanx [ON]")
		else
			autoPhalanx = false
			windower.add_to_chat(028, "Auto Phalanx [OFF]")
		end
		return true
	elseif command == 'autoaquaveil' then
		if not autoAquaveil then
			autoAquaveil = true
			windower.add_to_chat(028, "Auto Aquaveil [ON]")
		else
			autoAquaveil = false
			windower.add_to_chat(028, "Auto Aquaveil [OFF]")
		end
		return true
	elseif command == 'autoja' then
		if not autoJA then
			autoJA = true
			windower.add_to_chat(028, "Auto JA [ON]")
		else
			autoJA = false
			windower.add_to_chat(028, "Auto JA [OFF]")
		end
	elseif command == 'auto1hr' then
		if not auto1hr then
			auto1hr = true
			windower.add_to_chat(028, "Auto 1hr [ON]")
		else
			auto1hr = false
			windower.add_to_chat(028, "Auto 1hr [OFF]")
		end
	elseif command == 'autostrat' then
		if not autoStrat then
			autoStrat = true
			windower.add_to_chat(028, "Auto Stratagem [ON]")
		else
			autoStrat = false
			windower.add_to_chat(028, "Auto Stratagem [OFF]")
		end
	elseif command == 'scmode' then
		if not scSchMode then
			scSchMode = true
			windower.add_to_chat(028, "SC SCH Mode [ON]")
		else
			scSchMode = false
			windower.add_to_chat(028, "SC SCH Mode [OFF]")
		end
	elseif command == 'ignoreprot' or command == 'ignoreshell' then
		if not ignoreProtShellWear then
			ignoreProtShellWear = true
			windower.add_to_chat(028, "Recast Protect/Shell on wear [OFF]")
		else
			ignoreProtShellWear = false
			windower.add_to_chat(028, "Recast Protect/Shell on wear [ON]")
		end
	elseif command:sub(1,8) == "autocast" then
		command = command:gsub("autocast ","")
		if command ~= nil then
			local finalCommand={} ; i=1
			for str in command:gmatch( "([^%s]+)") do
				finalCommand[i] = str
				i = i + 1
			end
			command = ''
			for i,v in pairs(finalCommand) do
				if v ~= finalCommand[#finalCommand] then
					command = command..' '..v
				end
			end
			if command ~= '' and #finalCommand > 0 then
--				windower.add_to_chat(050,'Usage //gs c autocast '..command..'['..finalCommand[#finalCommand]..']')
				auto_spell_toggle(finalCommand[#finalCommand],command:sub(2,#command))
			else
				windower.add_to_chat(050,'Usage //gs c autocast [spellname] [target]')
				windower.add_to_chat(050,'e.g. //gs c autocast Haste '..player.name)
			end
		end
		return true
	elseif command:sub(1,5) == "haste" then
		commandSplit = command:gsub("haste ","")
		if commandSplit ~= nil then
			if player.main_job == 'RDM' then
				auto_spell_toggle(commandSplit,'Haste II')
			else
				auto_spell_toggle(commandSplit,'Haste')
			end
		end
		return true
    elseif command:sub(1,7) == "refresh" then
        commandSplit = command:gsub("refresh ","")
        if commandSplit ~= nil then
            if player.main_job == 'RDM' then
                local rdmjpdata = windower.ffxi.get_player().job_points.rdm.jp_spent
                if rdmjpdata >= 1200 then
                    auto_spell_toggle(commandSplit,'Refresh III')
                else
                    auto_spell_toggle(commandSplit,'Refresh II')
                end
            else
                auto_spell_toggle(commandSplit,'Refresh')
            end
        end
        return true
	elseif command:sub(1,10) == 'push_front' then
		command = command:gsub("push_front ", "")
		commandSplit = string.split(command," ")
		spellToPush = ''
		if type(commandSplit) == 'table' then
			for i = 1, #commandSplit do
				if i ~= #commandSplit then
					spellToPush = spellToPush..' '..commandSplit[i]
				end
			end
			if spellToPush:slice(1,1) == ' ' then
				spellToPush = spellToPush:slice(2,#spellToPush)
			end

			--Build target name, t/bt/playername
			target = false
			if commandSplit[#commandSplit] == 't' or commandSplit[#commandSplit] == 'bt' then
				target = commandSplit[#commandSplit]
				rangeCheck = false
			else
				target = checkName(commandSplit[#commandSplit])
				rangeCheck = true
			end

			--If we have a target, parse resources and find a matching spell, then push to back of queue
			if target ~= false then
				for i,v in pairs(gearswap.res.spells) do
					if v['en'] ~= nil and v['en']:lower() == spellToPush then
						direct_push_front(v, 'ma', target, rangeCheck)
						return true
					end
				end

				for i,v in pairs(gearswap.res.job_abilities) do
					if v['en'] ~= nil and v['en']:lower() == spellToPush then
						direct_push_front(v, 'ja', target, rangeCheck)
						return true
					end
				end
			end
		end
	elseif command:sub(1,4) == 'push' then
		command = command:gsub("push ", "")
		commandSplit = string.split(command," ")
		spellToPush = ''
		if type(commandSplit) == 'table' then
			for i = 1, #commandSplit do
				if i ~= #commandSplit then
					spellToPush = spellToPush..' '..commandSplit[i]
				end
			end
			if spellToPush:slice(1,1) == ' ' then
				spellToPush = spellToPush:slice(2,#spellToPush)
			end

			--Build target name, t/bt/playername
			target = false
			if commandSplit[#commandSplit] == 't' or commandSplit[#commandSplit] == 'bt' then
				target = commandSplit[#commandSplit]
				rangeCheck = false
			else
				target = checkName(commandSplit[#commandSplit])
				rangeCheck = true
			end

			--If we have a target, parse resources and find a matching spell, then push to back of queue
			if target ~= false then
				for i,v in pairs(gearswap.res.spells) do
					if v['en'] ~= nil and v['en']:lower() == spellToPush then
						direct_push(v, 'ma', target, rangeCheck)
						return true
					end
				end

				for i,v in pairs(gearswap.res.job_abilities) do
					if v['en'] ~= nil and v['en']:lower() == spellToPush then
						direct_push(v, 'ja', target, rangeCheck)
						return true
					end
				end
			end
		end
	elseif command == 'selferases' or command == 'erases' or command == 'statusfixes' or command == 'selfstatusfixes' then
		if not self_status_fix then
			self_status_fix = true
			windower.add_to_chat(028, "Self Status Fixes [ON]")
		else
			self_status_fix = false
			windower.add_to_chat(028, "Self Status Fixes [OFF]")
		end
		return true
	elseif command:sub(1,12) == 'directstring' then
		command = command:gsub("directstring ", "")
		commandSplit = string.split(command," ")
		spellToPush = ''
		if type(commandSplit) == 'table' then
			for i = 1, #commandSplit do
				if i ~= #commandSplit then
					spellToPush = spellToPush..' '..commandSplit[i]
				end
			end
			if spellToPush:slice(1,1) == ' ' then
				spellToPush = spellToPush:slice(2,#spellToPush)
			end

			--Build target name, t/bt/playername
			target = false
			target = checkName(commandSplit[#commandSplit])

			--If we have a target, parse resources and find a matching spell, then push to back of queue
			if target ~= false then
				process_push_string(spellToPush,target)
			end
		end
	elseif command:sub(1,8) == "priority" then
		command = command:gsub("priority ","")

		commandSplit = string.split(command," ")
		priorityToUse = 1.5

		if type(commandSplit) == 'table' then
			if commandSplit[1] ~= nil then
				priorityToUse = tonumber(commandSplit[1])
			end
			--Build target name, t/bt/playername
			target = false
			target = checkName(commandSplit[#commandSplit])

			--If we have a target, parse resources and find a matching spell, then push to back of queue
			if target ~= false then
				priority_players[target] = priorityToUse
				windower.add_to_chat(050,target..' now set at '..priorityToUse..' (Default 1.0)')
			else
				windower.add_to_chat(050,"Couldn't find player "..commandSplit[#commandSplit])
			end
		else
			windower.add_to_chat(050,"Syntax error, please use //gs c priority {priority_number} {player_to_prioritize}")
			windower.add_to_chat(050,"{priority_number} should range from 0 (never cure) to 10 (Massively prioritize even the tiniest heals on tank). Default is 1.0")
		end
		return true
    elseif command:sub(1,5) == "self " then
        command = command:gsub("self ","")
        if selfFix[command] ~= nil then
            if selfFix[command] then
                selfFix[command] = false
                windower.add_to_chat(050,"Self casting of "..command.." now [OFF]")
            else
                selfFix[command] = true
                windower.add_to_chat(050,"Self casting of "..command.." now [ON]")
            end
        end
        return true
	elseif command:sub(1,3) == "sc " then
		if player.main_job == 'SCH' and count_stratagems_ready() >= 2 and (buffactive['Dark Arts'] or buffactive['Addendum: Black'] or is_ability_ready('Dark Arts')) then
			command = command:gsub("sc ","")
			scStarted = false
			if command == 'fire2' or command == 'fire' or command == 'light2' or command == 'light' or command == 'fusion' or command == 'fusi' or command == 'fus' then
				scStarted = true
				scStep = 1
				scName = 'Fusion (Fire/Light)'
				scSpell1 = 'Fire'
				scSpell2 = 'Thunder'
				scElement = 'Fire'
			elseif command == 'distortion' or command == 'disto' or command == 'dist' or command == 'dis' or command == 'ice2' or command == 'blizzard2' or command == 'water2' then
				scStarted = true
				scStep = 1
				scName = 'Distortion (Blizzard/Water)'
				scSpell1 = 'Luminohelix'
				scSpell2 = 'Stone'
				scElement = 'Ice'
			elseif command == 'wind' or command == 'aero' or command == 'thunder' or command == 'wind2' or command == 'aero2' or command == 'thunder2' or command == 'lightning2' or command == 'fra' or command == 'frag' or command == 'fragmentation' then
				scStarted = true
				scStep = 1
				scName = 'Fragmentation (Thunder/Wind)'
				scSpell1 = 'Blizzard'
				scSpell2 = 'Water'
				scElement = 'Thunder'
			elseif command == 'earth' or command == 'stone' or command == 'earth2' or command == 'stone2' then
				scStarted = true
				scStep = 1
				scName = 'Gravitation (Earth/Dark)'
				scSpell1 = 'Aero'
				scSpell2 = 'Noctohelix'
				scElement = 'Earth'
			elseif command == 'dark' or command == 'dark2' or command == 'gra' or command == 'grav' or command == 'gravitation' then
				scStarted = true
				scStep = 1
				scName = 'Gravitation (Earth/Dark)'
				scSpell1 = 'Aero'
				scSpell2 = 'Noctohelix'
				scElement = 'Dark'
                if not is_spell_ready('Noctohelix') then
                    scStarted = false
                end
			elseif command == 'fire1' or command == 'liquefaction' or command == 'lique' or command == 'liq' then
				scStarted = true
				scStep = 1
				scName = 'Liquefaction (Fire)'
				scSpell1 = 'Stone'
				scSpell2 = 'Fire'
				scElement = 'Fire'
			elseif command == 'stone1' or command == 'earth1' or command == 'scission' or command == 'sciss' or command == 'scis' or command == 'sci' then
				scStarted = true
				scStep = 1
				scName = 'Scission (Earth)'
				scSpell1 = 'Fire'
				scSpell2 = 'Stone'
				scElement = 'Earth'
			elseif command == 'water' or command == 'water1' or command == 'water2' or command == 'reverberation' or command == 'reverb' or command == 'rever' or command == 'rev' then
				scStarted = true
				scStep = 1
				scName = 'Reverberation (Water)'
				scSpell1 = 'Stone'
				scSpell2 = 'Water'
				scElement = 'Water'
			elseif command == 'wind1' or command == 'aero1' or command == 'detonation' or command == 'deton' or command == 'deto' or command == 'det' then
				scStarted = true
				scStep = 1
				scName = 'Detonation (Wind)'
				scSpell1 = 'Thunder'
				scSpell2 = 'Aero'
				scElement = 'Wind'
			elseif command == 'ice' or command == 'ice1' or command == 'ice2' or command == 'blizzard' or command == 'blizzard1' or command == 'blizzard2' or command == 'induration' or command == 'indur' or command == 'indu' or command == 'ind' then
				scStarted = true
				scStep = 1
				scName = 'Induration (Ice)'
				scSpell1 = 'Water'
				scSpell2 = 'Blizzard'
				scElement = 'Ice'
			elseif command == 'thunder1' or command == 'impaction' or command == 'impact' or command == 'impac' or command == 'impa' or command == 'imp' then
				scStarted = true
				scStep = 1
				scName = 'Impaction (Thunder)'
				scSpell1 = 'Blizzard'
				scSpell2 = 'Thunder'
				scElement = 'Thunder'
			elseif command == 'light1' or command == 'transfixion' or command == 'transfix' or command == 'transfi' or command == 'transf' or command == 'trans' or command == 'tran' or command == 'tra' then
				scStarted = true
				scStep = 1
				scName = 'Transfixion (Light)'
				scSpell1 = 'Noctohelix'
				scSpell2 = 'Luminohelix'
				scElement = 'Light'
                if not is_spell_ready('Noctohelix') or not is_spell_ready('Luminohelix') then
                    scStarted = false
                end
			elseif command == 'dark1' or command == 'compression' or command == 'compress' or command == 'compres' or command == 'compre' or command == 'compr' or command == 'comp' or command == 'com' then
				scStarted = true
				scStep = 1
				scName = 'Compression (Dark)'
				scSpell1 = 'Luminohelix'
				scSpell2 = 'Noctohelix'
				scElement = 'Dark'
                if not is_spell_ready('Noctohelix') or not is_spell_ready('Luminohelix') then
                    scStarted = false
                end
			elseif command == 'kaustra' and buffactive['Tabula Rasa'] then
				scStarted = true
				scStep = 1
				scName = 'Gravitation (Earth/Dark)'
				scSpell1 = 'Aero'
				scSpell2 = 'Noctohelix'
				scElement = 'Dark'
                if not is_spell_ready('Noctohelix') then
                    scStarted = false
                end
			end

			if scStarted then
                local temp_target = 't'
                if party_target ~= false then
                    temp_target = party_target
                end

				if autoMB and scElement ~= 'Light' then
					local spellToMBWith = ''

					if command == 'kaustra' and buffactive['Tabula Rasa'] then
						spellToMBWith = 'Kaustra'
					elseif helixOrTier == 'helix' and helixAvailable == 2 and is_spell_ready(mbHelixSpell[scElement]..' II') then
						spellToMBWith = mbHelixSpell[scElement]..' II'
					elseif helixOrTier == 'helix' and scElement ~= 'Dark' and helixAvailable == 1 and is_spell_ready(mbHelixSpell[scElement]) then
						spellToMBWith = mbHelixSpell[scElement]
					elseif buffactive['Addendum: Black'] and is_spell_ready(mbTierSpell[scElement]..' V') then
						spellToMBWith = mbTierSpell[scElement]..' V'
					elseif buffactive['Addendum: Black'] and is_spell_ready(mbTierSpell[scElement]..' IV') then
						spellToMBWith = mbTierSpell[scElement]..' IV'
					elseif is_spell_ready(mbTierSpell[scElement]..' III') then
						spellToMBWith = mbTierSpell[scElement]..' III'
					elseif is_spell_ready(mbTierSpell[scElement]..' II') then
						spellToMBWith = mbTierSpell[scElement]..' II'
					elseif is_spell_ready(mbTierSpell[scElement]) then
						spellToMBWith = mbTierSpell[scElement]
					end
					if spellToMBWith ~= '' then
                        if autoEbu or spellToMBWith == 'Kaustra' then
                            add_to_front(stack_spells[spellToMBWith], temp_target, {with_stratagem='Ebullience'})
                        else
						  add_to_front(stack_spells[spellToMBWith], temp_target)
						end
					end
				end

                add_to_front(stack_spells[scSpell2], temp_target, {with_stratagem='Immanence',skillchain_name=scName,skillchain_step=2})
				add_to_front(stack_spells[scSpell1], temp_target, {with_stratagem='Immanence',skillchain_name=scName,skillchain_step=1})

				if (not buffactive['Dark Arts'] and not buffactive['Addendum: Black']) and is_ability_ready('Dark Arts') then
					add_to_front(gearswap.res.job_abilities[212], player.name)
				end
			end
		end
		return true
	elseif command == 'mbtype' then
		if helixOrTier == 'helix' then
			helixOrTier = 'tier'
			windower.add_to_chat(028, "Auto MB Spell [Helix]")
		else
			helixOrTier = 'helix'
			windower.add_to_chat(028, "Auto MB Spell [Tier Spells]")
		end
		return true
	elseif command == 'automb' then
		if not autoMB then
			autoMB = true
			windower.add_to_chat(028, "Auto MB [ON]")
		else
			autoMB = false
			windower.add_to_chat(028, "Auto MB [OFF]")
		end
		return true
	elseif command == 'autoebu' or command == 'autoeb' or command == 'autoebullience' then
		if not autoEbu then
			autoEbu = true
			windower.add_to_chat(028, "Auto Ebullience [ON]")
		else
			autoEbu = false
			windower.add_to_chat(028, "Auto Ebullience [OFF]")
		end
		return true
	elseif command == 'remove_first' then
		if #spellStack > 0 and spellStack[1] ~= nil and spellStack[1]['spell'] ~= nil and spellStack[1]['target'] ~= nil then
			windower.add_to_chat(028, "Removing - "..spellStack[1]['spell'].." on "..spellStack[1]['target'])
			rebuildArray(spellStack[1]['spell'], spellStack[1]['target'])
		else
			windower.add_to_chat(028, "No spells to remove")
		end
		return true
    elseif command:sub(1,12) == "partytarget " then
        local possible_target = command:gsub("partytarget ","")
        current_party_list = make_party_list(alliance[1])
        if tonumber(possible_target) ~= nil then
            if check_target_exists(false, tonumber(possible_target)) then
                print('target exists, setting')
                party_target = tonumber(possible_target)
                party_target_change()
            end
        else
            print('didnt set target')
            party_target = false
        end
	elseif command == 'help' then
		windower.add_to_chat(028, "cures - Toggles curing on/off.")
		windower.add_to_chat(028, "ally - Toggles ally curing on/off.")
		windower.add_to_chat(028, "partystatus - Toggles party status heals on/off.")
		windower.add_to_chat(028, "allystatus - Toggles ally status heals on/off.")
		windower.add_to_chat(028, "autoss - Toggles automatic stoneskin on/off.")
		windower.add_to_chat(028, "autoblink - Toggles automatic blink on/off.")
		windower.add_to_chat(028, "autophalanx - Toggles automatic phalanx on/off.")
		windower.add_to_chat(028, "autoaquaveil - Toggles automatic aquaveil on/off.")
		windower.add_to_chat(028, "ignoreprot - Toggles automatic recast of protect/shell on wear on/off.")
		if player.main_job == 'BRD' then
			windower.add_to_chat(028, "autoja - Toggles automatic BRD JA on/off.")
			windower.add_to_chat(028, "auto1hr - Toggles automatic BRD 1hr on/off.")
			windower.add_to_chat(028, "sing {song1} {song2} {song3} {song4} {optional target} - Sings a single set of songs.")
			windower.add_to_chat(028, "keep singing {song1} {song2} {song3} {song4} {optional target} - Repeatedly sings songs.")
		end
		if player.main_job == 'SCH' then
			windower.add_to_chat(028, "autostrat - Toggles automatic Stratagem usage on/off")
			windower.add_to_chat(028, "scmode - Toggles SCH SC mode on/off, used to ignore party commands when trying to SC.")
			windower.add_to_chat(028, "sc {element} - Queues an SC, use element with a 1 on the end to use T1 SC i.e. sc fire1.")
			windower.add_to_chat(028, "automb - Toggles automatic MB for SCH SC.")
			windower.add_to_chat(028, "mbtype - Toggles MB type for SCH SC helix/tier.")
			windower.add_to_chat(028, "autoebu - Toggles automatic Ebullience for SCH SC MB.")
			windower.add_to_chat(028, "kaustra - Does a dark SC and MBs with Ebullience Kaustra, if 1hr is up and active.")
		end
		windower.add_to_chat(028, "priorty {priority number} {target} - Adjusts target priority for all actions on target. Default is 1, recommended 2 for tanks.")
		windower.add_to_chat(028, "haste {target} - Adds/removes target from auto haste list.")
		windower.add_to_chat(028, "directstring {string} - Processes {string} as if it was said in pt chat. i.e. directstring para erase haste.")
		windower.add_to_chat(028, "push {spell} {target} - Adds {spell} to back of queue on {target}.")
		windower.add_to_chat(028, "push_front {spell} {target} - Adds {spell} to front of queue on {target}.")
		windower.add_to_chat(028, "autocast {spell} {target} - Repeats certain buff spells on {target}.")
		windower.add_to_chat(028, "clear - Clears all spells curently queued for use.")
		windower.add_to_chat(028, "remove_first - Removes next spell from queue, useful if using skillchain and it didn't detect a spell completing.")
		windower.add_to_chat(028, "ping {start/stop} - Turns spell_stack on/off, can be used to turn on in town")
		return true
	elseif command == 'ping start' then
		changePing(true)
		return true
	elseif command == 'ping stop' then
		changePing(false)
		return true
	elseif command == 'clear' then
		clear_spell_stack()
		return true
	elseif command == 'jpdetect' then
		--Tier of helix available, based on gifts
		--Sort out how many JP spent to determine STP to add
		local schjpdata = windower.ffxi.get_player().job_points.sch.jp_spent

		if schjpdata >= 1200 then
			helixAvailable = 2
		else
			helixAvailable = 1
		end

		--Recas time for stratagems (550 JP gift reduces this to 33s for SCH), 48s for SCH main, 60s for /SCH
		if player.main_job == 'SCH' then
			maxStratagems = 5

			if schjpdata >= 550 then
				stratagemRecast = 33
			else
				stratagemRecast = 48
			end
		else
			stratagemRecast = 60
			maxStratagems = 2
		end

		return true
    elseif command == 'warpga' then
        if player.sub_job ~= 'BLM' and player.main_job ~= 'BLM' then
            return false
        end
        add_to_front(stack_spells['Warp'], player.name, {fixed_order=true})
        local party_list = gearswap.make_user_table()
        for i,v in pairs(party) do
            if type(v) == 'table' and v.name and v.name ~= player.name and v.mob and type(v.mob) == 'table' and v.mob.distance and v.mob.distance ~= 0.089004568755627 and v.mob.distance < 420 then
                add_to_front(stack_spells['Warp II'], v.name, {partyCheck=true, fixed_order=true})
            end
        end

        return true
	else
		return false
	end
end


function make_party_list(party)
    local party_list = gearswap.make_user_table()
    for i,v in pairs(party) do
        if type(v) == 'table' and v.name and v.mob and v.mob.id and v.mob.index then
            local tab = gearswap.make_user_table()
            for j,k in pairs(v.mob) do
                tab[j] = k
            end
            tab.mpp = v.mpp
            tab.mp = v.mp
            tab.zone = v.zone
            tab.tp = v.tp
            party_list[v.name], party_list[v.mob.id], party_list[v.mob.index] = tab, tab, tab
            if tab.pet_index then
                local temppet = gearswap.make_user_table()
                for j,k in pairs(windower.ffxi.get_mob_by_index(tab.pet_index) or {}) do
                    temppet[j] = k
                end
                party_list[temppet.name], party_list[temppet.id], party_list[temppet.index] = temppet, temppet, temppet
            end
        end
    end
    party_list._count = party.count
    return party_list
end

current_party_list = make_party_list(alliance[1])

function check_target_exists(spell, possible_target)
    local local_mobs = false
    if possible_target == 't' then
        local_mobs = windower.ffxi.get_mob_by_target('t')
    else
        local_mobs = windower.ffxi.get_mob_by_id(possible_target)
    end

    if local_mobs ~= nil and type(local_mobs) == 'table' and local_mobs.distance ~= nil then
        if spell ~= false and spell.range ~= nil then
            if spell_distances[spell.range] ~= nil and local_mobs.distance > spell_distances[spell.range] then
                print('Invalid Target - not in casting range '..local_mobs.distance..' > '..spell_distances[spell.range])
                return false
            end
        end
        if local_mobs.distance == 0.089004568755627 then
            print('Invalid Target - not in range '..local_mobs.distance)
            return false
        end
        --if (local_mobs.race ~= 0 and local_mobs.name ~= 'Ingrid') then
        --    print('Invalid Target - Human')
        --    return false
        --end
        if not local_mobs then
            print('Invalid Target - not in memory')
            return false
        end
        if local_mobs.hpp == 0 then
            print('Invalid Target - 0 HP')
            return false
        end
        if not local_mobs.valid_target then
            print('Invalid Target - valid_target is false')
            return false
        end
        if local_mobs.in_party then
            print('Invalid Target - in party')
            return false
        end
        if local_mobs.in_alliance then
            print('Invalid Target - in alliance')
            return false
        end
        if not local_mobs.is_npc then
            print('Invalid Target - not NPC')
            return false
        end
        if local_mobs.charmed then
            print('Invalid Target - is charmed')
            return false
        end

        return true
    end
    return false
end

function do_main_corsair_roll(roll_to_use, lucky_number, halt_at)
    if type(stack_job_abilities[roll_to_use]) ~= 'table' then
        print('do_corsair_roll() was passed an invalid roll name')
        return false
    end

    if not buffactive[roll_to_use] and (not buffactive["Bust"] or buffactive["Bust"] < 2) and is_ability_ready('Phantom Roll') then
        direct_push(stack_job_abilities[roll_to_use], 'ja', player.name, false)
        return false
    elseif buffactive[roll_to_use] and buffactive["Double-Up Chance"] and lastValue == 10 and is_ability_ready('Snake Eye') then
        direct_push(stack_job_abilities["Snake Eye"], 'ja', player.name, false)
        return false
    elseif buffactive[roll_to_use] and buffactive["Double-Up Chance"] and lastValue == 10 and buffactive['Snake Eye'] then
        direct_push(stack_job_abilities["Double-Up"], 'ja', player.name, false)
        return false
    elseif buffactive[roll_to_use] and buffactive["Double-Up Chance"] and is_ability_ready('Double-Up') and (lastValue ~= lucky_number and lastValue < halt_at) then
        direct_push(stack_job_abilities["Double-Up"], 'ja', player.name, false)
        return false
    else
        if lastValue == lucky_number or lastValue >= halt_at then
            lastValue = 0
            return true
        else
            return false
        end
    end
end

function do_corsair_roll(roll_to_use, lucky_number, halt_at)
    if type(stack_job_abilities[roll_to_use]) ~= 'table' then
        print('do_corsair_roll() was passed an invalid roll name')
        return false
    end

    if not buffactive[roll_to_use] and not buffactive["Bust"] and is_ability_ready('Phantom Roll') then
        direct_push(stack_job_abilities[roll_to_use], 'ja', player.name, false)
        return false
    elseif buffactive[roll_to_use] and buffactive["Double-Up Chance"] and lastValue == 10 and is_ability_ready('Snake Eye') then
        direct_push(stack_job_abilities["Snake Eye"], 'ja', player.name, false)
        return false
    elseif buffactive[roll_to_use] and buffactive["Double-Up Chance"] and lastValue == 10 and buffactive['Snake Eye'] then
        direct_push(stack_job_abilities["Double-Up"], 'ja', player.name, false)
        return false
    elseif buffactive[roll_to_use] and buffactive["Double-Up Chance"] and is_ability_ready('Double-Up') and (lastValue ~= lucky_number and lastValue < halt_at) then
        direct_push(stack_job_abilities["Double-Up"], 'ja', player.name, false)
        return false
    else
        if lastValue == lucky_number or lastValue >= halt_at then
            lastValue = 0
            return true
        else
            return false
        end
    end
end

function queue_spell_if_busy(spell)
    local validSpell = true
    --Determine if spell is castable, cancel if not and don't add to spellStack queue

    if spell.target.type == 'SELF' or spell.target.type == 'Self' then
        thisTarget = player.name

        if spell.targets['Self'] == false then
            cancel_spell()
            validSpell = false
        end
    elseif spell.target.type == 'PLAYER' then
        thisTarget = spell.target.name

        --Check if the spell target is a party member, and if so make sure the spell is castable on party members, otherwise check if castable on general players
        if checkPartyName(spell.target.name) then
            if spell.targets['Party'] == false then
                cancel_spell()
                validSpell = false
            end
        else
            if spell.targets['Player'] == false then
                cancel_spell()
                validSpell = false
            end
        end
    elseif spell.target.type == 'MONSTER' then
        if spell.target.raw == '<bt>' then
            thisTarget = 'bt'
        elseif spell.target ~= nil and spell.target.id ~= nil then
            thisTarget = spell.target.id
        else
            cancel_spell()
            validSpell = false
        end

        if spell.targets['Enemy'] == false then
            cancel_spell()
            validSpell = false
        end
    else
        validSpell = false
    end

    --Ensure the spell was castable, spellStack has a queue and the spell isn't already in it, if so then add to front of spellStack queue to allow players to add to queue by using macros in emergencies
    if validSpell and #spellStack > 0 and spell.prefix ~= '/item' and not checkInQueue(spell.english,thisTarget,thisPrefix) and not checkInQueue(spell.english,'t',thisPrefix) then
        windower.add_to_chat(050,'Added '..spell.english..' on '..thisTarget..' to front of queue')
        add_to_front(spell, thisTarget, false)
    end
end