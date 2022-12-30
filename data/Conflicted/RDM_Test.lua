






require("no_interruptions")

function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function user_setup()
    state.OffenseMode:options('Hybrid', 'DD', 'DT')
    state.HybridMode:options()
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Pull', 'DT','Refresh')
 
  
end

function init_gear_sets()

    --Precast Sets

sets.precast.FC = {main={ name="Grioavolr", augments={'INT+8','Mag. Acc.+30','"Mag.Atk.Bns."+26','Magic Damage +3',}},
    sub="Mensch Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body="Zendik Robe",
    hands={ name="Chironic Gloves", augments={'VIT+3','INT+3','"Refresh"+1',}},
    legs="Aya. Cosciales +1",
    feet={ name="Chironic Slippers", augments={'MND+10','Rng.Atk.+24','"Fast Cast"+6','Accuracy+20 Attack+20',}},
    neck="Loricate Torque +1",
    waist="Channeler's Stone",
    left_ear="Thureous Earring",
    right_ear="Flashward Earring",
    left_ring="Stikini Ring +1",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}

    --Midcast Sets
   
    --Engaged Sets
	
	--

end