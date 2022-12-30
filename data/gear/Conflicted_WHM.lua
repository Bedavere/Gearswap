organizer_items = {
    echos="Echo Drops",
    ring="Warp Ring",
}

sets['precast'] = {}
sets['midcast'] = {}
sets['mpBelt'] = {waist="Fucho-no-Obi"}
sets['Reive'] = {}

sets.midcast['Weather'] = {}

sets['TH'] = {waist="Chaac Belt"}

--Precast Sets
sets.precast['General'] = {main="Ames",
    sub="Sors Shield",
    ammo="Incantor Stone",
    head="Inyanga Tiara +1",
    body="Zendik Robe",
    hands="Inyan. Dastanas +1",
    legs="Aya. Cosciales +1",
    feet="Pinga Pumps",
    neck="Aceso's Choker",
    waist="Embla Sash",
    left_ear="Mendi. Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Inyanga Ring",
    back="Moonbeam Cape"}
sets.precast['Cure'] = set_combine(sets.precast['General'], {main="Queller rod",
    sub="Sors Shield",
    ammo="Incantor Stone",
    head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    body="Annoint. Kalasiris",
    hands={ name="Chironic Gloves", augments={'"Fast Cast"+2','CHR+4','"Refresh"+2','Accuracy+4 Attack+4',}},
    legs="Ebers Pant. +1",
    feet={ name="Kaykaus Boots +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    neck={ name="Clr. Torque +1", augments={'Path: A',}},
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Tuisto Earring",
    left_ring="Defending Ring",
    right_ring="Stikini Ring +1",
    back="Moonbeam Cape"})
sets.precast['Enhancing Magic'] = set_combine(sets.precast['General'] )
sets.precast['Impact'] = set_combine(sets.precast['General'], {head='empty',body="Twilight Cloak"})

--Midcast sets
sets.midcast['General'] = set_combine(sets.precast['General'])
sets.midcast['Cure'] = {main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}},
    sub="Genmei Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Kaykaus Mitra +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    body="Ebers Bliaud +1",
    hands={ name="Chironic Gloves", augments={'"Fast Cast"+2','CHR+4','"Refresh"+2','Accuracy+4 Attack+4',}},
    legs="Ebers Pant. +1",
    feet={ name="Kaykaus Boots +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
    neck={ name="Clr. Torque +1", augments={'Path: A',}},
    waist="Austerity Belt",
    left_ear="Malignance Earring",
    right_ear="Mendi. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Solemnity Cape"}
sets.midcast['Curaga'] = set_combine(sets.midcast['Cure'],{body="Theo. Briault +3"})
sets.midcast['StatusHeals'] = set_combine(sets.precast['General'], {main="Yagrush",neck="Cleric's Torque",head="Ebers Cap +1",body="Piety Briault +3",waist="Witful Belt",hands="Inyan. dastanas +2",feet="Ayanmo Gambieras +2"})
sets.midcast['Cursna'] = set_combine(sets.midcast['StatusHeals'])

