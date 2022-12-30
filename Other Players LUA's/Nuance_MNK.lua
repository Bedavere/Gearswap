-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()
    state.OffenseMode:options('Normal','LowAcc','MidAcc','MAX')

    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end



-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    
	    --------------------------------------
    -- Augments
    --------------------------------------
	
	Segomo = {}
	Segomo.TP = {name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
	Segomo.Impetus = {name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
	Segomo.Smite = {name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10'}}
	Segomo.Kicks = {name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	Segomo.Howling = {name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	Segomo.FC = {name="Segomo's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10'}}
    Segomo.FH = {name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','"Regen"+5'}}
	
	-- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +3"}
    sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +2"}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +2"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +2"}
    sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}
    sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas +1"}
    sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Chi Blast'] = {head="Hesychast's Crown +3"}

    sets.precast.JA['Chakra'] = {
    ammo="Brigantia Pebble",
    head="Genmei Kabuto",
    body="Anchorite's Cyclas +2",
    hands="Hes. Gloves +1",
    legs="Hizamaru Hizayoroi +2",
    feet="Kendatsuba Sune-Ate +1",
    neck="Unmoving Collar +1",
    waist="Caudata Belt",
    left_ear="Terra's Pearl",
    right_ear="Terra's Pearl",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring +1",
    back=Segomo.Chakra}
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
    ammo="Brigantia Pebble",
    head="Genmei Kabuto",
    body="Anch. Cyclas +1",
    hands="Hes. Gloves +1",
    legs="Hizamaru Hizayoroi +2",
    feet="Kendatsuba Sune-Ate",
    neck="Unmoving Collar +1",
    waist="Caudata Belt",
    left_ear="Terra's Pearl",
    right_ear="Terra's Pearl",
    left_ring="Titan Ring +1",
    right_ring="Niqmaddu Ring +1",
    back="Segomo's Mantle"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
    ammo="Sapience Orb",
    head="Herculean Helm",
    body="Taeon Tabard",
    hands="Leyline Gloves",
    legs="Kendatsuba Hakama",
    feet="Ahosi Leggings",
    neck="Voltsurge Torque",
    waist="Moonbow Belt +1",
    left_ear="Enchanter Earring +1",
    right_ear="Loquacious Earring",
    left_ring="Rahab Ring",
    right_ring="Prolix Ring",
    back=Segomo.Chakra}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	ammo="Knobkierrie",
	head="Hesychast's Crown +3",
    body="Ken. Samue +1",
    hands="Anchor. Gloves +2",
    legs="Hiza. Hizayoroi +2",
    feet="Anch. Gaiters +2",
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    ear1="Moonshade Earring",
    ear2="Sherida Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    back=Segomo.FH}
    
	sets.precast.WSAcc = {}
    
	sets.precast.WSMod = {}
    
	sets.precast.MaxTP = {}
    
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
    
	sets.precast.WS.Mod = set_combine(sets.precast.WS, sets.precast.WSMod)

    -- Specific weaponskill sets.
    
    sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Ken. Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+10','Accuracy+11',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})
    
	sets.precast.WS['Final Heaven']    = set_combine(sets.precast.WS, {
	ammo="Knobkierrie",
    head="Hesychast's Crown +3",
    body="Ken. Samue +1",
    hands="Anchor. Gloves +2",
    legs="Hiza. Hizayoroi +2",
    feet={ name="Herculean Boots", augments={'Accuracy+22 Attack+22','Weapon skill damage +3%','STR+10','Attack+11',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','"Regen"+5'}}})
	
	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
	head="Hesychast's Crown +3",
    body="Ken. Samue +1",
    hands="Anchor. Gloves +2",
    legs="Hiza. Hizayoroi +2",
    feet="Anch. Gaiters +2",
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Ishvara Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}})
    
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {})
    
	sets.precast.WS["Ascetic's Fury"]   = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Anchorite's Cyclas +2",
    hands={ name="Ryuo Tekko +1", augments={'DEX+12','Accuracy+25','"Dbl.Atk."+4',}},
    legs="Ken. Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+25 Attack+25','Crit. hit damage +5%','DEX+7','Accuracy+12',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}})
	
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Kendatsuba Samue +1",
    hands={ name="Ryuo Tekko +1", augments={'DEX+12','Accuracy+25','"Dbl.Atk."+4',}},
    legs="Ken. Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+25 Attack+25','Crit. hit damage +5%','DEX+7','Accuracy+12',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}})
	
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Ken. Jinpachi +1",
    body={ name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+10','Accuracy+11',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}})
    
	sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
	ammo="Knobkierrie",
	head="Hesychast's Crown +3",
    body="Ken. Samue +1",
    hands="Anchor. Gloves +2",
    legs="Kendatsuba Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+10','Accuracy+11',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}})
    
    
	sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
	ammo="Knobkierrie",
	head="Hesychast's Crown +3",
    body="Ken. Samue +1",
    hands="Anchor. Gloves +2",
    legs="Kendatsuba Hakama +1",
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+10','Accuracy+11',}},
    neck="Fotia Gorget",
    waist="Moonbow Belt",
    left_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}})
    
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {})
    
	sets.precast.WS["Raging Fists"].LowAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    
	sets.precast.WS["Howling Fist"].LowAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    
	sets.precast.WS["Asuran Fists"].LowAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    
	sets.precast.WS["Ascetic's Fury"].LowAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    
	sets.precast.WS["Victory Smite"].LowAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
    
	sets.precast.WS["Shijin Spiral"].LowAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    
	sets.precast.WS["Dragon Kick"].LowAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    
	sets.precast.WS["Tornado Kick"].LowAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

    
	sets.precast.WS["Raging Fists"].MidAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMod)
    
	sets.precast.WS["Howling Fist"].MidAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMod)
    
	sets.precast.WS["Asuran Fists"].MidAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMod)
    
	sets.precast.WS["Ascetic's Fury"].MidAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMod)
    
	sets.precast.WS["Victory Smite"].MidAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSMod)
    
	sets.precast.WS["Shijin Spiral"].MidAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMod)
    
	sets.precast.WS["Dragon Kick"].MidAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMod)
    
	sets.precast.WS["Tornado Kick"].MidAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMod)


    sets.precast.WS['Cataclysm'] = {
        head="Wayfarer Circlet",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Wayfarer Robe",hands="Otronif Gloves",ring1="Acumen Ring",ring2="Demon's Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}
    
	sets.precast.WS['Retribution'] = {ammo="Knobkierrie",
        head="Ryuo Somen +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Ryuo Domaru +1",hands="Ryuo Tekko +1",ring1="Niqmaddu Ring",ring2="Ifrit Ring +1",
        back=Segomo.WS,waist="Moonbow Belt +1",legs="Hizamaru Hizayoroi +2",feet="Herculean Boots"}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
    ammo="Sapience Orb",
    head="Herculean Helm",
    body="Taeon Tabard",
    hands="Leyline Gloves",
    legs="Kendatsuba Hakama +1",
    feet="Ahosi Leggings",
    neck="Magoraga Bead Necklace",
    waist="Moonbow Belt +1",
    left_ear="Enchanter Earring +1",
    right_ear="Loquacious Earring",
    left_ring="Rahab Ring",
    right_ring="Prolix Ring",
    back=Segomo.Chakra}
	
    -- Specific spells
    sets.midcast.Utsusemi = {
    ammo="Sapience Orb",
    head="Herculean Helm",
    body="Taeon Tabard",
    hands="Leyline Gloves",
    legs="Kendatsuba Hakama +1",
    feet="Ahosi Leggings",
    neck="Magoraga Bead Necklace",
    waist="Moonbow Belt +1",
    left_ear="Enchanter Earring +1",
    right_ear="Loquacious Earring",
    left_ring="Rahab Ring",
    right_ring="Prolix Ring",
    back=Segomo.Chakra}
	
    -- Sets to return to when not performing an action.

    -- Idle sets
    sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Kendatsuba Jinpachi +1",
    body="Ashera Harness",
    hands="Adhemar Wristbands +1",
    legs="Kendatsuba Hakama +1",
    feet="Kendatsuba Sune-Ate +1",
    neck="Loricate Torque +1",
    waist="Moonbow Belt",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Chirich Ring +1",
    right_ring="Defending Ring",
    back=Segomo.FH}
    
	sets.idle.Town = {
    ammo="Staunch Tathlum +1",
    head="Kendatsuba Jinpachi +1",
    body="Kendatsuba Samue +1",
    hands="Kendatsuba Tekko +1",
    legs="Kendatsuba Hakama +1",
    feet="Kendatsuba Sune-Ate +1",
    neck="Moonlight Nodowa",
    waist="Moonbow Belt +1",
    right_ear="Sherida Earring",
    left_ear="Telos Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back=Segomo.TP}
    
	sets.idle.Weak = {
    ammo="Staunch Tathlum +1",
    head="Rao Kabuto +1",
    body="Hiza. Haramaki +1",
    hands="Rao Kote +1",
    legs="Rao Haidate +1",
    feet="Rao Sune-Ate +1",
    neck="Loricate Torque +1",
    waist="Moonbow Belt",
    left_ear="Genmei Earring",
    right_ear="Infused Earring",
    left_ring="Sheltered Ring",
    right_ring="Defending Ring",
    back="Moonlight Cape"}
	
    -- Defense sets
    sets.defense.PDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sherida Earring",
        body="Ashera Harness",hands="Malignance Gloves",ring1="Gere Ring",ring2="Defending Ring",
        back=Segomo.TP,waist="Moonbow Belt",legs="Malignance Tights",feet="Kendatsuba Sune-Ate +1"}

    sets.defense.MDT = {ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Telos Earring",ear2="Sherida Earring",
        body="Ashera Harness",hands="Malignance Gloves",ring1="Gere Ring",ring2="Defending Ring",
        back=Segomo.TP,waist="Moonbow Belt",legs="Malignance Tights",feet="Kendatsuba Sune-Ate +1"}

    sets.Kiting = {feet="Crier's Gaiters"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {
	ammo="Ginsen",
    head="Adhemar Bonnet +1",
    body="Kendatsuba Samue +1",
    hands="Adhemar Wrist. +1",
    legs="Hesychast's Hose +3",
    feet="Anchorite's Gaiters +3",
    neck="Monk's Nodowa +2",
    waist="Moonbow Belt",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
	
    sets.engaged.LowAcc = {    
    ammo="Ginsen",
    head="Adhemar Bonnet +1",
    body="Kendatsuba Samue +1",
    hands="Adhemar Wrist. +1",
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','"Triple Atk."+4','DEX+10','Accuracy+11',}},
    neck="Anu Torque",
    waist="Moonbow Belt",
    left_ear="Brutal Earring",
    right_ear="Sherida Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
	
	sets.engaged.MidAcc ={
    ammo="Ginsen",
    head="Kendatsuba Jinpachi +1",
    body="Kendatsuba Samue +1",
    hands="Adhemar Wristbands +1",
    legs="Hesychast's Hose +3",
    feet="Anchorite's Gaiters +3",
    neck="Anu Torque",
    waist="Moonbow Belt",
    right_ear="Sherida Earring",
    left_ear="Cessance Earring",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back=Segomo.TP}
	
	sets.engaged.MAX = {
    ammo="Ginsen",
    head="Kendatsuba Jinpachi +1",
    body="Kendatsuba Samue +1",
    hands="Adhemar Wristbands +1",
    legs="Kendatsuba Hakama +1",
    feet="Kendatsuba Sune-Ate +1",
    neck="Anu Torque",
    waist="Moonbow Belt",
    right_ear="Mache Earring +1",
    left_ear="Mache Earring +1",
    left_ring="Gere Ring",
    right_ring="Niqmaddu Ring",
    back=Segomo.TP}
	
	
    -- Defensive melee hybrid sets
    sets.engaged.PDT = {
    ammo="Staunch Tathlum +1",
    head="Kendatsuba Jinpachi +1",
    body="Kendatsuba Samue +1",
    hands="Kendatsuba Tekko +1",
    legs="Kendatsuba Hakama +1",
    feet="Kendatsuba Sune-Ate +1",
    neck="Moonlight Nodowa",
    waist="Moonbow Belt +1",
    right_ear="Sherida Earring",
    left_ear="Genmei Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back=Segomo.TP}

    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
	sets.engaged.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.LowAcc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.LowAcc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})

    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Bhikku Cyclas +1"}
    sets.footwork_kick_feet = {legs="Kendatsuba Hakama +1",feet="Anchorite's Gaiters +3"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            if (state.OffenseMode.current == 'Fodder' and info.impetus_hit_count > 5) or (info.impetus_hit_count > 8) then
                equip(sets.impetus_body)
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(8, 2)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'RUN' then
        set_macro_page(1, 2)
    else
        set_macro_page(3, 2)
    end
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