------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')

    send_command('bind @s gs c cycle AutoWSMode')

    send_command('bind ` input /ma "Sudden Lunge" <t>')
    send_command('bind ^o input /ja "Unbridled Learning" <me>')
    send_command('bind ^p input /ja "Diffusion" <me>')
    send_command('bind !o input /ma "Erratic Flutter" <me>')
    send_command('bind !p input /ma "Occultation" <me>')
    send_command('bind ^` input /ma "Magic Fruit" <me>')
    send_command('bind !d input /ma "Nat. Meditation" <me>')

    send_command('bind ^numpad/ input /ja "Chain Affinity" <me>')
    send_command('bind ^numpad* input /ja "Burst Affinity" <me>')
    send_command('bind ^numpad- input /ja "Efflux" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind !numlock input /ja "Defender" <me>')
        send_command('bind !numpad/ input /ja "Berserk" <me>')
        send_command('bind !numpad* input /ja "Warcry" <me>')
        send_command('bind !numpad- input /ja "Aggressor" <me>')
    end

    if player.sub_job == 'DNC' then
        send_command('bind !numlock input /ja "Spectral Jig" <me>')
        send_command('bind !numpad/ input /ja "Haste Samba" <me>')
        send_command('bind !numpad* input /ja "Healing Waltz" <me>')
    end

    if player.sub_job == 'NIN' then
        send_command('bind !, input /ma "Utsusemi: Ni" <me>')
        send_command('bind !. input /ma "Utsusemi: Ichi" <me>')
        send_command('bind !numlock input /ma "Monomi: Ichi" <me>')
        send_command('bind !numpad/ input /ma "Tonko: Ni" <me>')
    end

    send_command('bind ^numpad7 input /ws "Chant du Cygne" <t>')
    send_command('bind ^numpad8 input /ws "Expiacion" <t>')
    send_command('bind ^numpad9 input /ws "Black Halo" <t>')
    send_command('bind ^numpad4 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad6 input /ws "Requiescat" <t>')
    send_command('bind ^numpad1 input /ws "Sanguine Blade" <t>')

end

function file_unload()

    send_command('unbind `')
    send_command('unbind ^`')
    send_command('unbind ^o')
    send_command('unbind ^p')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind !d')
    send_command('unbind !,')
    send_command('unbind !.')
    send_command('unbind @s')
    send_command('unbind !numlock')
    send_command('unbind !numpad/')
    send_command('unbind !numpad*')
    send_command('unbind !numpad-')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')


end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

send_command('alias mab input /equip sub "Naegling"; input /equip main "Kaja Rod";' )
send_command('alias tp input /equip main "Tizona"; input /equip sub "Almace";' )
send_command('alias mac input /equip main "Tizona"; input /equip sub "Naegling";' )
send_command('alias exp input /equip main "Tizona"; input /equip sub "Thibron";')


