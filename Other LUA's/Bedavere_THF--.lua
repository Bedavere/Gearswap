require("no_interruptions")

function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end
set_macros(1,3) -- Sheet, Book <<<<<<<<<<<<<<<<<<<<<<<************

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'DT', 'LowHaste')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.IdleMode:options('Normal', 'Flash')

    gear.default.weaponskill_neck = "Fotia Gorget"
    gear.default.weaponskill_waist = "Fotia Belt"
    

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
	sets.midcast['Horde Lullaby'] = sets.TreasureHunter
	
    sets.TreasureHunter = {ammo="Ginsen",
    head="Wh. Rarab Cap +1",
    body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
    hands={ name="Plun. Armlets +1", augments={'Enhances "Perfect Dodge" effect',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet="Skulk. Poulaines +1",
    neck="Bathy Choker",
    waist="Chaac Belt",
    left_ear="Sherida Earring",
    right_ear="Cessance Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}},
}
    sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    sets.Kiting = {feet="Jute Boots +1"}
	
	--Equipped when SneakAttack Active
    sets.buff['Sneak Attack'] = {
	ammo="Yetshila +1",
    head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
    feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+4','Attack+5',}},
    neck="Caro Necklace",
    waist="Grunfeld Rope",
    left_ear="Sherida Earring",
    right_ear="Mache Earring",
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}
	--Equipped when TrickAttack Active
    sets.buff['Trick Attack'] = {
	ammo="Yetshila +1",
    head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +2",
    neck="Moepapa Medal",
    waist="Svelt. Gouriz +1",
    left_ear="Sherida Earring",
    right_ear="Dawn Earring",
    left_ring="Ilabrat Ring",
    right_ring="Garuda Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = {head="Plunderer's Bonnet",hands="Pillager's Armlets +1",legs="Pillager's Culottes +1",feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Felistris Mask",ear1="Oneiros Earring",ear2="Enchanter Earring +1",
        body="Emet Harness",hands="Buremte Gloves",ring1="Asklepian Ring",ring1="Valseur's Ring",
        back="Aisance Mantle +1",waist="Chuq'aba Belt",legs="Rawhide Trousers",feet="Wayfarer Clogs"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
	ammo="Sapience Orb",
    head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +3%','Accuracy+10',}},
    body={ name="Adhemar Jacket", augments={'HP+80','"Fast Cast"+7','Magic dmg. taken -3',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Mummu Kecks +2",
    feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+14','"Triple Atk."+1','"Fast Cast"+7','Accuracy+15 Attack+15','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    neck="Baetyl Pendant",
    waist="Chaac Belt",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}

    sets.precast.FC.Utsusemi = sets.precast.FC


    -- Ranged snapshot gear
    sets.precast.RA = {head="Aurore Beret",hands="Iuitl Wristbands",legs="Nahtirah Trousers",feet="Wurrukatte Boots"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +3','Pet: INT+10','Weapon skill damage +10%','Accuracy+2 Attack+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    feet={ name="Herculean Boots", augments={'MND+2','CHR+5','Quadruple Attack +3','Accuracy+2 Attack+2',}},
    neck="Caro Necklace",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
}
    

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = {
	ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +3','Pet: INT+10','Weapon skill damage +10%','Accuracy+2 Attack+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    feet={ name="Herculean Boots", augments={'MND+2','CHR+5','Quadruple Attack +3','Accuracy+2 Attack+2',}},
    neck="Caro Necklace",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
}
    

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {})
    

    sets.precast.WS['Evisceration'] = {
	ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +3','Pet: INT+10','Weapon skill damage +10%','Accuracy+2 Attack+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    feet={ name="Herculean Boots", augments={'MND+2','CHR+5','Quadruple Attack +3','Accuracy+2 Attack+2',}},
    neck="Caro Necklace",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
}

    sets.precast.WS["Rudra's Storm"] = {
	ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Meg. Cuirie +2",
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +3','Pet: INT+10','Weapon skill damage +10%','Accuracy+2 Attack+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    feet={ name="Herculean Boots", augments={'MND+2','CHR+5','Quadruple Attack +3','Accuracy+2 Attack+2',}},
    neck="Caro Necklace",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}},
}

    sets.precast.WS["Shark Bite"] = sets.precast.WS
   

    sets.precast.WS['Mandalic Stab'] = sets.precast.WS


    sets.precast.WS['Aeolian Edge'] = {
	ammo="Seeth. Bomblet +1",
    head={ name="Herculean Helm", augments={'Accuracy+3 Attack+3','Weapon skill damage +4%','STR+15',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
    feet={ name="Herculean Boots", augments={'"Triple Atk."+4','Accuracy+14',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Ishvara Earring",
    right_ear="Friomisi Earring",
    left_ring="Ilabrat Ring",
    right_ring="Dingir Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
}

   -- sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)--


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
	ammo="Staunch Tathlum",
    head="Meghanada Visor +2",
    body="Meg. Cuirie +2",
    hands="Kurys Gloves",
    legs="Meg. Chausses +2",
    feet="Ahosi Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}

	sets.idle.Flash = {
	ammo="Yamarang",
    head="Pill. Bonnet +3",
    body="Pillager's Vest +3",
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs="Mummu Kecks +2",
    feet="Meg. Jam. +2",
    neck="Loricate Torque +1",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Regal Ring",
    back="Moonbeam Cape",
}

    sets.idle.Town = {
	ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands="Turms Mittens +1",
    legs="Mummu Kecks +2",
    feet="Turms Leggings +1",
    neck="Loricate Torque +1",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','"Regen"+5',}},
}

    sets.idle.Weak = {
	ammo="Staunch Tathlum",
    head="Meghanada Visor +2",
    body="Meg. Cuirie +2",
    hands="Kurys Gloves",
    legs="Meg. Chausses +2",
    feet="Ahosi Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}


    -- Defense sets

    sets.defense.Evasion = {}

    sets.defense.PDT = {}

    sets.defense.MDT = {}


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
    ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands="Turms Mittens +1",
    legs="Mummu Kecks +2",
    feet="Turms Leggings +1",
    neck="Loricate Torque +1",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','"Regen"+5',}},
}
        
    -- Mod set for trivial mobs (Skadi+1)
    sets.engaged.Acc = {
    ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands="Turms Mittens +1",
    legs="Mummu Kecks +2",
    feet="Turms Leggings +1",
    neck="Loricate Torque +1",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','"Regen"+5',}},
}

    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.DT = {
	ammo="Yamarang",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands="Turms Mittens +1",
    legs="Mummu Kecks +2",
    feet="Turms Leggings +1",
    neck="Loricate Torque +1",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','"Regen"+5',}},
}

	sets.engaged.LowHaste = {
	ammo="Yamarang",
    head="Skulker's Bonnet +1",
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+30','"Triple Atk."+4','Attack+5',}},
    neck="Erudit. Necklace",
    waist="Reiki Yotai",
    left_ear="Sherida Earring",
    right_ear="Suppanomimi",
    left_ring="Hetairoi Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+5','"Store TP"+10',}},
}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    --if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        --equip(sets.TreasureHunter)
    if spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end




