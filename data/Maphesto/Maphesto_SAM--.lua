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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('LowACC', 'MidACC', 'HighACC', 'MAX')
    state.WeaponskillMode:options('LowACC', 'MidACC', 'HighACC', 'MAX')
    state.PhysicalDefenseMode:options('PDT', 'MDT')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	sets.enmity = {ammo="Paeapua", head="Loess Barbuta +1", neck="Unmoving Collar +1", body="Emet Harness +1", ear1="Trux Earring", ear2="Cryptic Earring", 
	ring2="Petrov Ring", ring1="Begrudging Ring", hands="Kurys Gloves", waist="Sulla Belt", legs="Flamma Dirs +2", feet="Amm Greaves",
	back="Reiki Cloak"}


    --------------------------------------
    -- Augments
    --------------------------------------
	
	Smertrios = {}
	Smertrios.gkWS = {}
    Smertrios.gkWS = {name="Smertrios's mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	Smertrios.gkTP = {name="Smertrios's mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10'}}
	Smertrios.gkTP2 = {name="Smertrios's mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%'}}
    
	ValHead = {}
	ValHead.WS = {}
	ValHead.WS = {name="Valorous mask", augments={'Attack+25','Weapon skill damage +4%','STR+9','Accuracy+14'}}
	
	ValBody = {}
	ValBody.WS = {}
	ValBody.WS = {name="Valorous mail", augments={'Accuracy+25 Attack+25','Weapon skill damage +5%','AGI+6','Accuracy+12','Attack+11'}}
	
	ValHands = {}
	ValHands.WS = {}
	ValHands.TP = {}
	ValHands.WS = {name="Valorous mitts", augments={'Weapon skill damage +5%','STR+4','Accuracy+14','Attack+8'}}
	ValHands.TP = {name="Valorous mitts", augments={'Accuracy+18 Attack+18','"Store TP"+7','DEX+5','Accuracy+7',}}
	
	ValFeet = {}	
	ValFeet.WS = {}
	ValFeet.TP = {}
	ValFeet.WS = {name="Valorous greaves", augments={'Accuracy+13 Attack+13','Weapon skill damage +5%','DEX+9','Accuracy+9',}}
    ValFeet.TP = {name="Valorous Greaves", augments={'Pet: DEX+4','STR+11','"Store TP"+8','Accuracy+16 Attack+16'}}
	
	--------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
	
    sets.precast.JA['Meditate'] = {
	head		="Wakido Kabuto +2",
	hands		="Sakonji Kote +2",
	back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

	sets.precast.JA['Hasso'] = {hands="Wakido Kote +3",feet="Wakido Sune. +3"}
	
	sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +2"}
	
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +2"}
       
	sets.precast.JA['Provoke'] = sets.enmity
	
	-- Precast sets to enhance Spells
	
	sets.precast['Stun'] = sets.enmity
	
	-- End
	
    -- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    
	sets.precast.WS = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
    
	sets.precast.WS.LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
	
	sets.precast.WS.MidACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
	
	sets.precast.WS.MAX = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
						
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	sets.precast.WS['Tachi: Fudo'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},

}


    sets.precast.WS['Tachi: Fudo'].LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		="Sakonji domaru +1",
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia belt",
    left_ear	="Thrud Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Fudo'].MidACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		="Sakonji domaru +1",
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia belt",
    left_ear	="Thrud Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Fudo'].HighACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		="Sakonji domaru +1",
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia belt",
    left_ear	="Thrud Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Fudo'].MAX = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		="Sakonji domaru +1",
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia belt",
    left_ear	="Thrud Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})

	sets.precast.WS['Tachi: Shoha'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
													 
													 
    sets.precast.WS['Tachi: Shoha'].LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Shoha'].MidACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Grunfeld Rope",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Shoha'].HighACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Sakonji Kote +2", augments={'Enhances "Blade Bash" effect',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Grunfeld Rope",
    left_ear	="Telos Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Shoha'].MAX = set_combine(sets.precast.WS, {
    ammo		="Amar Cluster",
    head		="Ken. Jinpachi +1",
    body		="Ken. Samue +1",
    hands		="Flam. Manopolas +2",
    legs		="Ken. Hakama +1",
    feet		="Ken. Sune-Ate +1",
    neck		="Moonlight Nodowa",
    waist		="Grunfeld Rope",
    left_ear	="Telos Earring",
    right_ear	="Digni. Earring",
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})

	sets.precast.WS['Tachi: Rana'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
													  
													  
    sets.precast.WS['Tachi: Rana'].LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Rana'].MidACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Grunfeld Rope",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
	
	sets.precast.WS['Tachi: Rana'].HighACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Sakonji Kote +2", augments={'Enhances "Blade Bash" effect',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Grunfeld Rope",
    left_ear	="Telos Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Rana'].MAX = set_combine(sets.precast.WS, {
    ammo		="Amar Cluster",
    head		="Ken. Jinpachi +1",
    body		="Ken. Samue +1",
    hands		="Flam. Manopolas +2",
    legs		="Ken. Hakama +1",
    feet		="Ken. Sune-Ate +1",
    neck		="Moonlight Nodowa",
    waist		="Grunfeld Rope",
    left_ear	="Telos Earring",
    right_ear	="Digni. Earring",
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})

	sets.precast.WS['Tachi: Kaiten'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
													 
													 
    sets.precast.WS['Tachi: Kaiten'].LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Kaiten'].MidACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Grunfeld Rope",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Kaiten'].HighACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Sakonji Kote +2", augments={'Enhances "Blade Bash" effect',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Grunfeld Rope",
    left_ear	="Telos Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Tachi: Kaiten'].MAX = set_combine(sets.precast.WS, {
    ammo		="Amar Cluster",
    head		="Ken. Jinpachi +1",
    body		="Ken. Samue +1",
    hands		="Flam. Manopolas +2",
    legs		="Ken. Hakama +1",
    feet		="Ken. Sune-Ate +1",
    neck		="Moonlight Nodowa",
    waist		="Grunfeld Rope",
    left_ear	="Telos Earring",
    right_ear	="Digni. Earring",
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})

	sets.precast.WS['Tachi: Jinpu'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
    hands		={ name="Founder's Gauntlets", augments={'STR+10','Attack+15','"Mag.Atk.Bns."+15','Phys. dmg. taken -5%',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
    neck		="Fotia Gorget",
    waist		="Ioskeha Belt +1",
    left_ear	="Friomisi Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Damage taken-5%',}},
}
						
	sets.precast.WS['Tachi: Ageha'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
												
	
	sets.precast.WS['Namas Arrow'] = {}
													   
													   
	sets.precast.WS['Namas Arrow'].LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Namas Arrow'].MidACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
																	
    sets.precast.WS['Namas Arrow'].HighACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})
											   
    sets.precast.WS['Stardiver'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
													   
													   
	sets.precast.WS['Stardiver'].LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})											     
    
	
    sets.precast.WS['Impulse Drive'] = {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
}
													   
													   
	sets.precast.WS['Impulse Drive'].LowACC = set_combine(sets.precast.WS, {
    ammo		="Knobkierrie",
    head		={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','DEX+10','Accuracy+14','Attack+13',}},
    body		={ name="Valorous Mail", augments={'Accuracy+30','Weapon skill damage +3%','VIT+2','Attack+15',}},
    hands		={ name="Valorous Mitts", augments={'Attack+25','Weapon skill damage +4%','STR+7','Accuracy+10',}},
    legs		="Wakido Haidate +3",
    feet		={ name="Valorous Greaves", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+5','Accuracy+14',}},
    neck		="Fotia Gorget",
    waist		="Fotia Belt",
    left_ear	="Ishvara Earring",
    right_ear	={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
})											     
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {
    ammo		="Staunch Tathlum +1",
    head		="Ken. Jinpachi +1",
    body		="Dagon Breast.",
    hands		="Ken. Tekko +1",
    legs		="Ken. Hakama +1",
    feet		="Ken. Sune-Ate +1",
    neck		="Loricate Torque +1",
    waist		="Ioskeha Belt +1",
    left_ear	="Cessance Earring",
    right_ear	="Telos Earring",
    left_ring	="Regal Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
    
    sets.idle.Field = {
    ammo="Paeapua", head="Loess Barbuta +1", neck="Unmoving Collar +1", body="Emet Harness +1", ear1="Trux Earring", ear2="Cryptic Earring", 
	ring2="Petrov Ring", ring1="Begrudging Ring", hands="Kurys Gloves", waist="Sulla Belt", legs="Flamma Dirs +2", feet="Amm Greaves",
	back="Reiki Cloak",
}

    sets.idle.Weak = {
    ammo		="Staunch Tathlum +1",
    head		="Ken. Jinpachi +1",
    body		="Dagon Breast.",
    hands		="Ken. Tekko +1",
    legs		="Ken. Hakama +1",
    feet		="Ken. Sune-Ate +1",
    neck		="Loricate Torque +1",
    waist		="Eschan Stone",
    left_ear	="Thureous Earring",
    right_ear	="Cryptic Earring",
    left_ring	="Ilabrat Ring",
    right_ring	="Etana Ring",
    back		="Moonbeam Cape",
}
    
    -- Defense sets
    sets.defense.PDT = {
    ammo="Paeapua", head="Loess Barbuta +1", neck="Unmoving Collar +1", body="Emet Harness +1", ear1="Trux Earring", ear2="Cryptic Earring", 
	ring2="Provocare Ring", ring1="Supershear Ring", hands="Kurys Gloves", waist="Eschan Stone", legs="Flamma Dirs +2", feet="Amm Greaves",
	back="Reiki Cloak",
}
	
    sets.defense.MDT = {
    ammo		="Staunch Tathlum +1",
    head		="Ken. Jinpachi +1",
    body		="Wakido Domaru +2",
    hands		="Ken. Tekko +1",
    legs		="Ken. Hakama +1",
    feet		={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
    neck		="Loricate Torque +1",
    waist		="Flume Belt",
    left_ear	="Etiolation Earring",
    right_ear	="Handler's Earring +1",
    left_ring	="Defending Ring",
    right_ring	={ name="Dark Ring", augments={'Breath dmg. taken -5%','Magic dmg. taken -6%','Phys. dmg. taken -4%',}},
    back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	
    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    
	sets.engaged = {
    ammo		="Ginsen",
    head		="Flam. Zucchetto +2",
    body		="Ken. Samue +1",
    hands		="Wakido Kote +3",
    legs		="Ken. Hakama +1",
    feet		="Wakido sune-ate +3",
    neck		="Moonlight Nodowa",
    waist		="Ioskeha Belt +1",
    left_ear	="Cessance Earring",
    right_ear	="Telos Earring",
    left_ring	="Flamma Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	
	sets.engaged.LowACC = {
    ammo		="Ginsen",
    head		="Flam. Zucchetto +2",
    body		="Ken. Samue +1",
    hands		="Wakido Kote +3",
    legs		="Ken. Hakama +1",
    feet		="Wakido sune-ate +3",
    neck		="Moonlight Nodowa",
    waist		="Ioskeha Belt +1",
    left_ear	="Cessance Earring",
    right_ear	="Telos Earring",
    left_ring	="Flamma Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
	
    sets.engaged.MidACC = {
    ammo		="Ginsen",
    head		="Flam. Zucchetto +2",
    body		="Ken. Samue +1",
    hands		="Wakido Kote +3",
    legs		="Ken. Hakama +1",
    feet		="Wakido sune-ate +3",
    neck		="Moonlight Nodowa",
    waist		="Ioskeha Belt +1",
    left_ear	="Cessance Earring",
    right_ear	="Telos Earring",
    left_ring	="Flamma Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}

	sets.engaged.HighACC = {
    ammo		="Ginsen",
    head		="Flam. Zucchetto +2",
    body		="Ken. Samue +1",
    hands		="Wakido Kote +3",
    legs		="Ken. Hakama +1",
    feet		="Wakido sune-ate +3",
    neck		="Moonlight Nodowa",
    waist		="Ioskeha Belt +1",
    left_ear	="Cessance Earring",
    right_ear	="Telos Earring",
    left_ring	="Flamma Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}
        
    sets.engaged.MAX = {
    ammo		="Ginsen",
    head		="Flam. Zucchetto +2",
    body		="Ken. Samue +1",
    hands		="Wakido Kote +3",
    legs		="Ken. Hakama +1",
    feet		="Wakido sune-ate +3",
    neck		="Moonlight Nodowa",
    waist		="Ioskeha Belt +1",
    left_ear	="Cessance Earring",
    right_ear	="Telos Earring",
    left_ring	="Flamma Ring",
    right_ring	="Niqmaddu Ring",
    back		={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
}		

    sets.buff.Sekkanoki = {hands="Kasuga Kote"}
    sets.buff.Sengikori = {feet="Kasuga Sune-ate"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Stardiver" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
	if spell.name:lower() == 'stun' then
		equip(sets.precast['Stun'])
	end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
	if spell.name:lower() == 'stun' then
		equip(sets.precast['Stun'])
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'DRK' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end
