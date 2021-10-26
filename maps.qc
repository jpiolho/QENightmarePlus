string(string title) GetMapName =
{
    if(mapname == "base32b" && title == "Base 32") {
        return "Base 32 (Nightmare+)";
    } else if(mapname == "death32c" && title == "Death 32") {
        return "Death 32 (Nightmare+)";
    } else if(mapname == "dm1" && title == "Place of Two Deaths") {
        return "Place of Two Deaths (Nightmare+)";
    } else if(mapname == "dm2" && title == "Claustrophobopolis") {
        return "Claustrophobopolis (Nightmare+)";
    } else if(mapname == "dm3" && title == "The Abandoned Base") {
        return "The Abandoned Base (Nightmare+)";
    } else if(mapname == "dm4" && title == "The Bad Place") {
        return "The Bad Place (Nightmare+)";
    } else if(mapname == "dm5" && title == "The Cistern") {
        return "The Cistern (Nightmare+)";
    } else if(mapname == "dm6" && title == "The Dark Zone") {
        return "The Dark Zone (Nightmare+)";
    } else if(mapname == "dm7" && title == "The Edge") {
        return "The Edge (Nightmare+)";
    } else if(mapname == "dm8" && title == "Acrophobia") {
        return "Acrophobia (Nightmare+)";
    } else if(mapname == "e1m1" && title == "The Slipgate Complex") {
        return "The Slipgate Complex (Nightmare+)";
    } else if(mapname == "e1m2" && title == "Castle of the Damned") {
        return "Castle of the Damned (Nightmare+)";
    } else if(mapname == "e1m3" && title == "The Necropolis") {
        return "The Necropolis (Nightmare+)";
    } else if(mapname == "e1m4" && title == "The Grisly Grotto") {
        return "The Grisly Grotto (Nightmare+)";
    } else if(mapname == "e1m5" && title == "Gloom Keep") {
        return "Gloom Keep (Nightmare+)";
    } else if(mapname == "e1m6" && title == "The Door To Chthon") {
        return "The Door To Chthon (Nightmare+)";
    } else if(mapname == "e1m7" && title == "The House of Chthon") {
        return "The House of Chthon (Nightmare+)";
    } else if(mapname == "e1m8" && title == "Ziggurat Vertigo") {
        return "Ziggurat Vertigo (Nightmare+)";
    } else if(mapname == "e2m1" && title == "The Installation") {
        return "The Installation (Nightmare+)";
    } else if(mapname == "e2m2" && title == "The Ogre Citadel") {
        return "The Ogre Citadel (Nightmare+)";
    } else if(mapname == "e2m3" && title == "The Crypt of Decay") {
        return "The Crypt of Decay (Nightmare+)";
    } else if(mapname == "e2m4" && title == "The Ebon Fortress") {
        return "The Ebon Fortress (Nightmare+)";
    } else if(mapname == "e2m5" && title == "The Wizard's Manse") {
        return "The Wizard's Manse (Nightmare+)";
    } else if(mapname == "e2m6" && title == "The Dismal Oubliette") {
        return "The Dismal Oubliette (Nightmare+)";
    } else if(mapname == "e2m7" && title == "The Underearth") {
        return "The Underearth (Nightmare+)";
    } else if(mapname == "e3m1" && title == "Termination Central") {
        return "Termination Central (Nightmare+)";
    } else if(mapname == "e3m2" && title == "The Vaults of Zin") {
        return "The Vaults of Zin (Nightmare+)";
    } else if(mapname == "e3m3" && title == "The Tomb of Terror") {
        return "The Tomb of Terror (Nightmare+)";
    } else if(mapname == "e3m4" && title == "Satan's Dark Delight") {
        return "Satan's Dark Delight (Nightmare+)";
    } else if(mapname == "e3m5" && title == "The Wind Tunnels") {
        return "The Wind Tunnels (Nightmare+)";
    } else if(mapname == "e3m6" && title == "Chambers of Torment") {
        return "Chambers of Torment (Nightmare+)";
    } else if(mapname == "e3m7" && title == "The Haunted Halls") {
        return "The Haunted Halls (Nightmare+)";
    } else if(mapname == "e4m1" && title == "The Sewage System") {
        return "The Sewage System (Nightmare+)";
    } else if(mapname == "e4m2" && title == "The Tower of Despair") {
        return "The Tower of Despair (Nightmare+)";
    } else if(mapname == "e4m3" && title == "The Elder God Shrine") {
        return "The Elder God Shrine (Nightmare+)";
    } else if(mapname == "e4m4" && title == "The Palace of Hate") {
        return "The Palace of Hate (Nightmare+)";
    } else if(mapname == "e4m5" && title == "Hell's Atrium") {
        return "Hell's Atrium (Nightmare+)";
    } else if(mapname == "e4m6" && title == "The Pain Maze") {
        return "The Pain Maze (Nightmare+)";
    } else if(mapname == "e4m7" && title == "Azure Agony") {
        return "Azure Agony (Nightmare+)";
    } else if(mapname == "e4m8" && title == "The Nameless City") {
        return "The Nameless City (Nightmare+)";
    } else if(mapname == "end" && title == "Shub-Niggurath's Pit") {
        return "Shub-Niggurath's Pit (Nightmare+)";
    } else if(mapname == "start" && title == "Introduction") {
        return "Introduction (Nightmare+)";
    }
	
	// Default
	return title;
}