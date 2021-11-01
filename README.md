# QENightmarePlus
A cooperative multiplayer mod for Quake Enhanced that makes the game more difficult

## What is it?
This is a singleplayer / cooperative mod for Quake Enhanced that makes the game more difficult by increasing the amount of monsters and their hp.
Currently only works for the quake main campaign.
There's a bunch of different gamemodes you can apply to tweak the game to your liking.
Works with all difficulties.

By default here's what's going to happen:
* Tries to double the amount of monsters
* Ammo picks up / max ammo is increased by 1.5x
* Monster health is doubled (except Zombies, which get 1.5x)
* When changing map, you'll be given a minimum amount of ammo for all types of ammo (shells, nails, rockets, cells).
* Cooperative: Whenever a player respawns, it will be given any weapons that have been picked up in the map or carried over from previous map. Keys that have been picked up in the current level will also be given.

## Known issues

* Monsters inside water will not spawn extras.

## How to install for singleplayer
1. Go to your 'Saved games' quake folder, or your steam quake/rerelease folder. You can get to your saved games folder by pressing Windows+R and typing: %userprofile%\Saved Games\Nightdive Studios\Quake
2. Create a folder called "qenightmareplus"
3. Extract zip into this folder

## How to install for multiplayer
1. Go to your 'Saved games' quake folder, NOT THE STEAM FOLDER. You can go to it by pressing Windows+R and typing: %userprofile%\Saved Games\Nightdive Studios\Quake
2. Create a folder called 'id1'
3. Create another folder and call it 'mpmod'. If you already have this folder, skip this step.
4. Extract zip into the 'id1' folder you created on step 2. If you already have an 'id1' folder, it's likely from another mod. Unfortunately, you'll have to replace it.

## How to run the mod

### For singleplayer
1. Open console and type: `game qenightmareplus`
2. Start a Quake campaign level/game.

### For multiplayer
1. Open console and type: `game mpmod`
2. Start a multiplayer game

### Technical explanation of how multiplayer works.
When you change to mpmod, it sets the root folder to be Saved Games, so next time the game goes into id1 it will use the files from Saved Games and override.

## How to set gamemodes
1. Open console and set the variable 'saved1' to the value you want.
2. Restart map

## Game modes
You can activate multiple gamemodes by adding the values together. (eg: 1+2 = 3)

### 1: No extra monsters
   No extra monsters will be placed.

### 2: Triple monsters
   If enabled, the game will try to triple the amount of monsters instead of double.

### 4: Normal monster health
   Monsters hp will remain the default amount.

### 8: Nightmare 50 hp
   If difficulty is set to nightmare, the maximum amount of health will be capped at 50.

### 16: Normal ammo amount
   The amount of ammo pickups and max ammo will not be increased.
   
### 32: Don't carry items over
   Cooperative: When players spawn, they will not be given weapons or items that have been found or carried over by other players.

### 64: Don't start with extra ammo
   The player will not be given extra ammo for nails, rockets and cells when spawning or starting a map.

### 128: Respawn items
   Items can respawn, even in singleplayer. This applies to health, ammo and armor pickups.
   
### 256: Don't respawn items
   Items will not respawn, even in coop. This applies to health, ammo and armor pickups.
   
### 512: Madness amount of monsters
   If enabled, the game will try to 8x the amount of monsters.

### 1024: Disperse
   Extra monsters will be more dispersed.
   
### 2048: No infighting
   Monsters will not infight among each other.

## Credits
JPiolho: Author
