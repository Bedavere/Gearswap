-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('Mote-Utility.lua')
end
 
 require("no_interruptions")
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
     
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
 
 
    blue_magic_maps = {}
     
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
     
    -- Physical Spells --
     
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }
	blue_magic_maps.PhysicalStun = S{
		'Head Butt', 'Tail Slap', 'Frypan', 'Whirl of Rage', 'Sudden Lunge'
	}
    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike'
    }
 
    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave','Sweeping Gouge','Saurian Slide'
    }
         
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive',
    }
         
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
         
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Sudden Lunge','Wild Oats'
    }
 
    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }
 
    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }
 
    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }
 
    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }
     
     
    -- Magical Spells --
 
    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Crashing Thunder','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Regurgitation','Rending Deluge',
        'Subduction','Tem. Upheaval','Water Bomb','Crashing Thunder','Nectarous Deluge','Molting Plumage',
		'Spectral Floe','Tearing Gust','Cesspool'
    }
	
	blue_magic_maps.MagicalDarkness = S{
		'Evryone. Grudge','Tenebral Crush','Palling Salvo','Dark Orb','Death Ray','Eyes On Me'
	}
	
	blue_magic_maps.MagicalLight = S{
		'Diffusion Ray','Rail Cannon','Blinding Fulgor', 'Magic Hammer', 'Retinal Glare', '1000 Needles'
	}
    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream', 'Mind Blast', 'Scouring Spate'
    }
	blue_magic_maps.MagicalAgi = S{
		'Silent Storm'
	}
    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Mysterious Light'
    }
 
    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse', 'Entomb'
    }
 
    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades', 'Anvil Lightning'
    }
    blue_magic_maps.MagicalStr = S{
		'Searing Tempest'
	}
	
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        'Absolute Terror','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Light of Penance',
        'Lowing','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Venom Shell','Voracious Trunk','Yawn','Cruel Joke'
    }
 
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

	blue_magic_maps.Enmity = S{
		'Actinic Burst', 'Fantod', 'Jettatura', 'Exuviation', 'Temporal Shift'
	}
	
    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Temporal Shift', 'Thunderbolt'
    }
         
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
     
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Atra. Libations','Blood Drain','Blood Saber','Diamondhide','Digest',
		'Magic Barrier','Metallic Body','MP Drainkiss','Nat. Meditation','Occultation','Osmosis',}
 
    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle','Mighty Guard','Pyric Bulwark', 'Orcish Counterstance', 'Carcharian Verve',
    }
     
     
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Crashing Thunder',
        'Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar','Pyric Bulwark','Thunderbolt',
        'Tourbillion','Uproot','Mighty Guard','Cruel Joke','Cesspool','Tearing Gust'
    }
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'TP', 'Hybrid', 'MidAcc', 'Acc', 'Learning', 'TH', 'PDT')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal','PDT')
	--state.HybridMode:options('Normal', 'Defense')
    --gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
 
    -- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
	send_command('bind f11 input /gs c cycle offensemode')
	
	--alias shortcuts
	
	send_command('alias mf input /ma Magic Fruit')
	send_command('alias ww input /ma White Wind')
	send_command('alias voke input /ja Provoke')
	send_command('alias echoes input /item "Echo Drops" <me>')
	send_command('alias remedy input /item "Remedy" <me>')
	send_command('alias doom input /item "Holy Water" <me>')
    update_combat_form()
    --select_default_macro_book()
	
end
 
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
	send_command('unbind f11')
