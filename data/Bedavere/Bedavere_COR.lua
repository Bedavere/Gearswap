-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+X ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+NumLock ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--
--  Weapons:    [ WIN+E ]          Cycles between available ranged weapons --gs c cycle gun
--              [ WIN+W ]          Toggle Ranged Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Leaden Salute
--              [ CTRL+Numpad6 ]    Wildfire
--              [ CTRL+Numpad1 ]    Evisceration
--              [ CTRL+Numpad3 ]    Exenterator
--
--  RA:         [ ALT+Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

require("no_interruptions")

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

	send_command('alias hw input /item "Holy Water" <me>' )
	send_command('alias re input /item "Remedy" <me>' )
	send_command('alias ed input /item "Echo Drops" <me>' )
	send_command('alias pa input /item "Panacea" <me>' )

    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.DualWield = M(false, 'Dual Wield III')
    state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Magic Enhance', 'Magic Attack'}
    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'DT', 'Acc', 'FullDT') --F9
    state.HybridMode:options('Normal', 'DT', 'Acc')
    state.RangedMode:options('Normal', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'Refresh')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.AutoWSMode = M(false, 'AutoWSMode')
    state.Gun = M{['description']='Current Gun', 'Death Penalty', 'Fomalhaut', 'Anarchy +2'}
    state.Main = M{['description']='Current Main', 'DP', 'Evis', 'SB', 'Shooting'}
    state.CP = M(false, "Capacity Points Mode")

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"
    options.ammo_warning_limit = 10

    -- Additional local binds

    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind ^c input /ja "Crooked Cards" <me>')
    send_command('bind ^s input /ja "Snake Eye" <me>')
    send_command('bind ^f input /ja "Fold" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command ('bind @` gs c toggle LuzafRing')

    send_command('bind ^- gs c cycleback mainqd')
    send_command('bind ^= gs c cycle mainqd')
    send_command('bind !- gs c cycle altqd')
    send_command('bind != gs c cycleback altqd')
    send_command('bind ^[ gs c toggle selectqdtarget')
    send_command('bind ^] gs c toggle usealtqd')

    send_command('bind @c gs c toggle CP')
    send_command('bind @q gs c cycle QDMode')
    send_command('bind @e gs c cycle Gun')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @d gs c cycle Main')
    send_command('bind @s gs c cycle AutoWSMode')

    send_command('bind ^numlock input /ja "Triple Shot" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind ^numpad/ input /ja "Berserk" <me>')
        send_command('bind ^numpad* input /ja "Warcry" <me>')
        send_command('bind ^numpad- input /ja "Aggressor" <me>')
    end

    send_command('bind ^numpad7 input /ws "Savage Blade" <t>')
    send_command('bind ^numpad8 input /ws "Last Stand" <t>')
    send_command('bind ^numpad4 input /ws "Leaden Salute" <t>')
    send_command('bind ^numpad6 input /ws "Wildfire" <t>')
    send_command('bind ^numpad1 input /ws "Evisceration" <t>')
    send_command('bind ^numpad2 input /ws "Aeolian Edge" <t>')
    send_command('bind ^numpad3 input /ws "Circle Blade" <t>')

    send_command('bind !numpad0 input /ra <t>')

    select_default_macro_book()

end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^c')
    send_command('unbind ^s')
    send_command('unbind ^f')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^,')
    send_command('unbind @c')
    send_command('unbind @q')
    send_command('unbind @e')
    send_command('unbind @w')
    send_command('unbind @d')
    send_command('unbind @s')
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind !numpad0')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

----------------------------------------------------------------    ------------------------- Precast Sets -------------------------

    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}

    sets.precast.CorsairRoll = {ranged="Compensator",
    head="Lanun Tricorne +1",
    neck="Regal Necklace",
    body="Lanun Frac +3",
    hands="Chasseur's Gants +1",
    feet="Lanun Bottes +3",
    waist="Flume Belt +1",
    back="Camulus's Mantle",
	}

    sets.precast.CorsairRoll.Gun = set_combine(sets.precast.CorsairRoll.engaged, {})
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chass. Bottes"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

    sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll, {ring1="Luzaf's Ring"})
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}


    sets.precast.Waltz = {
    body="Passion Jacket",
    neck="Phalaina Locket",
    ring1="Asklepian Ring",
    waist="Gishdubar Sash",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
	head="Carmine Mask +1",
    body="Nyame Mail",
    hands="Leyline Gloves",
    legs="Nyame Flanchard",
    feet="Carmine Greaves +1",
    neck="Orunmila's Torque",
    waist="Sailfi Belt +1",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back="Moonlight Cape",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    head="Carmine Mask +1",
    body="Nyame Mail",
    hands="Leyline Gloves",
    legs="Nyame Flanchard",
    feet="Carmine Greaves +1",
    neck="Orunmila's Torque",
    waist="Sailfi Belt +1",
    left_ear="Enchntr. Earring +1",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Rahab Ring",
    back="Moonlight Cape",
    })

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {
    head="Aurore Beret +1",
    neck="Comm. Charm +2",
    body="Laksa. Frac +3",
    hands="Carmine Fin. Ga. +1",
	legs="Laksa. Trews +3",
    feet="Meg. Jam. +2",
    waist="Impulse Belt",
    back={ name="Camulus's Mantle", augments={'"Snapshot"+10',}},
    } 


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {head="Nyame helm",
    body="Lanun Frac +3",
    hands="Nyame gauntlets",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Comm. Charm +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Regal Ring",
    right_ring="Epaminonda's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    ear2="Telos Earring",
    ring2="Cacoethic Ring",
    })

    sets.precast.WS['Last Stand'] = {head="Nyame helm",
    body="Lanun Frac +3",
    hands="Nyame gaintlets",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Comm. Charm +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Regal Ring",
    right_ring="Epaminonda's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	}

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
    head="Nyame helm",
    body="Laksamana's frac +3",
    hands="Nyame gauntlets",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Comm. Charm +2",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear="Moonshade Earring",
    left_ring="Regal Ring",
    right_ring="Epaminonda's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Wildfire'] = {ammo="Living Bullet",
	head="Nyame helm",
    body="Lanun Frac +3",
    hands="Nyame gauntlets",
    legs="Nyame flanchard",
    feet="Lanun bottes +3",
    neck="Comm. Charm +2",
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear="Crematio Earring",
    left_ring="Dingir Ring",
    right_ring="Epaminonda's Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	}

    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {ammo="Living Bullet",
	head="Pixie Hairpin +1",
    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck="Comm. Charm +2",
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Dingir Ring",
    right_ring="Archon Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	})

    sets.precast.WS['Leaden Salute'].FullTP = {ear1="Crematio Earring", waist="Svelt. Gouriz +1"}  --Function Made for this.

    sets.precast.WS['Evisceration'] = {
    head="Pixie hairpin +1",
    body="Abnoba Kaftan",
    hands="Mummu Wrists +2",
    legs="Meg. Chausses +2",
    feet="Mummu Gamash. +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Mache Earring +1",
    left_ring="Mummu Ring",
    right_ring="Regal Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
    }

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
    head="Meghanada Visor +2",
    ear2="Telos Earring",})

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	head="Lanun Tricorne +3",
    hands="Meg. Gloves +2",
    legs="Mummu Kecks +2",
	})

    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})


    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Laksa. Frac +3",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Comm. Charm +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	})

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
    ear2="Telos Earring",
    waist="Grunfeld Rope",
	})

    sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Laksa. Frac +3",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Comm. Charm +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    })

    sets.precast.WS['Swift Blade'].Acc = set_combine(sets.precast.WS['Swift Blade'], {
    head="Meghanada Visor +2",
    hands="Meg. Gloves +2",
    ear2="Telos Earring",
    })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {})

    sets.precast.WS['Circle Blade'] = {
    head={ name="Nyame Helm", augments={'Path: B',}},
    body="Laksa. Frac +3",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
    neck={ name="Comm. Charm +2", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
    ear1="Halasz Earring",
    hands="Rawhide Gloves",
    legs="Carmine Cuisses +1",
    ring1="Evanescence Ring",
    }

    sets.midcast.Cure = {
    neck="Phalaina Locket",
    ear1="Mendi. Earring",
    ring1="Lebeche Ring",
    }

    sets.midcast.Phalanx = {
    head="Carmine Mask",
    neck="Incanter's Torque",
    ear1="Andoaa Earring",
    body="Taeon Tabard",
    hands="Taeon Gloves",
    ring1="Stikini Ring",
    ring2="Stikini Ring",
    legs={ name="Herculean Trousers", augments={'"Fast Cast"+1','"Counter"+2','Phalanx +4','Accuracy+8 Attack+8','Mag. Acc.+7 "Mag.Atk.Bns."+7',}},
    feet="Taeon Boots",
    }


    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Occult Acumen Set
    sets.midcast['Dark Magic'] = {
    ammo=gear.QDbullet,
    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+2','VIT+10','Mag. Acc.+5','"Mag.Atk.Bns."+14',}},
    body="Mummu Jacket +2",
    hands={ name="Adhemar Wrist. +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','DEX+5','Mag. Acc.+14','"Mag.Atk.Bns."+12',}},
    feet="Carmine Greaves +1",
    neck="Sanctity Necklace",
    ear1="Dedition Earring",
    ear2="Telos Earring",
    ring1="Archon Ring",
    ring2="Dingir Ring",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
    waist="Eschan Stone",
    }

    sets.midcast.CorsairShot = {
    ammo=gear.QDbullet,
    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+2','VIT+10','Mag. Acc.+5','"Mag.Atk.Bns."+14',}},
    body="Lanun Frac +3",
    hands="Carmine Fin. Ga. +1",
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','DEX+5','Mag. Acc.+14','"Mag.Atk.Bns."+12',}},
    feet="Lanun Bottes +3",
    neck="Comm. Charm +2",
    left_ear="Crematio Earring",
    ear2="Friomisi Earring",
    ring1="Fenrir Ring +1",
    ring2="Dingir Ring",
    back="Gunslinger's Cape",
    waist="Eschan Stone",
    }

    sets.midcast.CorsairShot.STP = {
    ammo=gear.QDbullet,
    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+2','VIT+10','Mag. Acc.+5','"Mag.Atk.Bns."+14',}},
    body="Mummu Jacket +2",
    hands="Carmine Fin. Ga. +1",
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}},
    feet="Carmine Greaves +1",
    neck="Iskur Gorget",
    ear1="Dedition Earring",
    ear2="Telos Earring",
    ring1="Petrov Ring",
    ring2="Chirich Ring +1",
    back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
    waist="Yemaya Belt",
    }

    sets.midcast.CorsairShot.Resistant = set_combine(sets.midcast.CorsairShot, {
    head="Lanun Tricorne +3",
    body="Mummu Jacket +2",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamash. +2",
    neck="Sanctity Necklace",
    back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
    waist="Eschan Stone",
    })

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant
    sets.midcast.CorsairShot.Enhance = {feet="Chass. Bottes +1"}

    -- Ranged gear
    sets.midcast.RA = {
    head="Malignance chapeau",
	neck="Iskur Gorget",
	ear2="Telos Earring",
	ear1="Crep. Earring",
	body="Nisroch Jerkin",
	hands="Meg. Gloves +2",
	ring1="Regal Ring",
	ring2="Cacoethic Ring",
	back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	waist="Yemaya Belt",
	legs="Malignance tights",
	feet="Malignance boots",
    }

    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA, {
    ring1="Cacoethic Ring",
    })


    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
    head="Meghanada Visor +2",
    body="Nisroch jerkin",
    hands="Mummu Wrists +2",
    legs="Mummu Kecks +2",
    feet="Oshosi Leggings +1",
    ring1="Begrudging Ring",
    ring2="Mummu Ring",
    })

    sets.TripleShot = {
    head="Oshosi Mask +1",
    body="Cshosi vest +1", 
    hands="Malignance gloves",
    legs="Oshosi Trousers +1", 
    feet="Oshosi Leggings +1", 
    }

    sets.TripleShotCritical = {
    head="Meghanada Visor +2",
    }


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
    head="Nyame helm",
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Loricate torque +1",
    waist="Flume Belt +1",
    ear1="Tuisto Earring",
    ear2="Sanare Earring",
    left_ring="Shneddick Ring",
    right_ring="Defending Ring",
    back="Moonbeam cape",
    }

    sets.idle.Refresh = set_combine(sets.idle, {
    head={ name="Rawhide Mask", augments={'HP+50','Accuracy+15','Evasion+20',}},
    hands={ name="Herculean Gloves", augments={'MND+4','Pet: INT+7','"Refresh"+2','Accuracy+14 Attack+14','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
    legs={ name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -1%','Attack+16','"Refresh"+2','Accuracy+18 Attack+18',}},
    feet={ name="Herculean Boots", augments={'STR+11','Weapon Skill Acc.+3','"Refresh"+2','Accuracy+6 Attack+6','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
    right_ear="Ethereal Earring",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
    head="Adhemar Bonnet +1",
    body="Adhemar Jacket +1",
    hands="Adhemar Wrist. +1",
    legs="Samnuha Tights",
    feet={ name="Herculean Boots", augments={'MND+2','CHR+5','Quadruple Attack +3','Accuracy+2 Attack+2',}},
    neck="Combatant's torque",
    ear1="Cessance Earring",
    ear2="Telos Earring",
    ring1="Petrov Ring",
    ring2="Epona's Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}},
    waist="Reiki Yotai",
    }

   -- sets.engaged.DP = set_combine(sets.engaged, {
   --     main="Rostam",
   --     sub="Lanun Knife", 
   --     })

    sets.engaged.DT = set_combine(sets.engaged, {
    head="Malignance Chapeau",
    body="Adhemar Jacket +1",
    hands="Malignance gloves",
    legs="Malignance tights",
    feet="Malignance boots",
    neck="Combatant's torque",
    ear1="Crep. Earring",
    ear2="Telos Earring",
    ring1="Ilabrat Ring",
    ring2="Petrov Ring",
    back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}},
    waist="Sailfi belt +1",
    })

    sets.engaged.Acc = set_combine(sets.engaged, {
    ring1="Chirich Ring +1",
    legs="Mummu Kecks +2",
    waist="Kentarch Belt +1",
    })
	
	sets.engaged.FullDT = set_combine(sets.engaged, {
    head="Nyame helm",
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Combatant's torque",
    waist="Flume Belt +1",
    ear1="Cessance Earring",
    ear2="Telos Earring",
    ring1="Petrov Ring",
    right_ring="Defending Ring",
    back="Moonbeam cape",
    })

---------------------------------------------------------------

----------------------------------------------------------------

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
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- Gear
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
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

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' then
            equip(sets.precast.CorsairRoll.Gun)
        end
    -- Equip obi if weather/day matches for WS.
    elseif spell.type == 'WeaponSkill' then
        if spell.english == 'Leaden Salute' then
            if world.weather_element == 'Dark' or world.day_element == 'Dark' then
                equip(sets.Obi)
            end
            if player.tp > 2900 then
                equip(sets.precast.WS['Leaden Salute'].FullTP)
            end
        elseif spell.english == 'Wildfire' and (world.weather_element == 'Fire' or world.day_element == 'Fire') then
            equip(sets.Obi)
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip obi if weather/day matches for Quick Draw.
    if spell.type == 'CorsairShot' then
        if (spell.element == world.day_element or spell.element == world.weather_element) and
        (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            equip(sets.Obi)
        end
        if state.QDMode.value == 'Magic Enhance' then
            equip(sets.midcast.CorsairShot.Enhance)
        elseif state.QDMode.value == 'STP' then
            equip(sets.midcast.CorsairShot.STP)
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Armageddon" then
                equip(sets.TripleShotCritical)
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.main == "Armageddon" then
            equip(sets.midcast.RA.Critical)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end


-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('ranged')
    else
        enable('ranged')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Gun.current == 'Death Penalty' then
        equip({ranged="Death Penalty"})
    elseif state.Gun.current == 'Fomalhaut' then
        equip({ranged="Fomalhaut"})
    elseif state.Gun.current == 'Anarchy +2' then
        equip({ranged="Anarchy +2"})
    end

	if state.Main.current == 'DP' then
		equip({main="Lanun Knife", sub="Eletta Knife"})
	elseif state.Main.current == 'Evis' then
		equip({main="Lanun Knife", sub="Blurred Knife +1"})
	elseif state.Main.current == 'SB' then
		equip({main="Hep. Sapara +1", sub="Blurred Knife +1"})
	elseif state.Main.current == 'Shooting' then
		equip({main="Rostam", sub="Nusku Shield"})
	end

    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.Gun.current == 'Death Penalty' then
        equip({ranged="Death Penalty"})
    elseif state.Gun.current == 'Fomalhaut' then
        equip({ranged="Fomalhaut"})
    elseif state.Gun.current == 'Anarchy +2' then
        equip({ranged="Anarchy +2"})
    end

	if state.Main.current == 'DP' then
		equip({main="Lanun Knife", sub="Eletta Knife"})
	elseif state.Main.current == 'Evis' then
		equip({main="Lanun Knife", sub="Blurred Knife +1"})
	elseif state.Main.current == 'SB' then
		equip({main="Hep. Sapara +1", sub="Blurred Knife +1"})
	elseif state.Main.current == 'Shooting' then
		equip({main="Rostam", sub="Nusku Shield"})
	end
	return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''

    msg = msg .. '[ Offense/Ranged: '..state.OffenseMode.current

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end

    msg = msg .. '/' ..state.RangedMode.current .. ' ]'

    if state.WeaponskillMode.value ~= 'Normal' then
        msg = msg .. '[ WS: '..state.WeaponskillMode.current .. ' ]'
    end

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON ]'
    end

    msg = msg .. '[ *'..state.Mainqd.current

    if state.UseAltqd.value == true then
        msg = msg .. '/'..state.Altqd.current
    end

    msg = msg .. ' ('

    if state.QDMode.value then
        msg = msg .. state.QDMode.current .. ') '
    end

    msg = msg .. ']'

    add_to_chat(060, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end

        send_command('@input /ja "'..doqd..'" <t>')
    end

end


function define_roll_values()
    rolls = {
        ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus..' ('..rollsize..') ')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]

    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

windower.register_event('tp change', function(tp)
   if state.AutoWSMode.value == true then
	if player.tp > 1249 and player.status == 'Engaged' then
		send_command('input /ws "Leaden Salute" <t>')
	end
   end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 16)
    elseif player.sub_job == "NIN" then
        set_macro_page(1, 16)
    elseif player.sub_job == "WAR" then
        set_macro_page(1, 16)
    elseif player.sub_job == "RNG" then
        set_macro_page(1, 16)
    elseif player.sub_job == "WHM" then
        set_macro_page(1, 16)
    else
        set_macro_page(1, 16)
    end
end


