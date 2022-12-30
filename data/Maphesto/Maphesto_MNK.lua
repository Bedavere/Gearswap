-- *** Credit goes to Flippant for helping me with Gearswap *** --
-- ** I Use Some of Motenten's Functions ** --

function get_sets()
	AccIndex = 1
	AccArray = {"LowACC","MidACC","HighACC"} -- 3 Levels Of Accuracy Sets For TP/WS/Hybrid. First Set Is LowACC. Add More ACC Sets If Needed Then Create Your New ACC Below. --
	IdleIndex = 1
	IdleArray = {"Regen","Movement"} -- Default Idle Set Is Movement --
	Armor = 'None'
	HP = 'OFF'
	Attack = 'OFF' -- Set Default WS Attack Set ON or OFF Here --
	Rancor = 'OFF' -- Set Default Rancor ON or OFF Here --
	target_distance = 8 -- Set Default Distance Here --

	sc_map = {SC1="VictorySmite", SC2="Impetus", SC3="Berserk"} -- 3 Additional Binds. Can Change Whatever JA/WS/Spells You Like Here. Remember Not To Use Spaces. --

	sets.Idle = {}
	-- Idle/Town Sets --
	sets.Idle.Regen = {ammo="Ginsen",
	head="Kendatsuba Jinpachi +1",neck="Sanctity Necklace",ear1="Infused Earring",ear2="Telos Earring",
	body="Hesychast's Cyclas +3",hands="Kendatsuba Tekko +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10'}},
	waist="Moonbow Belt +1",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-Ate +1"
}

	--Normal TP Sets --
	sets.TP = {ammo="Ginsen",
    ammo="Ginsen",
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands="Ken. Tekko +1",
    legs="Ken. Hakama +1",
    feet="Ken. Sune-Ate +1",
    neck="Moonlight Nodowa",
    waist="Hurch'lan Sash",
    left_ear="Sherida Earring",
    right_ear="Digni. Earring",
    left_ring="Epona's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	
	sets.TP.MidACC = set_combine(sets.TP,{ammo="Ginsen",
	head="Kendatsuba Jinpachi +1",neck="Moonlight Nodowa",ear1="Cessance Earring",ear2="Telos Earring",
	body="Kendatsuba Samue +1",hands="Kendatsuba Tekko +1",ring1="Epona's Ring",ring2="Niqmaddu Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10'}},
	waist="Moonbow Belt +1",legs="Kendatsuba Hakama +1",feet="Kendatsuba Sune-Ate +1"})
	sets.TP.HighACC = set_combine(sets.TP.MidACC,{})
	
	-- (Impetus Up) TP Sets --
    sets.TP.Impetus = set_combine(sets.TP,{
    body="Bhikku Cyclas +1"})

	-- Footwork Set --
	sets.TP.Footwork = set_combine(sets.TP,{
	legs="Hesychast's Hose +3",feet="Anchorite's Gaiters +3"})
	
	sets.TP.ImpetusFootwork = set_combine(sets.TP,{
	body="Bhikku Cyclas +1",legs="Hesychast's Hose +3",feet="Anchorite's Gaiters +3"})
	
	-- Perfect Counter Set --
	sets.TP.PerfectCounter = {head="Bhikku Crown +1"}

	-- TP Rancor ON Neck --
	sets.TP.Rancor = {neck="Rancor Collar"}

	-- PDT/MDT Sets --
	sets.PDT = {}

	sets.MDT = set_combine(sets.PDT,{})
	
	sets.Counterstance = {ammo="Ginsen",
	head="Kendatsuba Jinpachi +1",neck="Moonlight Nodowa",ear1="Cryptic Earring",ear2="Telos Earring",
	body="Hesychast's Cyclas +3",hands="Kendatsuba Tekko +1",ring1="Defending Ring",ring2="Vocane Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10'}},
	waist="Moonbow Belt +1",legs="Anchorite's Hose +3",feet="Hesychast's Gaiters +3"}

	-- Hybrid/HP Sets --
	sets.TP.Hybrid = {ammo="Ginsen",
	head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Sherida Earring",ear2="Telos Earring",
	body="Kendatsuba Samue +1",hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	ring1="Defending Ring",ring2="Vocane Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10'}},
	waist="Moonbow Belt +1",legs="Hesychast's Hose +3",feet="Anchorite's Gaiters +3"}
	sets.TP.HybridImpetus = {ammo="Ginsen",
	head="Adhemar Bonnet +1",neck="Twilight Torque",ear1="Sherida Earring",ear2="Telos Earring",
	body="Bhikku Cyclas +1",hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
	ring1="Defending Ring",ring2="Vocane Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10'}},
	waist="Moonbow Belt +1",legs="Hesychast's Hose +3",feet="Anchorite's Gaiters +3"}
	sets.TP.Hybrid.MidACC = set_combine(sets.TP.Hybrid,{})
	sets.TP.Hybrid.HighACC = set_combine(sets.TP.Hybrid.MidACC,{})

	sets.HP = set_combine(sets.PDT,{})

	-- WS Base Set --
	sets.WS = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Herculean Boots", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','Attack+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

	-- Victory Smite Sets --
	sets.WS["Victory Smite"] = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Herculean Boots", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','Attack+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}
	sets.WS["Victory Smite"].MidACC = set_combine(sets.WS["Victory Smite"],{})
	sets.WS["Victory Smite"].HighACC = set_combine(sets.WS["Victory Smite"].MidACC,{})

	-- Victory Smite(Attack) Set --
	sets.WS["Victory Smite"].ATT = set_combine(sets.WS["Victory Smite"],{})

	-- Shijin Spiral Sets --
	sets.WS["Shijin Spiral"] = {head="Kendatsuba Jinpachi +1",neck="Caro Necklace",ear1="Sherida Earring",ear2="Moonshade Earring",
	body="Adhemar Jacket +1",hands="Kendatsuba Tekko +1",ring1="Ilabrat Ring",ring2="Niqmaddu Ring",
	back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10'}},
	waist="Moonbow Belt +1",legs="Jokushu Haidate",feet="Kendatsuba Sune-Ate +1"}
	sets.WS["Shijin Spiral"].MidACC = set_combine(sets.WS["Shijin Spiral"],{})
	sets.WS["Shijin Spiral"].HighACC = set_combine(sets.WS["Shijin Spiral"].MidACC,{})

	-- Shijin Spiral(Attack) Set --
	sets.WS["Shijin Spiral"].ATT = set_combine(sets.WS["Shijin Spiral"],{})

	-- Asuran Fists Sets --
	sets.WS["Asuran Fists"] = {
	}
	sets.WS["Asuran Fists"].MidACC = set_combine(sets.WS["Asuran Fists"],{})
	sets.WS["Asuran Fists"].HighACC = set_combine(sets.WS["Asuran Fists"].MidACC,{})

	sets.WS["Final Heaven"] = {ammo="Knobkierrie",
	head="Hesychast's Crown +3",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Ishvara Earring",
	body={ name="Herculean Vest", augments={'Attack+25','Weapon skill damage +4%','STR+10',}},
	hands="Anchorite's Gloves +3",ring1="Regal Ring",ring2="Niqmaddu Ring",
	back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
	waist="Moonbow Belt +1",legs="Hizamaru Hizayoroi +2",
	feet={ name="Herculean Boots", augments={'Attack+18','Weapon skill damage +4%','STR+9',}}}
	
	sets.WS["Tornado Kick"] = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Herculean Boots", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','Attack+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.WS["Dragon Kick"] = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Herculean Boots", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','Attack+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.WS["Asuran Fists"] = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Hiza. Hizayoroi +2",
    feet={ name="Herculean Boots", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','Attack+4',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Dingir Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

	sets.WS["Ascetic's Fury"] = {ammo="Knobkierrie",
	head="Adhemar Bonnet +1",neck="Fotia Gorget",ear1="Sherida Earring",ear2="Moonshade Earring",
	body="Anchorite's Cyclas +3",hands="Ryuo Tekko +1",ring1="Begrudging Ring",ring2="Niqmaddu Ring",
	back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
	waist="Moonbow Belt +1",legs="Hesychast's Hose +3",
	feet={ name="Herculean Boots", augments={'Accuracy+14 Attack+14','Crit. hit damage +4%','DEX+6','Accuracy+12','Attack+13',}}}
	
	-- JA Sets --
	sets.JA = {}
	sets.JA.Footwork = {feet="Bhikku Gaiters +1"}
	sets.JA.Focus = {head="Anchorite's Crown +3"}
	sets.JA['Formless Strikes'] = {body="Hesychast's Cyclas +3"}
	sets.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
	sets.JA.Mantra = {feet="Hesychast's Gaiters +3"}
	sets.JA.Counterstance = {feet="Hesychast's Gaiters +3"}
	sets.JA.Dodge = {feet="Anchorite's Gaiters +3"}
	sets.JA.Chakra = {
			body="Achorite's Cyclas +3",
			hands="Hesychast's Gloves +3"}
	sets.JA.Provoke = {
			ammo="Sapience Orb",
			feet="Hermes' Sandals",
			neck="Unmoving Collar +1",
			left_ear="Trux Earring",
			right_ear="Cryptic Earring",
			left_ring="Petrov Ring",
			right_ring="Dingir Ring",
			back="Reiki Cloak",
}
	-- Waltz Set --
	sets.Waltz = {}

	sets.Precast = {head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+22','"Fast Cast"+5','MND+13',}},
	neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
	body="Taeon Tabard",hands="Leyline Gloves",ring2="Prolix Ring",
	legs={ name="Herculean Trousers", augments={'Mag. Acc.+7','"Fast Cast"+5','INT+1',}},
	feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+5','STR+9','Mag. Acc.+4',}}}
	-- Fastcast Set --
	sets.Precast.FastCast = {head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+22','"Fast Cast"+5','MND+13',}},
	neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
	body="Taeon Tabard",hands="Leyline Gloves",ring2="Prolix Ring",
	legs={ name="Herculean Trousers", augments={'Mag. Acc.+7','"Fast Cast"+5','INT+1',}},
	feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+5','STR+9','Mag. Acc.+4',}}}
	-- Utsusemi Precast Set --
	sets.Precast.Utsusemi = set_combine(sets.Precast.FastCast,{neck="Magoraga Beads"})

	sets.Midcast = {}
	-- Magic Haste Set --
	sets.Midcast.Haste = set_combine(sets.PDT,{})
end

function precast(spell,action)
	if spell.type == "WeaponSkill" then
		if player.status ~= 'Engaged' then -- Cancel WS If You Are Not Engaged. Can Delete It If You Don't Need It --
			cancel_spell()
			add_to_chat(123,'Unable To Use WeaponSkill: [Disengaged]')
			return
		else
			equipSet = sets.WS
			if equipSet[spell.english] then
				equipSet = equipSet[spell.english]
			end
			if Attack == 'ON' then
				equipSet = equipSet["ATT"]
			end
			if equipSet[AccArray[AccIndex]] then
				equipSet = equipSet[AccArray[AccIndex]]
			end
			if spell.english == "Victory Smite" or spell.english == "Ascetic's Fury" then
				if buffactive.Impetus then -- Equip Bhikku Cyclas +1 When You Have Impetus On For Victory Smite or Ascetic's Fury --
					equipSet = set_combine(equipSet,{body="Bhikku Cyclas +1"})
				end
			end
			equip(equipSet)
		end
	elseif spell.type == "JobAbility" then
		if sets.JA[spell.english] then
			equip(sets.JA[spell.english])
		end
	elseif spell.action_type == 'Magic' then
		if spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ni' then
				if buffactive['Copy Image (3)'] then
					cancel_spell()
					add_to_chat(123, spell.name .. ' Canceled: [3 Images]')
					return
				else
					equip(sets.Precast.Utsusemi)
				end
			else
				equip(sets.Precast.Utsusemi)
			end
		else
			equip(sets.Precast.FastCast)
		end
	elseif spell.type == "Waltz" then
		refine_waltz(spell,action)
		equip(sets.Waltz)
	elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
		cast_delay(0.2)
		send_command('cancel Sneak')
	end
	if HP == 'ON' then
		equip(sets.HP)
	end
end

function midcast(spell,action)
	if spell.action_type == 'Magic' then
		if spell.english:startswith('Utsusemi') then
			if spell.english == 'Utsusemi: Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then
				send_command('@wait 1.7;cancel Copy Image*')
			end
			equip(sets.Midcast.Haste)
		elseif spell.english == 'Monomi: Ichi' then
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equip(sets.Midcast.Haste)
		else
			equip(sets.Midcast.Haste)
		end
	end
end

function aftercast(spell,action)
	if not spell.interrupted then
		if spell.type == "WeaponSkill" then
			send_command('wait 0.2;gs c TP')
		end
	end
	status_change(player.status)
end

function status_change(new,old)
	check_equip_lock()
	if Armor == 'PDT' then
		equip(sets.PDT)
	elseif Armor == 'MDT' then
		equip(sets.MDT)
	elseif new == 'Engaged' then
		equipSet = sets.TP
		if Armor == 'Hybrid' then
			equipSet = equipSet["Hybrid"]
		end
		if Attack == 'ON' then
			equipSet = equipSet["ATT"]
		end
		if equipSet[AccArray[AccIndex]] then
			equipSet = equipSet[AccArray[AccIndex]]
		end
		if buffactive.Impetus then
            equipSet = set_combine(equipSet,sets.TP.Impetus)
        end
		if buffactive.Footwork then
            equipSet = set_combine(equipSet,sets.TP.Footwork)
		end
		if buffactive.Impetus and buffactive.Footwork then
			equipSet = set_combine(equipSet,sets.TP.ImpetusFootwork)
		end
		if Armor == 'Hybrid' and buffactive.Impetus then
			equipSet = set_combine(equipSet,sets.TP.HybridImpetus)
		end
		if buffactive.Counterstance then
			equipSet = set_combine(equipSet,sets.Counterstance)
		end
		if buffactive['Perfect Counter'] then
			equipSet = set_combine(equipSet,sets.TP.PerfectCounter)
		end
		equip(equipSet)
	else
		equipSet = sets.Idle
		if equipSet[IdleArray[IdleIndex]] then
			equipSet = equipSet[IdleArray[IdleIndex]]
		end
		equip(equipSet)
	end
	if HP == 'ON' then
		equip(sets.HP)
	end
end

function buff_change(buff,gain)
	buff = string.lower(buff)
	if buff == "aftermath: lv.3" then -- AM3 Timer/Countdown --
		if gain then
			send_command('timers create "Aftermath: Lv.3" 180 down;wait 150;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 15;input /echo Aftermath: Lv.3 [WEARING OFF IN 15 SEC.];wait 5;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
		else
			send_command('timers delete "Aftermath: Lv.3"')
			add_to_chat(123,'AM3: [OFF]')
		end
	end
	if not midaction() then
		status_change(player.status)
	end
end

-- In Game: //gs c (command), Macro: /console gs c (command), Bind: gs c (command) --
function self_command(command)
	if command == 'C1' then -- Accuracy Toggle --
		AccIndex = (AccIndex % #AccArray) + 1
		add_to_chat(158,'Accuracy Level: ' .. AccArray[AccIndex])
		status_change(player.status)
	elseif command == 'C17' then -- Main Weapon Toggle --
		WeaponIndex = (WeaponIndex % #WeaponArray) + 1
		add_to_chat(158,'Main Weapon: '..WeaponArray[WeaponIndex])
		status_change(player.status)
	elseif command == 'C5' then -- Auto Update Gear Toggle --
		status_change(player.status)
		add_to_chat(158,'Auto Update Gear')
	elseif command == 'C2' then -- Hybrid Toggle --
		if Armor == 'Hybrid' then
			Armor = 'None'
			add_to_chat(123,'Hybrid Set: [Unlocked]')
		else
			Armor = 'Hybrid'
			add_to_chat(158,'Hybrid Set: '..AccArray[AccIndex])
		end
		status_change(player.status)
	elseif command == 'C7' then -- PDT Toggle --
		if Armor == 'PDT' then
			Armor = 'None'
			add_to_chat(123,'PDT Set: [Unlocked]')
		else
			Armor = 'PDT'
			add_to_chat(158,'PDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C15' then -- MDT Toggle --
		if Armor == 'MDT' then
			Armor = 'None'
			add_to_chat(123,'MDT Set: [Unlocked]')
		else
			Armor = 'MDT'
			add_to_chat(158,'MDT Set: [Locked]')
		end
		status_change(player.status)
	elseif command == 'C3' then -- HP Toggle --
		if HP == 'ON' then
			HP = 'OFF'
			add_to_chat(123,'HP Set: [Unlocked]')
		else
			HP = 'ON'
			add_to_chat(158,'HP Set: [locked]')
		end
		status_change(player.status)
	elseif command == 'C16' then -- Rancor Toggle --
		if Rancor == 'ON' then
			Rancor = 'OFF'
			add_to_chat(123,'Rancor: [OFF]')
		else
			Rancor = 'ON'
			add_to_chat(158,'Rancor: [ON]')
		end
		status_change(player.status)
	elseif command == 'C9' then -- Attack Toggle --
		if Attack == 'ON' then
			Attack = 'OFF'
			add_to_chat(123,'Attack: [OFF]')
		else
			Attack = 'ON'
			add_to_chat(158,'Attack: [ON]')
		end
		status_change(player.status)
	elseif command == 'C8' then -- Distance Toggle --
		if player.target.distance then
			target_distance = math.floor(player.target.distance*10)/10
			add_to_chat(158,'Distance: '..target_distance)
		else
			add_to_chat(123,'No Target Selected')
		end
	elseif command == 'C6' then -- Idle Toggle --
		IdleIndex = (IdleIndex % #IdleArray) + 1
		add_to_chat(158,'Idle Set: ' .. IdleArray[IdleIndex])
		status_change(player.status)
	elseif command == 'TP' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	elseif command:match('^SC%d$') then
		send_command('//' .. sc_map[command])
	end
end

function check_equip_lock() -- Lock Equipment Here --
	if player.equipment.right_ring == "Warp Ring" or player.equipment.right_ring == "Dim. Ring (Holla)" then
		disable('ring2')
	else
		enable('ring2')
	end
end

function timer_impetus()
	local duration = 180
	send_command('timers create "Impetus" '..tostring(duration)..' down')
end

function timer_mantra()
	local duration = 180
	send_command('timers create "Mantra" '..tostring(duration)..' down')
end

function refine_waltz(spell,action)
	if spell.type ~= 'Waltz' then
		return
	end

	if spell.name == "Healing Waltz" or spell.name == "Divine Waltz" or spell.name == "Divine Waltz II" then
		return
	end

	local newWaltz = spell.english
	local waltzID

	local missingHP

	if spell.target.type == "SELF" then
		missingHP = player.max_hp - player.hp
	elseif spell.target.isallymember then
		local target = find_player_in_alliance(spell.target.name)
		local est_max_hp = target.hp / (target.hpp/100)
		missingHP = math.floor(est_max_hp - target.hp)
	end

	if missingHP ~= nil then
		if player.sub_job == 'DNC' then
			if missingHP < 40 and spell.target.name == player.name then
				add_to_chat(123,'Full HP!')
				cancel_spell()
				return
			elseif missingHP < 150 then
				newWaltz = 'Curing Waltz'
				waltzID = 190
			elseif missingHP < 300 then
				newWaltz = 'Curing Waltz II'
				waltzID = 191
			else
				newWaltz = 'Curing Waltz III'
				waltzID = 192
			end
		else
			return
		end
	end

	local waltzTPCost = {['Curing Waltz'] = 20, ['Curing Waltz II'] = 35, ['Curing Waltz III'] = 50}
	local tpCost = waltzTPCost[newWaltz]

	local downgrade

	if player.tp < tpCost and not buffactive.trance then

		if player.tp < 20 then
			add_to_chat(123, 'Insufficient TP ['..tostring(player.tp)..']. Cancelling.')
			cancel_spell()
			return
		elseif player.tp < 35 then
			newWaltz = 'Curing Waltz'
		elseif player.tp < 50 then
			newWaltz = 'Curing Waltz II'
		end

		downgrade = 'Insufficient TP ['..tostring(player.tp)..']. Downgrading to '..newWaltz..'.'
	end

	if newWaltz ~= spell.english then
		send_command('@input /ja "'..newWaltz..'" '..tostring(spell.target.raw))
		if downgrade then
			add_to_chat(158, downgrade)
		end
		cancel_spell()
		return
	end

	if missingHP > 0 then
		add_to_chat(158,'Trying to cure '..tostring(missingHP)..' HP using '..newWaltz..'.')
	end
end

function find_player_in_alliance(name)
	for i,v in ipairs(alliance) do
		for k,p in ipairs(v) do
			if p.name == name then
				return p
			end
		end
	end
end