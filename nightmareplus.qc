float(vector start,vector end) NightmarePlus_TestEdge =
{
    if(pointcontents(start) != CONTENT_EMPTY || pointcontents(end) != CONTENT_EMPTY)
        return FALSE;

/*
    if(findradius(start,2) || findradius(end,2))
        return FALSE;
*/
    traceline(start,end,FALSE,self);
    if(!trace_inopen || trace_fraction < 1.0 || trace_ent)
        return FALSE;
    
    // Now test the opposite
    traceline(end,start,FALSE,self);
    if(!trace_inopen || trace_fraction < 1.0 || trace_ent)
        return FALSE;

    return TRUE;
}

void() Debug_DrawBounds = 
{
	makevectors (self.v_angle);
	local vector from = self.origin + '0 0 16';
    local vector to = from + v_forward * 256;
	
    local vector isValid = FALSE;

    traceline (from, to, FALSE, self);

    local vector center = trace_endpos;
    local vector bmin = '-16 -16 -24';
    local vector bmax = '16 16 40';

    draw_bounds(center + bmin,center + bmax,trace_ent ? 251 : 63,0,FALSE);

    // Check wall/entities collisions
    local vector vec1;
    local vector vec2;

    vec1_x = center_x + bmin_x;
    vec1_y = center_y;
    vec1_z = center_z;

    vec2_x = center_x + bmax_x;
    vec2_y = center_y;
    vec2_z = center_z;

    draw_line(vec1,vec2,!NightmarePlus_TestEdge(vec1,vec2) ? 251 : 63,FALSE);
    
    vec1_x = center_x;
    vec1_y = center_y + bmax_y;
    vec1_z = center_z;
    
    vec2_x = center_x;
    vec2_y = center_y + bmin_y;
    vec2_z = center_z;
    
    draw_line(vec1,vec2,!NightmarePlus_TestEdge(vec1,vec2) ? 251 : 63,FALSE);
    
    vec1_x = center_x;
    vec1_y = center_y;
    vec1_z = center_z + bmax_z;
    
    vec2_x = center_x;
    vec2_y = center_y;
    vec2_z = center_z + bmin_z;
    
    draw_line(vec1,vec2,!NightmarePlus_TestEdge(vec1,vec2) ? 251 : 63,FALSE);

    /*
    local float radius = 3;
    local vector tmp = center + bmin;
    draw_sphere(tmp,radius,!NightmarePlus_TestEdge(center + bmin,center + bmax) ? 251 : 63,FALSE);
    local vector tmp = center + bmax;
    draw_sphere(tmp,radius,!NightmarePlus_TestEdge(center + bmin,center + bmax) ? 251 : 63,FALSE);
    */
}

