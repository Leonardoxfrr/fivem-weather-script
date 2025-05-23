# fivem-weather-script

## Beschreibung

Dieses Script ermöglicht es, Wetter und Uhrzeit auf einem FiveM-Server einfach zu steuern. Es bietet verschiedene Befehle, um Wetter und Zeit zu setzen, zu sperren und wieder freizugeben. Die Konfiguration erfolgt über die Datei `config.lua`.

### Funktionen
- Setzt Wetter und Uhrzeit beim Serverstart auf Standard- oder feste Werte (konfigurierbar).
- Wetter und Uhrzeit können per Command geändert werden.
- Wetter- und Uhrzeitänderungen können gesperrt und wieder freigegeben werden.
- Konfiguration über `config.lua`.

### Befehle

- `/setweather [Wettertyp]`  
  Setzt das Wetter auf den angegebenen Typ (z.B. CLEAR, RAIN, SMOG, EXTRASUNNY).
- `/settime [Stunde] [Minute]`  
  Setzt die Uhrzeit auf die angegebene Stunde und Minute.
- `/stopweather`  
  Sperrt die Änderung des Wetters.
- `/stoptime`  
  Sperrt die Änderung der Uhrzeit.
- `/resumeweather`  
  Gibt die Wetteränderung wieder frei.
- `/resumetime`  
  Gibt die Uhrzeitänderung wieder frei.

### Konfiguration
Bearbeite die Datei `config.lua`, um Standardwerte oder feste Werte für Wetter und Uhrzeit festzulegen.

---

## Description

This script allows you to easily control weather and time on a FiveM server. It provides several commands to set, lock, and unlock weather and time. Configuration is done via the `config.lua` file.

### Features
- Sets weather and time to default or fixed values on server start (configurable).
- Weather and time can be changed via command.
- Weather and time changes can be locked and unlocked.
- Configuration via `config.lua`.

### Commands

- `/setweather [weather type]`  
  Sets the weather to the specified type (e.g. CLEAR, RAIN, SMOG, EXTRASUNNY).
- `/settime [hour] [minute]`  
  Sets the time to the specified hour and minute.
- `/stopweather`  
  Locks weather changes.
- `/stoptime`  
  Locks time changes.
- `/resumeweather`  
  Unlocks weather changes.
- `/resumetime`  
  Unlocks time changes.

### Configuration
Edit the `config.lua` file to set default or fixed values for weather and time.

