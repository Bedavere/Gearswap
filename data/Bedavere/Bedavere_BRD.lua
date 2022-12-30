require("no_interruptions")

-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Mordant Rime
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    SongMode may take one of three values: None, Placeholder, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder
    
    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Hybrid', 'Club') --Added Hybrid 7/19/22
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant', 'Enmity') --Added Emnity 5/26/22 [Non-working at the moment]
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Horn', 'Harp'}

    state.Carol = M{['description']='Carol', 
    'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
    'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
    'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
    }

    state.Threnody = M{['description']='Threnody',
    'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
    'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
    }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
    'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
    'Spirited Etude', 'Logical Etude', 'Echanting Etude', 'Bewitching Etude'}

    state.WeaponLock = M(false, 'Weapon Lock')
    state.CP = M(false, "Capacity Points Mode")

    -- Additional local binds
    --include('Global-Binds.lua') -- OK to remove this line
    --include('Global-GEO-Binds.lua') -- OK to remove this line

    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
    
    send_command('bind ^` gs c cycle SongMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')

    send_command('bind ^backspace gs c cycle SongTier')
    send_command('bind ^insert gs c cycleback Etude')
    send_command('bind ^delete gs c cycle Etude')
    send_command('bind ^home gs c cycleback Carol')
    send_command('bind ^end gs c cycle Carol')
    send_command('bind ^pageup gs c cycleback Threnody')
    send_command('bind ^pagedown gs c cycle Threnody')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @c gs c toggle CP')

    send_command('bind ^numpad7 input /ws "Mordant Rime" <t>')
    send_command('bind ^numpad4 input /ws "Evisceration" <t>')
    send_command('bind ^numpad5 input /ws "Rudra\'s Storm" <t>')
    send_command('bind ^numpad1 input /ws "Aeolian Edge" <t>')
    send_command('bind ^numpad2 input /ws "Wasp Sting" <t>')
    send_command('bind ^numpad3 input /ws "Gust Slash" <t>')

    select_default_macro_book()
    set_lockstyle()

    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^backspace')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
    send_command('unbind @c')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
    head="Vanya Hood",
    body="Inyanga Jubbah +2",
    hands="Leyline Gloves",
    legs="Ayanmo cosciales +2",
    feet="Bihu Slippers +3",
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Enchanter's Earring +1",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10'}}}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    right_ear="Mendi. Earring"})

    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
    head="Vanya Hood",
    body="Inyanga Jubbah +2",
    hands="Leyline Gloves",
    legs="Ayanmo cosciales +2",
    feet="Bihu Slippers +3",
    neck="Orunmila's Torque",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Enchanter's Earring +1",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10'}}})

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}}}
    sets.precast.JA.Troubadour = {body={ name="Bihu Justaucorps +3", augments={'Enhances "Troubadour" effect',}}}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +2"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
       
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
    head="Nyame helm",
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands="Nyame Gauntlets",
    legs="Nyame flanchard",
    feet="Nyame Sollerets",
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ifrit Ring +1",
    right_ring="Epaminondas's Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
    head={ name="Lustratio Cap +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Lustr. Mittens +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
    legs={ name="Bihu Cannions +2", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ifrit Ring +1",
    right_ring="Epaminondas's Ring",
    back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}})
	
	--range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
    --head="Nyame helm",
    --body="Bihu Jstcorps. +3",
    --hands="Nyame Gauntlets",
    --legs="Nyame flanchard",
    --feet=Bihu slippers +3,
    --neck="Caro Necklace",
    --waist="Sailfi Belt +1",
    --left_ear="Ishvara Earring",
    --right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    --left_ring="Ifrit Ring +1",
    --right_ring="Epaminondas's Ring",
    --back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
    
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Aeolean Edge'] = set_combine(sets.precast.WS, {
	range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Mizu. Kubikazari",
    waist="Orpheus's Sash",
    left_ear="Sanare Earring",
    right_ear="Regal Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}})
	
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
    range={ name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6 DEX+6',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Bihu Cannions +2", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist="Fucho-no-Obi",
    left_ear="Ishvara Earring",
    right_ear="Regal Earring",
    left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    right_ring="Epaminondas's Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}})

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
    waist="Fotia belt",
    left_ring="Ilabrat Ring"})
    
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	--Timers Need Adjustment After Obtaining Brioso +1 And +2 Feet.
	
	--Minuet           10:52
	--Madrigal         10:52
	--Prelude          10:56
	--Vmarch           11:09
	--Hmarch           11:33 
	--Minne            10:52 
	--Ballad           10:45
	--Etude            10:45
	--Carol            10:56
	--Scherzo          10:45
	
	
    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC
        
    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {body="Fili Hongreline +2",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
	
    sets.midcast.Carol = {hands="Mousai Gages +1",legs="Inyanga Shalwar +2",feet="Nyame sollerets"}
	
    sets.midcast.Etude = {}
	
    sets.midcast.HonorMarch = {range="Marsyas",hands="Fili Manchettes +2",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
	
	sets.midcast['Foe Lullaby'] = {main="Daybreak",
    sub="Genmei Shield",
    range="Daurdabla",
    head="Halitus helm",
    body="Emet Harness",
    hands="Brioso cuffs +3",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Unmoving collar +1",
    waist="Trance belt",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Petrov Ring",
    right_ring="Eihwaz Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
	sets.midcast['Foe Lullaby II'] = {main="Daybreak",
    sub="Genmei Shield",
    range="Daurdabla",
    head="Halitus helm",
    body="Emet Harness",
    hands="Brioso cuffs +3",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Unmoving collar +1",
    waist="Trance belt",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Petrov Ring",
    right_ring="Eihwaz Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
	--sets.midcast['Horde Lullaby'] = {main="Daybreak",                                              --Enmity Set for Odyseey NMs
    --sub="Genmei Shield",
    --range="Daurdabla",
    --head="Halitus helm",
    --body="Emet Harness",
    --hands="Brioso cuffs +3",
    --legs="Nyame flanchard",
    --feet="Nyame sollerets",
    --neck="Unmoving collar +1",
    --waist="Trance belt",
    --left_ear="Cryptic Earring",
    --right_ear="Friomisi Earring",
    --left_ring="Petrov Ring",
    --right_ring="Eihwaz Ring",
    --back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
	sets.midcast['Horde Lullaby'] = {main="Daybreak",
    sub="Genmei Shield",
    range="Daurdabla",
    head="Halitus helm",
    body="Emet Harness",
    hands="Brioso cuffs +3",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Unmoving collar +1",
    waist="Trance belt",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Petrov Ring",
    right_ring="Eihwaz Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
	sets.midcast['Horde Lullaby II'] = {head="Brioso Roundlet +3",
    body="Fili Hongreline +2",
    hands="Brioso Cuffs +3",
    legs="Brioso Cannions +3",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
	
    sets.midcast.Madrigal = {head="Fili Calot +2",back="Intarabus's cape",legs="Nyame flanchard"}
	
	sets.midcast.Prelude = {head="Fili Calot +2",back="Intarabus's cape",legs="Inyanga Shalwar"}
	
    sets.midcast.Mambo = {}
	
    sets.midcast.March = {hands="Fili Manchettes +2",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
	
    sets.midcast.Minne = {body="Fili Hongreline +2",legs="Mousai seraweels +1",feet="Brioso Slippers +3"}
	
    sets.midcast.Minuet = {body="Fili Hongreline +2",legs="Inyanga Shalwar +1",feet="Brioso Slippers"} --Regular
	--sets.midcast.Minuet = {body="Fili Hongreline +2",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"} --FullDuration
	
    sets.midcast.Paeon = {range="Daurdabla",
    head="Bunzi's Hat",
    body="Bunzi's Robe",
    hands="Bunzi's Gloves",
    legs="Bunzi's Pants",
    feet="Bunzi's Sabots",
    neck="Unmoving Collar +1",
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Shneddick Ring",
    right_ring="Moonlight Ring",
    back="Moonlight cape"}
	
    --sets.midcast.Threnody = {body="Mousai Manteel"}
	
    sets.midcast['Adventurer\'s Dirge'] = {hands="Bihu Cuffs +3"}
	
    sets.midcast['Foe Sirvente'] = {head="Bihu Roundlet +2"}
	
    --sets.midcast['Magic Finale'] = {legs="Fili Rhingrave +1"}
	
    sets.midcast["Sentinel's Scherzo"] = {}

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
    main="Carnwenhan",
    sub="Genmei Shield",
    range="Gjallarhorn",
    head="Nyame helm",
    body="Fili Hongreline +2",
    hands="Fili Manchettes +2",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    ear1="Genmei Earring",
    ear2="Etiolation Earring",
    ring1="Moonlight Ring",
    ring2="Defending Ring",
    waist="Flume Belt +1",
    back="Moonlight Cape"
	}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
    --main="Carnwenhan",
    --sub="Ammurapi Shield",
    --range="Gjallarhorn",
    head="Brioso Roundlet +3",
    body="Fili Hongreline +2",
    hands="Brioso Cuffs +3",
    legs="Brioso Cannions +3",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Digni. Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

    -- For song debuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {legs="Brioso Cannions +3"})
	
	-- Testing/Not Working [Function for Enmity Casting Set]
	sets.midcast.SongEnfeebleEnmity = {body="Emet Harness"}

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = set_combine(sets.midcast.SongEnhancing, {range=info.ExtraSongInstrument})

    -- Other general spells and classes.
    sets.midcast.Cure = {
    main="Daybreak",
    sub="Genmei Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Annoint. Kalasiris",
    hands="Inyan. Dastanas +2",
    legs="Inyanga Shalwar +2",
    feet="Inyan. Crackows +2",
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Moonlight Ring",
    right_ring="Defending Ring",
    back="Moonlight Cape",
    back="Solemnity Cape"}
    
    sets.midcast.Curaga = sets.midcast.Cure
    
    sets.midcast.StatusRemoval = {
    head="Nahtirah Hat",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','Song spellcasting time -4%',}},
    legs="Aya. Cosciales +2",
    feet={ name="Chironic Slippers", augments={'"Resist Silence"+10','Magic dmg. taken -2%','"Refresh"+1','Accuracy+6 Attack+6','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    neck="Orunmila's Torque",
    waist="Channeler's Stone",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Shadow Ring",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}
    
    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Inyanga Jubbah +2",
    hands="Inyan. Dastanas +2",
    legs="Aya. Cosciales +2",
    feet="Gende. Galosh. +1",
    neck="Debilis Medallion",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Meili Earring",
    left_ring="Haoma's Ring",
    right_ring="Haoma's Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}})
    
    sets.midcast['Enhancing Magic'] = {
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+17','"Conserve MP"+5','Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Witful Belt",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Breath dmg. taken -3%','Phys. dmg. taken -5%','Magic dmg. taken -4%',}},
    back="Perimede Cape"}

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Inyanga Tiara +2"})
    sets.midcast.Haste = sets.midcast['Enhancing Magic']
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash", back="Grapevine Cape"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget", waist="Siegel Sash", legs="Shedir Seraweels"})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {waist="Emphatikos Rope"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
    main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Brioso Roundlet +3",
    body="Bihu Jstcorps. +3",
    hands="Brioso Cuffs +3",
    legs="Brioso Cannions +3",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}}

    
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
    range="Marsyas",
    head="Bunzi's hat",
    body="Bunzi's robe",
    hands={ name="Chironic Gloves", augments={'Pet: STR+7','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3',}},
    legs="Bunzi's Pants",
    feet="Bunzi's sabots",
    neck="Bard's Charm +2",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Infused Earring",
    left_ring="Shneddick Ring",
    right_ring="Moonlight Ring",
    back="Moonlight Cape"}

    sets.idle.DT = {
    range="Marsyas",
    head="Nyame helm",
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Loricate torque +1",
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Genmei Earring",
    left_ring="Shneddick Ring",
    right_ring="Moonlight Ring",
    back="Moonlight Cape"}

    sets.idle.MEva = {
    main="Daybreak",
    sub="Genmei Shield",
    range="Marsyas",
    head="Bunzi's Hat",
    body="Bunzi's Robe",
    hands="Bunzi's Gloves",
    legs="Bunzi's Pants",
    feet="Bunzi's Sabots",
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist="Luminary Sash",
    left_ear="Sanare Earring",
    right_ear="Regal Earring",
    left_ring="Shneddick Ring",
    right_ring="Lunette Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}}}

    sets.idle.Town = set_combine(sets.idle, {
    main="Daybreak",
    sub="Genmei Shield",
    range="Marsyas",
    head="Bunzi's Hat",
    body="Bunzi's Robe",
    hands="Bunzi's Gloves",
    legs="Bunzi's Pants",
    feet="Bunzi's Sabots",
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist="Luminary Sash",
    left_ear="Sanare Earring",
    right_ear="Regal Earring",
    left_ring="Shneddick Ring",
    right_ring="Lunette Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}}})
    
    sets.idle.Weak = sets.idle.DT
    
    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Fili Cothurnes +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    sets.engaged = {main="Naegling",
	sub="Fusetto +2",
	range={ name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}},
    head="Volte tiara",
    body="Ashera Harness",
    hands="Bunzi's gloves",
    legs="Volte tights",
    feet="Nyame sollerets",
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}

    sets.engaged.Acc = set_combine(sets.engaged, {main={ name="Carnwenhan", augments={'Path: A',}},
    sub={ name="Fusetto +2", augments={'TP Bonus +1000',}},
    range={ name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}},
    head="Volte Tiara",
    body="Ashera Harness",
    hands="Bunzi's Gloves",
    legs="Volte Tights",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Crep. Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}})
	
	sets.engaged.Club = set_combine(sets.engaged, {main="Daybreak",
    sub={ name="Fusetto +2", augments={'TP Bonus +1000',}},
    range={ name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}},
    head="Volte Tiara",
    body="Ashera Harness",
    hands="Bunzi's Gloves",
    legs="Volte Tights",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Bard's Charm +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Crep. Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}})

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
	main="Carnwenhan",
	sub="Fusetto +2",
	range={ name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}},
    head="Volte tiara",
    body="Ashera Harness",
    hands="Bunzi's gloves",
    legs="Volte tights",
    feet="Nyame sollerets",
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
	main="Carnwenhan",
	sub="Blurred knife +1",
    range={ name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}},
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet={ name="Bihu Slippers +3", augments={'Enhances "Nightingale" effect',}},
    neck="Combatant's Torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},})

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = sets.engaged.DW
    sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc

    -- 45% Magic Haste (36% DW to cap)
	sets.engaged.DW.MaxHaste = {
    ammo="Ginsen",
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Combatant's Torque",
    waist="Reiki Yotai",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonbeam Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}

    sets.engaged.DW.MaxHaste.Acc = set_combine(sets.engaged.DW, {
    ammo="Ginsen",
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Combatant's Torque",
    waist="Reiki Yotai",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonbeam Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}})

    sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {ear1="Cessance Earring", back=gear.BRD_DW_Cape})
    sets.engaged.DW.Acc.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHaste, {ear1="Cessance Earring", back=gear.BRD_DW_Cape})

    sets.engaged.Aftermath = {
    range={ name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}},
    head="Volte tiara",
    body="Ashera Harness",
    hands="Bunzi's gloves",
    legs="Volte tights",
    feet="Nyame sollerets",
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
    main="Naegling",
	sub="Fusetto +2",
	range={ name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}},
    head="Nyame helm",
    body="Ashera Harness",
    hands="Bunzi's gloves",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Bard's Charm +2",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Defending Ring",
    right_ring="Moonlight Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.SongDWDuration = {main="Carnwenhan", sub="Kali"}

    sets.buff.Doom = {
	ring1={name="Ephedra Ring"},
    ring2={name="Ephedra Ring"},
    waist="Gishdubar Sash"}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then  
     --  if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and 
     --       not state.Buff['Pianissimo'] then
     --       
     --       local spell_recasts = windower.ffxi.get_spell_recasts()
     --       if spell_recasts[spell.recast_id] < 2 then
     --           send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
     --           eventArgs.cancel = true
     --           return
     --       end
     --   end]]
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Horn' then
                equip({range="Gjallarhorn"})
            else
                equip({range="Daurdabla"})
            end
        end
    end
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
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Horn' then
                equip({range="Gjallarhorn"})
            else
                equip({range="Daurdabla"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.CombatForm.current == 'DW' then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
end

function job_buff_change(buff,gain)

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end

    gearinfo(cmdParams, eventArgs)
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
		if state.CastingMode.value == 'Enmity' then  --Added all Enmity lines 5/26/22
            return 'SongEnfeebleEnmity'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
    else
        return 'SongEnhancing'
    end
end

function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false
 
    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1
    
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then 
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then 
        base = 30
    end

    totalDuration = math.floor(mult * base)
        
    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then 
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then 
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade. 
        end
    end
    
    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 12 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 12 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

windower.register_event('zone change', 
    function()
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            send_command('gi ugs true')
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 9)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset 182 ' .. lockstyleset)
end