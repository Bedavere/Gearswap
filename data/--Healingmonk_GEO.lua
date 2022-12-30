include('how_about_no.lua')
include('organizer-lib.lua')
include('no_interruptions.lua')
include('spam_protection.lua')
include('common_commands.lua')
include('spell_stack.lua')

--Spell Stack Settings
--Use auto curing true|false
doCures = true
--Use status cures and ally buffs on alliance true|false
allianceCheck = false
--Use cures on alliance true|false
allianceHeal = false
--Use Stoneskin automatically true|false
autoSS = false
--Use Blink automatically true|false
autoBlink = true
--Use Sublimation automatically true|false
autoSub = false
--Use Phalanx automatically true|false
autoPhalanx = false
--Use Aquaveil automatically true|false
autoAquaveil = false
--Use short JAs when ready and appropriate
autoJA = false
--Use 1hr when ready and appropriate
auto1hr = false
--Use automated nuke to get hate on target
autoHate = false

--timestamp to prevent chat spam
lastChat = 0

--Percent to start using seidr body for nukes (mp back from damage)
afBodyPercent = 70

--'single' or 'aoe' nukes, used with my trigger self_commands to switch between single target or aoe
nukeType = 'single'
--Set to use when nuking
MBMode = 'Elemental Magic'
--String that's passed for mirror nuking to indicating MBing or not
mbPassString = 'N'

--Players able to control longer JA usage from chat
valid_controllers = T{'Csakid','Killtacular','Talkus'}

--list of spells to use when using trigger spells and incoming mirror nuke requests
use_spells = {}
use_spells.aoe = {}
use_spells.aoe.Water =          {'Watera III',      'Watera II',    'Watera'}
use_spells.aoe.Thunder =        {'Thundara III',    'Thundara II',  'Thundara'}
use_spells.aoe.Stone =          {'Stonera III',     'Stonera II',   'Stonera'}
use_spells.aoe.Aero =           {'Aera III',        'Aera II',      'Aera'}
use_spells.aoe.Blizzard =       {'Blizzara III',    'Blizzara II',  'Blizzara'}
use_spells.aoe.Fire =           {'Fira III',        'Fira II',      'Fira'}

use_spells.single = {}
use_spells.single.Water =       {'Water V',         'Water IV',         'Water III',        'Water II',         'Water'}
use_spells.single.Thunder =     {'Thunder V',   'Thunder IV',       'Thunder III',      'Thunder II',       'Thunder'}
use_spells.single.Stone =       {'Stone V',         'Stone IV',         'Stone III',        'Stone II',         'Stone'}
use_spells.single.Aero =        {'Aero V',      'Aero IV',          'Aero III',         'Aero II',          'Aero'}
use_spells.single.Blizzard =    {'Blizzard V',  'Blizzard IV',      'Blizzard III',     'Blizzard II',      'Blizzard'}
use_spells.single.Fire =        {'Fire V',      'Fire IV',          'Fire III',         'Fire II',          'Fire'}

indiOn = false
geoOn = false
repeatSpell = T{
stack_spells['Indi-Malaise'],stack_spells['Geo-Frailty']}
geoRepeatSpell = stack_spells['Geo-Frailty']
entrustTarget = ''
entrustOn = false
lastCast = 0
sibyl = false
kuyin = false
mythicTries = 0
dtMode = false

CurrentElement = 'Thunder'
CurrentElementa = 'Thundara'
helixName = 'Ionohelix'
stormName = 'Thunderstorm'
autoNuke = false
aoeSpell = false

spellAcc = 'Low'

indiSpells = T{}
indiSpells['Indi-Regen'] = 539
indiSpells['Indi-Refresh'] = 541
indiSpells['Indi-STR'] = 542
indiSpells['Indi-DEX'] = 543
indiSpells['Indi-VIT'] = 544
indiSpells['Indi-AGI'] = 545
indiSpells['Indi-INT'] = 546
indiSpells['Indi-MND'] = 547
indiSpells['Indi-CHR'] = 548
indiSpells['Indi-Fury'] = 549
indiSpells['Indi-Barrier'] = 550
indiSpells['Indi-Acumen'] = 551
indiSpells['Indi-Fend'] = 552
indiSpells['Indi-Precision'] = 553
indiSpells['Indi-Voidance'] = 554
indiSpells['Indi-Focus'] = 555
indiSpells['Indi-Attunement'] = 556
indiSpells['Indi-Haste'] = 580
indiSpells['Indi-Languor'] = -1
indiSpells['Indi-Malaise'] = -1
indiSpells['Indi-Wilt'] = -1
indiSpells['Indi-Frailty'] = -1
indiSpells['Indi-Fade'] = -1
indiSpells['Indi-Vex'] = -1
indiSpells['Indi-Slip'] = -1
indiSpells['Indi-Torpor'] = -1
indiSpells['Indi-Slow'] = -1
indiSpells['Indi-Slow'] = -1
indiSpells['Indi-Paralysis'] = -1
indiSpells['Indi-Gravity'] = -1
indiSpells['Indi-Poison'] = -1

