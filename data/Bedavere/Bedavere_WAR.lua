--  Credit goes to Flippant for helping me with Gearswap  --
--  I Use Some of Motenten's Functions  --

-- Initialization function for this job file.
function get_sets()
mote_include_version = 2
include('Mote-Include.lua')
end
 
-- gs debugmode
-- gs showswaps
 
function binds_on_load()
-- F9-F12
send_command('bind f9 gs c cycle OffenseMode')
send_command('bind f10 gs c cycle HybridMode')
send_command('bind f11 gs c cycle CastingMode')
send_command('bind f12 gs c update user')
-- CTRL F9-F12
send_command('bind ^q gs c mainweapon')
send_command('bind ^f9 gs c cycle WeaponskillMode')
-- ALT F9-12
send_command('bind !f9 gs c cycle IdleMode')
send_command('bind !f10 gs c cycle RangedMode')
send_command('bind !f12 gs c cycle Kiting')
end
 
function job_setup()
state.mainweapon = M{['description'] = 'Main Weapon'}
state.mainweaponoptions('GAX','GSD','Shield','DW','FAxe','DWaxe','Pole','H2H')
end
 
function user_setup()
-- Options Override default values
state.OffenseModeoptions('Normal', 'Acc')
state.WeaponskillModeoptions('Normal', 'Acc')
state.HybridModeoptions('Normal', 'PDT')
state.CastingModeoptions('Normal', 'Resistant')
state.IdleModeoptions('Normal','PDT')
state.PhysicalDefenseModeoptions('PDT', 'MDT')
 
GAX_weapons = S{'Chango'}
GSD_weapons = S{'Ragnarok'}
Shield_weapons = S{'Blurred Shield +1'}
DW_weapons = S{'Reikiko','Tanmogayi +1'}
DWaxe_weapons = S{'Dolichenus','Barbarity +1'}
FAxe_weapons = S{'Dolichenus','Blurred Shield +1'}
Pole_weapons = S{'Shining One'}
H2H_weapons = S{'Karambit'}
 
update_combat_form()
select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg job change)
function file_unload()
if binds_on_unload then
binds_on_unload()
end
end

sets.mainweapon = {}

sets.mainweapon.GAX = {
main="Chango",
sub="Utu Grip",
}

sets.mainweapon.GSD = {
main="Ragnarok",
sub="Utu Grip",
}

sets.mainweapon.Shield = {
main="Reikiko",
sub="Blurred Shield +1",
}
 
sets.mainweapon.DW = {
 main="Reikiko",
 sub="Tanmogayi +1",
 }
 
sets.mainweapon.FAxe = {
main="Dolichenus",
sub="Blurred Shield +1",
}
 
sets.mainweapon.DWaxe = {
 main="Dolichenus",
 sub="Reikiko",
 }
 
sets.mainweapon.Pole = {
main="Shining One",
sub="Utu Grip",
}

sets.mainweapon.H2H = {
main="Karambit",
}

 
-- Define sets and vars used by this job file.
function init_gear_sets()
-- Precast sets
	sets.JA = {}
	
	sets.precast.JA.Berserk = {"body=Pumm. Lorica +3","feet=Agoge Calligae +3"}
	sets.precast.JA.Aggressor = {head="umm. Mask +3",body="Agoge Lorica +3"}
	sets.precast.JA.Retaliation = {feet="Boii Calligae +1"}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1"}
	sets.precast.JA.Warcry = {head="Agoge Mask +3"}
	sets.precast.JA.Tomahawk = {ammo="Thr. Tomahawk"}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +3"}
 
