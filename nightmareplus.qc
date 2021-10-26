float(vector start,vector end) NightmarePlus_TestEdge =
{
    if(pointcontents(start) != CONTENT_EMPTY || pointcontents(end) != CONTENT_EMPTY)
        return FALSE;


    if(findradius(start,2) || findradius(end,2))
        return FALSE;

    traceline(start,end,TRUE,world);
    if(!trace_inopen || trace_fraction < 1.0 || trace_ent != world)
        return FALSE;
    
    // Now test the opposite
    traceline(end,start,TRUE,world);
    if(!trace_inopen || trace_fraction < 1.0 || trace_ent != world)
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

    if(!trace_ent) {
        isValid = TRUE;

        traceline(to,from,FALSE,self);

        if(trace_ent)
            isValid = FALSE;
    }
    else {
        isValid = TRUE;
    }

    local vector center = trace_endpos;
    local vector bmin = '-16 -16 -24';
    local vector bmax = '16 16 40';

    draw_bounds(center + bmin,center + bmax,trace_ent ? 251 : 63,0,FALSE);

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

    local float i;
    for(i=0;i<8;i++) {
        local float contents = pointcontents(corners[i]);

        if(contents != CONTENT_EMPTY && contents != CONTENT_WATER)
            return FALSE;
    }
    
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

    local float tries = 64;
    do 
    {
        placement = monster.origin;
        placement_x += randomRange(-128,128);
        placement_y += randomRange(-128,128);

        if(NightmarePlus_TestEdge(monster.origin,placement) && NightmarePlus_TestPlacement(placement,monster.mins,monster.maxs)) {				
            local entity ent = spawn();
            ent.classname = monster.classname;
            ent.origin = placement;

            oself = self;
            self = ent;
            creation();
            self = oself;


            total_monsters++;

            if(cvar("developer"))
                dprint("OK\n");
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

void() nightmareplus_spawner = 
{
    self.think = NightmarePlus_GenerateEnemies;
    self.nextthink = time;
}