--First Lua Project. Red Mage.

--Main Point is to seperate all spells and JAs so that you can use gear enhancing equip for all Spells/Abilities that are Avaliable.
  -- AKA, Phalanx, Aquaveil, SS, Drain, Aspir, MNDenfeebles, INTEnfeebles, All WS mods, High/Mid/Lower Tier Spells, 
  
--Sets to put in

function get_sets()

sets.precast = {}
sets.midcast = {}
sets.aftercast = {}

----------------Precast--------------------Precast--------------------Precast-------------------------

sets.precast.fc = {head="Befouled Crown"}

------------------Midcast------------------Midcast------------------Midcast---------------------------

sets.midcast.EnhancingDuration = {head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +9',}},
    hands={ name="Telchine Gloves", augments={'Potency of "Cure" effect received+3%','Enh. Mag. eff. dur. +9',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +9',}}}
	
sets.midcast.phalanx = {head="Befouled Crown",
    body={ name="Witching Robe", augments={'MP+35',}},
    hands={ name="Merlinic Dastanas", augments={'Pet: AGI+6','"Avatar perpetuation cost" -1','"Refresh"+1','Accuracy+16 Attack+16','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
    legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
    feet={ name="Merlinic Crackows", augments={'"Fast Cast"+3','Pet: "Subtle Blow"+7','Phalanx +5','Accuracy+17 Attack+17',}}}
	
sets.midcast.
	
-----------------Aftercast----------------Aftercast------------------Aftercst-------------------------

sets.aftercast.idle = {main="Bolelabunga",
    sub="Genbu's Shield",
    ammo="Strobilus",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands={ name="Merlinic Dastanas", augments={'Pet: AGI+6','"Avatar perpetuation cost" -1','"Refresh"+1','Accuracy+16 Attack+16','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+10','Mag. Acc.+11','"Mag.Atk.Bns."+9',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Mag. crit. hit dmg. +7%','INT+10','Mag. Acc.+10',}},
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+36%','MND+2','"Mag.Atk.Bns."+5','DEF+5',}}}
	
sets.aftercast.engaged = {main="Bolelabunga",
    sub="Genbu's Shield",
    ammo="Strobilus",
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands={ name="Merlinic Dastanas", augments={'Pet: AGI+6','"Avatar perpetuation cost" -1','"Refresh"+1','Accuracy+16 Attack+16','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','INT+10','Mag. Acc.+11','"Mag.Atk.Bns."+9',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Mag. crit. hit dmg. +7%','INT+10','Mag. Acc.+10',}},
    neck="Loricate Torque +1",
    waist="Fucho-no-Obi",
    left_ear="Etiolation Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Renaye Ring",
    right_ring="Defending Ring",
    back={ name="Mecisto. Mantle", augments={'Cap. Point+36%','MND+2','"Mag.Atk.Bns."+5','DEF+5',}}}
	
end

function precast(spell)
	if spell.type:contains('Magic') then
		equip(sets.precast.fc)
	end 
end

function midcast(spell)

	if spell.english == 'Phalanx' then
	equip(sets.midcast.phalanx)
	end
	if spell.english == "Haste" then
	equip(sets.midcast.EnhancingDuration)
	end
end

function aftercast(spell)

	if player.status == "Engaged" then
		equip(sets.aftercast.engaged)
	elseif player.status == "Idle" then
		equip(sets.aftercast.idle)
	end

end