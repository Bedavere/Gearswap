eraseables = T{'elegy','requiem','bind','weight','bio','dex down','str down','agi down','mnd down','vit down','mnd down','int down','accuracy down','defense down','magic def. down','slow','max hp down','attack down','max mp down'}
naSpells = {}
naSpells = {
    sleep = gearswap.res.spells[7],
    silence = gearswap.res.spells[17],
    paralysis = gearswap.res.spells[15],
    plague = gearswap.res.spells[19],
    poison = gearswap.res.spells[14],
    blindness = gearswap.res.spells[16],
    doom = gearswap.res.spells[20],
    curse = gearswap.res.spells[20],
    petrification = gearswap.res.spells[18],
}
priority_players = {}
curablePlayer = {}
selfFix = {}
selfFix['paralyna'] = false
selfFix['poisona'] = false
selfFix['erase'] = false
selfFix['cursna'] = false
lastValue = 0
stunMode = false
has_marsyas = false
lastStatus = {}
for i,v in pairs(naSpells) do
    lastStatus[i] = 0
end
lastStatus['Sacrifice'] = 0
lastStatus['Erase'] = 0
--Table to hold valid controllers for special commands (currently only songs and ja)
valid_controllers = T{}
--Spell Stack Settings
--Use auto curing true|false
doCures = true
--Use Divine Caress automatically true|false
autoCaress = false
--Use status cures and party buffs on party true|false
ptStatusHeals = true
--Use status cures and ally buffs on alliance true|false
allyStatusHeals = true
--Use cures on alliance true|false
allianceHeal = false
--Use Stoneskin automatically true|false
autoSS = false
--Use Blink automatically true|false
autoBlink = false
--Use Sublimation automatically true|false
autoSub = false
--Use Phalanx automatically true|false
autoPhalanx = false
--Use Aquaveil automatically true|false
autoAquaveil = false
--Recast prot/shelll if they wear
ignoreProtShellWear = false
--Use BRD JA automatically true|false
autoJA = false
--Use BRD 1hr automatically true|false
auto1hr = false
--Blank table for resing songs
resingSongs = {}
--Use self status fixes or not
self_status_fix = true
totalSongs = 3
currentMaxSongs = totalSongs
--Auto strat usage
autoStrat = true
--Mode to ignore pt buff crap to avoid SC breaking
scSchMode = false
--Tracks if SC is started for pt chat
scStarted = false
--Automatically add in helix MB
autoMB = true
--Automatically add in Ebullience for SC MBs
autoEbu = false
--Use helix or tier
helixOrTier = 'helix'
mbHelixSpell = T{   Fire        = 'Pyrohelix',
                    Earth       = 'Geohelix',
                    Water       = 'Hydrohelix',
                    Wind        = 'Anemohelix',
                    Ice         = 'Cryohelix',
                    Thunder     = 'Ionohelix',
                    Dark        = 'Noctohelix'
    }
mbTierSpell = T{    Fire        = 'Fire',
                    Earth       = 'Stone',
                    Water       = 'Water',
                    Wind        = 'Aero',
                    Ice         = 'Blizzard',
                    Thunder     = 'Thunder',
                    Dark        = 'Stone'
    }
--auto recast data
mainSpells = T{}
mainSpells['WHM'] = T{
        {name='Haste',target="any",recast=270},
		{name='Flurry',target="any",recast=270},
        {name='Regen IV',target="party",recast=185},
        {name='Protect V',target="party",recast=2880},
        {name='Shell V',target="party",recast=2880},
        {name='Protectra V',target="party",recast=2880},
        {name='Shellra V',target="party",recast=2880},
        {name='Barblizzara',target="self",recast=780},
        {name='Barfira',target="self",recast=780},
        {name='Barwatera',target="self",recast=780},
        {name='Barthundra',target="self",recast=780},
        {name='Barstonra',target="self",recast=780},
        {name='Baraera',target="self",recast=780},
        {name='Barblizzara',target="self",recast=780},
        {name='Barblindra',target="self",recast=780},
        {name='Barsleepra',target="self",recast=780},
        {name='Baramnesra',target="self",recast=780},
        {name='Barpetra',target="self",recast=780},
        {name='Barpoisonra',target="self",recast=780},
        {name='Barparalyzra',target="self",recast=780},
        {name='Barsilencera',target="self",recast=780},
        {name='Barvira',target="self",recast=780},
        {name='Auspice',target="self",recast=290},
        {name='Boost-STR',target="self",recast=480},
        {name='Boost-DEX',target="self",recast=480},
        {name='Boost-INT',target="self",recast=480},
        {name='Boost-AGI',target="self",recast=480},
        {name='Boost-VIT',target="self",recast=480},
        {name='Boost-MND',target="self",recast=480},
        {name='Boost-CHR',target="self",recast=480}
    }

