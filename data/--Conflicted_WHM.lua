include('common_commands.lua')
include('how_about_no.lua')
include('no_interruptions.lua')
include('spam_protection.lua')
include('spell_stack.lua')

--Spell Stack Settings
--Use auto curing true|false
doCures = true
--Use Divine Caress automatically true|false
autoCaress = true
--Use status cures and ally buffs on alliance true|false
allianceCheck = true
--Use cures on alliance true|false
allianceHeal = false
--Use Stoneskin automatically true|false
autoSS = true
--Use Blink automatically true|false
autoBlink = false
--Use Sublimation automatically true|false
autoSub = true
--Use Phalanx automatically true|false
autoPhalanx = false
--Use Aquaveil automatically true|false
autoAquaveil = false
--Allow stratagems to be used automatically
autoStrat = true

selfFix['paralyna'] = true
selfFix['poisona'] = false
selfFix['erase'] = false
selfFix['cursna'] = true

valid_controllers = alt_names

local whmjpdata = windower.ffxi.get_player().job_points.whm.jp_spent
if whmjpdata >= 100 then
    reraiseAvailable = gearswap.res.spells[848]
else
    reraiseAvailable = gearswap.res.spells[142]
end

function get_sets()

	meleeMode = "Club"
	meleeSet = false
	cureSet = "Cure"
	mythicTries = 0
	dtMode = false

	lastx = 0
	lasty = 0

	autoCoffer = false
	cofferName = 'Velkk Coffer'
	lastChat = 0

	send_command('@input /macro book 2;wait 5;gs c jpdetect;')

	load_gear_file()
end

function pretarget(spell)
    if check_ready(spell) == false then
        cancel_spell()
    end

    queue_spell_if_busy(spell)

    if spell.english == 'Sneak' and spell.target.name == player.name and player.sub_job == 'DNC' and is_ability_ready('Spectral Jig') then
        cancel_spell()
        windower.send_command('input /ja "Spectral Jig" <me>;')
    end
end

function get_best_castable_single_cure(spell)
	if player.mp < spell.mp_cost then
		if player.mp >= 135 and spell.mp_cost > 135 then
			cancel_spell()
			windower.send_command('input /ma "Cure V" '..spell.target.name..';')
		elseif player.mp >= 88 and spell.mp_cost > 88 then
			cancel_spell()
			windower.send_command('input /ma "Cure IV" '..spell.target.name..';')
		elseif player.mp >= 46 and spell.mp_cost > 46 then
			cancel_spell()
			windower.send_command('input /ma "Cure III" '..spell.target.name..';')
		elseif player.mp >= 24 and spell.mp_cost > 24 then
			cancel_spell()
			windower.send_command('input /ma "Cure II" '..spell.target.name..';')
		elseif player.mp >= 8 and spell.mp_cost > 8 then
			cancel_spell()
			windower.send_command('input /ma "Cure" '..spell.target.name..';')
		end
	end
end

function get_best_castable_aoe_cure(spell)
	if player.mp < spell.mp_cost then
		if player.mp >= 260 and spell.mp_cost > 260 then
			cancel_spell()
			windower.add_to_chat(209,"Changing to IV")
			windower.send_command('input /ma "Curaga IV" '..spell.target.name..';')
		elseif player.mp >= 180 and spell.mp_cost > 180 then
			cancel_spell()
			windower.add_to_chat(209,"Changing to III")
			windower.send_command('input /ma "Curaga III" '..spell.target.name..';')
		elseif player.mp >= 120 and spell.mp_cost > 120 then
			cancel_spell()
			windower.add_to_chat(209,"Changing to II")
			windower.send_command('input /ma "Curaga II" '..spell.target.name..';')
		elseif player.mp >= 60 and spell.mp_cost > 60 then
			cancel_spell()
			windower.add_to_chat(209,"Changing to I")
			windower.send_command('input /ma "Curaga" '..spell.target.name..';')
		end
	end
end