-- Fast cast sets for spells
sets.precast.FC = {ammo="Sapience Orb",
    head="{ name=Odyssean Helm, augments={'Accuracy+29','Fast Cast+2','AGI+4','Attack+5',}}",
    body="{ name=Odyss. Chestplate, augments={'Accuracy+22 Attack+22','Fast Cast+5','MND+10',}}",
    hands="{ name=Leyline Gloves, augments={'Accuracy+12','Mag. Acc.+14','Mag.Atk.Bns.+15','Fast Cast+2',}}",
    legs="{ name=Eschite Cuisses, augments={'Mag.Atk.Bns.+25','Conserve MP+6','Fast Cast+5',}}",
    feet="{ name=Odyssean Greaves, augments={'Accuracy+18','Fast Cast+4','INT+13','Mag.Atk.Bns.+2',}}",
    neck="Voltsurge Torque",
    waist="Flume Belt",
    left_ear="Cessance Earring",
    right_ear="Loquac. Earring",
    left_ring="Defending Ring",
    right_ring="Moonlight Ring",
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20','Attack+20','STR+10','Double Attack+10',}},}
 
-- Midcast Sets
sets.midcast.FastRecast = {}
sets.JA.Berserk = {body=Pumm. Lorica +3,feet=Agoge Calligae +3}
sets.JA.Aggressor = {head=Pumm. Mask +3,body=Agoge Lorica +3}
sets.JA[Blood Rage] = {body=Boii Lorica +1}
sets.JA.Warcry = {head=Agoge Mask +3}
sets.JA.Tomahawk = {ammo=Thr. Tomahawk}
sets.JA[Mighty Strikes] = {hands=Agoge Mufflers +3}

sets.midcast.Flash = {}
 
-- Resting sets --
 
-- Idle sets
sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Volte Salade",
    body={ name=Souv. Cuirass +1, augments={'HP+65','STR+12','Accuracy+13',}},
    hands="Volte Moufles",
    legs="Volte Brayettes",
    feet="Hermes' Sandals",
    neck=Loricate Torque +1",
    waist=Flume Belt',
    left_ear=Odnowa Earring +1,
    right_ear=Odnowa Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20','Attack+20','STR+8','Weapon skill damage +10%','Damage taken-5%',}}
}
 
sets.idle.PDT = {    ammo=Staunch Tathlum +1,
    head=Volte Salade,
    body={ name=Souv. Cuirass +1, augments={'HP+65','STR+12','Accuracy+13',}},
    hands=Volte Moufles,
    legs=Volte Brayettes,
    feet=Hermes' Sandals,
    neck=Loricate Torque +1,
    waist=Ioskeha Belt +1,
    left_ear=Odnowa Earring +1,
    right_ear=Odnowa Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20','Attack+20','STR+8','Weapon skill damage +10%','Damage taken-5%',}}}

 
--Engaged GAX
sets.engaged.GAX = {
	ammo=Ginsen,
    head=Flam. Zucchetto +2,
    body=Pumm. Lorica +3,
    hands=Sulev. Gauntlets +2,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Regal Ring,
    right_ring=Flamma Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage Taken -5%'}},
}
 
sets.engaged.GAX.PDT = {
    ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},
} 
 
 --Engaged Pole
sets.engaged.Pole = {
	ammo=Ginsen,
    head=Flam. Zucchetto +2,
    body=Agoge Lorica +3,
    hands=Sulev. Gauntlets +2,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Brutal Earring,
    left_ring=Niqmaddu Ring,
    right_ring=Flamma Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage Taken -5%'}},
}
 
sets.engaged.Pole.PDT = {main=Shining One, 
	sub=Utu Grip, 
    ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},
} 
 
