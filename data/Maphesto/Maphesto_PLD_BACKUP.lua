-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false

	include('Mote-TreasureHunter')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')

    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()

    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Exp ring shit
--XP CP Rings
rings = L{"Vocation Ring","Trizek Ring","Capacity Ring","Undecennial Ring","Decennial Ring","Allied Ring","Novennial Ring","Kupofried's Ring","Anniversary Ring",
    "Emperor Band","Empress Band","Chariot Band","Duodec. Ring","Expertise Ring"}
rings_count = 3 --set this to the ring # in rings you want to use
function get_item_next_use(name)--returns time that you can use the item again
    for _,n in pairs({"inventory","wardrobe"}) do
        for _,v in pairs(gearswap.items[n]) do
            if type(v) == "table" and v.id ~= 0 and gearswap.res.items[v.id].en == name then
                return gearswap.extdata.decode(v)
            end
        end
    end
end
function xp_cp_ring_equip(ring)--equips given ring
     if auto_ring then
         enable("left_ring")
         gearswap.equip_sets('equip_command',nil,{left_ring=ring})
         disable("left_ring")
     end
end
function schedule_xpcp_ring()--schedules equip of selected ring
    local ring_time = os.time(os.date("!*t", get_item_next_use(rings[rings_count]).next_use_time))-os.time()
    if type(xpcpcoring) == "thread" then
        coroutine.close(xpcpcoring)
    end
    xpcpcoring = coroutine.schedule(xp_cp_ring_equip:prepare(rings[rings_count]),(ring_time > 0 and ring_time or 1))
end
function check_ring_buff()-- returs true if you do not have the buff from xp cp ring
    local xpcprings = {cp=S{"Vocation Ring","Trizek Ring","Capacity Ring"},
                       xp=S{"Undecennial Ring","Decennial Ring","Allied Ring","Novennial Ring","Kupofried's Ring","Anniversary Ring","Emperor Band",
                            "Empress Band","Chariot Band","Duodec. Ring","Expertise Ring"}}
    if xpcprings.xp:contains(rings[rings_count]) and buffactive['Dedication'] == (check_in_party("Kupofried") and 1 or nil) then
        return true
    elseif xpcprings.cp:contains(rings[rings_count]) and not buffactive['Commitment'] then
        return true
    end
    return false
end
auto_ring = true --switch this to true to auto use your ring
function buff_change(name,gain,buff_table)
    if S{'Commitment','Dedication'}:contains(name) and auto_ring then
        if gain then
            enable("left_ring")
        else
            schedule_xpcp_ring()
        end
    end
end
function aftercast(status,current_event,spell)
    if auto_ring then
        if rings:contains(player.equipment.left_ring) then
            send_command('wait 3.0;input /item "'..player.equipment.left_ring..'" <me>')
        end
    end
end

