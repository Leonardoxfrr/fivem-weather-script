-- Serverseitige Wetter- und Uhrzeitsteuerung für ESX

local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local config = require "config"

local stopWeather = false
local stopTime = false

-- Helper: Admin-Check
local function isAdmin(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.getGroup and xPlayer.getGroup() == 'admin' then
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

RegisterCommand('setweather', function(source, args)
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

RegisterCommand('settime', function(source, args)
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
    if not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopWeather = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Wetteränderung wurde gestoppt!' } })
end)

RegisterCommand('stoptime', function(source, args)
    if not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopTime = true
    TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Uhrzeitänderung wurde gestoppt!' } })
end)

RegisterCommand('resumeweather', function(source, args)
    if not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopWeather = false
    TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Wetteränderung ist wieder möglich!' } })
end)

RegisterCommand('resumetime', function(source, args)
    if not isAdmin(source) then
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Keine Berechtigung!' } })
        return
    end
    stopTime = false
    TriggerClientEvent('chat:addMessage', source, { args = { '^2SYSTEM', 'Uhrzeitänderung ist wieder möglich!' } })
end)

-- FiveM spezifische globale Funktionen deklarieren (nur für Linter/IDE, nicht für FiveM selbst notwendig)
if false then
    function TriggerEvent() end
    function TriggerClientEvent() end
    function AddEventHandler() end
    function GetCurrentResourceName() end
end
