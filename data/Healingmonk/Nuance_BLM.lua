-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
 
end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- If you're new to gearswap, the F9~12 keys and CTRL keys in combination is how you activate this stuff.

function job_setup()
    state.OffenseMode:options('Normal', 'None', 'Locked')
    state.CastingMode:options('BURST', 'OccultAcumen', 'FreeNuke', 'FreeNukeACC')
    state.IdleMode:options('Normal', 'PDT', "Death")
	state.VorsealMode = M('Normal', 'Vorseal')
	state.ManawallMode = M('Swaps', 'No_Swaps')
	state.Enfeebling = M('None')
	--Vorseal mode is handled simply when zoning into an escha zone--
    state.Moving  = M(false, "moving")
   

    element_table = L{'Earth','Wind','Ice','Fire','Water','Lightning'}

 
    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
 
    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V','Fire VI'},
        ['Firega'] = {'Firaga','Firaga II','Firaga III','Firaja'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V','Blizzard VI'},
        ['Icega'] = {'Blizzaga','Blizzaga II','Blizzaga III','Blizzaja'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V','Aero VI'},
        ['Windga'] = {'Aeroga','Aeroga II','Aeroga III','Aeroja'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V','Stone VI'},
        ['Earthga'] = {'Stonega','Stonega II','Stonega III','Stoneja'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V','Thunder VI'},
        ['Lightningga'] = {'Thundaga','Thundaga II','Thundaga III','Thundaja'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V','Water VI'},
        ['Waterga'] = {'Waterga','Waterga II','Waterga III','Waterja'},
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
        ['Sleepgas'] = {'Sleepga','Sleepga II'}}
	
	
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f11 gs c cycle CastingMode')
	send_command('bind ^f11 gs c cycle Enfeebling')
	send_command('bind f12 gs c cycle ManawallMode')
    organizer_items = {aeonic="Khatvanga"}
    select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
	send_command('unbind f10')
	send_command('unbind ^`f11')
	send_command('unbind @`f11')
	send_command('unbind ^f11')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
	--------------------------------------
    -- Augments
    --------------------------------------
	Laevateinn = {}
	Laevateinn.ENF = {}
    Laevateinn.ENF = {name="Laevateinn", augments={'Enfb.mag. skill +16','MND+13','Mag. Acc.+23'}}
    Laevateinn.Death = {name="Laevateinn", augments={'MP+99','Mag. Acc.+28','"Mag.Atk.Bns."+26'}}
	
	Taranus = {}
	Taranus.Idle = {}
	Taranus.Idle = {name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Fast Cast"+10','Damage taken-5%'}}
	Taranus.NUKE = {name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10'}}
	
	Merlinic = {}
	Merlinic.FC = {}
	Merlinic.FC = {name="Merlinic Jubbah", augments={'Mag. Acc.+22','"Fast Cast"+5','"Mag.Atk.Bns."+10'}}

	
    ---- Precast Sets ----
    
	sets.precast.WS = {
        head="Archmage's Petasos +3",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Barkarole Earring",
        body="Archmage's Coat +3",hands="Archmage's Gloves +3",ring1="Mephitas's Ring",ring2="Mephitas's Ring +1",
        back=Taranus.Idle,waist="Fotia Belt",legs="Archmage's Tonban +3",feet="Archmage's Sabots +3"}
	
    sets.precast.WS['Myrkr'] = {
        head="Pixie Hairpin +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Barkarole Earring",
        body="Amalric Doublet +1",hands="Amalric Gages +1",ring1="Mephitas's Ring",ring2="Mephitas's Ring +1",
        back=Taranus.Idle,waist="Fotia Belt",legs="Amalric Slops +1",feet="Amalric Nails +1"}

	sets.precast.WS['Vidohunir'] = {
        head="Pixie Hairpin +1",neck="Fotia Gorget",ear1="Regal Earring",ear2="Barkarole Earring",
        body="Archmage's Coat +3",hands="Archmage's Gloves +3",ring1="Archon Ring",ring2="Shiva Ring +1",
        back=Taranus.Nuke,waist="Fotia Belt",legs="Archmage's Tonban +3",feet="Archmage's Sabots +3"}
	 
    -- Precast sets to enhance JAs
	
    sets.precast.JA['Mana Wall'] = {back="Taranus's cape",feet="Wicce Sabots +1"}
 
    sets.precast.JA.Manafont = {body="Archmage's Coat +3"}
	
    -- Base precast Fast Cast set, this set will have to show up many times in the function section of the lua
	-- So dont forget to do that.
 
    sets.precast.FC = {
		ammo="Sapience Orb", --2
        head="Amalric Coif +1", --11
		neck="Voltsurge Torque", --4
		ear1="Enchanter Earring +1", -- 2
		ear2="Loquacious Earring", --5
        body="Zendik Robe", --13
		hands="Volte gloves", --6
		ring1="Kishar Ring", --4
		ring2="Rahab Ring", --2
        back=Taranus.Idle, --10
		waist="Witful Belt", --3
		legs="Volt Brais", --8
		feet="Amalric Nails +1"} --6
		
	sets.precast['Impact'] = {
		ammo="Sapience Orb",
        head=empty,
		neck="Voltsurge Torque",
		ear1="Enchant Earring",
		ear2="Loquacious Earring",
        body="Twilight Cloak",
		hands="Volte gloves",
		ring1="Prolix Ring",
		ring2="Rahab Ring",
        back=Taranus.Idle,
		waist="Witful Belt",
		legs="Volte Brais",
		feet="Amalric Nails +1"}
		
    sets.precast['Death'] = {
		ammo="Strobilus",
        head="Amalric Coif +1",
		neck="Voltsurge Torque",
		ear1="Enchant Earring",
		ear2="Loquacious Earring",
        body="Zendik Robe",
		hands="Otomi Gloves",
		ring1="Mephitas Ring +1",
		ring2="Rahab Ring",
        back=Taranus.Idle,
		waist="Witful Belt",
		legs="Psycloth Lappas",
		feet="Amalric Nails +1"}
				
	sets.precast.FC.HighMP = {
		ammo="Sapience Orb",
        head="Amalric Coif +1",
		neck="Voltsurge Torque",
		ear1="Enchant Earring",
		ear2="Loquacious Earring",
        body="Shango Robe",
		hands="Volte gloves",
		ring1="Prolix Ring",
		ring2="Rahab Ring",
        back=Taranus.Idle,
		waist="Witful Belt",
		legs="Volte Brais",
		feet="Amalric Nails +1"}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Enfeebling Magic'] = sets.precast.FC
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole earring"})
    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {body="Heka's Kalasiris",legs="Doyen pants", back="Pahtli Cape"})
 
    -- Midcast set for Death, Might as well only have one set, unless you plan on free-nuking death for some unexplainable reason.

    sets.midcast['Death'] = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Strobilus",
		head="Pixie Hairpin +1",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Sorcerer's Stole +2",
		waist="Yamabuki-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Regal Earring",
		right_ring="Archon Ring",
		left_ring="Mephitas's Ring +1",
		back=Taranus.Idle}
 
    sets.midcast['Death'].FreeNuke = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Strobilus",
		head="Pixie Hairpin +1",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Sorcerer's Stole +2",
		waist="Yamabuki-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Regal Earring",
		right_ring="Archon Ring",
		left_ring="Mephitas's Ring +1",
		back=Taranus.Idle} 
 
    ---- Midcast Sets ----
    sets.midcast.FastRecast = {}
 
    sets.midcast['Healing Magic'] = {}

    sets.midcast['Enhancing Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Telchine Cap",
		body="Telchine Chas.",
		hands="Telchine Gloves",
		legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
		feet="Telchine Pigaches",
		neck="Loricate Torque +1",
		waist="Gishdubar Sash",
		left_ear="Hearty Earring",
		right_ear="Dominance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=Taranus.Idle}
	
	sets.midcast.Mana_Wall_No_Swap = {
		main="Malignance Pole",
		sub="Kaja Grip",
		ammo="Staunch Tathlum +1",
		head="Archmage's Petasos +3",
		body="Shamash Robe",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Wicce Sabots +1",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back=Taranus.Idle}
	
	-- I personally do not have gear to alter these abilities as of the time of disseminating this file, but 
	-- definitely add them here if you have them.
 
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {feet="Inspirited Boots",waist="Gishdubar Sash"})
	
    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {})
	
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})
	
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",
		neck="Nodens Gorget",
		hands="Telchine Gloves",
		legs="Shedir Seraweels",
		ear2="Earthcry Earring"})
 
    sets.midcast['Enfeebling Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		body="Spaekona's Coat +3",
		hands="Ea Cuffs +1",
		legs="Ea Slops +1",
		feet="Medium's Sabots",
		neck="Sorcerer's Stole +2",
		waist="Eschan Stone",
		left_ear="Barkaro. Earring",
		right_ear="Dignitary's Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back=Taranus.NUKE}   

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {feet="Archmage's Sabots +3"})
 
    sets.midcast['Dark Magic'] = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Spaekona's Coat +3",
		hands="Jhakri cuffs +1",
		legs="Ea Slops +1",
		feet="Merlinic Crackows",
		neck="Sorcerer's Stole +2",
		waist="Fucho-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Dignitary's Earring",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring +1",
		back=Taranus.NUKE}
 
    -- Elemental Magic sets
     
	sets.midcast['Elemental Magic'] = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Ea Hat +1",
		body="Ea Houppelande +1",
		hands="Amalric Gages +1",
		legs="Ea Slops +1",
		feet="Amalric Nails +1",
		neck="Sorcerer's Stole +2",
		waist="Sacro Cord",
		ear2="Regal Earring",
		ear1="Malignance Earring",
		ring1="Mujin Band",
		ring2="Freke Ring",
		back=Taranus.NUKE}
	
    sets.midcast['Elemental Magic'].FreeNuke = set_combine(sets.midcast['Elemental Magic'], {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Baetyl Pendant",
		waist="Sacro Cord",
		ear2="Regal Earring",
		ear1="Malignance Earring",
		ring1="Freke Ring",
		ring2="Shiva Ring +1",
		back=Taranus.NUKE})
	
	sets.midcast['Elemental Magic'].FreeNukeACC = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",
		body="Archmage's Coat +3",
		hands="Archmage's Gloves +3",
		legs="Archmage's Tonban +3",
		feet="Archmage's Sabots +3",
		neck="Sorcerer's Stole +2",
		waist="Sacro Cord",
		ear2="Friomisi Earring",
		ear1="Malignance Earring",
		ring1="Shiva Ring +1",
		ring2="Freke Ring",
		back=Taranus.NUKE})		
		
    sets.midcast['Elemental Magic'].OccultAcumen = set_combine(sets.midcast['Elemental Magic'].HighTierNuke, {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Seraphic Ampulla",
		head="Mallquis Chapeau +1",
		body="Spaekona's Coat +3",
		hands="Amalric Gages +1",
		legs="Perdition Slops",
		feet="Amalric Nails +1",
		neck="Combatant's Torque",
		waist="Oneiros Rope",
		ear2="Dedition Earring",
		ear1="Telos Earring",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back=Taranus.NUKE})
		
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
	
    sets.midcast['Elemental Magic'].HighTierNuke.FreeNuke = set_combine(sets.midcast['Elemental Magic'].FreeNuke, {})
		
	sets.midcast['Elemental Magic'].HighTierNuke.FreeNukeACC = set_combine(sets.midcast['Elemental Magic'].FreeNukeACC, {})	
				
    sets.midcast['Elemental Magic'].HighTierNuke.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {})
		
    sets.midcast['Impact'] = {
		main="Laevateinn",
		sub="Niobid Strap",
		head=empty,
		body="Twilight Cloak",
		hands="Jhakri cuffs +2",
		legs="Ea Slops +1",
		feet="Jhakri Pigaches +2",
		neck="Sorcerer's Stole +2",
		waist="Eschan Stone",
		ear2="Dignitary's Earring",
		ear1="Barkaro. Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back=Taranus.NUKE}
		
	sets.midcast['Impact'].OccultAcumen = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head=empty,
		body="Twilight Cloak",
		hands="Jhakri cuffs +2",
		legs="Perdition Slops",
		feet="Jhakri Pigaches +2",
		neck="Combatant's Torque",
		waist="Oneiros Rope",
		ear2="Dedition Earring",
		ear1="Telos Earring",
		ring1="Chirich Ring +1",
		ring2="Chirich Ring +1",
		back=Taranus.NUKE}
	
	sets.midcast['Comet'] = set_combine(sets.midcast['Elemental Magic'], {
		head="Pixie Hairpin +1",
		ring2="Archon Ring"})
 
	sets.midcast['Comet'].FreeNuke = set_combine(sets.midcast['Elemental Magic'], {
		head="Pixie Hairpin +1",
		ring2="Archon Ring"})
	
	sets.midcast.Klimaform = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Saevus Pendant +1",
		waist="Sacro Cord",
		ear2="Friomisi Earring",
		ear1="Barkaro. Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back=Taranus.NUKE}
	