indiSpellShortnames = T{regen       = gearswap.res.spells[768],
                        refresh     = gearswap.res.spells[770],
                        str         = gearswap.res.spells[772],
                        dex         = gearswap.res.spells[773],
                        agi         = gearswap.res.spells[775],
                        int         = gearswap.res.spells[776],
                        mnd         = gearswap.res.spells[777],
                        chr         = gearswap.res.spells[778],
                        att         = gearswap.res.spells[779],
                        fury        = gearswap.res.spells[779],
                        def         = gearswap.res.spells[780],
                        barrier     = gearswap.res.spells[780],
                        mab         = gearswap.res.spells[781],
                        acumen      = gearswap.res.spells[781],
                        matt        = gearswap.res.spells[781],
                        mdb         = gearswap.res.spells[782],
                        fend        = gearswap.res.spells[782],
                        mdef        = gearswap.res.spells[782],
                        acc         = gearswap.res.spells[783],
                        precision   = gearswap.res.spells[783],
                        eva         = gearswap.res.spells[784],
                        voidance    = gearswap.res.spells[784],
                        macc        = gearswap.res.spells[785],
                        focus       = gearswap.res.spells[785],
                        meva        = gearswap.res.spells[786],
                        attunement  = gearswap.res.spells[786],
                        haste       = gearswap.res.spells[771],
                        mdefdown    = gearswap.res.spells[790],
                        defdown     = gearswap.res.spells[788],
                        mevadown    = gearswap.res.spells[794],
                        attdown     = gearswap.res.spells[787],
                        mabdown     = gearswap.res.spells[789],
                        mattdown    = gearswap.res.spells[789],
                        maccdown    = gearswap.res.spells[793],
                        accdown     = gearswap.res.spells[791],
                        evadown     = gearswap.res.spells[792],
                        slow        = gearswap.res.spells[795],
                        para        = gearswap.res.spells[796],
                        gravity     = gearswap.res.spells[797],
                        weight      = gearswap.res.spells[797],
                        poison      = gearswap.res.spells[769],
                    }

geoSpellShortnames = T{ regen       = gearswap.res.spells[798],
                        refresh     = gearswap.res.spells[800],
                        str         = gearswap.res.spells[802],
                        dex         = gearswap.res.spells[803],
                        agi         = gearswap.res.spells[805],
                        int         = gearswap.res.spells[806],
                        mnd         = gearswap.res.spells[807],
                        chr         = gearswap.res.spells[808],
                        att         = gearswap.res.spells[809],
                        fury        = gearswap.res.spells[809],
                        def         = gearswap.res.spells[810],
                        barrier     = gearswap.res.spells[810],
                        mab         = gearswap.res.spells[811],
                        acumen      = gearswap.res.spells[811],
                        matt        = gearswap.res.spells[811],
                        mdb         = gearswap.res.spells[812],
                        fend        = gearswap.res.spells[812],
                        mdef        = gearswap.res.spells[812],
                        acc         = gearswap.res.spells[813],
                        precision   = gearswap.res.spells[813],
                        eva         = gearswap.res.spells[814],
                        voidance    = gearswap.res.spells[814],
                        macc        = gearswap.res.spells[815],
                        focus       = gearswap.res.spells[815],
                        meva        = gearswap.res.spells[816],
                        attunement  = gearswap.res.spells[816],
                        haste       = gearswap.res.spells[801],
                        mdefdown    = gearswap.res.spells[820],
                        defdown     = gearswap.res.spells[818],
                        mevadown    = gearswap.res.spells[824],
                        attdown     = gearswap.res.spells[817],
                        mabdown     = gearswap.res.spells[819],
                        mattdown    = gearswap.res.spells[819],
                        maccdown    = gearswap.res.spells[823],
                        accdown     = gearswap.res.spells[821],
                        evadown     = gearswap.res.spells[822],
                        slow        = gearswap.res.spells[825],
                        para        = gearswap.res.spells[826],
                        gravity     = gearswap.res.spells[827],
                        weight      = gearswap.res.spells[827],
                        poison      = gearswap.res.spells[799],
                    }

function get_sets()
    load_gear_file()
end

function pretarget(spell)
    if check_ready(spell) == false then
        cancel_spell()
    end

    queue_spell_if_busy(spell)

    if spell.skill == 'Elemental Magic' then
        if spell.english:sub(-6) == 'ra III' then
            pretargRecastData = windower.ffxi.get_spell_recasts()
            if (player.mp >= spell.mp_cost) and pretargRecastData[spell.recast_id] ~= nil and pretargRecastData[spell.recast_id] > 60 then
                cancel_spell()
                newSpell = spell.english:gsub(spell.english:sub(-6),"ra II")
                send_command('input /ma "'..newSpell..'" <t>;')
            end
        elseif spell.english:sub(-5) == 'ra II' then
            pretargRecastData = windower.ffxi.get_spell_recasts()
            if (player.mp >= spell.mp_cost) and pretargRecastData[spell.recast_id] ~= nil and pretargRecastData[spell.recast_id] > 60 then
                cancel_spell()
                newSpell = spell.english:gsub(spell.english:sub(-5),"ra")
                send_command('input /ma "'..newSpell..'" <t>;')
            end
        elseif spell.english:sub(-2) == ' V' then
            pretargRecastData = windower.ffxi.get_spell_recasts()
            if (player.mp >= spell.mp_cost) and pretargRecastData[spell.recast_id] ~= nil and pretargRecastData[spell.recast_id] > 60 then
                cancel_spell()
                newSpell = spell.english:gsub(spell.english:sub(-2)," IV")
                send_command('input /ma "'..newSpell..'" <t>;')
            end
        elseif spell.english:sub(-3) == ' IV' then
            pretargRecastData = windower.ffxi.get_spell_recasts()
            if (player.mp >= spell.mp_cost) and pretargRecastData[spell.recast_id] ~= nil and pretargRecastData[spell.recast_id] > 60 then
                cancel_spell()
                newSpell = spell.english:gsub(spell.english:sub(-3)," III")
                send_command('input /ma "'..newSpell..'" <t>;')
            end
        elseif spell.english:sub(-4) == ' III' then
            pretargRecastData = windower.ffxi.get_spell_recasts()
            if (player.mp >= spell.mp_cost) and pretargRecastData[spell.recast_id] ~= nil and pretargRecastData[spell.recast_id] > 60 then
                cancel_spell()
                newSpell = spell.english:gsub(spell.english:sub(-3)," II")
                send_command('input /ma "'..newSpell..'" <t>;')
            end
        elseif spell.english:sub(-3) == ' II' then
            pretargRecastData = windower.ffxi.get_spell_recasts()
            if (player.mp >= spell.mp_cost) and pretargRecastData[spell.recast_id] ~= nil and pretargRecastData[spell.recast_id] > 60 then
                cancel_spell()
                newSpell = spell.english:gsub(spell.english:sub(-3),"")
                send_command('input /ma "'..newSpell..'" <t>;')
            end
        end
    end
