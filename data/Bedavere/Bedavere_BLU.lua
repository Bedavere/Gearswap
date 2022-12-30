require("no_interruptions")

function get_sets()

	
	send_command('bind ^` gs c toggle TP set')		
	RosmertaWS = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	RosmertaNuke = {name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	RosmertaTP = {name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	SavageHercHead ={name="Herculean Helm", augments={'Attack+6','Weapon skill damage +5%','STR+7','Accuracy+7',}}
	CastHercHead = {}
	TPHercHead = {name="Herculean Helm", augments={'Attack+16','"Triple Atk."+3','Accuracy+14',}}
	WSHercBody = {}
	TPHercBody = {}
	WSHercHands = {}
	TPHercHands = {name="Herculean Gloves", augments={'Accuracy+22','"Triple Atk."+2','MND+10','Attack+15',}}
	WSHercLegs = {name="Herculean Trousers", augments={'Accuracy+12 Attack+12','Crit.hit rate+3','STR+5','Accuracy+8','Attack+11',}}
	TPHercLegs = {name="Herculean Trousers", augments={'Accuracy+25','"Triple Atk."+2','AGI+4','Attack+2',}}
	WSHercFeet = {name="Herculean Boots", augments={'Accuracy+30','Crit. hit damage +2%','DEX+10','Attack+1',}}
	TPHercFeet = {name="Herculean Boots", augments={'Accuracy+18','"Triple Atk."+4','DEX+9',}}
	
	
	include('Mote-Globals.lua')
	
	--Idle Sets--	
	sets.Idle = {}
	
	sets.Idle.index = {'Standard','DT'}
	Idle_ind = 1			
	
	sets.Idle.Standard = {ammo="Staunch Tathlum +1",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Flume Belt +1",
    left_ear="Tuisto Earring",
    right_ear="Eabani Earring",
    left_ring="Stikini Ring +1",
    right_ring="Shneddick Ring",
    back="Moonlight Cape"}	
	
	sets.TP = {}

	sets.TP.index = {'Standard','DT','Accuracy'}
	TP_ind = 1
	
	sets.TP.Standard = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Combatant's torque",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Petrov Ring",
    right_ring="Ilabrat Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
						
	sets.TP.DT = {ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Warder's Charm",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Tuisto Earring",
    right_ear="Telos Earring",
    left_ring="Lunette Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
				  
	sets.TP.Accuracy = {ammo="Ginsen",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs={ name="Samnuha Tights", augments={'STR+9','DEX+8','"Dbl.Atk."+2','"Triple Atk."+2',}},
    feet={ name="Herculean Boots", augments={'MND+2','CHR+5','Quadruple Attack +3','Accuracy+2 Attack+2',}},
    neck="Caro Necklace",
    waist="Reiki Yotai",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Petrov Ring",
    right_ring="Ilabrat Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}			  
		
	
	--Weaponskill Sets--
	sets.WS = {}
	
	sets.Requiescat = {}
	
	sets.Requiescat.index = {'Attack','Accuracy'}
	Requiescat_ind = 1
	
	sets.Requiescat.Attack = {ammo="Aqua Sachet",
						      head="Jhakri Coronal +1",neck="Fotia gorget",ear1="Brutal earring",ear2="Moonshade earring",
						 	  body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Epona's ring",ring2="Levia. ring",
						   	  back="Bleating mantle",waist="Fotia belt",legs="Herculean Trousers",feet="Jhakri Pigaches +1"}
								  
	sets.Requiescat.Accuracy = {ammo="Honed tathlum",
						        head="Jhakri Coronal +1",neck="Fotia gorget",ear1="Brutal earring",ear2="Moonshade earring",
							    body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Epona's ring",ring2="Levia. ring",
							    back="Letalis mantle",waist="Fotia belt",legs="Herculean Trousers",feet="Jhakri Pigaches +1"}
							 
	sets.ChantDuCygne = {}
	
	sets.ChantDuCygne.index = {'Attack','Accuracy'}
	ChantDuCygne_ind = 1
	
	sets.ChantDuCygne.Attack = {ammo="Ginsen",
    head="Jhakri Coronal +2",
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands="Jhakri Cuffs +2",
    legs={ name="Herculean Trousers", augments={'Attack+20','Weapon skill damage +4%','STR+10',}},
    feet={ name="Herculean Boots", augments={'Accuracy+13','Weapon skill damage +4%','STR+10','Attack+12',}},
    neck="Caro Necklace",
    waist="Prosilio Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Defending Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
							   
	sets.ChantDuCygne.Accuracy = {ammo="Ginsen",
    head="Jhakri Coronal +2",
    body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
    hands="Jhakri Cuffs +2",
    legs={ name="Herculean Trousers", augments={'Attack+20','Weapon skill damage +4%','STR+10',}},
    feet={ name="Herculean Boots", augments={'Accuracy+13','Weapon skill damage +4%','STR+10','Attack+12',}},
    neck="Caro Necklace",
    waist="Prosilio Belt +1",
    left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    right_ear="Telos Earring",
    left_ring="Ilabrat Ring",
    right_ring="Defending Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
							    
	sets.WS.SanguineBlade = {}
	
	sets.WS.SanguineBlade = {ammo="Pemphredo Tathlum",
						     head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Ishvara earring",ear2="Friomisi earring",
							 body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Archon ring",ring2="Shiva Ring +1",
							 back=RosmertaNuke,waist="Aswang Sash",legs="Amalric Slops",feet="Jhakri Pigaches +1"}
		
	sets.WS.SavageBlade = {ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Caro Necklace",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Tuisto Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ifrit Ring +1",
    right_ring="Epaminonda's Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
	
	sets.WS.CircleBlade = {}		
			
	sets.WS.CircleBlade = {ammo="Cheruski needle",
						   head="Dampening Tam",neck="Fotia Gorget",ear1="Moonshade earring",ear2="Ishvara earring",
						   body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's ring",ring2="Pyrosoul ring",
						   back="Bleating mantle",waist="Fotia belt",legs="Herculean Trousers",feet="Herculean Boots"}
						   
	sets.WS.Expiacion = {}		
			
	sets.WS.Expiacion = {ammo="Cheruski needle",
					     head=SavageHercHead,neck="Caro Necklace",ear1="Moonshade earring",ear2="Ishvara earring",
						 body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's ring",ring2="Pyrosoul ring",
						 back="Vespid mantle",waist="Wanion Belt",legs=TPHercLegs,feet=TPHercFeet}
						 
	sets.Realmrazer = {}
	
	sets.Realmrazer.index = {'Attack','Accuracy'}
	Realmrazer_ind = 1
	
	sets.Realmrazer.Attack = {ammo="Cheruski needle",
						      head="Jhakri Coronal +1",neck="Fotia gorget",ear1="Bladeborn earring",ear2="Steelflash Earring",
						 	  body="Luhlaza jubbah +1",hands="Jhakri Cuffs +1",ring1="Levia. ring",ring2="Aquasoul ring",
						   	  back="Bleating mantle",waist="Fotia belt",legs="Hashishin Tayt +1",feet="Jhakri Pigaches +1"}
							  
	sets.Realmrazer.Accuracy = {ammo="Honed tathlum",
						        head="Jhakri Coronal +1",neck="Flame gorget",ear1="Bladeborn earring",ear2="Steelflash earring",
							    body="Luhlaza jubbah +1",hands="Jhakri Cuffs +1",ring1="Levia. ring",ring2="Aquasoul ring",
							    back="Letalis mantle",waist="Light belt",legs="Hashishin Tayt +1",feet="Jhakri Pigaches +1"}
							
	sets.WS.BlackHalo = {}		
			
	sets.WS.BlackHalo = {ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Caro Necklace",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Tuisto Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ifrit Ring +1",
    right_ring="Epaminonda's Ring",
    back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
						 						
	sets.WS.FlashNova = {}
	
	sets.WS.FlashNova = {ammo="Pemphredo Tathlum",
						  head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Novio Earring",ear2="Friomisi earring",
						  body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Shiva ring +1",ring2="Shiva Ring +1",
						  back=RosmertaNuke,waist="Aswang Sash",legs="Amalric Slops",feet="Jhakri Pigaches +1"}
								
								
								
								
								
	--Blue Magic Sets--
	sets.BlueMagic = {}
	
	sets.BlueMagic.STR = {ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','"Mag.Atk.Bns."+25','Enmity-6',}},
    feet={ name="Herculean Boots", augments={'"Cure" potency +9%','Crit. hit damage +1%','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    neck="Sanctity Necklace",
    waist="Yamabuki-no-Obi",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}}}
						  
	sets.BlueMagic.STRDEX = {ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','"Mag.Atk.Bns."+25','Enmity-6',}},
    feet={ name="Herculean Boots", augments={'"Cure" potency +9%','Crit. hit damage +1%','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    neck="Sanctity Necklace",
    waist="Yamabuki-no-Obi",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}}}
							
	sets.BlueMagic.STRVIT = {ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','"Mag.Atk.Bns."+25','Enmity-6',}},
    feet={ name="Herculean Boots", augments={'"Cure" potency +9%','Crit. hit damage +1%','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    neck="Sanctity Necklace",
    waist="Yamabuki-no-Obi",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}}}
							 
	sets.BlueMagic.STRMND = {ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','"Mag.Atk.Bns."+25','Enmity-6',}},
    feet={ name="Herculean Boots", augments={'"Cure" potency +9%','Crit. hit damage +1%','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    neck="Sanctity Necklace",
    waist="Yamabuki-no-Obi",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}}}
								
	sets.BlueMagic.AGI = {ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','"Mag.Atk.Bns."+25','Enmity-6',}},
    feet={ name="Herculean Boots", augments={'"Cure" potency +9%','Crit. hit damage +1%','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    neck="Sanctity Necklace",
    waist="Yamabuki-no-Obi",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}}}
						  ---
	sets.BlueMagic.INT = {ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
    body={ name="Amalric Doublet +1", augments={'MP+80','"Mag.Atk.Bns."+25','"Fast Cast"+4',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','"Mag.Atk.Bns."+25','Enmity-6',}},
    feet={ name="Herculean Boots", augments={'"Cure" potency +9%','Crit. hit damage +1%','Phalanx +4','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
    neck="Sanctity Necklace",
    waist="Yamabuki-no-Obi",
    left_ear="Regal Earring",
    right_ear="Friomisi Earring",
    left_ring="Shiva Ring +1",
    right_ring="Shiva Ring +1",
    back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10',}}}
						  
	sets.BlueMagic.TenebralCrush = set_combine(sets.BlueMagic.INT, {head="Pixie Hairpin +1"})
						  
	sets.BlueMagic.CruelJoke = {ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",
    body="Shamash Robe",
    hands="Regal Cuffs",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},}
	
	sets.BlueMagic.MortalRay = {ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",
    body="Shamash Robe",
    hands="Regal Cuffs",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},}
	
	sets.BlueMagic.GeistWall = {main={ name="Tizona", augments={'Path: A',}},
    sub="Naegling",
    ammo="Staunch Tathlum +1",
    head="Volte Cap",
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands="Volte Bracers",
    legs="Volte Hose",
    feet="Volte Boots",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Shneddick Ring",
    back="Moonlight Cape",}
						  
	sets.BlueMagic.Cures = {ammo="Aqua sachet",
						    head="Carmine Mask",neck="Aife's Medal",ear1="Lifestorm earring",ear2="Loquac. earring",
						    body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Levia. ring",ring2="Karka ring",
						    back="Tempered Cape +1",waist="Cascade Belt",legs="Telchine Braconi",feet="Medium's Sabots"}
							
	sets.BlueMagic.SelfCures = {ammo="Aqua sachet",
								head="Carmine Mask",neck="Aife's Medal",ear1="Loquac. earring",ear2="Lifestorm earring",
								body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Asklepian ring",ring2="Kunaji Ring",
								back="Tempered Cape +1",waist="Chuq'aba Belt",legs="Telchine Braconi",feet="Medium's Sabots"}
							
	sets.BlueMagic.Stun = {ammo="Mavi tathlum",
						   head="Helios Band",neck="Sanctity Necklace",ear1="Loquac. earring",
						   body="Jhakri Robe +1",hands="Leyline Gloves",ring1="Stikini Ring",ring2="Sangoma ring",
						   back="Cornflower cape",waist="Ovate Rope",legs="Hashishin Tayt +1",feet="Luhlaza charuqs +1"}
						   
	sets.BlueMagic.HeavyStrike = {ammo="Honed tathlum",
						          head="Jhakri Coronal +1",neck="Ire torque",ear1="Flame pearl",ear2="Heartseeker earring",
						          body="Assim. jubbah +1",hands="Umuthi gloves",ring1="Pyrosoul ring",ring2="Petrov ring",
						          back="Cornflower cape",waist="Dynamic belt +1",legs="Manibozho brais",feet="Assim. charuqs +1"}
								  
	 
	
	sets.BlueMagic.WhiteWind = {ammo="Mavi tathlum",
								head="Luh. Keffiyeh +1",neck="Cuamiz collar",ear1="Upsurge Earring",ear2="Cassie earring",
								body="Aetosaur jerkin",hands="Weath. cuffs +1",ring1="Bomb queen ring",ring2="Meridian ring",
								back="Oretania's cape",waist="Gold mog. belt",legs="Desultor tassets",feet="Llwyd's clogs"}
									 
	sets.BlueMagic.MagicAccuracy = {ammo="Pemphredo Tathlum",
    head="Malignance Chapeau",
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Erra Pendant",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Digni. Earring",
    left_ring="Stikini Ring +1",
    right_ring="Stikini Ring +1",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},} 
									 
	sets.BlueMagic.Skill = {ammo="Mavi tathlum",
							head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Loquac. earring",
							body="Assim. jubbah +1",hands="Fea's Cuffs",ring1="Renaye ring",
							back="Cornflower cape",waist="Twilight belt",legs="Hashishin Tayt +1",feet="Luhlaza charuqs +1"}
							
	sets.BlueMagic.SkillRecast = {ammo="Mavi tathlum",
							      head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Loquac. earring",
							      body="Assim. jubbah +1",hands="Fea's Cuffs",ring1="Prolix ring",
							      back="Cornflower cape",waist="Twilight belt",legs="Hashishin Tayt +1",feet="Luhlaza charuqs +1"}
								  
								  
								  
								  
						
						
	--Utility Sets--
	sets.Utility = {}
	
	sets.Utility.Stoneskin = {head="Haruspex hat",neck="Stone Gorget",ear1="Loquac. earring",ear2="Earthcry earring",
							  body="Assim. jubbah +1",hands="Stone Mufflers",ring1="Prolix ring",
							  back="Swith Cape +1",waist="Siegel sash",legs="Haven hose",feet="Iuitl gaiters"}
							  
	sets.Utility.Phalanx = {head="Haruspex hat",neck="Incanter's torque",ear1="Loquac. earring",ear2="Augment. earring",
						    body="Assim. jubbah +1",hands="Ayao's gages",ring1="Prolix ring",
							back="Swith Cape +1",waist="Pythia sash +1",legs="Portent pants",feet="Iuitl gaiters"}
							
	sets.Utility.Steps = {ammo="Honed tathlum",
						  head="Jhakri Coronal +1",ear2="Heartseeker earring",
						  body="Thaumas coat",hands="Umuthi gloves",
						  back="Letalis cape",waist="Chaac belt",legs="Manibozho brais",feet="Manibozho boots"}
						  
	sets.Utility.PDT = {head="Jhakri Coronal +1",neck="Twilight torque",ear1="Ethereal earring",
						body="Iuitl vest",hands="Umuthi gloves",ring1="Dark ring",ring2="Dark ring",
						back="Mollusca mantle",waist="Flume belt",legs="Iuitl Tights +1",feet="Iuitl gaiters"}
						
	sets.Utility.MDT = {head="Jhakri Coronal +1",neck="Twilight torque",
						body="Assim. jubbah +1",hands="Umuthi gloves",ring1="Dark ring",ring2="Dark ring",
						back="Mollusca mantle",legs="Herculean Trousers",feet="Luhlaza charuqs +1"}
							
	
	
	
	
	
	--Job Ability Sets--
	
	sets.JA = {}
	
	sets.JA.ChainAffinity = {feet="Assim. charuqs"}
	
	sets.JA.BurstAffinity = {feet="Hashishin Basmak +1"}
	
	sets.JA.Efflux = {legs="Hashishin Tayt +1",back="Rosmerta's Cape"}
	
	sets.JA.AzureLore = {hands="Luh. bazubands +1"}
	
	sets.JA.Diffusion = {feet="Luhlaza Charuqs +1"}
								
								
			
			
			
			
	--Precast Sets--
	sets.precast = {}
	
	sets.precast.FC = {}
	
	sets.precast.FC.Standard = {ammo="Sapience Orb",
    head="Amalric Coif +1",
    body={ name="Samnuha Coat", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+14','"Fast Cast"+3','"Dual Wield"+4',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +2",
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Orunmila's Torque",
    waist="Witful Belt",
    left_ear="Enchntr. Earring +1",
    right_ear="Etiolation Earring",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back="Perimede Cape"}
	
	sets.precast.FC.Blue = {ammo="Sapience Orb",
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +2",
    feet={ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}},
    neck="Orunmila's Torque",
    waist="Witful Belt",
    left_ear="Tuisto Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back="Moonlight Cape"}	
							
	sets.org = {main="Tizona",sub="Nibiru Blade",main="Nibiru Cudgel",sub="Nibiru Cudgel",
				ring1="Warp Ring",ring2="Echad Ring",ring2="Trizek Ring",back="Nexus Cape",
				back="Aptitude Mantle",head="Echo Drops",neck="Remedy",hands="Marinara Slice +1",waist="Holy Water",
				legs="Sole Sushi +1",feet="Reraise Earring"}						
end


function precast(spell)
	if spell.action_type == 'Magic' then
		equip(sets.precast.FC.Standard)
				
		if spell.skill == 'Blue Magic' then
		equip(sets.precast.FC.Blue)
		end
	end
	
	if spell.english == 'Azure Lore' then
		equip(sets.JA.AzureLore)
	end
	
	if spell.english == 'Requiescat' or spell.english == 'Savage Blade' then
		equip(sets.Requiescat[sets.Requiescat.index[Requiescat_ind]])
	end
	
	if spell.english == 'Chant du Cygne' then
		equip(sets.ChantDuCygne[sets.ChantDuCygne.index[ChantDuCygne_ind]])
	end
	
	if spell.english == 'Circle Blade' then
		equip(sets.WS.CircleBlade)
	end
		
	if spell.english == 'Expiacion' then
		equip(sets.WS.Expiacion)
	end
	
	if spell.english == 'Sanguine Blade' then
		equip(sets.WS.SanguineBlade)
	end
	
	if spell.english == 'Savage Blade' then
		equip(sets.WS.SavageBlade)
	end
	
	if spell.english == 'Box Step' then
		equip(sets.Utility.Steps)
	end
	
	if spell.english == 'Realmrazer' then
		equip(sets.Realmrazer[sets.Realmrazer.index[Realmrazer_ind]])
	end
	
	if spell.english == 'Flash Nova' then
		equip(sets.WS.FlashNova)
	end
end
	
function midcast(spell,act)
	if spell.english == 'Vertical Cleave' or spell.english == 'Death Scissors' or spell.english == 'Empty Thrash' or spell.english == 'Dimensional Death' or spell.english == 'Quadrastrike' or spell.english == 'Bloodrake' then
		equip(sets.BlueMagic.STR)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
		
	if spell.english == 'Disseverment' or spell.english == 'Hysteric Barrage' or spell.english == 'Frenetic Rip' or spell.english == 'Seedspray' or spell.english == 'Vanity Dive' or spell.english == 'Goblin Rush' or spell.english == 'Paralyzing Triad' or spell.english == 'Thrashing Assault' then
		equip(sets.BlueMagic.STRDEX)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Quad. Continuum' or spell.english == 'Sinker Drill' or spell.english == 'Delta Thrust' or spell.english == 'Cannonball' or spell.english == 'Glutinous Dart' then
		equip(sets.BlueMagic.STRVIT)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Whirl of Rage' then
		equip(sets.BlueMagic.STRMND)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Benthic Typhoon' or spell.english == 'Final Sting' or spell.english == 'Spiral Spin' then
		equip(sets.BlueMagic.AGI)
		if buffactive['Chain Affinity'] then
			equip(sets.JA.ChainAffinity)
		end
		if buffactive['Efflux'] then
			equip(sets.JA.Efflux)
		end
	end
	
	if spell.english == 'Gates of Hades' or spell.english == 'Leafstorm' or spell.english == 'Firespit' or spell.english == 'Acrid Stream' or spell.english == 'Regurgitation' or spell.english == 'Corrosive Ooze' or spell.english == 'Thermal Pulse' or spell.english == 'Magic Hammer' or spell.english == 'Evryone. Grudge' or spell.english == 'Water Bomb' or spell.english == 'Dark Orb' or spell.english == 'Thunderbolt' or spell.english == 'Tem. Upheaval' or spell.english == 'Embalming Earth' or spell.english == 'Foul Waters' or spell.english == 'Rending Deluge' or spell.english == 'Droning Whirlwind' or spell.english == 'Subduction' or spell.english == 'Spectral Floe' or spell.english == 'Anvil Lightning' or spell.english == 'Scouring Spate' or spell.english == 'Entomb' or spell.english == 'Searing Tempest' then
		equip(sets.BlueMagic.INT)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end
	end
	
	if spell.english == 'Tenebral Crush' then
		equip(sets.BlueMagic.TenebralCrush)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end
	end
	
	if spell.english == 'Magic Fruit' or spell.english == 'Plenilune Embrace' or spell.english == 'Wild Carrot' or spell.english == 'Pollen' or spell.english == 'Cure III' or spell.english == 'Cure IV' then
		equip(sets.BlueMagic.Cures)
			if spell.target.name == player.name and string.find(spell.english, 'Magic Fruit') or string.find(spell.english, 'Plenilune Embrace') or string.find(spell.english, 'Wild Carrot') or string.find(spell.english, 'Cure III') or string.find(spell.english, 'Cure IV') then
				equip(sets.BlueMagic.SelfCures)
			end
	end
	
	if spell.english == 'White Wind' then
		equip(sets.BlueMagic.WhiteWind)
	end
	
	if spell.english == 'Head Butt' or spell.english == 'Sudden Lunge' or spell.english == 'Blitzstrahl' then
		equip(sets.BlueMagic.Stun)
	end
	
	if spell.english == 'Heavy Strike' then
		equip(sets.BlueMagic.HeavyStrike)
	end
	
	if spell.english == 'Charged Whisker' then
		equip(sets.BlueMagic.ChargedWhisker)
		if buffactive['Burst Affinity'] then
			equip(sets.JA.BurstAffinity)
		end
	end
	
	if spell.english == 'Cruel Joke' then
		equip(sets.BlueMagic.CruelJoke)
	end
	
	if spell.english == 'Mortal Ray' then
		equip(sets.BlueMagic.MortalRay)
	end
	
	if spell.english == 'Geist Wall' then
		equip(sets.BlueMagic.GeistWall)
	end
	
	if spell.english == 'Frightful Roar' or spell.english == 'Infrasonics' or spell.english == 'Barbed Crescent' or spell.english == 'Tourbillion' or spell.english == 'Cimicine Discharge' or spell.english == 'Sub-zero smash' or spell.english == 'Filamented Hold' or spell.english == 'Mind Blast' or spell.english == 'Sandspin' or spell.english == 'Hecatomb Wave' or spell.english == 'Cold Wave' or spell.english == 'Terror Touch' or spell.english == 'Blank Gaze' or spell.english == 'Dream Flower' then
		equip(sets.BlueMagic.MagicAccuracy)
	end
	
	if spell.english == 'MP Drainkiss' or spell.english == 'Digest' or spell.english == 'Blood Saber' or spell.english == 'Blood Drain' or spell.english == 'Osmosis' or spell.english == 'Occultation' or spell.english == 'Magic Barrier' or spell.english == 'Diamondhide' or spell.english == 'Metallic Body' or spell.english == 'Retinal Glare' or spell.english == 'Mighty Guard' then
		equip(sets.BlueMagic.SkillRecast)
		if buffactive['Diffusion'] then
			equip(sets.JA.Diffusion)
		end
	end
	
	if spell.english == 'Cocoon' or spell.english == 'Harden Shell' or spell.english == 'Animating Wail' or spell.english == 'Battery Charge' or spell.english == 'Nat. Meditation' or spell.english == 'Carcharian Verve' or spell.english == 'O. Counterstance' or spell.english == 'Barrier Tusk' or spell.english == 'Saline Coat' or spell.english == 'Regeneration' or spell.english == 'Erratic Flutter' then
		if buffactive['Diffusion'] then
			equip(sets.JA.Diffusion)
		end
	end
end

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
	elseif command == 'toggle Req set' then
		Requiescat_ind = Requiescat_ind +1
		if Requiescat_ind > #sets.Requiescat.index then Requiescat_ind = 1 end
		send_command('@input /echo <----- Requiescat Set changed to '..sets.Requiescat.index[Requiescat_ind]..' ----->')
	elseif command == 'toggle CDC set' then
		ChantDuCygne_ind = ChantDuCygne_ind +1
		if ChantDuCygne_ind > #sets.ChantDuCygne.index then ChantDuCygne_ind = 1 end
		send_command('@input /echo <----- Chant du Cygne Set changed to '..sets.ChantDuCygne.index[ChantDuCygne_ind]..' ----->')
	elseif command == 'toggle Rea set' then
		Realmrazer_ind = Realmrazer_ind +1
		if Realmrazer_ind > #sets.Realmrazer.index then Realmrazer_ind = 1 end
		send_command('@input /echo <----- Realmrazer Set changed to '..sets.Realmrazer.index[Realmrazer_ind]..' ----->')
	elseif command == 'equip TP set' then
		equip(sets.TP[sets.TP.index[TP_ind]])
	elseif command == 'equip Idle set' then
		equip(sets.Idle[sets.Idle.index[Idle_ind]])
	end
end