-- These next two sets are used later in the functions to determine what gear will be used in High MP and Low MP situations
-- SPECIFICALLY for Aspir spells.  In the LowMP set, put your best Aspir+ gear, in the other set put your best Max MP gear.
-- Find out how much your maximum MP is in each set, and adjust the MP values in the function area accordingly
-- (CTRL+F: Aspir Handling)

	sets.midcast.HighMP = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",
		body="Ea Houppelande +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Sorcerer's Stole +2",
		waist="Sacro Cord",
		ear2="Friomisi Earring",
		ear1="Barkaro. Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back=Taranus.NUKE}
 
	sets.midcast.LowMP = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head="Archmage's Petasos +3",
		body="Archmage's Coat +3",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Sorcerer's Stole +2",
		waist="Sacro Cord",
		ear2="Friomisi Earring",
		ear1="Barkaro. Earring",
		ring1="Shiva Ring +1",
		ring2="Shiva Ring +1",
		back=Taranus.NUKE}
		
	
		
    --Set to be equipped when Day/Weather match current spell element

	sets.Obi = {waist="Hachirin-no-Obi",}
	
	-- I actually have two references to equip this item, just in case your globals are out of date.
 
    -- Resting sets
	
    sets.resting = {}
 
    -- Idle sets: Make general idle set a max MP set, later hooks will handle the rest of your refresh sets, but
	-- remember to alter the refresh sets (Ctrl+F to find them)

    sets.idle = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Staunch Tathlum +1",
		head="Volte Beret",
		body="Shamash Robe",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Amalric Nails +1",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back=Taranus.Idle}
 
    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Staunch Tathlum +1",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Mallquis Clogs +1",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		ring1="Stikini Ring +1",
		ring2="Defending Ring",
		back=Taranus.Idle}
		
	sets.idle.Death = {
		main=Laevateinn.Death,
		sub="Niobid Strap",
		ammo="Strobilus",
		head="Amalric Coif +1",
		body="Amalric Doublet +1",
		hands="Otomi Gloves",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Barkarole Earring",
		ear2="Etiolation Earring",
		ring1="Mephitas's Ring +1",
		ring2="Defending Ring",
		back=Taranus.Idle}
		
    sets.Adoulin = {body="Councilor's Garb",}

    sets.MoveSpeed = {feet="Crier's Gaiters"}
    
    sets.TreasureHunter = {waist="Chaac Belt"}
 
    -- Set for Conserve MP toggle, convert damage to MP body.
	
    sets.AFBody = {body="Spaekona's Coat +3"}
 
    --- PDT set is designed to be used for MP total set, MDT can be used for whatever you like but in MDT mode
	--- the player.mp arguments will likely stop working properly
	
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Archmage's Petasos +3",
		body="Shamash Robe",
		hands="Hagondes Cuffs +1",
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -4%',}},
		feet="Mallquis Clogs +2",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		left1="Stikini Ring +1",
		ring2="Defending Ring",
		back=Taranus.Idle}
 
    sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Befouled Crown",
		body="Mallquis Saio +2",
		hands="Volte Gloves",
		legs="Archmage's Tonban +3",
		feet="Mallquis Clogs +2",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		ring1="Sheltered Ring",
		ring2="Defending Ring",
		back=Taranus.Idle}
		
    sets.Kiting = {feet="Crier's Gaiters"}
	
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	
	sets.auto_refresh = {
		main="Laevateinn",
		sub="Niobid Strap",
		ammo="Staunch Tathlum +1",
		head="Volte Beret",
		body="Shamash Robe",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Amalric Nails +1",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		ring1="Stikini Ring +1",
		ring2="Stikini Ring +1",
		back=Taranus.Idle}
		
    -- Mana Wall idle set

    sets.buff['Mana Wall'] = {
		main="Mafic Cudgel",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Archmage's Petasos +3",
		body="Shamash Robe",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Wicce Sabots +1",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back=Taranus.Idle}
		
	sets.midcast.Cure = {
		head="Vanya Hood",
		body="Vanya Robe",
		hands="Telchine Gloves",
		legs="Vanya Slops",
		feet="Medium's Sabots",
		neck="Incanter's Torque",
		waist="Slipor Sash",
		left_ear="Mendicant's Earring",
		right_ear="Beatific Earring",
		left_ring="Janniston Ring",
		right_ring="Lebeche Ring",
		back="Oretania's Cape +1",}
	
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {waist="Gishdubar Sash"})
    
	-- Engaged sets
	
	sets.engaged = {
		ammo="Staunch Tathlum +1",
		head="Archmage's Petasos +3",
		body="Mallquis Saio +2",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Mallquis Clogs +2",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		left1="Stikini Ring +1",
		ring2="Defending Ring",
		back=Taranus.Idle}
		
	sets.engaged.Normal = {
		ammo="Staunch Tathlum +1",
		head="Archmage's Petasos +3",
		body="Mallquis Saio +2",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Mallquis Clogs +2",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		left1="Stikini Ring +1",
		ring2="Defending Ring",
		back=Taranus.Idle}
		
	sets.engaged.None = {
		ammo="Staunch Tathlum +1",
		head="Archmage's Petasos +3",
		body="Mallquis Saio +2",
		hands="Volte Gloves",
		legs="Volte Brais",
		feet="Mallquis Clogs +2",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		ear1="Genmei Earring",
		ear2="Etiolation Earring",
		left1="Stikini Ring +1",
		ring2="Defending Ring",
		back=Taranus.Idle}
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
--- Define MP and buff specific Fast Cast and Midcast sets for conservation of MP for death sets, most will be
--- handled on thier own. What you need to change is the player.mp value to match slightly under what your max
--- MP is in your standard fast cast set. The set is designed to Dynamically switch fast cast sets to sets that
--- preserve your MP total if you are above the amount at which equiping your standard set would decrease your
--- maximum MP. Due to a rework in how these arguments are organised, all gearsets are being handled above the
--- function block for this file.
 
