	--=====================Bedavere_SMN.lua=============================
		--AutoBP + AutoLocK BP Sets During Astral Conduit and Apogee in this Lua
		--You can Toggle off the AutoBP if you like.
	
--few Custtom binds here, can be edited or deleted [ Lines 563-572 ]
    --TogglePetMB   [ F9 = gs c toggle mb ]                             --Toggles Pet MB Set for BPs
    --ToggleAutoBP  [ F10 = gs c toggle auto ]                          --Toggles AutoBP ON/OFF
    --Lock Nirvana  [ F12 = /gs c toggle melee ]                        --Locks Weapon so you dont lose TP
    --SpecialBUFF   [ pagedown = pagedown gs c pact buffSpecial ]       --SpecialBUFF
    --Call ramuh    [ end = input /ma "Ramuh" <me>')                    --Calls Ramuh
    --Pet Idle Set  [ pageup gs c avatar mode ]                         --Toggles Pet Idle Sets
    --Volt Strike   [ ALT + Numpad0 = input /pet "Volt Strike" <t> ]    --Volt Strike
    --Thunderspark  [ ALT + Numpad1 = input /pet "Thunderspark" <t> ]   --Thunderspark 
    --Shock Squall  [ ALT + Numpad2 = input /pet "Shock Squall" <t> ]   --ShockSquall ( Stun Aoe )



-- Blood Pacts Groupings:	
--[[
     Put: /console gs c pact [PactType] as your macro
	 
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
			bp99
            astralflow
--]]



-- Setup your Gear Sets below:
function get_sets()
   
    Elemental_Staff = 'ON' -- Set Default Precast Elemental Staves ON or OFF Here --
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        -- leave this empty
    sets.avatar = {}    -- leave this empty
    -- Your idle set when you DON'T have an avatar out
		sets.me.idle = {
		main="Nirvana",
		sub="Elan Strap +1",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		body="Shomonjijoe +1",
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Baayami sabots +1",
		neck="Loricate torque +1",
		waist="Fucho-no-obi",
		left_ear="Etiolation Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Moonlight Cape",}
		
	sets['Avatar\'s Favor'] = {head="Beckoner's horn +1"}
    sets.avatar.perp = {
    main="Nirvana",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+23','STR+2','"Refresh"+2',}},
    legs="Assid. Pants +1",
    feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Hypaspist Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
	}
      
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = {}
    
	sets.latent_refresh = {waist="Fucho-no-obi"}
    -----------------------
    -- Perpetuation Related
    -----------------------
      
    -- Avatar's Out --  
    -- This is the base for all perpetuation scenarios, as seen below
    sets.avatar.perp = {
    main="Nirvana",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+23','STR+2','"Refresh"+2',}},
    legs="Assid. Pants +1",
    feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    neck="Loricate Torque +1",
    waist="Isa Belt",
    left_ear="Hypaspist Earring",
    right_ear="Lugalbanda Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
	}
  
    -- The following sets base off of perpetuation, so you can consider them idle sets.
    -- Set the relevant gear, bearing in mind it will overwrite the perpetuation item for that slot!
    sets.avatar["Carbuncle"] = {hands={ name="Helios Gloves", augments={'Pet: Attack+27 Pet: Rng.Atk.+27','Pet: "Dbl. Atk."+5','Pet: Haste+6',}}}
    sets.avatar["Cait Sith"] = {hands="Lamassu Mitts +1"}
    -- When we want our avatar to stay alive
    sets.avatar.tank = set_combine(sets.avatar.perp,{
	back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','Pet: "Regen"+10',}},
	})

      
    -- When we want our avatar to shred
    sets.avatar.melee = set_combine(sets.avatar.perp,{
	-- left_ear="Domesticator's Earring",right_ear="Lugalbanda Earring",
	-- hands={ name="Helios Gloves", augments={'Pet: Attack+27 Pet: Rng.Atk.+27','Pet: "Dbl. Atk."+5','Pet: Haste+6',}},
	-- waist="Incarnation sash",left_ear="Lugalbanda Earring",
	-- back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10',}},
	sub="Duplus Grip",
	ammo="Hasty Pinion +1",
    head="Convoker's Horn +3",
    body="Tali'ah Manteel +2",
    hands="Convo. Bracers +3",
    legs={ name="Telchine Braconi", augments={'"Cure" potency +7%','Enh. Mag. eff. dur. +9',}},
    feet="Convo. Pigaches +3",
    neck="Lissome Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Telos Earring",
    left_ring="Hetairoi Ring",
    right_ring="Petrov Ring",
    back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','"Dbl.Atk."+10',}},
	})
      
    -- When we want our avatar to hit
    sets.avatar.acc = set_combine(sets.avatar.perp,{        
	main="Nirvana",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head="Convoker's horn +3",
    body="Con. Doublet +3",
    hands="Asteria Mitts +1",
    legs="Assid. Pants +1",
    feet="Baayami Sabots +1",
    neck="Smn. Collar +1",
    waist="Isa Belt",
    left_ear="Lugalbanda Earring",
    right_ear="Domesticator's Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10','Damage taken-5%',}},
	})
      
    -- When Avatar's Favor is active
    sets.avatar.favor = set_combine(sets.avatar.perp,{
	head="Beck. Horn +1",
	legs="Beck. Spats +1"})
      
    ----------------------------
    -- Summoning Skill Related
    -- Including all blood pacts
    ----------------------------
      
    -- + Summoning Magic. This is a base set for max skill and blood pacts and we'll overwrite later as and when we need to
    sets.avatar.skill = {
    main="Espiritus",
    sub="Vox Grip",
    ammo="Sancus Sachet +1",
    head="Baayami hat",
    body="Baayami Robe",
    hands="Baayami cuffs",
    legs="Baayami slops",
    feet="Baayami Sabots",
    neck="Incanter's Torque",
    waist="Lucidity Sash",
    left_ear="Smn. Earring",
    right_ear="Andoaa Earring",
    left_ring="Stikini Ring +1",
    right_ring="Evoker's Ring",
    back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+14','Blood Pact Dmg.+1','Blood Pact ab. del. II -1',}},
	}
      
    -------------------------
    -- Individual Blood Pacts
    -------------------------
      
    -- Physical damage
    sets.avatar.atk = set_combine(sets.avatar.skill,{
	-- right_ear="Kyrene's Earring",
    -- feet={ name="Helios Boots", augments={'Pet: Attack+28 Pet: Rng.Atk.+28','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
    -- body="Glyphic Doublet +3",
	main="Nirvana",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Helios Band", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
    body="Con. Doublet +3",
    hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: DEX+3','Pet: Mag. Acc.+8','Pet: "Mag.Atk.Bns."+12',}},
    legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
    feet={ name="Helios Boots", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    left_ear="Lugalbanda Earring",
    right_ear="Gelos Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
	})
   

   sets.avatar.pacc = set_combine(sets.avatar.atk,{	
    main="Nirvana",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Helios Band", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
    body="Con. Doublet +3",
    hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: DEX+3','Pet: Mag. Acc.+8','Pet: "Mag.Atk.Bns."+12',}},
    legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
    feet={ name="Helios Boots", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}},
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    left_ear="Lugalbanda Earring",
    right_ear="Gelos Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
	})
	
      
    -- Magic Attack
    sets.avatar.mab = set_combine(sets.avatar.skill,{
    main={ name="Grioavolr", augments={'Blood Pact Dmg.+10','Pet: INT+13','Pet: Mag. Acc.+19','Pet: "Mag.Atk.Bns."+25','DMG:+5',}},
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    body="Con. Doublet +3",
    hands={ name="Merlinic Dastanas", augments={'Pet: Attack+30 Pet: Rng.Atk.+30','Blood Pact Dmg.+10','Pet: DEX+3','Pet: Mag. Acc.+8','Pet: "Mag.Atk.Bns."+12',}},
    legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    neck="Adad Amulet",
    waist="Regal Belt",
    left_ear="Lugalbanda Earring",
    right_ear="Gelos Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Pet: Magic Damage+10',}},
	})
    
	sets.avatar.mabTP = set_combine(sets.avatar.skill,{
    main="Grioavolr",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    body={ name="Merlinic Jubbah", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+10','Pet: STR+5','Pet: "Mag.Atk.Bns."+14',}},
    hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+9','Pet: Mag. Acc.+5',}},
    legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
    feet={ name="Apogee Pumps +1", augments={'MP+60','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    neck="Smn. Collar +1",
    waist="Regal Belt",
    left_ear="Lugalbanda Earring",
    right_ear="Gelos Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','Pet: "Regen"+10',}},
	})
	
	
	sets.avatar.mb = set_combine(sets.avatar.mab,{hands="Glyphic Bracers +1"})
    -- Hybrid
    sets.avatar.hybrid = set_combine(sets.avatar.skill,{
    main="Nirvana",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    body="Con. Doublet +3",
    hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+9','Pet: Mag. Acc.+5',}},
    legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
    feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    neck="Smn. Collar +1",
    waist="Regal Belt",
    left_ear="Lugalbanda Earring",
    right_ear="Gelos Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','Pet: "Regen"+10',}},
	})
      
    -- Magic Accuracy
    sets.avatar.macc = set_combine(sets.avatar.skill,{
    main="Grioavolr",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    body={ name="Merlinic Jubbah", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+10','Pet: STR+5','Pet: "Mag.Atk.Bns."+14',}},
    hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+9','Pet: Mag. Acc.+5',}},
    legs={ name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    neck="Smn. Collar +1",
    waist="Regal Belt",
    left_ear="Lugalbanda Earring",
    right_ear="Gelos Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','Pet: "Regen"+10',}},
	})
      
    -- Buffs
    sets.avatar.buff = set_combine(sets.avatar.skill,{    
    ammo="Sancus Sachet +1",
    head="Baayami hat",
    body="Baayami Robe",
    hands="Baayami cuffs",
    legs="Baayami slops",
    feet="Baayami Sabots +1",
    neck="Incanter's Torque",
    waist="Lucidity Sash",
    right_ear="Andoaa Earring",
    left_ring="Stikini Ring +1",
    right_ring="Evoker's Ring",
    back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+14','Blood Pact Dmg.+1','Blood Pact ab. del. II -1',}},
    })
      
    -- Other
    sets.avatar.other = set_combine(sets.avatar.skill,{
    main="Nirvana",
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    body="Con. Doublet +3",
    hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+9','Pet: Mag. Acc.+5',}},
    legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
    feet={ name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}},
    neck="Smn. Collar +1",
    waist="Regal Belt",
    left_ear="Lugalbanda Earring",
    right_ear="Gelos Earring",
    left_ring="Varar Ring +1",
    right_ring="Varar Ring +1",
    back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','Pet: "Regen"+10',}},
	})
      
    -- Combat Related Sets
      
    -- Melee
    -- The melee set combines with perpetuation, because we don't want to be losing all our MP whilst we swing our Staff
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
    sets.me.melee = set_combine(sets.avatar.perp,{sub="Duplus Grip",
    ammo="Hasty Pinion +1",
    head="Convoker's Horn +3",
    body="Tali'ah Manteel +2",
    hands="Convo. Bracers +3",
    legs={ name="Telchine Braconi", augments={'"Cure" potency +7%','Enh. Mag. eff. dur. +9',}},
    feet="Convo. Pigaches +3",
    neck="Lissome Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Mache Earring +1",
    right_ear="Telos Earring",
    left_ring="Hetairoi Ring",
    right_ring="Petrov Ring",
    back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','"Dbl.Atk."+10',}},
    })
      
    -- Shattersoul. Weapon Skills do not work off perpetuation as it only stays equipped for a moment
    sets.me["Shattersoul"] = {
        head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Mag. crit. hit dmg. +10%','INT+8','Mag. Acc.+12','"Mag.Atk.Bns."+13',}},
        body={ name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+9','Mag. Acc.+14','"Mag.Atk.Bns."+7',}},
        hands="Amalric gages",
        legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +4','INT+10','Mag. Acc.+2','"Mag.Atk.Bns."+15',}},
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','"Drain" and "Aspir" potency +7','INT+15','Mag. Acc.+4','"Mag.Atk.Bns."+14',}},
        neck="Saevus Pendant +1",
        waist="Refoccilation Stone",
        left_ear="Barkaro. Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Shiva Ring +1",
    }
    sets.me["Garland of Bliss"] = {
		head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+6','Mag. Acc.+9',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Mizu. Kubikazari",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring="Shneddick Ring",
		right_ring="Shiva Ring +1",
		back="Twilight Cape",
		}
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ---------------
    -- Casting Sets
    ---------------
      
    sets.precast = {}
    sets.midcast = {}
    sets.aftercast = {}
      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+5','CHR+3',}},
		body="Baayami robe",neck="Voltsurge Torque",hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+2','"Fast Cast"+5',}},left_ring="Kishar ring",
		right_ring="Weather. Ring",back="Swith cape +1",waist="Witful Belt",legs="Lengo Pants",
		left_ear="Enchanter earring +1",right_ear="Loquacious Earring",ammo="Impatiens",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+1','"Fast Cast"+6','INT+10',}},
    }
-- Elemental Staves --
		
    -- Summoning Magic Cast time - gear
    sets.precast.summoning = set_combine(sets.precast.casting,{head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+5','CHR+3',}},
		body="Baayami robe",neck="Voltsurge Torque",hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+2','"Fast Cast"+5',}},left_ring="Kishar ring",
		right_ring="Weather. Ring",back="Moonlight Cape",waist="Witful Belt",legs="Lengo Pants",
		left_ear="Etiolation Earring",right_ear="Loquacious Earring",ammo="Impatiens",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+1','"Fast Cast"+6','INT+10',}},}
    )
	
	sets.precast.trust = set_combine(sets.precast.casting,{head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+5','CHR+3',}},
		body="Baayami robe",neck="Voltsurge Torque",hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+2','"Fast Cast"+5',}},left_ring="Kishar ring",
		right_ring="Weather. Ring",back="Swith cape +1",waist="Witful Belt",legs="Lengo Pants",
		left_ear="Etiolation Earring",right_ear="Loquacious Earring",ammo="Impatiens",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+1','"Fast Cast"+6','INT+10',}},}
    )
      
    -- Enhancing Magic, eg. Siegel Sash, etc	
    sets.precast.enhancing = set_combine(sets.precast.casting,{	
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
		waist="Siegel Sash",
		head="Umuthi Hat",
		legs="Portent pants",
		left_ear="Earthcry Earring",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+5','CHR+3',}},
		body="Baayami robe",neck="Voltsurge Torque",hands={ name="Merlinic Dastanas", augments={'"Mag.Atk.Bns."+2','"Fast Cast"+5',}},left_ring="Kishar ring",
		right_ring="Weather. Ring",back="Swith cape +1",waist="Witful Belt",legs="Lengo Pants",
		left_ear="Enchanter earring +1",right_ear="Loquacious Earring",ammo="Impatiens",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+1','"Fast Cast"+6','INT+10',}},
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------
      
    -- Blood Pact Ability Delay
    sets.precast.bp = {
    ammo="Sancus Sachet +1",
    head="Beckoner's Horn +1",
    body="Con. Doublet +3",
    hands="Baayami Cuffs",
    feet="Baayami Sabots +1",
    neck="Incanter's Torque",
    waist="Lucidity Sash",
    left_ear="Andoaa Earring",
    left_ring="Stikini Ring +1",
    right_ring="Evoker's Ring",
    back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+14','Blood Pact Dmg.+1','Blood Pact ab. del. II -1',}},
    }
      
    -- Mana Cede
    sets.precast["Mana Cede"] = {
        hands="Beckoner's Bracers +1",
    }
      
    -- Astral Flow  
    sets.precast["Astral Flow"] = {head="Glyphic Horn +1"
    }
      
    ----------
    -- Midcast
    ----------
      
    -- We handle the damage and etc. in Pet Midcast later
      
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
	sets.midcast.summoning = {main="Nirvana",back="Campestres's cape",
	}
	
    sets.midcast.casting = set_combine(sets.precast.casting,{
        ammo="Sancus Sachet +1",
    })
      
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
	    main="Gada",
        sub="Ammurapi shield",	
		head="Amalric coif +1",
		body="Telchine Chasuble",
		hands="Telchine Gloves",
		waist="Siegel Sash",
		legs="Telchine braconi",
		feet="Telchine Pigaches",
    })
	    -- Enfeebling
    sets.midcast.enfeeble = {
	    main="Sucellus",
        sub="Ammurapi shield",
		ammo="Pemphredo Tathlum",
        head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+6','Mag. Acc.+9',}},
        body="Zendik robe",
        hands="Amalric gages +1",
        legs="Amalric slops +1",
        feet="Amalric Nails +1",
        neck="Erra Pendant",
        waist="Luminary Sash",
        left_ear="Gwati Earring",
        right_ear="Digni. Earring",
        left_ring="Stikini Ring +1",
        right_ring="Kishar Ring",
    }

    sets.midcast.dia = set_combine(sets.midcast['Enfeebling Magic'], {
	head={ name="Merlinic Hood", augments={'Magic burst dmg.+8%','MND+2','"Treasure Hunter"+2','Accuracy+2 Attack+2','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
	waist="Chaac belt"
	})	 
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{waist="Siegel Sash",head="Umuthi hat",neck="Nodens gorget",})
    -- Elemental Siphon, eg, Tatsumaki Thingies, Esper Stone, etc
    sets.midcast.siphon = set_combine(sets.avatar.skill,{
        ammo="Sancus sachet +1",
        head="Beckoner's Horn +1",
		left_ring="Zodiac ring",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +5','Pet: Enmity+7','Blood Pact Dmg.+3',}},
    })
        
    -- Cure Potency
    sets.midcast.cure = set_combine(sets.midcast.casting,{
        main="Serenity",sub="Elan strap +1",
		head="Vanya Hood",neck="Voltsurge Torque",ear1="Roundel Earring",ear2="Mendi. Earring",
		body="Nefer kalasiris",hands="Telchine gloves",ring1="Stikini Ring +1",ring2="Kunaji ring",
		back="Moonlight Cape",waist="Gishdubar sash",legs="Lengo pants",feet="Vanya clogs"
    })
      
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have an avatar out?
  
end

-----------------------------------------------------------------------------------------------------------------------------------

	-- Setup your Key Bindings here:  
    windower.send_command('bind f7 gs c toggle mb')
    windower.send_command('bind f10 gs c toggle auto') --Toggles Auto BP
    windower.send_command('bind f12 gs c toggle melee')
    windower.send_command('bind pagedown gs c pact buffSpecial') 
    windower.send_command('bind end input /ma "Ramuh" <me>')
    windower.send_command('bind pageup gs c avatar mode') --Toggles Pet Idle Sets
    send_command('bind ^numpad0 input /pet "Volt Strike" <t>')
    send_command('bind ^numpad1 input /pet "Thunderspark" <t>')
    send_command('bind ^numpad2 input /pet "Shock Squall" <t>')
	send_command('wait 2;input /lockstyleset 2')	
	
	-------------------------------------------------------------------------------------------------------------------------------

	----Add Or Remove Blood Pact to certain Sets here--

	pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}
    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl', ['Shiva']='Crystal Blessing'}
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
    pacts.buffspecial = {['Ifrit']=' <staff_and_grip Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence', ['Ramuh']='Thunderspark'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV', ['Fenrir']='Impact',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Gash'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
	pacts.bp99 = {['Ifrit']='Conflag Strike', ['Ramuh']='Volt Strike', ['Titan']='Crag Throw', ['Diabolos']='Blindside'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

--		
		
bp_physical=S{	'Punch','Rock Throw','Barracuda Dive','Claw','Axe Kick','Shock Strike','Camisado','Regal Scratch','Poison Nails',
				'Moonlit Charge','Crescent Fang','Rock Buster','Tail Whip','Double Punch','Megalith Throw','Double Slap','Eclipse Bite',
				'Mountain Buster','Spinning Dive','Predator Claws','Rush','Chaotic Strike','Crag Throw','Volt Strike'}

bp_hybrid=S{	'Burning Strike','Flaming Crush'}

bp_magical=S{	'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon',
				'Ruinous Omen','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Thunderspark','Somnolence',
				'Meteorite','Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Nether Blast','Meteor Strike',
				'Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Impact','Thunderstorm','Level ? Holy','Holy Mist','Lunar Bay',
				'Night Terror','Conflagration Strike', 'Zantetsuken'}
				
bp_debuff=S{	'Lunar Cry','Mewing Lullaby','Nightmare','Lunar Roar','Slowga','Ultimate Terror','Sleepga','Eerie Eye','Tidal Roar',
				'Diamond Storm','Shock Squall','Pavor Nocturnus'}
				
bp_buff=S{		'Shining Ruby','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Hastega','Noctoshield',
				'Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Soothing Ruby','Heavenward Howl',
				'Soothing Current','Hastega II','Crystal Blessing'}

bp_other=S{		'Healing Ruby','Raise II','Aerial Armor','Reraise II','Whispering Wind','Glittering Ruby','Earthen Ward','Spring Water','Healing Ruby II'} 

AvatarList=S{	'Shiva','Ramuh','Garuda','Leviathan','Diabolos','Titan','Fenrir','Ifrit','Carbuncle','Fire Spirit','Air Spirit','Ice Spirit',
				'Thunder Spirit','Light Spirit','Dark Spirit','Earth Spirit','Water Spirit','Cait Sith','Alexander','Odin','Atomos'}
				
spirit_element={Fire='Fire Spirit',Earth='Earth Spirit',Water='Water Spirit',Wind='Air Spirit',Ice='Ice Spirit',Lightning='Thunder Spirit',
				Light='Light Spirit',Dark='Dark Spirit'}spirit_conflict={Fire='Ice',Earth='Lightning',Water='Fire',Wind='Earth',Ice='Wind',
				Lightning='Water',Light='Dark',Dark='Light'}
				
-------------------------------------------------------------------------------------------------------------------------------------


-- Set Macros for your SMN's macro page, book.
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end
set_macros(1,2) -- Sheet, Book
	

-- Required variables and  their initial value
meleeing = false
autobp = false
favor = false
mBurst = false
macc = false
mode = "perp"
savedMode = "perp"

 
 
 function precast(spell)
 
    -- Don't swap if we're in the middle of something or our pet's doing something
    -- Stops macro spam from interfering with an action GS is already handling
    if midaction() or pet_midaction() then
		return
    end
    if buffactive['Astral Conduit'] then
        return
    end


    -- If we're doing a blood pact, equip our delay set IF Apogee or Astral Conduit are not active
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
     
        equip(sets.precast.bp)
         
    elseif spell.type == 'SummonerPact' then
     
        -- This chunk of code handles Elemental Siphon. It will look at the current day and weather and cancel the spell to summon
        -- the right elemental. Your elemental siphon macro should summon a Dark Spirit to trigger this check
         
        -- These use the included lists in global.lua to determine the right spirit to summon
             
        if spell.name == 'Dark Spirit' then
            if world.weather_element == 'Dark' then
             
                -- Dark Weather is active, lets the spell go ahead and equips summoning precast
                equip(sets.precast.summoning)
                 
            elseif world.weather_element ~= 'None' and spirit_conflict[world.day_element] ~= world.weather_element then
             
                -- It's not dark weather but there is some weather up, cancels dark and summons the right spirit
                cancel_spell()
                send_command('input /ma "%s" <me>':format(spirit_element[world.weather_element]))
                equip(sets.precast.summoning)
                 
            elseif world.day_element == 'Dark' then
             
                -- It's darksday so allow the dark spirit to go ahead and equip summoning
                equip(sets.precast.summoning)
                 
            else
             
                -- There is no weather up and it's not darksday, so summon the current day's spirit
                cancel_spell()              
                send_command('input /ma "%s" <me>':format(spirit_element[world.day_element]))
                equip(sets.precast.summoning)
                 
            end
        else
         
            -- We're not summoning Dark Spirit, so we don't want to Siphon, which means we're summoning an avatar
            equip(sets.precast.summoning)
             
        end
         
    -- Moving on to other types of magic
    elseif spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.name == AvatarList:contains(spell.name) then
     
        -- Stoneskin Precast
        if spell.name == 'Stoneskin' then
         
            windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            equip(sets.precast.stoneskin)
             
        -- Cure Precast
        elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            equip(sets.precast.cure)
             
        -- Enhancing Magic
        elseif spell.skill == 'Magic' or spell.skill == 'Trust' then
         
            equip(sets.precast.enhancing)
             
            if spell.name == 'Sneak' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
            end
        else
         
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)
             
        end
         
    -- Summoner Abilities
    -- We use a catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
     
    elseif sets.precast[spell.name] then
        equip(sets.precast[spell.name])
    end
     
end
 
function midcast(spell)
      
    -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' then
        if spell.name == 'Stoneskin' then
            equip(sets.midcast.stoneskin)
        elseif spell.name:match('Cure') or spell.name:match('Cura') or spell.name:match('Regen')then
            equip(sets.midcast.cure)
		elseif spell.name:match('Blind') or spell.name:match('Dispel') or spell.name:match('Silence') or spell.name:match('Paralyze') or spell.name:match('Slow') then
			equip(sets.midcast.enfeeble)
        elseif spell.skill == 'Enhancing Magic' then
            equip(sets.midcast.enhancing)
            if spell.name:match('Protect') or spell.name:match('Shell') then
                equip({rring="Sheltered Ring"})
            end
        else
            equip(sets.midcast.casting)
        end
    elseif spell.name == 'Elemental Siphon' then
     
        -- Siphon Set
        equip(sets.midcast.siphon)
         
        -- Checks if pet matches weather
        --if pet.element == world.weather_element then
        --    equip(sets.midcast.siphon,{main="Chatoyant Staff"--[[Take advantage of the weather boost]]})
        --end
         
    -- And our catch all, if a set exists for this spell use it
    elseif sets.midcast[spell.name] then
        equip(sets.midcast[spell.name])
         
    -- Remember those WS Sets we defined? :)
    elseif sets.me[spell.name] then
        equip(sets.me[spell.name])
    end
end
 
function aftercast(spell)
 
    -- If our pet is doing something, prevents us swapping equipment too early
    if midaction() or pet_midaction() then
		return
    end
    if buffactive['Astral Conduit'] then
        return
    end
     
    -- If not a blood pact or summon
    if spell and (not spell.type or not string.find(spell.type,'BloodPact') and not AvatarList:contains(spell.name) or spell.interrupted) then
     
        -- Then initiate idle function to check which set should be equipped
        idle(pet)
         
    end
end

function pet_midcast(spell)
 
    -- Our pet is doing something
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
     
        -- We're going to check the lists in global.lua for matches and equip the relevant sets
         
        if bp_physical:contains(spell.name) then
            if mode == 'acc' then
                equip(sets.avatar.pacc)		
			else
				equip(sets.avatar.atk)
            end
        elseif bp_hybrid:contains(spell.name) then
         
            equip(sets.avatar.hybrid)
            if pet.name == 'Ifrit' then
                
            end
             
        elseif bp_magical:contains(spell.name) then
			if mode == 'acc' then
                equip(sets.avatar.macc)
			elseif mBurst then
                equip(sets.avatar.mb)			
			else
				equip(sets.avatar.mab)
            end
 
        elseif bp_debuff:contains(spell.name) then
         
            equip(sets.avatar.macc)
             
        elseif bp_buff:contains(spell.name) then
         
            equip(sets.avatar.buff)
             
        elseif bp_other:contains(spell.name) then
         
            equip(sets.avatar.other)
             
        elseif spell.name == 'Perfect Defense' then
         
            equip(sets.avatar.skill)
             
        else
         
            equip(sets.avatar.skill)
             
        end
		if pet.name == 'Carbuncle' or pet.name == 'Cait Sith' then
			equip(sets.avatar[pet.name])
		end
    end 
end
 
function pet_aftercast(spell)
     
    -- Pet aftercast is simply a check for whether Conduit and Apogee are up, and then a call to our aftercast function
    -- We have a variable called autobp that we set to true or false with commands to auto repeat BPs for us
    if (buffactive['Apogee'] or buffactive['Astral Conduit']) and autobp then
        send_command('input /pet "%s" <t>':format(spell.name))
        return
    end
    
    idle(pet)
    -- Add to Chat rules for buffs with variable values.
	if (spell.english=="Ecliptic Howl") then
		if (world.moon_pct>89) then
				add_to_chat(104,"[Ecliptic Howl] Accuracy 25 - Evasion 1")
		elseif (world.moon_pct>74) then
				add_to_chat(104,"[Ecliptic Howl] Accuracy 21 - Evasion 5")
		elseif (world.moon_pct>59) then
				add_to_chat(104,"[Ecliptic Howl] Accuracy 17 - Evasion 9")
		elseif (world.moon_pct>39) then
				add_to_chat(104,"[Ecliptic Howl] Accuracy 13 - Evasion 13")
		elseif (world.moon_pct>24) then
				add_to_chat(104,"[Ecliptic Howl] Accuracy 9 - Evasion 17")
		elseif (world.moon_pct>9) then
				add_to_chat(104,"[Ecliptic Howl] Accuracy 5 - Evasion 21")
		else
				add_to_chat(104,"[Ecliptic Howl] Accuracy 1 - Evasion 25")
		end
	elseif (spell.english=="Ecliptic Growl") then
		if (world.moon_pct>89) then
				add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 7 - INT/MND/CHR/AGI 1")
		elseif (world.moon_pct>74) then
				add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 6 - INT/MND/CHR/AGI 2")
		elseif (world.moon_pct>59) then
				add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 5 - INT/MND/CHR/AGI 3")
		elseif (world.moon_pct>39) then
				add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 4 - INT/MND/CHR/AGI 4")
		elseif (world.moon_pct>24) then
				add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 3 - INT/MND/CHR/AGI 5")
		elseif (world.moon_pct>9) then
				add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 2 - INT/MND/CHR/AGI 6")
		else
				add_to_chat(104,"[Ecliptic Growl] STR/DEX/VIT 1 - INT/MND/CHR/AGI 7")
		end
	elseif (spell.english=="Lunar Cry") then
		if (world.moon_pct>89) then
				add_to_chat(104,"[Lunar Cry] Enemy Acc Down 31 - Enemy Eva Down 1")
		elseif (world.moon_pct>74) then
				add_to_chat(104,"[Lunar Cry] Enemy Acc Down 26 - Enemy Eva Down 6")
		elseif (world.moon_pct>59) then
				add_to_chat(104,"[Lunar Cry] Enemy Acc Down 21 - Enemy Eva Down 11")
		elseif (world.moon_pct>39) then
				add_to_chat(104,"[Lunar Cry] Enemy Acc Down 16 - Enemy Eva Down 16")
		elseif (world.moon_pct>24) then
				add_to_chat(104,"[Lunar Cry] Enemy Acc Down 11 - Enemy Eva Down 21")
		elseif (world.moon_pct>9) then
				add_to_chat(104,"[Lunar Cry] Enemy Acc Down 6 - Enemy Eva Down 26")
		else
				add_to_chat(104,"[Lunar Cry] Enemy Acc Down 1 - Enemy Eva Down 31")
		end
	elseif (spell.english=="Heavenward Howl") then
		if (world.moon_pct>89) then
				add_to_chat(104,"[Heavenward Howl] Moon Phase Full moon - Endrain 15%")
		elseif (world.moon_pct>73) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 74~90% {Endrain 12%")
		elseif (world.moon_pct>56) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 57~73% {Endrain 8%}")
		elseif (world.moon_pct>39) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 40~56% {First Quarter Moon - Endrain 5% | Last Quarter - moon Enaspir 1%}" )
		elseif (world.moon_pct>24) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 25~39% {Enaspir 2%}")
		elseif (world.moon_pct>9) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 10~24% {Enaspir 4%}")
		else
				add_to_chat(104,"[Heavenward Howl] Moon Phase New Moon - Enaspir 5%")
		end     
	elseif (spell.english=="Dream Shroud") then
		if (world.time >= 0 and world.time < 1*60) then
				add_to_chat(104,"[Dream Shroud] MAB 13 - MDB 1")
		elseif (world.time >= 1*60 and world.time < 2*60) or (world.time >= 23*60 and world.time <= 23*60+59) then
				add_to_chat(104,"[Dream Shroud] MAB 12 - MDB 2")
		elseif (world.time >= 2*60 and world.time < 3*60) or (world.time >= 22*60 and world.time < 23*60) then
				add_to_chat(104,"[Dream Shroud] MAB 11 - MDB 3")
		elseif (world.time >= 3*60 and world.time < 4*60) or (world.time >= 21*60 and world.time < 22*60) then
				add_to_chat(104,"[Dream Shroud] MAB 10 - MDB 4")
		elseif (world.time >= 4*60 and world.time < 5*60) or (world.time >= 20*60 and world.time < 21*60) then
				add_to_chat(104,"[Dream Shroud] MAB 9 - MDB 5")
		elseif (world.time >= 5*60 and world.time < 6*60) or (world.time >= 19*60 and world.time < 20*60) then
				add_to_chat(104,"[Dream Shroud] MAB 8 - MDB 6")
		elseif (world.time >= 6*60 and world.time < 7*60) or (world.time >= 18*60 and world.time < 19*60) then
				add_to_chat(104,"[Dream Shroud] MAB 7 - MDB 7")
		elseif (world.time >= 7*60 and world.time < 8*60) or (world.time >= 17*60 and world.time < 18*60) then
				add_to_chat(104,"[Dream Shroud] MAB 6 - MDB 8")
		elseif (world.time >= 8*60 and world.time < 9*60) or (world.time >= 16*60 and world.time < 17*60) then
				add_to_chat(104,"[Dream Shroud] MAB 5 - MDB 9")
		elseif (world.time >= 9*60 and world.time < 10*60) or (world.time >= 15*60 and world.time < 16*60) then
				add_to_chat(104,"[Dream Shroud] MAB 4 - MDB 10")
		elseif (world.time >= 10*60 and world.time < 11*60) or (world.time >= 14*60 and world.time < 15*60) then
				add_to_chat(104,"[Dream Shroud] MAB 3 - MDB 11")
		elseif (world.time >= 11*60 and world.time < 12*60) or (world.time >= 13*60 and world.time < 14*60) then
				add_to_chat(104,"[Dream Shroud] MAB 2 - MDB 12")
		else
				add_to_chat(104,"[Dream Shroud] MAB 1 - MDB 13")
		end
	end 
end
 
function idle(pet)
 
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
     
    if favor and pet.isvalid then   
        -- Avatar's favor takes priority!
        equip(sets.avatar.favor)       
    elseif meleeing and player.status=='Engaged' then   
        -- We're both engaged and meleeing
        equip(sets.me.melee)        
    elseif pet.isvalid then        
        -- We have a pet out but we're not meleeing, set the right idle set
        equip(sets.avatar[mode])
    elseif pet.name == 'Alexander' then       
        -- We have a pet out but we're not meleeing, set the right idle set
        equip(sets.avatar.skill)	
    else
        -- We're not meleeing and we have no pet out
        equip(sets.me.idle)     
    end
	-- If we have cait or carbie  we switch to hands.
	if pet.name == 'Carbuncle' or pet.name == 'Cait Sith' then
			equip(sets.avatar[pet.name])
	end
end
 
function status_change(new,old)
    if new == 'Engaged' then
     
        -- If we engage check our meleeing status
        idle(pet)
         
    elseif new=='Resting' then
     
        -- We're resting
        equip(sets.me.resting)
	else
		idle(pet)
    end
end
 
function pet_change(pet,gain)
 
    -- When we summon or release an avatar
    idle(pet)
	windower.add_to_chat(8,'----- Avatar set to '..mode..' mode! -----')
end
 
 
function self_command(command)
 
    local commandArgs = command
     
    -- This command takes //gs c avatar mode, where mode is what you want, eg, tank, acc, melee, etc
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
		if commandArgs[1] == 'avatar' and pet.isvalid then
			if commandArgs[2] then
				mode = tostring(commandArgs[2])
				if mode == 'mode' then
					if savedMode == 'perp' then
					   mode = 'tank'
					   savedMode = 'tank'
					elseif savedMode == 'tank' then
					   mode = 'melee'
					   savedMode = 'melee'
					elseif savedMode == 'melee' then
					   mode = 'acc'
					   savedMode = 'acc'
					elseif savedMode == 'acc' then
					   mode = 'perp'
					   savedMode = 'perp'
					end
				end    
				equip(sets.avatar[mode])
				windower.add_to_chat(8,'----- Avatar set to '..mode..' mode! -----')
			end
		elseif commandArgs[1] == 'toggle' then
            if commandArgs[2] == 'auto' then
             
                -- //gs c toggle auto will toggle auto blood pacts on and off. Auto blood pact will make your GS repeat BPs under Apogee or Conduit
                -- And by repeat I mean repeat. If Conduit is up, it will SPAM the BP until Conduit is down
                if autobp then
                    autobp = false
                    windower.add_to_chat(8,'----- Auto BP mode Disabled -----')
                else
                    autobp = true
                    windower.add_to_chat(8,'----- Auto BP mode Enabled -----')
                end
            elseif commandArgs[2] == 'melee' then
             
                -- //gs c toggle melee will toggle melee mode on and off.
                -- This basically locks the slots that will cause you to lose TP if changing them,
                -- As well as equip your melee set if you're engaged
 
                if meleeing then
                    meleeing = false
                    enable('main','sub','ranged')
                    windower.add_to_chat(8,'----- Weapons Unlocked, WILL LOSE TP -----')
                    idle(pet)
                else
                    meleeing=true
                    disable('main','sub','ranged')
                    windower.add_to_chat(8,'----- Weapons Locked, WILL NOT LOSE TP -----')
                    idle(pet)
                end
                 
            elseif commandArgs[2] == 'favor' then
                     
                -- //gs c toggle favor will toggle Favor mode on and off.
                -- It won't automatically toggle, as some people like having favor active without the gear swaps for maximum effectiveness
                -- You need to toggle prioritisation yourself
                if favor then
                    favor = false
                    windower.add_to_chat(8,"----- Avatar's Favor Mode OFF -----")
                else
                    favor = true
                    windower.add_to_chat(8,"----- Avatar's Favor Mode ON -----")
                end
            elseif commandArgs[2] == 'mb' then
                     
                -- //gs c toggle mb will toggle mb mode on and off.
                -- You need to toggle prioritisation yourself
                if mBurst then
                    mBurst = false
                    windower.add_to_chat(8,"----- Avatar's MB Mode OFF -----")
                else
                    mBurst = true
                    windower.add_to_chat(8,"----- Avatar's MB Mode ON -----")
                end
            end
		-- Handles executing blood pacts in a generic, avatar-agnostic way.
		-- //gs c pact [pacttype]
		elseif commandArgs[1]:lower() == 'pact' then
			if not pet.isvalid then
					windower.add_to_chat(122,'No avatar currently available. Returning to default macro set.')
					set_macros(1,2)
				return
			end
		 
			if not commandArgs[2] then
				windower.add_to_chat(123,'No pact type given.')
				return
			end
		 
			local pact = commandArgs[2]:lower()
		 
			if not pacts[pact] then
				windower.add_to_chat(123,'Unknown pact type: '..tostring(pact))
				return
			end
		 
			if pacts[pact][pet.name] then
				if pact == 'astralflow' and not buffactive['astral flow'] then
					windower.add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
					return
				end
		 
				-- Leave out target; let Shortcuts auto-determine it.
				send_command('@input /pet "'..pacts[pact][pet.name]..'"')
			else
				windower.add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
			end
        end
    end
end