end

function precast(spell,action)
	if spell.action_type == 'Item' then
		return
	end
    if check_ready(spell) then
        if spell.type == 'WeaponSkill' then
            if spell.target.distance > 10 or player.tp < 900 then
                cancel_spell()
                return
            end

            if sets[spell.english] then
                equip(sets[spell.english])
            else
                equip(sets['Weaponskill'])
            end

            windower.add_to_chat(050, '['..spell.name..'] '..spell.target.name..' <'..player.tp..'%>')
        elseif spell.type == 'JobAbility' and sets.precast[spell.english] then
            equip(sets.precast[spell.english])
        elseif spell.type == 'Geomancy' then
            equip(sets.precast['Geomancy'])
        elseif spell.type == 'WhiteMagic' then
            if string.find(spell.english,'Cure') then
                equip(sets.precast['CureSet'])
            else
                equip(sets.precast['General'])
            end
        elseif spell.type == 'BlackMagic' then
            if spell.english == 'Impact' then
                equip(sets.precast['Impact'])
            else
                if spell.skill == 'Elemental Magic' then
                    equip(sets.precast['Elemental Magic'])
                else
                    equip(sets.precast['General'])
                end
            end
        elseif spell.cast_time and spell.cast_time > 0 then
            equip(sets.precast['General'])
        end

        spam_protection_on(spell)
    else
        cancel_spell()
    end
end

function midcast(spell,action)
	if spell.action_type == 'Item' then
		return
	end
    equipSet = sets.midcast['General']
    if spell.type == 'Ninjutsu' then
        if spell.english == 'Utsusemi: Ichi' then
            if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
                equip(sets['UtsuSet'])
                send_command('wait 1.5;cancel 66;cancel 446;cancel 445;cancel 444;')
            end
        elseif spell.english == 'Utsusemi: Ni' then
            equip(sets['UtsuSet'])
        elseif spell.type == 'Trust' then
            equip(sets['Trust'])
        end
    elseif spell.type == 'Geomancy' then
        if spell.english:sub(1,4) == 'Indi' then
            equipSet = sets.midcast['Indi']
        else
            equipSet = sets.midcast['Geomancy']
        end
    elseif spell.type == 'WhiteMagic' then
        if string.find(spell.english,'Cure') then
            equipSet = sets.midcast['CureSet']
        elseif spell.english == 'Cursna' then
            equipSet = sets.midcast['Cursna']
        elseif spell.skill == 'Enhancing Magic' then
            if spell.english == 'Stoneskin' then
                equipSet = sets.midcast['Stoneskin']
            elseif spell.english == 'Aquaveil' then
                equipSet = sets.midcast['Aquaveil']
            else
                equipSet = sets.midcast['Enhancing Magic']
            end
        elseif spell.skill == 'Enfeebling Magic' then
            equipSet = sets.midcast['Enfeebling Magic']
        end
    elseif spell.type == 'BlackMagic' then
        if spell.english == 'Drain' or spell.english == 'Drain II' or spell.english == 'Aspir' or spell.english == 'Aspir II' then
            equipSet = sets.midcast[spellAcc]['Drain']
        elseif spell.skill == 'Enfeebling Magic' then
            equipSet = sets.midcast['Enfeebling Magic']
        elseif spell.english == 'Impact' then
            equipSet = sets.midcast['Impact']
        elseif spell.skill == 'Elemental Magic' then
            equipSet = sets.midcast[spellAcc][MBMode]
            if buffactive['Reive Mark'] then
                equipSet = set_combine(equipSet, {neck="Arciela's Grace +1"})
            end
            if (((player.mp-spell.mp_cost)/player.max_mp)*100) < afBodyPercent then
                equipSet = set_combine(equipSet, sets['lowMpNuke'])
            end
        end
    elseif spell.type == 'Trust' then
        equipSet = set_combine(equipSet, sets['Trust'])
    end

    if spell.cast_time and spell.cast_time > 0 then
        equip(equipSet)
    end