function job_precast(spell, action, spellMap, eventArgs)
    enable('feet','back')	
	if spell.english == "Impact" then
		sets.precast.FC = sets.precast['Impact']
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
	if player.mp > 2000 and state.VorsealMode.value == 'Vorseal' then
	equip(sets.precast.FC.HighMP)
	elseif player.mp < 2000 and state.VorsealMode.value == 'Vorseal' then
	equip(sets.precast.FC)
	elseif player.mp > 1650 and state.VorsealMode.value == 'Normal' then
	equip(sets.precast.FC.HighMP)
	elseif player.mp < 1650 and state.VorsealMode.value == 'Normal' then
	equip(sets.precast.FC)
    end
end


 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

	
	if spell.english == 'Jettatura' or spell.english == 'Geist Wall' 
	or spell.english == 'Soporific' or spell.english == 'Blank Gaze' 
	or spell.english == 'Sheep Song' or spell.english == 'Chaotic Eye' 
	or spell.english == 'Cursed Sphere' or spell.english == 'Flash' then
	equip(sets.midcast.Flash)
	end
	
    if spell.english == 'Death' then
        equip(sets.midcast['Death'])
	end
	
	if spell.english == "Impact" then
        equip({head=empty,body="Twilight Cloak"})
    end
	
end


-- Aspir Handling
 
