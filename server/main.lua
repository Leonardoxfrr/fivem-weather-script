-- Serverseitige Wetter- und Uhrzeitsteuerung für ESX

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local stopWeather = false
local stopTime = false

-- Helper: Admin-Check
local function isAdmin(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end
    local group = xPlayer.getGroup and xPlayer.getGroup() or xPlayer.get('group')
    if group == 'admin' or group == 'superadmin' then
        return true
    end
    return false
end

-- Fixes Wetter und Zeit beim Serverstart setzen
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    if config.FixWeather then
        TriggerClientEvent('weatherChanger:setWeather', -1, config.FixedWeatherType)
        stopWeather = true
    else
        TriggerClientEvent('weatherChanger:setWeather', -1, config.DefaultWeather)
    end
    if config.FixTime then
        TriggerClientEvent('weatherChanger:setTime', -1, config.FixedHour, config.FixedMinute)
        stopTime = true
    else
        TriggerClientEvent('weatherChanger:setTime', -1, config.DefaultHour, config.DefaultMinute)
    end
end)

RegisterCommand('setweather', function(source, args, rawCommand)
    print('DEBUG: setweather command received', source, args[1])
    if source == 0 then -- Konsole darf immer
        if not args[1] then print('Bitte gib einen Wettertyp an!') return end
        TriggerClientEvent('weatherChanger:setWeather', -1, args[1])
        print('Wetter geändert zu: ' .. args[1])
        return
    end
    if not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    if stopWeather then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Wetteränderung ist aktuell gesperrt!' } })
        return
    end
    if #args < 1 then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Bitte gib einen Wettertyp an!' } })
        return
    end
    local weatherType = args[1]
    TriggerClientEvent('weatherChanger:setWeather', -1, weatherType)
end)

RegisterCommand('settime', function(source, args, rawCommand)
    print('DEBUG: settime command received', source, args[1], args[2])
    if source == 0 then -- Konsole darf immer
        if not args[1] or not args[2] then print('Bitte gib Stunde und Minute an!') return end
        TriggerClientEvent('weatherChanger:setTime', -1, tonumber(args[1]), tonumber(args[2]))
        print('Uhrzeit geändert zu: ' .. args[1] .. ':' .. args[2])
        return
    end
    if not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    if stopTime then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Uhrzeitänderung ist aktuell gesperrt!' } })
        return
    end
    if #args < 2 then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Bitte gib Stunde und Minute an!' } })
        return
    end
    local hour = tonumber(args[1])
    local minute = tonumber(args[2])
    TriggerClientEvent('weatherChanger:setTime', -1, hour, minute)
end)

RegisterCommand('stopweather', function(source, args)
    if source ~= 0 and not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopWeather = true
    if source == 0 then print('Wetteränderung wurde gestoppt!')
    else TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Wetteränderung wurde gestoppt!' } }) end
end)

RegisterCommand('stoptime', function(source, args)
    if source ~= 0 and not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopTime = true
    if source == 0 then print('Uhrzeitänderung wurde gestoppt!')
    else TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Uhrzeitänderung wurde gestoppt!' } }) end
end)

RegisterCommand('resumeweather', function(source, args)
    if source ~= 0 and not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopWeather = false
    if source == 0 then print('Wetteränderung ist wieder möglich!')
    else TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Wetteränderung ist wieder möglich!' } }) end
end)

RegisterCommand('resumetime', function(source, args)
    if source ~= 0 and not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopTime = false
    if source == 0 then print('Uhrzeitänderung ist wieder möglich!')
    else TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Uhrzeitänderung ist wieder möglich!' } }) end
end)

-- Command suggestions für die Chat-Eingabe registrieren
TriggerEvent('chat:addSuggestion', '/setweather', 'Setzt das Wetter', {
    { name = 'Wettertyp', help = 'z.B. CLEAR, RAIN, EXTRASUNNY' }
})
TriggerEvent('chat:addSuggestion', '/settime', 'Setzt die Uhrzeit', {
    { name = 'Stunde', help = 'z.B. 12' },
    { name = 'Minute', help = 'z.B. 30' }
})
TriggerEvent('chat:addSuggestion', '/stopweather', 'Sperrt Wetteränderungen')
TriggerEvent('chat:addSuggestion', '/stoptime', 'Sperrt Uhrzeitänderungen')
TriggerEvent('chat:addSuggestion', '/resumeweather', 'Erlaubt wieder Wetteränderungen')
TriggerEvent('chat:addSuggestion', '/resumetime', 'Erlaubt wieder Uhrzeitänderungen')

-- FiveM spezifische globale Funktionen deklarieren (nur für Linter/IDE, nicht für FiveM selbst notwendig)
if false then
    function TriggerEvent() end
    function TriggerClientEvent() end
    function AddEventHandler() end
    function GetCurrentResourceName() end
end
