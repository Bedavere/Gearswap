-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
--Notes: Need to work on Impact Midcast
--
--
--
------------------BEDAVERE.lua-------------------------------------------------------------------------------------
require("no_interruptions")

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')

end

-- Spells List

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')       --F9
    state.CastingMode:options('Normal', 'Resistant')  --Window + F11
    state.IdleMode:options('Normal', 'PDT')           --Window + F12
	
	 state.MagicBurst = M(false, 'Magic Burst')
	 
	 -- Additional local binds
	 
	 send_command('bind @` gs c toggle MagicBurst')
end	
	include('organizer-lib')
-- Define sets and vars used by this job file.
function init_gear_sets()

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic +3"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}

    -- Fast cast sets for spells
	

    sets.precast.FC = {
    ammo="Sapience Orb",
    head="Amalric Coif +1",
    body="Zendik Robe",
    hands="Nyame Gauntlets",
    legs="Geomancy Pants +3",
    feet={ name="Merlinic Crackows", augments={'INT+2','"Blood Pact" ability delay -3','"Refresh"+2',}},
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Etiolation Earring",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back="Fi Follet Cape +1"}
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
	ammo="Sapience Orb",
    body="Twilight cloak",
    hands="Nyame gauntlets",
    legs="Geomancy Pants +3",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Occult Acumen"+10','INT+9','Mag. Acc.+4','"Mag.Atk.Bns."+14',}},
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back="Fi Follet Cape +1"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",body="Heka's Kalasiris",back="Pahtli Cape"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +1",ear1="Barkarole Earring"})
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Black Halo'] = {ammo="Oshasha's treatise",
	head={ name="Nyame Helm", augments={'Path: B',}},
    body="Nyame Mail",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Regal Earring",
    right_ear="Telos earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%','Spell interruption rate down-10%',}}}
	
    sets.precast.WS['Flash Nova'] = {ammo="Ghastly Tathlum +1",
    head="Helios Band",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Barkarole Earring",
    body="Amalric Doublet",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Strendu Ring",
    back="Seshaw Cape",waist="Snow Belt",legs="Hagondes Pants",feet="Helios Boots"}

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
	



    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {ammo="Sapience Orb",
    head="Amalric Coif +1",
    body="Zendik Robe",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Geomancy Pants +3",
    feet={ name="Merlinic Crackows", augments={'INT+2','"Blood Pact" ability delay -3','"Refresh"+2',}},
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Malignance Earring",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back="Fi Follet Cape +1"}
	
	sets.midcast.EnfeeblingMagic = {main="Contemplator +1",
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head="Geo. Galero +3",
    body="Geomancy Tunic +3",
    hands="Regal Cuffs",
    legs="Geomancy Pants +3",
    feet="Bagua Sandals +3",
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},}
	
	sets.midcast.Drain = {main="Rubicundity",sub="Genbu's Shield",ammo="Hydrocera",
    head="Bagua Galero +1",neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Hirudinea Earring",
    body="Azimuth Coat +1",hands="Jhakri Cuffs +1",ring1="Archon Ring",ring2="Evanescence Ring",
    back="Ogapepo Cape",waist="Fucho-no-Obi",legs="Azimuth Tights +1",feet=MerlinicFeetFree}
		
	sets.midcast.Aspir = sets.midcast.Drain	

    sets.midcast.Geomancy = {main="Idris",range="Dunna",head="Azimuth Hood +1",body="Bagua Tunic",hands="Geomancy Mitaines +1",
	feet="Medium's Sabots",back="Lifestream Cape",ring1="Renaye Ring",neck="Melic Torque"}
	
    sets.midcast.Geomancy.Indi = {main="Idris",range="Dunna",head="Azimuth Hood +1",body="Bagua Tunic",hands="Geomancy Mitaines +1",
	legs="Bagua Pants +3",feet="Azimuth Gaiters",back="Nantosuelta's Cape",ring1="Renaye Ring",neck="Melic Torque"}
	
	sets.midcast['Elemental Magic'] = {
	main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Agwu's cap",
    body="Ea houppelande",
    hands="Agwu's gages",
    legs="Ea slops",
    feet="Agwu's pigaches",
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-obi",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Shiva Ring +1",
    right_ring="Freke Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}}
	
	sets.midcast.Impact = {          --------------Working as of 4/14/2022
	main={ name="Contemplator +1", augments={'Path: A',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    body="Crepuscular Cloak",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Geomancy Pants +3",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Erra Pendant",
    waist="Sacro Cord",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}}}

    sets.midcast.Cure = {
	main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Fi Follet Cape +1"}
    
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast['Enfeebling Magic'] = {                 -----------Add Spell Specific Enfeebles Later.
	main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Geo. Galero +3",
    body="Geomancy Tunic +3",
    hands="Regal Cuffs",
    legs="Geomancy Pants +3",
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
    neck="Erra Pendant",
    waist="Isa Belt",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Nantosuelta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%','Spell interruption rate down-10%',}}}
	
	sets.midcast['Enhancing Magic'] = {
	main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands="Regal cuffs",
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Fi Follet Cape +1"}
	
	sets.midcast.Phalanx = {
	main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Fi Follet Cape +1"}
	
	sets.midcast.Aquaveil = {
	main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Amalric coif +1",
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs="Shedir seraweels",
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Fi Follet Cape +1"}
	
	sets.midcast.Haste = {
	main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Fi Follet Cape +1"}
	
	sets.midcast.Refresh = {
	main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Fi Follet Cape +1"}

    sets.midcast.Protectra = {
	main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Fi Follet Cape +1"}
	
	sets.midcast.Stoneskin = {neck="Nodens Gorget",waist="Siegel Sash",legs="Shedir seraweels"}

    sets.midcast.Shellra = {
	main="Gada",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Fi Follet Cape +1"}
	
	-- Set for Magic Burst Only
	
	sets.magic_burst = {
	main="Idris",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Ea Hat",
    body="Ea Houppelande",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs="Ea Slops",
    feet="Ea Pigaches",
    neck="Mizu. Kubikazari",
    waist="Hachirin-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Regal Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
        body="Jhakri Robe +1",hands="Merlinic Dastanas",ring1="Renaye Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Assiduity Pants +1",feet="Chelona Boots"}


    -- Idle sets

    sets.idle = {
	main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head="Volte Beret",
    body="Shamash Robe",
    hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+23','STR+2','"Refresh"+2',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Merlinic Crackows", augments={'INT+2','"Blood Pact" ability delay -3','"Refresh"+2',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Moonlight Cape"}

    sets.idle.PDT = {
	main="Daybreak",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head="Volte Beret",
    body="Shamash Robe",
    hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+23','STR+2','"Refresh"+2',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Merlinic Crackows", augments={'INT+2','"Blood Pact" ability delay -3','"Refresh"+2',}},
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Moonlight Cape"}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {
	main="Idris",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head="Azimuth Hood +1",
    body="Shamash Robe",
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}}

    sets.idle.PDT.Pet = {
	main="Idris",
    sub="Genmei Shield",
    ammo="Staunch Tathlum +1",
    head="Azimuth Hood +1",
    body="Shamash Robe",
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    legs="Nyame flanchard",
    feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}}

    sets.idle.Town = {
	main="Daybreak",
    sub="Genmei Shield",
    ammo="Sapience orb",
    head="Volte beret",
    body="Shamash Robe",
    hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+23','STR+2','"Refresh"+2',}},
    legs="Assid. Pants +1",
    feet={ name="Merlinic Crackows", augments={'INT+2','"Blood Pact" ability delay -3','"Refresh"+2',}},
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
	left_ear="Etiolation Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Moonlight Cape"}

    sets.idle.Weak = {
	main="Idris",
    sub="Genmei Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Geomancy Tunic +3",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+17','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+21','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque",
    waist="Isa Belt",
    left_ear="Handler's Earring +1",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}
    -- Defense sets

    sets.defense.PDT = {main="Solstice",sub="Genmei Shield",range="Dunna",
	head="Befouled Crown",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    body="Jhakri Robe +2",hands="Bagua Mitaines +1",ring1="Renaye Ring",ring2="Defending Ring",
    back="Umbra Cape",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}

    sets.defense.MDT = {main="Solstice",sub="Genmei Shield",range="Dunna",
	head="Befouled Crown",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    body="Jhakri Robe +2",hands="Bagua Mitaines +1",ring1="Renaye Ring",ring2="Defending Ring",
    back="Umbra Cape",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------
	sets.engaged.Normal = {
	main="Maxentius",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Combatant's Torque",
    waist="Fucho-no-Obi",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}}
	
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end
 




function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
	
	if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
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
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

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

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
		equip(sets.midcast.EnfeeblingMagic)
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
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
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
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