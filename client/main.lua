-- Clientseitige Wetter- und Uhrzeitsteuerung

RegisterNetEvent('weatherChanger:setWeather')
AddEventHandler('weatherChanger:setWeather', function(weatherType)
    SetWeatherTypeOvertimePersist(weatherType, 1.0)
    SetWeatherTypeNowPersist(weatherType)
    SetWeatherTypeNow(weatherType)
    SetOverrideWeather(weatherType)
    TriggerEvent('chat:addMessage', { args = { '^2Wetter', 'Wetter geändert zu: ' .. weatherType } })
end)

RegisterNetEvent('weatherChanger:setTime')
AddEventHandler('weatherChanger:setTime', function(hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
    TriggerEvent('chat:addMessage', { args = { '^2Uhrzeit', 'Uhrzeit geändert zu: ' .. hour .. ':' .. string.format('%02d', minute) } })
end)
