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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

require("no_interruptions")

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	
    -- Fast cast sets for spells
	
    sets.precast.FC = {
    main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head="Vanya Hood",
    body="Inyanga Jubbah +1",
    hands="Aya. Manopolas +1",
    legs="Ayanmo cosciales +1",
    feet={ name="Chironic Slippers", augments={'Crit.hit rate+2','"Rapid Shot"+2','Weapon skill damage +6%','Accuracy+15 Attack+15','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Prolix Ring",
    back="Solemnity Cape"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat",hands="Carapacho Cuffs",legs="Doyen Pants"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
	ammo="Incantor Stone",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Inyanga Jubbah +2",
    hands={ name="Chironic Gloves", augments={'Pet: "Subtle Blow"+2','Pet: Attack+30 Pet: Rng.Atk.+30','"Refresh"+2','Accuracy+18 Attack+18',}},
    legs="Ebers Pantaloons",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Loquac. Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}})
    
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
	
	sets.precast.FC.CureAurora = sets.precast.FC.Cure
	
    sets.precast.FC.CuragaAurora = sets.precast.FC.Cure
	
	-- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault +3"}
	sets.precast.JA.Devotion = {head="Piety cap +3"}

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
	main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Inyanga Jubbah +1",
    hands="Aya. Manopolas +1",
    legs="Ayanmo cosciales +1",
    feet={ name="Chironic Slippers", augments={'Crit.hit rate+2','"Rapid Shot"+2','Weapon skill damage +6%','Accuracy+15 Attack+15','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Prolix Ring",
    back="Solemnity Cape"}
        
    -- Cure sets
	sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff", sub="Enki Strap", back="Twilight Cape", waist="Hachirin-no-obi",})
	
	sets.midcast.CureAurora = 
	{main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Chironic Hat", augments={'"Cure" potency +4%','Magic Damage +12','"Refresh"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'Pet: "Subtle Blow"+2','Pet: Attack+30 Pet: Rng.Atk.+30','"Refresh"+2','Accuracy+18 Attack+18',}},
    legs="Aya. Cosciales +2",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Meili Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}
	
    sets.midcast.CureSolace = 
	{main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut",
    hands={ name="Telchine Gloves", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs="Ebers Pantaloons",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Meili Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    sets.midcast.Cure = 
	{main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut",
    hands={ name="Telchine Gloves", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs="Ebers Pantaloons",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Meili Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    sets.midcast.CuragaAurora =
	{main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Chironic Hat", augments={'"Cure" potency +4%','Magic Damage +12','"Refresh"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'Pet: "Subtle Blow"+2','Pet: Attack+30 Pet: Rng.Atk.+30','"Refresh"+2','Accuracy+18 Attack+18',}},
    legs="Aya. Cosciales +2",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Meili Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}
	
	sets.midcast.Curaga =
	{main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Chironic Hat", augments={'"Cure" potency +4%','Magic Damage +12','"Refresh"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'Pet: "Subtle Blow"+2','Pet: Attack+30 Pet: Rng.Atk.+30','"Refresh"+2','Accuracy+18 Attack+18',}},
    legs="Aya. Cosciales +2",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Meili Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

	sets.midcast.Cursna ={main="Yagrush",
    sub="Sors Shield",
    ammo="Impatiens",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Ebers Bliaud +1",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs="Theophany Pantaloons +3",
    feet= "Gendewitha Galoshes +1",
    neck="Debilis Medallion",
    waist="Witful Belt",
    left_ear="Etiolation Earring",
    right_ear="Lempo Earring",
    left_ring="Haoma's Ring",
    right_ring="Menelaus's Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    sets.midcast.StatusRemoval = {main="Yagrush",
    sub="Ammurapi Shield",
    ammo="Impatiens",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Ebers Bliaud +1",
    hands="Theophany Mitts +3",
    legs={ name="Piety Pantaln. +3", augments={'Enhances "Shellra V" effect',}},
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Cleric's Torque",
    waist="Witful Belt",
    left_ear="Etiolation Earring",
    right_ear="Mendi. Earring",
    left_ring="Haoma's Ring",
    right_ring="Haoma's Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Gada",
    sub="Ammurapi Shield",	
    ammo="Impatiens",
    head="Telchine cap",
    body="Telchine chasuble",
    hands="Telchine gloves",
    legs="Telchine Braconi",
    feet="Theophany Duckbills +3",
    neck="Incanter's Torque",
    waist="Olympus Sash",
    right_ear="Andoaa Earring",
    left_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Perimede Cape",}

    sets.midcast.Stoneskin = {head="Umuthi Hat",neck="Nodens Gorget",ear2="Earthcry Earring",
        body="Telchine Chasuble",hands="Inyanga Dastanas +2",
        back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},waist="Siegel Sash",legs="Shedir Seraweels",feet="Theophany Duckbills +3"}

    sets.midcast.Auspice = {hands="Telchine gloves",feet="Ebers Duckbills +1"}

    sets.midcast.BarElement = {main="Beneficus",
    sub="Ammurapi Shield",
    ammo="Impatiens",
    head="Ebers Cap",
    body="Ebers Bliaud",
    hands="Inyanga Dastanas +2",
    legs={ name="Piety Pantaln. +3", augments={'Enhances "Shellra V" effect',}},
    feet="Ebers Duckbills",
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back= "Perimede Cape",}

	sets.midcast['Haste'] = {main="Gada",
    sub="Ammurapi Shield",	
    ammo="Impatiens",
    head="Telchine cap",
    body="Telchine chasuble",
    hands="Telchine gloves",
    legs="Telchine Braconi",
    feet="Theophany Duckbills +3",
    neck="Incanter's Torque",
    waist="Olympus Sash",
    right_ear="Andoaa Earring",
    left_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Perimede Cape",}
	
    sets.midcast.Regen = {main="Bolelabunga",
    sub="Ammurapi Shield",
    ammo="Impatiens",
    head="Inyanga Tiara +2",
    body="Piety Briault +3",
    hands="Ebers Mitts +1",
    legs="Theophany Pantaloons +3",
    feet="Piety Duckbills +3",
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Lebeche Ring",
    back="Perimede Cape",}

    sets.midcast.Protectra = {main="Gada",
    sub="Ammurapi Shield",
    ammo="Impatiens",
    head="Telchine cap",
    body="Telchine Chasuble",
    hands="Telchine gloves",
    legs={ name="Piety Pantaln. +3", augments={'Enhances "Shellra V" effect',}},
    feet={ name="Piety Duckbills +3", augments={'Enhances "Protectra V" effect',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Brachyura Earring",
    right_ear="Etiolation Earring",
    left_ring="Stikini Ring +1",
    right_ring="Sheltered Ring",
    back="Perimede Cape",}

    sets.midcast.Shellra = {main="Gada",
    sub="Ammurapi Shield",
    ammo="Impatiens",
    head="Telchine cap",
    body="Telchine Chasuble",
    hands="Telchine gloves",
    legs={ name="Piety Pantaln. +3", augments={'Enhances "Shellra V" effect',}},
    feet={ name="Piety Duckbills +3", augments={'Enhances "Protectra V" effect',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Brachyura Earring",
    right_ear="Etiolation Earring",
    left_ring="Stikini Ring +1",
    right_ring="Sheltered Ring",
    back="Perimede Cape",}


    sets.midcast['Divine Magic'] = {main="Gada",
    sub="Ammurapi Shield",
    ammo="Impatiens",
    head="Ipoca Beret",
    body="Theophany briault +3",
    hands="Piety mitts +3",
    legs="Chironic Hose",
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Jokushu Chain",
    waist="Luminary Sash",
    left_ear="Mendi. Earring",
    right_ear="Etiolation Earring",
    left_ring="Stikini Ring +1",
    right_ring="Fenian Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    sets.midcast['Dark Magic'] = {main="Gada", sub="Ammurapi Shield",
        head="Nahtirah Hat",neck="Erra Pendant",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Theophany Duckbills +3"}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Yagrush",
    sub="Ammurapi Shield",
    ammo="Hydrocera",
    head="Piety Cap +3",
    body="Theo. Briault +3",
    hands="Piety Mitts +3",
    legs="Chironic Hose",
    feet="Piety duckbills +3",
    neck="Erra Pendant",
    waist="Luminary sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Kishar Ring",
    right_ring="Sangoma Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    sets.midcast.IntEnfeebles = {main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Piety Cap +3",
    body="Theo. Briault +3",
    hands="Piety Mitts +3",
    legs="Chironic Hose",
    feet="Piety Duckbills +3",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Kishar Ring",
    right_ring="Sangoma Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Chironic Hat", augments={'"Cure" potency +4%','Magic Damage +12','"Refresh"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'Pet: "Subtle Blow"+2','Pet: Attack+30 Pet: Rng.Atk.+30','"Refresh"+2','Accuracy+18 Attack+18',}},
    legs="Aya. Cosciales +2",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck="Twilight Torque",
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Meili Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}},}

    sets.idle.PDT = {main="Earth Staff",
    sub="Oneiros Grip",
    ammo="Impatiens",
    head="Aya. Zucchetto +2",
    body="Gendewitha Bliaut +1",
    hands="Inyanga Dastanas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Siegel Sash",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Patricius Ring",
    back="Moonlight Cape",}
	
	sets.idle.Town = {main="Ames",
    sub="Genbu's Shield",
    ammo="Incantor Stone",
    head={ name="Chironic Hat", augments={'"Cure" potency +4%','Magic Damage +12','"Refresh"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'Pet: "Subtle Blow"+2','Pet: Attack+30 Pet: Rng.Atk.+30','"Refresh"+2','Accuracy+18 Attack+18',}},
    legs="Aya. Cosciales +2",
    feet={ name="Chironic Slippers", augments={'AGI+10','Attack+18','"Refresh"+2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    neck="Twilight Torque",
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Meili Earring",
    left_ring="Inyanga Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}
		
    sets.idle.Weak = {main="Ames",
    sub="Genbu's Shield",
    ammo="Shadow Sachet",
    head="Aya. Zucchetto +1",
    body="Revealer's Tunic",
    hands="Aya. Manopolas +1",
    legs="Aya. Cosciales +1",
    feet="Aya. Gambieras +1",
    neck="Wiglen Gorget",
    waist="Porous Rope",
    left_ear="Musical Earring",
    right_ear="Gifted Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Solemnity Cape"}
		
    -- Defense sets

    sets.defense.PDT = {main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Inyanga Dastanas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Fucho-no-obi",
    left_ear="Infused Earring",
    right_ear="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Inyanga Ring",
    back="Moonlight Cape",}

    sets.defense.MDT = {main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Homiliary",
    head="Inyanga Tiara +2",
    body="Zendik Robe",
    hands="Inyan. Dastanas +2",
    legs="Assiduity pants +1",
    feet="Herald's Gaiters",
    neck="Sanctity Necklace",
    waist="Fucho-no-obi",
    right_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}},
    left_ear="Etiolation Earring",
    left_ring="Stikini Ring +1",
    right_ring="Inyanga Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Occ. inc. resist. to stat. ailments+10',}}}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
            main="Mjollnir",
    sub="Sindri",
    ammo="Vanir Battery",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Ayanmo Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Ayanmo Gambieras +2",
    neck="Sanctity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Chirich Ring",
    right_ring="Petrov Ring",
	back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}

	-- Weaponskill sets
	
	sets.precast.WS['Hexa strike'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Duckbills +3",
    feet="Piety Duckbills +3",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Chirich Ring",
    right_ring="Petrov Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
	sets.precast.WS['Realmrazer'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Duckbills +3",
    feet="Piety Duckbills +3",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Chirich Ring",
    right_ring="Petrov Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	

	sets.precast.WS['Mystic Boon'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Pantaloons +3",
    feet="Piety Duckbills +3",
    neck="Fotia Gorget",
    waist="Prosilio Belt +1",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Rajas Ring",
    right_ring="Chirich Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
	sets.precast.WS['Randgrith'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Pantaloons +3",
    feet="Piety Duckbills +3",
    neck="Caro Necklace",
    waist="Prosilio belt +1",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Rajas Ring",
    right_ring="Petrov Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
	sets.precast.WS['Black Halo'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Pantaloons +3",
    feet="Piety Duckbills +3",
    neck="Caro Necklace",
    waist="Prosilio belt +1",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Petrov Ring",
    right_ring="Chirich Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",back="Mending Cape"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Mending Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
		
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
         
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(4, 3)
end