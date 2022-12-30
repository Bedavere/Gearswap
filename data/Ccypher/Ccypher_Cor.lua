-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

--[[
gs c toggle luzaf -- Toggles use of Luzaf Ring on and off

Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
for ranged weaponskills, but not actually meleeing.
Acc on offense mode (which is intended for melee) will currently use .Acc weaponskill
mode for both melee and ranged weaponskills.  Need to fix that in core.
--]]
require("no_interruptions") 
send_command('input /macro book 3;wait .1;input /macro set 1;')

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


 -- Setup vars that are user-dependent.  Can override this function in a sidecar file.
 function user_setup()
	
	-- Options: Override default values
	state.OffenseMode:options('Melee', 'Acc', 'DT')
	state.RangedMode:options('Normal', 'Acc', 'NoFlurry')
	state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
	state.RestingModes = {'Normal'}
	state.PhysicalDefenseModes = {'PDT'}
	state.MagicalDefenseModes = {'MDT'}
	
	--state.Defense.PhysicalMode = 'PDT'
	options.ammo_warning_limit = 15


	-- Additional local binds
	-- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
	send_command('bind ^f9 gs c cycle RangedMode')
	send_command('bind ^` input /ja "Double-up" <me>') -- Ctrl `
	send_command('bind !` input //gs c toggle LuzafRing')  -- Alt `

 end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.Obi = {waist="Hachirin-no-Obi"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +1"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
	sets.precast.JA['Double-Up'] = {
		head		={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
		body		="Oshosi Vest +1",
		hands		="Chasseur's Gants +1",
		legs		={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet		="Osh. Leggings +1",
		neck		="Regal Necklace",
		waist		="Flume Belt",
		left_ear	="Etiolation Earring",
		right_ear	="Digni. Earring",
		left_ring	="Luzaf's Ring",
		right_ring	="Defending Ring",
		back		={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.lockstyle = {
		range		="Death Penalty",
		head		={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body		="Nisroch Jerkin",
		hands		={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs		={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet		={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
	}
	
	sets.precast.CorsairRoll = {
		head		={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
		body		="Oshosi Vest +1",
		hands		="Chasseur's Gants +1",
		legs		={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet		="Osh. Leggings +1",
		neck		="Regal Necklace",
		waist		="Flume Belt",
		left_ear	="Etiolation Earring",
		right_ear	="Digni. Earring",
		left_ring	="Luzaf's Ring",
		right_ring	="Defending Ring",
		back		={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +1"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

	
	--CORShot Ability Delay- gears
	sets.precast.CorsairShot = {}
	
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
	
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {ring1="Asklepian Ring"}
	
	-- Fast cast sets for spells
	sets.precast.FC = {
		head		={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body		="Oshosi Vest +1",
		hands		={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs		={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet		={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
		neck		="Voltsurge Torque",
		waist		="Flume Belt",
		left_ear	="Etiolation Earring",
		right_ear	="Loquac. Earring",
		left_ring	="Rahab Ring",
		right_ring	="Kishar Ring",
		back		="Moonbeam Cape",
}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {Body="Passion Jacket"})
	
	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
	neck="Fotia Gorget",
	waist="Fotia Belt",
	}


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = {
		ammo		="Chrono Bullet",
		head		={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body		="Abnoba Kaftan",
		hands		="Meg. Gloves +2",
		legs		="Mummu Kecks +2",
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Cessance Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Rahab Ring",
		right_ring	="Kishar Ring",
		back		={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.precast.WS['Exenterator'] = sets.precast.WS

	sets.precast.WS['Requiescat'] = sets.precast.WS
	
	sets.precast.WS['Savage Blade'] = {
		ammo		="Chrono Bullet",
		head		={ name="Herculean Helm", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','STR+3',}},
		body		="Laksa. Frac +3",
		hands		="Meg. Gloves +2",
		legs		={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','STR+6','Accuracy+9',}},
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Fotia Gorget",
		waist		="Grunfeld Rope",
		left_ear	="Telos Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Rufescent Ring",
		right_ring	="Regal Ring",
		back		={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

	sets.precast.WS['Detonator'] = {
		ammo		="Chrono Bullet",
		head		="Meghanada Visor +2",
		body		="Laksa. Frac +3",
		hands		="Meg. Gloves +2",
		legs		="Meg. Chausses +2",
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Telos Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Dingir Ring",
		right_ring	="Regal Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

	sets.precast.WS['Last Stand'] = {
		ammo		="Chrono Bullet",
		head		="Meghanada Visor +2",
		body		="Laksa. Frac +3",
		hands		="Meg. Gloves +2",
		legs		="Meg. Chausses +2",
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Telos Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Dingir Ring",
		right_ring	="Regal Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

	sets.precast.WS['Last Stand'].Acc = {
		ammo		="Chrono Bullet",
		head		="Meghanada Visor +2",
		body		="Laksa. Frac +3",
		hands		="Meg. Gloves +2",
		legs		="Meg. Chausses +2",
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Iskur Gorget",
		waist		="Fotia Belt",
		left_ear	="Telos Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Dingir Ring",
		right_ring	="Regal Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}


	sets.precast.WS['Wildfire'] = {
		ammo		="Living Bullet",
		head		={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','Mag. Acc.+13','"Mag.Atk.Bns."+12',}},
		body		={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands		={ name="Herculean Gloves", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +4%','AGI+9','Mag. Acc.+15',}},
		legs		={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +4%','AGI+8','Mag. Acc.+7',}},
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Friomisi Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Dingir Ring",
		right_ring	="Regal Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

	sets.precast.WS['Hot Shot'] = {
		ammo		="Living Bullet",
		head		={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','Mag. Acc.+13','"Mag.Atk.Bns."+12',}},
		body		={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands		={ name="Herculean Gloves", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +4%','AGI+9','Mag. Acc.+15',}},
		legs		={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+22','Weapon skill damage +4%','Mag. Acc.+17',}},
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Friomisi Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Dingir Ring",
		right_ring	="Regal Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag.Dmg.+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

	sets.precast.WS['Leaden Salute'] = {
		ammo		="Living Bullet",
		head		="Pixie Hairpin +1",
		body		={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands		={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs		={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +4%','AGI+8','Mag. Acc.+7',}},
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Friomisi Earring",
		right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	="Dingir Ring",
		right_ring	="Archon Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Dmg+10','Weapon skill damage +10%',}},
}

	sets.precast.WS['Dancing Edge'] = {
		ammo		="Chrono Bullet",
		head		={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body		={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands		={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs		="Meg. Chausses +2",
		feet		={ name="Herculean Boots", augments={'Rng.Atk.+18','"Triple Atk."+4','STR+3','Accuracy+10','Attack+4',}},
		neck		="Fotia Gorget",
		waist		="Fotia Belt",
		left_ear	="Telos Earring",
		right_ear	="Cessance Earring",
		left_ring	="Epona's Ring",
		right_ring	="Regal Ring",
		back		={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	-- Midcast Sets
	sets.midcast.FastRecast = {}

	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.CorsairShot = {
		ammo		="Living Bullet",
		head		={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','Mag. Acc.+13','"Mag.Atk.Bns."+12',}},
		body		={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands		={ name="Herculean Gloves", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +4%','AGI+9','Mag. Acc.+15',}},
		legs		={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +4%','AGI+8','Mag. Acc.+7',}},
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Sanctity Necklace",
		waist		="Eschan Stone",
		left_ear	="Friomisi Earring",
		right_ear	="Hecate's Earring",
		left_ring	="Dingir Ring",
		right_ring	="Acumen Ring",
		back		={ name="Gunslinger's Cape", augments={'Enmity-3','"Mag.Atk.Bns."+4','"Phantom Roll" ability delay -5',}},
}

	sets.midcast.CorsairShot.Acc = {
		ammo		="Living Bullet",
		head		={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','Mag. Acc.+13','"Mag.Atk.Bns."+12',}},
		body		={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands		={ name="Herculean Gloves", augments={'Mag. Acc.+11 "Mag.Atk.Bns."+11','Weapon skill damage +4%','AGI+9','Mag. Acc.+15',}},
		legs		={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +4%','AGI+8','Mag. Acc.+7',}},
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Sanctity Necklace",
		waist		="Eschan Stone",
		left_ear	="Friomisi Earring",
		right_ear	="Hecate's Earring",
		left_ring	="Dingir Ring",
		right_ring	="Acumen Ring",
		back		={ name="Gunslinger's Cape", augments={'Enmity-3','"Mag.Atk.Bns."+4','"Phantom Roll" ability delay -5',}},
}

	sets.midcast.CorsairShot['Light Shot'] = {
		ammo		="Living Bullet",
		head		={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','Mag. Acc.+13','"Mag.Atk.Bns."+12',}},
		body		="Oshosi Vest +1",
		hands		="Mummu Wrists +2",
		legs		="Osh. Trousers +1",
		feet		="Lak. Bottes",
		neck		="Sanctity Necklace",
		waist		="Kwahu Kachina Belt",
		left_ear	="Digni. Earring",
		right_ear	="Hecate's Earring",
		left_ring	="Stikini Ring +1",
		right_ring	="Stikini Ring +1",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
}

	sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

	----Flurry Not Active------
	sets.precast.RA = {
		ammo		="Chrono Bullet",
		head		="Chass. Tricorne +1",
		body		="Oshosi Vest +1",
		hands		={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs		={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
		feet		="Meg. Jam. +2",
		neck		="Iskur Gorget",
		waist		="Yemaya Belt",
		left_ear	="Telos Earring",
		right_ear	="Enervating Earring",
		left_ring	="Dingir Ring",
		right_ring	="Ilabrat Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10','Phys. dmg. taken-10%',}},
}
	
	-- Ranged gear
	sets.midcast.RA = {
		ammo		="Chrono Bullet",
		head		="Meghanada Visor +2",
		body		="Nisroch Jerkin",
		hands		={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs		={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet		="Osh. Leggings +1",
		neck		="Iskur Gorget",
		waist		="Yemaya Belt",
		left_ear	="Telos Earring",
		right_ear	="Enervating Earring",
		left_ring	="Dingir Ring",
		right_ring	="Ilabrat Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10','Phys. dmg. taken-10%',}},
}

	--Sets to be used as Midshot.TripleShot Buffactive
	sets.midcast.RA.Acc = {
		ammo		="Chrono Bullet",
		head		="Oshosi Mask +1",
		body		="Chasseur's Frac +1",
		hands		={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}},
		legs		="Osh. Trousers +1",
		feet		="Osh. Leggings +1",
		neck		="Iskur Gorget",
		waist		="Yemaya Belt",
		left_ear	="Telos Earring",
		right_ear	="Enervating Earring",
		left_ring	="Dingir Ring",
		right_ring	="Ilabrat Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Snapshot"+10','Phys. dmg. taken-10%',}},
}

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = sets.idle


	-- Idle sets
	sets.idle = {
		ammo		="Chrono Bullet",
		head		="Meghanada Visor +2",
		body		="Meg. Cuirie +2",
		hands		="Meg. Gloves +2",
		legs		="Mummu Kecks +2",
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Loricate Torque +1",
		waist		="Flume Belt",
		left_ear	="Etiolation Earring",
		right_ear	="Spellbr. Earring",
		left_ring	="Defending Ring",
		right_ring	={ name="Dark Ring", augments={'Breath dmg. taken -5%','Magic dmg. taken -6%','Phys. dmg. taken -4%',}},
		back		="Moonbeam Cape",
}

	sets.idle.Town = {
		ammo		="Living Bullet",
		head		="Oshosi Mask +1",
		body		="Nisroch Jerkin",
		hands		={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}},
		legs		="Osh. Trousers +1",
		feet		="Osh. Leggings +1",
		neck		="Regal Necklace",
		waist		="Flume Belt",
		left_ear	="Telos Earring",
		right_ear	="Enervating Earring",
		left_ring	="Regal Ring",
		right_ring	="Dingir Ring",
		back		={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
}

	-- Defense sets
	sets.defense.PDT = {
		ammo		="Chrono Bullet",
		head		="Meghanada Visor +2",
		body		="Meg. Cuirie +2",
		hands		="Meg. Gloves +2",
		legs		="Mummu Kecks +2",
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Loricate Torque +1",
		waist		="Flume Belt",
		left_ear	="Etiolation Earring",
		right_ear	="Spellbr. Earring",
		left_ring	="Defending Ring",
		right_ring	={ name="Dark Ring", augments={'Breath dmg. taken -5%','Magic dmg. taken -6%','Phys. dmg. taken -4%',}},
		back		="Moonbeam Cape",
}

	sets.defense.MDT = {
		ammo		="Chrono Bullet",
		head		="Meghanada Visor +2",
		body		="Meg. Cuirie +2",
		hands		="Meg. Gloves +2",
		legs		="Mummu Kecks +2",
		feet		={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck		="Loricate Torque +1",
		waist		="Flume Belt",
		left_ear	="Etiolation Earring",
		right_ear	="Spellbr. Earring",
		left_ring	="Defending Ring",
		right_ring	={ name="Dark Ring", augments={'Breath dmg. taken -5%','Magic dmg. taken -6%','Phys. dmg. taken -4%',}},
		back		="Moonbeam Cape",
}


	sets.Kiting = {feet="Carmine Cuisses +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged.Melee = {
		ammo		="Chrono Bullet",
		head		={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body		={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands		={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs		="Meg. Chausses +2",
		feet		={ name="Herculean Boots", augments={'Rng.Atk.+18','"Triple Atk."+4','STR+3','Accuracy+10','Attack+4',}},
		neck		="Combatant's Torque",
		waist		="Sarissapho. Belt",
		left_ear	="Cessance Earring",
		right_ear	="Telos Earring",
		left_ring	="Ilabrat Ring",
		right_ring	="Epona's Ring",
		back		={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.Acc = {
		ammo		="Chrono Bullet",
		head		={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body		={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands		={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs		="Meg. Chausses +2",
		feet		={ name="Herculean Boots", augments={'Rng.Atk.+18','"Triple Atk."+4','STR+3','Accuracy+10','Attack+4',}},
		neck		="Combatant's Torque",
		waist		="Sarissapho. Belt",
		left_ear	="Cessance Earring",
		right_ear	="Telos Earring",
		left_ring	="Ilabrat Ring",
		right_ring	="Epona's Ring",
		back		={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}	

	sets.engaged.DT = {
		ammo		="Chrono Bullet",
		head		={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body		={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands		={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs		="Mummu Kecks +2",
		feet		={ name="Herculean Boots", augments={'Rng.Atk.+18','"Triple Atk."+4','STR+3','Accuracy+10','Attack+4',}},
		neck		="Loricate Torque +1",
		waist		="Sarissapho. Belt",
		left_ear	="Telos Earring",
		right_ear	="Cessance Earring",
		left_ring	="Defending Ring",
		right_ring	="Epona's Ring",
		back		={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	
end


function job_setup()
    state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false
    end

function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' and state.Buff['Triple Shot'] then
		equip(sets.midcast.RA.Acc)
		eventArgs.handled = true
	end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip obi if weather/day matches for Quick Draw.
    if spell.type == 'CorsairShot' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
end
end
end