end

function aftercast(spell,action)
    if spam_protection_off(spell)then
        handle_idle()
        if spell.english == 'Bolster' then
            buffactive['Bolster'] = true
        end
    end
    checkAftercast(spell)
end

function pet_aftercast(spell)
    if spam_protection_off(spell) then
        handle_idle()
    end
    checkAftercast(spell)
end

function status_change(new,old)
    handle_idle()
end

function buff_change(buff,gain_or_loss)
    if gain_or_loss then
        if buff == 'Aftermath: Lv.3' then
            send_command('timers c "AM3" 180 up "Aftermath"')
        elseif buff == 'Aftermath: Lv.2' then
            send_command('timers c "AM2" 180 up "Aftermath"')
        elseif buff == 'Aftermath: Lv.1' then
            send_command('timers c "AM1" 180 up "Aftermath"')
        end

        if buff == 'weakness' then
            send_command('timers c "Weakness" 300 up "Weakness"')
        end
    else
        if buff == 'Aftermath: Lv.3' then
            send_command('timers d "AM3"')
        elseif buff == 'Aftermath: Lv.2' then
            send_command('timers d "AM2"')
        elseif buff == 'Aftermath: Lv.1' then
            send_command('timers d "AM1"')
        elseif buff == 'encumbrance' then
            windower.send_command('gs c dt_end;')
        end

        if buff == 'weakness' then
            send_command('timers d "Weakness"')
        end
    end
end

function pet_change()
    handle_idle()
end

function handle_idle()
    if player.status == 'Engaged' then
        equipSet = sets['Melee']

        if buffactive['Reive Mark'] then
            equipSet = set_combine(equipSet, {sets['Reive']})
        end
    elseif player.status == 'Resting' then
        equipSet = sets['Resting']
        if player.mpp < 50 then
            equipSet = set_combine(equipSet, sets['mpBelt'])
        end
    else
        if player.mpp > 80 or dtMode then
            equipSet = sets['DT']
        else
            equipSet = sets['IdleRefresh']
        end

        if not dtMode and player_target == false then
            equipSet = set_combine(equipSet, sets['Running'])
        end

        if player.mpp < 50 then
            equipSet = set_combine(equipSet, sets['mpBelt'])
        end
    end

    if pet.isvalid then
        equipSet = set_combine(equipSet, sets['Luopan_DT'])
    end

    if player.indi ~= nil then
        equipSet = set_combine(equipSet, sets['BubbleActive'])
    end

    equip(equipSet)
end

function processMirrorNukes(singleOrAoe)
    --Only do this if mirror nuke mode is on
    if mirror_nuke then
        --Check we get a valid target
        local target_info = windower.ffxi.get_mob_by_target('t')
        if type(target_info) == 'table' and target_info.id ~= nil then
            --send the nuke element, aoe/single, mb/no_MB, target_ID to the common_commands mirror function
            execute_common_command('mirror ele '..elements_base:current()..' '..singleOrAoe..' '..mbPassString..' '..target_info.id)
        end
    end
end


function nukeWithElement(elementToUse, singleOrAoe, tierToUse)
    --Check the target exists and is in range (21 yalms)
    local request_test = windower.ffxi.get_mob_by_target('t')
    if request_test ~= nil and request_test.id ~= nil and request_test.distance <= 441 then
        --Geo ra spells are 12 yalms max, force single target if this condition isnt met
        if player.main_job == 'GEO' and singleOrAoe == 'aoe' and request_test.distance > 144 then
            singleOrAoe = 'single'
        end

        --Check we have a nuke available for this element, and then select the best match
        if use_spells ~= nil and use_spells[singleOrAoe] ~= nil and use_spells[singleOrAoe][elementToUse] ~= nil then
            local numTiers = #use_spells[singleOrAoe][elementToUse]+1
            local bestMatchValue = false
            local bestMatchSpell = false
            for i,v in pairs(use_spells[singleOrAoe][elementToUse]) do
                if is_spell_ready(v) then
                    if bestMatchValue == false then
                        bestMatchValue = numTiers-i-tierToUse
                        bestMatchSpell = v
                    elseif (numTiers-i-tierToUse) >= 0 and (numTiers-i-tierToUse) <= bestMatchValue then
                        bestMatchValue = numTiers-i-tierToUse
                        bestMatchSpell = v
                    end
                end
            end
            if bestMatchSpell ~= false then
                send_command('input /ma "'..bestMatchSpell..'" <t>;')
            end
        end
    end
end

