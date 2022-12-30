require("no_interruptions")

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Barrage = buffactive.Barrage or false
    state.Buff.Camouflage = buffactive.Camouflage or false
    state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
    state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
    state.Buff['Double Shot'] = buffactive['Double Shot'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','dwNormal')
    state.HybridMode:options('Normal','DT')
    state.RangedMode:options('Normal','Acc','Critical')
    state.WeaponskillMode:options('Normal')
    state.IdleMode:options('Normal', 'DT')
	set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
end

-- Set up all gear sets.
function init_gear_sets()
	-- Augmented Gear
	Belenus = {}
	Belenus.mSTP = {name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10'}}
	Belenus.Trueflight = {name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','"Weapon skill damage +10%',}}
	Belenus.LastStand = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	Belenus.Savage = {name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','"Weapon skill damage +10%',}}
	Belenus.Midshot = {name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	Belenus.Snapshot = {name="Belenus's Cape", augments={'"Snapshot"+10'}}
	Belenus.FC = {name="Belenus's Cape", augments={'"Fast Cast"+10',}}
	Belenus.Jishnu = {name="Belenus's Cape", augments={'DEX+20','Rng.Acc.+20 Rng.Atk.+20','Crit.hit rate+10'}}
	
	HercFeet = {}
	HercFeet.TP = {name="Herculean Boots",augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+10','Accuracy+11'}}
	HercFeet.CRIT = {name="Herculean Boots",augments={'Accuracy+25 Attack+25','Crit. hit damage +5%','DEX+7','Accuracy+12'}}

    -- Precast sets to enhance JAs
    sets.precast.JA['Eagle Eye Shot'] = {legs="Arcadian Braccae +3"}
    sets.precast.JA['Bounty Shot'] = {hands="Amini Glove. +1",wait="Chaac Belt",legs="Volte Hose"}
    sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
    sets.precast.JA['Scavenge'] = {feet="Orion Socks +2"}
    sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +2"}
    sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +2"}
	
    -- Fast cast sets for spells
    sets.precast.FC = {neck="Carmine Mask +1",
	neck="Orunmila's Torque",
	ear1="Loquac. Earring",
	ear2="Etiolation Earring",
	hands="Leyline Gloves",
	ring1="Rahab Ring"}
    
	sets.precast.FC.Utsusemi = sets.precast.FC
    
	sets.precast.RA = {
	head="Amini Gapette +1",
	neck="Scout's Gorget +2",
	body="Amini Caban +1",
	hands="Carmine Fin. Ga. +1",
	ring2="Crepuscular Ring",
	back=Belenus.Snapshot,
	waist="Yemaya Belt",
	legs="Adhemar Kecks",
	feet="Meg. Jam. +2"}
	
	sets.precast.RA.F1 = set_combine(sets.precast.RA, {
	head="Amini Gapette +1",  --Change to Orion Bracae +3
	legs="Adhemar Kecks"})
	
	sets.precast.RA.F2 = set_combine(sets.precast.RA.F1, {
	waist="Yemaya Belt",
	feet="Meg. Jam. +2"}) --Change to Acrcadian Socks +3
	
	sets.precast.RA.Gastraphetes = {
	head="Orion Beret +3",
	neck="Scout's Gorget +2",
	body="Amini Caban +1",
	hands="Carmine Fin. Ga. +1",
	back=Belenus.Snapshot,
	waist="Impulse Belt",
	legs="Orion Braccae +2",
	feet="Meg. Jam. +2"}
	
	sets.precast.RA.F1.Gastraphetes = set_combine(sets.precast.RA.Gastraphetes, {
	legs="Adhemar Kecks +1",
	feet="Arcadian Socks +3"})
	
	sets.precast.RA.F2.Gastraphetes = set_combine(sets.precast.RA.F1.Gastraphetes, {
	waist="Yemaya Belt"})
	
	-- Weaponskill Sets
	sets.precast.WS = {}
    
	sets.precast.WS['Last Stand'] = {
	head="Nyame helm",
	neck="Fotia gorget",
	ear1="Ishvara Earring",
	ear2="Moonshade Earring",
	body="Nyame Mail",
	hands="Meghanada Gloves +2",
	ring1="Regal Ring",
	ring2="Epaminondas's Ring",
	back=Belenus.LastStand,
	waist="Fotia Belt",
	legs="Nyame flanchard",
	feet="Nyame Sollerets"}
	
	sets.precast.WS['Coronach'] = set_combine(sets.precast.WS["Last Stand"], {ear1="Odr Earring",ear2="Sherida Earring"})
	
	sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS["Last Stand"], {waist="Tellen Belt",feet="Ikenga's Clogs"})
	
	sets.precast.WS['Refulgent Arrow'] = set_combine(sets.precast.WS["Last Stand"], {waist="Tellen Belt",feet="Ikenga's Clogs"})
	
	sets.precast.WS['Empyreal Arrow'] = set_combine(sets.precast.WS["Last Stand"], {waist="Tellen Belt",feet="Ikenga's Clogs"})	
	
	sets.precast.WS['Trueflight'] = {  --Needs Edited
	head=empty,
	neck="Scout's Gorget +2",
	ear1="Friomisi Earring",
	ear2="Moonshade Earring",
	body="Cohort Cloak +1",
	hands="Nyame Gauntlets",
	ring1="Weatherspoon Ring",
	ring2="Dingir Ring",
	back=Belenus.Trueflight,
	waist="Orpheus's Sash",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"}
	
	sets.precast.WS['Aeolian Edge'] = {  --Needs Edited
	head="Nyame Helm",
	neck="Scout's Gorget +2",
	ear1="Friomisi Earring",
	ear2="Moonshade Earring",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	ring1="Metamorph Ring +1",
	ring2="Dingir Ring",
	back=Belenus.Trueflight,
	waist="Orpheus's Sash",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"}	
	
	sets.precast.WS['Trueflight'].FullTP = set_combine(sets.precast.WS["Trueflight"], {ear2="Ishvara Earring"})
	
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS["Trueflight"], {ring1="Epaminondas's Ring",ear2="Ishvara Earring"})	
	
	sets.precast.WS['Jishnu\'s Radiance'] = {
	head="Adhemar Bonnet +1",
	neck="Fotia Gorget",
	ear1="Sherida Earring",
	ear2="Odr Earring",
	body="Meg. Cuirie +2",
	hands="Mummu Wrists +2",
	ring1="Regal Ring",
	ring2="Mummu Ring",
	back=Belenus.LastStand,
	waist="Fotia Belt",
	legs="Jokushu Haidate",
	feet="Ikenga's Clogs"}  --Need Feet
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS["Last Stand"], {
	head="Nyame Helm",
	neck="Caro necklace",
	body="Nyame Mail",
	hands="Nyame Gauntlets",
	back=Belenus.Savage,
	waist="Sailfi Belt +1",
	legs="Nyame Flanchard",
	feet="Nyame Sollerets"})
	
    -- Fast recast for spells
    sets.midcast.FastRecast = sets.precast.FC

    -- Ranged sets
    sets.midcast.RA = {
	head="Malignance chapeau",
	neck="Iskur Gorget",
	ear2="Telos Earring",
	ear1="Beyla Earring",
	body="Nisroch Jerkin",
	hands="Meg. Gloves +2",
	ring1="Regal Ring",
	ring2="Cacoethic Ring",
	back=Belenus.Midshot,
	waist="Yemaya Belt",
	legs="Malignance tights",
	feet="Malignance boots"}
   
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
	head="Malignance chapeau", --Orion Beret +3
	waist="Yemaya Belt", --K. Kachina Belt +1
	feet="Malignance tights"})
    
	sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
	ear2="Enervating Earring",
	ring1="Mummu Ring",
	ring2="Dingir Ring",
	waist="Yemaya Belt", --K. Kachina Belt +1
	legs="Mummu Kecks +2",
	feet="Osh. Leggings +1"})
	
	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {
	hands="Orion Bracers +2",
	ring2="Dingir Ring"})
    
	sets.buff.Camouflage = {
	head="Meghanada Visor +2",
	neck="Scout's Gorget +2",
	ear1="Telos Earring",
	ear2="Enervating Earring",
	body="Meg. Cuirie +2",
	hands="Kobo Kote",
	ring1="Ilabrat Ring",
	ring2="Begrudging Ring",
	back=Belenus.Midshot,
	waist="K. Kachina Belt +1",
	legs="Darraigner's Brais",
	feet="Osh. Leggings +1"}
    
	sets.DoubleShot = set_combine(sets.midcast.RA, {
	head="Oshosi Mask +1",
	body="Oshosi Vest +1",
--	hands="Oshosi Gloves +1",
	legs="Oshosi Trousers +1",
	feet="Oshosi Leggings +1"})

    -- Idle sets
    sets.idle = {
	head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Warder's Charm",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Infused Earring",
    left_ring="Regal Ring",
    right_ring="Defending Ring",
    back="Moonlight Cape"}
    
	sets.idle.DT = set_combine(sets.idle, {
	ring1="Gelatinous Ring +1"})
    
	sets.idle.Town = sets.idle

    -- Engaged sets
    sets.engaged = {
	head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Sherida Earring",
	ear2="Telos Earring",
	body="Adhemar Jacket +1",
	hands="Adhemar wristbands +1",
	ring1="Petrov Ring",
	ring2="Ilabrat Ring",
	back=Belenus.mSTP,
	waist="Olseni Belt",
	legs="Malignance Tights",
	feet="Malignance Boots"}
    
	sets.engaged.dwNormal = {
	head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Sherida Earring",
	ear2="Telos Earring",
	body="Adhemar Jacket +1",
	hands="Adhemar wristbands +1",
	ring1="Petrov Ring",
	ring2="Ilabrat Ring",
	back=Belenus.mSTP,
	waist="Olseni Belt",
	legs="Malignance Tights",
	feet="Malignance Boots"}
	
	sets.engaged.DT = set_combine(sets.engaged, {
	head="Meghanada Visor +2",
	neck="Loricate Torque +1",
	ear2="Odnowa Earring +1",
	body="Meg. Cuirie +2",
	hands="Meg. Gloves +2",
	ring1="Defending Ring",
	waist="Flume Belt +1",
	legs="Volte Tights",
	feet="Volte Spats"})

	-- Special Sets
    sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {})
    
	sets.buff.Doom = {neck="Nicander's Necklace",ring1="Eshmun's Ring",ring2="Eshmun's Ring",waist="Gishdubar Sash"}
    
	sets.Obi = {waist="Hachirin-no-Obi"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Safety checks for weaponskills 
	if spell.type:lower() == 'weaponskill' then
		if player.tp < 1000 then
				eventArgs.cancel = true
				return
		end
		if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
			-- Cancel Action if distance is too great, saving TP
			add_to_chat(122,"Outside WS Range!")
			eventArgs.cancel = true
			return
		end
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		if BuffFlurry == 0 then 
			equip(sets.precast.RA)
			if sets.precast.RA[player.equipment.range] then
				equip(sets.precast.RA[player.equipment.range])
			end
		end
		if BuffFlurry == 1 then
			equip(sets.precast.RA.F1)
			if sets.precast.RA.F1[player.equipment.range] then
				equip(sets.precast.RA.F1[player.equipment.range])
			end
		elseif BuffFlurry == 2 then
			equip(sets.precast.RA.F2)
			if sets.precast.RA.F2[player.equipment.range] then
				equip(sets.precast.RA.F2[player.equipment.range])
			end
		end
	end
	-- Equip obi if weather/day matches for WS.
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Trueflight' then
            if world.weather_element == 'Light' or world.day_element == 'Light' then
                equip(sets.Obi)
            end
            if player.tp > 2900 then
                equip(sets.precast.WS["Trueflight"].FullTP)
            end
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
            end
        end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if buffactive['Double Shot'] then
            equip(sets.DoubleShot)
        end
        if state.Buff.Barrage then
            equip(sets.buff.Barrage)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english == "Shadowbind" then
        send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
function job_buff_change(buff,gain)
	if not gain and buff == "Flurry" then
		BuffFlurry = 0
	end
	if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end
	if buff:lower() == 'petrification' then
		if gain then
			send_command('@input /p Stona')
		end
	end
	if buff:lower() == 'paralysis' then
		if gain then
			send_command('@input /p Paralyna')
		end
	end
	if buff:lower() == 'slow' then
		if gain then
			send_command('@input /p Erase - Slowed')
		end
	end
	if buff:lower() == 'blindness' then
		if gain then
			send_command('@input /p Blindna')
		end
	end
	if buff:lower() == 'sleep' then
		if gain then
			send_command('@input /p zzz')
		end
	end
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current..'/'..state.RangedMode.current
    msg = msg .. ' ][ WS: '..state.WeaponskillMode.current
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ' ][ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end
    msg = msg .. ' ]'
    add_to_chat(060, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
	
function set_lockstyle()
    send_command('wait 7; input /lockstyleset 199')
end

Flurrylevels = {[845] = 1,[846] = 2}
BuffFlurry = 0

windower.register_event('action', function(act)
        playerId = windower.ffxi.get_player().id
        for k,v in ipairs(act.targets) do
            if windower.ffxi.get_player().id == v.id then
				if act.param == 845 or act.param == 846 then
					BuffFlurry = Flurrylevels[act.param]
				end
            end
        end
    end)
	
autows = {
    ['Default'] = "",
    ['Fomalhaut'] = "Last Stand",
    ['Annihilator'] = "Coronach",
	['Yoichinoyumi'] = "Namas Arrow",
	['Gastraphetes'] = "Trueflight",
	['Sparrowhawk +2'] = "Savage Blade"}

autows_tp = {
    ['Fomalhaut'] = 1250,
	['Annihilator'] = 1000,
	['Yoichinoyumi'] = 1250,
	['Gastraphetes'] = 1250,
	['Sparrowhawk +2'] = 1000}
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
	tp_range = autows_tp[player.equipment.main] or 1000
    if tp >= tp_range and autotp then
        local ws = find_weaponskill()
        windower.send_command('input /ws "'..ws..'" <t>')
    end
end)