mainSpells['RDM'] = T{
        {name='Haste II',target="any",recast=179},
        {name='Refresh II',target="any",recast=179},
        {name='Refresh III',target="any",recast=179},
        {name='Flurry II',target="party",recast=179}
    }

mainSpells['SCH'] = T{
        {name='Regen V',target="party",recast=179},
        {name='Voidstorm',target="party",recast=179},
        {name='Aurorastorm',target="party",recast=179},
        {name='Thunderstorm',target="party",recast=179},
        {name='Hailstorm',target="party",recast=179},
        {name='Firestorm',target="party",recast=179},
        {name='Windstorm',target="party",recast=179},
        {name='Rainstorm',target="party",recast=179},
        {name='Sandstorm',target="party",recast=179},
        {name='Voidstorm II',target="party",recast=179},
        {name='Aurorastorm II',target="party",recast=179},
        {name='Thunderstorm II',target="party",recast=179},
        {name='Hailstorm II',target="party",recast=179},
        {name='Firestorm II',target="party",recast=179},
        {name='Windstorm II',target="party",recast=179},
        {name='Rainstorm II',target="party",recast=179},
        {name='Sandstorm II',target="party",recast=179},
        {name='Adloquium',target="party",recast=179}
    }

subSpells = T{}
subSpells['WHM'] = T{
        {name='Haste',target="any",recast=270},
    }
	
subSpells = T{}
subSpells['SCH'] = T{
        {name='Voidstorm',target="party",recast=300},
        {name='Aurorastorm',target="party",recast=300},
        {name='Thunderstorm',target="party",recast=300},
        {name='Hailstorm',target="party",recast=300},
        {name='Firestorm',target="party",recast=300},
        {name='Windstorm',target="party",recast=300},
        {name='Rainstorm',target="party",recast=300},
        {name='Sandstorm',target="party",recast=300},
    }

subSpells['RDM'] = T{
        {name='Haste',target="any",recast=270},
        {name='Flurry',target="any",recast=270},
        {name='Refresh',target="any",recast=270},
    }
--Zone IDs to ignore (Town)
exclusion_zones = T{14,26,43,44,48,50,53,70,71,80,87,94,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,256,257,280,284}
--Key the resources by spell name to ease rewriting all of my scripts by ID
stack_spells = {}
stack_job_abilities = {}
stack_weapon_skills = {}

for i,v in pairs(gearswap.res.spells) do
    if v['en'] ~= nil and stack_spells[v['en']] == nil then
        stack_spells[v['en']] = v
    end
end

for i,v in pairs(gearswap.res.job_abilities) do
    if v['en'] ~= nil and stack_job_abilities[v['en']] == nil then
        stack_job_abilities[v['en']] = v
    end
end

for i,v in pairs(gearswap.res.weapon_skills) do
    if v['en'] ~= nil and stack_weapon_skills[v['en']] == nil then
        stack_weapon_skills[v['en']] = v
    end
end

use_mb_on_next_nuke = false

valid_fonts = T{
    'fixedsys',
    'lucida console',
    'courier',
    'courier new',
    'ms mincho',
    'consolas',
    'dejavu sans mono'
}
output_position_x = 0
output_position_y = 0
output_position_font_size = 10
output_position_bg_alpha = 255
output_position_bg_r = 0
output_position_bg_g = 0
output_position_bg_b = 0
output_position_font_alpha = 255
output_position_font_r = 255
output_position_font_g = 255
output_position_font_b = 255
output_max_lines = 5

spell_distances = {
      [2] = 4*4,
      [3] = 5*5,
      [4] = 6.2*6.2,
      [5] = 7.5*7.5,
      [6] = 7.8*7.8,
      [7] = 8.8*8.8,
      [8] = 11*11,
      [9] = 13*13,
     [10] = 15*15,
     [11] = 16.6*16.6,
     [12] = 21*21,
}

curaga_5_amount = 1600
curaga_4_amount = 1200
curaga_3_amount = 1000
curaga_2_amount = 600

cure_6_amount = 1450
cure_5_amount = 1150
cure_4_amount = 1050
cure_3_amount = 650
abyssea_cure_3_amount = 600