-- This section is for you to define at what value your Aspir sets will change. This is to let your aspirs
-- get you into your death idle and higher MP values. This number should be around 100 MP lower than the
-- Fast cast argument above this to prevent looping. The intent is to ensure that if you use aspir while you
-- are already above a value defined in this section then it will put on your highest MP set, capping you off
-- rather than simply capping you to whatever your Aspir potency set's max MP value happens to be.

function job_post_midcast(spell, action, spellMap, eventArgs)
	
	if (spell.skill == 'Elemental Magic' or spell.skill == 'Healing Magic') and (spell.element == world.weather_element or spell.element == world.day_element) then
        equip(sets.Obi)
	end
	
	
	if spell.english == 'Aspir' or spell.english == 'Aspir II' or spell.english == 'Aspir III' and state.VorsealMode.value == 'Vorseal' and player.mp > 1765 then
		equip(sets.midcast.HighMP)
	elseif spell.english == 'Aspir' or spell.english == 'Aspir II' or spell.english == 'Aspir III' and state.VorsealMode.value == 'Vorseal' and player.mp < 1765 then
		equip(sets.midcast.LowMP)
	elseif spell.english == 'Aspir' or spell.english == 'Aspir II' or spell.english == 'Aspir III' and state.VorsealMode.value == 'Normal' and player.mp > 1580 then
		equip(sets.midcast.HighMP)
	elseif spell.english == 'Aspir' or spell.english == 'Aspir II' or spell.english == 'Aspir III' and state.VorsealMode.value == 'Normal' and player.mp < 1580 then
		equip(sets.midcast.LowMP)
	end
	
    if spell.element == world.day_element or spell.element == world.weather_element then
        if string.find(spell.english,'helix') then
            equip(sets.midcast.Helix)
        else 
            equip(sets.Obi)
        end
    end
	if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and (player.mp-spell.mp_cost) < 436 then
		equip(sets.AFBody)
	end
		
	if spell.skill == 'Enfeebling Magic' and state.Enfeebling.Value == 'Effect' then
		equip(sets.midcast['Enfeebling Magic'].Effect)
	end
	
	if spell.skill == 'Elemental Magic' and (string.find(spell.english,'ga') or string.find(spell.english,'ja') or string.find(spell.english,'ra')) then
            equip(sets.AFBody)
	end
	
	if spellMap == 'Cure' and state.ManawallMode.Value == 'No_Swaps' then
		equip(sets.midcast.Mana_Wall_No_Swap)
	elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
	end
	
	if spell.skill == 'Enhancing Magic' and state.ManawallMode.Value == 'No_Swaps' then
		equip(sets.midcast.Mana_Wall_No_Swap)
	end
