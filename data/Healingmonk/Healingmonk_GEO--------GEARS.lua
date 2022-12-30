-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

require("no_interruptions")

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

    sets.precast.FC = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body="Zendik Robe",
    hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
    legs="Geomancy Pants",
    feet={ name="Merlinic Crackows", augments={'"Conserve MP"+2','Pet: Mag. Acc.+8','"Refresh"+2',}},
    neck="Sanctity Necklace",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10',}}}
		
	sets.precast.Impact = set_combine(sets.precast.FC, {body="Twilight Cloak"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal",hands="Bagua Mitaines +1",ear1="Barkarole Earring"})

    
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
		
	sets.midcast.EnfeeblingMagic = {main={ name="Grioavolr", augments={'INT+9','Mag. Acc.+29','"Mag.Atk.Bns."+30','Magic Damage +5',}},
    sub="Enki Strap",
    range="Nepote Bell",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'Attack+19','STR+8','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Regal Earring",
    right_ear="Hermetic Earring",
    left_ring="Perception Ring",
    right_ring="Etana Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10',}}}
		
	sets.midcast.Dispel = {main={ name="Grioavolr", augments={'INT+9','Mag. Acc.+29','"Mag.Atk.Bns."+30','Magic Damage +5',}},
    sub="Enki Strap",
    range="Nepote Bell",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'Attack+19','STR+8','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Regal Earring",
    right_ear="Hermetic Earring",
    left_ring="Perception Ring",
    right_ring="Etana Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10',}}}
		
	sets.midcast.Drain = {main={ name="Grioavolr", augments={'INT+9','Mag. Acc.+29','"Mag.Atk.Bns."+30','Magic Damage +5',}},
    sub="Enki Strap",
    range="Nepote Bell",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'Attack+19','STR+8','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Regal Earring",
    right_ear="Hermetic Earring",
    left_ring="Perception Ring",
    right_ring="Etana Ring",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10',}}}
		
	sets.midcast.Aspir = sets.midcast.Drain	

    sets.midcast.Geomancy = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    range="Nepote Bell",
    head="Azimuth Hood",
    body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
    hands="Geomancy Mitaines",
    legs="Geomancy Pants",
    feet={ name="Merlinic Crackows", augments={'Attack+19','STR+8','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Eabani Earring",
    right_ear="Flashward Earring",
    left_ring="Etana Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
							 
    sets.midcast.Geomancy.Indi = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    range="Nepote Bell",
    head="Azimuth Hood",
    body={ name="Bagua Tunic", augments={'Enhances "Bolster" effect',}},
    hands="Geomancy Mitaines",
    legs="Geomancy Pants",
    feet={ name="Merlinic Crackows", augments={'Attack+19','STR+8','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Eabani Earring",
    right_ear="Flashward Earring",
    left_ring="Etana Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
	
	sets.midcast['Elemental Magic'] = {main={ name="Grioavolr", augments={'INT+9','Mag. Acc.+29','"Mag.Atk.Bns."+30','Magic Damage +5',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'"Conserve MP"+2','Pet: Mag. Acc.+8','"Refresh"+2',}},
    neck="Sanctity Necklace",
    waist="Oneiros Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10',}}}

    sets.midcast.Cure = {main="Tamaxchi",sub="Sors Shield",ammo="Aqua Sachet",
		head="Vanya Hood",neck="Nodens Gorget",
        body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Tempered Cape +1",waist="Cascade Belt",legs="Telchine Braconi",feet="Medium's Sabots"}
    
    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Protectra = {ring1="Renaye Ring"}
	
	sets.midcast.Stoneskin = {head="Umuthi Hat",body="Telchine Chasuble",neck="Nodens Gorget",
							  waist="Siegel Sash",legs="Haven Hose",feet="Regal Pumps +1"}

    sets.midcast.Shellra = {ring1="Renaye Ring"}
	
	sets.midcast.Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
	
	sets.midcast.Impact = {body="Twilight Cloak"}
	
	-- Set for Magic Burst Only
	
	sets.magic_burst = {main={ name="Grioavolr", augments={'INT+9','Mag. Acc.+29','"Mag.Atk.Bns."+30','Magic Damage +5',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'"Conserve MP"+2','Pet: Mag. Acc.+8','"Refresh"+2',}},
    neck="Sanctity Necklace",
    waist="Oneiros Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10',}}}


    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
        body="Jhakri Robe +1",hands="Merlinic Dastanas",ring1="Renaye Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",legs="Assiduity Pants +1",feet="Chelona Boots"}


    -- Idle sets

    sets.idle = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    range="Nepote Bell",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'Attack+19','STR+8','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Eabani Earring",
    right_ear="Flashward Earring",
    left_ring="Etana Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}

    sets.idle.PDT = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    range="Nepote Bell",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Merlinic Crackows", augments={'Attack+19','STR+8','"Refresh"+1','Accuracy+19 Attack+19','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Eabani Earring",
    right_ear="Flashward Earring",
    left_ring="Etana Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    range="Nepote Bell",
    head="Azimuth Hood",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+16','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+15','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Eabani Earring",
    right_ear="Flashward Earring",
    left_ring="Etana Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}}

    sets.idle.PDT.Pet = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    range="Nepote Bell",
    head="Azimuth Hood",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+16','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+15','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Eabani Earring",
    right_ear="Flashward Earring",
    left_ring="Etana Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}}

    sets.idle.Town = {main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Sors Shield",
    range="Nepote Bell",
    head="Azimuth Hood",
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+16','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+15','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%',}},
    neck="Sanctity Necklace",
    waist="Gishdubar Sash",
    left_ear="Eabani Earring",
    right_ear="Flashward Earring",
    left_ring="Etana Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10','Pet: "Regen"+5',}}}

    sets.idle.Weak = {main="Solstice",sub="Genbu's Shield",range="Dunna",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Handler's Earring +1",ear2="Odnowa Earring +1",
        back={ name="Nantosuelta's Cape", augments={'Pet: "Regen"+10',}},
		hands="Bagua Mitaines +1",ring1="Renaye Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Fucho-no-Obi",legs={ name="Telchine Braconi", augments={'Mag. Evasion+17','Pet: "Regen"+3','Pet: Damage taken -4%',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+21','Pet: "Regen"+3','Pet: Damage taken -4%',}}}
    -- Defense sets

    sets.defense.PDT = {main="Bolelabunga",
    sub="Genbu's Shield",
    range="Dunna",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs="Assid. Pants +1",
    feet="Mallquis Clogs +1",
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Insect Ring",
    back="Solemnity Cape"}

    sets.defense.MDT = {main="Bolelabunga",
    sub="Genbu's Shield",
    range="Dunna",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands="Jhakri Cuffs +1",
    legs="Assid. Pants +1",
    feet="Mallquis Clogs +1",
    neck="Loricate Torque +1",
    waist="Slipor Sash",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Insect Ring",
    back="Solemnity Cape"}

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