send_command('alias hw input /item "Holy Water" <me>' )
send_command('alias re input /item "Remedy" <me>' )
send_command('alias ed input /item "Echo Drops" <me>' )
send_command('alias pa input /item "Panacea" <me>' )

	state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
	state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
	state.Buff.Convergence = buffactive.Convergence or false
	state.Buff.Diffusion = buffactive.Diffusion or false
	state.Buff.Efflux = buffactive.Efflux or false
	
	state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
	state.Buff['Unbridled Wisdom'] = buffactive['Unbridled Wisdom'] or false


	blue_magic_maps = {}
	
	-- Mappings for gear sets to use for various blue magic spells.
	-- While Str isn't listed for each, it's generally assumed as being at least
	-- moderately signficant, even for spells with other mods.
	
	-- Physical Spells --
	
	-- Physical spells with no particular (or known) stat mods
	blue_magic_maps.Physical = S{
		'Bilgestorm','Sweeping Gouge','Saurian Slide'
	}

	-- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
	blue_magic_maps.PhysicalAcc = S{
		'Heavy Strike'
	}

	-- Physical spells with Str stat mod
	blue_magic_maps.PhysicalStr = S{
		'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
		'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
		'Uppercut','Vertical Cleave'
	}
		
	-- Physical spells with Dex stat mod
	blue_magic_maps.PhysicalDex = S{
		'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
		'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
		'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
		'Vanity Dive'
	}
		
	-- Physical spells with Vit stat mod
	blue_magic_maps.PhysicalVit = S{
		'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
		'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
	}
		
	-- Physical spells with Agi stat mod
	blue_magic_maps.PhysicalAgi = S{
		'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
		'Pinecone Bomb','Spiral Spin','Wild Oats'
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
		'Anvil Lightning','Atra. Libations','Blastbomb','Blazing Bound','Blinding Fulgor',
		'Bomb Toss','Cursed Sphere','Dark Orb','Death Ray','Diffusion Ray','Droning Whirlwind',
		'Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm','Maelstrom',
		'Molting Plumage','Nectarous Deluge','Rail Cannon','Regurgitation',
		'Rending Deluge','Retinal Glare','Scouring Spate','Searing Tempest','Silent Storm',
		'Spectral Floe','Subduction','Tem. Upheaval','Water Bomb',
		'Tearing Gust','Cesspool','Cruel Joke','Polar Roar','Crashing Thunder','Uproot'
	}

	-- Magical spells with a primary Mnd mod
	blue_magic_maps.MagicalMnd = S{
		'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
	}

	-- Magical spells with a primary Chr mod
	blue_magic_maps.MagicalChr = S{
		'Eyes On Me','Mysterious Light'
	}

	-- Magical spells with a Vit stat mod (on top of Int)
	blue_magic_maps.MagicalVit = S{
		'Thermal Pulse'
	}

	--Magical spells with a Str stat mod
	blue_magic_maps.MagicalStr = S{
		'Searing Tempest'
	}

	--Magical spells with a Agi stat mod
	blue_magic_maps.MagicalAgi = S{
		'Silent Storm'
	}

	-- Magical spells with a Dex stat mod (on top of Int)
	blue_magic_maps.MagicalDex = S{
		'Charged Whisker','Gates of Hades'
	}

	-- Magical spells with a Dark elemental
	blue_magic_maps.MagicalDark = S{
		'Palling Salvo','Tenebral Crush'
	}
			
	-- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
	-- Add Int for damage where available, though.
	blue_magic_maps.MagicAccuracy = S{
		'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
		'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
		'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
		'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
		'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
		'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
		'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
		'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
	}
		
	-- Breath-based spells
	blue_magic_maps.Breath = S{
		'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
		'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
		'Thunder Breath','Vapor Spray','Wind Breath'
	}

	-- Stun spells
	blue_magic_maps.Stun = S{
		'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
		'Thunderbolt','Whirl of Rage'
	}
		
	-- Healing spells
	blue_magic_maps.Healing = S{
		'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
		'Wild Carrot'
	}
	
	-- Buffs that depend on blue magic skill
	blue_magic_maps.SkillBasedBuff = S{
		'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
		'Pyric Bulwark','Reactor Cool','Occultation', 'Mighty Guard', 'Cocoon', 'Fantod', 'Carcharian Verve'
	}

	-- Other general buffs
	blue_magic_maps.Buff = S{
	'Amplification', 'Animating Wail', 'Battery Charge', 'Erratic Flutter', 'Exuviation', 'Feather Barrier', 'Harden Shell', 'Memento Mori', 'Nat. Meditation', 'Orcish Counterstance', 'Refueling', 'Regeneration', 'Saline Coat', 'Triumphant Roar', 'Warm-Up', 'Winds of Promyvion', 'Zephyr Mantle'
	}
	
	
	-- Spells that require Unbridled Learning to cast.
	unbridled_spells = S{
		'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
		'Cesspool','Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades',
		'Harden Shell','Mighty Guard','Polar Roar','Pyric Bulwark','Tearing Gust',
		'Thunderbolt','Tourbillion','Uproot'
	}
	
    
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()

	state.OffenseMode:options('STP', 'DT')
     state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT')
	state.Buff.Diffusion = buffactive.Diffusion or false

    state.AutoWSMode = M(false, 'AutoWSMode')


    update_combat_form()
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
    	head="Carmine Mask",
    	body="Luhlaza Jubbah +1",
    	hands="Leyline Gloves",
    	legs="Aya. Cosciales +2",
    	feet="Carmine Greaves +1",
    	neck="Voltsurge Torque",
    	waist="Witful belt",
    	left_ear="Etiolation Earring",
    	right_ear="Loquac. Earring",
    	left_ring="Kishar Ring",
    	right_ring="Lebeche Ring",
    	back="Perimede Cape",
	}

        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Floestone",
    	head={ name="Herculean Helm", augments={'Attack+28','Weapon skill damage +5%','STR+6','Accuracy+11',}},
	neck="Fotia Gorget",
	left_ear="Moonshade Earring",
	right_ear="Ishvara Earring",
	body="Assim. Jubbah +3",
	hands="Jhakri Cuffs +2",
	left_ring="Karieyh Ring",
     right_ring="Epaminondas's Ring",
	back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	waist="Fotia Belt",
	legs="Luhlaza Shalwar +3",
	feet={ name="Herculean Boots", augments={'Attack+28','Weapon skill damage +4%','STR+9','Accuracy+9',}},
	}
        
    sets.precast.WS['Chant du Cygne'] = {
    ammo="Jukukik Feather",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Herculean Vest", augments={'Accuracy+20','Crit. hit damage +4%','DEX+15','Attack+12',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Rng.Acc.+24','Crit. hit damage +4%','DEX+15','Accuracy+15','Attack+12',}},
    neck="Mirage Stole +2",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Mache Earring +1",
    left_ring="Epona's Ring",
    right_ring="Begrudging Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
}

    
	sets.precast.WS['Requiescat'] = {ammo="Ginsen",
    head="Jhakri Coronal +2",
    body="Assim. Jubbah +3",
    hands="Jhakri Cuffs +2",
    legs="Luhlaza Shalwar +3",
    feet="Jhakri Pigaches +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Ishvara Earring",
    left_ring="Karieyh Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rosmerta's Cape", augments={'MND+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}


	sets.precast.WS['Savage Blade'] = {ammo="Floestone",
    head={ name="Herculean Helm", augments={'Attack+28','Weapon skill damage +5%','STR+6','Accuracy+11',}},
    body="Assim. Jubbah +3",
    hands="Jhakri Cuffs +2",
    legs="Luhlaza Shalwar +3",
    feet={ name="Herculean Boots", augments={'Attack+28','Weapon skill damage +4%','STR+9','Accuracy+9',}},
    neck="Mirage Stole +2",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Ishvara Earring",
    left_ring="Karieyh Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}


	sets.precast.WS['Expiacion'] = {ammo="Floestone",
    head={ name="Herculean Helm", augments={'Attack+28','Weapon skill damage +5%','STR+6','Accuracy+11',}},
    body="Assim. Jubbah +3",
    hands="Jhakri Cuffs +2",
    legs="Luhlaza Shalwar +3",
    feet={ name="Herculean Boots", augments={'Attack+28','Weapon skill damage +4%','STR+9','Accuracy+9',}},
    neck="Mirage Stole +2",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Ishvara Earring",
    left_ring="Karieyh Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.precast.WS['Flat Blade'] = {
    ammo="Pemphredo Tathlum",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Jhakri Cuffs +2",
    legs="Aya. Cosciales +2",
    feet="Jhakri Pigaches +2",
    neck="Sanctity Necklace",
    waist="Fotia Belt",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Rufescent Ring",
    right_ring="Chirich Ring +1",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}

	sets.precast.WS['Sanguine Blade'] = {
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Assim. Jubbah +3",
    hands="Jhakri Cuffs +2",
    legs={ name="Luhlaza Shalwar +3", augments={'Enhances "Assimilation" effect',}},
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck="Baetyl Pendant",
    waist="Hachirin-no-Obi",
    left_ear="Friomisi Earring",
    right_ear="Regal Earring",
    left_ring="Archon Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
}


    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
 	
	sets.midcast['Blue Magic'] = {}
	
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = {ammo="Falcon Eye",
    head="Luh. Keffiyeh +3",
    body="Assim. Jubbah +3",
    hands="Jhakri Cuffs +2",
    legs="Luhlaza Shalwar +3",
    feet={ name="Herculean Boots", augments={'Attack+28','Weapon skill damage +4%','STR+9','Accuracy+9',}},
    neck="Mirage Stole +2",
    waist="Prosilio Belt +1",
    left_ear="Regal Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Shukuyu Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
}


	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
		{})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


	-- Magical Spells --
	
    sets.midcast['Blue Magic'].Magical =  {
	ammo="Pemphredo Tathlum",
	head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+30','Enmity-3','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
	body="Jhakri Robe +2",
	hands="Amalric Gages +1",
	legs="Amalric Slops +1",
	feet="Amalric Nails +1",
	neck="Baetyl Pendant",
	waist="Orpheus's Sash",
	left_ear="Regal Earring",
	right_ear="Friomisi Earring",
	left_ring="Shiva Ring +1",
	right_ring="Shiva Ring +1",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}},
	}


	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{})
	
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
		{})

	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical)

	sets.midcast['Blue Magic'].MagicalStr = set_combine(sets.midcast['Blue Magic'].Magical, {legs="Luhlaza Shalwar +3"})

	sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical, {legs="Luhlaza Shalwar +3"})

	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

	sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {head="Pixie Hairpin +1", ring2="Archon Ring", legs="Luhlaza Shalwar +3"})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
    head="Luh. Keffiyeh +3", 
    neck="Mirage Stole +2",
    hands="Regal Cuffs", 
    left_ear="Regal Earring", 
    ear2="Digni. Earring",
    left_ring="Stikini Ring +1", 
    right_ring="Stikini Ring +1",
    waist="Eschan Stone", 
    legs="Aya. Cosciales +2", 
    feet="Jhakri Pigaches +2",
    })

	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = {}
	
	sets.midcast.Swipe = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast.Lunge = set_combine(sets.midcast['Blue Magic'].Magical, {})



	-- Other Types --
	
	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
		{})

	sets.midcast['Blue Magic'].Healing = {ammo="Mavi Tathlum",
    head="Luh. Keffiyeh +3",
    body="Vrikodara Jupon",
    hands="Telchine Gloves",
    legs="Carmine Cuisses +1",
    feet="Amalric Nails +1",
    neck="Incanter's Torque",
    waist="Gishdubar Sash",
    left_ear="Regal Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Lebeche Ring",
}



	sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.precast.FC, {ammo="Mavi Tathlum",
    head="Luh. Keffiyeh +3",
    neck="Mirage Stole +2",
    body="Assim. Jubbah +3",
    hands="Rawhide Gloves",
    legs="Hashishin Tayt +1",
    --feet="Luhlaza Charuqs +1",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back="Cornflower Cape",
})


		    
    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Staunch Tathlum +1",
    head="Rawhide Mask",
    body="Assim. Jubbah +3",
    hands={ name="Herculean Gloves", augments={'MND+4','Pet: INT+7','"Refresh"+2','Accuracy+14 Attack+14','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
    legs={ name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -1%','Attack+16','"Refresh"+2','Accuracy+18 Attack+18',}},
    feet={ name="Herculean Boots", augments={'STR+11','Weapon Skill Acc.+3','"Refresh"+2','Accuracy+6 Attack+6','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Loricate Torque +1",
    waist="Flume Belt",
    ear1="Etiolation Earring",
    ear2="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Stikini Ring +1",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
}


    sets.idle.PDT = {ammo="Staunch Tathlum +1",
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Assim. Bazu. +3",
    legs="Aya. Cosciales +2",
    feet="Ahosi Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    ear1="Etiolation Earring",
    ear2="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Stikini Ring +1",
    back="Moonbeam Cape",
}
    
    sets.Kiting = {legs="Carmine cuisses +1"}
	

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    
	sets.engaged.STP = {
    ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Adhemar Jacket +1",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'Accuracy+24 Attack+24','"Triple Atk."+4','Accuracy+1','Attack+12',}},
    neck="Mirage Stole +2",
    waist="Windbuffet Belt +1",
    left_ear="Suppanomimi",
    right_ear="Dedition Earring",
    left_ring="Epona's Ring",
    right_ring="Petrov Ring",
    back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
}


	sets.engaged.DT = set_combine(sets.engaged.STP, {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Assim. Bazu. +3",
    right_ring="Defending Ring",
})


    -- Example of Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    --sets.buff['Divine Caress'] = {hands="Orison Mitts +2",back="Mending Cape"}

	sets.buff['Diffusion'] = {feet = "Luhlaza Charuqs +1"}
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if unbridled_spells:contains(spell.english) and not (state.Buff['Unbridled Learning'] or state.Buff['Unbridled Wisdom']) then
		eventArgs.cancel = true
		windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
	end
	if spellMap == 'Cure' or spellMap == 'Curaga' then
		gear.default.obi_waist = ""
		if spell.element == world.weather_element or spell.element == world.day_element then
			gear.default.obi_waist = "Hachirin-no-Obi"
		end
	elseif spell.skill == 'Elemental Magic' or spell.skill == 'Dark Magic' or spell.skill == "Blue Magic" then
		gear.default.obi_waist = "Eschan Stone"
		if spell.element == world.weather_element or spell.element == world.day_element then
			gear.default.obi_waist = "Hachirin-no-Obi"
		end
	end
end

-- Run after the default midcast() is done.
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
end

function job_precast(spell, action, spellMap, eventArgs)
    --No Spell Interrupt/Knockback
    if check_ready(spell) then
        spam_protection_on(spell)
    else
        cancel_spell()
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
	--No Spell Interrupt/Knockback
	if spam_protection_off(spell)then
		handle_idle()	
	end	
	 --checkAftercast(spell)
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

function update_combat_form()
	-- Check for H2H or single-wielding
	if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
		state.CombatForm:reset()
	else
		state.CombatForm:set('DW')
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

windower.register_event('tp change', function(tp)
   if state.AutoWSMode.value == true then
	if player.tp > 999 and player.status == 'Engaged' then
		--send_command('input /ws "Expiacion" <t>')
		send_command('input /ws "Chant du Cygne" <t>')
	end
	if player.hp < 1000 then
		send_command('input /ma "Magic Fruit" <me>')
	end
   end
end)

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--No Interrupt/Knockback
function handle_ping()
  if player.status ~= 'Resting' then
  if doCures then
   cure_process()
 
   showArrayContents()
   handleSpareTime()
  end
 else
  lastx = player.x
  lasty = player.y
 end
end

function handle_idle()
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end









