----------------------------_______  _______  ______     _______  _______  _______  _______ ---------------------
---------------------------(  ____ )(  ____ \(  __  \   (       )(  ___  )(  ____ \(  ____ \---------------------
---------------------------| (    )|| (    \/| (  \  )  | () () || (   ) || (    \/| (    \/---------------------
---------------------------| (____)|| (__    | |   ) |  | || || || (___) || |      | (__    ---------------------
---------------------------|     __)|  __)   | |   | |  | |(_)| ||  ___  || | ____ |  __)   ---------------------
---------------------------| (\ (   | (      | |   ) |  | |   | || (   ) || | \_  )| (      ---------------------
---------------------------| ) \ \__| (____/\| (__/  )  | )   ( || )   ( || (___) || (____/\---------------------
---------------------------|/   \__/(_______/(______/   |/     \||/     \|(_______)(_______/---------------------
-----------------------------------------------------------------------------------------------------------------
	--Nuance~Asura--Erupt~Asura--				
	-------------------------------------------------------------------------------------------------------------
	--Recommended additional add-ons not officially supported by Windower.
	--Anchor https://github.com/svanheulen/anchor-windower-addon
	--React https://github.com/SammehFFXI/FFXIAddons/tree/master/React
	--Keep in mind they are not supported for a reason. That said, they are very useful in a plethora of fights.
	-------------------------------------------------------------------------------------------------------------
	--If you're new to gearswap, the F1-F12 keys and CTRL/ALT/WIN keys in combination is how you cycle the sets.
	-------------------------------------------------------------------------------------------------------------
	--F9 = Cycle OffenseMode
	--F10 = Equips and locks PDT
	--F11 = Equips and locks MDT
	--F12 = Refreshes and shows current sets in use
	-------------------------------------------------------------------------------------------------------------
	--ALT+F1 = Auto WS ON/OFF (WS used is as defined later in a weapon table.)
	--ALT+F2 = Cycle Magic Burst Accuracy Modes
	--ALT+F3 = Equips and locks Bow/Ammo, used for multi stepping skillchains or having the fat magic accuracy from Ambuscade bow always on. (Default ammo is Demon Arrows, you can change this.)	
	--ALT+F4 = Turns burst mode off completely.
	-------------------------------------------------------------------------------------------------------------
	--ALT+F10 = Cycle Back WeaponMode
	--ALT+F11 = Cycle Forward WeaponMode
	--ALT+F12 = Unlocks gear from being locked into PDT/MDT via the F10/F11 Keys as mentioned above.
	-------------------------------------------------------------------------------------------------------------
	--CTRL+F9 = Hybrid Modes-Not in use.
	--CTRL+F10 = Defense Modes-Not in use.
	--CTRL+F11 = Cycle CastingMode
	--CTRL+F12 = Cycle IdleMode
	-------------------------------------------------------------------------------------------------------------
	--Keybinds (! = ALT / @ = WIN / ^ = CTRL)
	--Specific to activating a few consumables/items or Job Abilities.
	send_command('bind !c input /p Converting!;input /ja "Convert" <me>;wait 1;input /ma "Cure IV" <me>')
	send_command('bind @s input /ja "Saboteur" <me>')
	send_command('bind @e input /item "Echo Drops" <me>')
	send_command('bind @r input /item "Remedy" <me>')
	send_command('bind @p input /item "Panacea" <me>')
	send_command('bind @h input /item "Holy Water" <me>')
	send_command('bind !w input /equip ring2 "Warp Ring"; /echo Warping; wait 11; input /item "Warp Ring" <me>;')
	send_command('bind !q input /equip ring2 "Dim. Ring (Holla)"; /echo Reisenjima; wait 11; input /item "Dim. Ring (Holla)" <me>;')
	-------------------------------------------------------------------------------------------------------------
	--Specific to toggling combat/casting modes.
	send_command('bind !f2 gs c cycle burstmode')
	send_command('bind !f4 gs c set BurstMode None')
	send_command('bind !f11 gs c WeaponMode')
	send_command('bind !f10 gs c WeaponMode reverse')
	send_command('bind !f3 gs c RangeMode')
	-------------------------------------------------------------------------------------------------------------
	--Remember to add an unbind your keybinds in the event you add more!
	-------------------------------------------------------------------------------------------------------------
function user_unload()
    send_command('unbind !c')
    send_command('unbind @s')	
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind @p')
    send_command('unbind @h')
    send_command('unbind !w')
    send_command('unbind !q')	
    send_command('unbind !f2')	
    send_command('unbind !f4')
    send_command('unbind !f11')
    send_command('unbind !f10')
    send_command('unbind !f3')	
end
	-------------------------------------------------------------------------------------------------------------
	--If you dont like the text colors of the HUD you can change the RGB codes below.
	-------------------------------------------------------------------------------------------------------------
gearswap_box = function()
  str = '           \\cs(255,0,0)RED MAGE\\cr\n'
  str = str..'Weapon Mode:\\cs(255,0,0)	   '..state.WeaponMode.current..'\\cr\n'
  str = str..'          Auto WS:\\cs(204,23,99)   '
  if autotp then
	str = str..'On\\cr\n'
  else
    str = str..'Off\\cr\n'
  end
  str = str..'	 Ranged Mode:\\cs(255,128,0)   '..state.RangeMode.current..'\\cr\n'
  str = str..' Offense Mode:\\cs(255,255,0)   '..state.OffenseMode.current..'\\cr\n'
  str = str..'Defense Mode:\\cs(128,255,0)   '..state.DefenseMode.current..'\\cr\n'
  str = str..' Casting Mode:\\cs(0,182,49)   '..state.CastingMode.current..'\\cr\n'
  str = str..'     Burst Mode:\\cs(0,255,128)   '..state.BurstMode.current..'\\cr\n'
  str = str..'       Idle Mode:\\cs(255,0,255)   '..state.IdleMode.current..'\\cr\n'
  return str
end
	-------------------------------------------------------------------------------------------------------------
	--Likely will need to change the X & Y below to adjust the position of the on screen HUD for your screen.
	-------------------------------------------------------------------------------------------------------------
gearswap_box_config = {pos={x=757,y=540},padding=8,text={font='Segoe UI Symbol',size=12,Fonts={'sans-serif'},},bg={alpha=100},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('organizer-lib')
end
function job_setup()
    state.Buff.Saboteur = buffactive.saboteur or false
end
	-------------------------------------------------------------------------------------------------------------
	-- I use multiple weapons in various combinations to achieve what I want.
	-- You will nee to alter them according to your needs via state.WeaponMode:options and sets.engaged further down.
	-------------------------------------------------------------------------------------------------------------
function user_setup()
    state.OffenseMode:options('None','Fencer','DW','DWacc')
    state.CastingMode:options('Normal','Mid','High')
    state.IdleMode:options('Normal')
	-------------------------------------------------------------------------------------------------------------
	--Combinations of weapons are put in no more than 6 letters as they are shown in the HUD as such and we want a clean look!
	--Comment out any you do not wish to use. You don't need to comment them out in the engaged sets further down it will just skip over them if commented out here.
	-------------------------------------------------------------------------------------------------------------
	state.WeaponMode = M{['description'] = 'Weapon Mode'}
	state.WeaponMode:options(
	'Normal', --Unlocks main and sub slots.
	'MurShd', --Murgleis / Ammurapi Shield
	'CroShd', --Crocea Mors / Ammurapi Shield
--	'ClbShd', --Maxentius / Ammurapi Shield
--	'SeqShd', --Sequence / Sacro Bulwark
	'ExcShd', --Excalibur / Sacro Bulwark
	'MurDag', --Murgleis / Tauret
	'SeqDag', --Sequence / Tauret
--	'NaeThi', --Naegling / Machaera +2
	'AlmDag', --Almace / Tauret
	'CroDag', --Crocea Mors / Tauret
--	'DagDag', --Tauret / Ternion Dagger +1
	'DagAlm', --Tauret / Almace
--	'ClbDag', --Maxentius / Tauret
	"CroDay", --Crocea Mors / Daybreak
	"H2H")    --Kaja Knuckles
	
	state.RangeMode = M{['description'] = 'Ranged Mode'}
	state.RangeMode:options('Off','On')	
	state.BurstMode = M{['description'] = 'Burst Mode'}
	state.BurstMode:options('None','Normal','Mid','High')

	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()

	element_table = L{'Earth','Wind','Ice','Fire','Water','Lightning'}
    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II'}
    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Firega'] = {'Firaga'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Icega'] = {'Blizzaga'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Windga'] = {'Aeroga','Aeroga II'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Earthga'] = {'Stonega','Stonega II'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Lightningga'] = {'Thundaga'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Waterga'] = {'Waterga','Waterga II'},
        ['Aspirs'] = {'Aspir'},
        ['Sleepgas'] = {'Sleepga'}}
		
    select_default_macro_book()
end

function init_gear_sets()
	-------------------------------------------------------------------------------------------------------------
	--Your augments gear will be different then mine, edit accordingly! Utilize the //gs export function of GS and copy/paste!
	-------------------------------------------------------------------------------------------------------------
	Grioavolr = {}
	Grioavolr.ENF = {}
    Grioavolr.ENF = {name="Grioavolr", augments={'Enfb.mag. skill +16','MND+13','Mag. Acc.+23'}}
	Grioavolr.NUKE = {name="Grioavolr", augments={'"Conserve MP"+4','Mag. Acc.+26','"Mag.Atk.Bns."+29'}}

    Colada = {}
	Colada.ENH = {}
    Colada.ENH = {name="Colada", augments={'Enh. Mag. eff. dur. +4','Mag. Acc.+2','"Mag.Atk.Bns."+4','DMG:+1'}}
	Colada.Idle = {}
	
	Crocea = {}
	Crocea.A = {} 
	Crocea.B = {}
	Crocea.C = {}
	
	Sucellos = {}
	Sucellos.ENF = {}
	Sucellos.ENF = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10'}}
	Sucellos.NUKE = {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10'}}
	Sucellos.TP = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%'}}
	Sucellos.TP2 = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%'}}
	Sucellos.CDC = {name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10'}}
	Sucellos.SB = {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	Sucellos.REQ = {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}
	Sucellos.Idle = {name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','System: 1 ID: 1158 Val: 4'}}
	Sucellos.EleWS = {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%'}}
	Sucellos.Empyreal = {name="Sucellos's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%'}}
	Sucellos.Sanguine = {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%'}}
	Sucellos.BlackHalo = {name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%'}}
	Sucellos.Enmity = {name="Sucellos's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5'}}
	Sucellos.DNC = {}
	Sucellos.PreShot = {}
	Sucellos.MidShot = {}
	
	TelHead = {}
	TelHead.ENH = {}
	TelHead.ENH = {name="Telchine Cap", augments={'Enmity-5','Enh. Mag. eff. dur. +10'}}
	TelHead.REG = {name="Telchine Cap", augments={'Regen Potency +3'}}
    
	TelBody = {}
	TelBody.ENH = {}
    TelBody.REG = {name="Telchine Chasuble", augments={'Regen Potency +3'}}
	
	TelHands = {}
	TelHands.ENH = {}
    TelHands.REG = {name="Telchine Gloves", augments={'Regen Potency +3'}}
	
	TelLegs = {}
	TelLegs.ENH = {}
	TelLegs.ENH = {name="Telchine Braconi", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +10'}}
    TelLegs.REG = {name="Telchine Braconi", augments={'Regen Potency +3'}}
	
	TelFeet = {}
	TelFeet.ENH = {}
	TelFeet.REG = {name="Telchine Pigaches", augments={'Regen Potency +3'}}
	
	--Job Ability Precast 
    sets.precast.JA['Chainspell'] = {body="Vitiation Tabard +3"}
    sets.precast.JA['Convert'] = {main="Murgleis"}
	
	--Magic Precast
	--FAST CAST (Personally I do not to use Quick Magic. If you're a fan it caps at 10%.)
	--30% at level 89.
	--8% at 2000 Job Points.
	--42% to cap.
    sets.precast.FC = {
	ammo="Staunch Tathlum +1",
	head="Atrophy Chapeau +3", --16%
	neck="Loricate Torque +1",
	ear2="Genmei Earring",
	ear1="Etiolation Earring", --1%
	body="Vitiation Tabard +3", -- 15%
	hands="Atrophy Gloves +3",
	ring1="Gelatinous Ring +1",
	ring2="Defending Ring",
	back=Sucellos.ENF, -- 10%
	waist="Flume Belt +1",
	legs="Ayanmo Cosciales +2", -- 6%
	feet="Ayanmo Gambieras +2"}
	--TOTAL FC = 86% (Legs only worn for the DT-)

	--20% Crocea Mors (Will only call on this set when Crocea Mors is in the main hand.)
	--30% at level 89
	--8% at 2000 Job Points.
	--22% to cap.
	sets.precast.FC['Crocea Mors'] = {
	ammo="Staunch Tathlum +1",
	head="Atrophy Chapeau +3", --16%
	neck="Loricate Torque +1",
	ear2="Sacro Bulwark",
	ear1="Etiolation Earring", --1%
	body="Ayanmo Corazza +2",
	hands="Malignance Gloves",
	ring1="Gelatinous Ring +1",
	ring2="Defending Ring",
	back=Sucellos.ENF,
	waist="Flume Belt +1",
	legs="Malignance Tights",
	feet="Ayanmo Gambieras +2"}
	-- TOTAL FC = 85%
	
	--YOU'RE A RDM. YOU DON'T NEED THIS UNLESS YOU ABSOLUTLY NEED THE CAST TIME REDUCTION!	
--	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    
	--SEE ABOVE.	
--	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {head="Umuthi Hat", hands="Carapacho Cuffs", legs="Doyen Pants"})

	--IMPACT. HEAD HAS TO BE SHUT OFF AND BODY LOCKED, THIS CUTS OFF A TON OF YOUR BEST FASTCAST EQUIPMENT.	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
	sets.precast['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak",sub="Ammurapi Shield"})
	
	--Precast Weaponskill
	--DEFAULT WS SET 
	--CDC/Evisceration/Anything undefined. (DEX/CRIT)
	sets.precast.WS = {
	ammo="Yetshila +1",
	head="Jhakri Coronal +2",
	neck="Fotia Gorget",
	ear2="Mache Earring +1",
	ear1="Mache Earring +1",
	body="Ayanmo Corazza +2",
	hands="Jhakri Cuffs +2",
	ring2="Ilabrat Ring",
	ring1="Begrudging Ring",
	back=Sucellos.CDC,
	waist="Fotia Belt",
	legs="Vitiation Tights +3",
	feet="Thereoid Greaves"}
		
	--SAVAGE BLADE (STR/MND/WSD+/ATTK)
	sets.precast.WS['Savage Blade'] = {
	ammo="Regal Gem",
	head="Vitiation Chapeau +3",
	neck="Duelist's Torque +2",
	ear1="Moonshade Earring",
	ear2="Ishvara Earring",
	body="Vitiation Tabard +3",
	hands="Atrophy Gloves +3",
	ring1="Karieyh Ring",
	ring2="Epaminondas's Ring",
	back=Sucellos.SB,
	waist="Grunfeld Rope",
	legs="Jhakri Slops +2",
	feet="Chironic Slippers"}
		
	--DEATH BLOSSOM (STR/MND/WSD+/ATTK)
	sets.precast.WS['Death Blossom'] = {
	ammo="Regal Gem",
	head="Vitiation Chapeau +3",
	neck="Duelist's Torque +2",
	ear1="Moonshade Earring",
	ear2="Ishvara Earring",
	body="Vitiation Tabard +3",
	hands="Atrophy Gloves +3",
	ring1="Karieyh Ring",
	ring2="Epaminondas's Ring",
	back=Sucellos.SB,
	waist="Grunfeld Rope",
	legs="Jhakri Slops +2",
	feet="Chironic Slippers"}
		
	--REQUIESCAT (STR/MND/ACC/ATTCK/MultiATTCK)	
	sets.precast.WS['Requiescat'] = {
	ammo="Regal Gem",
	head="Jhakri Coronal +2",
	neck="Fotia Gorget",
	ear1="Moonshade Earring",
	ear2="Sherida Earring",
	body="Jhakri Robe +2",
	hands="Jhakri Cuffs +2",
	ring1="Shukuyu Ring",
	ring2="Rufescent Ring",
	back=Sucellos.SB,
	waist="Fotia Belt",
	legs="Jhakri Slops +2",
	feet="Jhakri Pigaches +2"}

	--RED LOTUS BLADE
	--SHINING BLADE	
	--SERAPH BLADE 
	--BURNING BLADE
	--(STR/MND/INT/MAB/MACC/WSD+/TP BONUS+/LIGHT-AFFINITY for Shining & Seraph/MND trumps INT with Crocea Mors.)
	sets.precast.WS['Red Lotus Blade'] = {
	ammo="Pemphredo Tathlum",
	head="Jhakri Coronal +2",
	neck="Baetyl Pendant",
	ear1="Malignance Earring",
	ear2="Moonshade Earring",
	body="Amalric Doublet +1",
	hands="Jhakri Cuffs +2",
	ring1="Epaminondas's Ring",
	ring2="Freke Ring",
	back=Sucellos.Sanguine,
	waist="Orpheus's Sash",
	legs="Amalric Slops +1",
	feet="Amalric Nails +1"}

	sets.precast.WS['Burning Blade'] = set_combine(sets.precast.WS['Red Lotus Blade'])
		
	sets.precast.WS['Shining Blade'] = set_combine(sets.precast.WS['Red Lotus Blade'], {ring2="Weatherspoon Ring"})
	
	sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Shining Blade'])
	
	sets.precast.WS['Seraph Strike'] = set_combine(sets.precast.WS['Shining Blade'])	

	sets.precast.WS['Seraph Shining'] = set_combine(sets.precast.WS['Shining Blade'])
	
	--AEOLIAN EDGE (AGI/INT/MAB/MACC/WSD+/TP BONUS+)	
    sets.precast.WS['Aeolian Edge'] = {
	ammo="Pemphredo Tathlum",
	head="Jhakri Coronal +2",
	neck="Baetyl Pendant",
	ear1="Malignance Earring",
	ear2="Moonshade Earring",
	body="Amalric Doublet +1",
	hands="Jhakri Cuffs +2",
	ring1="Epaminondas's Ring",
	ring2="Karieyh Ring",
	back=Sucellos.EleWS,
	waist="Orpheus's Sash",
	legs="Amalric Slops +1",
	feet="Amalric Nails +1"}
	
	--SANGUINE BLADE (STR/MND/MND/DARK-AFFINITY+/MAB/WSD+/MACC/MND trumps INT with Crocea Mors.)	
    sets.precast.WS['Sanguine Blade'] = {
	ammo="Pemphredo Tathlum",
	head="Pixie Hairpin +1",
	neck="Baetyl Pendant",
	ear1="Malignance Earring",
	ear2="Regal Earring",
	body="Amalric Doublet +1",
	hands="Jhakri Cuffs +2",
	ring1="Archon Ring",
	ring2="Epaminondas's Ring",
	back=Sucellos.Sanguine,
	waist="Orpheus's Sash",
	legs="Amalric Slops +1",
	feet="Amalric Nails +1"}
	
	--Empyreal Arrow (AGI/RACC/WSD+/RATTK/WSACC/We aren't RNG so stack accordingly.)
	sets.precast.WS['Empyreal Arrow'] = {
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Gaudryi Necklace",
    waist="Yemaya Belt",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    left_ring="Karieyh Ring",
    right_ring="Epaminondas's Ring",
    back=Sucellos.Empyreal}

	--Black Halo (STR/MND/ATTK/MultiATTCK/MND is the clear winner over STR here.)
	sets.precast.WS['Black Halo'] = {
	ammo="Regal Gem",
	head="Vitiation Chapeau +3",
	neck="Duelist's Torque +2",
	ear1="Moonshade Earring",
	ear2="Ishvara Earring",
	body="Vitiation Tabard +3",
	hands="Atrophy Gloves +3",
	ring1="Rufescent Ring",
	ring2="Epaminondas's Ring",
	back=Sucellos.BlackHalo,
	waist="Luminary Sash",
	legs="Vitiation Tights +3",
	feet="Chironic Slippers"}
	
	--Asuran Fists (STR/VIT/ACC/ATTK/We aren't MNK you would do better using a club for blunt. But this is fun regardless.)
	sets.precast.WS['Asuran Fists'] = {
	ammo="Ginsen",
	head="Vitiation Chapeau +3",
	neck="Sanctity Necklace",
	ear1="Mache Earring +1",
	ear2="Mache Earring +1",
	body="Vitiation Tabard +3",
	hands="Atrophy Gloves +3",
	ring1="Rufescent Ring",
	ring2="Ilabrat Ring",
	back=Sucellos.SB,
	waist="Grunfeld Rope",
	legs="Vitiation Tights +3",
	feet="Jhakri Pigaches +2"}

	--Midcast
	--I HAVE NO IDEA WHAT THIS EVEN DOES. I assume it's the set all undefined magic falls into.
    sets.midcast.FastRecast = {
	ammo="Staunch Tathlum +1",
	head="Atrophy Chapeau +3",
	neck="Loricate Torque +1",
	ear2="Genmei Earring",
	ear1="Etiolation Earring",
	body="Vitiation Tabard +3",
	hands="Atrophy Gloves +3",
	ring1="Gelatinous Ring +1",
	ring2="Defending Ring",
	back=Sucellos.ENF,
	waist="Flume Belt +1",
	legs="Ayanmo Cosciales +2",
	feet="Ayanmo Gambieras +2"}
	
	--CURE SPECIFIC		
    sets.midcast.Cure = {
	main="Bolelabunga",
	sub="Ammurapi Shield",
	ammo="Regal Gem",
	head="Kaykaus Mitra +1",
    body="Kaykaus Bliaut +1",
	neck="Incanter's Torque",
	hands="Kaykaus Cuffs +1",
	ring2="Janniston Ring",
	ring1="Sirona's Ring",
	ear1="Beatific Earring",
	ear2="Regal Earring",
	back=Sucellos.Idle,
	waist="Luminary Sash",
	legs="Kaykaus Tights +1",
	feet="Kaykaus Boots +1"}
 
	--CURAGA SPECIFIC (/WHM)
    sets.midcast.Curaga = sets.midcast.Cure
	
	--CURE WHEN AURORASTORM IS ON	
	sets.midcast.CureWeather = set_combine(sets.midcast['Cure'], {main="Chatoyant Staff",waist="Hachirin-No-Obi",back="Twilight Cape"})
    
	--CURE ON YOURSELF
	sets.midcast.CureMe = set_combine(sets.midcast['Cure'], {ring1="Kunaji Ring", neck="Phalaina Locket", waist="Gishdubar Sash"})
	
	--ONLY WORKS WITH react.lua ti'll I figure the shit out.
	sets.CureRec = {ring1="Kunaji Ring", neck="Phalaina Locket", waist="Gishdubar Sash"}
	
	--GENERAL USE ENHANCING DURATION (Spells that do not scale with skill+)	
    sets.midcast['Enhancing Magic'] = {
	main=Colada.ENH,
	sub="Ammurapi Shield",
    head=TelHead.ENH,
	neck="Duelist's Torque +2",
	ear1="Andoaa Earring",
	ear2="Augmenting Earring",
    body="Vitiation Tabard +3",
	hands="Atrophy Gloves +3",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
    back="Ghostfyre Cape",
	waist="Olympus Sash",
	legs=TelLegs.ENH,
	feet="Lethargy Houseaux +1"}

	--REFRESH SPECIFIC
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
	head="Amalric Coif +1", 
	body="Atrophy Tabard +3", 
	waist="Gishdubar Sash", 
	legs="Lethargy Fuseau +1"})

	--AQUAVEIL SPECIFIC	
	sets.midcast.Aquaveil = {}
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
	ammo="Staunch Tathlum +1",
	head="Amalric Coif +1",
	neck="Loricate Torque +1",
	ear1="Genmei Earring",
	ear2="Etiolation Earring",
	body="Rosette Jaseran +1",
	hands="Regal Cuffs",
	ring1="Ayanmo Ring",
	ring2="Defending Ring",
	back="Sucellos's Cape",
	waist="Emphatikos Rope",
	legs="Shedir Seraweels",
	feet="Amalric Nails +1"})
	
	--AQUAVEIL CURRENTLY UP
	sets.midcast.Aquaveil.up = set_combine(sets.midcast['Enhancing Magic'], {
	head="Amalric Coif +1",
	hands="Regal Cuffs",
	legs="Shedir Seraweels",
	waist="Emphatikos Rope"})
	
	--STONESKIN SPECIFIC (Potency is capped even naked gear shown enhances that cap, maybe use DT in additional slots.)
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
--	main="Pukulatmuj +1",
	ear2="Earthcry Earring", --+10
	neck="Nodens Gorget", --+30
	waist="Siegel Sash", --+20
	hands="Stone Mufflers", --+30
	legs="Shedir Seraweels"}) --+35
																			
	--CURSNA SPECIFIC (/WHM or /SCH In Light Arts only.)																			
	sets.midcast.Cursna = {
	main="Prelatic Pole",
	sub="Curatio Grip",
	head="Vanya Hood",
	ear1="Beatific Earring",
	ear2="Healing Earring",
	body="Vitiation Tabard +3",
--	hands="Hieros Mittens",
	neck="Debilis Medallion",
	ring1="Menelaus's Ring",
	ring2="Haoma's Ring",
	back="Oretania's Cape +1",
	waist="Bishop's Sash",
	legs="Vanya Slops",
	feet="Gendewitha Galoshes +1"}
		
	--ENHANCING MAGIC SKILL +++++		
	sets.ENH = {
	main="Pukulatmuj +1",
	sub="Arendsi Fleuret",
	ammo="Impatiens",
	head="Befouled Crown",
	body="Vitiation Tabard +3",
	neck="Incanter's Torque",
	hands="Vitiation Gloves +3",
	ring2="Stikini Ring +1",
	ring1="Stikini Ring +1",
	ear1="Augmenting Earring",
	ear2="Andoaa Earring",
	back="Ghostfyre Cape",
	waist="Olympus Sash",
	legs="Atrophy Tights +3",
	feet="Lethargy Houseaux +1"}

	Tempers = S {'Temper','Temper II'}
	EnSpells = S {'Enfire','Enwater','Enthunder','Enstone','Enaero','Enblizzard'}
	EnSpell = sets.ENH
	GainSpells = S {'Gain-MND','Gain-INT','Gain-STR','Gain-DEX','Gain-AGI','Gain-VIT','Gain-CHR'}
	GainSpell = sets.ENH
	BarSpells = S {'Barwater','Barfire','Baraero','Barblizzard','Barstone','Barthunder'}
	BarSpell = set_combine(sets.ENH,{legs="Shedir Seraweels"})
	Obi_WeaponSkills = S {'Sanguine Blade',
						  'Red Lotus Blade',
						  'Burning Blade',
						  'Seraph Blade',
						  'Shining Blade',
						  'Aeolian Edge',
						  'Cyclone',
						  'Gust Slash',
						  'Energy Drain',
						  'Energy Steal',
						  'Flash Nova',
						  'Shining Strike',
						  'Seraph Strike'}

	--PHALANX SPECIFIC (/SCH AoE this set doesn't HELP anyone but you. - Anything over 500 enhancing skill doesn't help anyone.)		
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {
	main="Egeking",   
	head={name="Taeon Chapeau",augments={'Attack+19','Potency of "Cure" effect received+7%','Phalanx +3'}},
    body={name="Taeon Tabard",augments={'Potency of "Cure" effect received+2%','Phalanx +3'}},
    hands={name="Taeon Gloves",augments={'Potency of "Cure" effect received+3%','Phalanx +3'}},
    legs={name="Taeon Tights",augments={'Potency of "Cure" effect received+7%','Phalanx +3'}},
    feet={name="Chironic Slippers",augments={'Magic Damage +3','DEX+7','Phalanx +4','Accuracy+20 Attack+20'}}})
 
	--POTENCY (MND FOCUS) 
    sets.midcast['Enfeebling Magic'] = {
	main="Daybreak",
	sub="Ammurapi Shield",
	ammo="Regal Gem",
    head="Vitiation Chapeau +3",
	neck="Duelist's Torque +2",
	ear1="Malignance Earring",
	ear2="Regal Earring",
    body="Atrophy Tabard +3",
	hands="Kaykaus Cuffs +1",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
    back=Sucellos.ENF,
	waist="Luminary Sash",
	legs="Chironic Hose",
	feet="Vitiation Boots +3"}
		
	--DIA III SPECIFIC (TH+/POTENCY+DURATION)
    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {
	head="Vitiation Chapeau +3",
	body="Lethargy Sayon +1",
	ammo="Regal Gem",
--	hands="Regal Cuffs",
	ring1="Kishar Ring",
	hands="Merlinic Dastanas", --TH+2
	waist="Chaac Belt", --TH+1
	legs="Volte Hose"}) --TH+1
	
	--POTENCY+DURATION	
	sets.midcast['Inundation'] = set_combine(sets.midcast['Enfeebling Magic'], {
	head="Vitiation Chapeau +3", 
	body="Lethargy Sayon +1",
	hands="Regal Cuffs",
	ammo="Regal Gem",
	ring1="Kishar Ring"})

	--SLOW II SPECIFIC	
    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitiation Chapeau +3"})

	--NUKE NORMAL
	sets.midcast['Elemental Magic'] = {}
	
    sets.midcast['Elemental Magic'] = {
	main="Daybreak",
	sub="Ammurapi Shield",
	ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
	neck="Baetyl Pendant",
	ear1="Regal Earring",
	ear2="Malignance Earring",
    body="Amalric Doublet +1",
	hands="Amalric Gages +1",
	ring1="Freke Ring",
	ring2="Shiva Ring +1",
    back=Sucellos.NUKE,
	waist="Sacro Cord",
	legs="Amalric Slops +1",
	feet="Amalric Nails +1"}

	--NUKE MAGIC ACCURACY +		
	sets.midcast['Elemental Magic'].Mid = {
	main="Daybreak",
	sub="Ammurapi Shield",
	ammo="Pemphredo Tathlum",
    head="Jhakri Coronal +2",
	neck="Sanctity Necklace",
	ear1="Regal Earring",
	ear2="Malignance Earring",
    body="Amalric Doublet +1",
	hands="Amalric Gages +1",
	ring1="Freke Ring",
	ring2="Shiva Ring +1",
    back=Sucellos.NUKE,
	waist="Sacro Cord",
	legs="Amalric Slops +1",
	feet="Amalric Nails +1"}

	--NUKE MAGIC ACCURACY ++
	sets.midcast['Elemental Magic'].High = {
	main="Daybreak",
	sub="Enki Strap",
	ammo="Pemphredo Tathlum",
    head="Amalric Coif +1",
	neck="Sanctity Necklace",
	ear1="Regal Earring",
	ear2="Malignance Earring",
    body="Amalric Doublet +1",
	hands="Amalric Gages +1",
	ring1="Freke Ring",
	ring2="Shiva Ring +1",
    back=Sucellos.NUKE,
	waist="Sacro Cord",
	legs="Amalric Slops +1",
	feet="Vitiation Boots +3"}
	
	--NUKE BURST
	sets.midcast['Elemental Magic'].burst = {}
	
	sets.midcast['Elemental Magic'].burst.Normal = {
	main="Daybreak",
	sub="Ammurapi Shield",
	ammo="Pemphredo Tathlum",
    head="Ea Hat +1",
	neck="Mizukage-no-Kubikazari",
	ear2="Regal Earring",
	ear1="Malignance Earring",
    body="Ea Houppelande +1",
	hands="Amalric Gages +1",
	ring1="Locus Ring",
	ring2="Mujin Band",
    back=Sucellos.NUKE,
	waist="Sacro Cord",
	legs="Ea Slops +1",
	feet="Amalric Nails +1"}
	
	--NUKE BURST +
	sets.midcast['Elemental Magic'].burst.Mid = {
	main="Daybreak",
	sub="Ammurapi Shield",
	ammo="Pemphredo Tathlum",
    head="Ea Hat +1",
	neck="Mizukage-no-Kubikazari",
	ear2="Regal Earring",
	ear1="Malignance Earring",
    body="Ea Houppelande +1",
	hands="Ea Cuffs +1",
	ring1="Freke Ring",
	ring2="Mujin Band",
    back=Sucellos.NUKE,
	waist="Sacro Cord",
	legs="Ea Slops +1",
	feet="Vitiation Boots +3"}
	
	--NUKE BURST ++
	sets.midcast['Elemental Magic'].burst.High = {
	main="Daybreak",
	sub="Enki Strap",
	ammo="Pemphredo Tathlum",
    head="Atrophy Chapeau +3",
	neck="Mizukage-no-Kubikazari",
	ear2="Regal Earring",
	ear1="Malignance Earring",
    body="Ea Houppelande +1",
	hands="Regal Cuffs",	
--	hands="Ea Cuffs +1",
	ring1="Locus Ring",
	ring2="Mujin Band",
    back=Sucellos.NUKE,
	waist="Sacro Cord",
	legs="Ea Slops +1",
	feet="Vitiation Boots +3"}

	--BIO
    sets.midcast['Dark Magic'] = {
	main="Murgleis",
	sub="Ammurapi Shield",
	ammo="Ullr",
    head="Pixie Hairpin +1",
	neck="Erra Pendant",
	ear1="Regal Earring",
	ear2="Dignitary's Earring",
    body="Atrophy Tabard +3",
	hands="Atrophy Gloves +3",
	ring1="Archon Ring",
	ring2="Stikini Ring +1",
    back=Sucellos.ENF,
	waist="Sacro Cord",
	legs="Atrophy Tights +3",
	feet="Vitiation Boots +3"}

	--DRAIN/ASPIR		
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
	main="Rubicundity",
	waist="Fucho-no-Obi"})
	
    sets.midcast.Aspir = sets.midcast.Drain

	--MAGIC ACCURACY
	sets.midcast['Sleep'] = {
	main="Murgleis",
	sub="Ammurapi Shield",
	ranged="Ullr",
    head="Atrophy Chapeau +3",
	body="Atrophy Tabard +3",
	hands="Regal Cuffs",	
--	hands="Kaykaus Cuffs +1",
    legs="Chironic Hose",
	feet="Vitiation Boots +3",
	neck="Duelist's Torque +2",
	waist="Luminary Sash",
    ear1="Digni. Earring",
	ear2="Regal Earring",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
	back=Sucellos.ENF}

	sets.midcast['Sleep II'] = set_combine(sets.midcast['Sleep'])
	sets.midcast['Sleepga'] = set_combine(sets.midcast['Sleep'])
	sets.midcast['Blind'] = set_combine(sets.midcast['Sleep'])
	sets.midcast['Stun'] = set_combine(sets.midcast['Sleep'])
 	sets.midcast['Bind'] = set_combine(sets.midcast['Sleep'])
 	sets.midcast['Gravity II'] = set_combine(sets.midcast['Sleep'])
 	sets.midcast['Gravity'] = set_combine(sets.midcast['Sleep'])
 	sets.midcast['Silence'] = set_combine(sets.midcast['Sleep'])
 	sets.midcast['Frazzle II'] = set_combine(sets.midcast['Sleep'])
 	sets.midcast['Dispel'] = set_combine(sets.midcast['Sleep'])
	sets.midcast.Impact = set_combine(sets.midcast['Sleep'], {head=empty,body="Twilight Cloak"})
	sets.midcast['Dispelga'] = set_combine(sets.midcast['Sleep'], {main="Daybreak"})	

	--Enmity		
	sets.midcast['Flash'] = {
	ammo="Sapience Orb",
    head="Halitus Helm",
	body="Emet Harness +1",
	hands="Dux Finger Gauntlets +1",
    legs="Malignance Tights",
	feet="Rager Ledelsens +1",
	neck="Loricate Torque +1",
	waist="Goading Belt",
    ear1="Odnowa Earring +1",
	ear2="Etiolation Earring",
	ring1="Petrov Ring",
	ring2="Begrudging Ring",
	back=Sucellos.Enmity}
		
	--ENHANCING MAGIC FOR YOURSELF	
    sets.midcast.EnhancingDuration = {
	main=Colada.ENH,
	sub="Ammurapi Shield", 
	head=TelHead.ENH,
	body="Vitiation Tabard +3",
	legs=TelLegs.ENH,
	hands="Atrophy Gloves +3",
	back="Ghostfyre Cape",
	waist="Olympus Sash",
	feet="Lethargy Houseaux +1",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
	ear1="Andoaa Earring",
	ear2="Augmenting Earring",
	neck="Duelist's Torque +2"}
        
	--ENHANCING MAGIC FOR OTHERS w/ COMPOSURE		
    sets.buff.ComposureOther = {
	main=Colada.ENH,
	sub="Ammurapi Shield",
	head="Lethargy Chappel +1",
    body="Lethargy Sayon +1",
	hands="Atrophy Gloves +3",
    legs="Lethargy Fuseau +1",
	feet="Lethargy Houseaux +1",
	neck="Duelist's Torque +2"}

	--EQUIPS EMPYREAN HANDS WHEN SABOTEUR ACTIVE	
    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
    
	--EQUIPS WHEN WEATHER/DAY MATCHES SPELL	
	sets.Obi = {waist="Hachirin-no-Obi"}
    
	--RESTING	
    sets.resting = {
	main="Daybreak",
	sub="Sacro Bulwark",
	ammo="Homiliary",
    head="Vitiation Chapeau +3",
	neck="Loricate Torque +1",
	ear1="Genmei Earring",
	ear2="Etiolation Earring",
    body="Shamash Robe",
	hands="Volte Gloves",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
    back=Sucellos.Idle,
	waist="Slipor Sash",
	legs="Volte Brais",
	feet="Vitiation Boots +3"}

	--IDLE SETS		
    sets.idle = {
	main="Daybreak",
	sub="Sacro Bulwark",
	ammo="Homiliary",
    head="Vitiation Chapeau +3",
	neck="Loricate Torque +1",
	ear1="Genmei Earring",
	ear2="Etiolation Earring",
    body="Shamash Robe",
	hands="Volte Gloves",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
    back=Sucellos.Idle,
	waist="Slipor Sash",
	legs="Volte Brais",
	feet="Vitiation Boots +3"}

    sets.idle.Town = {
	main="Murgleis",
	sub="Sacro Bulwark",
	ammo="Staunch Tathlum +1",
    head="Vitiation Chapeau +3",
	neck="Duelist's Torque +2",
	ear1="Genmei Earring",
	ear2="Etiolation Earring",
    body="Shamash Robe",
	hands="Regal Cuffs",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
    back=Sucellos.Idle,
	waist="Flume Belt +1",
	legs="Malignance Tights",
	feet="Vitiation Boots +3"}    
    
	--DEFENSE SETS (LOCKED WHEN EQUIPPED)	
    sets.defense.PDT = {
	ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
	neck="Loricate Torque +1",
	ear2="Genmei Earring",
	ear1="Odnowa Earring +1",
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Gelatinous Ring +1",
	ring2="Defending Ring",
    back=Sucellos.TP2,
	waist="Flume Belt +1",
	legs="Malignance Tights",
	feet="Atrophy Boots +3"}

    sets.defense.MDT = {
	ammo="Staunch Tathlum +1",
    head="Malignance Chapeau",
	neck="Loricate Torque +1",
	ear2="Etiolation Earring",
	ear1="Odnowa Earring +1",
    body="Malignance Tabard",
	hands="Volte Bracers",
	ring1="Purity Ring",
	ring2="Defending Ring",
    back=Sucellos.Enmity,
	waist="Slipor Sash",
	legs="Malignance Tights",
	feet="Atrophy Boots +3"}

	--EQUIPS WHEN MP LOW AND IDLE.
    sets.latent_refresh = {waist="Fucho-no-obi"}

	--ENGAGED SETS	
    sets.engaged = {
	ammo="Ginsen",
    head="Ayanmo Zucchetto +2",
	neck="Combatant's Torque",
	ear1="Telos Earring",
	ear2="Mache Earring +1",
    body="Malignance Tabard",
	hands="Ayanmo Manopolas +2",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP2,
	waist="Reiki Yotai",
	legs="Malignance Tights",
	feet="Volte Spats"}

	sets.engaged.Fencer = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Brutal Earring",
	ear2="Telos Earring",
    body="Malignance Tabard",
	hands="Ayanmo Manopolas +2",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back="Ghostfyre Cape",
	waist="Orpheus's Sash",
	legs="Malignance Tights",
	feet="Volte Spats"}

	--No Haste, not that it will happen often. 49 DW to cap.	
	sets.engaged.DW = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Anu Torque",
	ear1="Eabani Earring", --4
	ear2="Suppanomimi", --5
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP, --10
	waist="Reiki Yotai", --7
	legs="Carmine Cuisses +1", --6
	feet="Volte Spats"}
	--32 Total / 17 short.
	
	--Haste II (30%) 31 DW needed to cap delay.
	sets.engaged.DW[30] = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Anu Torque",
	ear1="Eabani Earring", --4
	ear2="Suppanomimi", --5
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP, --10
	waist="Reiki Yotai", --7
	legs="Malignance Tights",
	feet="Volte Spats"}
	
	--For Haste Samba use If you're into sub DNC or whatever.
	sets.engaged.DW[35] = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Eabani Earring",
	ear2="Sherida Earring",
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP2,
	waist="Reiki Yotai",
	legs="Malignance Tights",
	feet="Volte Spats"}	

	--Capped Haste / 11 DW to cap delay.	
	sets.engaged.DW[50] = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Anu Torque",
	ear1="Eabani Earring", --4
	ear2="Sherida Earring",
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP2,
	waist="Reiki Yotai", --7
	legs="Malignance Tights",
	feet="Volte Spats"}
	--11 DW Capped.
			
	--No Haste, not that it will happen often. 49 DW to cap.		
	sets.engaged.DWacc = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Eabani Earring", --4
	ear2="Suppanomimi", --5
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP, --10
	waist="Reiki Yotai", --7
	legs="Carmine Cuisses +1", --6
	feet="Volte Spats"}
	--32 Total / 17 short.
	
	--Haste II (30%) 31 DW needed to cap delay.
	sets.engaged.DWacc[30] = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Eabani Earring", --4
	ear2="Suppanomimi", --5
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP, --10
	waist="Reiki Yotai", --7
	legs="Malignance Tights",
	feet="Volte Spats"}
	
	--For Haste Samba use If you're into that.	
	sets.engaged.DWacc[35] = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Eabani Earring",
	ear2="Sherida Earring",
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP2,
	waist="Reiki Yotai",
	legs="Malignance Tights",
	feet="Volte Spats"}
	
	--Capped Haste / 11 DW to cap delay.
	sets.engaged.DWacc[50] = {
	ammo="Ginsen",
    head="Malignance Chapeau",
	neck="Combatant's Torque",
	ear1="Eabani Earring", -- 4
	ear2="Sherida Earring",
    body="Malignance Tabard",
	hands="Malignance Gloves",
	ring1="Chirich Ring +1",
	ring2="Chirich Ring +1",
    back=Sucellos.TP2,
	waist="Reiki Yotai", --7
	legs="Malignance Tights",
	feet="Volte Spats"}
	--11 DW Capped.
		
	--WEAPON SETS (Toggles and locks weapons. ALT+F10[back] & ALT+F11[forward]).	
	sets.engaged.MurShd = {main="Murgleis",sub="Ammurapi Shield"}
	sets.engaged.CroShd = {main="Crocea Mors",sub="Ammurapi Shield"}
	sets.engaged.ClbShd = {main="Maxentius",sub="Ammurapi Shield"}
	sets.engaged.SeqShd = {main="Sequence",sub="Ammurapi Shield"}
	sets.engaged.ExcShd = {main="Excalibur",sub="Sacro Bulwark"}
	sets.engaged.MurDag = {main="Murgleis",sub="Tauret"}
	sets.engaged.SeqDag = {main="Sequence",sub="Tauret"}
	sets.engaged.NaeThi = {main="Naegling",sub="Machaera +2"}
	sets.engaged.CroDag = {main="Crocea Mors",sub="Tauret"}
	sets.engaged.AlmDag = {main="Almace",sub="Tauret"}
	sets.engaged.DagDag = {main="Tauret",sub="Ternion Dagger +1"}
	sets.engaged.DagAlm = {main="Tauret",sub="Almace"}
	sets.engaged.ClbDag = {main="Maxentius",sub="Machaera +2"}
	sets.engaged.H2H = {main="Kaja Knuckles",sub=empty}
	sets.engaged.CroDay = {main="Crocea Mors",sub="Daybreak"}
	
	--Ranged Set (ALT+F3 to toggle and lock.)
	sets.Ranged = {ranged="Ullr",ammo="Demon Arrow"}
end

	--FUNCTIONS
	
function job_buff_change(buff, gain)
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		build_haste()
		if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end	

function job_post_midcast(spell, action, spellMap, eventArgs)
	
	if (spell.skill == 'Elemental Magic' and (state.BurstMode.value ~= 'None' or state.CastingMode.value ~= 'Normal')) then
		if state.BurstMode.value ~= 'None' then
			equip(sets.midcast['Elemental Magic'].burst[state.BurstMode.value])
		else
			equip(sets.midcast['Elemental Magic'][state.CastingMode.value])
		end
	end
	if (spell.skill == 'Elemental Magic' or spell.skill == 'Healing Magic' or spell.type == 'WeaponSkill') and (spell.element == world.weather_element or spell.element == world.day_element) then
		if spell.type == 'WeaponSkill' then
			if Obi_WeaponSkills:contains(spell.english) then
				equip(sets.Obi)
			end
		else
			equip(sets.Obi)
		end
	end
	
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        if sets.midcast[spell.name] then
            equip(sets.midcast[spell.name])
        else
            equip(sets.midcast.EnhancingDuration)
        end
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureMe)
    end
	    if spell.element == world.day_element or spell.element == world.weather_element then
        if string.find(spell.english,'helix') then
            equip(sets.midcast.Helix)
        else 
			if spell.type == 'WeaponSkill' then
				if Obi_WeaponSkills:contains(spell.english) then
					equip(sets.Obi)
				end
			else
				equip(sets.Obi)
			end
        end
	end
	if spell.english == "Aquaveil" and buffactive.aquaveil then
		equip(sets.midcast.Aquaveil.up)
	end
	if GainSpells:contains(spell.english) then
		equip(GainSpell)
	elseif EnSpells:contains(spell.english) then
		equip(EnSpell)
	elseif BarSpells:contains(spell.english) then
		equip(BarSpell)
	elseif Tempers:contains(spell.english) then
		equip(EnSpell)
	end
end

	--Custom functions for timing your debuffs on the enemy. I just recommend using debuff lua that comes with Windower itself though.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then -- Sleep II Countdown --
            send_command('wait 60;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('wait 30;input /echo Sleep Effect: [WEARING OFF IN 30 SEC.];wait 15;input /echo Sleep Effect: [WEARING OFF IN 15 SEC.];wait 10;input /echo Sleep Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Break" then -- Break Countdown --
            send_command('wait 25;input /echo Break Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Paralyze" or spell.english == "Paralyze II" then -- Paralyze Countdown --
             send_command('wait 115;input /echo Paralyze Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Slow" or spell.english == "Slow II" then -- Slow Countdown --
            send_command('wait 115;input /echo Slow Effect: [WEARING OFF IN 5 SEC.]')
        elseif spell.english == "Dia III" then -- Dia Countdown --
            send_command('wait 139;input /echo Dia III Effect: [WEARING OFF IN 5 SEC.]')			
        end
    end
end

function job_handle_equipping_gear(status, eventArgs)
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if meleeSet[state.WeaponMode.current] then
        meleeSet = set_combine(meleeSet,sets.engaged[state.WeaponMode.value])
        enable('main','sub')
        equip(meleeSet)
        disable('main','sub')
    end
	if state.OffenseMode.value == 'DW' or state.OffenseMode.value =='DWacc' then
		if hastelevel > 0 then
			meleeSet = set_combine(meleeSet,sets.engaged[state.OffenseMode.value][hastelevel])
		end
	end
    return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir'}
    local sleeps = S{'Sleep','Sleep II'}
    local sleepgas = S{'Sleepga'}
 
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' spells are on cooldown. Cancelling spell casting.'
 
    local spell_index
 
end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SCH' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'BLM' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end

	--This is where you define what WS to use with what weapon with the auto WS function.
autows = {
    ['Default'] = "Chant Du Cygne",
    ['Crocea Mors'] = "Sanguine Blade",
    ['Sequence'] = "Savage Blade",
	['Murgleis'] = "Death Blossom",
	['Tauret'] = "Evisceration",
	['Naegling'] = "Savage Blade",
	['Maxentius'] = "Black Halo",
	['Kaja Knuckles'] = "Asuran Fists"}

autotp = false

function find_weaponskill()
    local ws = autows[player.equipment.main] or 0
    if ws == 0 then
        return autows.Default
    else
        return ws
    end
end
 
 windower.register_event('tp change', function(tp)
    if tp >= 1000 and autotp then
        local ws = find_weaponskill()
        windower.send_command('input /ws "'..ws..'" <t>')
    end
end)

function job_self_command(commandArgs, eventArgs)
    if commandArgs[1] == 'autotp' then
        if not autotp then
            autotp = true
            windower.add_to_chat(1,'AutoWS set to ON MOTHER FUCKER')
        else
            autotp = false
            windower.add_to_chat(1,'AutoWS set to OFF SADFACED BITCH')
        end
    elseif commandArgs[1] == 'WeaponMode' then
		handle_cycle(commandArgs)
        enable('main','sub')
        equip(sets.engaged[state.WeaponMode.value])
		if state.WeaponMode.value ~= 'Normal' then
			disable('main','sub')
		end
	elseif commandArgs[1] == 'RangeMode' then
		handle_cycle(commandArgs)
		if state.RangeMode.value == 'On' then
			equip(sets.Ranged)
			disable('range','ammo')
		end
		if state.RangeMode.value == 'Off' then
			enable('range','ammo')
			handle_equipping_gear(player.status)
		end
	end
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end

windower.send_command('bind !f1 gs c autotp')

hastelevel = 0

function build_haste()
	if (buffactive[580] or buffactive.embrava) or (buffactive.march or buffactive[604]) then
		hastelevel = 50
		add_to_chat(8,'Haste: Max')
		return
	end
	if buffactive['haste samba'] then
		hastelevel = 35
		add_to_chat(8,'Haste: 35')
		return
	end
	if buffactive[33] then
		hastelevel = 30
		add_to_chat(8,'Haste: 30')
		return
	end
	hastelevel = 0
end

function spell_control(spell)
	if spell.type == "Item" then
		return false
	elseif spell.target.name == nil and not spell.target.raw:contains("st") then
		return true
	elseif spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability) or not check_recast('ability',spell.recast_id)) then
		return true
	elseif spell.type == 'WeaponSkill' and player.tp < 1000 then
		return true
	elseif spell.type == 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability)) then
		msg("Weapon Skill Canceled, Can't")
		return true
	elseif spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell)
      or not check_recast('spell',spell.recast_id)) then
		return true
	elseif spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) and not spell.action_type == 'Ability' then
        msg("Spell Canceled, Not Enough MP")
		return true
	end
	local fm_count = 0
	for i, v in pairs(buffactive) do
		if tostring(i):startswith('finishing move') or tostring(i):startswith('?????????') then
			fm_count = tonumber(string.match(i, '%d+')) or 1
		end
	end
	local min_fm_for_flourishes = {['Animated Flourish']=1,['Desperate Flourish']=1,['Violent Flourish']=1,['Reverse Flourish']=1,['Building Flourish']=1,
                                   ['Wild Flourish']=2,['Climactic Flourish']=1,['Striking Flourish']=2,['Ternary Flourish']=3,}
	if min_fm_for_flourishes[spell.en] then
		if min_fm_for_flourishes[spell.en] > fm_count and not buffactive[507] then
			return true
		end
	end
	if spell.en == 'Spectral Jig' then
		send_command('cancel 71')
	end
	if spell.name == 'Utsusemi: Ichi' and overwrite and buffactive['Copy Image (3)'] then
		return true
	end
	if player.tp >= 1000 and player.target and player.target.distance and player.target.distance > 7 and spell.type == 'WeaponSkill' then
		msg("Weapon Skill Canceled  Target Out of Range")
		return true
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if sets.precast.FC[player.equipment.main] and spell.action_type == "Magic" then
        equip(sets.precast.FC[player.equipment.main])
    end
end

function set_lockstyle()
    send_command('wait 7; input /lockstyleset 1')
end