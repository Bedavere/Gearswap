--[[
War Lua 1.0 By Erupt

Bind -

	Alt - F1 = Auto WeaponSkill
	Alt - F2 = Auto Hasso
	F9 - cycles through sets

****************************************************** --]]
 
Town = S {
    "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
    "Port Windurst", "Windurst Waters", "Windurst Woods", "Windurst Walls", "Heavens Tower",
    "Port San d'Oria", "Northern San d'Oria", "Southern San d'Oria", "Chateau d'Oraguille",
	"Port Bastok", "Bastok Markets", "Bastok Mines", "Metalworks",
    "Aht Urhgan Whitegate", "Nashmau",
    "Selbina", "Mhaura", "Norg",  "Kazham", "Tavanazian Safehold",
    "Eastern Adoulin", "Western Adoulin", "Celennia Memorial Library", "Mog Garden"
}
 
 function get_sets()
 
	Cichols = {}
	Cichols.WSD = { name = "Cichol's mantle", augments = { 'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%', } }
	Cichols.Reso = { name="Cichol's mantle", augments={ 'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Damage taken-5%', } }
	Cichols.TP	= { name="Cichol's mantle", augments={ 'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%', } }
	
	sets.TP = {}
	sets.TP.index = {'Standard', 'Accuracy', 'HybridDT','FullDT'}
	TP_ind = 1 -- Standard set is the Default
	sets.Weapons = {}
	sets.Weapons.index = { 'Chango', 'Ragnarok', 'Shining One', 'Kaja Axe', 'Kaja Sword' }
	WP_ind = 1


	OdysseanLegs = {}
	OdysseanLegs.WSD = { name="Odyssean cuisses", augments = {'Accuracy+22 Attack+22','Weapon skill damage +4%',}}

	sets.lockstyle = {
	    head        = "Founder's Corona",
        body        = "Found. Breastplate",
        hands       = "Founder's Gauntlets",
        legs        = "Founder's Hose",
        feet        = "Founder's Greaves"
	}
	
	sets.idle = {    
		ammo		="Staunch Tathlum +1",
		head		="Twilight Helm",
		body		="Kumarbi's Akar",
		hands		="Sulev. Gauntlets +2",
		legs		="Sulev. Cuisses +2",
		feet		="Hermes' Sandals",
		neck		="Sanctity Necklace",
		waist		="Nierenschutz",
		left_ear	="Infused Earring",
		right_ear	="Etiolation Earring",
		left_ring	="Sheltered Ring",
		right_ring	="Paguroidea Ring",
		back		="Moonbeam Cape",
    }
	
	  sets.Weapons['Chango'] = {
		main		="Chango",
		sub			="Utu Grip",
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Combatant's Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Brutal Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	  sets.Weapons['Ragnarok'] = {
		main		="Ragnarok",
		sub			="Utu Grip",
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Combatant's Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Brutal Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	  sets.Weapons['Kaja Sword'] = {
		main		="Kaja Sword",
		sub			="Blurred Shield +1",
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Combatant's Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Brutal Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	  sets.Weapons['Kaja Axe'] = {
		main		="Kaja Axe",
		sub			="Blurred Shield +1",
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Combatant's Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Brutal Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	  sets.Weapons['Shining One'] = {
		main		="Shining One",
		sub			="Utu Grip",
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Combatant's Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Brutal Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
      sets.TP['Standard'] = {
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Combatant's Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Brutal Earring",
		left_ring	="Flamma Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	

	  sets.TP['Accuracy'] = {
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Flam. Manopolas +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Warrior's Beads",
		waist		="Ioskeha Belt +1",
		left_ear	="Digni. Earring",
		right_ear	="Telos Earring",
		left_ring	="Flamma Ring",
		right_ring	="Regal Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	
		  sets.TP['HybridDT'] = {
     
		ammo		="Staunch Tathlum +1",
		head		="Hjarrandi Helm",
		body		="Hjarrandi Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Flam. Gambieras +2",
		neck		="Sanctity Necklace",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Telos Earring",
		left_ring	="Moonlight Ring",
		right_ring	="Moonlight Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	
		sets.TP['FullDT'] = {
     
		ammo		="Staunch Tathlum +1",
		head		="Hjarrandi Helm",
		body		="Hjarrandi Breast.",
		hands		="Ar. Manopolas +1",
		legs		="Arke Cosc. +1",
		feet		="Ar. Gambieras +1",
		neck		="Loricate Torque +1",
		waist		="Ioskeha Belt +1",
		left_ear	="Hearty Earring",
		right_ear	="Etiolation Earring",
		left_ring	="Moonlight Ring",
		right_ring	="Moonlight Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
 sets.TP['Hetairoi'] = {
     
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Clotharius Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Brutal Earring",
		left_ring	="Hetairoi Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
 

	sets.engaged = sets.TP['Standard']
	sets.ws = {}
	sets.wsacc = {}
    sets.ws.Default = {
		ammo		="Knobkierrie",
		head		="Agoge Mask +2",
		body		="Pumm. Lorica +3",
		hands		={ name="Odyssean Gauntlets", augments={'DEX+14','"Dbl.Atk."+1','Weapon skill damage +8%','Accuracy+9 Attack+9',}},
		legs		={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%',}},
		feet		="Sulev. Leggings +2",
		neck		="Fotia Gorget",
		waist		="Ioskeha Belt +1",
		left_ear	="Ishvara Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Niqmaddu Ring",
		right_ring	="Regal Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
    sets.ws.Resolution = {
		ammo		="Knobkierrie",
		head		={ name="Argosy Celata +1", augments={'STR+12','DEX+12','Attack+20',}},
		body		="Pumm. Lorica +3",
		hands		={ name="Argosy Mufflers +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs		={ name="Argosy Breeches +1", augments={'STR+12','DEX+12','Attack+20',}},
		feet		="Pumm. Calligae +3",
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	sets.wsacc.Resolution = {
		ammo		="Amar Cluster",
		head		="Flam. Zucchetto +2",
		body		="Pumm. Lorica +3",
		hands		="Sulev. Gauntlets +2",
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Cessance Earring",
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	sets.ws.Upheaval = {}
	sets.ws.Upheaval.lowtp = {
		ammo		="Knobkierrie",
		head		="Agoge Mask +2",
		body		="Pumm. Lorica +3",
		hands		={ name="Odyssean Gauntlets", augments={'DEX+14','"Dbl.Atk."+1','Weapon skill damage +8%','Accuracy+9 Attack+9',}},
		legs		={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%',}},
		feet		="Sulev. Leggings +2",
		neck		="Fotia Gorget",
		waist		="Ioskeha Belt +1",
		left_ear	="Ishvara Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Niqmaddu Ring",
		right_ring	="Regal Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},	
	}
    sets.ws.Upheaval.hightp = {
		ammo		="Knobkierrie",
		head		="Agoge Mask +2",
		body		="Pumm. Lorica +3",
		hands		={ name="Odyssean Gauntlets", augments={'DEX+14','"Dbl.Atk."+1','Weapon skill damage +8%','Accuracy+9 Attack+9',}},
		legs		="Pumm. Cuisses +3",
		feet		="Pumm. Calligae +3",
		neck		="Asperity Necklace",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	sets.wsacc.Upheaval = {
		ammo		="Knobkierrie",
		head		="Agoge Mask +2",
		body		="Pumm. Lorica +3",
		hands		={ name="Odyssean Gauntlets", augments={'DEX+14','"Dbl.Atk."+1','Weapon skill damage +8%','Accuracy+9 Attack+9',}},
		legs		={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%',}},
		feet		="Sulev. Leggings +2",
		neck		="Fotia Gorget",
		waist		="Ioskeha Belt +1",
		left_ear	="Ishvara Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Niqmaddu Ring",
		right_ring	="Regal Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
    sets.ws['Impulse Drive'] = {
		ammo		="Knobkierrie",
		head		="Agoge Mask +2",
		body		="Pumm. Lorica +3",
		hands		={ name="Odyssean Gauntlets", augments={'DEX+14','"Dbl.Atk."+1','Weapon skill damage +8%','Accuracy+9 Attack+9',}},
		legs		={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%',}},
		feet		="Sulev. Leggings +2",
		neck		="Fotia Gorget",
		waist		="Flume Belt",
		left_ear	="Ishvara Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},	
	}

	sets.wsdusk = {
		left_ear	= "Lugra Earring +1"
	}
	
	sets.aggressor = {
		body		= "Agoge Lorica +1",
		head		= "Pumm. Mask +3"
	}
	sets.charge = {
		legs		= "Agoge cuisses +1"
	}
	sets.berserk = {
		body		= "Pumm. Lorica +3",
		feet		= "Agoge Calligae +1"
	}
	sets.warcry = {
		head		= "Agoge Mask +2"
	}
	
	
	sets.FC  = {
		ammo		="Sapience Orb",
		body		={ name="Odyss. Chestplate", augments={'Accuracy+24 Attack+24','Weapon skill damage +2%','DEX+4','Accuracy+12','Attack+10',}},
		hands		={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		feet		={ name="Odyssean Greaves", augments={'"Fast Cast"+5','DEX+8','Accuracy+5','Attack+10',}},
		neck		="Voltsurge Torque",
		left_ear	="Loquac. Earring",
		right_ear	="Etiolation Earring",
		left_ring	="Lebeche Ring",
		right_ring	="Rahab Ring",
	}
	sets.town = {
     
		ammo		="Staunch Tathlum +1",
		head		="Arke Zuchetto +1",
		body		="Dagon Breastplate",
		hands		="Ar. Manopolas +1",
		legs		="Arke Cosc. +1",
		feet		="Ar. Gambieras +1",
		neck		="Combatant's Torque",
		waist		="Ioskeha Belt +1",
		left_ear	="Cessance Earring",
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Niqmaddu Ring",
		back		={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }
	
 end
 
 --[[ ******************************************************
  Equip functions - put on the sets we defined above, and
 echo a note to our chat log so we know it worked.
****************************************************** --]]
 
 -- equip our idle set
 function equip_idle()
--     windower.add_to_chat(8,'[Idle]')
	if Town:contains(world.area) then
		equip(sets.town)
	else
		equip(sets.idle)
	end
end

-- equip our engaged set
function equip_engaged()
--    windower.add_to_chat(8,'[Engaged]')
    equip(sets.engaged)
end

-- equip our weapon skill set
function equip_ws(spell)
--    windower.add_to_chat(8,'[Weapon Skill]')
	if spell.name == "Resolution" then
		if world.time >= 17*60 or world.time < 7*60 then -- Dusk to Dawn time.
			if TP_ind ~= 2 then
				equip(sets.TP['Standard'],sets.ws.Resolution,sets.wsdusk)
			else
				equip(sets.TP['Standard'],sets.wsacc.Resolution,sets.wsdusk)
			end
		else
			if TP_ind ~= 2 then
				equip(sets.TP['Standard'],sets.ws.Resolution)
			else
				equip(sets.TP['Standard'],sets.wsacc.Resolution)
			end
		end
	elseif spell.name == "Upheaval" then
		if TP_ind ~= 2 then
			if player.tp < 1250 and not buffactive.Warcry then
				equip(sets.ws.Upheaval.lowtp)
			else
				equip(sets.ws.Upheaval.hightp)
			end
		else
			equip(sets.TP['Standard'],sets.wsacc.Upheaval)
		end
	elseif sets.ws[spell.name] then
		equip(sets.ws[spell.name])
	else
		equip(sets.ws.Default)
	end
end

function choose_set()
    if player.status == "Engaged" then
        equip_engaged()
    else
         equip_idle()
    end
 end
 
 function precast(spell)
     if spell.type == 'WeaponSkill' then
        equip_ws(spell)
    end
	if spell.name == 'Aggressor' then
		equip(sets.engaged,sets.aggressor)
	elseif spell.name == "Warrior's Charge" then
		equip(sets.engaged,sets.charge)
	elseif spell.name:lower() == "berserk" then
		equip(sets.engaged,sets.berserk)
	elseif spell.name:lower() == "warcry" then
		equip(sets.engaged,sets.warcry)
	end
	if spell.action_type == 'Magic' then
		equip(sets.FC)
	end
 end
 
 function midcast(spell)
 end
 
 function aftercast(spell)
     choose_set()
end

function status_change(new,old)
    choose_set()
end

function buff_change(buff,gain,btable)
	if runHasso then
		if not gain then 
			if tostring(buff) == 'Hasso' and (not buffactive.Seigan) then
				windower.send_command('input /ja Hasso <me>')
			end
		end
	end
end

-- self_command function for WAR is used to toggle weapon skills,
-- and conditionally use abilities from our /sam subjob.
function self_command(m)
	if m == 'autotp' then
		if not autotp then
			autotp = true
			windower.add_to_chat(1,'AutoWS set to On')
		else
			autotp = false
			windower.add_to_chat(1,'AutoWS set to Off')
		end
	end
	if m == 'autohasso' then
		if not runHasso then
			runHasso = true
			windower.add_to_chat(1,'AutoHasso set to On')
			windower.send_command('input /ja Hasso <me>')
		else
			runHasso = false
			windower.add_to_chat(1,'AutoHasso set to Off')
		end
	end
	if m == 'idle' then
		choose_set()
	elseif m == 'toggle' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		sets.engaged = sets.TP[sets.TP.index[TP_ind]]
		choose_set()
	elseif m == 'reverse' then
		TP_ind = TP_ind -1
		if TP_ind == 0 then TP_ind = #sets.TP.index end
		windower.add_to_chat(1,'<----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		sets.engaged = sets.TP[sets.TP.index[TP_ind]]
		choose_set()
	elseif m == 'hybriddt' then
		TP_ind = 3
		windower.add_to_chat(1,'Switched to Hybrid DT')
		sets.engaged = sets.TP[sets.TP.index[TP_ind]]
		choose_set()
	elseif m == 'fulldt' then
		TP_ind = 4
		windower.add_to_chat(1,'Switched to Full DT')
		sets.engaged = sets.TP[sets.TP.index[TP_ind]]
		choose_set()
	elseif m == 'weapon' then
		WP_ind = WP_ind +1
		if WP_ind > #sets.Weapons.index then WP_ind = 1 end
		windower.add_to_chat(1,'<----- Weapon changed to '..sets.Weapons.index[WP_ind]..' ----->')
		sets.engaged = sets.Weapons[sets.Weapons.index[WP_ind]]
		equip(sets.engaged)
	end
 end
 
 
 function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

--Set to default WAR Macro Page  (Book, Page)
set_macros(1,6)
 

 

 -- Finally, puts on our fashion set, lockstyle it, then switch to our idle set.
 send_command('wait 1;gs equip lockstyle;wait 2;input /lockstyle on;wait 2;gs c idle')
 
 
 autows = {
	['Default'] = "Freezebite",
	['Ragnarok'] = "Resolution",
	['Minos'] = "Upheaval",
	['Chango'] = "Upheaval",
	['Kaja Sword'] = "Savage Blade",
}

autotp = false	

function find_weaponskill()
	local ws = autows[player.equipment.main] or 0	
	--  Defaulting weaponskill becuase main is not in the table
	if ws == 0 then
		return autows.Default
	else
		return ws
	end
end
 
 windower.register_event('tp change', function(tp)
	if tp >= 1000 and autotp then
		local ws = find_weaponskill()
		windower.send_command('input /ws "'..ws..'" <t>')
	end
end)
	
-- Motes Function not used	
function job_self_command(commandArgs, eventArgs)
	if commandArgs[0] == 'autotp' then
		if not autotp then
			autotp = true
			windower.add_to_chat(1,'AutoWS set to On')
		else
			autotp = false
			windower.add_to_chat(1,'AutoWS set to Off')
		end
	end
end


windower.send_command('bind !f1 gs c autotp')
windower.send_command('bind !f2 gs c autohasso')
windower.send_command('bind f9 gs c toggle')
windower.send_command('bind f10 gs c hybriddt')
windower.send_command('bind f11 gs c fulldt')
windower.send_command('bind f12 gs c weapon')