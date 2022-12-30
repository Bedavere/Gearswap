-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- [ Job Function Toggles ] --
  -- [ OffenseMode F9  = Normal/None ]
  -- [ Defensemode F10 = PDT / F11 = MDT ]
  -- [ ShowAllMode F12 = Shows Current Modes ]
  -- [ CastingMode ??  = Unsure how this Toggles, and also no resistant sets listed. ]

-- Initialization function for this job file.

--These Files can be removed Below--

require("no_interruptions")

------------------------------------

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
    ammo="Sapience Orb",
    head="Volte Beret",
    body="Inyanga Jubbah +2",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs="Volte Brais",
    feet="Volte Gaiters",
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {head="Umuthi Hat",hands="Carapacho Cuffs",legs="Doyen Pants"})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Ebers Pantaloons +"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
	main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
    sub="Genmei Shield",
    ammo="Sapience Orb",
    head="Volte Beret",
    body="Inyanga Jubbah +2",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs="Volte Brais",
    feet="Volte Gaiters",
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}})
    
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
	ammo="Sapience Orb",
    head="Volte Beret",
    body="Inyanga Jubbah +2",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs="Volte Brais",
    feet="Volte Gaiters",
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
        
    -- Cure sets
	sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff", sub="Enki Strap", back="Twilight Cape", waist="Hachirin-no-obi",})
	
	sets.midcast.CureAurora = {
	main="Raetic Rod +1",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut +1",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Ebers Pant. +1",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Mendi. Earring",
    right_ear="Glorious Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
	sets.midcast.CureMelee = {
	ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut +1",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Ebers Pant. +1",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Mendi. Earring",
    right_ear="Glorious Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
    sets.midcast.CureSolace = {
	main="Raetic Rod +1",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut +1",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Ebers Pant. +1",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Mendi. Earring",
    right_ear="Glorious Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

    sets.midcast.Cure = {
	main="Raetic Rod +1",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut +1",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Ebers Pant. +1",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Mendi. Earring",
    right_ear="Glorious Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

    sets.midcast.CuragaAurora = {
	main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut +1",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Ebers Pant. +1",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Hachirin-no-obi",
    left_ear="Mendi. Earring",
    right_ear="Glorious Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
	sets.midcast.Curaga = {
	main="Raetic Rod +1",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Ebers Bliaut +1",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Ebers Pant. +1",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Mendi. Earring",
    right_ear="Glorious Earring",
    left_ring="Mephitas's Ring +1",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

	sets.midcast.Cursna ={main="Yagrush",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Kaykaus Mitra", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
    body="Ebers Bliaud +1",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
    legs={ name="Piety Pantaloons", augments={'Enhances "Afflatus Misery" effect',}},
    feet="Gende. Galosh. +1",
    neck="Debilis Medallion",
    waist="Witful Belt",
    left_ear="Hearty Earring",
    right_ear="Loquac. Earring",
    left_ring="Ephedra Ring",
    right_ring="Menelaus's Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

    sets.midcast.StatusRemoval = {main="Yagrush",
    sub="Genmei shield",
    ammo="Staunch Tathlum +1",
    head="Nyame helm",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -4%',}},
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Cleric's Torque",
    waist="Witful Belt",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {main="Beneficus",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head="Telchine Cap",
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands="Inyan. Dastanas +2",
    legs={ name="Piety Pantaln. +1", augments={'Enhances "Afflatus Misery" effect',}},
    feet="Nyame sollerets",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Fi Follet Cape +1"}

    sets.midcast.Stoneskin = {
	neck="Nodens Gorget",ear2="Earthcry Earring",
    waist="Siegel Sash",legs="Shedir Seraweels"}

    sets.midcast.Auspice = {hands="Telchine gloves",feet="Ebers Duckbills +1"}

    sets.midcast.BarElement = {main="Beneficus",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head="Befouled Crown",
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands="Inyan. Dastanas +2",
    legs={ name="Piety Pantaln. +1", augments={'Enhances "Afflatus Misery" effect',}},
    feet="Ebers Duckbills +1",
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Fi Follet Cape +1"}

	sets.midcast['Haste'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+24','"Mag.Atk.Bns."+2',}},
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    body="Nyame Mail",
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Fi Follet Cape +1"}
	
	sets.midcast['Raise'] = {main="Bolelabunga",
    sub="Ammurapi Shield",	
    ammo="Impatiens",
    head="Telchine cap",
    body="Vedic coat",
    hands="Telchine gloves",
    legs="Telchine Braconi",
    feet="Hygieia Clogs +1",
    neck="Incanter's Torque",
    waist="Luminary Sash",
    right_ear="Andoaa Earring",
    left_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Perimede Cape"}
	
	sets.midcast['Arise'] = {main="Bolelabunga",
    sub="Ammurapi Shield",	
    ammo="Impatiens",
    head="Telchine cap",
    body="Vedic coat",
    hands="Telchine gloves",
    legs="Telchine Braconi",
    feet="Hygieia Clogs +1",
    neck="Incanter's Torque",
    waist="Luminary Sash",
    right_ear="Andoaa Earring",
    left_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Perimede Cape"}
	
	sets.midcast['Aquaveil'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+19',}},
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+17','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Loquac. Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Shadow Ring",
    back="Solemnity Cape"}
	
    sets.midcast.Regen = {main="Bolelabunga",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+17','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Loquac. Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Shadow Ring",
    back="Solemnity Cape"}

    sets.midcast.Protectra = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+19',}},
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+17','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Loquac. Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Shadow Ring",
    back="Solemnity Cape"}

    sets.midcast.Shellra = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+19',}},
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+17','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Loquac. Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Shadow Ring",
    back="Solemnity Cape"}


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

    sets.midcast['Dark Magic'] = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+19',}},
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Inyanga Tiara +2",
    body="Inyanga Jubbah +2",
    hands="Regal Cuffs",
    legs={ name="Chironic Hose", augments={'Mag. Acc.+30','AGI+5','Accuracy+13 Attack+13','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    feet="Skaoi Boots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Alaunus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Bunzi's Hat",
    body="Shamash Robe",
    hands="Bunzi's Gloves",
    legs={ name="Chironic Hose", augments={'Mag. Acc.+30','AGI+5','Accuracy+13 Attack+13','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    feet="Bunzi's Sabots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}}}

    sets.midcast.IntEnfeebles = {main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Bunzi's Hat",
    body="Shamash Robe",
    hands="Bunzi's Gloves",
    legs={ name="Chironic Hose", augments={'Mag. Acc.+30','AGI+5','Accuracy+13 Attack+13','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    feet="Bunzi's Sabots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}}}
	
	sets.midcast['Dia'] = {
    main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Bunzi's Hat",
    body="Shamash Robe",
    hands="Bunzi's Gloves",
    legs={ name="Chironic Hose", augments={'Mag. Acc.+30','AGI+5','Accuracy+13 Attack+13','Mag. Acc.+15 "Mag.Atk.Bns."+15',}},
    feet="Bunzi's Sabots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}}}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head="Volte Beret",
    body="Shamash Robe",
    hands={ name="Chironic Gloves", augments={'Pet: STR+7','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3',}},
    legs="Assid. Pants +1",
    feet={ name="Chironic Slippers", augments={'"Resist Silence"+10','Magic dmg. taken -2%','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Glorious Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Moonlight Cape"}

    sets.idle.PDT = {main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head="Nyame helm",
    body="Shamash Robe",
    hands={ name="Chironic Gloves", augments={'Pet: STR+7','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3',}},
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Hearty Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Moonlight Cape"}
	
	sets.idle.Town = {main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Chironic Hat", augments={'Spell interruption rate down -4%','Attack+12','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
    body="Shamash Robe",
    hands={ name="Chironic Gloves", augments={'Pet: STR+7','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3',}},
    legs="Assid. Pants +1",
    feet={ name="Chironic Slippers", augments={'"Resist Silence"+10','Magic dmg. taken -2%','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck="Sanctity Necklace",
    waist="Luminary Sash",
    left_ear="Hearty Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Moonlight Cape"}
		
    sets.idle.Weak = {main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Chironic Hat", augments={'Spell interruption rate down -4%','Attack+12','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
    body="Shamash Robe",
    hands={ name="Chironic Gloves", augments={'Pet: STR+7','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3',}},
    legs="Inyanga Shalwar +2",
    feet={ name="Chironic Slippers", augments={'"Resist Silence"+10','Magic dmg. taken -2%','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Hearty Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Breath dmg. taken -3%','Phys. dmg. taken -5%','Magic dmg. taken -4%',}},
    back="Moonlight Cape"}
		
    -- Defense sets

    sets.defense.PDT = {main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Chironic Hat", augments={'Spell interruption rate down -4%','Attack+12','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
    body="Shamash Robe",
    hands={ name="Chironic Gloves", augments={'Pet: STR+7','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3',}},
    legs="Inyanga Shalwar +2",
    feet={ name="Chironic Slippers", augments={'"Resist Silence"+10','Magic dmg. taken -2%','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Hearty Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Breath dmg. taken -3%','Phys. dmg. taken -5%','Magic dmg. taken -4%',}},
    back="Moonlight Cape"}

    sets.defense.MDT = {main="Bolelabunga",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Chironic Hat", augments={'Spell interruption rate down -4%','Attack+12','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
    body="Shamash Robe",
    hands={ name="Chironic Gloves", augments={'Pet: STR+7','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3',}},
    legs="Inyanga Shalwar +2",
    feet={ name="Chironic Slippers", augments={'"Resist Silence"+10','Magic dmg. taken -2%','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Hearty Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Breath dmg. taken -3%','Phys. dmg. taken -5%','Magic dmg. taken -4%',}},
    back="Moonlight Cape"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
    ammo="White tathlum",
    head="Aya. Zucchetto +2",
    body={ name="Telchine Chas.", augments={'Accuracy+19','"Store TP"+4',}},
    hands={ name="Telchine Gloves", augments={'Accuracy+19','"Store TP"+5',}},
    legs="Aya. Cosciales +2",
    feet="Battlecast gaiters",
    neck="Asperity Necklace",
    waist="Goading Belt",
    left_ear="Telos Earring",
    right_ear="Eabani Earring",
    left_ring="Chirich Ring",
    right_ring="Petrov Ring",
	 back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}

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
    right_ear="Moonshade Earring",
    left_ring="Rufescent Ring",
    right_ring="Petrov Ring",
    back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
	sets.precast.WS['Realmrazer'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Duckbills +3",
    feet="Piety Duckbills +3",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Regal Earring",
    right_ear="Moonshade Earring",
    left_ring="Rufescent Ring",
    right_ring="Petrov Ring",
    back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	

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
    right_ear="Moonshade Earring",
    left_ring="Ilabrat Ring",
    right_ring="Chirich Ring",
    back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
	sets.precast.WS['Randgrith'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Pantaloons +3",
    feet="Piety Duckbills +3",
    neck="Caro Necklace",
    waist="Prosilio belt +1",
    left_ear="Regal Earring",
    right_ear="Ishvara Earring",
    left_ring="Rufescent Ring",
    right_ring="Epaminodas's Ring",
    back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}
	
	sets.precast.WS['Black Halo'] ={
    ammo="Amar Cluster",
    head="Piety cap +3",
    body="Piety Briault +3",
    hands="Piety mitts +3",
    legs="Piety Pantaloons +3",
    feet="Piety Duckbills +3",
    neck="Nuna Gorget +1",
    waist="Luminary belt",
    left_ear="Regal Earring",
    right_ear="Moonshade Earring",
    left_ring="Epaminodas's Ring",
    right_ring="Rufescent Ring",
    back={ name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Damage taken-5%',}}}


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
    set_macro_page(1, 2)
end