--Engaged H2H
sets.engaged.H2H = {    ammo=Yetshila +1,
    head=Flam. Zucchetto +2,
    body=Flamma Korazin +2,
    hands=Flam. Manopolas +2,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck={ name=War. Beads +2, augments={'Path A',}},
    waist=Ioskeha Belt +1,
    left_ear=Mache Earring +1,
    right_ear=Mache Earring +1,
    left_ring=Hetairoi Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},}

  sets.engaged.H2H.PDT = set_combine(sets.engaged.H2H), {   
	ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},}
 
 sets.engaged.H2H.Acc  = {
 ammo= Seething Bomblet +1,
	head=Flam. Zucchetto +2,
    body=Pumm. Lorica +3,
    hands=Flam. Manopolas +2,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Mache Earring +1,
    right_ear=Mache Earring +1,
    left_ring=Regal Ring,
    right_ring=Chirich Ring +1,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage Taken -5%'}},}
	
--Engaged GSD
sets.engaged.GSD = {
    sub=Utu Grip,
    ammo=Ginsen,
    head=Flam. Zucchetto +2,
    body=Pumm. Lorica +3,
    hands=Sulev. Gauntlets +2,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Regal Ring,
    right_ring=Flamma Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage Taken -5%'}},}
 
sets.engaged.GSD.PDT = set_combine(sets.engaged.GSD), {    ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},}
 
sets.engaged.GSD.Acc = set_combine(sets.engaged.GSD, {})

-- DW Set
sets.engaged.DW = {    ammo=Ginsen,
    head=Flam. Zucchetto +2,
    body=Flamma Korazin +2,
    hands=Emicho Gauntlets +1,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Suppanomimi,
    left_ring=Flamma Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+30','Attack+20','Double Attack+10','Damage taken -5%'}},}

sets.engaged.DW.PDT = {
     ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Suppanomimi,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},}
 
-- DWaxe Set
sets.engaged.DWaxe = {
	ammo=Ginsen,
    head=Flam. Zucchetto +2,
    body=Flamma Korazin +2,
    hands=Emicho Gauntlets +1,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Suppanomimi,
    left_ring=Flamma Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage Taken -5%'}},}

sets.engaged.DWaxe.PDT = {
    ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Suppanomimi,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},}

-- Sword and Board Sets
sets.engaged.Shield = {    ammo=Ginsen,
    head=Flam. Zucchetto +2,
    body=Agoge Lorica +3,
    hands=Agoge Mufflers +3,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Regal Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage Taken -5%'}},}
 
sets.engaged.Shield.PDT = {    ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20','Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},}


sets.engaged.Shield.Acc = set_combine(sets.engaged.GAX, {})

-- FAxe Set
 sets.engaged.FAxe = {    ammo=Ginsen,
    head=Flam. Zucchetto +2,
    body=Agoge Lorica +3,
    hands=Agoge Mufflers +3,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Regal Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20, Attack+20','Accuracy+10','Double Attack+10','Damage Taken -5%'}},}
 
sets.engaged.FAxe.PDT = {    ammo=Staunch Tathlum +1,
    head=Sulevia's Mask +2,
    body=Souveran Cuirass +1,
    hands=Sulev. Gauntlets +2,
    legs=Souveran Diechlings +1,
    feet=Pumm. Calligae +3,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Cessance Earring,
    right_ear=Telos Earring,
    left_ring=Moonlight Ring,
    right_ring=Defending Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','Double Attack+10','Damage taken-5%',}},}

 
-- Weaponskill sets
sets.precast.WS = {    ammo=Knobkierrie,
    head=Agoge Mask +3,
    body=Pumm. Lorica +3,
    hands=Pumm. Mufflers +3,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=Fotia Gorget,
    waist=Fotia Belt,
    left_ear=Cessance Earring,
    right_ear={ name=Moonshade Earring, augments={'Attack+4','TP Bonus +25',}},
    left_ring=Regal Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20 Attack+20','STR+10','Double Attack+10',}},}

sets.precast.WS[Upheaval] = {
    ammo=Knobkierrie,
    head=Agoge Mask +3,
    neck=War. Beads +2,
    left_ear=Brutal Earring,
    right_ear=Moonshade Earring,
    body=Pummeler's Lorica +3,
    hands=Argosy Mufflers +1,
	left_ring=Regal Ring,
    right_ring=Epaminondas's Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20','Attack+20','STR+8','Weapon skill damage +10%','Damage taken-5%',}},
    waist=Ioskeha Belt +1,
    legs=Pummeler's Cuisses +3,
    feet=Sulev. Leggings +2,}

sets.precast.WS[Raging Fists] = {
    main=Karambit,
    ammo=Seeth. Bomblet +1,
    head=Agoge Mask +3,
    neck=War. Beads +2,
    left_ear=Brutal Earring,
    right_ear=Moonshade Earring,
    body=Argosy Hauberk +1,
    hands=Argosy Mufflers +1,
	left_ring=Regal Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20 Attack+20','STR+10','Double Attack+10',}},
    waist=Fotia Belt,
    legs=Pummeler's Cuisses +3,
    feet=Sulev. Leggings +2,}
	
	sets.precast.WS[Asuran Fists] = {
    main=Karambit,
    ammo=Knobkierrie,
    head={ name=Agoge Mask +3, augments={'Enhances Savagery effect',}},
    body=Pumm. Lorica +3,
    hands=Sulev. Gauntlets +2,
    legs={ name=Agoge Cuisses +3, augments={'Enhances Warrior's Charge effect',}},
    feet=Pumm. Calligae +3,
    neck=Fotia Gorget,
    waist=Fotia Belt,
    left_ear=Brutal Earring,
    right_ear={ name=Moonshade Earring, augments={'Attack+4','TP Bonus +250',}},
    left_ring=Regal Ring,
    right_ring=Epaminondas's Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%','Damage taken-5%',}},}

sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {ammo=Seething Bomblet +1,})

sets.precast.WS['Scourge'] = set_combine(sets.precast.WS['Metatron Torment'])

sets.precast.WS['Decimation'] = {
    ammo=Seeth. Bomblet +1,
    head={ name=Agoge Mask +3, augments={'Enhances Savagery effect',}},
    body={ name=Agoge Lorica +3, augments={'Enhances Aggressive Aim effect',}},
    hands=Sulev. Gauntlets +2,
    legs=Pumm. Cuisses +3,
    feet=Pumm. Calligae +3,
    neck=Fotia Gorget,
    waist=Fotia Belt,
    left_ear=Cessance Earring,
    right_ear=Brutal Earring,
    left_ring=Hetairoi Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20 Attack+20','STR+10','Dbl.Atk.+10',}},}

sets.precast.WS['Cloudsplitter'] = {    ammo=Seeth. Bomblet +1,
    head=Volte Salade,
    body={ name=Agoge Lorica +3, augments={'Enhances Aggressive Aim effect',}},
    hands={ name=Leyline Gloves, augments={'Accuracy+12','Mag. Acc.+14','Mag.Atk.Bns.+15','Fast Cast+2',}},
    legs={ name=Eschite Cuisses, augments={'Mag.Atk.Bns.+25','Conserve MP+6','Fast Cast+5',}},
    feet=Flam. Gambieras +2,
    neck=Sanctity Necklace,
    waist=Eschan Stone,
    left_ear=Halasz Earring,
    right_ear=Friomisi Earring,
    left_ring=Regal Ring,
    right_ring=Flamma Ring,
    back={ name=Cichol's Mantle, augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','Dbl.Atk.+10','Damage taken-5%',}},}

sets.precast.WS['Impulse Drive'] = {
    main=Shining One,
    sub=Utu Grip,
    ammo=Yetshila +1,
    head={ name=Agoge Mask +3, augments={'Enhances Savagery effect',}},
    body=Pumm. Lorica +3,
    hands=Flam. Manopolas +2,
    legs=Agoge Cuisses +3,
    feet=Boii Calligae +1,
    neck=War. Beads +2,
    waist=Ioskeha Belt +1,
    left_ear=Ishvara Earring,
    right_ear={ name=Moonshade Earring, augments={'Attack+4','TP Bonus +250',}},
    left_ring=Regal Ring,
    right_ring=Niqmaddu Ring,
    back={ name=Cichol's Mantle, augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%','Damage taken-5%',}},}

