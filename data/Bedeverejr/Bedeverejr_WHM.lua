require("no_interruptions")

function get_sets()

	send_command('bind f9 gs c toggle TP set')
	send_command('bind f10 gs c toggle Idle set')
	
	function file_unload()
      
 
        send_command('unbind ^f9')
        send_command('unbind ^f10')
		send_command('unbind ^f11')
		send_command('unbind ^f12')
       
        send_command('unbind !f9')
        send_command('unbind !f10')
		send_command('unbind !f11')
        send_command('unbind !f12')
 
        send_command('unbind f9')
        send_command('unbind f10')
        send_command('unbind f11')
        send_command('unbind f12')
 
       
 
	end	

	
	--IDLE SETS--	


	sets.Idle = {}

	
	sets.Idle.index = {'Standard', 'Refresh', 'DT'}
	Idle_ind = 1			
	
	sets.Idle.Standard = {main="Bolelabunga",
    sub="Genbu's Shield",
    ammo="Vanir Battery",
    head={ name="Chironic Hat", augments={'Enmity+1','Mag. Acc.+8 "Mag.Atk.Bns."+8','"Refresh"+2','Accuracy+2 Attack+2',}},
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Assid. Pants +1",
    feet={ name="Chironic Slippers", augments={'Magic dmg. taken -2%','Pet: Attack+16 Pet: Rng.Atk.+16','"Refresh"+1','Accuracy+6 Attack+6',}},
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Solemnity Cape"}

	
	sets.Idle.Refresh = {main="Bolelabunga",
    sub="Genbu's Shield",
    ammo="Vanir Battery",
    head={ name="Chironic Hat", augments={'Enmity+1','Mag. Acc.+8 "Mag.Atk.Bns."+8','"Refresh"+2','Accuracy+2 Attack+2',}},
    body="Inyanga Jubbah +2",
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Refresh"+1',}},
    legs="Assid. Pants +1",
    feet={ name="Chironic Slippers", augments={'Magic dmg. taken -2%','Pet: Attack+16 Pet: Rng.Atk.+16','"Refresh"+1','Accuracy+6 Attack+6',}},
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
	
	
	sets.Idle.DT = {main="Bolelabunga",
    sub="Genbu's Shield",
    ammo="Vanir Battery",
    head={ name="Chironic Hat", augments={'Enmity+1','Mag. Acc.+8 "Mag.Atk.Bns."+8','"Refresh"+2','Accuracy+2 Attack+2',}},
    body="Inyanga Jubbah +2",
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Refresh"+1',}},
    legs="Assid. Pants +1",
    feet={ name="Chironic Slippers", augments={'Magic dmg. taken -2%','Pet: Attack+16 Pet: Rng.Atk.+16','"Refresh"+1','Accuracy+6 Attack+6',}},
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}

	
	--TP SETS--
	
	
	sets.TP = {}

	
	sets.TP.index = {'Standard', 'DT'}
	
	TP_ind = 1
	
	sets.TP.Standard = {main="Queller Rod",
	sub="Genbu's Shield",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Asperity Necklace",
    ear1="Steelflash Earring",
    ear2="Bladeborn Earring",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
    ring1="Rajas Ring",
    ring2="Apate Ring",
    back="Kayapa Cape",
    waist="Witful Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}


	sets.TP.DT = {main="Queller Rod",
	sub="Genbu's Shield",
	ammo="Staunch Tathlum",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
	neck="Loricate Torque +1",
	ear1={ name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}},
	ear2="Ethereal Earring",
	body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
	ring1={ name="Dark Ring", augments={'Phys. dmg. taken -5%','Magic dmg. taken -4%',}},
	ring2="Defending Ring",
	back="Repulse Mantle",
	waist="Witful Belt",
	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}

	
	--WEAPONSKILL SETS--
	
	
	sets.WS = {}
	
	sets.HexaStrike = {}
	
	sets.HexaStrike.index = {'Attack'}
	HexaStrike_ind = 1
	
	sets.HexaStrike.Attack = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Fotia Gorget",
    ear1="Steelflash Earring",
    ear2="Bladeborn Earring",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
    ring1="Rajas Ring",
    ring2="Apate Ring",
    back="Rancorous Mantle",
    waist="Fotia Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}

 
	sets.Judgement = {}
	
	sets.Judgement.index = {'Attack'}
	Judgement_ind = 1
	
	sets.Judgement.Attack = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Fotia Gorget",
    ear1="Steelflash Earring",
    ear2="Bladeborn Earring",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
    ring1="Rajas Ring",
    ring2="Apate Ring",
    back="Kayapa Cape",
    waist="Fotia Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}

	
	sets.Realmrazer = {}
	
	sets.Realmrazer.index = {'Attack'}
	Realmrazer_ind = 1
	
	sets.Realmrazer.Attack = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Fotia Gorget",
    ear1="Steelflash Earring",
    ear2="Bladeborn Earring",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
    ring1="Rajas Ring",
    ring2="Apate Ring",
    back="Kayapa Cape",
    waist="Fotia Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}


	sets.WS.FlashNova = {}
	
	sets.WS.FlashNova = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Mizu. Kubikazari",
    ear1="Friomisi Earring",
    ear2="Hecate's Earring",
    body="Wayfarer Robe",
    hands="Helios Gloves",
    ring1="Strendu Ring",
    ring2="Acumen Ring",
    back="Toro Cape",
    waist="Salire Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet="Helios Boots"}
	
	
	sets.WS.Myrkr = {}
	
	sets.WS.Myrkr = {main="",
	sub="",
	ammo="",
	head="",
	neck="",
	ear1="",
	ear2="",
	body="",
	hands="",
	ring1="",
	ring2="",
	back="",
	waist="",
	legs="",
	feet=""}
	
	
	sets.WS.Shattersoul = {}
	
	sets.WS.Shattersoul = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Mizu. Kubikazari",
    ear1="Friomisi Earring",
    ear2="Hecate's Earring",
    body="Wayfarer Robe",
    hands="Helios Gloves",
    ring1="Strendu Ring",
    ring2="Acumen Ring",
    back="Toro Cape",
    waist="Salire Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet="Helios Boots"}
	
	
	sets.WS.Cataclysm = {}
	
	sets.WS.Cataclysm = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Mizu. Kubikazari",
    ear1="Friomisi Earring",
    ear2="Hecate's Earring",
    body="Wayfarer Robe",
    hands="Helios Gloves",
    ring1="Strendu Ring",
    ring2="Acumen Ring",
    back="Toro Cape",
    waist="Salire Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet="Helios Boots"}
	
	
	sets.WS.Retribution = {}
	
	sets.WS.Retribution = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Fotia Gorget",
    ear1="Steelflash Earring",
    ear2="Bladeborn Earring",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
    ring1="Rajas Ring",
    ring2="Apate Ring",
    back="Kayapa Cape",
    waist="Fotia Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}
	
	
	sets.WS.SpiritTaker = {}
	
	sets.WS.SpiritTaker = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Fotia Gorget",
    ear1="Steelflash Earring",
    ear2="Bladeborn Earring",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
    ring1="Rajas Ring",
    ring2="Apate Ring",
    back="Kayapa Cape",
    waist="Fotia Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}
	
	
	sets.WS.ShellCrusher = {}
	
	sets.WS.ShellCrusher = {main="",
	sub="",
	ammo="Hasty Pinion +1",
    head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
    neck="Fotia Gorget",
    ear1="Steelflash Earring",
    ear2="Bladeborn Earring",
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
	hands="Telchine Gloves",
    ring1="Rajas Ring",
    ring2="Apate Ring",
    back="Kayapa Cape",
    waist="Fotia Belt",
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Telchine Pigaches"}
	
	
	--PRECAST SETS--
	
		
	sets.precast = {}
	
	sets.precast.fc = {}
	
	sets.precast.fc = {head="Bunzi's Hat",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','Song spellcasting time -5%',}},
    legs="Aya. Cosciales +2",
    feet="Nyame Sollerets",
    neck="Baetyl Pendant",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}}}
	
	
	sets.precast.cure = {}
	
	sets.precast.cure = {head="Bunzi's Hat",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','Song spellcasting time -5%',}},
    legs="Ebers pantaloons",
    feet="Nyame Sollerets",
    neck="Baetyl Pendant",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}}}
	
	
	sets.precast.ehancing = {}
	
	sets.precast.enhancing = {head="Bunzi's Hat",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -2%','Song spellcasting time -5%',}},
    legs="Aya. Cosciales +2",
    feet="Nyame Sollerets",
    neck="Baetyl Pendant",
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}}}
	
	sets.precast.impact = {}
	

	sets.precast.benediction = {}
	
	sets.precast.benediction = {body={ name="Piety Briault", augments={'Enhances "Benediction" effect',}}}
	
	
	sets.precast.martyr = {}
	
	sets.precast.martyr = {hands=""}
	
	
	sets.precast.divinecaress = {}
	
	sets.precast.divinecaress = {hands="Ebers Mitts +1", back={ name="Mending Cape", augments={'Healing magic skill +5','Enha.mag. skill +10','Mag. Acc.+4',}},}
	
	
	sets.precast.devotion = {}
	
	sets.precast.devotion = {body="Anhur Robe"}
	
	
	--MIDCAST SETS--
	
	
	sets.WhiteMagic = {}
	
	
	sets.WhiteMagic.enhancingduration = {}
	
	sets.WhiteMagic.enhancingduration = {main="Ababinili",
    sub="Raptor Strap +1",
    ammo="Vanir Battery",
    head="Befouled Crown",
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Refresh"+1',}},
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Earthcry Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Maquette Ring",
    back="Solemnity Cape"}
	
	
	sets.WhiteMagic.aquaveil = {}
	
	sets.WhiteMagic.aquaveil = {main="Gada",
	sub="Ammurapi Shield",
	ammo="Incantor Stone",
	head="Chironic Hat",
	neck="Enhancing Torque",
	ear1="Loquac. Earring",
	ear2="",
	body={ name="Telchine Chas.", augments={'DEF+18','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'Mag. Evasion+9','"Conserve MP"+2','Enh. Mag. eff. dur. +9',}},
	ring1="Prolix Ring",
	ring2="Weather. Ring",
	back="Swith Cape +1",
	waist="Emphatikos Rope",
	legs="Shedir Seraweels",
	feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +8',}}}
	
	
	sets.WhiteMagic.boost = {}
	
	sets.WhiteMagic.boost = {main="Gada",
	sub="Ammurapi Shield",
	ammo="Incantor Stone",
	head={ name="Telchine Cap", augments={'"Conserve MP"+4','Enh. Mag. eff. dur. +8',}},
	neck="Melic Torque",
	ear1="Loquac. Earring",
	ear2="Andoaa Earring",
	body={ name="Telchine Chas.", augments={'DEF+18','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'Mag. Evasion+9','"Conserve MP"+2','Enh. Mag. eff. dur. +9',}},
	ring1="Stikini Ring",
	ring2="Stikini Ring",
	back={ name="Mending Cape", augments={'Healing magic skill +5','Enha.mag. skill +10','Mag. Acc.+4',}},
	waist="Olympus Sash",
	legs={ name="Telchine Braconi", augments={'Evasion+20','Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +8',}}}

	
	sets.WhiteMagic.barspell = {}
	
	sets.WhiteMagic.barspell = {main="Ababinili",
    sub="Raptor Strap +1",
    ammo="Vanir Battery",
    head="Befouled Crown",
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Refresh"+1',}},
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +9',}},
    neck="Loricate Torque +1",
    waist="Gishdubar Sash",
    left_ear="Earthcry Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Maquette Ring",
    back="Solemnity Cape"}
	
	
	sets.WhiteMagic.curepotency = {}
	
	sets.WhiteMagic.curepotency = {main={ name="Gada", augments={'MND+10','Mag. Acc.+20','DMG:+2',}},
    sub="Genbu's Shield",
    ammo="Vanir Battery",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Refresh"+1',}},
    legs="Ebers Pantaloons",
    feet={ name="Chironic Slippers", augments={'Magic dmg. taken -2%','Pet: Attack+16 Pet: Rng.Atk.+16','"Refresh"+1','Accuracy+6 Attack+6',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
	
	
	sets.WhiteMagic.curagapotency = {}
	
	sets.WhiteMagic.curagapotency = {main={ name="Gada", augments={'MND+10','Mag. Acc.+20','DMG:+2',}},
    sub="Genbu's Shield",
    ammo="Vanir Battery",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'Pet: "Store TP"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Refresh"+1',}},
    legs="Ebers Pantaloons",
    feet={ name="Chironic Slippers", augments={'Magic dmg. taken -2%','Pet: Attack+16 Pet: Rng.Atk.+16','"Refresh"+1','Accuracy+6 Attack+6',}},
    neck={ name="Cleric's Torque", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Etiolation Earring",
    right_ear="Tuisto Earring",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
	
	
	sets.WhiteMagic.regen = {}
	
	sets.WhiteMagic.regen = {main="Bolelabunga",
	sub="Ammurapi Shield",
	ammo="Incantor Stone",
	head={ name="Telchine Cap", augments={'"Conserve MP"+4','Enh. Mag. eff. dur. +8',}},
	neck="Orison Locket",
	ear1="Andoaa Earring",
	ear2="Gifted Earring",
	body={ name="Telchine Chas.", augments={'DEF+18','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
	hands="Ebers Mitts +1",
	ring1="Prolix Ring",
	ring2="Weather. Ring",
	back="Swith Cape +1",
	waist="Witful Belt",
	legs={ name="Telchine Braconi", augments={'Evasion+20','Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'Spell interruption rate down -4%','Enh. Mag. eff. dur. +9',}}}
	
	
	sets.WhiteMagic.protect = {}
	
	sets.WhiteMagic.protect = {main="Gada",
	sub="Ammurapi Shield",
	ammo="Incantor Stone",
	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
	neck="Orison Locket",
	ear1="Brachyura Earring",
	ear2="Gifted Earring",
	body={ name="Telchine Chas.", augments={'DEF+18','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
	ring1="Weather. Ring",
	ring2="Sheltered Ring",
	back="Swith Cape +1",
	waist="Witful Belt",
	legs={ name="Piety Pantaloons", augments={'Enhances "Shellra V" effect',}},
	feet={ name="Telchine Pigaches", augments={'Spell interruption rate down -4%','Enh. Mag. eff. dur. +9',}}}
	
	
	sets.WhiteMagic.shell = {}
	
	sets.WhiteMagic.shell = {main="Gada",
	sub="Ammurapi Shield",
	ammo="Incantor Stone",
	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
	neck="Orison Locket",
	ear1="Brachyura Earring",
	ear2="Gifted Earring",
	body={ name="Telchine Chas.", augments={'DEF+18','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
	ring1="Weather. Ring",
	ring2="Sheltered Ring",
	back="Swith Cape +1",
	waist="Witful Belt",
	legs={ name="Piety Pantaloons", augments={'Enhances "Shellra V" effect',}},
	feet={ name="Telchine Pigaches", augments={'Spell interruption rate down -4%','Enh. Mag. eff. dur. +9',}}}
	
	
	sets.WhiteMagic.macc = {}
	
	sets.WhiteMagic.macc = {main="Eminent Staff",
	sub="Mephitis Grip",
	ammo="Incantor Stone",
	head={ name="Helios Band", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. crit. hit dmg. +9%',}},
	neck="Stoicheion Medal",
	ear1="Psystorm Earring",
	ear2="Lifestorm Earring",
	body="Helios Jacket",
	hands="Gendewitha Gages",
	ring1="Stikini Ring",
	ring2="Stikini Ring",
	back="Refraction Cape",
	waist="Salire Belt",
	legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
	feet="Uk'uxkaj Boots"}
	
	
	sets.WhiteMagic.naspell = {}
	
	sets.WhiteMagic.naspell = {main="Yagrush",
    sub="Genbu's Shield",
	ammo="Incantor Stone",
	head="Ebers Cap",
	neck="Orison Locket",
	ear1="Loquac. Earring",
	ear2="Novia Earring",
	body="Inyanga Jubbah +1",
	hands="Ebers Mitts",
	ring1="Prolix Ring",
	ring2="Weather. Ring",
	back={ name="Mending Cape", augments={'Healing magic skill +5','Enha.mag. skill +10','Mag. Acc.+4',}},
	waist="Witful Belt",
	legs="Artsieq Hose",
	feet="Regal Pumps +1"}
	
	
	sets.WhiteMagic.cursna = {}
	
	sets.WhiteMagic.cursna = {main="Yagrush",
    sub="Genbu's Shield",
    ammo="Vanir Battery",
    head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="Inyanga Jubbah +2",
    hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +8','"Conserve MP"+5','"Fast Cast"+5',}},
    legs="Assid. Pants +1",
    feet={ name="Gende. Galosh. +1", augments={'Phys. dmg. taken -4%',}},
    neck="Debilis Medallion",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Tuisto Earring",
    left_ring="Menelaus's Ring",
    right_ring="Haoma's Ring",
    back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}}}
	
	
	sets.WhiteMagic.auspice = {}
	
	sets.WhiteMagic.auspice = {feet="Ebers Duckbills"}
	
	
	sets.WhiteMagic.weather = {}
	
	sets.WhiteMagic.weather = {main="Chatoyant Staff", back='Twilight Cape', waist='Hachirin-no-Obi'}
	
	
	sets.WhiteMagic.weathercure = {}
	
	sets.WhiteMagic.weathercure = {main="Chatoyant Staff", waist='Hachirin-no-Obi'}
	
	
end
	

    -- FUNCTION PRECAST --


function precast(spell)
	
	
	if spell.action_type == 'Magic' then
		equip(sets.precast.fc)
	if spell.english == 'Cure' or spell.english == 'Cure II' or spell.english == 'Cure III' or spell.english == 'Cure IV' or spell.english == 'Cure V' 
	or spell.english == 'Cure VI' or spell.english == 'Curaga' or spell.english == 'Curaga II' or spell.english == 'Curaga III' or spell.english == 'Curaga IV' 
	or spell.english == 'Curaga V' then
	    equip(sets.precast.cure)
	elseif spell.english == 'Regen' or spell.english == 'Regen II' or spell.english == 'Regen III' or spell.english == 'Regen IV' or spell.english == 'Protect' 
	or spell.english == 'Protect II' or spell.english == 'Protect III' or spell.english == 'Protect IV' or spell.english == 'Protect V' 
	or spell.english == 'Protectra' or spell.english == 'Protectra II' or spell.english == 'Protectra III' or spell.english == 'Protectra IV' 
	or spell.english == 'Protectra V' or spell.english == 'Shell' or spell.english == 'Shell II' or spell.english == 'Shell III' or spell.english == 'Shell IV' 
	or spell.english == 'Shell V' or spell.english == 'Shellra' or spell.english == 'Shellra II' or spell.english == 'Shellra III' or spell.english == 'Shellra IV' 
	or spell.english == 'Shellra V' or spell.english == 'Refresh' or spell.english == 'Haste' or spell.english == 'Phalanx' or spell.english == 'Stoneskin' 
	or spell.english == 'Aquaveil' or spell.english == 'Blink' or spell.english == 'Flurry' or spell.english == 'Deodorize' or spell.english == 'Sneak' 
	or spell.english == 'Invisible' or spell.english == 'Blaze Spikes' or spell.english == 'Ice Spikes' or spell.english == 'Shock Spikes' 
	or spell.english == 'Rainstorm' or spell.english == 'Hailstorm' or spell.english == 'Thunderstorm' or spell.english == 'Firestorm' 
	or spell.english == 'Aurorastorm' or spell.english == 'Sandstorm' or spell.english == 'Voidstorm' or spell.english == 'Windstorm' or spell.english == 'Enaero' 
	or spell.english == 'Enblizzard' or spell.english == 'Enfire' or spell.english == 'Enthunder' or spell.english == 'Enstone' or spell.english == 'Enwater'
    or spell.english == 'Barfire' or spell.english == 'Barfira' or spell.english == 'Baraero' or spell.english == 'Baraera' or spell.english == 'Barstone' 
	or spell.english == 'Barstonra' or spell.english == 'Barblizzard' or spell.english == 'Barblizzara' or spell.english == 'Barthunder' 
	or spell.english == 'Barthundra' or spell.english == 'Barwater' or spell.english == 'Barwatera' or spell.english == 'Barsleep' 
	or spell.english == 'Barsleepra' or spell.english == 'Barpoison' or spell.english == 'Barpoisonra' or spell.english == 'Barparalyze' 
	or spell.english == 'Barparalyzra' or spell.english == 'Barblind' or spell.english == 'Barblindra' or spell.english == 'Barsilence' 
	or spell.english == 'Barsilencera' or spell.english == 'Barvirus' or spell.english == 'Barvira' or spell.english == 'Baramnesia' 
	or spell.english == 'Baramnesra' then
        equip(sets.precast.enhancing)
	elseif spell.english == 'Impact' then
	    equip(sets.precast.impact)
	end
	end

	
	if spell.english == 'Hexa Strike' then
	    equip(sets.HexaStrike[sets.HexaStrike.index[HexaStrike_ind]])
	end
	
	
	if spell.english == 'Judgement' then
	    equip(sets.Judgement[sets.Judgement.index[Judgement_ind]])
	end
	
	
	if spell.english == 'Realmrazer' then
		equip(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
	end
	
	
	if spell.english == 'Flash Nova' then
		equip(sets.WS.FlashNova)
	end
	
	
	if spell.english == 'Myrkr' then
	    equip(sets.WS.Myrkr)
	end
	
	
	if spell.english == 'Spirit Taker' then
	    equip(sets.WS.SpiritTaker)
	end
	
	
	if spell.english == 'Shattersoul' then
	    equip(sets.WS.Shattersoul)
	end
	
	
	if spell.english == 'Shell Crusher' then
	    equip(sets.WS.ShellCrusher)
	end
	
	
	if spell.english == 'Retribution' then
	    equip(sets.WS.Retribution)
	end
	
	
	if spell.english == 'Cataclysm' then
	    equip(sets.WS.Cataclysm)
	end
	
	
	if spell.english == 'Devotion' then
	    equip(sets.precast.devotion)
	end
	
	
	if spell.english == 'Benediction' then
	    equip(sets.precast.benediction)
	end
	
	
	if spell.english == 'Martyr' then
	    equip(sets.precast.martyr)
	end
	
	
	if spell.english == 'Divine Caress' then
	    equip(sets.precast.divinecaress)
	end
	
	
end
	
	
    -- FUNCTION MIDCAST --
	
	
function midcast(spell,act)
	
	
	if spell.english == 'Cure' or spell.english == 'Cure II' or spell.english == 'Cure III' or spell.english == 'Cure IV' or spell.english == 'Cure V' 
	or spell.english == 'Cure VI' then
	    equip(sets.WhiteMagic.curepotency)
		    if buffactive['Aurorastorm 	'] then
			equip(sets.WhiteMagic.weathercure)
	end
	end
	
	
	if spell.english == 'Curaga' or spell.english == 'Curaga II' or spell.english == 'Curaga III' or spell.english == 'Curaga IV' 
	or spell.english == 'Curaga V' then
	    equip(sets.WhiteMagic.curagapotency)
		    if buffactive['Aurorastorm'] then
			equip(sets.WhiteMagic.weather)
	end
	end
	
	
	if spell.english == 'Regen' or spell.english == 'Regen II' or spell.english == 'Regen III' or spell.english == 'Regen IV' then
	    equip(sets.WhiteMagic.regen)
	end
	
	
	if spell.english == 'Barfire' or spell.english == 'Barfira' or spell.english == 'Baraero' or spell.english == 'Baraera' or spell.english == 'Barstone' 
	or spell.english == 'Barstonra' or spell.english == 'Barblizzard' or spell.english == 'Barblizzara' or spell.english == 'Barthunder' 
	or spell.english == 'Barthundra' or spell.english == 'Barwater' or spell.english == 'Barwatera' or spell.english == 'Barsleep' 
	or spell.english == 'Barsleepra' or spell.english == 'Barpoison' or spell.english == 'Barpoisonra' or spell.english == 'Barparalyze' 
	or spell.english == 'Barparalyzra' or spell.english == 'Barblind' or spell.english == 'Barblindra' or spell.english == 'Barsilence' 
	or spell.english == 'Barsilencera' or spell.english == 'Barvirus' or spell.english == 'Barvira' or spell.english == 'Baramnesia' 
	or spell.english == 'Baramnesra' then
	    equip(sets.WhiteMagic.barspell)
	end
	
	
	if spell.english == 'Blindna' or spell.english == 'Poisona' or spell.english == 'Paralyna' or spell.english == 'Silena' or spell.english == 'Stona' 
	or spell.english == 'Viruna' then
	    equip(sets.WhiteMagic.naspell)
	end
	
	
	if spell.english == 'Cursna' then
	    equip(sets.WhiteMagic.cursna)
	end
	
	
	if spell.english == 'Blind' or spell.english == 'Slow' or spell.english == 'Paralyze' or spell.english == 'Sleep' or spell.english == 'Sleep II' 
	or spell.english == 'Repose' or spell.english == 'Sleepga' or spell.english == 'Addle' or spell.english == 'Dia' or spell.english == 'Dia II' 
	or spell.english == 'Bio' or spell.english == 'Bio II' or spell.english == 'Diaga' or spell.english == 'Poison' or spell.english == 'Silence' 
	or spell.english == 'Bind' or spell.english == 'Gravity' or spell.english == 'Dispel' or spell.english == 'Distract' or spell.english == 'Frazzle' 
	or spell.english == 'Poison II' or spell.english == 'Poisonga' then
	    equip(sets.WhiteMagic.macc)
	end
	
	
	if spell.english == 'Protect' or spell.english == 'Protect II' or spell.english == 'Protect III' or spell.english == 'Protect IV' 
	or spell.english == 'Protect V' or spell.english == 'Protectra I' or spell.english == 'Protectra II' or spell.english == 'Protectra III' 
	or spell.english == 'Protectra IV' or spell.english == 'Protectra V' then
	    equip(sets.WhiteMagic.protect)
	end
	
	
	if spell.english == 'Shell' or spell.english == 'Shell II' or spell.english == 'Shell III' or spell.english == 'Shell IV' or spell.english == 'Shell V' 
	or spell.english == 'Shellra' or spell.english == 'Shellra II' or spell.english == 'Shellra III' or spell.english == 'Shellra IV' or spell.english == 'Shellra V' then
	    equip(sets.WhiteMagic.shell)
	end
	
	
	if spell.english == 'Refresh' or spell.english == 'Haste' or spell.english == 'Phalanx' or spell.english == 'Stoneskin' or spell.english == 'Blink' 
	or spell.english == 'Flurry' or spell.english == 'Deodorize' or spell.english == 'Sneak' or spell.english == 'Invisible' or spell.english == 'Blaze Spikes' 
	or spell.english == 'Ice Spikes' or spell.english == 'Shock Spikes' or spell.english == 'Rainstorm' or spell.english == 'Hailstorm' or spell.english == 'Thunderstorm' 
	or spell.english == 'Firestorm' or spell.english == 'Aurorastorm' or spell.english == 'Sandstorm' or spell.english == 'Voidstorm' or spell.english == 'Windstorm' 
	or spell.english == 'Enaero' or spell.english == 'Enblizzard' or spell.english == 'Enfire' or spell.english == 'Enthunder' or spell.english == 'Enstone' 
	or spell.english == 'Enwater' then
	    equip(sets.WhiteMagic.enhancingduration)
	end
	
	
	if spell.english == 'Aquaveil' then
	    equip(sets.WhiteMagic.aquaveil)
	end
	
	
	if spell.english == 'Boost-STR' or spell.english == 'Boost-DEX' or spell.english == 'Boost-VIT' or spell.english == 'Boost-AGI' 
	or spell.english == 'Boost-INT' or spell.english == 'Boost-MND' or spell.english == 'Boost-CHR' then
	    equip(sets.WhiteMagic.boost)
	end
	
	
	if spell.english == 'Auspice' then
	    equip(sets.WhiteMagic.auspice)
	end
	
	
end


    -- FUNCTION AFTERCAST --


function aftercast(spell)
	
	
	if player.status == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
	
	
	if spell.action_type == 'Weaponskill' then
		add_to_chat(158,'TP Return: ['..tostring(player.tp)..']')
	end

	
end

function status_change(new,old)
	
	
	if new == 'Engaged' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	else
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
	
	
end

function self_command(command)
	if command == 'toggle TP set' then
		TP_ind = TP_ind +1
		if TP_ind > #sets.TP.index then TP_ind = 1 end
		send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'toggle Idle set' then
		Idle_ind = Idle_ind +1
		if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
		send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	elseif command == 'toggle HexaStrike set' then
		HexaStrike_ind = HexaStrike_ind +1
		if HexaStrike_ind > #sets.HexaStrike.index then HexaStrike_ind = 1 end
		send_command('@input /echo <----- Hexa Strike Set changed to '..sets.HexaStrike.index[HexaStrike_ind]..' ----->')
	elseif command == 'toggle Judgement set' then
		Judgement_ind = Judgement_ind +1
		if Judgement_ind > #sets.Judgement.index then Judgement_ind = 1 end
		send_command('@input /echo <----- Judgement Set changed to '..sets.Judgement.index[Judgement_ind]..' ----->')
	elseif command == 'toggle Realmrazer set' then
		Realmrazer_ind = Realmrazer_ind +1
		if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
		send_command('@input /echo <----- Realmrazer Set changed to '..sets.Realmrazer.index[Realmrazer_ind]..' ----->')
	elseif command == 'equip TP set' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'equip Idle set' then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end