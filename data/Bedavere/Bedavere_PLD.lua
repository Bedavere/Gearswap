-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
 
    -- Organizer
    include('organizer-lib')
end
 
 require("no_interruptions")
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'SIRD', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    state.IdleMode:options('Normal', 'Refresh')
     
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
     
    gear.Weard = { name="Weard Mantle", augments={'VIT+1','DEX+3','Enmity+2','Phalanx +5'}}
    gear.RudianosTP = { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
    gear.RudianosWS = { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','Weapon skill damage +10%',}}
    gear.RudianosFC = { name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10',}}
    gear.RudianosEnm = { name="Rudianos's Mantle", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10',}}
    gear.Ejekamal = { name="Ejekamal Boots", augments={'Haste+2','"Snapshot"+2','"Fast Cast"+3',}}
    gear.AcroLegsFC = { name="Acro Breeches", augments={'"Fast Cast"+2'}}
     
    target_distance = 5.5 -- Set Default Distance Here --
 
    update_defense_mode()
     
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')
    send_command('bind @f12 gs c cycle CastingMode')
    send_command('pld')
 
    select_default_macro_book()
end
 
function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
    send_command('unbind @f12')
    send_command('gs enable all')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Fast cast sets for spells
    
    sets.precast.FC = {main="Sakpata's Sword",
	ammo="Sapience Orb",
    head="Carmine Mask +1",
    body="Rev. Surcoat +3",
    hands="Leyline Gloves",
    legs="Nyame Flanchard",
    feet="Odyssean Greaves",
    neck="Orunmila's Torque",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back="Moonlight Cape",
}
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC['Cure'] = {
	ammo="Sapience Orb",
    head="Carmine Mask +1",
    body="Rev. Surcoat +3",
    hands="Leyline Gloves",
    legs="Nyame Flanchard",
    feet="Odyssean Greaves",
    neck="Orunmila's Torque",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back="Moonlight Cape",
}
    
    --Enmity
 
    sets.precast.Enmity = {
	ammo="Sapience Orb",
    head="Loess Barbuta +1",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Moonlight Necklace",
    waist="Creed baudrier",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Apeile Ring",
    right_ring="Eihwaz Ring",
    back="Rudianos's Mantle",
}
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.precast.Enmity, {legs="Caballarius Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.Enmity, {feet="Reverence Leggings +1"})
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.Enmity, {hands="Caballarius Gauntlets +1", ear2="Knightly Earring"})
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.Enmity, {feet="Caballarius Leggings"})
    sets.precast.JA['Rampart'] = set_combine(sets.precast.Enmity, {head="Caballarius Coronet +1"})
    sets.precast.JA['Fealty'] = set_combine(sets.precast.Enmity, {body="Caballarius Surcoat"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.Enmity, {feet="Chevalier's Sabatons"})
    sets.precast.JA['Sepulcher'] = sets.precast.Enmity
    sets.precast.JA['Palisade'] = sets.precast.Enmity
    sets.precast.JA['Cover'] = set_combine(sets.precast.Enmity, {head="Reverence Coronet"})
 
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
    ammo="Paeapua",
	head="Sulevia's Mask +1",
	body="Rev. Surcoat +3",
	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
	legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+7','Breath dmg. taken -3%',}},
	feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
	neck="Aife's Medal",
	waist="Creed Baudrier",
	left_ear="Spellbr. Earring",
	right_ear="Nourish. Earring +1",
	left_ring="Aquasoul Ring",
	right_ring="Solemn Ring",
	back={ name="Weard Mantle", augments={'VIT+1','DEX+1','Enmity+3','Phalanx +4',}},
}
    
    -- /WAR
    sets.precast.JA['Provoke'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Berserk'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Warcry'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Aggressor'] = set_combine(sets.precast.Enmity, {})
    sets.precast.JA['Defender'] = set_combine(sets.precast.Enmity, {})
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
	head="Sulevia's Mask +2",
	body="Sulevia's Plate. +1",
	hands="Sulev. Gauntlets +1",
	legs="Sulevi. Cuisses +1",
	feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
	neck="Unmoving Collar +1",
	waist="Chaac Belt",
	left_ear="Handler's Earring +1",
	right_ear="Handler's Earring",
	left_ring="Valseur's Ring",
	right_ring="Asklepian Ring",
	back={ name="Weard Mantle", augments={'VIT+1','DEX+1','Enmity+3','Phalanx +4',}},
}
    
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Hasty Pinion +1",
	ammo="Amar Cluster",
	head="Sulevia's Mask +2",
	body="Sulevia's Plate. +1",
	hands="Sulev. Gauntlets +1",
	legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	feet="Sulev. Leggings +1",
	neck="Iqabi Necklace",
	waist="Eschan Stone",
	left_ear="Steelflash Earring",
	right_ear="Heartseeker Earring",
	left_ring="Enlivened Ring",
	right_ring="Sulevia's Ring",
	back="Grounded Mantle",
}
    
    sets.precast.Flourish1 = {
	ammo="Amar Cluster",
	head="Sulevia's Mask +2",
	body="Sulevia's Plate. +1",
	hands="Sulev. Gauntlets +1",
	legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	feet="Sulev. Leggings +1",
	neck="Iqabi Necklace",
	waist="Eschan Stone",
	left_ear="Steelflash Earring",
	right_ear="Heartseeker Earring",
	left_ring="Enlivened Ring",
	right_ring="Sulevia's Ring",
	back="Grounded Mantle",
}
 
   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
     
    sets.precast.WS = {
	ammo="Crepuscular pebble",
	head="Nyame helm",
	body="Nyame mail",
	hands="Nyame gauntlets",
	legs="Nyame flanchard",
	feet="Nyame sollerets",
	neck="Unmoving Collar +1",
	waist="Sailfi Belt +1",
	left_ear="Thrud Earring",
	right_ear="Moonshade Earring",
	left_ring="Epaminondas's Ring",
	right_ring="Defending Ring",
	back="Moonlght cape",
}
 
    sets.precast.WS.Acc = {
	ammo="Amar Cluster",
	head="Sulevia's Mask +2",
	body="Sulevia's Plate. +1",
	hands="Sulev. Gauntlets +1",
	legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	feet="Sulev. Leggings +1",
	neck="Sanctity Necklace",
	waist="Eschan Stone",
	left_ear="Steelflash Earring",
	right_ear="Heartseeker Earring",
	left_ring="Enlivened Ring",
	right_ring="Sulevia's Ring",
	back="Grounded Mantle",
}
 
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring2="Solemn Ring",})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {waist="Fotia Belt"})
    
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {hands="Flamma Manopolas +1",waist="Windbuffet Belt +1"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {hands="Flamma Manopolas +1"})
 
    sets.precast.WS['Sanguine Blade'] = {
	ammo="Erlene's Notebook",
	head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst dmg.+10%','"Refresh"+1',}},
	body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
	hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
	legs={ name="Valor. Hose", augments={'Accuracy+20 Attack+20','Weapon skill damage +2%','VIT+6','Accuracy+11','Attack+11',}},
	feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
	neck="Eddy Necklace",
	waist="Fotia Belt",
	left_ear="Friomisi Earring",
	right_ear="Hecate's Earring",
	left_ring="Archon Ring",
	right_ring="Acumen Ring",
	back="Izdubar Mantle",
}
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'], {
	head={ name="Jumalik Helm", augments={'MND+10','"Mag.Atk.Bns."+15','Magic burst dmg.+10%','"Refresh"+1',}},
})
    
    sets.precast.WS['Atonement'] = {
	ammo="Sapience Orb",
    head="Loess Barbuta +1",
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Moonlight Necklace",
    waist="Creed baudrier",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Apeile Ring",
    right_ring="Eihwaz Ring",
    back="Rudianos's Mantle",
}
    
    sets.precast.WS['Savage Blade'] = {
	ammo="Crepuscular pebble",
	head="Nyame helm",
	body="Nyame mail",
	hands="Nyame gauntlets",
	legs="Nyame flanchard",
	feet="Nyame sollerets",
	neck="Unmoving Collar +1",
	waist="Sailfi Belt +1",
	left_ear="Thrud Earring",
	right_ear="Moonshade Earring",
	left_ring="Epaminondas's Ring",
	right_ring="Defending Ring",
	back="Moonlght cape",
}
    
    sets.precast.WS['Circle Blade'] = {
	ammo="Crepuscular pebble",
	head="Nyame helm",
	body="Nyame mail",
	hands="Nyame gauntlets",
	legs="Nyame flanchard",
	feet="Nyame sollerets",
	neck="Unmoving Collar +1",
	waist="Sailfi Belt +1",
	left_ear="Thrud Earring",
	right_ear="Moonshade Earring",
	left_ring="Epaminondas's Ring",
	right_ring="Defending Ring",
	back="Moonlght cape",
}     
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    sets.midcast.FastRecast = {
	ammo="Sapience Orb",
    head="Carmine Mask +1",
    body="Rev. Surcoat +3",
    hands="Leyline Gloves",
    legs="Nyame Flanchard",
    feet="Odyssean Greaves",
    neck="Orunmila's Torque",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Kishar Ring",
    right_ring="Moonlight Ring",
    back="Moonlight Cape",
}
    
    sets.midcast.Enmity = set_combine(sets.precast.Enmity, {})
    
	sets.midcast.SIRD = {              --Test Set.
	ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs="Founder's hose",
    feet="Odyssean Greaves",
    neck="Moonlight Necklace",
    waist="Creed baudrier",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Apeile Ring",
    right_ring="Defending Ring",
    back="Moonlight Cape"
}
	
	--sets.midcast.SIRD = {          --Working Old Set.
	--ammo="Staunch Tathlum +1",
    --head="Souv. Schaller +1",
    --body="Rev. Surcoat +3",
    --hands="Sakepata's gauntlets",
    --legs="Carmine Cuisses +1",
    --feet="Nyame Sollerets",
    --neck="Moonlight Necklace",
    --waist="Audumbla Sash",
    --left_ear="Halasz Earring",
    --right_ear="Knightly Earring",
    --left_ring="Evanescence Ring",
    --right_ring="Defending Ring",
    --back="Moonlight Cape"}
	
    --sets.midcast.SIRD = {                             -Finished Set ONce all pieces are together.
	--ammo="Staunch Tathlum +1",
    --head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    --body="Rev. Surcoat +3",
    --hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    --legs="Founder's hose",
    --feet={ name="Nyame Sollerets", augments={'Path: B',}},
    --neck="Moonlight Necklace",
    --waist="Audumbla Sash",
    --left_ear="Tuisto Earring",
    --right_ear="Knightly Earring",
    --left_ring="Eihwaz Ring",
    --right_ring="Defending Ring",
    --back="Moonlight Cape"}
 
    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {})
    sets.midcast.Flash.SIRD = set_combine(sets.midcast.Flash, sets.midcast.Enmity)
    sets.midcast.Stun = set_combine(sets.midcast.Enmity, {})
    sets.midcast.Stun.SIRD = set_combine(sets.midcast.Stun, sets.midcast.Enmity)
    
    sets.midcast.Cure = {
	ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Sakpata's Breastplate",
    hands="Souv. Handsch. +1",
    legs="Founder's hose",
    feet="Odyssean Greaves",
    neck="Moonlight Necklace",
    waist="Trance Belt",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Apeile Ring",
    right_ring="Defending Ring",
    back="Moonlight Cape",
}

    sets.midcast.Cure.SIRD = {
	ammo="Staunch Tathlum +1",
    head="Souv. Schaller +1",
    body="Sakpata's Breastplate",
    hands="Sakpata's gauntlets",
    legs="Founder's hose",
    feet="Odyssean Greaves",
    neck="Unmoving collar +1",
    waist="Creed baudrier",
    left_ear="Tuisto Earring",
    right_ear="Cryptic Earring",
    left_ring="Apeile Ring",
    right_ring="Defending Ring",
    back="Rudianos's mantle"}
	
	sets.midcast.Protect = {sub="Srivatsa"}

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], 
	{main="Sakpata's Sword",
    ammo="Staunch Tathlum +1",
    head={ name="Valorous Mask", augments={'AGI+3','"Cure" potency +11%','Phalanx +4',}},
    body={ name="Valorous Mail", augments={'Pet: STR+6','Accuracy+2 Attack+2','Phalanx +4',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs="Sakpata's Cuisses",
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Mimir Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Weard Mantle", augments={'VIT+4','DEX+1','Enmity+5','Phalanx +5',}},
})
	
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.Enmity, {})
    sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.midcast.SIRD)
    sets.midcast['Blue Magic']['Wild Carrot'] = set_combine(sets.midcast.Enmity, sets.midcast.Cure)
    sets.midcast['Blue Magic']['Wild Carrot'].SIRD = set_combine(sets.midcast['Blue Magic']['Wild Carrot'], sets.midcast.SIRD)
	sets.midcast['Blue Magic']['Cocoon'] = set_combine(sets.midcast.SIRD)
    
    sets.midcast['Enhancing Magic'] = {}
    sets.midcast['Enhancing Magic'].SIRD = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SIRD)
    
    sets.midcast.Protect = {sub="Srivatsa",ring1="Sheltered Ring"}
    sets.midcast.Protect.SIRD = set_combine(sets.midcast.Protect, sets.midcast.SIRD)
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shell.SIRD = set_combine(sets.midcast.Shell, sets.midcast.SIRD)
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
 
    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {
	ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Rev. Surcoat +3",
    hands="Regal Gauntlets",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Moonlight Necklace",
    waist="Asklepian Belt",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Stikini Ring +1",
    right_ring="Moonlight Ring",
    back="Moonlight Cape",
}
    
 
    -- Idle sets
    sets.idle = {main="Burtgang",
	sub="Ochain",
	ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Regal Gauntlets",
    legs="Sakpata's cuisses",
    feet="Sakpata's Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Shneddick Ring",
    right_ring="Stikini Ring +1",
    back="Moonlight Cape",
}
 
    sets.idle.Refresh = set_combine(sets.idle, {
	ammo="Homiliary",
    head="Sakpata's Helm",
    body="Rev. Surcoat +3",
    hands="Regal Gauntlets",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Sakpata's Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Moonlight Ring",
    right_ring="Stikini Ring +1",
    back="Moonlight Cape",
})
 
    sets.idle.Town = {main="Burtgang",
	sub="Ochain",
	ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Regal Gauntlets",
    legs="Sakpata's cuisses",
    feet="Sakpata's Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Shneddick Ring",
    right_ring="Stikini Ring +1",
    back="Moonlight Cape",
}
    
    sets.idle.Weak = set_combine(sets.idle,{
	ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Sakpata's Plate",
    hands="Regal Gauntlets",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Moonlight Necklace",
    waist="Asklepian Belt",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Stikini Ring +1",
    right_ring="Moonlight Ring",
    back="Moonlight Cape",
})
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Carmine Cuisses +1"}
 
    --sets.latent_refresh = {waist="Fucho-no-obi"}
 
 
    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {ring1="Vocane Ring +1",back="Repulse Mantle"}
    sets.MP = {ammo="Homiliary",neck="Coatl Gorget +1",waist="Flume Belt"} --Chev. Armet +1
    sets.MP_Knockback = set_combine(sets.MP, sets.Knockback)
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {
	main={ name="Brilliance", augments={'Shield skill +6','Divine magic skill +9','Enmity+3','DMG:+6',}},
	sub="Ochain"
}
    sets.MagicalShield = {
	main={ name="Brilliance", augments={'Shield skill +6','Divine magic skill +9','Enmity+3','DMG:+6',}},
	sub="Aegis"
}
 
    -- Basic defense sets.
     
    sets.defense.PDT = {
	ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Nyame mail",
    hands="Nyame Gauntlets",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Moonlight Necklace",
    waist="Asklepian Belt",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Shneddick ring",
    right_ring="Moonlight Ring",
    back="Moonlight Cape",
}
    sets.defense.HP = {
	main={ name="Brilliance", augments={'Shield skill +9','Divine magic skill +14','Enmity+6','DMG:+13',}},
    sub="Aegis",
    ammo="Vanir Battery",
    head={ name="Souveran Schaller", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands="Regal Gauntlets",
    legs={ name="Souveran Diechlings", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    feet={ name="Souveran Schuhs", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
    neck="Loricate Torque +1",
    waist="Asklepian Belt",
    left_ear="Etiolation Earring",
    right_ear="Hearty Earring",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
    sets.defense.Reraise = {ammo="Staunch Tathlum",
    head="Twilight Helm",
    body="Twilight Mail",
}
    sets.defense.Charm = {
	ammo="Demonry Stone",
	head={ name="Founder's Corona", augments={'DEX+9','Accuracy+14','Mag. Acc.+15','Magic dmg. taken -4%',}},
	body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
	legs={ name="Odyssean Cuisses", augments={'Attack+23','Damage taken-2%','STR+13','Accuracy+11',}},
	feet="Hippomenes Socks",
	neck="Unmoving Collar +1",
	waist="Asklepian Belt",
	left_ear="Etiolation Earring",
	right_ear="Spellbr. Earring",
	left_ring="Defending Ring",
	right_ring="Shadow Ring",
	back="Solemnity Cape",
}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {
	ammo="Demonry Stone",
	head="Sulevia's Mask +2",
	body="Rev. Surcoat +3",
	hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	legs="Sulevi. Cuisses +1",
	feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
	neck="Twilight Torque",
	waist="Nierenschutz",
	left_ear="Etiolation Earring",
	right_ear="Spellbr. Earring",
	left_ring="Defending Ring",
	right_ring="Moonbeam Ring",
	back="Moonbeam Cape",
}
 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
     
    sets.engaged = {main="Burtgang",
	ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    hands="Regal Gauntlets",
    neck="Moonlight Necklace",
    waist="Asklepian Belt",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Moonlight Cape",
}
 
    sets.engaged.Acc = {
	ammo="Amar Cluster",
	head="Flam. Zucchetto +1",
	body="Flamma Korazin +1",
	hands="Flam. Manopolas +1",
	legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	feet="Flam. Gambieras +1",
	neck="Combatant's Torque",
	waist="Anguinus Belt",
	left_ear="Mache Earring",
	right_ear="Mache Earring",
	left_ring="Petrov Ring",
	right_ring="Sulevia's Ring",
	back="Grounded Mantle",
}
 
    sets.engaged.DW = set_combine(sets.engaged, {ear1="Suppanomimi",ear2="Brutal Earring",legs="Carmine Cuisses +1"})
 
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {ear1="Dudgeon Earring",ear2="Heartseeker Earring"})
 
    sets.engaged.PDT = {
	ammo="Amar Cluster",
	head="Sulevia's Mask +2",
	body="Sulevia's Plate. +1",
	hands="Sulev. Gauntlets +1",
	legs="Sulevi. Cuisses +1",
	feet="Sulev. Leggings +1",
	neck="Sanctity Necklace",
	waist="Phasmida Belt",
	left_ear="Mache Earring",
	right_ear="Mache Earring",
	left_ring="Candent Ring",
	right_ring="Sulevia's Ring",
	back={ name="Weard Mantle", augments={'VIT+1','DEX+1','Enmity+3','Phalanx +4',}},
}
    
    sets.engaged.Acc.PDT = sets.engaged.PDT
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)
 
    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT, {ear1="Suppanomimi",ear2="Brutal Earring"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.PDT, {ear1="Dudgeon Earring",ear2="Heartseeker Earring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)
 
 
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
 
    sets.buff.Doom = {
	ring1="Saida Ring",
	ring2="Saida Ring",
}
    sets.buff.Cover = {head="Reverence Coronet", body="Caballarius Surcoat"}
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" and player.status == 'Engaged' and spell.target.distance > target_distance then -- Cancel WS If You Are Out Of Range --
       eventArgs.cancel=true
       add_to_chat(123, spell.name..' Canceled: [Out of Range]')
       return
    end
end
 
 
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
 
-- Called when the player's state changes (e.g. Normal to Acc Engaged mode).
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
 
-- Called when status changes (Idle to Engaged, Resting, etc.)
function job_status_change(newStatus, oldStatus, eventArgs)
    update_defense_mode()
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if world.area:contains('Adoulin') then
        idleSet = set_combine(idleSet, {body="Councilor's Garb"})
    end
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
     
    msg = msg .. ', Casting: ' .. state.CastingMode.value
     
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
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'tds' then
        local newTargetDistance = tonumber(cmdParams[2])
        if not newTargetDistance then
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
            return
        end
        if newTargetDistance > 0 then
            target_distance = newTargetDistance
            add_to_chat(122, '[Weaponskill max range set to '..newTargetDistance..' yalms.]')
        else
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
        end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_defense_mode()
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
    if player.sub_job == 'WAR' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'RNG' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'PLD' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'SCH' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'BLU' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'DRK' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 17)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 17)
    else
        set_macro_page(1, 17)  --BRD
    end
end