-- Mighty Strikes WS Set --
sets.MS_WS = {feet=Boii Calligae +1}
end
 
-- Job-specific hooks for standard casting events.
function job_midcast(spell, action, spellMap, eventArgs)
 
end
 
-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
 
end
 
function display_current_job_state(eventArgs)
local msg = 'Melee'
if state.HybridMode.value ~= 'Normal' then
msg = msg .. '' .. state.HybridMode.value
end
end
 
 function pretarget(spell,action)
	if spell.action_type == 'Magic' and buffactive.silence then -- Auto Use Echo Drops If You Are Silenced --
		cancel_spell()
		send_command('input item Echo Drops me')
	elseif spell.english == Berserk and buffactive.Berserk then -- Change Berserk To Aggressor If Berserk Is On --
		cancel_spell()
		send_command('Aggressor')
	elseif spell.english == Seigan and buffactive.Seigan then -- Change Seigan To Third Eye If Seigan Is On --
		cancel_spell()
		send_command('ThirdEye')
	elseif spell.english == Meditate and player.tp  2900 then -- Cancel Meditate If TP Is Above 2900 --
		cancel_spell()
		add_to_chat(123, spell.name .. ' Canceled ['..player.tp..' TP]')
	elseif spell.type == 'WeaponSkill' and player.status == 'Engaged' then
		if spell.english ~= 'Bora Axe' and spell.name ~= 'Mistral Axe' and spell.target.distance  target_distance then -- Cancel WS If You Are Out Of Range --
			cancel_spell()
			add_to_chat(123, spell.name..' Canceled [Out of Range]')
			return
		end
	end