end
 
 
-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
 
    sets.buff['Burst Affinity'] = {}
    sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +2"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh +1"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {}
    sets.buff.Efflux = {}
 
    sets.Enmity = {ammo="Sapience Orb", head="Rabid Visor", neck="Unmoving Collar", body="Emet Harness +1", ear1="Friomisi Earring", ear2="Cryptic Earring", 
			ring1="Pernicious Ring", ring2="Petrov Ring"} 
    -- Precast Sets
     
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands +2"}
	
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity
	
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
	sets.precast.JA['Lunge'] = {ammo="Pemphredo Tathlum",
        head="Amalric Coif",neck="Sanctity Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric Gages +1",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},waist="Yamabuki-no-obi",legs="Luhlaza shalwar +3",feet="Amalric Nails"}
	
	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']	
		
    -- Fast cast sets for spells
     
    sets.precast.FC = {
    main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Sapience Orb",
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body={ name="Luhlaza Jubbah +1", augments={'Enhances "Enchainment" effect',}},
    hands={ name="Herculean Gloves", augments={'"Fast Cast"+4','Mag. Acc.+8',}},
    legs="Aya. Cosciales +2",
    feet="Carmine Greaves",
    neck="Orunmila's Torque",
    waist="Witful Belt",
    left_ear="Enchntr. Earring +1",
    right_ear="Etiolation Earring",
    left_ring="Prolix Ring",
    right_ring="Vertigo Ring",
    back={ name="Rosmerta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+8','"Fast Cast"+10',}},
}
	
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Luhlaza Jubbah +1"})
 
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
     
    sets.precast.FC['Ninjutsu'] = set_combine(sets.precast.FC, {neck="Magoraga Beads", body="Passion Jacket"})
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Accuracy+25','Weapon skill damage +3%','STR+9',}},
    body="Assim. Jubbah +2",
    hands={ name="Herculean Gloves", augments={'"Dbl.Atk."+1','Pet: "Mag.Atk.Bns."+28','"Refresh"+1','Accuracy+17 Attack+17',}},
    legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+28','Weapon skill damage +4%','STR+10','Attack+7',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Cessance Earring",
    left_ring="Petrov Ring",
    right_ring="Rufescent Ring",
    back={ name="Rosmerta's Cape", augments={'STR+30','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}
    --sets.precast.WS.acc = set_combine(sets.precast.WS, {hands={ name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Crit.hit rate+4','STR+4','Attack+13',}},})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Expiacion'] = {
    main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Accuracy+25','Weapon skill damage +3%','STR+9',}},
    body="Assim. Jubbah +2",
    hands={ name="Herculean Gloves", augments={'Attack+14','Weapon skill damage +3%','STR+4',}},
    legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
    feet={ name="Herculean Boots", augments={'Accuracy+28','Weapon skill damage +4%','STR+10','Attack+7',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Cessance Earring",
    left_ring="Ifrit Ring",
    right_ring="Rufescent Ring",
    back={ name="Rosmerta's Cape", augments={'STR+30','Accuracy+20 Attack+20','Weapon skill damage +10%','Damage taken-5%',}},
}
    sets.precast.WS['Chant du Cygne'] = {
    main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Accuracy+20','Crit. hit damage +4%',}},
    body={ name="Herculean Vest", augments={'Accuracy+28','Crit.hit rate+4','Attack+2',}},
    hands={ name="Herculean Gloves", augments={'Weapon skill damage +2%','DEX+8','Phalanx +4','Accuracy+1 Attack+1',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+27','"Triple Atk."+3','AGI+9',}},
    feet={ name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Petrov Ring",
    right_ring="Ilabrat Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+30','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}

	sets.precast.WS['Chant du Cygne'].TP = set_combine(sets.precast.WS['Expiacion'], {ammo="Falcon Eye",neck="Fotia Gorget", ear1="Mache Earring +1",ear2="Telos Earring",waist="Fotia Belt",
		ring1="Hetairoi Ring",ring2="Epona's Ring",})
    	
	sets.precast.WS['Savage Blade'] = sets.precast.WS['Expiacion']
    --sets.precast.WS['Circle Blade'] = sets.precast.WS['Expiacion']
	
    sets.precast.WS['Requiescat'] = {ammo="Ginsen",
		head="Jhakri Coronal +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +1",ring1="Rufescent Ring",ring2="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+8','"Fast Cast"+10',}},
		waist="Fotia belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
    
    sets.precast.WS['Sanguine Blade'] = {main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Ginsen",
    head={name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
    body={name="Herculean Vest", augments={'Accuracy+15 Attack+15','Crit. hit damage +4%','STR+7','Accuracy+15','Attack+12',}},
    hands={name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={name="Herculean Trousers", augments={'Accuracy+27','"Triple Atk."+3','AGI+9',}},
    feet={name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+3',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Mache Earring",
    right_ear="Brutal Earring",
    left_ring="Adoulin Ring",
    right_ring="Petrov Ring",
    back={name="Rosmerta's Cape", augments={'DEX+30','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}
    sets.precast.WS['Judgment'] = set_combine(sets.precast.WS['Expiacion'], {neck="Fotia Gorget", waist="Fotia Belt"})
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Expiacion'], {neck="Fotia Gorget", waist="Fotia Belt"})
    sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
        head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		waist="Fotia Belt",legs="Luhlaza shalwar +3",feet="Amalric Nails"}
	sets.precast.WS['Seraph Blade'] = sets.precast.WS['Flash Nova']
	sets.precast.WS['Shining Blade'] = sets.precast.WS['Flash Nova']
	sets.precast.WS['Realmrazer'] = {ammo="Cheruski needle",
		head="Jhakri Coronal +2",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Telos earring",
        body="Luhlaza Jubbah +3",hands="Luhlaza Bazubands +3",ring1="Rufescent Ring",ring2="Leviathan Ring",
		back={ name="Rosmerta's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','"Dbl.Atk."+10',}},
		waist="Fotia belt",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}
     
    -- Midcast Sets
    sets.midcast.FastRecast = sets.engaged
         
    sets.midcast['Blue Magic'] = {}
     
    -- Physical Spells --
     
    sets.midcast['Blue Magic'].Physical = {ammo="Cheruski Needle",
        head="Jhakri Coronal +2",neck="Caro Necklace",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Rufescent Ring",ring2="Ifrit Ring",
       back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},waist="Olseni Belt",legs="Samnuha Tights",feet="Assim. Charuqs +2"}
 
    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Falcon eye",
        head="Jhakri Coronal +2",neck="Caro Necklace",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Ramuh Ring +1",ring2="Patricius Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
		waist="Olseni Belt",legs="Samnuha Tights",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
 
    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Adhemar Jacket +1"})
 
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Falcon Eye",body="Adhemar Jacket +1",
		ring1="Shiva Ring +1", ring2="Ramuh Ring +1", waist="Olseni Belt",})
 
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Adhemar Jacket +1"})
 
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {ring1="Rufescent Ring +1",ring2="Gardua Ring +1"})
 
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical)
 
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ring1="Leviathan Ring",ring2="Leviathan Ring"})
 
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical)
 
    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)
 
 
    -- Magical Spells --
     
    sets.midcast['Blue Magic'].Magical = {
    main={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
    sub={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
    ammo="Dosis Tathlum",
    head="Jhakri Coronal +1",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +1",
    neck="Nefarious Collar",
    waist="Aswang Sash",
    left_ear="Hecate's Earring",
    right_ear="Friomisi Earring",
    left_ring="Vertigo Ring",
    right_ring="Jhakri Ring",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}},
}
	sets.midcast['Blue Magic'].MagicalDarkness = set_combine(sets.midcast['Blue Magic'].Magical,
       {head="Pixie Hairpin +1",ring1="Archon Ring"})
	   
	sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical,
       {ring1="Shiva Ring +1"})
     
    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
       {ring1="Shiva Ring +1",feet="Amalric Nails"})
	   
    sets.midcast['Blue Magic'].MagicalStr = set_combine(sets.midcast['Blue Magic'].Magical, {ring2="Rufescent Ring"})
	
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {ring1="Rufescent Ring",ring2="Leviathan Ring"})
	
	sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical, {ring1="Garuda Ring +1",ring2="Garuda Ring +1"})        
 
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)
 
    sets.midcast['Blue Magic'].MagicAccuracy = {
        ammo="Hydrocera",head="Amalric Coif",neck="Sanctity Necklace",ear1="Enchanter's Earring +1",
		ear2="Digni. Earring",body="Amalric Doublet",hands="Rawhide Gloves",ring1="Stikini Ring",ring2="Stikini Ring",back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		waist="Eschan Stone",
		legs="Luhlaza shalwar +3",feet="Amalric Nails"}
     
    -- Breath Spells --
     
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Iqabi Necklace",ear1="Enchanter's Earring +1",ear2="Digni. Earring",
        body="Assimilator's Jubbah +3",hands="Rawhide Gloves",ring1="K'ayres Ring",ring2="Beeline Ring", waist=gear.ElementalObi,
        back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		legs="Hashishin Tayt +1",feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
 
    -- Other Types --
	
	sets.midcast['Blue Magic'].Enmity = sets.Enmity
     
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {head="Amalric Coif",waist="Eschan Stone"})
         
    sets.midcast['Blue Magic']['White Wind'] = {ammo="Hydrocera",
		head={ name="Telchine Cap", augments={'Mag. Evasion+24','Potency of "Cure" effect received+5%',}},
		neck="Phalaina Locket",ear1="Mendi. Earring",ear2="Odnowa Earring +1",
		body="Vrikodara jupon",hands={ name="Telchine Gloves", augments={'Mag. Acc.+15','"Cure" potency +8%','MND+6',}},
		ring1="Leviathan Ring",ring2="Kunaji Ring",
		back="Moonbeam Cape",waist="Gishdubar Sash",legs="Gyve Trousers",feet={ name="Telchine Pigaches", augments={'"Mag.Atk.Bns."+8','Potency of "Cure" effect received+5%','MND+5',}},}
 
    sets.midcast['Blue Magic'].Healing = {ammo="Hydrocera",
        head={ name="Telchine Cap", augments={'Mag. Evasion+24','Potency of "Cure" effect received+5%',}},
		neck="Phalaina Locket",ear1="Mendi. Earring",ear2="Lifestorm Earring", 
        body="Vrikodara jupon",hands={ name="Telchine Gloves", augments={'Mag. Acc.+15','"Cure" potency +8%','MND+6',}},
		ring1="Leviathan Ring",ring2="Kunaji Ring",
        back="Solemnity Cape",waist="Gishdubar Sash",legs="Gyve Trousers",feet={ name="Telchine Pigaches", augments={'"Mag.Atk.Bns."+8','Potency of "Cure" effect received+5%','MND+5',}},}
	
    sets.midcast['Blue Magic'].PhysicalStun = {ammo="Ginsen",
        head="Jhakri Coronal +2",neck="Sanctity Necklace",ear1="Zennaroi Earring",ear2="Digni. Earring",
        body="Mekosuchinae Harness",hands="Leyline Gloves",ring1="Cacoethic ring +1",ring2="Etana Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
		waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Assim. Charuqs +2"}
     
    sets.midcast['Blue Magic']['Cannonball'] = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Sanctity Necklace",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",ring1="Rajas Ring",ring2="Ifrit Ring",
        back="Cornflower Cape",waist="Chuq'aba Belt",legs="Hashishin Tayt +1",feet="Assim. Charuqs +2"}
         
    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Incanter's torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Assimilator's Jubbah +3",hands="Rawhide Gloves",ring1="Prolix Ring",ring2="Defending Ring",
        back="Cornflower Cape",waist="Witful Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
		
	sets.midcast['Blue Magic']['Occultation'] = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Incanter's torque",
        body="Assimilator's Jubbah +3",hands="Hashishin Bazubands +1",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Cornflower Cape",waist="Witful Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
         
    sets.midcast['Blue Magic']['Atra. Libations'] = {ammo="Mavi Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's torque",ear1="Enchanter's Earring +1",ear2="Digni. Earring",
        body="Assimilator's Jubbah +3",hands="Rawhide Gloves",ring1="Archon Ring",ring2="Sangoma Ring",
        back="Cornflower Cape",waist=gear.ElementalObi,legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
 
    sets.midcast['Blue Magic'].Buff = {head="Amalric Coif",waist="Gishdubar Sash",legs="Carmine Cuisses +1"}
    sets.midcast.Flash = sets.Enmity 
    sets.midcast['Elemental Magic'] = sets.midcast['Blue Magic'].Magical
    sets.midcast['Healing Magic'] = sets.midcast['Blue Magic'].Healing 
    sets.midcast['Enfeebling Magic'] = sets.midcast['Blue Magic'].MagicAccuracy
     
    sets.midcast['Dark Magic'] = sets.midcast['Blue Magic'].MagicAccuracy
         
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    sets.midcast.Stoneskin = {waist="Siegel Sash"}
	
	--sets.self_healing = {ring1="Kunaji Ring"}
 
    -- Sets to return to when not performing an action.
 
    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Incanter's Torque",ear1="Ethereal Earring",ear2="Cessance Earring",
        body="Assimilator's Jubbah +3",hands="Assimilator's Bazubands +2",ring1="Hetairoi Ring",ring2="Epona's Ring",
        back="Cornflower Cape",waist="Flume Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
         
    sets.latent_refresh = {waist="Fucho-no-obi"}
 
    -- Resting sets
    sets.resting = {}
     
    -- Idle sets
    sets.idle = {
    main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Ginsen",
    head="Rawhide Mask",
    body="Jhakri Robe +2",
    hands={ name="Herculean Gloves", augments={'"Dbl.Atk."+1','Pet: "Mag.Atk.Bns."+28','"Refresh"+1','Accuracy+17 Attack+17',}},
    legs="Carmine Cuisses +1",
    feet={ name="Herculean Boots", augments={'"Dbl.Atk."+1','Crit.hit rate+2','"Refresh"+2','Accuracy+6 Attack+6',}},
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Defending Ring",
    right_ring="Petrov Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
}


	--sets.idle.PDT = {ammo="Staunch Tathlum",
     --   head="Rawhide Mask",neck="Loricate Collar +1",ear1="Cessance Earring",ear2="Ethereal Earring",
     --   body="Mekosuchinae Harness",
	--	hands={ name="Herculean Gloves", augments={'Magic dmg. taken -2%','"Conserve MP"+6','Damage taken-2%','Accuracy+1 Attack+1',}},
	--	ring1="Patricius ring",ring2="Defending Ring",back="Solemnity Cape",
      --  waist="Flume Belt",legs={ name="Herculean Trousers", augments={'Damage taken-3%','Accuracy+4','Attack+12',}},
		-- feet={ name="Herculean Boots", augments={'Pet: "Dbl. Atk."+3','Accuracy+23','"Refresh"+2','Accuracy+2 Attack+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},}
 
     
    -- Defense sets
    sets.defense.PDT = {
    main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Staunch Tathlum",
    head="Aya. Zucchetto +1",
    body="Ayanmo Corazza +1",
    hands="Aya. Manopolas +1",
    legs="Carmine Cuisses +2",
    feet="Aya. Gambieras +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Defending Ring",
    right_ring="Petrov Ring",
    back="Xucau Mantle",
}
    sets.defense.MDT = {}
    sets.midcast.Trust = sets.engaged 
    --sets.Kiting = {waist="Chaac Belt"}
    sets.Kiting = {back="Mecistopins Mantle", legs="Carmine Cuisses +1"}
    --sets.Kiting = {neck="Adoulin's Refuge +1"}
     
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    -- M.Accuracy = Eosuchus Club
    -- Normal = Buramenk'ah
    -- Nuking = Bolelabunga
    sets.engaged = {
    main="Tizona",
    sub={ name="Colada", augments={'"Dbl.Atk."+2','STR+7','Accuracy+20','Attack+14','DMG:+10',}},
    ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wristbands +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+27','"Triple Atk."+3','AGI+9',}},
    feet={ name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+3',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
}
	sets.engaged.TP = {ammo="Ginsen",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
		neck="Ainia Collar",
		waist="Reiki Yotai",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Petrov Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
}
	sets.engaged.Hybrid = {
		ammo="Staunch Tathlum",
		head="Aya. Zucchetto +2",
		body={ name="Adhemar Jacket +1", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
		neck="Loricate Torque +1",
		waist="Flume Belt",
		ear1="Suppanomimi",
		ear2="Digni. Earring",
		ring1="Patricius Ring",
		ring2="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},}
		
	sets.engaged.MidAcc = {ammo="Ginsen",
        head="Adhemar Bonnet +1",neck="Lissome Necklace",ear1="Suppanomimi",ear2="Telos Earring",
        body="Adhemar Jacket +1",hands="Adhemar Wristbands +1",
		ring1="Hetairoi Ring",ring2="Epona's Ring",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
		waist="Kentarch Belt +1",legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}	
    sets.engaged.Acc = {ammo="Ginsen",
		head="Carmine Mask +1",neck="Combatant's Torque", ear1="Telos Earring",ear2="Digni. Earring",
		body="Adhemar Jacket +1",
		hands="Adhemar Wristbands +1",
		ring1="Ramuh ring +1",ring2="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},waist="Olseni Belt",legs="Carmine Cuisses +1",
		feet={ name="Herculean Boots", augments={'Accuracy+18','STR+9','"Store TP"+7','Accuracy+17 Attack+17','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},}
	sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
	sets.engaged.TH = {ammo="Ginsen",
		head="Adhemar Bonnet +1",
		body={ name="Herculean Vest", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','Mag. Acc.+8','"Treasure Hunter"+1','Accuracy+4 Attack+4',}},
		hands={ name="Herculean Gloves", augments={'Pet: Accuracy+4 Pet: Rng. Acc.+4','Pet: INT+6','"Refresh"+1','Accuracy+2 Attack+2',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Herculean Boots", augments={'Attack+7','Pet: Mag. Acc.+16','"Treasure Hunter"+2','Accuracy+3 Attack+3',}},
		neck="Lissome Necklace",
		waist="Chaac Belt",
		left_ear="Suppanomimi",
		right_ear="Telos Earring",
		left_ring="Sheltered Ring",
		right_ring="Paguroidea Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
}
		sets.engaged.PDT = {ammo="Ginsen",
        head="Lithelimb Cap",neck="Twilight Torque",ear1="Tripudio Earring",ear2="Ethereal Earring",
        body="Emet Harness",hands="Umuthi Gloves",ring1="Patricius ring",ring2="Dark Ring",back="Repulse Mantle",
        waist="Flume Belt",legs="Iuitl Tights +1",feet="Iuitl Gaiters +1"}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
-- Cancel Buffs Section
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
    
    if not spell.interrupted then
        if spell.english == 'Spectral Jig' and buffactive['Sneak'] then
            send_command('cancel 71; cancel sneak')
        end
        if spell.english == 'Stoneskin' and buffactive['Stoneskin'] then
            send_command('cancel 37; cancel stoneskin')
        end
        if spell.english == 'Sneak' then
            if spell.target.type == 'SELF' and buffactive['Sneak'] then
                send_command('cancel 71; cancel sneak')
            end
        end
        if spell.english == 'Monomi: Ichi' and buffactive['Sneak'] then
            send_command('cancel 71; cancel sneak')
        end
        if (spell.english == 'Reraise' or spell.english == 'Reraise II' or spell.english == 'Reraise III') then
            send_command('cancel 113; cancel Reraise*')
        end
    end
end
 
-- Unbridled Learning
function filtered_action(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not buffactive['Unbridled Learning'] then
        cancel_spell()
        send_command('input /ja "Unbridled Learning" <me>;wait 1;input /ma "'..spell.english..'" '..spell.target.name)
    end
end
 
 
-- Run after the default midcast() is done.
function job_aftercast(spell)
    if not spell.interrupted then  
        if (spell.english == "Dream Flower")
        then -- Sleep Countdown --
            send_command('wait 75;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        end
    end
end
 
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end
 
     
    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
	buff = string.lower(buff)
    if buff == "aftermath: lv.3" then -- AM3 Timer --
        if gain then
            send_command('timers create "Aftermath: Lv.3" 180 down AM3.png;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
        else
            send_command('timers delete "Aftermath: Lv.3"')
            add_to_chat(123,'AM3: [OFF]')
        end
    end
	
	
    --if buff == "Nat. Meditation ID" then -- ATK Boost Timer --
        --if gain then
            --send_command('timers create "Nat. Meditation commands here with 10 sec remain /echo Nat. Meditation[10s Remaining]' )
        --else
            --send_command('timers delete "Nat. Meditation ID"')
            --add_to_chat(123,'Nat. Meditation[OFF]')
        --end
    --end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end
 
 
-- Select default macro book on initial load or subjob change.
--function select_default_macro_book()
    -- Default macro set/book
--    if player.sub_job == 'DNC' then
--        set_macro_page(2, 4)
--    else
--        set_macro_page(1, 4)
--    end
--end