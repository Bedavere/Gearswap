-- Initialization function for this job file.

require("no_interruptions")

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end
 
-- //gs debugmode
-- //gs showswaps
require("no_interruptions") 
send_command('input /macro book 1;wait .1;input /macro set 4')
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
    -- Options: Override default values
    state.OffenseMode:options('Masa', 'Doji', 'DT')
    state.WeaponskillMode:options('Normal', 'NoDMG', 'PDT')
    state.HybridMode:options('Normal', 'PDT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('PDT', 'Regen')
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
     
------------------------
-- Precast sets For Job Abilities
------------------------
sets.precast.JA['Hasso'] = {
	hands="Wakido Kote +3",
}
sets.precast.JA['Meditate'] = {}


sets.precast.JA['Provoke'] = {ammo="Sapience Orb",
    head={ name="Loess Barbuta +1", augments={'Path: A',}},
    body="Emet Harness",
    hands="Kurys Gloves",
    legs={ name="Mpaca's Hose", augments={'Path: A',}},
    feet="Mpaca's Boots",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Trance Belt",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Petrov Ring",
    right_ring="Eihwaz Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
	
	--hands="Volte bracers",
	--legs="Volte hose",
	--feet="Volte boots",
	--waist="Chaac belt"

sets.precast.JA['Jump'] = {
	ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Wakido Kote +3",
    legs="Wakido Haidate +3",
    feet="Flam. Gambieras +2",
    neck="Moonlight Nodowa",
    waist="Kentarch Belt +1",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

sets.precast.JA['High Jump'] = {
	ammo="Ginsen",
    head="Flam. Zucchetto +2",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Wakido Kote +3",
    legs="Wakido Haidate +3",
    feet="Flam. Gambieras +2",
    neck="Moonlight Nodowa",
    waist="Kentarch Belt +1",
    left_ear="Telos Earring",
    right_ear="Cessance Earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
------------------------------- 
-- Fast cast sets for spells
-------------------------------

   
------------------------------   
	-- Midcast Sets
------------------------------	

	sets.midcast.Stun = {
	ammo="Sapience Orb",
	head="Loess Barbuta +1",
	neck="Warder's charm",
	body="Emet Harness",
	ear1="Friomisi Earring",
	ear2="Cryptic Earring",
	ring2="Petrov Ring",
	ring1="Eihwaz Ring",
	hands="Kurys Gloves",
	waist="Chaac Belt",
	legs="Volte hose",
	feet="Volte boots",
	back="Moonlight cape"}
	
	sets.midcast.Fire = {
	ammo="Sapience Orb",
	head="Loess Barbuta +1",
	neck="Warder's charm",
	body="Emet Harness",
	ear1="Friomisi Earring",
	ear2="Cryptic Earring",
	ring2="Petrov Ring",
	ring1="Eihwaz Ring",
	hands="Kurys Gloves",
	waist="Chaac Belt",
	legs="Volte hose",
	feet="Volte boots",
	back="Moonlight cape"}
	
	sets.midcast.Stone = {
	ammo="Sapience Orb",
	head="Loess Barbuta +1",
	neck="Warder's charm",
	body="Emet Harness",
	ear1="Friomisi Earring",
	ear2="Cryptic Earring",
	ring2="Petrov Ring",
	ring1="Eihwaz Ring",
	hands="Kurys Gloves",
	waist="Chaac Belt",
	legs="Volte hose",
	feet="Volte boots",
	back="Moonlight cape"}
	
------------------------------
    -- Aftercast Set 
------------------------------

	sets.aftercast = {
	ammo="Pemphredo Tathlum",
    head="Twilight Helm",
    ammo="Staunch Tathlum",
    head="Loess Barbuta +1",
    body="Wakido Domaru +3",
    hands="Flam. Manopolas +2",
    legs={ name="Valor. Hose", augments={'Accuracy+5','Damage taken-2%','Attack+10',}},
    feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
    neck="Lissome Necklace",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Breath dmg. taken -4%',}},
    back="Moonbeam Cape"}

-----------------------		
-- Idle sets
-----------------------
	sets.idle.Town = {
	ammo="Pemphredo Tathlum",
    head="Twilight Helm",
    ammo="Staunch Tathlum",
    head="Loess Barbuta +1",
    body="Wakido Domaru +3",
    hands="Flam. Manopolas +2",
    legs={ name="Valor. Hose", augments={'Accuracy+5','Damage taken-2%','Attack+10',}},
    feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
    neck="Lissome Necklace",
    waist="Flume Belt +1",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -4%','Breath dmg. taken -4%',}},
    back="Moonbeam Cape",
}

	sets.idle.PDT = {
	ammo="Crepusucular Pebble",
    head="Nyame helm",
    body="Ken. Samue +1",
    hands="Wakido Kote +3",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Sam. nodowa +1",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Schere Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.idle.Regen = {
    ammo="Staunch Tathlum",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
    hands="Kurys Gloves",
    legs="Ken. Hakama +1",
    feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Infused Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Defending Ring",
    right_ring="Gelatinous Ring +1",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}


-----------------------        
--Engaged sets
-----------------------        
	sets.engaged.Masa = {
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Ken. Samue +1",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Flam. Gambieras +2",
    neck="Sam. nodowa +1",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Schere Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}
	
	sets.engaged.Doji = {
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Ken. Samue +1",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Flam. Gambieras +2",
    neck="Sam. nodowa +1",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Schere Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.Norifusa = {
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Wakido Domaru +3",
    hands="Wakido Kote +3",
    legs="Wakido Haidate +3",
    feet="Flam. Gambieras +2",
    neck="Sam. nodowa +1",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Schere Earring",
    left_ring="Petrov Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}

	sets.engaged.DT = {
    ammo="Crepusucular Pebble",
    head="Nyame helm",
    body="Ken. Samue +1",
    hands="Wakido Kote +3",
    legs="Nyame flanchard",
    feet="Nyame sollerets",
    neck="Sam. nodowa +1",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Schere Earring",
    left_ring="Defending Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}	

	sets.engaged.Amano = {
    ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body="Ken. Samue +1",
    hands="Wakido Kote +3",
    legs="Ken. Hakama +1",
    feet="Flam. Gambieras +2",
    neck="Fotia Gorget",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Schere Earring",
    left_ring="Flamma Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

	

-----------------------
 -- Weaponskill sets
----------------------
	--STR--
	sets.precast.WS = {
	ammo="Knobkierrie",
    head="Nyame helm",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Nyame Gauntlets",
    legs="Wakido Haidate +3",
    feet="Nyame sollerets",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}	

	sets.precast.WS.PDT = {
	ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+30','Weapon skill damage +4%','STR+15','Accuracy+12',}},
    body="Sakonji Domaru +3",
    hands={ name="Founder's Gauntlets", augments={'STR+7','Attack+10','"Mag.Atk.Bns."+8','Phys. dmg. taken -2%',}},
    legs="Wakido Haidate +3",
    feet={ name="Founder's Greaves", augments={'VIT+9','"Mag.Atk.Bns."+12','Mag. Evasion+9',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminonda's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}	

	sets.precast.WS.NoDMG = {
	ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+30','Weapon skill damage +4%','STR+15','Accuracy+12',}},
    body="Sakonji Domaru +3",
    hands={ name="Founder's Gauntlets", augments={'STR+7','Attack+10','"Mag.Atk.Bns."+8','Phys. dmg. taken -2%',}},
    legs="Wakido Haidate +3",
    feet={ name="Founder's Greaves", augments={'VIT+9','"Mag.Atk.Bns."+12','Mag. Evasion+9',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminonda's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

	sets.precast.WS['Tachi: Shoha'] = {
	ammo="Knobkierrie",
    head="Nyame helm",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Nyame Gauntlets",
    legs="Wakido Haidate +3",
    feet="Nyame sollerets",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}	

	sets.precast.WS['Tachi: Shoha'].NoDMG = {
	ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+30','Weapon skill damage +4%','STR+15','Accuracy+12',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Wakido Kote +3",
    legs="Wakido Haidate +3",
    feet="Flam. Gambieras +2",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.precast.WS['Tachi: Fudo'] = {
    ammo="Knobkierrie",
    head="Mpaca's cap",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Nyame Gauntlets",
    legs="Wakido Haidate +3",
    feet="Nyame sollerets",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Flamma Ring", --Change back to Regal later
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}	

	sets.precast.WS['Tachi: Fudo'].NoDMG = {
	ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+30','Weapon skill damage +4%','STR+15','Accuracy+12',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Wakido Kote +3",
    legs="Wakido Haidate +3",
    feet="Ken. Sune-Ate +1",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Regal Ring", --Change back to Regal later
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	
	--STR40%-CHR60%--
	sets.precast.WS['Tachi: Ageha'] = {
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flam. Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flam. Gambieras +2",
    neck="Sanctity Necklace",
    waist="Fotia Belt",
    left_ear="Digni. Earring",
    right_ear="Telos Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

	sets.precast.WS['Tachi: Yukikaze'] = sets.precast.WS['Tachi: Fudo']

	sets.precast.WS['Tachi: Yukikaze'].NoDMG = {
    ammo="Pemphredo Tathlum",
    head="Flam. Zucchetto +2",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs={ name="Founder's Hose", augments={'MND+10','Mag. Acc.+15','Attack+15','Breath dmg. taken -5%',}},
    feet="Flam. Gambieras +2",
    neck="Sam. Nodowa +2",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Digni. Earring",
    left_ring="Regal Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

	-- 73-85% STR | Fragmentation / Scission
	sets.precast.WS['Tachi: Jinpu'] = {
    ammo="Knobkierrie",
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
    
	sets.precast.WS['Tachi: Kagero'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Accuracy+2 Attack+2','Weapon skill damage +3%','STR+10','Accuracy+10',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+19','Weapon skill damage +3%','STR+9','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +3%','STR+13','Accuracy+14','Attack+2',}},
    neck="Sam. Nodowa +1",
    waist="Prosilio Belt +1",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Epaminonda's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.precast.WS['Tachi: Koki'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Accuracy+2 Attack+2','Weapon skill damage +3%','STR+10','Accuracy+10',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+19','Weapon skill damage +3%','STR+9','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +3%','STR+13','Accuracy+14','Attack+2',}},
    neck="Sam. Nodowa +1",
    waist="Prosilio Belt +1",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

	
	sets.precast.WS['Tachi: Goten'] = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Accuracy+2 Attack+2','Weapon skill damage +3%','STR+10','Accuracy+10',}},
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands={ name="Valorous Mitts", augments={'Accuracy+19','Weapon skill damage +3%','STR+9','Attack+2',}},
    legs="Wakido Haidate +3",
    feet={ name="Valorous Greaves", augments={'Weapon skill damage +3%','STR+13','Accuracy+14','Attack+2',}},
    neck="Sam. Nodowa +1",
    waist="Prosilio Belt +1",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

	sets.precast.WS['Tachi: Jinpu'].NoDMG = {
    ammo="Knobkierrie",
    head={ name="Valorous Mask", augments={'Attack+30','Weapon skill damage +4%','STR+15','Accuracy+12',}},
    body="Sakonji Domaru +3",
    hands={ name="Founder's Gauntlets", augments={'STR+7','Attack+10','"Mag.Atk.Bns."+8','Phys. dmg. taken -2%',}},
    legs="Wakido Haidate +3",
    feet={ name="Founder's Greaves", augments={'VIT+9','"Mag.Atk.Bns."+12','Mag. Evasion+9',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Niqmaddu Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}

	sets.precast.WS['Stardiver'] = {
	ammo="Knobkierrie",
    head="Nyame helm",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Nyame Gauntlets",
    legs="Wakido Haidate +3",
    feet="Nyame sollerets",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.precast.WS['Sonic Thrust'] = {
	ammo="Knobkierrie",
    head="Nyame helm",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Nyame Gauntlets",
    legs="Wakido Haidate +3",
    feet="Nyame sollerets",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	
	sets.precast.WS['Namas Arrow'] = {
    head="Nyame helm",
    body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
    hands="Nyame Gauntlets",
    legs="Wakido Haidate +3",
    feet="Nyame sollerets",
    neck={ name="Sam. Nodowa +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Thrud Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Regal Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Mag. Acc+20 /Mag. Dmg.+20','STR+10','Weapon skill damage +10%',}},
}
	 -- Mighty Strikes WS Set --
    sets.MS_WS = {}
end

function job_buff_change(status,gain_or_loss)
    if buffactive.sleep then
	equip(sets.WakeSleep)
	end
	if playerStatus == 'Idle' then
        equip(sets.idle.PDT)   --   change idle name if different in your lua
   end
end

function self_command(command)
	if command == 'autohasso' then
		if not runHasso then
			runHasso = true
			windower.add_to_chat(1,'AutoHasso set to On')
			windower.send_command('input /ja Hasso <me>')
		else
			runHasso = false
			windower.add_to_chat(1,'AutoHasso set to Off')
		end
	end
end