end
 
function update_combat_form()
-- Check Weapontype
    if GAX_weaponscontains(player.equipment.main) then
    state.CombatFormset('GAX')
elseif 
    GSD_weaponscontains(player.equipment.main) then
    state.CombatFormset('GSD')
elseif
    Pole_weaponscontains(player.equipment.main) then
    state.CombatFormset('Pole')
elseif
    Shield_weaponscontains(player.equipment.sub) then
    state.CombatFormset('Shield')
elseif
    DWaxe_weaponscontains(player.equipment.sub) then
    state.CombatFormset('DWaxe')
elseif
    DW_weaponscontains(player.equipment.sub) then
    state.CombatFormset('DW')
elseif
    H2H_weaponscontains(player.equipment.main) then
    state.CombatFormset('H2H')	
	else
    state.CombatFormreset()
    end
	
end
 
 function midcast(spell,action)
	if spell.action_type == 'Magic' then
		if spell.englishstartswith('Utsusemi') then
			if spell.english == 'Utsusemi Ichi' and (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']) then -- Cancel Copy Image 1, 2 & 3 For Utsusemi Ichi --
				send_command('@wait 1.7;cancel Copy Image')
			end
			equip(sets.Midcast.Haste)
		elseif spell.english == 'Monomi Ichi' then -- Cancel Sneak --
			if buffactive['Sneak'] then
				send_command('@wait 1.7;cancel sneak')
			end
			equip(sets.Midcast.Haste)
		else
			equip(sets.Midcast.Haste)
		end
	end
end
 
function job_self_command(cmdParams, eventArgs)
command = cmdParams[1]lower()
if command=='mainweapon' then
enable('main','sub')
mainswap=1
send_command('gs c cycle mainweapon')
end
end
 
function job_update(cmdParams, eventArgs)
update_combat_form()
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
update_combat_form()
end
 
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
moonshade_WS = S{Resolution, Torcleaver, Savage Blade}
 
function job_post_precast(spell, action, spellMap, eventArgs)
--if spell.type == 'WeaponSkill' then
--if world.time = (1760) or world.time = (760) then
--equip({ear1=Lugra Earring +1,ear2=Lugra Earring})
--end
if moonshade_WScontains(spell.english) and player.tp2950 then 
equip({ear1=Moonshade Earring})
end
--if buffactive['Mighty Strikes'] then 
--if sets.precast.WS[spell] then
--equipSet = sets.precast.WS[spell]
--equipSet = set_combine(equipSet,sets.MS_WS)
--equip(equipSet)
--else
--equipSet = sets.precast.WS
--equipSet = set_combine(equipSet,sets.MS_WS)
--equip(equipSet)
--end
--end
--end
end
 
function customize_idle_set(idleSet)
if mainswap then
mainswap=0
enable('main','sub')
equip(sets.mainweapon[state.mainweapon.value])
disable('main','sub')
end
if player.mpp  51 then
return set_combine(idleSet, sets.latent_refresh)
end
if state.Buff.Doom or state.Buff.Curse then
return set_combine(idleSet, sets.Doom)
else
return idleSet
end
end
 
function customize_melee_set(meleeSet)
if mainswap then
mainswap=0
enable('main','sub')
equip(sets.mainweapon[state.mainweapon.value])
disable('main','sub')
end
if state.Buff.Aftermath then
return set_combine(meleeSet, sets.Aftermath)
end
if state.Buff.Doom then
return set_combine(meleeSet, sets.Doom)
end
if state.Buff.Curse then
return set_combine(meleeSet, sets.Curse)
else
return meleeSet
end
end
 
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
-- Default macro setbook
if player.sub_job == 'SAM' then
set_macro_page(2, 3)
elseif player.sub_job == 'NIN' then
set_macro_page(1, 3)
elseif player.sub_job == 'DRG' then
set_macro_page(5, 3)
elseif player.sub_job == 'DNC' then
set_macro_page(3, 3)
elseif player.sub_job == 'MNK' then
set_macro_page(6, 3)
else
set_macro_page(1, 3)
end
end
