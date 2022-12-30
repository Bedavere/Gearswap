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

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


 -- Setup vars that are user-dependent.  Can override this function in a sidecar file.
 function user_setup()
	
	-- Options: Override default values
	state.OffenseMode:options('Ranged', 'Melee', 'Acc')
	state.RangedMode:options('Normal', 'Acc')
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

	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes +1"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
	sets.precast.JA['Double Up'] = {neck="Regal Necklace"}

	sets.precast.CorsairRoll = {head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
    hands="Chasseur's Gants",
    neck="Regal Necklace",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}

	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chasseur's Culottes +1"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chasseur's Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

	sets.precast.LuzafRing = {ring2="Luzaf's Ring"}

	sets.precast.CorsairShot = {}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
		body="Iuitl Vest",hands="Iuitl Wristbands +1",
		legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {ring1="Asklepian Ring"}

	-- Fast cast sets for spells


	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	sets.precast.RA = {
    range="Molybdosis",
    head="Meghanada Visor +1",
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Gaudryi Necklace",
    waist="Yemaya Belt",
    left_ear="Bladeborn Earring",
    right_ear="Enervating Earring",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+5','Weapon skill damage +10%',}},
}

	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
	neck="Fotia Gorget",
	waist="Fotia Belt"
	}


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = sets.precast.WS

	sets.precast.WS['Exenterator'] = sets.precast.WS

	sets.precast.WS['Requiescat'] = sets.precast.WS
	
	sets.precast.WS['Savage Blade'] = {
    ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Attack+3','"Triple Atk."+3','STR+4','Accuracy+14',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +2",
    feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Asperity Necklace",
    waist="Flume Belt +1",
    left_ear="Digni. Earring",
    right_ear="Ishvara Earring",
    left_ring="Ilabrat Ring",
    right_ring="Apate Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}

	sets.precast.WS['Last Stand'] = {
    head={ name="Herculean Helm", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Magic burst dmg.+4%','STR+9','Mag. Acc.+3','"Mag.Atk.Bns."+10',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Magic burst dmg.+5%','Mag. Acc.+4',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+6','"Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Hachirin-no-Obi",
    left_ear="Crematio Earring",
    right_ear="Cessance Earring",
    left_ring="Acumen Ring",
    right_ring="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

	sets.precast.WS['Last Stand'].Acc = {
    head={ name="Herculean Helm", augments={'Rng.Acc.+22','Weapon skill damage +5%','DEX+5','Rng.Atk.+6',}},
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'Rng.Acc.+21','Weapon skill damage +5%','AGI+6','Rng.Atk.+7',}},
    feet={ name="Herculean Boots", augments={'Rng.Acc.+15 Rng.Atk.+15','Weapon skill damage +3%','Rng.Acc.+12','Rng.Atk.+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Neritic Earring",
    left_ring="Garuda Ring",
    right_ring="Garuda Ring +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}


	sets.precast.WS['Wildfire'] = {
    head={ name="Herculean Helm", augments={'Attack+3','"Triple Atk."+3','STR+4','Accuracy+14',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'Accuracy+12 Attack+12','Weapon skill damage +4%','VIT+6','Attack+15',}},
    feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Baetyl Pendant",
    waist="Yemaya Belt",
    left_ear="Friomisi Earring",
    right_ear="Novio Earring",
    left_ring="Dingir Ring",
    right_ring="Ilabrat Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+5','Weapon skill damage +10%',}},
}

	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'],{ring1="Ilabrat Ring"})


	-- Midcast Sets
	sets.midcast.FastRecast = {}

	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.CorsairShot = {
    head={ name="Herculean Helm", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Magic burst dmg.+4%','STR+9','Mag. Acc.+3','"Mag.Atk.Bns."+10',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands="Meg. Gloves +2",
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+24','Magic burst dmg.+5%','Mag. Acc.+4',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+6','"Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Hachirin-no-Obi",
    left_ear="Crematio Earring",
    right_ear="Cessance Earring",
    left_ring="Acumen Ring",
    right_ring="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

	sets.midcast.CorsairShot.Acc = {
    head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
    body={ name="Herculean Vest", augments={'MND+6','"Mag.Atk.Bns."+25','Accuracy+9 Attack+9','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Weapon skill damage +2%','MND+10','Mag. Acc.+10','"Mag.Atk.Bns."+12',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +3%','MND+4','Mag. Acc.+15','"Mag.Atk.Bns."+14',}},
    neck="Sanctity Necklace",
    waist="Svelt. Gouriz +1",
    left_ear="Digni. Earring",
    right_ear="Neritic Earring",
    left_ring="Garuda Ring +1",
    right_ring="Arvina Ringlet +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

	sets.midcast.CorsairShot['Light Shot'] = {
    head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
    body={ name="Herculean Vest", augments={'MND+6','"Mag.Atk.Bns."+25','Accuracy+9 Attack+9','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Weapon skill damage +2%','MND+10','Mag. Acc.+10','"Mag.Atk.Bns."+12',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +3%','MND+4','Mag. Acc.+15','"Mag.Atk.Bns."+14',}},
    neck="Sanctity Necklace",
    waist="Svelt. Gouriz +1",
    left_ear="Digni. Earring",
    right_ear="Neritic Earring",
    left_ring="Garuda Ring +1",
    right_ring="Arvina Ringlet +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
}

	sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']


	-- Ranged gear
	sets.midcast.RA = {
	ammo="Bullet",
    head="Meghanada Visor +1",
    body="Oshosi Vest",
    hands={ name="Adhemar Wristbands", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
    legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
    feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Enervating Earring",
    right_ear="Dedition Earring",
    left_ring="Haverton Ring",
    right_ring="Cacoethic Ring +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
}


	sets.midcast.RA.Acc = {
    head="Oshosi Mask",
    body="Oshosi Vest",
    hands={ name="Adhemar Wristbands", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
    legs="Oshosi Trousers",
    feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
    neck="Iskur Gorget",
    waist="Yemaya Belt",
    left_ear="Enervating Earring",
    right_ear="Dedition Earring",
    left_ring="Petrov Ring",
    right_ring="Haverton Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
}


	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {neck="Loricate Torque +1",ring1="Sheltered Ring",ring2="Paguroidea Ring"}


	-- Idle sets
	sets.idle = {
	ammo="Bullet",
    head={ name="Herculean Helm", augments={'Attack+3','"Triple Atk."+3','STR+4','Accuracy+14',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands="Meg. Gloves +1",
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Meghanada Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

	sets.idle.Town = {
    head="Rawhide Mask",
    body="Meg. Cuirie +1",
    hands={ name="Herculean Gloves", augments={'"Conserve MP"+3','Phys. dmg. taken -3%','"Fast Cast"+7',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Meg. Jam. +2",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Thureous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Reiki Cloak",
}

	-- Defense sets
	sets.defense.PDT = {
    head="Rawhide Mask",
    body="Meg. Cuirie +1",
    hands={ name="Herculean Gloves", augments={'"Conserve MP"+3','Phys. dmg. taken -3%','"Fast Cast"+7',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Meg. Jam. +2",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Thureous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Reiki Cloak",
}

	sets.defense.MDT = {
    head="Rawhide Mask",
    body="Meg. Cuirie +1",
    hands={ name="Herculean Gloves", augments={'"Conserve MP"+3','Phys. dmg. taken -3%','"Fast Cast"+7',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet="Meg. Jam. +2",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Thureous Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Reiki Cloak",
}


	sets.Kiting = {feet="Carmine Cuisses +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged.Melee = 
	{ammo="Ginsen",
    head={ name="Herculean Helm", augments={'Attack+3','"Triple Atk."+3','STR+4','Accuracy+14',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands={ name="Herculean Gloves", augments={'Accuracy+7','Attack+13','Magic burst dmg.+1%','Accuracy+14 Attack+14','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+3','STR+7','Attack+6',}},
    neck="Asperity Necklace",
    waist="Cetl Belt",
    left_ear="Heartseeker Earring",
    right_ear="Dudgeon Earring",
    left_ring="Ilabrat Ring",
    right_ring="Meghanada Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}

	sets.engaged.Acc = {
    head={ name="Adhemar Bonnet", augments={'DEX+8','AGI+8','Accuracy+12',}},
    body="Meg. Cuirie +1",
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Attack+22','Crit. hit damage +2%','DEX+15','Accuracy+15',}},
    neck="Sanctity Necklace",
    waist="Hurch'lan Sash",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Epona's Ring",
    right_ring="Defending Ring",
    back="Letalis Mantle",
}

	sets.engaged.Melee.DW = {
    head={ name="Adhemar Bonnet", augments={'DEX+8','AGI+8','Accuracy+12',}},
    body="Meg. Cuirie +1",
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Attack+22','Crit. hit damage +2%','DEX+15','Accuracy+15',}},
    neck="Sanctity Necklace",
    waist="Hurch'lan Sash",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Epona's Ring",
    right_ring="Defending Ring",
    back="Letalis Mantle",
}

	sets.engaged.Acc.DW = {
    head={ name="Adhemar Bonnet", augments={'DEX+8','AGI+8','Accuracy+12',}},
    body="Meg. Cuirie +1",
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Attack+22','Crit. hit damage +2%','DEX+15','Accuracy+15',}},
    neck="Sanctity Necklace",
    waist="Hurch'lan Sash",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Epona's Ring",
    right_ring="Defending Ring",
    back="Letalis Mantle",
}


	sets.engaged.Ranged = {
    head="Meghanada Visor +1",
    body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
    hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Herculean Boots", augments={'Accuracy+26','"Triple Atk."+3','DEX+7',}},
    neck="Lissome Necklace",
    waist="Kentarch Belt +1",
    left_ear="Cessance Earring",
    right_ear="Digni. Earring",
    left_ring="Epona's Ring",
    right_ring="Chirich Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}
end