float(vector placement,vector monsterMins,vector monsterMaxs) NightmarePlus_TestPlacement = 
{
    local vector corners[8];
    local vector corner;

    // Lower
    corner = placement + monsterMins;
    corners[0] = corner;

    corner_y = placement_y + monsterMaxs_y;
    corners[1] = corner;
    
    corner_x = placement_x + monsterMaxs_x;
    corners[2] = corner;
    
    corner_y = placement_y + monsterMins_y;
    corners[3] = corner;
    
    // Upper
    corner_z = placement_z + monsterMaxs_z;
    corners[4] = corner;
    
    corner_x = placement_x + monsterMins_x;
    corners[5] = corner;
    
    corner_y = placement_y + monsterMaxs_y;
    corners[6] = corner;

    corner_x = placement_x + monsterMaxs_x;
    corners[7] = corner;

    // Check corners
    local float i;
    for(i=0;i<8;i++) {
        local float contents = pointcontents(corners[i]);

        if(contents != CONTENT_EMPTY && contents != CONTENT_WATER)
            return FALSE;
    }


    // Check wall/entities collisions
    local vector vec1;
    local vector vec2;

    vec1_x = placement_x + monsterMins_x;
    vec1_y = placement_y;
    vec1_z = placement_z;

    vec2_x = placement_x + monsterMaxs_x;
    vec2_y = placement_y;
    vec2_z = placement_z;

    if(!NightmarePlus_TestEdge(vec1,vec2))
        return FALSE;
    
    vec1_x = placement_x;
    vec1_y = placement_y + monsterMaxs_y;
    vec1_z = placement_z;

    vec2_x = placement_x;
    vec2_y = placement_y + monsterMins_y;
    vec2_z = placement_z;

    if(!NightmarePlus_TestEdge(vec1,vec2))
        return FALSE;

    vec1_x = placement_x;
    vec1_y = placement_y;
    vec1_z = placement_z + monsterMaxs_z;

    vec2_x = placement_x;
    vec2_y = placement_y;
    vec2_z = placement_z + monsterMins_z;

    if(!NightmarePlus_TestEdge(vec1,vec2))
        return FALSE;
    
    // Final ent check
    local float maxSize = math_max(fabs(monsterMins_x) + fabs(monsterMaxs_x),fabs(monsterMins_y) + fabs(monsterMaxs_y));
    maxSize = math_max(maxSize,fabs(monsterMins_z) + fabs(monsterMaxs_z));

    local entity ent = findradius(placement,maxSize);
    
    while(ent) {
        for(i=0;i<8;i++) {
            local vector entMins = ent.origin + ent.mins;
            local vector entMaxs = ent.origin + ent.maxs;

            if(corners[i] >= entMins && corners[i] <= entMaxs)
                return FALSE;
        }

        ent = ent.chain;
    }
    

    return TRUE;
}

void(entity monster,void() creation) NightmarePlus_CreateEnemy =
{
    local vector placement;
    local entity oself;
    

    if(cvar("developer")) {
        dprint("Generating monster clone for '");
        dprint(monster.classname);
        dprint("' at ");
        dprint(vtos(monster.origin));
        dprint(" -> ");
    }

    local float tries = 256;
    do 
    {
        placement = monster.origin;
        placement_x += randomRange(-128,128);
        placement_y += randomRange(-128,128);

        traceline(monster.origin,placement,FALSE,monster);

        if(trace_fraction == 1.0 && !trace_ent && NightmarePlus_TestPlacement(placement,monster.mins,monster.maxs)) {				
            local entity ent = spawn();
            ent.classname = monster.classname;
            ent.origin = placement;
            ent.impulse = 1;

            oself = self;
            self = ent;
            creation();
            self = oself;

            if(cvar("developer")) {
                dprint("OK\n");
            }
            return;
        }
    }
    while(--tries > 0);

    if(cvar("developer"))
        dprint("FAILED\n");
}




entity nightmarePlus_lastEntity;
entity nightmarePlus_currentEntity;


void() NightmarePlus_GenerateEnemies =
{
    local entity lastEnt;
	local entity p;
	local entity ent;
	local float entitiesThisFrame = 0;

    if(!nightmarePlus_lastEntity) {
        // First, find the last entity
        p = world;
        while(p = nextent(p))
            nightmarePlus_lastEntity = p;

        nightmarePlus_currentEntity = world;
    }


	// Now loop through all entities, and end at the last entity
	p = nightmarePlus_currentEntity;
	while(p != nightmarePlus_lastEntity && p = nextent(p))
	{
        entitiesThisFrame++;

        
        if(entitiesThisFrame >= 45) {
            self.nextthink = time;
            return;
        }
            

        if (p.classname == "monster_army")
            NightmarePlus_CreateEnemy(p,monster_army);
        else if (p.classname == "monster_demon1")
            NightmarePlus_CreateEnemy(p,monster_demon1);
        else if (p.classname == "monster_dog")
            NightmarePlus_CreateEnemy(p,monster_dog);
        else if (p.classname == "monster_enforcer")
            NightmarePlus_CreateEnemy(p,monster_enforcer);
        else if (p.classname == "monster_fish")
            NightmarePlus_CreateEnemy(p,monster_fish);
        else if (p.classname == "monster_hell_knight")
            NightmarePlus_CreateEnemy(p,monster_hell_knight);
        else if (p.classname == "monster_knight")
            NightmarePlus_CreateEnemy(p,monster_knight);
        else if (p.classname == "monster_ogre")
            NightmarePlus_CreateEnemy(p,monster_ogre);
        else if (p.classname == "monster_shalrath")
            NightmarePlus_CreateEnemy(p,monster_shalrath);
        else if (p.classname == "monster_shambler")
            NightmarePlus_CreateEnemy(p,monster_shambler);
        else if (p.classname == "monster_tarbaby")
            NightmarePlus_CreateEnemy(p,monster_tarbaby);
        else if (p.classname == "monster_wizard")
            NightmarePlus_CreateEnemy(p,monster_wizard);
        else if (p.classname == "monster_zombie" && !(p.spawnflags & SPAWN_CRUCIFIED))
            NightmarePlus_CreateEnemy(p,monster_zombie);


        // Advance the iterator
        nightmarePlus_currentEntity = p;
	}

    remove(self);
}


