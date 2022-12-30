-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

------------------BEDEVEREJR.lua-------------------------------------------------------------------------------------


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	Merlinic={}
	MerlinicHeadMB = {name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+6%','CHR+8','Mag. Acc.+13','"Mag.Atk.Bns."+12',}}
	MerlinicHeadFree = {name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Enmity-2','INT+7','Mag. Acc.+14','"Mag.Atk.Bns."+6',}}
	MerlinicLegsMB = {name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+26','Attack+30','Accuracy+3 Attack+3','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
	MerlinicLegsFree = {name="Merlinic Shalwar", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Enmity-4','INT+10','Mag. Acc.+12','"Mag.Atk.Bns."+11',}}
	MerlinicFeetMB = {name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+19','Magic burst dmg.+8%','INT+7','Mag. Acc.+13',}}
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
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}

    -- Fast cast sets for spells
	

    sets.precast.FC = {head="Nahtirah Hat",
    body="Anhur Robe",
    hands="Mallquis cuffs",
    legs="Lengo pants",
    feet="Merlinic Crackows",
    neck="Baetyl Pendant",
    waist="Channeler's Stone",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +19','Pet: Damage taken -3%',}}}
		
	sets.precast.Impact = set_combine(sets.precast.FC, {body="Twilight Cloak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Tamaxchi",sub="Genbu's Shield",body="Heka's Kalasiris",back="Pahtli Cape"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines +1",ear1="Barkarole Earring"})

    
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
    sets.midcast.FastRecast = {main="Idris",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+6%','CHR+8','Mag. Acc.+13','"Mag.Atk.Bns."+12',}},
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Damage taken-1%','MND+6','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Occult Acumen"+10','INT+9','Mag. Acc.+4','"Mag.Atk.Bns."+14',}},
    neck="Erra Pendant",
    waist="Porous Rope",
    left_ear="Digni. Earring",
    right_ear="Cessance Earring",
    left_ring="Rahab Ring",
    right_ring="Stikini Ring +1",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +19','Pet: Damage taken -3%',}},}
		
	sets.midcast.EnfeeblingMagic = {ammo="Ghastly Tathlum",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+7','Magic burst dmg.+9%','MND+2','Mag. Acc.+12',}},
    body="Jhakri Robe +1",
    hands="Jhakri cuffs +1",
    legs="Jhakri slops +1",
    feet="Jhakri Pigaches +1",
    neck="Incanter's torque",
    waist="Aswang Sash",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Jhakri Ring",
    right_ring="Adoulin Ring",
    back="Seshaw Cape"}
		
	sets.midcast.Drain = {ammo="Ghastly Tathlum",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+7','Magic burst dmg.+9%','MND+2','Mag. Acc.+12',}},
    body="Jhakri Robe +1",
    hands="Jhakri cuffs +1",
    legs="Jhakri slops +1",
    feet="Jhakri Pigaches +1",
    neck="Incanter's torque"",
    waist="Aswang Sash",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Jhakri Ring",
    right_ring="Adoulin Ring",
    back="Seshaw Cape"}
		
	sets.midcast.Aspir = sets.midcast.Drain	

    sets.midcast.Geomancy = {main={ name="Solstice", augments={'MP+60','INT+15','"Mag.Atk.Bns."+15',}},
    sub="Solstice",
    ammo="Ghastly Tathlum",
    head="Azimuth Hood +1",
    body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
    hands="Geo. Mitaines +1",
    legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
    feet={ name="Bagua Sandals +1", augments={'Enhances "Radial Arcana" effect',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Loquac. Earring",
    right_ear="Gifted Earring",
    left_ring="Prolix Ring",
    right_ring="Vertigo Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +3','Indi. eff. dur. +14',}}}
							 
    sets.midcast.Geomancy.Indi = {main={ name="Solstice", augments={'MP+60','INT+15','"Mag.Atk.Bns."+15',}},
    sub="Solstice",
    ammo="Ghastly Tathlum",
    head="Azimuth Hood +1",
    body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
    hands="Geo. Mitaines +1",
    legs={ name="Bagua Pants", augments={'Enhances "Mending Halation" effect',}},
    feet={ name="Bagua Sandals +1", augments={'Enhances "Radial Arcana" effect',}},
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Loquac. Earring",
    right_ear="Gifted Earring",
    left_ring="Prolix Ring",
    right_ring="Vertigo Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +3','Indi. eff. dur. +14',}}}
	
	sets.midcast['Elemental Magic'] = {ammo="Ghastly Tathlum",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+7','Magic burst dmg.+9%','MND+2','Mag. Acc.+12',}},
    body="Jhakri Robe +1",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+11','Magic burst dmg.+11%','INT+3',}},
    feet="Jhakri Pigaches +1",
    neck="Mizu. Kubikazari",
    waist="Aswang Sash",
    left_ear="Friomisi Earring",
    right_ear="Hecate's Earring",
    left_ring="Jhakri Ring",
    right_ring="Adoulin Ring",
    back="Seshaw Cape"}

    sets.midcast.Cure = {main={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
    sub={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
    ammo="Sapience Orb",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body="Jhakri Robe +1",
    hands="Geo. Mitaines +1",
    legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+9%',}},
    neck="Twilight Torque",
    waist="Witful Belt",
    left_ear="Gifted Earring",
    right_ear="Loquac. Earring",
    left_ring="Jhakri Ring",
    right_ring="Adoulin Ring",
    back="Solemnity Cape"}
    
    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Aquaveil = {main="Earth Staff",
    sub="Irenic Strap",
    ammo="Vanir Battery",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+3%','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
	
	sets.midcast.Haste = {main="Earth Staff",
    sub="Irenic Strap",
    ammo="Vanir Battery",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+3%','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
	
	sets.midcast.Refresh = {main="Earth Staff",
    sub="Irenic Strap",
    ammo="Vanir Battery",
    head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+3%','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Gishdubar sash",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back="Grapevine cape"}

    sets.midcast.Protectra = {ring1="Renaye Ring"}
	
	sets.midcast.Stoneskin = {head="Umuthi Hat",body="Telchine Chasuble",neck="Nodens Gorget",
							  waist="Siegel Sash",legs="Haven Hose",feet="Regal Pumps +1"}

    sets.midcast.Shellra = {ring1="Renaye Ring"}
	
	sets.midcast.Impact = {body="Twilight Cloak"}
	
	-- Set for Magic Burst Only
	
	sets.magic_burst = {main="Idris",
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

    sets.idle = {main={ name="Solstice", augments={'MP+60','INT+15','"Mag.Atk.Bns."+15',}},
    sub={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
    ammo="Ghastly Tathlum",
    head="Azimuth Hood +1",
    body="Jhakri Robe +1",
    hands="Geo. Mitaines +1",
    legs={ name="Telchine Braconi", augments={'Pet: Mag. Acc.+20','Pet: "Regen"+3','Pet: Damage taken -2%',}},
    feet={ name="Bagua Sandals +1", augments={'Enhances "Radial Arcana" effect',}},
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Gifted Earring",
    left_ring="Jhakri Ring",
    right_ring="Adoulin Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','MP+22','Rng.Atk.+2','DEF+6',}}}

    sets.idle.PDT = {main="Earth Staff",sub="Irenic Strap",ammo="Vanir Battery",
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body="Jhakri Robe +2",
    hands={ name="Merlinic Dastanas", augments={'"Conserve MP"+5','Phys. dmg. taken -3%','"Refresh"+1','Accuracy+4 Attack+4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+10','Mag. Acc.+11','"Mag.Atk.Bns."+9',}},
    feet={ name="Merlinic Crackows", augments={'"Fast Cast"+3','Pet: "Subtle Blow"+7','Phalanx +5','Accuracy+17 Attack+17',}},
    neck="Loricate Torque +1",waist="Slipor Sash",left_ear="Etiolation Earring",right_ear="Odnowa Earring +1",
    left_ring="Lunette Ring +1",right_ring="Defending Ring",back="Solemnity Cape"}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main={ name="Solstice", augments={'MP+60','INT+15','"Mag.Atk.Bns."+15',}},
    sub={ name="Nibiru Cudgel", augments={'MP+50','INT+10','"Mag.Atk.Bns."+15',}},
    ammo="Ghastly Tathlum",
    head="Azimuth Hood +1",
    body="Jhakri Robe +1",
    hands="Geo. Mitaines +1",
    legs={ name="Telchine Braconi", augments={'Pet: Mag. Acc.+20','Pet: "Regen"+3','Pet: Damage taken -2%',}},
    feet={ name="Bagua Sandals +1", augments={'Enhances "Radial Arcana" effect',}},
    neck="Twilight Torque",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Gifted Earring",
    left_ring="Jhakri Ring",
    right_ring="Adoulin Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','MP+22','Rng.Atk.+2','DEF+6',}}}

    sets.idle.PDT.Pet = {main="Idris",
    sub="Genbu's Shield",
    ammo="Vanir Battery",
    head={ name="Telchine Cap", augments={'Pet: "Regen"+3','Pet: Damage taken -4%',}},
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
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}

    sets.idle.Town = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+17','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+21','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Stikini Ring +1",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}

    sets.idle.Weak = {main="Idris",
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands={ name="Telchine Gloves", augments={'Pet: "Regen"+2','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+17','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+21','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Etiolation earring",
    right_ear="Odnowa Earring +1",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}}}
    -- Defense sets

    sets.defense.PDT = {main="Solstice",sub="Genbu's Shield",range="Dunna",
		head="Befouled Crown",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Bagua Mitaines +1",ring1="Renaye Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}

    sets.defense.MDT = {main="Solstice",sub="Genbu's Shield",range="Dunna",
		head="Befouled Crown",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Jhakri Robe +2",hands="Bagua Mitaines +1",ring1="Renaye Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Fucho-no-Obi",legs="Assiduity Pants +1",feet="Geomancy Sandals +1"}

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