function precast(spell)
	local cancelled = false
	if spell.action_type == 'Item' then
		return
	end
	if check_ready(spell) then
		if spell.type == 'WeaponSkill' and player.tp > 100 then
			if spell.target.distance > 10 then
				cancelled = true
				cancel_spell()
			end

			if sets[spell.english] then
				if buffactive['Reive Mark'] then
					equip(sets[spell.english],sets['Reive'])
				else
					equip(sets[spell.english])
				end
            else
                equip(sets['WS'])
			end
			windower.add_to_chat(050, '['..spell.name..'] '..spell.target.name..' <'..player.tp..'>')
		elseif spell.type == 'JobAbility' then
			if sets[spell.english] then
				equip(sets[spell.english])
			end
		elseif spell.skill == 'Healing Magic' then
			if string.slice(spell.english,1,4) == 'Cure' or string.slice(spell.english,1,4) == 'Cura' then
				equip(sets.precast['Cure'])
            else
            equip(sets.precast['General'])
			end
		elseif spell.skill == 'Enhancing Magic' then
			equip(sets.precast['Enhancing Magic'])
		elseif spell.english == 'Impact' then
			equip(sets.precast['Impact'])
		elseif spell.english == "Spectral Jig" and is_ability_ready('Spectral Jig') then
			send_command('cancel 71;')
		elseif spell.cast_time ~= nil and spell.cast_time > 0 then
			equip(sets.precast['General'])
		end

		if not cancelled then
			spam_protection_on(spell)
		end
	else
		cancel_spell()
	end
end

function midcast(spell,action)
	if spell.action_type == 'Item' then
		return
	end
	if spell.skill == 'Healing Magic' then
		if spell.english:sub(1,4) == 'Cure' then
			equip(sets.midcast["Cure"])
			if world.day_element == 'Light' or world.weather_element == 'Light' then
				equip(sets.midcast["Weather"])
			end
		elseif spell.english:sub(1,4) == 'Cura' then
			equip(sets.midcast["Curaga"])
			if world.day_element == 'Light' or world.weather_element == 'Light' then
				equip(sets.midcast["Weather"])
			end
		elseif spell.english == 'Cursna' then
			equip(sets.midcast['Cursna'])
		elseif 	spell.english == 'Poisona' or
				spell.english == 'Paralyna' or
				spell.english == 'Blindna' or
				spell.english == 'Silena' or
				spell.english == 'Stona' or
				spell.english == 'Viruna' or
				spell.english == 'Esuna' then
			equip(sets.midcast['StatusHeals'])
		else
			equip(sets.midcast['General'])
		end

	elseif spell.skill == 'Enhancing Magic' then
		if spell.english == 'Erase' then
			equip(sets.midcast['StatusHeals'])
		elseif spell.english == 'Stoneskin' then
            equip(sets.midcast['Stoneskin'])
		elseif spell.english == 'Aquaveil' then
			equip(sets.midcast['Aquaveil'])
		elseif spell.english:sub(1,5) == 'Regen' then
			equip(sets.midcast['Regen'])
		elseif spell.english:sub(1,3) == 'Bar' then
            equip(set_combine(sets.midcast['Enhancing Magic Duration'], sets.midcast['Barspell']))
			if buffactive['Light Arts'] then
				equip(sets.midcast['Barspell Light Arts'])
			end
		elseif spell.english == 'Haste' or spell.english == 'Invisible' or spell.english == 'Sneak' or spell.english:sub(-5) == 'storm' or spell.english:sub(-8) == 'storm II' or spell.english:sub(1,4) == 'Prot' or spell.english:sub(1,4) == 'Shel' or spell.english == 'Adloquium' or spell.english:sub(-6) == 'Animus' or spell.english == 'Blink' or spell.english == 'Refresh' then
			equip(set_combine(sets.midcast['General'], sets.midcast['Enhancing Magic Duration']) )
        elseif spell.english:sub(1,8) == 'Teleport' or spell.english:sub(1,6) == 'Recall' or spell.english == 'Warp' or spell.english == 'Warp II' then
            equip(sets.midcast['General'])
		else
			equip( set_combine(sets.midcast['Enhancing Magic'], sets.midcast['Enhancing Magic Duration']) )
		end
	elseif spell.skill == 'Divine Magic' then
		equip(sets.midcast['Divine Magic'])

		if spell.english == "Repose" then
			equip(sets.midcast['Repose'])
		end
	elseif spell.skill == 'Elemental Magic' then

		equip(sets.midcast['Elemental Magic'])
		if spell.english == 'Impact' then
			equip(sets.midcast['Impact'])
		end

	elseif spell.skill == 'Dark Magic' then

		equip(sets.midcast['Dark Magic'])
		if spell.english == 'Stun' then
			equip(sets.midcast['Stun'])
		end

	elseif spell.skill == 'Enfeebling Magic' then

		equip(sets.midcast['Enfeebling Magic'])
        if spell.english == 'Dia' or spell.english == 'Dia II' then
            equip(sets['TH'])
        end

    elseif spell.type == 'Ninjutsu' then

        equip(sets.midcast['General'])
        if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4)']) then
            send_command('wait 1.5;cancel 66;cancel 446;cancel 445;cancel 444;')
        end

	elseif spell.cast_time ~= nil and spell.cast_time > 0 then

		equip(sets.midcast['General'])

	end
