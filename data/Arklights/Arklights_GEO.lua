-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

require("no_interruptions")

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

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
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	
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
    sets.precast.JA['Life cycle'] = {body="Geomancy Tunic"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +1"}

    -- Fast cast sets for spells

    sets.precast.FC = {
    head="Vanya Hood",
    body="Anhur Robe",
    hands="Leyline gloves",
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    feet={ name="Merlinic Crackows", augments={'"Fast Cast"+3','Pet: "Subtle Blow"+7','Phalanx +5','Accuracy+17 Attack+17',}},
    neck="Baetyl pendant",
    waist="Witful belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +19','Pet: Damage taken -4%','Damage taken-3%',}}}
		
	sets.precast.Impact = set_combine(sets.precast.FC, {body="Twilight Cloak"})

    sets.precast.FC.Cure = {head="Vanya Hood",
    body="Anhur Robe",
    hands="Leyline gloves",
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    feet={ name="Merlinic Crackows", augments={'"Fast Cast"+3','Pet: "Subtle Blow"+7','Phalanx +5','Accuracy+17 Attack+17',}},
    neck="Baetyl pendant",
    waist="Witful belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +19','Pet: Damage taken -4%','Damage taken-3%',}}}

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear2="Barkarole Earring"})

    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
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
    sets.midcast.FastRecast = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+11','Pet: Mag. Acc.+10','Pet: "Mag.Atk.Bns."+19',}},
    sub="Enki Strap",
    ranged="Dunna",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+26','Magic burst dmg.+8%','Mag. Acc.+14',}},
    feet="Medium's Sabots",
    neck="Sanctity Necklace",
    waist="Ovate Rope",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back="Ogapepo Cape"}
	
	sets.midcast.EnhancingMagic = {head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+3%','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}}
	
	sets.midcast.EnfeeblingMagic = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+11','Pet: Mag. Acc.+10','Pet: "Mag.Atk.Bns."+19',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs={ name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+26','Magic burst dmg.+8%','Mag. Acc.+14',}},
    feet="Medium's Sabots",
    neck="Sanctity Necklace",
    waist="Luminary sash",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Kishar Ring",
    right_ring="Stikini Ring",
    back="Ogapepo Cape"}
	
	sets.midcast.Dispel = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+11','Pet: Mag. Acc.+10','Pet: "Mag.Atk.Bns."+19',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+10','Mag. Acc.+11','"Mag.Atk.Bns."+9',}},
    feet="Medium's Sabots",
    neck="Sanctity Necklace",
    waist="Luminary sash",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Kishar Ring",
    right_ring="Stikini Ring",
    back="Ogapepo Cape"}
	
	sets.midcast.Drain = {main={ name="Rubicundity", augments={'Mag. Acc.+6','"Mag.Atk.Bns."+7','Dark magic skill +7',}},
    sub="Genbu's Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +6','MND+10','Mag. Acc.+6','"Mag.Atk.Bns."+13',}},
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+10','Mag. Acc.+11','"Mag.Atk.Bns."+9',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Mag. crit. hit dmg. +7%','INT+10','Mag. Acc.+10',}},
    neck="Erra Pendant",
    waist="Fucho-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Digni. Earring",
    left_ring="Shiva Ring +1",
    right_ring="Evanescence Ring",
    back="Ogapepo Cape"}
	
	sets.midcast.Aspir = sets.midcast.Drain	

    sets.midcast.Geomancy = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
    hands="Geomancy Mitaines",
    legs="Assid. Pants +1",
    feet="Azimuth Gaiters",
    neck="Loricate Torque +1",
    waist="Luminary Sash",
    left_ear="Calamitous Earring",
    right_ear="Gwati Earring",
    left_ring="Renaye Ring",
    right_ring="Stikini Ring +1",
    back="Lifestream Cape"}
							 
    sets.midcast.Geomancy.Indi = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
    hands="Geomancy Mitaines",
    legs="Assid. Pants +1",
    feet="Azimuth Gaiters",
    neck="Loricate Torque +1",
    waist="Luminary Sash",
    left_ear="Calamitous Earring",
    right_ear="Gwati Earring",
    left_ring="Renaye Ring",
    right_ring="Stikini Ring +1",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +19','Pet: Damage taken -4%','Damage taken-3%',}}}
	
	sets.midcast['Elemental Magic'] = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+11','Pet: Mag. Acc.+10','Pet: "Mag.Atk.Bns."+19',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +6','MND+10','Mag. Acc.+6','"Mag.Atk.Bns."+13',}},
    body="Jhakri Robe +2",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+10','Mag. Acc.+11','"Mag.Atk.Bns."+9',}},
    feet="Jhakri Pigaches +1",
    neck="Mizu. Kubikazari",
    waist="Refoccilation Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back="Ogapepo Cape"}

    sets.midcast.Cure = {main="Raetic Rod +1",
    sub="Genbu's Shield",
    range="Dunna",
    head="Vanya Hood",
    body="Annoint. Kalasiris",
    hands="Geomancy Mitaines",
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    feet={ name="Merlinic Crackows", augments={'Pet: MND+7','Pet: VIT+3','"Refresh"+2',}},
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +19','Pet: Damage taken -4%','Damage taken-3%',}}}
	
	sets.midcast.Cursna = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +4','MND+2','"Mag.Atk.Bns."+9','DMG:+8',}},
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body="Zendik Robe",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Geomancy Pants +3",
    feet={ name="Bagua Sandals +1", augments={'Enhances "Radial Arcana" effect',}},
    neck="Malison Medallion",
    waist="Gishdubar Sash",
    left_ear="Meili Earring",
    right_ear="Beatific Earring",
    left_ring="Menelaus's Ring",
    right_ring="Haoma's Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +1','Indi. eff. dur. +18','Pet: Damage taken -5%','Damage taken-1%',}}}
	
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {ring1="Renaye Ring"}
	
	sets.midcast.Stoneskin = {head="Umuthi Hat",body="Telchine Chasuble",neck="Nodens Gorget",waist="Siegel Sash",legs="Haven Hose",feet="Regal Pumps +1"}
	
    sets.midcast.Shellra = {ring1="Renaye Ring"}
	
	sets.midcast.Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
	
	sets.midcast.Impact = {body="Twilight Cloak"}
	
	sets.midcast.Phalanx = {}
	
	sets.midcast.Haste = {head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+3%','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}}
	
	-- Set for Magic Burst Only
	
	sets.magic_burst = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+11','Pet: Mag. Acc.+10','Pet: "Mag.Atk.Bns."+19',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +6','MND+10','Mag. Acc.+6','"Mag.Atk.Bns."+13',}},
    body="Jhakri Robe +2",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+10','Mag. Acc.+11','"Mag.Atk.Bns."+9',}},
    feet="Jhakri Pigaches +1",
    neck="Mizu. Kubikazari",
    waist="Refoccilation Stone",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back="Ogapepo Cape"}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
        body="Jhakri Robe +1",hands="Merlinic Dastanas",ring1="Renaye Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Assiduity Pants +1",feet="Chelona Boots"}


    -- Idle sets

    sets.idle = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head={ name="Telchine Cap", augments={'Pet: "Regen"+3','Pet: Damage taken -3%',}},
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines",
    legs="Assid. Pants +1",
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}

    sets.idle.PDT = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genbu's Shield",
    range="Dunna",
    head={ name="Telchine Cap", augments={'Pet: "Regen"+3','Pet: Damage taken -3%',}},
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines",
    legs="Assid. Pants +1",
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}}

    sets.idle.PDT.Pet = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}}

    sets.idle.Town = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head={ name="Telchine Cap", augments={'Pet: "Regen"+3','Pet: Damage taken -3%',}},
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines",
    legs="Assid. Pants +1",
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}

    sets.idle.Weak = {main="Solstice",sub="Genbu's Shield",range="Dunna",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Handler's Earring +1",ear2="Odnowa Earring +1",
        back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}},
		hands="Bagua Mitaines +1",ring1="Renaye Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Fucho-no-Obi",legs={ name="Telchine Braconi", augments={'Mag. Evasion+17','Pet: "Regen"+3','Pet: Damage taken -4%',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+21','Pet: "Regen"+3','Pet: Damage taken -4%',}}}
    -- Defense sets

    sets.defense.PDT = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genbu's Shield",
    range="Dunna",
    head={ name="Telchine Cap", augments={'Pet: "Regen"+3','Pet: Damage taken -3%',}},
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines",
    legs="Assid. Pants +1",
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}

    sets.defense.MDT = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genbu's Shield",
    range="Dunna",
    head={ name="Telchine Cap", augments={'Pet: "Regen"+3','Pet: Damage taken -3%',}},
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines",
    legs="Assid. Pants +1",
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

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
function select_default_macro_book()
    set_macro_page(1, 20)
end