void() nightmareplus_spawner_think =
{
    local entity monster = self.trigger_field;

    if (monster.classname == "monster_army")
        NightmarePlus_CreateEnemy(monster,monster_army);
    else if (monster.classname == "monster_demon1")
        NightmarePlus_CreateEnemy(monster,monster_demon1);
    else if (monster.classname == "monster_dog")
        NightmarePlus_CreateEnemy(monster,monster_dog);
    else if (monster.classname == "monster_enforcer")
        NightmarePlus_CreateEnemy(monster,monster_enforcer);
    else if (monster.classname == "monster_fish")
        NightmarePlus_CreateEnemy(monster,monster_fish);
    else if (monster.classname == "monster_hell_knight")
        NightmarePlus_CreateEnemy(monster,monster_hell_knight);
    else if (monster.classname == "monster_knight")
        NightmarePlus_CreateEnemy(monster,monster_knight);
    else if (monster.classname == "monster_ogre")
        NightmarePlus_CreateEnemy(monster,monster_ogre);
    else if (monster.classname == "monster_shalrath")
        NightmarePlus_CreateEnemy(monster,monster_shalrath);
    else if (monster.classname == "monster_shambler")
        NightmarePlus_CreateEnemy(monster,monster_shambler);
    else if (monster.classname == "monster_tarbaby")
        NightmarePlus_CreateEnemy(monster,monster_tarbaby);
    else if (monster.classname == "monster_wizard")
        NightmarePlus_CreateEnemy(monster,monster_wizard);
    else if (monster.classname == "monster_zombie")
        NightmarePlus_CreateEnemy(monster,monster_zombie);

    remove(self);
}

void() nightmareplus_spawner = 
{
    if(!self.trigger_field)
        objerror("self.trigger_field not set.");

    self.think = nightmareplus_spawner_think;
    self.nextthink = time;
}


void() NightmarePlus_CreateSpawnerIfNeeded =
{
    if(gamemode & GM_NO_EXTRA_MONSTERS)
        return;

    if(self.impulse == 1)
        return;


    local float total = 1;

    if(gamemode & GM_TRIPLE_MONSTERS)
        total = 2;

    local float i;
    for(i=0;i<total;i++) {
        local entity ent = spawn();
        ent.classname = "nightmareplus_spawner";
        ent.trigger_field = self;
        ent.origin = self.origin;

        local entity oself = self;
        self = ent;
        nightmareplus_spawner();
        self = oself;
    }
}

void() NightmarePlus_LoadGamemode =
{
    monsters_health_modifier = gamemode & GM_NORMAL_MONSTER_HEALTH ? 1 : 2;
    items_ammo_modifier = gamemode & GM_NORMAL_AMMO_AMOUNT ? 1 : 1.50;
}

float(float amount) NightmarePlus_GetAmmoAmount =
{
    return rint(amount * items_ammo_modifier);
}