-- end exp ring


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Caballarius Breeches +1"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +1"}
    sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings"}
    sets.precast.JA['Rampart'] = {head="Caballarius Coronet +1"}
    sets.precast.JA['Fealty'] = {body="Caballarius Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Creed Sabatons +2"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		ammo		="Staunch Tathlum +1",
		head		="Sulevia's Mask +2",
		body		="Dagon Breast.",
		hands		={ name="Cab. Gauntlets +1", augments={'Enhances "Chivalry" effect',}},
		legs		="Sulev. Cuisses +2",
		feet		="Ar. Gambieras +1",
		neck		="Phalaina Locket",
		waist		="Nierenschutz",
		left_ear	="Nourish. Earring +1",
		right_ear	="Lifestorm Earring",
		left_ring	="Rufescent Ring",
		right_ring	="Perception Ring",
		back		={ name="Rudianos's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Enmity+10',}},
}

	-- Treasure Hunter
	sets.TreasureHunter = {
		waist		="Chaac Belt",
		head		="Wh. Rarab Cap +1",
}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo		="Staunch Tathlum +1",
		head		="Sulevia's Mask +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Sulev. Cuisses +2",
		feet		="Sulev. Leggings +2",
		neck		="Unmoving Collar +1",
		waist		="Chaac Belt",
		left_ear	="Handler's Earring",
		right_ear	="Handler's Earring +1",
		left_ring	="Petrov Ring",
		right_ring	="Regal Ring",
		back		={ name="Rudianos's Mantle", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Enmity+10',}},
}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells

    sets.precast.FC = {
		ammo		="Sapience Orb",
		head		={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body		="Rev. Surcoat +3",
		hands		={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs		={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+7','Breath dmg. taken -3%',}},
		feet		={ name="Odyssean Greaves", augments={'"Fast Cast"+5','DEX+8','Accuracy+5','Attack+10',}},
		neck		="Voltsurge Torque",
		left_ear	="Etiolation Earring",
		right_ear	="Loquac. Earring",
		left_ring	="Kishar Ring",
		right_ring	="Rahab Ring",
		back		={ name="Rudianos's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},
}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo		="Amar Cluster",
		head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
		body		="Dagon Breast.",
		hands		={ name="Odyssean Gauntlets", augments={'Weapon skill damage +5%','VIT+10','Accuracy+14','Attack+2',}},
		legs		={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%',}},
		feet		="Sulev. Leggings +2",
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Ishvara Earring",
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Rufescent Ring",
		back		="Grounded Mantle",
}

    sets.precast.WS.Acc = {
		ammo		="Amar Cluster",
		head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
		body		="Dagon Breast.",
		hands		="Flam. Manopolas +2",
		legs		="Sulev. Cuisses +2",
		feet		="Sulev. Leggings +2",
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Ishvara Earring",
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Rufescent Ring",
		back		="Grounded Mantle",
}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Leviathan Ring",ring2="Aquasoul Ring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Leviathan Ring"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
      ammo="Jukukik Feather", head="Lustratio Cap", hands="Buremte Gloves"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {
      ammo="Jukukik Feather", head="Lustratio Cap", hands="Buremte Gloves"})

    sets.precast.WS['Savage Blade'] = {
		ammo		="Amar Cluster",
		head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Crit. hit damage +3%','STR+5','Accuracy+8','Attack+8',}},
		body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
		hands		={ name="Odyssean Gauntlets", augments={'Weapon skill damage +5%','VIT+10','Accuracy+14','Attack+2',}},
		legs		={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%',}},
		feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Ishvara Earring",
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Rufescent Ring",
		back		={ name="Weard Mantle", augments={'VIT+1','DEX+1','Enmity+3','Phalanx +4',}},
}

    sets.precast.WS['Sanguine Blade'] = {ammo="Ginsen",
        head="Reverence Coronet +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Phorcys Korazin",hands="Reverence Gauntlets",ring1="Fenrir Ring",ring2="Fenrir Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Miki. Cuisses",feet="Reverence Leggings +1"}

    sets.precast.WS['Atonement'] = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck=gear.ElementalGorget,ear1="Creed Earring",ear2="Steelflash Earring",
        body="Phorcys Korazin",hands="Reverence Gauntlets",ring1="Rajas Ring",ring2="Vexer Ring",
        back="Fierabras's Mantle",waist="Fotia Belt",legs="Ogier's Breeches",feet="Caballarius Leggings"}

	sets.precast.WS['Aeolian Edge'] = {ammo="Ginsen",
        head="Reverence Coronet +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Phorcys Korazin",hands="Reverence Gauntlets",ring1="Fenrir Ring",ring2="Fenrir Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Miki. Cuisses",feet="Reverence Leggings +1"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Chevalier's Armet",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets",
        waist="Zoran's Belt",legs="Enif Cosciales",feet="Carmine Greaves"}

    sets.midcast.Enmity = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Invidia Torque",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets",ring1="Vexer Ring",
        back="Fierabras's Mantle",waist="Goading Belt",legs="Reverence Breeches +1",feet="Caballarius Leggings"}

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Enif Cosciales"})

    sets.midcast.Stun = sets.midcast.Flash

    sets.midcast.Cure = {ammo="Iron Gobbet",
		head="Chevalier's Armet",neck="Diemer Gorget",ear1="Nourishing Earring +1",ear2="Ethereal Earring",
		body="Reverence Surcoat +1",hands="Buremte Gloves",ring1="K'ayres Ring",ring2="Meridian Ring",
		back="Weard Mantle",waist="Creed Baudrier",legs="Souveran Diechlings",feet="Souveran Schuhs"}

    sets.midcast['Enhancing Magic'] = {neck="Colossus's Torque",waist="Olympus Sash",legs="Carmine Greaves"}

    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}

	sets.midcast.Phalanx = {hands="Souveran Handschuhs", back="Weard Mantle", feet="Souveran Schuhs"}

  sets.midcast.Reprisal = {hands="Souveran Handschuhs", ring1="K'ayres Ring",ring2="Meridian Ring", back="Weard Mantle", feet="Souveran Schuhs"}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}

    sets.resting = {neck="Creed Collar", body="Respite Cloak",
        ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}


    -- Idle sets
    sets.idle = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Creed Collar",ear1="Trux Earring",ear2="Ethereal Earring",
        body="Caballarius Surcoat +1",hands="Souveran Handschuhs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Shadow Mantle",waist="Nierenschutz",legs="Crimson Cuisses",feet="Kaiser Schuhs"}

    sets.idle.Town = {main="Anahera Sword",ammo="Incantor Stone",
        head="Reverence Coronet +1",neck="Creed Collar",ear1="Trux Earring",ear2="Ethereal Earring",
        body="Caballarius Surcoat +1",hands="Souveran Handschuhs",ring1="Sheltered Ring",ring2="Defending Ring",
        back="Shadow Mantle",waist="Nierenschutz",legs="Crimson Cuisses",feet="Kaiser Schuhs"}

    sets.idle.Weak = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Creed Collar",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Souveran Handschuhs",ring1="Sheltered Ring",ring2="Meridian Ring",
        back="Fierabras's Mantle",waist="Nierenschutz",legs="Crimson Cuisses",feet="Souveran Schuhs"}

    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)

    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------

    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Creed Collar",waist="Nierenschutz"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Nierenschutz",back="Repulse Mantle"}

    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Anahera Sword",sub="Killedar Shield"} -- Ochain
    sets.MagicalShield = {main="Anahera Sword",sub="Beatific Shield +1"} -- Aegis

    -- Basic defense sets.

    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Twilight Torque",ear1="Creed Earring",ear2="Ethereal Earring",
        body="Caballarius Surcoat +1",hands="Souveran Handschuhs",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Nierenschutz",legs="Caballarius Breeches +1",feet="Souveran Schuhs"}
    sets.defense.HP = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",hands="Souveran Handschuhs",ring1="Defending Ring",ring2="Meridian Ring",
        back="Weard Mantle",waist="Creed Baudrier",legs="Souveran Diechlings",feet="Souveran Schuhs"}
    sets.defense.Reraise = {ammo="Iron Gobbet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Twilight Mail",hands="Souveran Handschuhs",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Weard Mantle",waist="Nierenschutz",legs="Caballarius Breeches +1",feet="Reverence Leggings +1"}
    sets.defense.Charm = {ammo="Iron Gobbet",
        head="Reverence Coronet +1",neck="Lavalier +1",ear1="Creed Earring",ear2="Buckler Earring",
        body="Caballarius Surcoat +1",hands="Souveran Handschuhs",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Nierenschutz",legs="Caballarius Breeches +1",feet="Reverence Leggings +1"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {ammo="Demonry Stone",
        head="Reverence Coronet +1",neck="Warder's Charm",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Caballarius Surcoat +1",hands="Souveran Handschuhs",ring1="Defending Ring",ring2="Shadow Ring",
        back="Mubvumbamiri mantle",waist="Creed Baudrier",legs="Souveran Diechlings",feet="Reverence Leggings +1"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
        head		="Reverence Coronet +1",neck="Twilight Torque",ear1="Trux Earring",ear2="Ethereal Earring",
		ammo		="Ginsen",
		head		="Flam. Zucchetto +2",
		body		="Dagon Breast.",
		hands		="Sulev. Gauntlets +2",
		legs		="Sulev. Cuisses +2",
		feet		="Flam. Gambieras +2",
		neck		="Combatant's Torque",
		waist		="Sarissapho. Belt",
		left_ear	="Cessance Earring",
		right_ear	="Telos Earring",
		left_ring	="Regal Ring",
		right_ring	="Flamma Ring",
		back		={ name="Weard Mantle", augments={'VIT+1','DEX+1','Enmity+3','Phalanx +4',}},
}

	-- sets.engaged = {ammo="Ginsen",
       -- head="Otomi Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Caballarius Surcoat +1",hands="Souveran Handschuhs",ring1="Rajas Ring",ring2="K'ayres Ring",
        -- back="Atheling Mantle",waist="Zoran's Belt",legs="Caballarius Breeches +1",feet="Whirlpool Greaves"}

    sets.engaged.Acc = {ammo="Paeapua",
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mes'yohi Haubergeon",hands="Odyssean Gauntlets",ring1="Rajas Ring",ring2="Apate Ring",
        back="Weard Mantle",waist="Zoran's Belt",legs="Souveran Diechlings",feet="Carmine Greaves"}

    sets.engaged.DW = {ammo="Ginsen",
        head="Otomi Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Mes'yohi Haubergeon",hands="Souveran Handschuhs",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Cizin Breeches",feet="Whirlpool Greaves"}

    sets.engaged.DW.Acc = {ammo="Ginsen",
        head="Yaoyotl Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Mes'yohi Haubergeon",hands="Odyssean Gauntlets",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Weard Mantle",waist="Zoran's Belt",legs="Cizin Breeches",feet="Carmine Greaves"}

    sets.engaged.PDT = set_combine(sets.engaged, {body="Caballarius Surcoat +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {body="Reverence Surcoat +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {body="Caballarius Surcoat +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Caballarius Surcoat +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end

    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end

    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end

    return defenseSet
end


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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end

    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
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

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end

    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
	set_macro_page(10, 1)
end