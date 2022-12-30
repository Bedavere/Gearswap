----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Acc", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Aptitude Mantle +1" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}
	
	send_command('gs enable all')
	send_command('bind !r input /item "Remedy" <me>')		-- ALT-R for remedies
	send_command('bind !p input /item "Panacea" <me>')		-- ALT-P for panacea
	send_command('bind !h input /item "Holy Water" <me>')  --ALT-H for Holy Water
    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind ^f1 gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP") 
    send_command("bind = gs c clear")
    
    
    
    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 400
    pos_y = 280
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()

	send_command("unbind !r")
	send_command("unbind !p")
	send_command("unbind !h")
	send_command("unbind ^f1")
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
    
    send_command('unbind @=')
    send_command('unbind @n')
end

function job_setup()
    include("PUP_Lib.lua")
	lockstyleset = 09
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    Animators.Range = "Animator P II +1"
    Animators.Melee = "Animator P +1"

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    AF = {}
    AF.Head = "Foire Taj +2"
    AF.Body = "Foire Tobe +3"
    AF.Hands = "Foire Dastanas +3"
    AF.Legs = "Foire Churidars +2"
    AF.Feet = "Foire Babouches +2"

    RELIC = {}
    RELIC.Head = "Pitre Taj +3" --Enhances Optimization
    RELIC.Body = "Pitre Tobe +3" --Enhances Overdrive
    RELIC.Hands = "Pitre Dastanas +3" --Enhances Fine-Tuning
    RELIC.Legs = "Pitre Churidars +3" --Enhances Ventriloquy
    RELIC.Feet = "Pitre Babouches +1" --Role Reversal

    EMPY = {}
    EMPY.Head = "Karagoz Capello +1"
    EMPY.Body = "Karagoz Farsetto +1"
    EMPY.Hands = "Karagoz Guanti +1"
    EMPY.Legs = "Karagoz Pantaloni +1"
    EMPY.Feet = "Karagoz Scarpe +1"

    Cape = {}
    
	Cape.PetMagic = { name="Visucius's Mantle", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+5','Pet: Haste+10',}}
	Cape.PetDT = {name = "Visucius's Mantle", augments = {'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1247 Val: 4'}}
    Cape.TP = {name = "Visucius's Mantle", augments={'STR+15','Accuracy+20 Attack+25','"Dbl.Atk."+10','Damage Taken -5%'}}
	Cape.VIT = { name="Visucius's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Cape.STR = { name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
	Cape.DEX = { name="Visucius's Mantle", augments={'DEX+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Weapon skill damage +10%',}}
    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
		--ammo="Staunch Tathlum +1",
		head="Rao Kabuto +1",
		body="Hiza. Haramaki +2",
		hands="Rao Kote",
		--hands={ name="Rao Kote +1", augments={'MND+12','Mag. Evasion+20','Magic dmg. taken -5',}},
		legs="Rao Haidate",
		feet="Mpaca's Boots",
		neck="Bathy Choker +1",
		waist="Moonbow Belt +1",
		ear1="Infused Earring",
		ear2="Odnowa Earring +1",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		--right_ring="Karieyh Ring +1",
		back="Moonlight Cape",
	
	
	}

    -------------------------------------Fastcast
    sets.precast.FC = {
		--ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Cure" potency +3%','"Fast Cast"+6','Accuracy+13 Attack+13','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
		body={ name="Taeon Tabard", augments={'DEF+16','Spell interruption rate down -9%','Phalanx +3',}},
		hands="Malignance Gloves",
		legs="Heyoka Subligar",
		feet="Regal Pumps +1",
		neck="Baetyl Pendant",
		waist="Klouskap Sash",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
		left_ring="Rahab Ring",
		right_ring="Lebeche Ring",
		back="Fi Follet Cape +1",
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet = EMPY.Feet}

    sets.precast.JA["Ventriloquy"] = {legs = RELIC.Legs}

    sets.precast.JA["Role Reversal"] = {feet = RELIC.Feet}

    sets.precast.JA["Overdrive"] = {body = RELIC.Body}

    sets.precast.JA["Repair"] = {
      ammo = "Automat. Oil +3",
      head="Rao Kabuto +1",
      left_ear="Guignol Earring",
      right_ear="Pratik Earring",
      body=AF.Body,
      hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
      legs="Desultor tassets",
      feet = AF.Feet
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {    
        main = "Kenkonken",
        neck = "Buffoon's Collar",
        body = EMPY.Body,
        hands = AF.Hands,
        back = "Visucius's Mantle",
        ear1 = "Burana Earring"
    }

    sets.precast.JA["Activate"] = {back = "Visucius's Mantle"}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {
	head="White Rarab Cap +1",
    --ammo="Per. Lucky Egg",
    feet={ name="Herculean Boots", augments={'Rng.Acc.+16 Rng.Atk.+16','Attack+22','"Treasure Hunter"+2',}},
    waist="Chaac Belt",
	}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       -- Add your set here 
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
      head=RELIC.Head,
      body="Nyame Mail",
      hands=RELIC.Hands,
      legs="Nyame Flanchard",
      feet="Nyame Sollerets",
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Brutal Earring",
      right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
      left_ring="Gere Ring",
      right_ring="Niqmaddu Ring",
      back=Cape.TP
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {
    })

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {
    })

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
      legs="Samnuha Tights",
      waist="Moonbow Belt +1",
    })

    sets.precast.WS["Shijin Spiral"] = set_combine(sets.precast.WS, {
      body="Tali'ah Manteel +2",
      hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+4','AGI+4','Attack+9',}},
      legs="Samnuha Tights",     
      right_ring="Regal Ring", 
      left_ear="Mache Earring +1",      
    })

    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
      --body="Tali'ah Manteel +2",
      hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+4','AGI+4','Attack+9',}},
      legs="Samnuha Tights",
      waist="Moonbow Belt +1",
      neck={ name="Pup. Collar", augments={'Path: A',}},
    })
	sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS, {
		 head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Shiva Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back=Cape.DEX
	})
	sets.precast.WS["Spinning Attack"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
				
		})
	

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        main={ name="Xiucoatl", augments={'Path: C',}},
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet="Malignance Boots",
        neck="Loricate Torque +1",
        waist="Moonbow Belt +1",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Gelatinous Ring +1",
        right_ring="Defending Ring",
        back=Cape.PetDT
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        ranged="Neo Animator",
		--head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		head="Mpaca's Cap",
        body="Tali'ah Manteel +2",
		--hands="Volte Mittens",
        hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+4','AGI+4','Attack+9',}},
        legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'Rng.Atk.+3','"Triple Atk."+3','DEX+3','Accuracy+12',}},
		--legs={ name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}},
        --feet={ name="Herculean Boots", augments={'"Triple Atk."+3','Rng.Atk.+13','Quadruple Attack +3','Accuracy+13 Attack+13','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
        neck="Shulmanu Collar",
        waist="Moonbow Belt +1",
        left_ear="Mache Earring +1",
        right_ear="Telos Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Gere Ring",
        back=Cape.TP
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = sets.engaged.Master

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = sets.engaged.Master

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = {
        head="Malignance Chapeau", -- 6
        body="Malignance Tabard", -- 9
        hands="Malignance Gloves", -- 5
        legs = "Malignance Tights", -- 7
        feet="Malignance Boots", -- 4
        neck={ name="Pup. Collar", augments={'Path: A',}},
        waist="Moonbow Belt +1", -- 6
        left_ear="Mache Earring +1",
        right_ear="Odnowa Earring +1", -- 3
        left_ring="Niqmaddu Ring",
        right_ring="Gere Ring",
        back=Cape.TP
    }
       
    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
      main={ name="Xiucoatl", augments={'Path: C',}},
      head="Heyoka Cap",
      body="Tali'ah Manteel +2",
      hands={ name="Herculean Gloves", augments={'Accuracy+29','"Triple Atk."+4','AGI+4','Attack+9',}},
      legs="Heyoka Subligar",
      feet={ name="Herculean Boots", augments={'Rng.Atk.+3','"Triple Atk."+3','DEX+3','Accuracy+12',}},
      neck="Shulmanu Collar",
      waist="Moonbow Belt +1",
      left_ear="Crepuscular Earring",
      right_ear="Telos Earring",
      left_ring="Niqmaddu Ring",
      right_ring="Gere Ring",
      back=Cape.PetDT
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = sets.engaged.MasterPet
    
    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = sets.engaged.MasterPet
    
    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = sets.engaged.Master.DT
    
    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = sets.engaged.Master

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
    }

    sets.midcast.Pet.Cure = sets.midcast.Pet
    sets.midcast.Pet["Healing Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Elemental Magic"] = {
      --head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+29','Pet: INT+1','Pet: Attack+8 Pet: Rng.Atk.+8','Pet: "Mag.Atk.Bns."+15',}},
      head="Mpaca's Cap",
	  body="Udug Jacket",
      --hands={ name="Herculean Gloves", augments={'"Fast Cast"+3','Pet: Mag. Acc.+23 Pet: "Mag.Atk.Bns."+23','STR+3 DEX+3','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
      hands="Mpaca's Gloves",	  
	  legs=RELIC.Legs,
      feet=RELIC.Feet,
      neck={ name="Pup. Collar", augments={'Path: A',}},
      waist="Ukko Sash",
      left_ear="Burana Earring",
      right_ear="Enmerkar Earring",
      left_ring="C. Palug Ring",
      right_ring="Tali'ah Ring",
      back=Cape.PetMagic
    }
    sets.midcast.Pet["Enfeebling Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Dark Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Divine Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Enhancing Magic"] = sets.midcast.Pet

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = set_combine(sets.idle.MasterDT,
        {
        }
    )
        
    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = sets.idle.MasterDT

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
      head="Heyoka Cap",
      body="Heyoka harness",
      hands="He. Mittens",
      legs="Heyoka Subligar",
      feet="He. Leggings",
      right_ear="Rimeice Earring",
      left_ear="Domesticator's earring"
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
    main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
    head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Accuracy+3','Pet: Haste+5',}},
    body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
    hands={ name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
    legs={ name="Taeon Tights", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
    feet={ name="Rao Sune-Ate", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}},
    neck="Shulmanu Collar",
    waist="Isa Belt",
    left_ear="Digni. Earring",
    right_ear="Rimeice Earring",
    left_ring="Thurandaut Ring",
    right_ring="Overbearing Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Attack+10','Pet: Haste+10','System: 1 ID: 1247 Val: 4',}},                                                                     --  5
    }

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
        main={ name="Xiucoatl", augments={'Path: C',}},
        head=EMPY.Head,
        body= RELIC.Body,
        hands="Mpaca's Gloves",
        legs="Heyoka Subligar",
        feet="Mpaca's Boots",
        neck="Shulmanu Collar",
        waist="Klouskap sash",
        left_ear="Enmerkar earring",
        right_ear="Rimeice Earring",
        left_ring="Thurandaut Ring",
        right_ring="C. Palug Ring",
        back=Cape.PetDT
    }


    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = {
        main={ name="Xiucoatl", augments={'Path: C',}},
        head=RELIC.Head,
        body= RELIC.Body,
        hands="Mpaca's Gloves",
        legs="Heyoka Subligar",
        feet="Mpaca's Boots",
        neck="Shulmanu Collar",
        waist="Klouskap sash",
        left_ear="Enmerkar Earring",
        right_ear="Rimeice Earring",
        left_ring="Thurandaut Ring",
        right_ring="Varar Ring +1",
        back=Cape.PetDT
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = {
      main={ name="Xiucoatl", augments={'Path: C',}},
      head={ name="Taeon Chapeau", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
	  body={ name="Taeon Tabard", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: "Dbl. Atk."+5','Pet: Damage taken -3%',}},
	  hands="Mpaca's Gloves",
	--hands={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+4','Pet: Damage taken -3%',}},
      legs={ name="Taeon Tights", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      --feet={ name="Taeon Boots", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
	  feet="Mpaca's Boots",
      neck="Shulmanu Collar",
      waist="Klouskap Sash",
      left_ear="Enmerkar Earring",
      right_ear="Rimeice Earring",
      left_ring="Thurandaut Ring",
      right_ring="C. Palug Ring",
      back=Cape.PetDT
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = sets.pet.EmergencyDT

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
      head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+29','Pet: INT+1','Pet: Attack+8 Pet: Rng.Atk.+8','Pet: "Mag.Atk.Bns."+15',}},
      body="Udug Jacket",
      hands={ name="Herculean Gloves", augments={'"Fast Cast"+3','Pet: Mag. Acc.+23 Pet: "Mag.Atk.Bns."+23','STR+3 DEX+3','Accuracy+18 Attack+18','Mag. Acc.+1 "Mag.Atk.Bns."+1',}},
      legs=RELIC.Legs,
      feet=RELIC.Feet,
      neck={ name="Pup. Collar", augments={'Path: A',}},
      waist="Ukko Sash",
      left_ear="Burana Earring",
      right_ear="Enmerkar Earring",
      left_ring="C. Palug Ring",
      right_ring="Tali'ah Ring",
      back=Cape.PetMagic
    }
    
    sets.idle.Pet.Regen = {
    }
    
 
    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged =
        set_combine(
        sets.idle.Pet.Engaged,
        {
            legs=EMPY.Legs
        }
    )

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
        head=RELIC.Head,
        body= RELIC.Body,
        hands="Mpaca's Gloves",   
        legs=EMPY.Legs,
        feet="Mpaca's Boots",
        neck="Shulmanu Collar",
        waist="Incarnation Sash",
        left_ear="Enmerkar earring",
        right_ear="Burana earring",
        left_ring="Thurandaut Ring",
        right_ring="C. Palug Ring",
        back=Cape.PetDT
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = set_combine(sets.midcast.Pet.WSNoFTP, {
        head=EMPY.Head,
        back="Dispersal Mantle",
        waist="Klouskap sash",
    })

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {}

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] = {
      head={ name="Taeon Chapeau", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
	  body={ name="Taeon Tabard", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: "Dbl. Atk."+5','Pet: Damage taken -3%',}},
	  hands="Mpaca's Gloves",
	--hands={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+4','Pet: Damage taken -3%',}},
      legs={ name="Taeon Tights", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
      --feet={ name="Taeon Boots", augments={'Pet: Accuracy+22 Pet: Rng. Acc.+22','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
	  feet="Mpaca's Boots",
      neck="Shulmanu Collar",
      waist="Incarnation Sash",
      left_ear="Burana earring",
      right_ear="Domesticator's earring",
      left_ring="Thurandaut Ring",
      right_ring="C. Palug Ring",
      back=Cape.PetDT
    }

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
        }
    )

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = {
        main={ name="Xiucoatl", augments={'Path: C',}},
        range="Animator P +1",
        ammo="Automat. Oil +3",
        head="Pitre Taj +3",
        body="Udug Jacket",
        hands="Malignance Gloves",
        legs="Heyoka Subligar",
        feet="Hermes' Sandals",
        neck="Shulmanu Collar",
        waist="Moonbow Belt +1",
        left_ear="Mache Earring +1",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Gere Ring",
        back=Cape.TP
    }

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(2, 14)
end
