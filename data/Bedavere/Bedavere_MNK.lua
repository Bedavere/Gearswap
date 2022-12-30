require("no_interruptions")

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function status_change(new,action)
	send_command('wait 6;input /lockstyleset 20')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Impetus = buffactive.Impetus or false



    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

	select_default_macro_book()
	
	state.OffenseMode:options('Normal', 'Hybrid')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Idle')

-- Function to bind keys when loading MNK script.
	send_command('bind !` input /echo GODHANDS <=> VERETHRAGNA;input /equip main Godhands;input /equip main Verethragna')
	send_command('bind ^= input /echo ASURAAAAAAAAA!!!;input /equipset 5;input /ws "Asuran Fists" <t>')
	send_command('bind ^- input /echo SHELL CRUSHERRRRR!!!;input /equipset 11;input /ws "Shell Crusher" <t>')	
	send_command('bind ^` input /equipset 19;input /echo COUNTER GEAR ON!!!')
	send_command('bind !- input /ja "Boost" <me>;input /echo BOOOOOOOOOOOOOOOOOOOOOOOOOOOOOSTU!!!!!')
	send_command('bind != input /ja "Inner Strength" <me>;input /echo INNER STRENGTH!!!')
	
	if player.sub_job == 'WAR' then
	send_command('bind !6 input /ja "Berserk" <me>;input /echo BERSERK!!!!')
	send_command('bind !5 input /ja "Aggressor" <me>;input /echo AGGRESSOR!!!!')
	send_command('bind ^7 input /ja "Warcry" <me>;input /echo WARCRY!!!!')
	elseif player.sub_job == 'NIN' then
	send_command('bind !6 input /ma "Utsusemi: Ni" <me>;input /echo UTSUSEMI:NI!!!!')
	send_command('bind !5 input /ma "Utsusemi: Ichi" <me>;input /echo UTSUSEMI:ICHI!!!!')
	elseif player.sub_job == 'DRG' then
    send_command('bind !6 input /ja "High Jump" <t>;input /echo HIGH JUMP!!!!')
	send_command('bind !5 input /ja "Jump" <t>;input /echo JUMP!!!!')
	send_command('bind ^7 input /ja "Ancient Circle" <me>;input /echo ANTI-DRAGON SHIT!!!!')
	end
	
end
	
