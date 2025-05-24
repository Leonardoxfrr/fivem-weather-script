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

-- Command-Suggestions für den Chat (damit die Commands angezeigt werden)
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