end

function aftercast(spell,action)
	if spam_protection_off(spell)then
		handle_idle()
	end
	checkAftercast(spell)
end

function status_change(new,old)
	if check_ready_status() then
		handle_idle()
	end
end

function buff_change(buff,gain_or_loss)
	if gain_or_loss then
		if buff == 'Aftermath: Lv.3' then
			send_command('timers c "AM3" 180 up "Aftermath"')
		elseif buff == 'Aftermath: Lv.2' then
			send_command('timers c "AM2" 180 up "Aftermath"')
		elseif buff == 'Aftermath: Lv.1' then
			send_command('timers c "AM1" 180 up "Aftermath"')
		end

		if buff == 'weakness' then
			send_command('timers c "Weakness" 300 up "Weakness"')
		end
	else
		if buff == 'Aftermath: Lv.3' then
			send_command('timers d "AM3"')
		elseif buff == 'Aftermath: Lv.2' then
			send_command('timers d "AM2"')
		elseif buff == 'Aftermath: Lv.1' then
			send_command('timers d "AM1"')
		elseif buff == 'encumbrance' then
			windower.send_command('gs c dt_end;')
		end

		if buff == 'weakness' then
			send_command('timers d "Weakness"')
		end
	end
end

function handle_idle()
	if player.status == 'Engaged' then
		equip(sets[meleeMode])

		if buffactive['Reive Mark'] then
			equip(sets['Reive'])
		end
	elseif player.status == 'Resting' then
		equip(sets['Resting'])
	else
		if player.mpp > 80 or dtMode then
			equip(sets['Idle DT'])
		else
			equip(sets['Idle Refresh'])
		end

		if not dtMode and player_target == false then
			equip(sets['Running'])
		end
	end

	if player.mpp < 50 then
		equip(sets['mpBelt'])
		if world.area == 'Nyzul Isle' or world.area == 'Alzadaal Undersea Ruins' or world.area == 'Zhayolm Remnants' or world.area == 'Arrapago Remnants' or world.area == 'Bhaflau Remnants' or world.area == 'Silver Sea Remnants' then
			equip({ring2 = "Balrahn's Ring"})
		end
	end
end