-- Function to revert binds when unloading MNK script.
function user_unload()
	send_command('unbind !`')
	send_command('unbind ^=')
	send_command('unbind ^-')
	send_command('unbind ^`')
	send_command('unbind !-')
	send_command('unbind !=')
	send_command('unbind !6')
	send_command('unbind !5')
	send_command('unbind ^7')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
	sets.Obi = {waist="Hachirin-no-Obi"}
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
	sets.precast.JA['Boost'] = {hands="Anchor. Gloves +3", waist="Ask Sash"}
	sets.precast.JA['Focus'] = {head="Anch. Crown +3"}
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3"}
	sets.precast.JA['Mantra'] = {feet="Hes. Gaiters +3"}
	sets.precast.JA['Counterstance'] = {feet="Hes. Gaiters +3"}
	sets.precast.JA['Formless Strikes'] = {body="Hes. Cyclas +3"}
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
	sets.precast.JA['Chi Blast'] = {head="Hes. Crown +3"}
    
	sets.precast.JA['Jump'] =  {ammo="Coiste Bodhar",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Combatant's Torque",
    waist="Moonbow Belt +1",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
	left_ring="Niqmaddu Ring",
    right_ring="Ilabrat Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'])
	
    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +2%','Mag. Acc.+4','"Mag.Atk.Bns."+14',}},
	neck="Orunmila's Torque",
    body={name="Adhemar Jacket +1",bag="Wardrobe 3"},
    hands="Leyline Gloves",
	feet={ name="Herculean Boots", augments={'Pet: Crit.hit rate +3','"Fast Cast"+2','Quadruple Attack +3','Accuracy+18 Attack+18',}},
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    right_ring="Defending Ring"}

	sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads'})
	sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'])

	
    
	-- Weaponskill sets
	
    sets.precast.WS['Victory Smite'] = {
	ammo="Coiste Bodhar",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Ken. Samue +1",
    hands="Adhemar wristbands +1",                                                                                               --{ name="Ryuo Tekko +1", augments={'DEX+12','Accuracy+25','"Dbl.Atk."+4',}}
    legs="Ken. Hakama +1",
    feet="Nyame sollerets",                                                                                                     --{ name="Herculean Boots", augments={'Accuracy+18','Crit.hit rate+4','STR+10','Attack+4',}}
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear="Schere Earring",
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}}
	
	sets.precast.WS['Ascetic\'s Fury'] = set_combine(sets.precast.WS['Victory Smite'])
	
	sets.precast.WS['Howling Fist'] = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Mpaca's Cap", augments={'Path: A',}},
    body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Herculean Gloves", augments={'Pet: STR+2','Pet: Phys. dmg. taken -2%','Quadruple Attack +3','Accuracy+20 Attack+20','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet={ name="Herculean Boots", augments={'Pet: Crit.hit rate +3','"Fast Cast"+2','Quadruple Attack +3','Accuracy+18 Attack+18',}},
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','"Regen"+5',}}}
	
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS['Howling Fist'], {feet="Anchorite's Gaiters +3"})
	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS['Howling Fist'], {feet="Anchorite's Gaiters +3"})
	
	sets.precast.WS['Raging Fists'] = {    
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Mpaca's Cap", augments={'Path: A',}},
    body={ name="Tatena. Harama. +1", augments={'Path: A',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','"Regen"+5',}}}
	
	sets.precast.WS['Spinning Attack'] = {
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Ken. Jinpachi +1",
    body="Ken. Samue +1",
    hands={ name="Herculean Gloves", augments={'Pet: STR+2','Pet: Phys. dmg. taken -2%','Quadruple Attack +3','Accuracy+20 Attack+20','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
    legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
    feet={ name="Herculean Boots", augments={'Pet: Crit.hit rate +3','"Fast Cast"+2','Quadruple Attack +3','Accuracy+18 Attack+18',}},
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','"Regen"+5',}}}
	
	sets.precast.WS['Asuran Fists'] = {
    ammo="Aurgelmir Orb +1",
    head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
    body={ name="Hes. Cyclas +3", augments={'Enhances "Formless Strikes" effect',}},
    hands={ name="Hes. Gloves +3", augments={'Enhances "Invigorate" effect',}},
    legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
    feet={ name="Hes. Gaiters +3", augments={'Enhances "Mantra" effect',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear="Telos Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','"Regen"+5',}}}
	
	sets.precast.WS['Shijin Spiral'] = {
	ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Ken. Jinpachi +1",
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Ken. Sune-Ate +1",
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear={ name="Schere Earring", augments={'Path: A',}},
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
	
	sets.precast.WS['Cataclysm'] = {
	ammo="Knobkierrie",
    head="Pixie Hairpin +1",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Moonbow Belt +1",
    left_ear="Friomisi Earring",
    right_ear="Ishvara Earring",
    left_ring="Epaminondas's Ring",
    right_ring="Archon Ring",
    back={ name="Segomo's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%',}}}
	
	sets.precast.WS['Shell Crusher'] = {
	ammo="Knobkierrie",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Sanctity Necklace",
    waist="Fotia Belt",
    left_ear="Digni. Earring",
    right_ear="Crep. Earring",
    left_ring="Crepuscular Ring",
    right_ring="Stikini Ring +1",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
    
	sets.precast.WS['Final Heaven'] = {} --lol
	
    -- Midcast Sets

    -- Sets to return to when not performing an action.
	
	sets.Kiting = {
	ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body={ name="Hes. Cyclas +3", augments={'Enhances "Formless Strikes" effect',}},
    hands={ name="Rao Kote +1", augments={'MND+12','Mag. Evasion+20','Magic dmg. taken -5',}},
    legs="Malignance Tights",
    feet="Hermes' Sandals",
    neck="Sanctity Necklace",
    waist="Moonbow Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Etiolation Earring",
    left_ring="Karieyh Ring +1",
    right_ring="Defending Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}

    -- Idle sets
	
	sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Rao Kabuto +1",
    body="Mpaca's Doublet",
    hands="Malignance gloves",
    legs="Malignance tights",
    feet="Hermes' Sandals",
    neck="Sanctity Necklace",
    waist="Moonbow Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Etiolation Earring",
    left_ring="Karieyh Ring +1",
    right_ring="Defending Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','"Regen"+5',}}}
	
	sets.idle.PDT = {
	ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body={ name="Hes. Cyclas +3", augments={'Enhances "Formless Strikes" effect',}},
    hands={ name="Rao Kote +1", augments={'MND+12','Mag. Evasion+20','Magic dmg. taken -5',}},
    legs="Malignance Tights",
    feet="Hermes' Sandals",
    neck="Sanctity Necklace",
    waist="Moonbow Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Etiolation Earring",
    left_ring="Karieyh Ring +1",
    right_ring="Defending Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
	
    
    -- Defense sets

    sets.defense.PDT = {
	ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Ken. Sune-Ate +1",
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Defending Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}

    -- Engaged sets

	sets.engaged = {
	ammo="Coiste Bodhar",
    head="Ken. Jinpachi +1",
    body="Mpaca's Doublet",
    hands={ name="Herculean Gloves", augments={'Pet: STR+2','Pet: Phys. dmg. taken -2%','Quadruple Attack +3','Accuracy+20 Attack+20','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
    legs="Ken. Hakama +1",
    feet={ name="Herculean Boots", augments={'Pet: Crit.hit rate +3','"Fast Cast"+2','Quadruple Attack +3','Accuracy+18 Attack+18',}},
    neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Schere Earring",
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
	
	sets.engaged.Hybrid = set_combine(sets.defense.PDT)

    sets.impetus_body = {body="Bhikku Cyclas +1"}
    sets.footwork_kick_feet = {feet="Anchorite's Gaiters +3"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
		if (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then 
			if buffactive.impetus and info.impetus_hit_count > 11 then
				equip(sets.impetus_body, {right_ear="Sherida Earring"})
			end
        elseif spell.english == 'Cataclysm' then 
			if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
				equip({waist="Hachirin-no-Obi"}) else
				equip({waist="Orpheus's Sash"})
			end
        end
	end
end



function job_buff_change(buff, gain)
	if buffactive['Boost'] then
		equip{waist="Ask Sash"}
	else 
		handle_equipping_gear(player.status)
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function customize_melee_set(meleeSet)
	if state.DefenseMode.value ~= 'Physical'  then
		if buffactive.impetus then
			if state.OffenseMode.value == 'Hybrid' then
				meleeSet= set_combine(meleeSet, sets.impetus_body, {hands="Nyame Gauntlets"}, {ammo="Crepuscular Pebble"})
			elseif state.OffenseMode.value == 'Normal' then
				meleeSet= set_combine(meleeSet, sets.impetus_body)
			end
		end
	end	
	return meleeSet
end


function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.interrupted then
		if buffactive['Sleep'] or buffactive['Stun'] or buffactive['Silence'] or buffactive['Petrify'] then
			handle_equipping_gear(player.status)
		end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


-- Select default macro book on initial load or subjob change.

function select_default_macro_book()
        set_macro_page(1, 3)
end




-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
    
end