function nukeTargetIDWithElement(elementToUse, singleOrAoe, tierToUse, targetID)
    --Ensure we're not already queued to do something with spellStack
    if spellStack ~= nil and #spellStack == 0 or spellStack == nil then
        if targetID ~= nil then
            --Check the target ID exists and is in range (21 yalms)
            if check_target_exists(false, targetID) then
                request_test = windower.ffxi.get_mob_by_id(targetID)
                --Geo ra spells are 12 yalms max, force single target if this condition isnt met
                if singleOrAoe == 'aoe' and request_test.distance > 144 then
                    singleOrAoe = 'single'
                end

                --Check we have a nuke available for this element, and then select the best match
                if use_spells ~= nil and use_spells[singleOrAoe] ~= nil and use_spells[singleOrAoe][elementToUse] ~= nil then
                    local numTiers = #use_spells[singleOrAoe][elementToUse]+1
                    local bestMatchValue = false
                    local bestMatchSpell = false
                    for i,v in pairs(use_spells[singleOrAoe][elementToUse]) do
                        if is_spell_ready(v) then
                            if bestMatchValue == false then
                                bestMatchValue = numTiers-i-tierToUse
                                bestMatchSpell = v
                            elseif (numTiers-i-tierToUse) >= 0 and (numTiers-i-tierToUse) <= bestMatchValue then
                                bestMatchValue = numTiers-i-tierToUse
                                bestMatchSpell = v
                            end
                        end
                    end
                    if bestMatchSpell ~= false then
                        send_command('input /ma "'..bestMatchSpell..'" '..targetID..';')
                    end
                end
            end
        end
    end
end

