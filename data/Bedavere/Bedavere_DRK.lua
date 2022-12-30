-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end
 
 require("no_interruptions")
-- //gs debugmode
-- //gs showswaps

function binds_on_load()
-- F9-F12
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind f10 gs c cycle HybridMode')
    send_command('bind f11 gs c cycle CastingMode')
    send_command('bind f12 gs c update user')
-- CTRL F9-F12
    send_command('bind ^f9 gs c cycle WeaponskillMode')
-- ALT F9-12
    send_command('bind !f9 gs c cycle IdleMode')
    send_command('bind !f10 gs c cycle RangedMode')
    send_command('bind !f12 gs c cycle Kiting')
end
 
function user_setup()
    -- Options: Override default values: Create Macro~Line1: /console gs c set OffenseMode Normal (change for each offense Mode)
													--Line2: /equip main "Montante +1" (change per wep)
													--Line3: /equip sub "Utu Grip" 
    state.OffenseMode:options('Normal', 'Ragnarok', 'Montante', 'Scythe', 'TpPDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal','PDT')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
 
                 
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()

	sets.WakeSleep = {neck="Berserker's Torque", head="Frenzy Sallet",}        --to auto wake up on zzz

	sets.enmity = {
	ammo="Sapience Orb",
    head="Halitus Helm",
    body="Emet Harness",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Odyssean Cuisses", augments={'"Store TP"+7','DEX+13','Accuracy+13',}},
    feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Unmoving Collar +1",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Cryptic Earring",
    left_ring="Eihwaz Ring",
    right_ring="Vexer Ring +1",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}
------------------------
-- Precast sets
------------------------
    sets.precast.JA['Blood Weapon'] = {}
    sets.precast.JA['Souleater'] = {}
    sets.precast.JA['Aracne Circle'] = {}
    sets.precast.JA['Warding Circle'] = {}
    sets.precast.JA['Weapon Bash'] = {}
    sets.precast.JA['Diabolic Eye'] = {}
    sets.precast.JA['Nether Void'] = {}
    sets.precast.JA['Arcane Crest'] = {}
	sets.precast.JA['Scarlet Delirium'] = {}
	sets.precast.JA['Soul Enslavement'] = {}
	sets.precast.JA['Consume Mana'] = {}
    sets.precast.JA['Provoke'] = sets.enmity