sets.midcast['Enhancing Magic'] = {main="Ames",
    sub="Sors Shield",
    ammo="Incantor Stone",
    head={ name="Telchine Cap", augments={'Mag. Evasion+13','"Elemental Siphon"+10','Enh. Mag. eff. dur. +9',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+21','"Elemental Siphon"+20','Enh. Mag. eff. dur. +7',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+15','"Elemental Siphon"+15','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+18','"Elemental Siphon"+15','Enh. Mag. eff. dur. +5',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+22','"Elemental Siphon"+30','Enh. Mag. eff. dur. +8',}},
    neck="Loricate Torque +1",
    waist="Austerity Belt",
    left_ear="Thureous Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Inyanga Ring",
    back="Moonbeam Cape"}
sets.midcast['Enhancing Magic Duration'] = sets.midcast['Enhancing Magic']
sets.midcast['Stoneskin'] = sets.midcast['Enhancing Magic']
sets.midcast['Refresh'] = sets.midcast['Enhancing Magic']
sets.midcast['Haste'] = sets.midcast['Enhancing Magic']
sets.midcast['Dia'] = {waist="Chaac Belt",feet="Chironic Slippers"}
sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'])
sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga",head="Inyanga Tiara +1",body="Piety Briault +3",hands="Ebers Mitts +1",legs="Theophany Pantaloons +3"})
sets.midcast['Barspell'] = set_combine(sets.midcast['Enhancing Magic'], {
		main="Beneficus",sub="Ammurapi Shield",head="Ebers Cap +1",body="Ebers Bliaud +1",legs="Piety Pantaloons +2",feet="Ebers Duckbills +1"})
sets.midcast['Barspell Light Arts'] = set_combine(sets.midcast['Enhancing Magic'])
sets.midcast['Elemental Magic'] = set_combine(sets.midcast['General'])
sets.midcast['Impact']=set_combine(sets.midcast['Elemental Magic'], {head='empty',body="Twilight Cloak",ring2="Stikini Ring +1",})
sets.midcast['Divine Magic'] = set_combine(sets.midcast['Elemental Magic'], {ring2="Stikini Ring +1",})
sets.midcast['Repose'] = set_combine(sets.midcast['General'])
sets.midcast['Dark Magic'] = set_combine(sets.midcast['General'])
sets.midcast['Stun'] = set_combine(sets.midcast['Dark Magic'])
sets.midcast['Enfeebling Magic'] = {main="Gada",sub="Ammurapi Shield",ammo="Homiliary",
    head="Theophany Cap +3",neck="Erra Pendant",left_ear="Regal Earring",right_ear="Digni. Earring",
    body="Theo. Briault +3",hands="Inyan. Dastanas +2",left_ring="Kishar Ring",right_ring="Stikini Ring +1",
    waist="Luminary Sash",legs="Th. Pant. +3",feet="Theo. Duckbills +3",
	back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10','Mag. Evasion+15',}}}

--JA Sets
sets['Benediction'] = set_combine(sets['Idle'], {body="Piety Briault +3"})
sets['Divine Caress'] = set_combine(sets['Idle'], {hands="Ebers Mitts"})

--Idle Sets
sets['Idle DT'] = {main="Ames",
    sub="Genmei Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Chironic Hat", augments={'"Store TP"+2','STR+4','"Refresh"+2',}},
    body="Shamash robe",
    hands={ name="Chironic Gloves", augments={'"Fast Cast"+2','CHR+4','"Refresh"+2','Accuracy+4 Attack+4',}},
    legs="Inyanga Shalwar +1",
    feet={ name="Chironic Slippers", augments={'Crit.hit rate+1','Weapon skill damage +2%','"Refresh"+2','Accuracy+3 Attack+3','Mag. Acc.+2 "Mag.Atk.Bns."+2',}},
    neck="Loricate Torque +1",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Moonbeam Cape"}
sets['Idle Refresh'] = sets['Idle DT']
sets['Resting'] = set_combine(sets['Idle Refresh'])
sets['Melee'] = {main="Tishtrya",sub="Mafic Cudgel",ammo="Homiliary",
    head="Aya. Zucchetto +2",neck="Asperity Necklace",left_ear="Telos Earring",right_ear="Brutal Earring",
    body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",left_ring="Rajas Ring",right_ring="Ilabrat Ring",
    waist="Witful Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2",
    back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
sets['Running'] = {}

--WS Sets
sets['WS'] = set_combine(sets['Melee'])
sets['Shattersoul'] = set_combine(sets['WS'])
sets['Hexa Strike'] = set_combine(sets['WS'])
sets['Realmrazer']=set_combine(sets['WS'])
sets['Mystic Boon']=set_combine(sets['WS'])

--Weapons for melee lock modes (need to update gear inside self command too if you change these)
sets['Staff']=set_combine(sets['Melee'])
sets['Club']=set_combine(sets['Melee'])
sets['Dual Club']=set_combine(sets['Melee'])