function self_command(command)
	if command == 'trigger1' then
		send_command('input /ma "Cure III" <stpc>;')
	elseif command == 'trigger2' then
		send_command('input /ma "Cure IV" <stpc>;')
	elseif command == 'trigger3' then
		send_command('input /ma "Cure V" <stpc>;')
	elseif command == 'trigger4' then
		send_command('input /ma "Cure VI" <stpc>;')
	elseif command == 'trigger5' then
		send_command('input /ma "Erase" <stpc>;')
	elseif command == 'step' then
		if player.status == 'Engaged' and player.sub_job == 'DNC' then
			send_command('input /ja "Box Step" <t>;')
		end
	elseif command == 'flourish' then
		if player.status == 'Engaged' and player.sub_job == 'DNC' then
			send_command('input /ja "Violent Flourish" <t>;')
		end
	elseif command == 'ws' then
		if player.status == 'Engaged' and player.tp >= 1000 then
			if meleeMode == "Staff" then
				send_command('input /ws "Shattersoul" <t>;')
			else
				send_command('input /ws "Realmrazer" <t>;')
			end
		end
	elseif command == 'melee' then
		if player.sub_job == "DNC" then
			if meleeMode == "Dual Club" then
				windower.add_to_chat(158,"Melee Mode [Staff]")
				weapon = 'Nilgal Pole'
				shield = 'Arbuda Grip'
				meleeMode = "Staff"
			else
				windower.add_to_chat(158,"Melee Mode [Dual Club]")
				weapon = 'Divinity'
				shield = 'Sindri'
				meleeMode = "Dual Club"
			end
		else
			if meleeMode == "Club" then
				windower.add_to_chat(158,"Melee Mode [Staff]")
				weapon = 'Nilgal Pole'
				shield = 'Arbuda Grip'
				meleeMode = "Staff"
			else
				windower.add_to_chat(158,"Melee Mode [Club]")
				weapon = 'Divinity'
				shield = "Genbu's Shield"
				meleeMode = "Club"
			end
		end
		send_command('gs c lockweapon;')
	elseif command == 'lockweapon' then
		equip(sets[meleeMode])
		if player.equipment.main == weapon and player.equipment.sub == shield then
			disable('main','sub')
			mythicTries = 0
			windower.add_to_chat(167,"Melee [ON]")
		elseif mythicTries > 10 then
			windower.add_to_chat(050,weapon.." couldn't be equipped at this time.")
		else
			enable('main','sub')
			mythicTries = mythicTries + 1
			send_command('wait 1;gs c lockweapon;')
		end
	elseif command == 'off' then
		enable('main','sub')
		meleeSet = false
		windower.add_to_chat(158,"Melee Mode [OFF]")
		handle_idle()
	elseif command:slice(1,9) == 'castspell' then
		commandSplit = T{}
		commandSplit = string.split(command," ")
		if commandSplit[2] ~= nil and commandSplit[3] ~= nil then
			if commandSplit[3] == 'bt' then
				send_command('input /ma "'..commandSplit[2]..'" <bt>;')
			elseif commandSplit[3] == 't' then
				send_command('input /ma "'..commandSplit[2]..'" <t>;')
			else
				send_command('input /ma "'..commandSplit[2]..'" '..commandSplit[3]..';')
			end
		end
	elseif command == 'tank' then
		if not dtMode then
			dtMode = true
			windower.add_to_chat(028, "Idle DT [ON]")
		else
			dtMode = false
			windower.add_to_chat(028, "Idle DT [OFF]")
		end
		handle_idle()
	elseif command == 'ws' and player.status == 'Engaged' and player.tp >= 1000 then
		if meleeMode == 'Staff' then
			send_command('input /ws "Shattersoul" <t>;')
		else
			send_command('input /ws "Realmrazer" <t>;')
		end
	elseif command == 'sneak' then
		send_command('input /ma "Sneak" <me>')
	elseif command == 'invisible' then
		send_command('input /ma "Invisible" <me>')
    elseif command == 'dia2' then
        direct_push(stack_spells['Dia II'], 'ma', 'bt', false)
	elseif command == 'debuff' then
		direct_push(stack_spells['Slow'], 'ma', 'bt', false)
		direct_push(stack_spells['Blind'], 'ma', 'bt', false)
		direct_push(stack_spells['Paralyze'], 'ma', 'bt', false)
		direct_push(stack_spells['Addle'], 'ma', 'bt', false)
	elseif command == 'jpdetect' then
		local whmjpdata = windower.ffxi.get_player().job_points.whm.jp_spent
		if whmjpdata >= 100 then
			reraiseAvailable = gearswap.res.spells[848]
		else
			reraiseAvailable = gearswap.res.spells[142]
		end
    elseif command == 'ambu3' then
        dtMode = true
        direct_push(gearswap.res.spells[54], 'ma', player.name, false)
        direct_push(gearswap.res.spells[53], 'ma', player.name, false)
        direct_push(gearswap.res.spells[55], 'ma', player.name, false)
	elseif execute_common_command(command) then
		--done
	elseif stack_command(command) then
		--done
	end
end