------------------------------- 
-- Fast cast sets for spells
-------------------------------
sets.precast.FC = {
    sub="Utu Grip",
    ammo="Staunch Tathlum",
    head="Sulevia's Mask +2",
    body={ name="Odyss. Chestplate", augments={'Mag. Acc.+1','"Fast Cast"+5','"Mag.Atk.Bns."+2',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Odyssean Greaves", augments={'Accuracy+26','"Fast Cast"+5','Mag. Acc.+4','"Mag.Atk.Bns."+13',}},
    neck="Loricate Torque +1",
    waist="Ioskeha Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Loquac. Earring",
    left_ring="Kishar Ring",
    right_ring="Prolix Ring",
    back="Solemnity Cape",
}
   
------------------------------   
	-- Midcast Sets
------------------------------	
    sets.midcast.FastRecast = {ammo="Pemphredo Tathlum",
				head="Pixie Hairpin +1", neck="Erra Pendant", ear1="Halasz Earring", ear2="Digni. Earring",
				body="Dagon Breast.", hands="Leyline Gloves", ring1="Archon Ring", ring2="Evanescence Ring",
				back=CicholWS, waist="Hachirin-no-obi", legs={ name="Odyssean Cuisses", augments={'"Store TP"+7','DEX+13','Accuracy+13',}},
				feet="Odyssean Greaves"}
	
	sets.midcast['Drain III']= 
				{ammo="Pemphredo Tathlum",
				head="Pixie Hairpin +1", neck="Erra Pendant", ear1="Halasz Earring", ear2="Digni. Earring",
				body="Dagon Breast.", hands="Leyline Gloves", ring1="Archon Ring", ring2="Evanescence Ring",
				back=CicholWS, waist="Hachirin-no-obi", legs={ name="Odyssean Cuisses", augments={'"Store TP"+7','DEX+13','Accuracy+13',}},
				feet="Odyssean Greaves"}
				
	sets.midcast['Stun']= {
	ammo="Sapience Orb",
    head="Halitus Helm",
    body="Emet Harness",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Odyssean Cuisses", augments={'"Store TP"+7','DEX+13','Accuracy+13',}},
    feet={ name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}},
    neck="Unmoving Collar +1",
    waist="Eschan Stone",
    left_ear="Friomisi Earring",
    right_ear="Cryptic Earring",
    left_ring="Eihwaz Ring",
    right_ring="Vexer Ring +1",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}

-----------------------		
-- Idle sets
-----------------------
	sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body={ name="Sakpata's Plate", augments={'Path: A',}},
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Loricate torque +1",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Sanare Earring",
    left_ring="Moonlight Ring",
    right_ring="Defending Ring",
    back="Moonlight Cape",
}
-----------------------        
--Engaged sets
-----------------------        
	sets.engaged.Normal = {
    ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Flam. Zucchetto +2",
    body="Volte Harness",
    hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
    legs="Sakpata's Cuisses",
    feet="Flam. Gambieras +2",
    neck="Combatant's Torque",
    waist="Ioskeha Belt +1",
    left_ear="Crep. Earring",
    right_ear="Telos Earring",
    left_ring="Moonlight Ring",
    right_ring="Flamma Ring",
    back="Moonlight Cape",
}
	
	sets.engaged.Ragnarok = {
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body="Emicho Haubert +1",
    hands="Emicho Gaunlets +1",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Lissome Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}
	
	sets.engaged.Montante = sets.engaged.Normal
	
	sets.engaged.Scythe = {    --Anguta--
    ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Emicho Haubert +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    hands={ name="Emi. Gauntlets +1", augments={'HP+65','DEX+12','Accuracy+20',}},
    legs={ name="Odyssean Cuisses", augments={'"Store TP"+7','DEX+13','Accuracy+13',}},
    feet="Flam. Gambieras +2",
    neck="Lissome Necklace",
    waist="Ioskeha Belt +1",
    left_ear="Brutal Earring",
    right_ear="Cessance Earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}
					
	sets.engaged.TpPDT = {
    ammo="Staunch Tathlum",
    head="Sulevia's Mask +2",
    body="Dagon Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt +1",
    left_ear="Cessance Earring",
    right_ear="Telos Earring",
    left_ring="Moonbeam Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
}
-----------------------
 -- Weaponskill sets
----------------------
	--All WS's not expressly identified
	sets.precast.WS = {
    ammo="Knobkierrie",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Caro Necklace",
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Schere Earring", augments={'Path: A',}},
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back="Moonlight Cape",
}
	
	-- 73-85% STR | Fragmentation / Scission
	sets.precast.WS['Torcleaver'] = {
    ammo="Knobkierrie",
    head="Sulevia's Mask +2",
    body="Dagon Breast.",
    hands={ name="Odyssean Gauntlets", augments={'Weapon skill damage +4%','VIT+14','Accuracy+14','Attack+8',}},
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
}
    
	-- 40/40% STR/VIT  | Light / Fusion	
	 sets.precast.WS['Scourge'] = {
    ammo="Knobkierrie",
    head="Sulevia's Mask +2",
    body="Dagon Breast.",
    hands={ name="Odyssean Gauntlets", augments={'Weapon skill damage +4%','VIT+14','Accuracy+14','Attack+8',}},
    legs="Sulev. Cuisses +2",
    feet="Sulev. Leggings +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Moonshade Earring",
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}},
}

	 sets.precast.WS['Resolution'] = {
    ammo="Seeth. Bomblet +1",
    head="Flam. Zucchetto +2",
    body="Dagon Breast.",
    hands="Sulev. Gauntlets +2",
    legs="Sulev. Cuisses +2",
    feet="Flam. Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +25',}},
    right_ear="Telos Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
}
	--73-85% VIT Fusion / Compression 
	 sets.precast.WS['Upheaval'] = {}
	
	-- 73-85% STR | Distortion / Detonation
	 sets.precast.WS['Ruinator'] = {}
     

end
 
 function job_buff_change(status,gain_or_loss)
    if buffactive.sleep then
	equip(sets.WakeSleep)
	end
	if playerStatus == 'Idle' then
        equip(sets.idle.PDT)   --   change idle name if different in your lua
   end
end
 
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
moonshade_WS = S{"Resolution", "Torcleaver"}
 

        