function self_command(command)
    if command == 'trigger1' then
        command = 'next_element'
    end
    if command == 'trigger1' then
        command = 'prev_element'
    end

    if execute_common_command(command) then
        --done
    elseif command:slice(1,8) == 'nuke_req' then
        command = command:gsub("nuke_req ","")
        if command ~= nil and string.len(command) > 0 then
            local nuke_request = T{}
            local counter = 1
            for w in string.gmatch(command, "%w+") do
                nuke_request[counter] = w
                counter = counter + 1
            end
            if nuke_request[1] ~= nil and nuke_request[2] ~= nil and nuke_request[3] ~= nil and nuke_request[4] ~= nil then
                self_command('element '..nuke_request[1])
                if nuke_request[3] == 'Y' then
                    MBMode = 'Elemental Magic MB'
                    mbPassString = 'Y'
                else
                    MBMode = 'Elemental Magic'
                    mbPassString = 'N'
                end
                nukeTargetIDWithElement(nuke_request[1], nuke_request[2], 6, nuke_request[4])
            end
        end
    elseif command == 'indi' then
        if indiOn then
            indiOn = false
            windower.add_to_chat(050,'Not using Indi- spells automatically')
        else
            indiOn = true
            windower.add_to_chat(050,'Using Indi- spells automatically')
        end
    elseif command == 'geo' then
        if geoOn then
            geoOn = false
            windower.add_to_chat(050,'Not using Geo- spells automatically')
        else
            geoOn = true
            windower.add_to_chat(050,'Using Geo- spells automatically')
        end
    elseif command == 'nuke' or command == 'autonuke' then
        if autoNuke then
            autoNuke = false
            windower.add_to_chat(050,'Not using nukes automatically (When engaged)')
        else
            autoNuke = true
            windower.add_to_chat(050,'Using nukes automatically (When engaged)')
        end
    elseif command == 'aoenuke' or command == 'aoe' then
        if aoeSpell then
            aoeSpell = false
            windower.add_to_chat(050,'Not using AoE nukes (When engaged)')
        else
            aoeSpell = true
            windower.add_to_chat(050,'Using AoE nukes (When engaged)')
        end
    elseif command == 'entruston' then
        if entrustOn then
            entrustOn = false
            windower.add_to_chat(050,'Not using Entrust automatically')
        else
            entrustOn = true
            windower.add_to_chat(050,'Using Entrust automatically')
        end
    elseif command:sub(1,9) == 'indispell' then
        commandSplit = T{}
        command = command:gsub("[%w ]+","%1")
        command = command:lower()
        if #command > 9 then
            command = command:sub(9,#command)
            commandSplit = string.split(command," ")
            table.clear(repeatSpell)

            j = 1
            for i=1, #commandSplit, 1 do
                for shortcutName,shortcutSpellName in pairs(indiSpellShortnames) do
                    if commandSplit[i] and commandSplit[i] == shortcutName then
                        repeatSpell[j] = shortcutSpellName
                        j = j + 1
                        windower.add_to_chat(050,'Adding '..shortcutSpellName.en)
                    end
                end
            end
        end
    elseif command:sub(1,8) == 'geospell' then
        commandSplit = T{}
        command = command:gsub("[%w ]+","%1")
        command = command:lower()
        if #command > 8 then
            command = command:sub(10,#command)
            geoRepeatSpell = false
            if command ~= '' then
                for shortcutName,shortcutSpell in pairs(geoSpellShortnames) do
                    if command == shortcutName then
                        geoRepeatSpell = shortcutSpell
                        windower.add_to_chat(050,'Using '..shortcutSpell.en)
                        break
                    end
                end
            end
        end
    elseif command:sub(1,7) == 'entrust' then
        command = command:gsub("entrust ", "")
        if #command > 0 then
            targetFound = checkName(command)
            if targetFound ~= '' and targetFound ~= player.name then
                entrustTarget = targetFound
                windower.add_to_chat(050,'Entrust target now ['..entrustTarget..']')
            else
                print('Player not found in party')
            end
        end
    elseif command == 'sneak' then
        send_command('input /ma "Sneak" <me>')
    elseif command == 'invisible' then
        send_command('input /ma "Invisible" <me>')
    elseif command == 'melee' then
        equip({main="Solstice",sub="Culminus"})
        windower.add_to_chat(050,"Club On")
        if player.sub_job == "DNC" and player.equipment.main == 'Solstice' and player.equipment.sub == 'Culminus' then
            disable('main','sub')
            mythicTries = 0
            windower.add_to_chat(167,"Melee [ON]")
        elseif player.equipment.main == 'Solstice' and player.equipment.sub == "Culminus" then
            disable('main','sub')
            mythicTries = 0
            windower.add_to_chat(167,"Melee [ON]")
        elseif mythicTries > 10 then
            windower.add_to_chat(050,"Melee couldn't be equipped at this time.")
        else
            enable('main','sub')
            mythicTries = mythicTries +1
            send_command('wait 1;gs c melee;')
        end
    elseif command == 'off' then
        enable('main','sub')
        windower.add_to_chat(050,"Melee Mode [OFF]")
        equip(sets[idleSet])
    elseif command == 'ws' and player.status == 'Engaged' and player.tp >= 1000 then
        if player.equipment.main == 'Solstice' then
            send_command('input /ws "Realmrazer" <t>;')
        elseif player.equipment.main == 'Marin Staff +1' then
            send_command('input /ws "Shattersoul" <t>;')
        end
    elseif command == 'type' then
        if nukeType == 'aoe' then
            nukeType = 'single'
            nukePassString = 'single'
            windower.add_to_chat(167,"Single Target Mode")
        else
            nukeType = 'aoe'
            nukePassString = 'aoe'
            windower.add_to_chat(167,"AoE Target Mode")
        end
    elseif command == 'trigger2' or command == 'mbmode' then
        if MBMode == 'Elemental Magic' then
            MBMode = 'Elemental Magic MB'
            mbPassString = 'Y'
            windower.add_to_chat(050,"MB Mode [ON]")
        else
            MBMode = 'Elemental Magic'
            mbPassString = 'N'
            windower.add_to_chat(050,"MB Mode [OFF]")
        end
    elseif command == 'tier1' or command == 't1' then
        nukeWithElement(elements_base:current(), nukeType, 1)
        processMirrorNukes(nukePassString)
    elseif command == 'trigger3' or command == 'tier2' or command == 't2' then
        nukeWithElement(elements_base:current(), nukeType, 2)
        processMirrorNukes(nukePassString)
    elseif command == 'trigger4' or command == 'tier3' or command == 't3' then
        nukeWithElement(elements_base:current(), nukeType, 3)
        processMirrorNukes(nukePassString)
    elseif command == 'trigger5' or command == 'tier4' or command == 't4' then
        nukeWithElement(elements_base:current(), nukeType, 4)
        processMirrorNukes(nukePassString)
    elseif command == 'trigger6' or command == 'tier5' or command == 't5' then
        nukeWithElement(elements_base:current(), nukeType, 5)
        processMirrorNukes(nukePassString)
    elseif command == 'tank' then
        if not dtMode then
            dtMode = true
            windower.add_to_chat(028, "Idle DT [ON]")
        else
            dtMode = false
            windower.add_to_chat(028, "Idle DT [OFF]")
        end
        handle_idle()
    elseif command == 'apex' then
        dtMode = false
        autoJA = true
        auto1hr = true
        autoSS = true
        geoOn = true
        indiOn = true
        entrustOn = true
        entrustTarget = 'Meshel'
        doCures = false
        if player.name == 'Raelious' then
            repeatSpell[1] = get_spell_from_name('Indi-Malise')
            repeatSpell[2] = get_spell_from_name('Indi-STR')
            geoRepeatSpell = get_spell_from_name('Geo-Haste')
            doCures = false
			geoOn = true
        else
            repeatSpell[1] = get_spell_from_name('Indi-Haste')
            repeatSpell[2] = get_spell_from_name('Indi-Acumen')
            geoRepeatSpell = get_spell_from_name('Geo-Malaise')
        end
    elseif command == 'dia2' then
        direct_push(stack_spells['Dia II'], 'ma', 'bt', false)
    elseif stack_command(command) then
        --done
    end
end

function party_target_change()
    if autoHate and party_target ~= false and (geoOn or indiOn) then
        if player.sub_job == 'WHM' then
            direct_push(stack_spells['Dia II'], 'ma', party_target, false)
        else
            direct_push(stack_spells['Fire'], 'ma', party_target, false)
        end
    end
end

function handle_ping()
    if player.hp == 0 and (#spellStack > 0 or party_target ~= false) then
        party_target = false
        clear_spell_stack()
        windower.add_to_chat(028,'Unsetting any party target and clearing stack')
    end

    if buffactive['petrification'] then
        if os.clock()-lastChat > 10 then
            send_command('input /p stoned')
            lastChat = os.clock()
        end
    elseif buffactive['sleep'] then
        if os.clock()-lastChat > 10 then
            send_command('input /p zzz')
            lastChat = os.clock()
        end
    elseif buffactive['silence'] then
        if os.clock()-lastChat > 5 then
            send_command('input /item "Echo Drops" <me>;')
            lastChat = os.clock()
        end
    end

    if check_ready_silent() and player.x == lastx and player.y == lasty then

        if autoNuke and player.status == 'Engaged' and player.mp > 250 then
            if aoeSpell and is_spell_ready(CurrentElementa..' II') then
                direct_push(get_spell_from_name(CurrentElementa..' II'), 'ma', 't', false)
            elseif is_spell_ready(CurrentElement..' V') then
                direct_push(get_spell_from_name(CurrentElement..' V'), 'ma', 't', false)
            elseif is_spell_ready(CurrentElement..' IV') then
                direct_push(get_spell_from_name(CurrentElement..' IV'), 'ma', 't', false)
            elseif is_spell_ready(CurrentElement..' III') then
                direct_push(get_spell_from_name(CurrentElement..' III'), 'ma', 't', false)
            elseif aoeSpell and is_spell_ready(CurrentElementa) then
                direct_push(get_spell_from_name(CurrentElementa), 'ma', 't', false)
            elseif is_spell_ready(CurrentElement..' II') then
                direct_push(get_spell_from_name(CurrentElement..' II'), 'ma', 't', false)
            elseif is_spell_ready(CurrentElement) then
                direct_push(get_spell_from_name(CurrentElement), 'ma', 't', false)
            end
        end

        if indiOn and #repeatSpell > 0 then
            local localIndiSpell = indiSpells[repeatSpell[1].en]
            if repeatSpell[1].id == 781 then
                sibyl = false
                for i,v in pairs(partyData) do
                    if type(v) == 'table' and partyData[i].name == 'StarSibyl' then
                        sibyl = true
                    end
                end

                if (sibyl and (buffactive[localIndiSpell] == 0 or buffactive[localIndiSpell] == 1)) or (not sibyl and not buffactive[localIndiSpell]) and os.clock()-lastCast > 60 and is_spell_ready(repeatSpell[1].en) then
                    direct_push_front(repeatSpell[1], 'ma', player.name, false)
                    lastCast = os.clock()
                elseif entrustOn and #repeatSpell > 1 and #entrustTarget > 0 and is_spell_ready(repeatSpell[2].en) and is_ability_ready('Entrust') and checkRange(entrustTarget,true) then
                    direct_push_front(repeatSpell[2], 'ma', entrustTarget, false)
                    direct_push_front(gearswap.res.job_abilities[386], 'ja', player.name, false)
                end
            elseif repeatSpell[1].id == 770 then
                sibyl = false
                for i,v in pairs(partyData) do
                    if type(v) == 'table' and partyData[i].name == 'Moogle' then
                        sibyl = true
                    end
                end

                if (sibyl and (buffactive[localIndiSpell] == 0 or buffactive[localIndiSpell] == 1)) or (not sibyl and not buffactive[localIndiSpell]) and os.clock()-lastCast > 60 and is_spell_ready(repeatSpell[1].en) then
                    direct_push_front(repeatSpell[1], 'ma', player.name, false)
                    lastCast = os.clock()
                elseif entrustOn and #repeatSpell > 1 and #entrustTarget > 0 and is_spell_ready(repeatSpell[2].en) and is_ability_ready('Entrust') and checkRange(entrustTarget,true) then
                    direct_push_front(repeatSpell[2], 'ma', entrustTarget, false)
                    direct_push_front(gearswap.res.job_abilities[386], 'ja', player.name, false)
                end
            elseif repeatSpell[1].id == 783 then
                kuyin = false
                for i,v in pairs(partyData) do
                    if type(v) == 'table' and partyData[i].name == 'KuyinHathdenna' then
                        kuyin = true
                    end
                end

                if (kuyin and (buffactive[localIndiSpell] == 0 or buffactive[localIndiSpell] == 1)) or (not kuyin and not buffactive[localIndiSpell]) and os.clock()-lastCast > 60 and is_spell_ready(repeatSpell[1].en) then
                    direct_push_front(repeatSpell[1], 'ma', player.name, false)
                    lastCast = os.clock()
                elseif entrustOn and #repeatSpell > 1 and #entrustTarget > 0 and is_spell_ready(repeatSpell[2].en) and is_ability_ready('Entrust') and checkRange(entrustTarget,true) then
                    direct_push_front(repeatSpell[2], 'ma', entrustTarget, false)
                    direct_push_front(gearswap.res.job_abilities[386], 'ja', player.name, false)
                end
            else
                if localIndiSpell == -1 and player.indi == nil then
                    direct_push_front(repeatSpell[1], 'ma', player.name, false)
                elseif localIndiSpell > 0 and not buffactive[localIndiSpell] and is_spell_ready(repeatSpell[1].en) then
                    direct_push_front(repeatSpell[1], 'ma', player.name, false)
                elseif entrustOn and #repeatSpell > 1 and #entrustTarget > 0 and is_spell_ready(repeatSpell[2].en) and is_ability_ready('Entrust') and checkRange(entrustTarget,true) then
                    direct_push_front(repeatSpell[2], 'ma', entrustTarget, false)
                    direct_push_front(gearswap.res.job_abilities[386], 'ja', player.name, false)
                end
            end
        end

        if geoOn and geoRepeatSpell ~= false then
            if not pet.isvalid and is_spell_ready(geoRepeatSpell.en) then
                if geoRepeatSpell.targets:contains('Enemy') and party_target ~= false then
                    if auto1hr and is_ability_ready('Bolster') and is_ability_ready('Ecliptic Attrition') and is_ability_ready('Dematerialize') then
                        direct_push_front(gearswap.res.job_abilities[347], 'ja', player.name, false)
                        direct_push_front(gearswap.res.job_abilities[351], 'ja', player.name, false)
                        direct_push_front(geoRepeatSpell, 'ma', party_target, false)
                        direct_push_front(gearswap.res.job_abilities[343], 'ja', player.name, false)
                    elseif autoJA and not buffactive['Bolster'] and is_ability_ready('Blaze of Glory') and not checkInQueue('Bolster', player.name, 'ja') then
                        if is_ability_ready('Life Cycle') then
                            direct_push_front(gearswap.res.job_abilities[349], 'ja', player.name, false)
                        end

                        if is_ability_ready('Ecliptic Attrition') then
                            direct_push_front(gearswap.res.job_abilities[347], 'ja', player.name, false)
                        end

                        if is_ability_ready('Dematerialize') then
                            direct_push_front(gearswap.res.job_abilities[351], 'ja', player.name, false)
                        end

                        direct_push_front(geoRepeatSpell, 'ma', party_target, false)

                        direct_push_front(gearswap.res.job_abilities[350], 'ja', player.name, false)
                    else
                        direct_push_front(geoRepeatSpell, 'ma', party_target, false)
                    end
                elseif geoRepeatSpell.targets:contains('Party') then
                    if auto1hr and is_ability_ready('Bolster') and is_ability_ready('Ecliptic Attrition') and is_ability_ready('Dematerialize') then
                        direct_push_front(gearswap.res.job_abilities[347], 'ja', player.name, false)
                        direct_push_front(gearswap.res.job_abilities[351], 'ja', player.name, false)
                        direct_push_front(geoRepeatSpell, 'ma', player.name, false)
                        direct_push_front(gearswap.res.job_abilities[343], 'ja', player.name, false)
                    elseif autoJA and is_ability_ready('Blaze of Glory') and not checkInQueue('Bolster', player.name, 'ja') then
                        if is_ability_ready('Life Cycle') then
                            direct_push_front(gearswap.res.job_abilities[349], 'ja', player.name, false)
                        end

                        if is_ability_ready('Ecliptic Attrition') then
                            direct_push_front(gearswap.res.job_abilities[347], 'ja', player.name, false)
                        end

                        if is_ability_ready('Dematerialize') then
                            direct_push_front(gearswap.res.job_abilities[351], 'ja', player.name, false)
                        end

                        direct_push_front(geoRepeatSpell, 'ma', player.name, false)

                        direct_push_front(gearswap.res.job_abilities[350], 'ja', player.name, false)
                    else
                        direct_push_front(geoRepeatSpell, 'ma', player.name, false)
                    end
                end
            else
                if geoRepeatSpell.targets:contains('Party') then
                    local tempx = player.x-pet.x
                    local tempy = player.y-pet.y
                    if math.sqrt((tempx*tempx)+(tempy*tempy)) > 7 and is_ability_ready('Full Circle') then
                        direct_push(gearswap.res.job_abilities[345], 'ja', player.name, false)
                    end
                end
            end
        end

        if player.sub_job_level > 0 then
            if player.sub_job == 'WHM' or player.sub_job == 'RDM' then
--                if not buffactive['reraise'] and recastData[gearswap.res.spells[135].recast_id] == 0 and player.mp > gearswap.res.spells[135].mp_cost then
--                    direct_push(gearswap.res.spells[135], 'ma', player.name, true)
--                end
                if autoSS and not buffactive['stoneskin'] and recastData[gearswap.res.spells[54].recast_id] == 0 and player.mp > gearswap.res.spells[54].mp_cost then
                    direct_push(gearswap.res.spells[54], 'ma', player.name, false)
                end
                if autoBlink and not buffactive['Blink'] and recastData[gearswap.res.spells[53].recast_id] == 0 and player.mp > gearswap.res.spells[53].mp_cost then
                    direct_push(gearswap.res.spells[53], 'ma', player.name, false)
                end
                if autoAquaveil and not buffactive['Aquaveil'] and recastData[gearswap.res.spells[55].recast_id] == 0 and player.mp > gearswap.res.spells[55].mp_cost then
                    direct_push(gearswap.res.spells[55], 'ma', player.name, false)
                end

                if selfFix['cursna'] and (buffactive['doom'] or buffactive['curse']) and is_spell_ready('Cursna') then
                    direct_push_front(gearswap.res.spells[20], 'ma', player.name, false)
                end
                if selfFix['erase'] and (buffactive['bind'] or buffactive['weight'] or buffactive['slow']) then
                    direct_push(gearswap.res.spells[143], 'ma', player.name, false)
                end
                if selfFix['poisona'] and buffactive['poison'] then
                    direct_push(gearswap.res.spells[14], 'ma', player.name, false)
                end
                if selfFix['paralyna'] and buffactive['paralysis'] then
                    direct_push(gearswap.res.spells[15], 'ma', player.name, false)
                end
            elseif player.sub_job == 'NIN' then
                if not buffactive['Copy Image (2)'] and not buffactive['Copy Image (3)'] and not buffactive['Copy Image (4)'] then
                    if is_spell_ready('Utsusemi: Ni') then
                        direct_push_front(gearswap.res.spells[339], 'ma', player.name, false)
                    elseif is_spell_ready('Utsusemi: Ichi') then
                        direct_push_front(gearswap.res.spells[338], 'ma', player.name, false)
                    end
                end
            end
        end

        check_auto_spell()
        if doCures then
            cure_process()
        end
        handleSpareTime()
    else
        lastx = player.x
        lasty = player.y
    end
end

function file_unload(file_name)
    windower.text.delete('stackoutput')
end