end
 
-- Duration arguments
-- Below you can include wait inputs for all spells that you are interested in having timers for
-- For the sake of brevity, I've only included crowd control spells into this list, but following
-- the same general format you should be able to intuitively include whatever you like.
 
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if buffactive['Mana Wall'] then
        enable('feet','back')
        equip(sets.buff['Mana Wall'])
        disable('feet','back')
    end
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then -- Sleep II Countdown --
            send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Break" or spell.english == "Breakga" then -- Break Countdown --
            send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Paralyze" then -- Paralyze Countdown --
             send_command('wait 115;input /echo Paralyze Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Slow" then -- Slow Countdown --
            send_command('wait 115;input /echo Slow Effect: [WEARING OFF IN 5 SEC.]')        
        end
    end
	--if buffactive['poison'] then
	--send_command('input /item "antidote" <me>')
	--end
end
 
function nuke(spell, action, spellMap, eventArgs)
    if player.target.type == 'MONSTER' then
        if state.AOE.value then
            send_command('input /ma "'..degrade_array[element_table:append('ga')][#degrade_array[element_table:append('ga')]]..'" '..tostring(player.target.name))
        else
            send_command('input /ma "'..degrade_array[element_table][#degrade_array[element_table]]..'" '..tostring(player.target.name))
        end
    else 
        add_to_chat(5,'A Monster is not targetted.')
    end
end
 
function job_self_command(commandArgs, eventArgs)
    if commandArgs[1] == 'element' then
        if commandArgs[2] then
            if element_table:contains(commandArgs[2]) then
                element_table = commandArgs[2]
                add_to_chat(5, 'Current Nuke element ['..element_table..']')
            else
                add_to_chat(5,'Incorrect Element value')
                return
            end
        else
            add_to_chat(5,'No element specified')
        end
    elseif commandArgs[1] == 'nuke' then
        nuke()
    end
end
 
 
function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir','Aspir II','Aspir III'}
    local sleeps = S{'Sleep','Sleep II'}
    local sleepgas = S{'Sleepga','Sleepga II'}
 
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'
 
    local spell_index
 
end

mov = {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
    mov.x = windower.ffxi.get_mob_by_index(player.index).x
    mov.y = windower.ffxi.get_mob_by_index(player.index).y
    mov.z = windower.ffxi.get_mob_by_index(player.index).z
end

moving = false
windower.raw_register_event('prerender',function()
    mov.counter = mov.counter + 1;
	if buffactive['Mana Wall'] then
		moving = false
    elseif mov.counter>15 then
        local pl = windower.ffxi.get_mob_by_index(player.index)
        if pl and pl.x and mov.x then
            dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
            if dist > 1 and not moving then
                state.Moving.value = true
                send_command('gs c update')
				if world.area:contains("Adoulin") then
                send_command('gs equip sets.Adoulin')
				else
                send_command('gs equip sets.MoveSpeed')
                end

        moving = true

            elseif dist < 1 and moving then
                state.Moving.value = false
                send_command('gs c update')
                moving = false
            end
        end
        if pl and pl.x then
            mov.x = pl.x
            mov.y = pl.y
            mov.z = pl.z
        end
        mov.counter = 0
    end
end)
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	--if buff == "poison" and gain then
	--send_command('input /item "antidote" <me>')
	--end
	if buff == "Vorseal" then
	send_command('gs c cycle VorsealMode')
	elseif buff == "Vorseal" and not gain then
	send_command('gs c cycle VorsealMode')
	end
	if buff == "Visitant" then
	send_command('gs l blm3.lua')
	end
    -- Unlock feet when Mana Wall buff is lost.
	if buff == "Mana Wall" then
	send_command('wait 0.5;gs c update')
	end
    if buff == "Mana Wall" and not gain then
        enable('feet','back')
        handle_equipping_gear(player.status)
    end
    if buff == "Commitment" and not gain then
        equip({ring2="Capacity Ring"})
        if player.equipment.right_ring == "Capacity Ring" then
            disable("ring2")
        else
            enable("ring2")
        end
    end
	if buff == "Vorseal" and gain then
	send_command('input //setbgm 75')
	elseif buff == "Vorseal" and not gain then
	send_command('input //setbgm 251')
	end
end
 
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)

end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
--[[function job_update(cmdParams, eventArgs)
    job_display_current_state(eventArgs)
    eventArgs.handled = true
end]]
 
function display_current_job_state(eventArgs)

end
 
-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end

function get_custom_wsmode(spell, spellMap, ws_mode)
    if spell.type == "WeaponSkill" then
        if sets.precast.WS[spell.name] then
            return sets.precast.WS[spell.name]
        else
            return sets.precast.WS
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if buffactive['Mana Wall'] then
        idleSet = sets.buff['Mana Wall']
	elseif player.mpp < 51 and state.IdleMode.value == 'PDT' then
			idleSet = sets.idle.PDT
	elseif player.mpp < 51 and state.IdleMode.value == 'Normal' then
		idleSet = set_combine(sets.auto_refresh, sets.latent_refresh)		
	elseif player.mp < 1765 and state.VorsealMode.value == 'Vorseal' and state.IdleMode.value == 'PDT' then
			idleSet = sets.idle.PDT
	elseif player.mp < 1765 and state.VorsealMode.value == 'Vorseal' and state.IdleMode.value == 'Normal' then
			idleSet = sets.auto_refresh
	elseif player.mp < 1580 and state.VorsealMode.value == 'Normal' and state.IdleMode.value == 'PDT' then
			idleSet = sets.idle.PDT
	elseif player.mp < 1580 and state.VorsealMode.value == 'Normal' and state.IdleMode.value == 'Normal' then
			idleSet = sets.auto_refresh
	end
    return idleSet
end
--- This is where I handle Death Mode Melee set modifications
function customize_melee_set(meleeSet)
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.buff['Mana Wall'])
    end
    return meleeSet
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(3, 5)
	-- Do not remove below argument or the file WILL NOT WORK PROPERLY when reloaded in an escha area--
	if buffactive['Vorseal'] and state.VorsealMode.value == 'Normal' then
	send_command('gs c cycle VorsealMode')
	end
end

--{{Emulator Backend: log_filter=*:Info}}