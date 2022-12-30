organizer_items = {
    echos="Echo Drops",
    capring="Capacity Ring",
    vocring="Vocation Ring",
    facring="Facility Ring",
    capmantle="Mecisto. Mantle",
    ring="Warp Ring",
    food="Pear Crepe"
}

HagondesHat_MAcc = {}
HagondesHat_MATK = {}

opposingElement = T{}
opposingElement['Water'] = 'Fire'
opposingElement['Lightning'] = 'Water'
opposingElement['Earth'] = 'Lightning'
opposingElement['Wind'] = 'Earth'
opposingElement['Ice'] = 'Wind'
opposingElement['Fire'] = 'Ice'
opposingElement['Light'] = 'Dark'
opposingElement['Dark'] = 'Light'

stormNames = T{}
stormNames['Water'] = 'Rainstorm'
stormNames['Lightning'] = 'Thunderstorm'
stormNames['Earth'] = 'Sandstorm'
stormNames['Wind'] = 'Windstorm'
stormNames['Ice'] = 'Hailstorm'
stormNames['Fire'] = 'Firestorm'
stormNames['Light'] = 'Voidstorm'
stormNames['Dark'] = 'Aurorastorm'

sets['Lightning'] = {}
sets['Ice'] = {}
sets['Water'] = {}
sets['Fire'] = {}
sets['Earth'] = {}
sets['Wind'] = {}
sets['Light'] = {}
sets['Dark'] = {}

sets['precast'] = {}
sets['midcast'] = {}
sets['mpBelt'] = {}
sets['Reive'] = {}
sets['Mythic'] = {}
sets['Resting'] = {}

sets['IdleRefresh'] = {main="Bolelabunga",sub="Genmei Shield",range="Dunna",
	head="Befouled Crown",neck="Loricate Torque +1",left_ear="Genmei Earring",right_ear="Etiolation Earring",
	body="Jhakri Robe +2",hands="Bagua Mitaines +2",left_ring="Gelatinous Ring",right_ring="Defending Ring",
	back="Moonbeam Cape",waist="Fucho-no-Obi",legs="Assid. Pants +1",feet="Mallquis Clogs +1"}

sets['DT'] = sets['IdleRefresh']
sets['Town'] = sets['DT']
sets['Running'] = {}
sets['BubbleActive'] = {}
sets['BolelabungaSet'] = {main="Bolelabunga"}
sets['TooMuchTP'] = {}

sets.precast['General'] = {main="Solstice",range="Dunna", 
	head={ name="Merlinic Hood", augments={'"Fast Cast"+5','CHR+9',}},neck="Voltsurge Torque",left_ear="Loquac. Earring",right_ear="Etiolation Earring",
	hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+30','"Fast Cast"+4','"Mag.Atk.Bns."+2',}},left_ring="Kishar Ring",right_ring="Weather. Ring",
	back="Lifestream Cape",waist="Witful Belt",legs="Geomancy Pants +2",feet={ name="Merlinic Crackows", augments={'"Fast Cast"+5','Mag. Acc.+10','"Mag.Atk.Bns."+8'}}}

sets['Melee'] = set_combine(sets.precast['General'], {})
sets.midcast['General'] = sets.precast['General']
sets.precast['Elemental Magic'] = set_combine(sets.precast['General'], {})

sets.midcast['Low'] = {}
sets.midcast['Mid'] = {}
sets.midcast['High'] = {}
sets.midcast['Low']['Elemental Magic'] = {}
sets.midcast['Mid']['Elemental Magic'] = sets.midcast['Low']['Elemental Magic']
sets.midcast['High']['Elemental Magic'] = sets.midcast['Low']['Elemental Magic']
sets.midcast['Low']['Elemental Magic MB'] = set_combine(sets.midcast['Low']['Elemental Magic'])
sets.midcast['Mid']['Elemental Magic MB'] = set_combine(sets.midcast['Mid']['Elemental Magic'])
sets.midcast['High']['Elemental Magic MB'] = set_combine(sets.midcast['High']['Elemental Magic'])
sets['lowMpNuke'] = {}
sets['Myrkr'] = sets.precast['General']
sets['Flash Nova'] = sets.midcast['High']['Elemental Magic']
sets['Shining Strike'] = sets.midcast['High']['Elemental Magic']
sets['Seraph Strike'] = sets.midcast['High']['Elemental Magic']

sets['Luopan_DT'] = {main="Bolelabunga",sub="Genmei Shield",range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head="Azimuth Hood",neck="Loricate Torque +1",left_ear="Handler's Earring",right_ear="Handler's Earring +1",
	body="Jhakri Robe +2",hands="Geo. Mitaines +2",left_ring="Gelatinous Ring",right_ring="Defending Ring",
	waist="Isa Belt",legs="Assid. Pants +1",feet="Bagua Sandals +3",
	back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10'}}}

sets.midcast['Enhancing Magic'] = {main="Gada",sub="Ammurapi Shield",range="Dunna",
	head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},neck="Incanter's Torque",left_ear="Andoaa Earring",
	body={ name="Telchine Chas.", augments={'Pet: "Regen"+3','Enh. Mag. eff. dur. +10',}},
	hands={ name="Telchine Gloves", augments={'Pet: "Regen"+3','Enh. Mag. eff. dur. +7',}},left_ring="Stikini Ring",right_ring="Stikini Ring",
	back="Perimede Cape",legs={ name="Telchine Braconi", augments={'Pet: "Regen"+3','Enh. Mag. eff. dur. +10',}},
	feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}}

sets.midcast['Enhancing Magic'] = set_combine(sets.precast['General'],{head="Befouled Crown"})
sets.precast['Geomancy'] = sets.precast['General']

sets.midcast['Geomancy'] = {main="Solstice",sub="Genmei Shield",range="Dunna",
	head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},neck="Incanter's Torque",left_ear="Calamitous Earring",right_ear="Gifted Earring",
	body="Bagua Tunic +1",hands="Geo. Mitaines +2",left_ring="Stikini Ring",right_ring="Stikini Ring",
	waist="Austerity Belt +1",back="Solemnity Cape",legs={ name="Vanya Slops", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
	feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}}

sets.midcast['Indi'] = set_combine(sets.midcast['Geomancy'], {legs="Bagua Pants +1",feet="Azimuth Gaiters",
	back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}})

sets.precast['Stoneskin'] = set_combine(sets.precast['Enhancing Magic'])
sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'])
sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {})

sets.midcast['Low']['Drain'] = set_combine(sets.midcast['Low']['Elemental Magic'], {})
sets.midcast['Mid']['Drain'] = sets.midcast['Mid']['Drain']
sets.midcast['High']['Drain'] = sets.midcast['High']['Drain']
sets.midcast['Enfeebling Magic'] =set_combine(sets.midcast['High']['Elemental Magic'], {})
sets['Trust'] = sets['Town']
sets.precast['Impact'] = set_combine(sets.precast['General'], {head=empty,body="Twilight Cloak"})
sets.midcast['Impact'] = sets.precast['Impact']
sets.precast['CureSet'] = {main="Gada",sub="Sors Shield",head="Vanya Hood",feet="Vanya Clogs",back="Solemnity Cape"}
sets.midcast['CureSet'] = set_combine(sets.precast['Cureset'],{})
sets.precast['Life Cycle'] = {}
sets.precast['Bolster'] = {body="Bagua Tunic +1"}
sets.precast['Radial Arcana'] = {}