function handle_ping()
    if player.hp == 0 and (#spellStack > 0 or party_target ~= false) then
        party_target = false
        clear_spell_stack()
        windower.add_to_chat(028,'Unsetting any party target and clearing stack')
    end

	if buffactive['petrification'] then
		if os.clock()-lastChat > 10 then
			send_command('input /p Stona!')
			lastChat = os.clock()
		end
	elseif buffactive['sleep'] then
		if os.clock()-lastChat > 10 then
			send_command('input /p zzz')
			lastChat = os.clock()
		end
	end

	if check_ready_silent() and player.x == lastx and player.y == lasty then
		if buffactive['silence'] and os.clock()-lastChat > 5 then
			send_command('input /item "Echo Drops" <me>;')
			lastChat = os.clock()
		end

		if player.sub_job == 'NIN' and not buffactive['Copy Image (2)'] and not buffactive['Copy Image (3)'] and not buffactive['Copy Image (4)'] then
			if is_spell_ready('Utsusemi: Ni') then
				direct_push_front(stack_spells['Utsusemi: Ni'], 'ma', player.name, false)
			elseif is_spell_ready('Utsusemi: Ichi') then
				direct_push_front(stack_spells['Utsusemi: Ichi'], 'ma', player.name, false)
			end
		end

		if selfFix['cursna'] and (buffactive['doom'] or buffactive['curse']) and is_spell_ready('Cursna') then
			direct_push_front(gearswap.res.spells[20], 'ma', player.name, false)
		end
		if selfFix['erase'] and (buffactive['bind'] or buffactive['weight'] or buffactive['slow']) then
			direct_push(gearswap.res.spells[143], 'ma', player.name, false)
		end
		if selfFix['poisona'] and buffactive['poison'] then
			direct_push(gearswap.res.spells[14], 'ma', player.name, false)
		end
		if selfFix['paralyna'] and buffactive['paralysis'] then
			direct_push(gearswap.res.spells[15], 'ma', player.name, false)
		end

		if autoSS and not buffactive['stoneskin'] and is_spell_ready('Stoneskin') then
			direct_push(gearswap.res.spells[54], 'ma', player.name, false)
		end
		if autoBlink and not buffactive['Blink'] and is_spell_ready('Blink') then
			direct_push(gearswap.res.spells[53], 'ma', player.name, false)
		end
		if autoAquaveil and not buffactive['Aquaveil'] and is_spell_ready('Aquaveil') then
			direct_push(gearswap.res.spells[55], 'ma', player.name, false)
		end

		if not buffactive['afflatus solace'] and not buffactive['afflatus misery'] and is_ability_ready('Afflatus Solace')then
			direct_push(gearswap.res.job_abilities[245], 'ja', player.name, false)
		end

        if not buffactive['reraise'] and is_spell_ready(reraiseAvailable.en) then
            direct_push(reraiseAvailable, 'ma', player.name, false)
        end

		if player.sub_job == 'SCH' and player.sub_job_level > 0 then
            if not buffactive['Addendum: White'] and not buffactive['Light Arts'] and is_ability_ready('Light Arts') then
                direct_push(gearswap.res.job_abilities[211], 'ja', player.name, false)
            else

			if autoSub then
				if not buffactive['weakness'] and not buffactive['Sublimation: Complete'] and not buffactive['Sublimation: Activated'] and is_ability_ready('Sublimation') then
					direct_push(gearswap.res.job_abilities[233], 'ja', player.name, false)
				end
				if not buffactive['weakness'] and player.mp < 600 and buffactive['Sublimation: Complete'] and is_ability_ready('Sublimation')then
					direct_push(gearswap.res.job_abilities[233], 'ja', player.name, false)
				end
			end

            end
		elseif player.sub_job == 'RDM' and player.sub_job_level > 0 then
			if not buffactive['weakness'] and  player.mp < 200 and player.hp > 1000 and is_ability_ready('Convert') then
				direct_push(gearswap.res.job_abilities[83], 'ja', player.name, false)
			end

			if not buffactive['refresh'] and is_spell_ready('Refresh') then
				direct_push(gearswap.res.spells[109], 'ma', player.name, false)
			end
		end

		check_auto_spell()
		if doCures then
			cure_process()
		end
		handleSpareTime()
	else
		if player.hp == 0 then
			clear_spell_stack()
		end
		lastx = player.x
		lasty = player.y
	end
end

function file_unload(file_name)
    windower.text.delete('stackoutput')
end