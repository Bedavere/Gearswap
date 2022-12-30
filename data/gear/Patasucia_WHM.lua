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
sets.precast['General'] = {main="Grioavolr",sub="Clerisy Strap",ammo="Sapience Orb",
		head="Nahtirah Hat",neck="Cleric's torque",left_ear="Loquac. Earring",right_ear="Etiolation Earring",
		body="Inyanga Jubbah +1",hands="Gende. Gages +1",left_ring="Weather. Ring",right_ring="Kishar Ring",legs="Ayanmo cosciales +2",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},waist="Witful Belt",feet="Kaykaus boots +1",}
sets.precast['Cure'] = set_combine(sets.precast['General'], {main="Queller Rod",sub="Sors Shield",head="Piety Cap +3", legs="Ebers Pantaloons +1", right_ear="Nourish. Earring +1", feet="Vanya clogs"})
sets.precast['Enhancing Magic'] = set_combine(sets.precast['General'] )
sets.precast['Impact'] = set_combine(sets.precast['General'], {head='empty',body="Twilight Cloak"})

--Midcast sets
sets.midcast['General'] = set_combine(sets.precast['General'])
sets.midcast['Cure'] = {main="Queller Rod",sub="Sors Shield",ammo="Homiliary",
    head="Kaykaus Mitra +1",neck="Cleric's torque",left_ear="Mendi. Earring",right_ear="Nourish. Earring +1", body="Ebers Bliaud +1",hands="Theophany Mitts +3",left_ring="Lebeche Ring",right_ring="Janniston Ring", waist="Acerbic Sash +1",legs="Ebers Pant. +1",feet="Kaykaus boots +1", back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+4','"Cure" potency +10%',}}}
sets.midcast['Curaga'] = set_combine(sets.midcast['Cure'],{body="Theo. Briault +3"})
sets.midcast['StatusHeals'] = set_combine(sets.precast['General'], {main="Yagrush",neck="Cleric's Torque",head="Ebers Cap +1",body="Piety Briault +3",waist="Witful Belt",hands="Inyan. dastanas +2",feet="Ayanmo Gambieras +2"})
sets.midcast['Cursna'] = set_combine(sets.midcast['StatusHeals'])

sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",
		head="Telchine Cap",neck="Cleric's Torque",left_ear="Andoaa Earring",left_ring="Stikini Ring",right_ring="Stikini Ring +1",back="Perimede Cape",
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},hands="Inyan. dastanas +2",legs="Telchine Braconi",feet="Kaykaus boots +1"}
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
sets['Idle DT'] = {main="Queller rod",sub="Genmei Shield",ammo="Homiliary",
	head="Aya. Zucchetto +2",neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Etiolation Earring",
	body="Theo. Briault +3",hands="Chironic Gloves",left_ring="Defending Ring",right_ring="Stikini Ring +1",
	back="Solemnity Cape",waist="Fucho-no-Obi",legs="Assid. Pants +1",feet="Ayanmo Gambieras +2"}
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