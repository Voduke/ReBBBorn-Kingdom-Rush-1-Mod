local a = {
	blood_pool_red = {
		prefix = "decal_blood",
		to = 1,
		from = 1
	},
	blood_pool_green = {
		prefix = "decal_blood",
		to = 2,
		from = 2
	},
	blood_pool_violet = {
		prefix = "decal_blood",
		to = 3,
		from = 3
	},
	blood_pool_gray = {
		prefix = "decal_blood",
		to = 4,
		from = 4
	},
	ground_hit_decal = {
		prefix = "decal_smoke_hitground",
		to = 12,
		from = 1
	},
	freeze_creep_ground_start = {
		prefix = "freeze_creep",
		to = 7,
		from = 1
	},
	freeze_creep_ground_end = {
		prefix = "freeze_creep",
		to = 23,
		from = 8
	},
	freeze_creep_air_start = {
		prefix = "freeze_creepFlying",
		to = 9,
		from = 1
	},
	freeze_creep_air_end = {
		prefix = "freeze_creepFlying",
		to = 21,
		from = 10
	},
	ps_shotgun_musketeer = {
		prefix = "particle_sniper_bullet",
		to = 13,
		from = 1
	},
	blood_splat_red = {
		prefix = "fx_blood_splat_red",
		to = 10,
		from = 1
	},
	blood_splat_green = {
		prefix = "fx_blood_splat_green",
		to = 10,
		from = 1
	},
	blood_splat_gray = {
		prefix = "fx_blood_splat_gray",
		to = 10,
		from = 1
	},
	blood_splat_violet = {
		prefix = "fx_blood_splat_violet",
		to = 10,
		from = 1
	},
	explode_small = {
		prefix = "states_small",
		to = 32,
		from = 22
	},
	explode_big = {
		prefix = "states_big",
		to = 32,
		from = 22
	},
	desintegrate_soldier = {
		prefix = "states_soldiers",
		to = 15,
		from = 1
	},
	desintegrate_enemy_small = {
		prefix = "states_small",
		to = 47,
		from = 33
	},
	desintegrate_enemy_big = {
		prefix = "states_big",
		to = 47,
		from = 33
	},
	desintegrate_enemy_air_small = {
		prefix = "states_small",
		to = 72,
		from = 59
	},
	explosion_big = {
		prefix = "explosion_big",
		to = 20,
		from = 3
	},
	explosion_fragment = {
		prefix = "explosion_fragment",
		to = 18,
		from = 1
	},
	explosion_air = {
		prefix = "explosion_air",
		to = 18,
		from = 1
	},
	explosion_shrapnel = {
		prefix = "explosion_shrapnel",
		to = 20,
		from = 1
	},
	explosion_rotten_shot = {
		prefix = "Explosion_RottenShot",
		to = 11,
		from = 1
	},
	explosion_flare_flareon = {
		prefix = "Inferno_Flareon_Explosion",
		to = 13,
		from = 1
	},
		rabbit_idle = {
		prefix = "rabbit",
		to = 8,
		from = 8
	},
	rabbit_walkingRightLeft = {
		prefix = "rabbit",
		to = 11,
		from = 1
	},
	rabbit_walkingUp = {
		prefix = "rabbit",
		to = 22,
		from = 12
	},
	rabbit_walkingDown = {
		prefix = "rabbit",
		to = 33,
		from = 23
	},
	rabbit_death = {
		prefix = "rabbit",
		to = 44,
		from = 34
	},
	decal_pixie_idle = {
		prefix = "pixie",
		to = 1,
		from = 1
	},
	decal_pixie_scratch = {
		prefix = "pixie",
		to = 18,
		from = 2
	},
	decal_pixie_harvester = {
		prefix = "pixie",
		to = 40,
		from = 19
	},
	decal_pixie_attack = {
		prefix = "pixie",
		to = 60,
		from = 41
	},
	decal_pixie_teleportOut = {
		prefix = "pixie",
		to = 75,
		from = 61
	},
	decal_pixie_teleportIn = {
		prefix = "pixie",
		to = 86,
		from = 76
	},
	decal_pixie_shoot = {
		prefix = "pixie",
		to = 100,
		from = 87
	},
	decal_pixie_walk = {
		prefix = "pixie",
		to = 107,
		from = 101
	},
	fx_bullet_pixie_instakill_hit = {
		prefix = "pixie_mushroomHit_big",
		to = 17,
		from = 1
	},
	fx_bullet_pixie_poison_hit = {
		prefix = "pixie_bottleHit_big",
		to = 16,
		from = 1
	},
	fx_mod_pixie_polymorph = {
		prefix = "pixie_polymorph_smoke_big",
		to = 11,
		from = 1
	},
	fx_mod_pixie_teleport_small = {
		prefix = "pixie_teleport_small",
		to = 10,
		from = 1
	},
	fx_mod_pixie_teleport_big = {
		prefix = "pixie_teleport_big",
		to = 10,
		from = 1
	},
	soldier_pirate_captain_idle = {
			prefix = "soldier_pirate_cap",
			to = 1,
			from = 1
		},
		soldier_pirate_captain_running = {
			prefix = "soldier_pirate_cap",
			to = 6,
			from = 2
		},
		soldier_pirate_captain_attack = {
			to = 17,
			from = 7,
			prefix = "soldier_pirate_cap",
			post = {
				1
			}
		},
		soldier_pirate_captain_death = {
			prefix = "soldier_pirate_cap",
			to = 24,
			from = 17
		},
		soldier_pirate_flamer_idle = {
			prefix = "soldier_pirate_flamer",
			to = 1,
			from = 1
		},
		soldier_pirate_flamer_running = {
			prefix = "soldier_pirate_flamer",
			to = 6,
			from = 2
		},
		soldier_pirate_flamer_attack = {
			to = 38,
			from = 19,
			prefix = "soldier_pirate_flamer",
			post = {
				1
			}
		},
		soldier_pirate_flamer_ranged_attack = {
			to = 18,
			from = 7,
			prefix = "soldier_pirate_flamer",
			post = {
				1
			}
		},
		soldier_pirate_flamer_death = {
			prefix = "soldier_pirate_flamer",
			to = 45,
			from = 39
		},
		explosion_molotov = {
			prefix = "proy_molotov_explosion",
			to = 18,
			from = 1
		},
		soldier_pirate_anchor_idle = {
			prefix = "fatPirate",
			to = 1,
			from = 1
		},
		soldier_pirate_anchor_running = {
			prefix = "fatPirate",
			to = 23,
			from = 2
		},
		soldier_pirate_anchor_attack = {
			prefix = "fatPirate",
			to = 47,
			from = 24
		},
		soldier_pirate_anchor_death = {
			prefix = "fatPirate",
			to = 67,
			from = 48
		},
		tower_merc_camp_pirates_idle = {
			prefix = "merc_camp_pirates",
			to = 1,
			from = 1
		},
		tower_merc_camp_pirates_open = {
			prefix = "merc_camp_pirates",
			to = 4,
			from = 1
		},
		tower_merc_camp_pirates_close = {
			prefix = "merc_camp_pirates",
			to = 1,
			from = 4
		},
	towerneptune_gems_1_empty = {
			prefix = "neptuno_gems_layer1",
			to = 1,
			from = 1
		},
		towerneptune_gems_1_ready = {
			prefix = "neptuno_gems_layer1",
			to = 21,
			from = 2
		},
		towerneptune_gems_1_shoot = {
			prefix = "neptuno_gems_layer1",
			to = 34,
			from = 22
		},
		towerneptune_gems_2_empty = {
			prefix = "neptuno_gems_layer2",
			to = 1,
			from = 1
		},
		towerneptune_gems_2_ready = {
			prefix = "neptuno_gems_layer2",
			to = 21,
			from = 2
		},
		towerneptune_gems_2_shoot = {
			prefix = "neptuno_gems_layer2",
			to = 34,
			from = 22
		},
		towerneptune_gems_3_empty = {
			prefix = "neptuno_gems_layer3",
			to = 1,
			from = 1
		},
		towerneptune_gems_3_ready = {
			prefix = "neptuno_gems_layer3",
			to = 21,
			from = 2
		},
		towerneptune_gems_3_shoot = {
			prefix = "neptuno_gems_layer3",
			to = 34,
			from = 22
		},
		towerneptune_gems_eyes_empty = {
			prefix = "neptuno_gems_layer4",
			to = 1,
			from = 1
		},
		towerneptune_gems_eyes_ready = {
			prefix = "neptuno_gems_layer4",
			to = 21,
			from = 2
		},
		towerneptune_gems_eyes_shoot = {
			prefix = "neptuno_gems_layer4",
			to = 34,
			from = 22
		},
		towerneptune_gems_trident_empty = {
			prefix = "neptuno_gems_layer5",
			to = 1,
			from = 1
		},
		towerneptune_gems_trident_ready = {
			prefix = "neptuno_gems_layer5",
			to = 21,
			from = 2
		},
		towerneptune_gems_trident_shoot = {
			prefix = "neptuno_gems_layer5",
			to = 34,
			from = 22
		},
		towerneptune_charging = {
			prefix = "neptuno_energy",
			to = 26,
			from = 1
		},
		towerneptune_charged = {
			prefix = "neptuno_energy2",
			to = 26,
			from = 1
		},
		towerneptune_trident_glow = {
			prefix = "neptuno_glow",
			to = 20,
			from = 1
		},
		towerneptune_tip_glow_pick = {
			prefix = "neptuno_glow_2",
			to = 5,
			from = 5
		},
		towerneptune_tip_glow_shoot = {
			prefix = "neptuno_glow_2",
			to = 14,
			from = 1
		},
		ray_neptune_explosion = {
			prefix = "neptuno_explosion",
			to = 16,
			from = 1
		},
		ray_neptune = {
			prefix = "neptuno_ray",
			to = 10,
			from = 1
		},
	soldiermecha_idle = {
			prefix = "Mecha",
			to = 1,
			from = 1
		},
		soldiermecha_running = {
			prefix = "Mecha",
			to = 21,
			from = 2
		},
		soldiermecha_bombright = {
			prefix = "Mecha",
			to = 47,
			from = 23
		},
		soldiermecha_bombleft = {
			prefix = "Mecha",
			to = 70,
			from = 48
		},
		soldiermecha_missilestart = {
			prefix = "Mecha",
			to = 82,
			from = 72
		},
		soldiermecha_missileloop = {
			prefix = "Mecha",
			to = 104,
			from = 83
		},
		soldiermecha_missileend = {
			prefix = "Mecha",
			to = 108,
			from = 105
		},
		soldiermecha_oilposture = {
			prefix = "Mecha",
			to = 145,
			from = 109
		},
		soldiermechaoil_idle = {
			prefix = "Mecha_Shitting",
			to = 1,
			from = 1
		},
		soldiermechaoil_oilposture = {
			prefix = "Mecha_Shitting",
			to = 145,
			from = 109
		},
		missile_mecha_flying = {
			prefix = "mech_missile",
			to = 3,
			from = 1
		},
		towermecha_layer1_idle = {
			prefix = "tower_mechs_layer1",
			to = 53,
			from = 53
		},
		towermecha_layer2_idle = {
			prefix = "tower_mechs_layer2",
			to = 53,
			from = 53
		},
		towermecha_layer3_idle = {
			prefix = "tower_mechs_layer3",
			to = 53,
			from = 53
		},
		towermecha_layer4_idle = {
			prefix = "tower_mechs_layer4",
			to = 53,
			from = 53
		},
		towermecha_layer5_idle = {
			prefix = "tower_mechs_layer5",
			to = 53,
			from = 53
		},
		towermecha_layer6_idle = {
			prefix = "tower_mechs_layer6",
			to = 53,
			from = 53
		},
		towermecha_layer7_idle = {
			prefix = "tower_mechs_layer7",
			to = 53,
			from = 53
		},
		towermecha_layer8_idle = {
			prefix = "tower_mechs_layer8",
			to = 53,
			from = 53
		},
		towermecha_layer9_idle = {
			prefix = "tower_mechs_layer9",
			to = 53,
			from = 53
		},
		towermecha_layer1_open = {
			prefix = "tower_mechs_layer1",
			to = 26,
			from = 1
		},
		towermecha_layer2_open = {
			prefix = "tower_mechs_layer2",
			to = 26,
			from = 1
		},
		towermecha_layer3_open = {
			prefix = "tower_mechs_layer3",
			to = 26,
			from = 1
		},
		towermecha_layer4_open = {
			prefix = "tower_mechs_layer4",
			to = 26,
			from = 1
		},
		towermecha_layer5_open = {
			prefix = "tower_mechs_layer5",
			to = 26,
			from = 1
		},
		towermecha_layer6_open = {
			prefix = "tower_mechs_layer6",
			to = 26,
			from = 1
		},
		towermecha_layer7_open = {
			prefix = "tower_mechs_layer7",
			to = 26,
			from = 1
		},
		towermecha_layer8_open = {
			prefix = "tower_mechs_layer8",
			to = 26,
			from = 1
		},
		towermecha_layer9_open = {
			prefix = "tower_mechs_layer9",
			to = 26,
			from = 1
		},
		towermecha_layer1_hold = {
			prefix = "tower_mechs_layer1",
			to = 27,
			from = 27
		},
		towermecha_layer2_hold = {
			prefix = "tower_mechs_layer2",
			to = 27,
			from = 27
		},
		towermecha_layer3_hold = {
			prefix = "tower_mechs_layer3",
			to = 27,
			from = 27
		},
		towermecha_layer4_hold = {
			prefix = "tower_mechs_layer4",
			to = 27,
			from = 27
		},
		towermecha_layer5_hold = {
			prefix = "tower_mechs_layer5",
			to = 27,
			from = 27
		},
		towermecha_layer6_hold = {
			prefix = "tower_mechs_layer6",
			to = 27,
			from = 27
		},
		towermecha_layer7_hold = {
			prefix = "tower_mechs_layer7",
			to = 27,
			from = 27
		},
		towermecha_layer8_hold = {
			prefix = "tower_mechs_layer8",
			to = 27,
			from = 27
		},
		towermecha_layer9_hold = {
			prefix = "tower_mechs_layer9",
			to = 27,
			from = 27
		},
		towermecha_layer1_close = {
			prefix = "tower_mechs_layer1",
			to = 53,
			from = 27
		},
		towermecha_layer2_close = {
			prefix = "tower_mechs_layer2",
			to = 53,
			from = 27
		},
		towermecha_layer3_close = {
			prefix = "tower_mechs_layer3",
			to = 53,
			from = 27
		},
		towermecha_layer4_close = {
			prefix = "tower_mechs_layer4",
			to = 53,
			from = 27
		},
		towermecha_layer5_close = {
			prefix = "tower_mechs_layer5",
			to = 53,
			from = 27
		},
		towermecha_layer6_close = {
			prefix = "tower_mechs_layer6",
			to = 53,
			from = 27
		},
		towermecha_layer7_close = {
			prefix = "tower_mechs_layer7",
			to = 53,
			from = 27
		},
		towermecha_layer8_close = {
			prefix = "tower_mechs_layer8",
			to = 53,
			from = 27
		},
		towermecha_layer9_close = {
			prefix = "tower_mechs_layer9",
			to = 53,
			from = 27
		},
	tower_build_dust = {
		prefix = "effect_buildSmoke",
		to = 12,
		from = 1
	},
	tower_sell_dust = {
		prefix = "effect_sellSmoke",
		to = 12,
		from = 1
	},
	coin_jump = {
		prefix = "nextwave_coin",
		to = 14,
		from = 1
	},
	fx_coin_jump = {
		prefix = "fx_coin_jump",
		to = 14,
		from = 1
	},
	smoke_bullet = {
		prefix = "fx_bullet_smoke",
		to = 12,
		from = 1
	},
	fx_rifle_smoke = {
		prefix = "fx_rifle_smoke",
		to = 11,
		from = 1
	},
	fx_teleport_arcane_small = {
		prefix = "states_small",
		to = 10,
		from = 1
	},
	fx_teleport_arcane_big = {
		prefix = "states_big",
		to = 10,
		from = 1
	},
	fx_mod_polymorph_sorcerer_small = {
		prefix = "states_small",
		to = 21,
		from = 11
	},
	fx_mod_polymorph_sorcerer_big = {
		prefix = "states_big",
		to = 21,
		from = 11
	},
	ground_hit_smoke = {
		prefix = "fx_smoke_hitground",
		to = 14,
		from = 1
	},
	fx_shield_small = {
		prefix = "shield_small",
		to = 11,
		from = 1
	},
	fx_demon_portal_out_small = {
		prefix = "states_small",
		to = 82,
		from = 73
	},
	fx_demon_portal_out_big = {
		prefix = "states_big",
		to = 68,
		from = 59
	},
	healing_small = {
		prefix = "healing_small",
		to = 24,
		from = 1
	},
	healing_medium = {
		prefix = "healing_big",
		to = 24,
		from = 1
	},
	healing_large = {
		prefix = "healing_boss_type1",
		to = 24,
		from = 1
	},
	bleeding_small_red = {
		prefix = "bleeding_small_red",
		to = 12,
		from = 1
	},
	bleeding_small_gray = {
		prefix = "bleeding_small_gray",
		to = 12,
		from = 1
	},
	bleeding_small_green = {
		prefix = "bleeding_small_green",
		to = 12,
		from = 1
	},
	bleeding_small_violet = {
		prefix = "bleeding_small_violet",
		to = 12,
		from = 1
	},
	bleeding_big_red = {
		prefix = "bleeding_big_red",
		to = 12,
		from = 1
	},
	bleeding_big_gray = {
		prefix = "bleeding_big_gray",
		to = 12,
		from = 1
	},
	bleeding_big_green = {
		prefix = "bleeding_big_green",
		to = 12,
		from = 1
	},
	bleeding_big_violet = {
		prefix = "bleeding_big_violet",
		to = 12,
		from = 1
	},
	stun_big_loop = {
		prefix = "stun_big",
		to = 26,
		from = 1
	},
	stun_small_loop = {
		prefix = "stun_small",
		to = 26,
		from = 1
	},
	poison_small = {
		prefix = "poison_small",
		to = 12,
		from = 1
	},
	poison_big = {
		prefix = "poison_big",
		to = 12,
		from = 1
	},
	poison_violet_small = {
		prefix = "poison_small_violet",
		to = 12,
		from = 1
	},
	mod_thorn_small_start = {
		prefix = "thorn_small",
		to = 18,
		from = 1
	},
	mod_thorn_small_loop = {
		prefix = "thorn_small",
		to = 18,
		from = 18
	},
	mod_thorn_small_end = {
		prefix = "thorn_small",
		to = 24,
		from = 19
	},
	mod_thorn_big_start = {
		prefix = "thorn_big",
		to = 18,
		from = 1
	},
	mod_thorn_big_loop = {
		prefix = "thorn_big",
		to = 18,
		from = 18
	},
	mod_thorn_big_end = {
		prefix = "thorn_big",
		to = 24,
		from = 19
	},
	mod_gerald_courage = {
		prefix = "hero_barracks_buff",
		to = 28,
		from = 1
	},
	fire_medium = {
		prefix = "fire_big",
		to = 10,
		from = 1
	},
	fire_small = {
		prefix = "fire_small",
		to = 10,
		from = 1
	},
	fire_large = {
		prefix = "fire_boss_type1",
		to = 10,
		from = 1
	},
	mod_troll_rage = {
		prefix = "rage_small",
		to = 27,
		from = 1
	},
	fireball_proyectile = {
		prefix = "fireball_proyectile",
		to = 6,
		from = 1
	},
	fireball_shadow = {
		prefix = "fireball_shadow",
		to = 20,
		from = 1
	},
	fireball_explosion = {
		prefix = "fireball_explosion",
		to = 18,
		from = 1
	},
	fireball_particle = {
		prefix = "fireball_particle",
		to = 4,
		from = 1
	},
	enemy_sheep_ground_death = {
		prefix = "sheep",
		to = 59,
		from = 49
	},
	
	enemy_sheep_ground_idle = {
		prefix = "sheep",
		to = 25,
		from = 25
	},
	enemy_sheep_ground_walkingRightLeft = {
		prefix = "sheep",
		to = 8,
		from = 1
	},
	enemy_sheep_ground_walkingDown = {
		prefix = "sheep",
		to = 24,
		from = 17
	},
	enemy_sheep_ground_walkingUp = {
		prefix = "sheep",
		to = 16,
		from = 9
	},
	enemy_sheep_fly_death = {
		prefix = "sheep_flying",
		to = 44,
		from = 34
	},
	enemy_sheep_fly_idle = {
		prefix = "sheep_flying",
		to = 11,
		from = 1
	},
	enemy_sheep_fly_walkingRightLeft = {
		prefix = "sheep_flying",
		to = 11,
		from = 1
	},
	enemy_sheep_fly_walkingDown = {
		prefix = "sheep_flying",
		to = 33,
		from = 23
	},
	enemy_sheep_fly_walkingUp = {
		prefix = "sheep_flying",
		to = 22,
		from = 12
	},
	twilight_golem_idle = {
		prefix = "gollem",
		to = 30,
		from = 1
	},
	twilight_golem_walkingRightLeft = {
		prefix = "gollem",
		to = 30,
		from = 1
	},
	twilight_golem_walkingDown = {
		prefix = "gollem",
		to = 60,
		from = 31
	},
	twilight_golem_walkingUp = {
		prefix = "gollem",
		to = 90,
		from = 61
	},
	twilight_golem_attack = {
		prefix = "gollem",
		to = 118,
		from = 91
	},
	twilight_golem_death = {
		prefix = "gollem",
		to = 146,
		from = 119
	},
	goblin_attack = {
		prefix = "goblin",
		to = 82,
		from = 70
	},
	goblin_death = {
		prefix = "goblin",
		to = 120,
		from = 106
	},
	goblin_idle = {
		prefix = "goblin",
		to = 67,
		from = 67
	},
	goblin_thorn = {
		prefix = "goblin",
		to = 101,
		from = 83
	},
	goblin_thornFree = {
		prefix = "goblin",
		to = 106,
		from = 102
	},
	goblin_walkingDown = {
		prefix = "goblin",
		to = 66,
		from = 45
	},
	goblin_walkingRightLeft = {
		prefix = "goblin",
		to = 22,
		from = 1
	},
	goblin_walkingUp = {
		prefix = "goblin",
		to = 44,
		from = 23
	},
	enemy_fat_orc_attack = {
		prefix = "orc",
		to = 77,
		from = 68
	},
	enemy_fat_orc_death = {
		prefix = "orc",
		to = 108,
		from = 102
	},
	enemy_fat_orc_idle = {
		prefix = "orc",
		to = 67,
		from = 67
	},
	enemy_fat_orc_thorn = {
		prefix = "orc",
		to = 96,
		from = 78
	},
	enemy_fat_orc_thornFree = {
		prefix = "orc",
		to = 101,
		from = 97
	},
	enemy_fat_orc_walkingDown = {
		prefix = "orc",
		to = 66,
		from = 45
	},
	enemy_fat_orc_walkingRightLeft = {
		prefix = "orc",
		to = 22,
		from = 1
	},
	enemy_fat_orc_walkingUp = {
		prefix = "orc",
		to = 44,
		from = 23
	},
	enemy_wolf_small_attack = {
		prefix = "wulf",
		to = 44,
		from = 31
	},
	enemy_wolf_small_death = {
		prefix = "wulf",
		to = 85,
		from = 69
	},
	enemy_wolf_small_idle = {
		prefix = "wulf",
		to = 31,
		from = 31
	},
	enemy_wolf_small_thorn = {
		prefix = "wulf",
		to = 63,
		from = 44
	},
	enemy_wolf_small_thornFree = {
		prefix = "wulf",
		to = 69,
		from = 65
	},
	enemy_wolf_small_walkingDown = {
		prefix = "wulf",
		to = 30,
		from = 21
	},
	enemy_wolf_small_walkingRightLeft = {
		prefix = "wulf",
		to = 10,
		from = 1
	},
	enemy_wolf_small_walkingUp = {
		prefix = "wulf",
		to = 20,
		from = 11
	},
	enemy_wolf_attack = {
		prefix = "worg",
		to = 44,
		from = 31
	},
	enemy_wolf_death = {
		prefix = "worg",
		to = 84,
		from = 69
	},
	enemy_wolf_idle = {
		prefix = "worg",
		to = 31,
		from = 31
	},
	enemy_wolf_thorn = {
		prefix = "worg",
		to = 63,
		from = 44
	},
	enemy_wolf_thornFree = {
		prefix = "worg",
		to = 69,
		from = 65
	},
	enemy_wolf_walkingDown = {
		prefix = "worg",
		to = 30,
		from = 21
	},
	enemy_wolf_walkingRightLeft = {
		prefix = "worg",
		to = 10,
		from = 1
	},
	enemy_wolf_walkingUp = {
		prefix = "worg",
		to = 20,
		from = 11
	},
	enemy_shadow_archer_attack = {
		to = 74,
		from = 68,
		prefix = "shadowArcher",
		post = {
			74,
			74,
			74
		}
	},
	enemy_shadow_archer_death = {
		prefix = "shadowArcher",
		to = 119,
		from = 112
	},
	enemy_shadow_archer_idle = {
		prefix = "shadowArcher",
		to = 67,
		from = 67
	},
	enemy_shadow_archer_shoot = {
		prefix = "shadowArcher",
		to = 88,
		from = 75
	},
	enemy_shadow_archer_thorn = {
		prefix = "shadowArcher",
		to = 86,
		from = 67
	},
	enemy_shadow_archer_thornFree = {
		prefix = "shadowArcher",
		to = 113,
		from = 108
	},
	enemy_shadow_archer_walkingDown = {
		prefix = "shadowArcher",
		to = 66,
		from = 45
	},
	enemy_shadow_archer_walkingRightLeft = {
		prefix = "shadowArcher",
		to = 22,
		from = 1
	},
	enemy_shadow_archer_walkingUp = {
		prefix = "shadowArcher",
		to = 44,
		from = 23
	},
	enemy_shaman_attack = {
		prefix = "shaman",
		to = 84,
		from = 67
	},
	enemy_shaman_death = {
		prefix = "shaman",
		to = 142,
		from = 136
	},
	enemy_shaman_idle = {
		prefix = "shaman",
		to = 67,
		from = 67
	},
	enemy_shaman_heal = {
		prefix = "shaman",
		to = 111,
		from = 88
	},
	enemy_shaman_thorn = {
		prefix = "shaman",
		to = 130,
		from = 112
	},
	enemy_shaman_thornFree = {
		prefix = "shaman",
		to = 135,
		from = 131
	},
	enemy_shaman_walkingDown = {
		prefix = "shaman",
		to = 66,
		from = 45
	},
	enemy_shaman_walkingRightLeft = {
		prefix = "shaman",
		to = 22,
		from = 1
	},
	enemy_shaman_walkingUp = {
		prefix = "shaman",
		to = 44,
		from = 23
	},
	enemy_gargoyle_death = {
		prefix = "gargoyle",
		to = 54,
		from = 43
	},
	enemy_gargoyle_idle = {
		prefix = "gargoyle",
		to = 14,
		from = 1
	},
	enemy_gargoyle_walkingDown = {
		prefix = "gargoyle",
		to = 42,
		from = 29
	},
	enemy_gargoyle_walkingRightLeft = {
		prefix = "gargoyle",
		to = 14,
		from = 1
	},
	enemy_gargoyle_walkingUp = {
		prefix = "gargoyle",
		to = 28,
		from = 15
	},
	enemy_cursed_shaman_attack = {
		prefix = "cursed_shaman",
		to = 69,
		from = 56
	},
	enemy_cursed_shaman_death = {
		prefix = "cursed_shaman",
		to = 85,
		from = 70
	},
	enemy_cursed_shaman_idle = {
		prefix = "cursed_shaman",
		to = 19,
		from = 19
	},
	enemy_cursed_shaman_shoot = {
		prefix = "cursed_shaman",
		to = 115,
		from = 104
	},
	enemy_cursed_shaman_heal = {
		prefix = "cursed_shaman",
		to = 103,
		from = 86
	},
	enemy_cursed_shaman_thorn = {
		prefix = "cursed_shaman",
		to = 130,
		from = 112
	},
	enemy_cursed_shaman_thornFree = {
		prefix = "cursed_shaman",
		to = 135,
		from = 131
	},
	enemy_cursed_shaman_walkingDown = {
		prefix = "cursed_shaman",
		to = 55,
		from = 38
	},
	enemy_cursed_shaman_walkingRightLeft = {
		prefix = "cursed_shaman",
		to = 18,
		from = 1
	},
	enemy_cursed_shaman_walkingUp = {
		prefix = "cursed_shaman",
		to = 37,
		from = 20
	},
	enemy_hobgoblin_small_attack = {
		prefix = "hobgoblin_small",
		to = 10,
		from = 2
	},
	enemy_hobgoblin_small_death = {
		prefix = "hobgoblin_small",
		to = 83,
		from = 77
	},
	enemy_hobgoblin_small_idle = {
		prefix = "hobgoblin_small",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_small_thorn = {
		prefix = "hobgoblin_small",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_small_thornFree = {
		prefix = "hobgoblin_small",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_small_walkingDown = {
		prefix = "hobgoblin_small",
		to = 76,
		from = 55
	},
	enemy_hobgoblin_small_walkingRightLeft = {
		prefix = "hobgoblin_small",
		to = 32,
		from = 11
	},
	enemy_hobgoblin_small_walkingUp = {
		prefix = "hobgoblin_small",
		to = 54,
		from = 33
	},
	enemy_hobgoblin_rider_attack = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_death = {
		prefix = "worg",
		to = 84,
		from = 69
	},
	enemy_hobgoblin_rider_idle = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_thorn = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_thornFree = {
		prefix = "hobgoblin_rider",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_rider_walkingDown = {
		prefix = "hobgoblin_rider",
		to = 30,
		from = 21
	},
	enemy_hobgoblin_rider_walkingRightLeft = {
		prefix = "hobgoblin_rider",
		to = 10,
		from = 2
	},
	enemy_hobgoblin_rider_walkingUp = {
		prefix = "hobgoblin_rider",
		to = 20,
		from = 11
	},
	enemy_hobgoblin_rider_runningDown = {
		prefix = "hobgoblin_rider",
		to = 48,
		from = 44
	},
	enemy_hobgoblin_rider_runningRightLeft = {
		prefix = "hobgoblin_rider",
		to = 38,
		from = 31
	},
	enemy_hobgoblin_rider_runningUp = {
		prefix = "hobgoblin_rider",
		to = 43,
		from = 39
	},
	enemy_ogre_attack = {
		prefix = "ogre",
		to = 106,
		from = 80
	},
	enemy_ogre_death = {
		prefix = "ogre",
		to = 145,
		from = 130
	},
	enemy_ogre_idle = {
		prefix = "ogre",
		to = 80,
		from = 80
	},
	enemy_ogre_thorn = {
		prefix = "ogre",
		to = 125,
		from = 107
	},
	enemy_ogre_thornFree = {
		prefix = "ogre",
		to = 129,
		from = 126
	},
	enemy_ogre_walkingDown = {
		prefix = "ogre",
		to = 78,
		from = 53
	},
	enemy_ogre_walkingRightLeft = {
		prefix = "ogre",
		to = 26,
		from = 1
	},
	enemy_ogre_walkingUp = {
		prefix = "ogre",
		to = 52,
		from = 27
	},
	enemy_spider_tiny_attack = {
		prefix = "spider_tiny",
		to = 46,
		from = 28
	},
	enemy_spider_tiny_death = {
		prefix = "spider_tiny",
		to = 84,
		from = 70
	},
	enemy_spider_tiny_idle = {
		prefix = "spider_tiny",
		to = 28,
		from = 28
	},
	enemy_spider_tiny_thorn = {
		prefix = "spider_tiny",
		to = 65,
		from = 47
	},
	enemy_spider_tiny_thornFree = {
		prefix = "spider_tiny",
		to = 70,
		from = 66
	},
	enemy_spider_tiny_walkingDown = {
		prefix = "spider_tiny",
		to = 27,
		from = 19
	},
	enemy_spider_tiny_walkingRightLeft = {
		prefix = "spider_tiny",
		to = 9,
		from = 1
	},
	enemy_spider_tiny_walkingUp = {
		prefix = "spider_tiny",
		to = 18,
		from = 10
	},
	enemy_spider_attack = {
		prefix = "spider_medium",
		to = 46,
		from = 28
	},
	enemy_spider_death = {
		prefix = "spider_medium",
		to = 84,
		from = 70
	},
	enemy_spider_idle = {
		prefix = "spider_medium",
		to = 28,
		from = 28
	},
	enemy_spider_thorn = {
		prefix = "spider_medium",
		to = 65,
		from = 47
	},
	enemy_spider_thornFree = {
		prefix = "spider_medium",
		to = 70,
		from = 66
	},
	enemy_spider_walkingDown = {
		prefix = "spider_medium",
		to = 27,
		from = 19
	},
	enemy_spider_walkingRightLeft = {
		prefix = "spider_medium",
		to = 9,
		from = 1
	},
	enemy_spider_walkingUp = {
		prefix = "spider_medium",
		to = 18,
		from = 10
	},
	enemy_spider_egg_start = {
		prefix = "spider_egg",
		to = 89,
		from = 1
	},
	enemy_spider_egg_idle = {
		prefix = "spider_egg",
		to = 89,
		from = 89
	},
	spider_explode_small = {
		prefix = "states_small",
		to = 58,
		from = 49
	},
	spider_explode_big = {
		prefix = "states_big",
		to = 58,
		from = 49
	},
	enemy_brigand_attack = {
		prefix = "brigand",
		to = 80,
		from = 67
	},
	enemy_brigand_death = {
		prefix = "brigand",
		to = 111,
		from = 104
	},
	enemy_brigand_idle = {
		prefix = "brigand",
		to = 67,
		from = 67
	},
	enemy_brigand_thorn = {
		prefix = "brigand",
		to = 99,
		from = 81
	},
	enemy_brigand_thornFree = {
		prefix = "brigand",
		to = 104,
		from = 100
	},
	enemy_brigand_walkingDown = {
		prefix = "brigand",
		to = 66,
		from = 45
	},
	enemy_brigand_walkingRightLeft = {
		prefix = "brigand",
		to = 22,
		from = 1
	},
	enemy_brigand_walkingUp = {
		prefix = "brigand",
		to = 44,
		from = 23
	},
	enemy_dark_knight_attack = {
		prefix = "darkKnight",
		to = 78,
		from = 67
	},
	enemy_dark_knight_death = {
		prefix = "darkKnight",
		to = 109,
		from = 102
	},
	enemy_dark_knight_idle = {
		prefix = "darkKnight",
		to = 67,
		from = 67
	},
	enemy_dark_knight_thorn = {
		prefix = "darkKnight",
		to = 97,
		from = 79
	},
	enemy_dark_knight_thornFree = {
		prefix = "darkKnight",
		to = 102,
		from = 98
	},
	enemy_dark_knight_walkingDown = {
		prefix = "darkKnight",
		to = 66,
		from = 45
	},
	enemy_dark_knight_walkingRightLeft = {
		prefix = "darkKnight",
		to = 22,
		from = 1
	},
	enemy_dark_knight_walkingUp = {
		prefix = "darkKnight",
		to = 44,
		from = 23
	},
	enemy_marauder_attack = {
		prefix = "marauder",
		to = 79,
		from = 67
	},
	enemy_marauder_death = {
		prefix = "marauder",
		to = 121,
		from = 114
	},
	enemy_marauder_idle = {
		prefix = "marauder",
		to = 67,
		from = 67
	},
	enemy_marauder_thorn = {
		prefix = "marauder",
		to = 99,
		from = 81
	},
	enemy_marauder_thornFree = {
		prefix = "marauder",
		to = 104,
		from = 100
	},
	enemy_marauder_walkingDown = {
		prefix = "marauder",
		to = 66,
		from = 45
	},
	enemy_marauder_walkingRightLeft = {
		prefix = "marauder",
		to = 22,
		from = 1
	},
	enemy_marauder_walkingUp = {
		prefix = "marauder",
		to = 44,
		from = 23
	},
	enemy_bandit_attack = {
		to = 74,
		from = 68,
		prefix = "bandit",
		post = {
			74,
			74,
			74
		}
	},
	enemy_bandit_death = {
		prefix = "bandit",
		to = 110,
		from = 99
	},
	enemy_bandit_idle = {
		prefix = "bandit",
		to = 67,
		from = 67
	},
	enemy_bandit_thorn = {
		prefix = "bandit",
		to = 93,
		from = 75
	},
	enemy_bandit_thornFree = {
		prefix = "bandit",
		to = 98,
		from = 94
	},
	enemy_bandit_walkingDown = {
		prefix = "bandit",
		to = 66,
		from = 45
	},
	enemy_bandit_walkingRightLeft = {
		prefix = "bandit",
		to = 22,
		from = 1
	},
	enemy_bandit_walkingUp = {
		prefix = "bandit",
		to = 44,
		from = 23
	},
	enemy_spider_small_attack = {
		prefix = "spider_small",
		to = 46,
		from = 28
	},
	enemy_spider_small_death = {
		prefix = "spider_small",
		to = 84,
		from = 70
	},
	enemy_spider_small_idle = {
		prefix = "spider_small",
		to = 28,
		from = 28
	},
	enemy_spider_small_thorn = {
		prefix = "spider_small",
		to = 65,
		from = 47
	},
	enemy_spider_small_thornFree = {
		prefix = "spider_small",
		to = 70,
		from = 66
	},
	enemy_spider_small_walkingDown = {
		prefix = "spider_small",
		to = 27,
		from = 19
	},
	enemy_spider_small_walkingRightLeft = {
		prefix = "spider_small",
		to = 9,
		from = 1
	},
	enemy_spider_small_walkingUp = {
		prefix = "spider_small",
		to = 18,
		from = 10
	},
	enemy_slayer_attack = {
		prefix = "darkSlayer",
		to = 85,
		from = 67
	},
	enemy_slayer_death = {
		prefix = "darkSlayer",
		to = 124,
		from = 110
	},
	enemy_slayer_idle = {
		prefix = "darkSlayer",
		to = 67,
		from = 67
	},
	enemy_slayer_thorn = {
		prefix = "darkSlayer",
		to = 88,
		from = 68
	},
	enemy_slayer_thornFree = {
		prefix = "darkSlayer",
		to = 110,
		from = 106
	},
	enemy_slayer_walkingDown = {
		prefix = "darkSlayer",
		to = 66,
		from = 45
	},
	enemy_slayer_walkingRightLeft = {
		prefix = "darkSlayer",
		to = 22,
		from = 1
	},
	enemy_slayer_walkingUp = {
		prefix = "darkSlayer",
		to = 44,
		from = 23
	},
	enemy_rocketeer_death = {
		prefix = "rocketeer",
		to = 66,
		from = 49
	},
	enemy_rocketeer_idle = {
		prefix = "rocketeer",
		to = 8,
		from = 1
	},
	enemy_rocketeer_walkingDown = {
		prefix = "rocketeer",
		to = 40,
		from = 33
	},
	enemy_rocketeer_walkingRightLeft = {
		prefix = "rocketeer",
		to = 8,
		from = 1
	},
	enemy_rocketeer_walkingUp = {
		prefix = "rocketeer",
		to = 24,
		from = 17
	},
	enemy_rocketeer_walkingDown_fast = {
		prefix = "rocketeer",
		to = 48,
		from = 41
	},
	enemy_rocketeer_walkingRightLeft_fast = {
		prefix = "rocketeer",
		to = 16,
		from = 9
	},
	enemy_rocketeer_walkingUp_fast = {
		prefix = "rocketeer",
		to = 32,
		from = 25
	},
	enemy_troll_attack = {
		prefix = "troll",
		to = 76,
		from = 67
	},
	enemy_troll_death = {
		prefix = "troll",
		to = 106,
		from = 101
	},
	enemy_troll_idle = {
		prefix = "troll",
		to = 67,
		from = 67
	},
	enemy_troll_thorn = {
		prefix = "troll",
		to = 95,
		from = 77
	},
	enemy_troll_thornFree = {
		prefix = "troll",
		to = 100,
		from = 96
	},
	enemy_troll_walkingDown = {
		prefix = "troll",
		to = 66,
		from = 45
	},
	enemy_troll_walkingRightLeft = {
		prefix = "troll",
		to = 22,
		from = 1
	},
	enemy_troll_walkingUp = {
		prefix = "troll",
		to = 44,
		from = 23
	},
	enemy_whitewolf_attack = {
		prefix = "winterwolf",
		to = 44,
		from = 31
	},
	enemy_whitewolf_death = {
		prefix = "winterwolf",
		to = 84,
		from = 69
	},
	enemy_whitewolf_idle = {
		prefix = "winterwolf",
		to = 31,
		from = 31
	},
	enemy_whitewolf_thorn = {
		prefix = "winterwolf",
		to = 63,
		from = 44
	},
	enemy_whitewolf_thornFree = {
		prefix = "winterwolf",
		to = 69,
		from = 65
	},
	enemy_whitewolf_walkingDown = {
		prefix = "winterwolf",
		to = 30,
		from = 21
	},
	enemy_whitewolf_walkingRightLeft = {
		prefix = "winterwolf",
		to = 10,
		from = 1
	},
	enemy_whitewolf_walkingUp = {
		prefix = "winterwolf",
		to = 20,
		from = 11
	},
	enemy_yeti_attack = {
		prefix = "yeti",
		to = 100,
		from = 73
	},
	enemy_yeti_death = {
		prefix = "yeti",
		to = 160,
		from = 126
	},
	enemy_yeti_idle = {
		prefix = "yeti",
		to = 73,
		from = 73
	},
	enemy_yeti_thorn = {
		prefix = "yeti",
		to = 93,
		from = 73
	},
	enemy_yeti_thornFree = {
		prefix = "yeti",
		to = 126,
		from = 122
	},
	enemy_yeti_walkingDown = {
		prefix = "yeti",
		to = 72,
		from = 50
	},
	enemy_yeti_walkingRightLeft = {
		prefix = "yeti",
		to = 25,
		from = 1
	},
	enemy_yeti_walkingUp = {
		prefix = "yeti",
		to = 49,
		from = 26
	},
	enemy_forest_troll_attack = {
		prefix = "forest_troll",
		to = 103,
		from = 73
	},
	enemy_forest_troll_death = {
		prefix = "forest_troll",
		to = 159,
		from = 126
	},
	enemy_forest_troll_idle = {
		prefix = "forest_troll",
		to = 73,
		from = 73
	},
	enemy_forest_troll_thorn = {
		prefix = "forest_troll",
		to = 92,
		from = 73
	},
	enemy_forest_troll_thornFree = {
		prefix = "forest_troll",
		to = 127,
		from = 122
	},
	enemy_forest_troll_walkingDown = {
		prefix = "forest_troll",
		to = 72,
		from = 50
	},
	enemy_forest_troll_walkingRightLeft = {
		prefix = "forest_troll",
		to = 25,
		from = 1
	},
	enemy_forest_troll_walkingUp = {
		prefix = "forest_troll",
		to = 49,
		from = 26
	},
	enemy_orc_armored_attack = {
		prefix = "orc_armored",
		to = 77,
		from = 67
	},
	enemy_orc_armored_death = {
		prefix = "orc_armored",
		to = 115,
		from = 102
	},
	enemy_orc_armored_idle = {
		prefix = "orc_armored",
		to = 67,
		from = 67
	},
	enemy_orc_armored_thorn = {
		prefix = "orc_armored",
		to = 96,
		from = 78
	},
	enemy_orc_armored_thornFree = {
		prefix = "orc_armored",
		to = 102,
		from = 97
	},
	enemy_orc_armored_walkingDown = {
		prefix = "orc_armored",
		to = 66,
		from = 45
	},
	enemy_orc_armored_walkingRightLeft = {
		prefix = "orc_armored",
		to = 22,
		from = 1
	},
	enemy_orc_armored_walkingUp = {
		prefix = "orc_armored",
		to = 44,
		from = 23
	},
	enemy_orc_rider_attack = {
		prefix = "orc_wolfrider",
		to = 44,
		from = 31
	},
	enemy_orc_rider_death = {
		prefix = "worg",
		to = 84,
		from = 69
	},
	enemy_orc_rider_idle = {
		prefix = "orc_wolfrider",
		to = 31,
		from = 31
	},
	enemy_orc_rider_thorn = {
		prefix = "orc_wolfrider",
		to = 50,
		from = 31
	},
	enemy_orc_rider_thornFree = {
		prefix = "orc_wolfrider",
		to = 69,
		from = 65
	},
	enemy_orc_rider_walkingDown = {
		prefix = "orc_wolfrider",
		to = 30,
		from = 21
	},
	enemy_orc_rider_walkingRightLeft = {
		prefix = "orc_wolfrider",
		to = 10,
		from = 1
	},
	enemy_orc_rider_walkingUp = {
		prefix = "orc_wolfrider",
		to = 20,
		from = 11
	},
	enemy_troll_axe_thrower_attack = {
		prefix = "troll_thrower",
		to = 97,
		from = 82
	},
	enemy_troll_axe_thrower_death = {
		prefix = "troll_thrower",
		to = 140,
		from = 124
	},
	enemy_troll_axe_thrower_idle = {
		prefix = "troll_thrower",
		to = 67,
		from = 67
	},
	enemy_troll_axe_thrower_shoot = {
		prefix = "troll_thrower",
		to = 82,
		from = 67
	},
	enemy_troll_axe_thrower_thorn = {
		prefix = "troll_thrower",
		to = 86,
		from = 67
	},
	enemy_troll_axe_thrower_thornFree = {
		prefix = "troll_thrower",
		to = 124,
		from = 120
	},
	enemy_troll_axe_thrower_walkingDown = {
		prefix = "troll_thrower",
		to = 66,
		from = 45
	},
	enemy_troll_axe_thrower_walkingRightLeft = {
		prefix = "troll_thrower",
		to = 22,
		from = 1
	},
	enemy_troll_axe_thrower_walkingUp = {
		prefix = "troll_thrower",
		to = 44,
		from = 23
	},
	enemy_raider_attack = {
		prefix = "Raider",
		to = 84,
		from = 70
	},
	enemy_raider_death = {
		prefix = "Raider",
		to = 150,
		from = 133
	},
	enemy_raider_idle = {
		prefix = "Raider",
		to = 67,
		from = 67
	},
	enemy_raider_shoot = {
		prefix = "Raider",
		to = 108,
		from = 85
	},
	enemy_raider_thorn = {
		prefix = "Raider",
		to = 86,
		from = 67
	},
	enemy_raider_thornFree = {
		prefix = "Raider",
		to = 133,
		from = 129
	},
	enemy_raider_walkingDown = {
		prefix = "Raider",
		to = 66,
		from = 45
	},
	enemy_raider_walkingRightLeft = {
		prefix = "Raider",
		to = 22,
		from = 1
	},
	enemy_raider_walkingUp = {
		prefix = "Raider",
		to = 44,
		from = 23
	},
	enemy_pillager_attack = {
		prefix = "Pillager",
		to = 103,
		from = 80
	},
	enemy_pillager_death = {
		prefix = "Pillager",
		to = 144,
		from = 127
	},
	enemy_pillager_idle = {
		prefix = "Pillager",
		to = 79,
		from = 79
	},
	enemy_pillager_thorn = {
		prefix = "Pillager",
		to = 122,
		from = 104
	},
	enemy_pillager_thornFree = {
		prefix = "Pillager",
		to = 127,
		from = 123
	},
	enemy_pillager_walkingDown = {
		prefix = "Pillager",
		to = 78,
		from = 53
	},
	enemy_pillager_walkingRightLeft = {
		prefix = "Pillager",
		to = 26,
		from = 1
	},
	enemy_pillager_walkingUp = {
		prefix = "Pillager",
		to = 52,
		from = 27
	},
	enemy_troll_brute_attack = {
		prefix = "troll_brute",
		to = 96,
		from = 68
	},
	enemy_troll_brute_death = {
		prefix = "troll_brute",
		to = 138,
		from = 120
	},
	enemy_troll_brute_idle = {
		prefix = "troll_brute",
		to = 67,
		from = 67
	},
	enemy_troll_brute_thorn = {
		prefix = "troll_brute",
		to = 115,
		from = 97
	},
	enemy_troll_brute_thornFree = {
		prefix = "troll_brute",
		to = 120,
		from = 116
	},
	enemy_troll_brute_walkingDown = {
		prefix = "troll_brute",
		to = 64,
		from = 45
	},
	enemy_troll_brute_walkingRightLeft = {
		prefix = "troll_brute",
		to = 22,
		from = 1
	},
	enemy_troll_brute_walkingUp = {
		prefix = "troll_brute",
		to = 44,
		from = 23
	},
	enemy_troll_chieftain_attack = {
		prefix = "troll_chieftain",
		to = 106,
		from = 79
	},
	enemy_troll_chieftain_death = {
		prefix = "troll_chieftain",
		to = 163,
		from = 145
	},
	enemy_troll_chieftain_idle = {
		prefix = "troll_chieftain",
		to = 79,
		from = 79
	},
	enemy_troll_chieftain_special = {
		prefix = "troll_chieftain",
		to = 121,
		from = 107
	},
	enemy_troll_chieftain_thorn = {
		prefix = "troll_chieftain",
		to = 140,
		from = 122
	},
	enemy_troll_chieftain_thornFree = {
		prefix = "troll_chieftain",
		to = 145,
		from = 141
	},
	enemy_troll_chieftain_walkingDown = {
		prefix = "troll_chieftain",
		to = 78,
		from = 53
	},
	enemy_troll_chieftain_walkingRightLeft = {
		prefix = "troll_chieftain",
		to = 26,
		from = 1
	},
	enemy_troll_chieftain_walkingUp = {
		prefix = "troll_chieftain",
		to = 52,
		from = 27
	},
	enemy_golem_head_attack = {
		prefix = "golemHead",
		to = 63,
		from = 45
	},
	enemy_golem_head_death = {
		prefix = "golemHead",
		to = 100,
		from = 89
	},
	enemy_golem_head_idle = {
		prefix = "golemHead",
		to = 45,
		from = 45
	},
	enemy_golem_head_thorn = {
		prefix = "golemHead",
		to = 65,
		from = 46
	},
	enemy_golem_head_thornFree = {
		prefix = "golemHead",
		to = 88,
		from = 84
	},
	enemy_golem_head_walkingRightLeft = {
		prefix = "golemHead",
		to = 13,
		from = 1
	},
	enemy_golem_head_walkingUp = {
		prefix = "golemHead",
		to = 44,
		from = 23
	},
	enemy_goblin_zapper_attack = {
		prefix = "goblin_zapper",
		to = 102,
		from = 81
	},
	enemy_goblin_zapper_death = {
		prefix = "goblin_zapper",
		to = 142,
		from = 125
	},
	enemy_goblin_zapper_idle = {
		prefix = "goblin_zapper",
		to = 67,
		from = 67
	},
	enemy_goblin_zapper_shoot = {
		prefix = "goblin_zapper",
		to = 81,
		from = 67
	},
	enemy_goblin_zapper_thorn = {
		prefix = "goblin_zapper",
		to = 120,
		from = 102
	},
	enemy_goblin_zapper_thornFree = {
		prefix = "goblin_zapper",
		to = 125,
		from = 121
	},
	enemy_goblin_zapper_walkingDown = {
		prefix = "goblin_zapper",
		to = 66,
		from = 45
	},
	enemy_goblin_zapper_walkingRightLeft = {
		prefix = "goblin_zapper",
		to = 22,
		from = 1
	},
	enemy_goblin_zapper_walkingUp = {
		prefix = "goblin_zapper",
		to = 44,
		from = 23
	},
	enemy_demon_attack = {
		prefix = "demonEvil",
		to = 76,
		from = 67
	},
	enemy_demon_death = {
		prefix = "demonDeath_small",
		to = 12,
		from = 1
	},
	enemy_demon_idle = {
		prefix = "demonEvil",
		to = 67,
		from = 67
	},
	enemy_demon_thorn = {
		prefix = "demonEvil",
		to = 95,
		from = 77
	},
	enemy_demon_thornFree = {
		prefix = "demonEvil",
		to = 100,
		from = 96
	},
	enemy_demon_walkingDown = {
		prefix = "demonEvil",
		to = 66,
		from = 45
	},
	enemy_demon_walkingRightLeft = {
		prefix = "demonEvil",
		to = 22,
		from = 1
	},
	enemy_demon_walkingUp = {
		prefix = "demonEvil",
		to = 44,
		from = 23
	},
	enemy_demon_mage_attack = {
		prefix = "demonMage",
		to = 86,
		from = 67
	},
	enemy_demon_mage_death = {
		prefix = "demonDeath_big",
		to = 12,
		from = 1
	},
	enemy_demon_mage_idle = {
		prefix = "demonMage",
		to = 67,
		from = 67
	},
	enemy_demon_mage_special = {
		prefix = "demonMage",
		to = 114,
		from = 87
	},
	enemy_demon_mage_thorn = {
		prefix = "demonMage",
		to = 133,
		from = 115
	},
	enemy_demon_mage_thornFree = {
		prefix = "demonMage",
		to = 138,
		from = 134
	},
	enemy_demon_mage_walkingDown = {
		prefix = "demonMage",
		to = 66,
		from = 45
	},
	enemy_demon_mage_walkingRightLeft = {
		prefix = "demonMage",
		to = 22,
		from = 1
	},
	enemy_demon_mage_walkingUp = {
		prefix = "demonMage",
		to = 44,
		from = 23
	},
	enemy_demon_wolf_attack = {
		prefix = "demonWolf",
		to = 45,
		from = 31
	},
	enemy_demon_wolf_death = {
		prefix = "demonDeath_small",
		to = 12,
		from = 1
	},
	enemy_demon_wolf_idle = {
		prefix = "demonWolf",
		to = 44,
		from = 44
	},
	enemy_demon_wolf_thorn = {
		prefix = "demonWolf",
		to = 64,
		from = 46
	},
	enemy_demon_wolf_thornFree = {
		prefix = "demonWolf",
		to = 69,
		from = 65
	},
	enemy_demon_wolf_walkingDown = {
		prefix = "demonWolf",
		to = 30,
		from = 21
	},
	enemy_demon_wolf_walkingRightLeft = {
		prefix = "demonWolf",
		to = 10,
		from = 1
	},
	enemy_demon_wolf_walkingUp = {
		prefix = "demonWolf",
		to = 20,
		from = 11
	},
	enemy_demon_imp_death = {
		prefix = "demonFlying",
		to = 54,
		from = 43
	},
	enemy_demon_imp_idle = {
		prefix = "demonFlying",
		to = 14,
		from = 1
	},
	enemy_demon_imp_walkingDown = {
		prefix = "demonFlying",
		to = 42,
		from = 29
	},
	enemy_demon_imp_walkingRightLeft = {
		prefix = "demonFlying",
		to = 14,
		from = 1
	},
	enemy_demon_imp_walkingUp = {
		prefix = "demonFlying",
		to = 28,
		from = 15
	},
	enemy_lava_elemental_attack = {
		prefix = "lavaElemental",
		to = 102,
		from = 73
	},
	enemy_lava_elemental_death = {
		prefix = "lavaElemental",
		to = 155,
		from = 126
	},
	enemy_lava_elemental_idle = {
		prefix = "lavaElemental",
		to = 73,
		from = 73
	},
	enemy_lava_elemental_raise = {
		prefix = "lavaElemental",
		to = 182,
		from = 156
	},
	enemy_lava_elemental_thorn = {
		prefix = "lavaElemental",
		to = 121,
		from = 103
	},
	enemy_lava_elemental_thornFree = {
		prefix = "lavaElemental",
		to = 125,
		from = 122
	},
	enemy_lava_elemental_walkingDown = {
		prefix = "lavaElemental",
		to = 72,
		from = 50
	},
	enemy_lava_elemental_walkingRightLeft = {
		prefix = "lavaElemental",
		to = 25,
		from = 1
	},
	enemy_lava_elemental_walkingUp = {
		prefix = "lavaElemental",
		to = 49,
		from = 26
	},
	enemy_sarelgaz_small_attack = {
		prefix = "spider_sonofsarelgaz",
		to = 58,
		from = 40
	},
	enemy_sarelgaz_small_death = {
		prefix = "spider_sonofsarelgaz",
		to = 102,
		from = 88
	},
	enemy_sarelgaz_small_idle = {
		prefix = "spider_sonofsarelgaz",
		to = 40,
		from = 40
	},
	enemy_sarelgaz_small_thorn = {
		prefix = "spider_sonofsarelgaz",
		to = 59,
		from = 40
	},
	enemy_sarelgaz_small_thornFree = {
		prefix = "spider_sonofsarelgaz",
		to = 88,
		from = 84
	},
	enemy_sarelgaz_small_walkingDown = {
		prefix = "spider_sonofsarelgaz",
		to = 39,
		from = 27
	},
	enemy_sarelgaz_small_walkingRightLeft = {
		prefix = "spider_sonofsarelgaz",
		to = 13,
		from = 1
	},
	enemy_sarelgaz_small_walkingUp = {
		prefix = "spider_sonofsarelgaz",
		to = 26,
		from = 14
	},
	enemy_rotten_lesser_attack = {
		prefix = "mushroom",
		to = 49,
		from = 34
	},
	enemy_rotten_lesser_death = {
		prefix = "mushroom",
		to = 122,
		from = 107
	},
	enemy_rotten_lesser_idle = {
		prefix = "mushroom",
		to = 1,
		from = 1
	},
	enemy_rotten_lesser_thorn = {
		prefix = "mushroom",
		to = 102,
		from = 84
	},
	enemy_rotten_lesser_thornFree = {
		prefix = "mushroom",
		to = 106,
		from = 103
	},
	enemy_rotten_lesser_walkingDown = {
		prefix = "mushroom",
		to = 33,
		from = 18
	},
	enemy_rotten_lesser_walkingRightLeft = {
		prefix = "mushroom",
		to = 17,
		from = 2
	},
	enemy_rotten_lesser_walkingUp = {
		prefix = "mushroom",
		to = 17,
		from = 2
	},
	enemy_rotten_lesser_raise = {
		prefix = "mushroom",
		to = 83,
		from = 50
	},
	enemy_swamp_thing_attack = {
		prefix = "rotten_thing",
		to = 102,
		from = 72
	},
	enemy_swamp_thing_death = {
		prefix = "rotten_thing",
		to = 179,
		from = 151
	},
	enemy_swamp_thing_idle = {
		prefix = "rotten_thing",
		to = 73,
		from = 73
	},
	enemy_swamp_thing_shoot = {
		to = 127,
		from = 102,
		prefix = "rotten_thing",
		post = {
			127
		}
	},
	enemy_swamp_thing_thorn = {
		prefix = "rotten_thing",
		to = 146,
		from = 128
	},
	enemy_swamp_thing_thornFree = {
		prefix = "rotten_thing",
		to = 151,
		from = 147
	},
	enemy_swamp_thing_walkingDown = {
		prefix = "rotten_thing",
		to = 71,
		from = 49
	},
	enemy_swamp_thing_walkingRightLeft = {
		prefix = "rotten_thing",
		to = 24,
		from = 1
	},
	enemy_swamp_thing_walkingUp = {
		prefix = "rotten_thing",
		to = 47,
		from = 25
	},
	enemy_swamp_thing_raise = {
		prefix = "rotten_thing",
		to = 213,
		from = 180
	},
	enemy_spider_rotten_tiny_attack = {
		prefix = "rotten_spider_tiny",
		to = 46,
		from = 28
	},
	enemy_spider_rotten_tiny_death = {
		prefix = "rotten_spider_tiny",
		to = 84,
		from = 70
	},
	enemy_spider_rotten_tiny_idle = {
		prefix = "rotten_spider_tiny",
		to = 28,
		from = 28
	},
	enemy_spider_rotten_tiny_thorn = {
		prefix = "rotten_spider_tiny",
		to = 65,
		from = 47
	},
	enemy_spider_rotten_tiny_thornFree = {
		prefix = "rotten_spider_tiny",
		to = 70,
		from = 66
	},
	enemy_spider_rotten_tiny_walkingDown = {
		prefix = "rotten_spider_tiny",
		to = 27,
		from = 19
	},
	enemy_spider_rotten_tiny_walkingRightLeft = {
		prefix = "rotten_spider_tiny",
		to = 9,
		from = 1
	},
	enemy_spider_rotten_tiny_walkingUp = {
		prefix = "rotten_spider_tiny",
		to = 18,
		from = 10
	},
	enemy_spider_rotten_attack = {
		prefix = "rotten_spider",
		to = 58,
		from = 40
	},
	enemy_spider_rotten_death = {
		prefix = "rotten_spider",
		to = 96,
		from = 82
	},
	enemy_spider_rotten_idle = {
		prefix = "rotten_spider",
		to = 40,
		from = 40
	},
	enemy_spider_rotten_thorn = {
		prefix = "rotten_spider",
		to = 77,
		from = 59
	},
	enemy_spider_rotten_thornFree = {
		prefix = "rotten_spider",
		to = 82,
		from = 78
	},
	enemy_spider_rotten_walkingDown = {
		prefix = "rotten_spider",
		to = 39,
		from = 27
	},
	enemy_spider_rotten_walkingRightLeft = {
		prefix = "rotten_spider",
		to = 13,
		from = 1
	},
	enemy_spider_rotten_walkingUp = {
		prefix = "rotten_spider",
		to = 26,
		from = 14
	},
	enemy_spider_rotten_egg_start = {
		prefix = "rotten_egg",
		to = 89,
		from = 1
	},
	enemy_spider_rotten_egg_idle = {
		prefix = "rotten_egg",
		to = 89,
		from = 89
	},
	enemy_rotten_tree_attack = {
		prefix = "rotten_treant",
		to = 70,
		from = 49
	},
	enemy_rotten_tree_death = {
		prefix = "rotten_treant",
		to = 136,
		from = 127
	},
	enemy_rotten_tree_idle = {
		prefix = "rotten_treant",
		to = 49,
		from = 49
	},
	enemy_rotten_tree_thorn = {
		prefix = "rotten_treant",
		to = 86,
		from = 71
	},
	enemy_rotten_tree_thornFree = {
		prefix = "rotten_treant",
		to = 91,
		from = 87
	},
	enemy_rotten_tree_walkingDown = {
		prefix = "rotten_treant",
		to = 46,
		from = 33
	},
	enemy_rotten_tree_walkingRightLeft = {
		prefix = "rotten_treant",
		to = 16,
		from = 1
	},
	enemy_rotten_tree_walkingUp = {
		prefix = "rotten_treant",
		to = 32,
		from = 17
	},
	enemy_rotten_tree_raise = {
		prefix = "rotten_treant",
		to = 126,
		from = 91
	},
	enemy_rotten_tree2_attack = {
		prefix = "bravebark_hero",
		to = 265,
		from = 240
	},
	enemy_rotten_tree2_death = {
		prefix = "bravebark_hero",
		to = 312,
		from = 266
	},
	enemy_rotten_tree2_idle = {
		prefix = "bravebark_hero",
		to = 1,
		from = 1
	},
	enemy_rotten_tree2_thorn = {
		prefix = "rotten_treant",
		to = 86,
		from = 71
	},
	enemy_rotten_tree2_thornFree = {
		prefix = "rotten_treant",
		to = 91,
		from = 87
	},
	enemy_rotten_tree2_walkingDown = {
		prefix = "rotten_treant",
		to = 46,
		from = 33
	},
	enemy_rotten_tree2_walkingRightLeft = {
		prefix = "bravebark_hero",
		to = 26,
		from = 2
	},
	enemy_rotten_tree2_walkingUp = {
		prefix = "rotten_treant",
		to = 32,
		from = 17
	},
	enemy_rotten_tree2_raise = {
		prefix = "rotten_treant",
		to = 126,
		from = 91
	},
	enemy_giant_rat_attack = {
		prefix = "CB_Rat",
		to = 42,
		from = 25
	},
	enemy_giant_rat_death = {
		prefix = "CB_Rat",
		to = 66,
		from = 43
	},
	enemy_giant_rat_idle = {
		prefix = "CB_Rat",
		to = 47,
		from = 47
	},
	enemy_giant_rat_thorn = {
		prefix = "CB_Rat",
		to = 85,
		from = 67
	},
	enemy_giant_rat_thornFree = {
		prefix = "CB_Rat",
		to = 89,
		from = 86
	},
	enemy_giant_rat_walkingDown = {
		prefix = "CB_Rat",
		to = 16,
		from = 9
	},
	enemy_giant_rat_walkingRightLeft = {
		prefix = "CB_Rat",
		to = 8,
		from = 1
	},
	enemy_giant_rat_walkingUp = {
		prefix = "CB_Rat",
		to = 24,
		from = 17
	},
	enemy_giant_rat_raise = {
		prefix = "CB_Rat",
		to = 104,
		from = 90
	},
	enemy_wererat_attack = {
		prefix = "CB_Ratman",
		to = 60,
		from = 43
	},
	enemy_wererat_death = {
		prefix = "CB_Ratman",
		to = 83,
		from = 61
	},
	enemy_wererat_idle = {
		prefix = "CB_Ratman",
		to = 60,
		from = 60
	},
	enemy_wererat_thorn = {
		prefix = "CB_Ratman",
		to = 102,
		from = 84
	},
	enemy_wererat_thornFree = {
		prefix = "CB_Ratman",
		to = 106,
		from = 103
	},
	enemy_wererat_walkingDown = {
		prefix = "CB_Ratman",
		to = 28,
		from = 15
	},
	enemy_wererat_walkingRightLeft = {
		prefix = "CB_Ratman",
		to = 14,
		from = 1
	},
	enemy_wererat_walkingUp = {
		prefix = "CB_Ratman",
		to = 42,
		from = 29
	},
	enemy_abomination_idle = {
		prefix = "CB_Abomination",
		to = 85,
		from = 85
	},
	enemy_abomination_walkingRightLeft = {
		prefix = "CB_Abomination",
		to = 28,
		from = 1
	},
	enemy_abomination_walkingUp = {
		prefix = "CB_Abomination",
		to = 56,
		from = 29
	},
	enemy_abomination_walkingDown = {
		prefix = "CB_Abomination",
		to = 84,
		from = 57
	},
	enemy_abomination_attack = {
		prefix = "CB_Abomination",
		to = 116,
		from = 86
	},
	enemy_abomination_death = {
		prefix = "CB_Abomination",
		to = 144,
		from = 117
	},
	enemy_werewolf_idle = {
		prefix = "CB_Werewolf",
		to = 1,
		from = 1
	},
	enemy_werewolf_walkingRightLeft = {
		prefix = "CB_Werewolf",
		to = 34,
		from = 21
	},
	enemy_werewolf_walkingUp = {
		prefix = "CB_Werewolf",
		to = 48,
		from = 35
	},
	enemy_werewolf_walkingDown = {
		prefix = "CB_Werewolf",
		to = 62,
		from = 49
	},
	enemy_werewolf_attack = {
		prefix = "CB_Werewolf",
		to = 20,
		from = 2
	},
	enemy_werewolf_death = {
		prefix = "CB_Werewolf",
		to = 91,
		from = 63
	},
	enemy_werewolf_raise = {
		prefix = "CB_Werewolf",
		to = 126,
		from = 92
	},
	enemy_halloween_zombie_idle = {
		prefix = "CB_Zombie",
		to = 72,
		from = 72
	},
		soldier_elf_kr1_idle = {
		prefix = "soldier_elf_kr1",
		to = 1,
		from = 1
	},
	soldier_elf_kr1_running = {
		prefix = "soldier_elf_kr1",
		to = 6,
		from = 1
	},
	soldier_elf_kr1_attack = {
		prefix = "soldier_elf_kr1",
		to = 24,
		from = 7
	},
	soldier_elf_kr1_death = {
		prefix = "soldier_elf_kr1",
		to = 47,
		from = 40
	},
	soldier_elf_kr1_shoot = {
		prefix = "soldier_elf_kr1",
		to = 36,
		from = 25
	},
	Tower_elf_kr1_door_open = {
		prefix = "Tower_elf_kr1_layer2",
		to = 5,
		from = 1
	},
	Tower_elf_kr1_door_close = {
		prefix = "Tower_elf_kr1_layer2",
		to = 25,
		from = 22
	},
	enemy_halloween_zombie_walkingRightLeft = {
		prefix = "CB_Zombie",
		to = 23,
		from = 1
	},
	enemy_halloween_zombie_walkingUp = {
		prefix = "CB_Zombie",
		to = 47,
		from = 24
	},
	enemy_halloween_zombie_walkingDown = {
		prefix = "CB_Zombie",
		to = 71,
		from = 48
	},
	enemy_halloween_zombie_attack = {
		prefix = "CB_Zombie",
		to = 93,
		from = 73
	},
	enemy_halloween_zombie_death = {
		prefix = "CB_Zombie",
		to = 115,
		from = 148
	},
	enemy_halloween_zombie_raise = {
		prefix = "CB_Zombie",
		to = 148,
		from = 115
	},
	enemy_lycan_idle = {
		prefix = "CB_Lycan",
		to = 67,
		from = 67
	},
	enemy_lycan_walkingRightLeft = {
		prefix = "CB_Lycan",
		to = 22,
		from = 1
	},
	enemy_lycan_walkingUp = {
		prefix = "CB_Lycan",
		to = 44,
		from = 23
	},
	enemy_lycan_walkingDown = {
		prefix = "CB_Lycan",
		to = 66,
		from = 45
	},
	enemy_lycan_attack = {
		prefix = "CB_Lycan",
		to = 86,
		from = 68
	},
	enemy_lycan_death = {
		prefix = "CB_Lycan",
		to = 215,
		from = 181
	},
	enemy_lycan_werewolf_idle = {
		prefix = "CB_Lycan",
		to = 114,
		from = 114
	},
	enemy_lycan_werewolf_walkingRightLeft = {
		prefix = "CB_Lycan",
		to = 128,
		from = 115
	},
	enemy_lycan_werewolf_walkingUp = {
		prefix = "CB_Lycan",
		to = 142,
		from = 129
	},
	enemy_lycan_werewolf_walkingDown = {
		prefix = "CB_Lycan",
		to = 156,
		from = 143
	},
	enemy_lycan_werewolf_attack = {
		prefix = "CB_Lycan",
		to = 180,
		from = 157
	},
	enemy_lycan_werewolf_death = {
		prefix = "CB_Lycan",
		to = 215,
		from = 181
	},
	enemy_lycan_werewolf_raise = {
		prefix = "CB_Lycan",
		to = 113,
		from = 87
	},
	enemy_skeleton_attack = {
		prefix = "skeleton",
		to = 67,
		from = 48
	},
	enemy_skeleton_death = {
		prefix = "skeleton",
		to = 114,
		from = 146
	},
	enemy_skeleton_idle = {
		prefix = "skeleton",
		to = 48,
		from = 48
	},
	enemy_skeleton_thorn = {
		prefix = "skeleton",
		to = 87,
		from = 67
	},
	enemy_skeleton_thornFree = {
		prefix = "skeleton",
		to = 93,
		from = 89
	},
	enemy_skeleton_walkingDown = {
		prefix = "skeleton",
		to = 47,
		from = 33
	},
	enemy_skeleton_walkingRightLeft = {
		prefix = "skeleton",
		to = 16,
		from = 1
	},
	enemy_skeleton_walkingUp = {
		prefix = "skeleton",
		to = 32,
		from = 17
	},
	enemy_skeleton_raise = {
		prefix = "skeleton",
		to = 146,
		from = 114
	},
	enemy_skeleton_big_attack = {
		prefix = "skeleton_warrior",
		to = 67,
		from = 48
	},
	enemy_skeleton_big_death = {
		prefix = "skeleton_warrior",
		to = 114,
		from = 146
	},
	enemy_skeleton_big_idle = {
		prefix = "skeleton_warrior",
		to = 48,
		from = 48
	},
	enemy_skeleton_big_thorn = {
		prefix = "skeleton_warrior",
		to = 67,
		from = 48
	},
	enemy_skeleton_big_thornFree = {
		prefix = "skeleton_warrior",
		to = 93,
		from = 89
	},
	enemy_skeleton_big_walkingDown = {
		prefix = "skeleton_warrior",
		to = 47,
		from = 33
	},
	enemy_skeleton_big_walkingRightLeft = {
		prefix = "skeleton_warrior",
		to = 16,
		from = 1
	},
	enemy_skeleton_big_walkingUp = {
		prefix = "skeleton_warrior",
		to = 32,
		from = 17
	},
	enemy_skeleton_big_raise = {
		prefix = "skeleton_warrior",
		to = 146,
		from = 114
	},
	enemy_zombie_attack = {
		prefix = "rotten_zombie",
		to = 93,
		from = 72
	},
	enemy_zombie_death = {
		prefix = "rotten_zombie",
		to = 137,
		from = 117
	},
	enemy_zombie_idle = {
		prefix = "rotten_zombie",
		to = 72,
		from = 72
	},
	enemy_zombie_thorn = {
		prefix = "rotten_zombie",
		to = 112,
		from = 94
	},
	enemy_zombie_thornFree = {
		prefix = "rotten_zombie",
		to = 117,
		from = 113
	},
	enemy_zombie_walkingDown = {
		prefix = "rotten_zombie",
		to = 71,
		from = 48
	},
	enemy_zombie_walkingRightLeft = {
		prefix = "rotten_zombie",
		to = 23,
		from = 1
	},
	enemy_zombie_walkingUp = {
		prefix = "rotten_zombie",
		to = 47,
		from = 24
	},
	enemy_zombie_raise = {
		prefix = "rotten_zombie",
		to = 170,
		from = 138
	},
	enemy_demon_flareon_attack = {
		prefix = "Inferno_Flareon",
		to = 102,
		from = 74
	},
	enemy_demon_flareon_death = {
		prefix = "demonDeath_small",
		to = 12,
		from = 1
	},
	enemy_demon_flareon_idle = {
		prefix = "Inferno_Flareon",
		to = 138,
		from = 126
	},
	enemy_demon_flareon_walkingDown = {
		prefix = "Inferno_Flareon",
		to = 36,
		from = 25
	},
	enemy_demon_flareon_walkingRightLeft = {
		prefix = "Inferno_Flareon",
		to = 12,
		from = 1
	},
	enemy_demon_flareon_walkingUp = {
		prefix = "Inferno_Flareon",
		to = 24,
		from = 13
	},
	enemy_demon_flareon_shoot = {
		prefix = "Inferno_Flareon",
		to = 73,
		from = 38
	},
	demon_flareon_flare = {
		prefix = "Inferno_Flareon_proy",
		to = 12,
		from = 1
	},
	enemy_demon_legion_attack = {
		prefix = "Inferno_Legion",
		to = 123,
		from = 96
	},
	enemy_demon_legion_death = {
		prefix = "Inferno_Legion",
		to = 237,
		from = 220
	},
	enemy_demon_legion_idle = {
		prefix = "Inferno_Legion",
		to = 93,
		from = 75
	},
	enemy_demon_legion_walkingDown = {
		prefix = "Inferno_Legion",
		to = 48,
		from = 25
	},
	enemy_demon_legion_walkingRightLeft = {
		prefix = "Inferno_Legion",
		to = 24,
		from = 1
	},
	enemy_demon_legion_walkingUp = {
		prefix = "Inferno_Legion",
		to = 72,
		from = 49
	},
	enemy_demon_legion_summon = {
		prefix = "Inferno_Legion",
		to = 162,
		from = 124
	},
	enemy_demon_legion_raise = {
		prefix = "Inferno_Legion",
		to = 194,
		from = 163
	},
	enemy_demon_gulaemon_attack = {
		prefix = "Inferno_FatDemon",
		to = 145,
		from = 130
	},
	enemy_demon_gulaemon_death = {
		prefix = "Inferno_FatDemon",
		to = 161,
		from = 146
	},
	enemy_demon_gulaemon_idle = {
		prefix = "Inferno_FatDemon",
		to = 73,
		from = 73
	},
	enemy_demon_gulaemon_walkingDown = {
		prefix = "Inferno_FatDemon",
		to = 48,
		from = 25
	},
	enemy_demon_gulaemon_walkingRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 24,
		from = 1
	},
	enemy_demon_gulaemon_walkingUp = {
		prefix = "Inferno_FatDemon",
		to = 72,
		from = 49
	},
	enemy_demon_gulaemon_fly_initFlyRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 77,
		from = 74
	},
	enemy_demon_gulaemon_fly_endFlyRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 91,
		from = 86
	},
	enemy_demon_gulaemon_fly_initFlyDown = {
		prefix = "Inferno_FatDemon",
		to = 96,
		from = 93
	},
	enemy_demon_gulaemon_fly_endFlyDown = {
		prefix = "Inferno_FatDemon",
		to = 110,
		from = 105
	},
	enemy_demon_gulaemon_fly_initFlyUp = {
		prefix = "Inferno_FatDemon",
		to = 115,
		from = 112
	},
	enemy_demon_gulaemon_fly_endFlyUp = {
		prefix = "Inferno_FatDemon",
		to = 129,
		from = 124
	},
	enemy_demon_gulaemon_fly_death = {
		prefix = "Inferno_FatDemon",
		to = 177,
		from = 162
	},
	enemy_demon_gulaemon_fly_idle = {
		prefix = "Inferno_FatDemon",
		to = 85,
		from = 78
	},
	enemy_demon_gulaemon_fly_walkingDown = {
		prefix = "Inferno_FatDemon",
		to = 104,
		from = 97
	},
	enemy_demon_gulaemon_fly_walkingRightLeft = {
		prefix = "Inferno_FatDemon",
		to = 85,
		from = 78
	},
	enemy_demon_gulaemon_fly_walkingUp = {
		prefix = "Inferno_FatDemon",
		to = 123,
		from = 116
	},
	enemy_necromancer_attack = {
		prefix = "necromancer",
		to = 91,
		from = 74
	},
	enemy_necromancer_death = {
		prefix = "necromancer",
		to = 200,
		from = 187
	},
	enemy_necromancer_idle = {
		prefix = "necromancer",
		to = 72,
		from = 72
	},
	enemy_necromancer_shoot = {
		prefix = "necromancer",
		to = 115,
		from = 92
	},
	enemy_necromancer_summon = {
		prefix = "necromancer",
		to = 163,
		from = 117
	},
	enemy_necromancer_thorn = {
		prefix = "necromancer",
		to = 182,
		from = 164
	},
	enemy_necromancer_thornFree = {
		prefix = "necromancer",
		to = 187,
		from = 183
	},
	enemy_necromancer_walkingDown = {
		prefix = "necromancer",
		to = 70,
		from = 49
	},
	enemy_necromancer_walkingRightLeft = {
		prefix = "necromancer",
		to = 24,
		from = 1
	},
	enemy_necromancer_walkingUp = {
		prefix = "necromancer",
		to = 48,
		from = 25
	},
	bolt_necromancer_idle = {
			prefix = "proy_Necromancer",
			to = 1,
			from = 1
		},
		bolt_necromancer_flying = {
			prefix = "proy_Necromancer",
			to = 1,
			from = 1
		},
		bolt_necromancer_hit = {
			prefix = "proy_Necromancer",
			to = 6,
			from = 2
		},
	enemy_demon_cerberus_attack = {
		prefix = "Inferno_Cerberus",
		to = 60,
		from = 44
	},
	enemy_demon_cerberus_death = {
		prefix = "Inferno_Cerberus",
		to = 92,
		from = 77
	},
	enemy_demon_cerberus_idle = {
		prefix = "Inferno_Cerberus",
		to = 43,
		from = 43
	},
	enemy_demon_cerberus_raise = {
		prefix = "Inferno_Cerberus",
		to = 189,
		from = 130
	},
	enemy_demon_cerberus_sleeping = {
		prefix = "Inferno_Cerberus",
		to = 129,
		from = 94
	},
	enemy_demon_cerberus_walkingDown = {
		prefix = "Inferno_Cerberus",
		to = 42,
		from = 29
	},
	enemy_demon_cerberus_walkingRightLeft = {
		prefix = "Inferno_Cerberus",
		to = 14,
		from = 1
	},
	enemy_demon_cerberus_walkingUp = {
		prefix = "Inferno_Cerberus",
		to = 28,
		from = 15
	},
	enemy_witch_shoot = {
		prefix = "CB_Witch",
		to = 89,
		from = 55
	},
	enemy_witch_death = {
		prefix = "CB_Witch",
		to = 104,
		from = 90
	},
	enemy_witch_idle = {
		prefix = "CB_Witch",
		to = 18,
		from = 1
	},
	enemy_witch_walkingDown = {
		prefix = "CB_Witch",
		to = 54,
		from = 37
	},
	enemy_witch_walkingRightLeft = {
		prefix = "CB_Witch",
		to = 18,
		from = 1
	},
	enemy_witch_walkingUp = {
		prefix = "CB_Witch",
		to = 36,
		from = 19
	},
	bolt_witch_idle = {
		prefix = "CB_Witch_proy",
		to = 1,
		from = 1
	},
	bolt_witch_flying = {
		prefix = "CB_Witch_proy",
		to = 1,
		from = 1
	},
	fx_bolt_witch_hit = {
		prefix = "CB_Witch_explosion",
		to = 19,
		from = 1
	},
	mod_witch_frog_idle = {
		prefix = "CB_Witch_frog",
		to = 19,
		from = 19
	},
	mod_witch_frog_jump = {
		prefix = "CB_Witch_frog",
		to = 30,
		from = 20
	},
	mod_witch_frog_puff = {
		prefix = "CB_Witch_frog",
		to = 50,
		from = 31
	},
	enemy_spectral_knight_attack = {
		prefix = "CB_DeathKnight",
		to = 221,
		from = 200
	},
	enemy_spectral_knight_death = {
		prefix = "CB_DeathKnight",
		to = 246,
		from = 222
	},
	enemy_spectral_knight_idle = {
		prefix = "CB_DeathKnight",
		to = 163,
		from = 146
	},
	enemy_spectral_knight_raise = {
		prefix = "CB_DeathKnight",
		to = 145,
		from = 105
	},
	enemy_spectral_knight_walkingDown = {
		prefix = "CB_DeathKnight",
		to = 199,
		from = 182
	},
	enemy_spectral_knight_walkingRightLeft = {
		prefix = "CB_DeathKnight",
		to = 163,
		from = 146
	},
	enemy_spectral_knight_walkingUp = {
		prefix = "CB_DeathKnight",
		to = 181,
		from = 164
	},
	spectral_knight_aura = {
		prefix = "CB_DeathKnight_aura",
		to = 30,
		from = 1
	},
	spectral_knight_aura_fx = {
		prefix = "CB_DeathKnight_aura",
		to = 1,
		from = 1
	},
	mod_spectral_knight_fx = {
		prefix = "CB_DeathKnight_buffedFx",
		to = 16,
		from = 1
	},
	enemy_fallen_knight_attack = {
		prefix = "CB_DeathKnight",
		to = 25,
		from = 1
	},
	enemy_fallen_knight_death = {
		prefix = "CB_DeathKnight",
		to = 104,
		from = 93
	},
	enemy_fallen_knight_idle = {
		prefix = "CB_DeathKnight",
		to = 26,
		from = 26
	},
	enemy_fallen_knight_raise = {
		prefix = "CB_DeathKnight",
		to = 145,
		from = 105
	},
	enemy_fallen_knight_walkingDown = {
		prefix = "CB_DeathKnight",
		to = 92,
		from = 71
	},
	enemy_fallen_knight_walkingRightLeft = {
		prefix = "CB_DeathKnight",
		to = 48,
		from = 27
	},
	enemy_fallen_knight_walkingUp = {
		prefix = "CB_DeathKnight",
		to = 70,
		from = 49
	},
	enemy_troll_skater_attack = {
		prefix = "troll_skater",
		to = 99,
		from = 68
	},
	enemy_troll_skater_death = {
		prefix = "troll_skater",
		to = 143,
		from = 136
	},
	enemy_troll_skater_idle = {
		prefix = "troll_skater",
		to = 67,
		from = 67
	},
	enemy_troll_skater_skateDown = {
		prefix = "troll_skater",
		to = 111,
		from = 106
	},
	enemy_troll_skater_skateRightLeft = {
		prefix = "troll_skater",
		to = 105,
		from = 100
	},
	enemy_troll_skater_skateUp = {
		prefix = "troll_skater",
		to = 111,
		from = 106
	},
	enemy_troll_skater_walkingDown = {
		prefix = "troll_skater",
		to = 64,
		from = 45
	},
	enemy_troll_skater_walkingRightLeft = {
		prefix = "troll_skater",
		to = 22,
		from = 1
	},
	enemy_troll_skater_walkingUp = {
		prefix = "troll_skater",
		to = 44,
		from = 23
	},
	enemy_hobgoblin_attack = {
		prefix = "hobgoblin",
		to = 85,
		from = 51
	},
	enemy_hobgoblin_death = {
		prefix = "hobgoblin",
		to = 110,
		from = 86
	},
	enemy_hobgoblin_idle = {
		prefix = "hobgoblin",
		to = 1,
		from = 1
	},
	enemy_hobgoblin_walkingDown = {
		prefix = "hobgoblin",
		to = 50,
		from = 26
	},
	enemy_hobgoblin_walkingRightLeft = {
		prefix = "hobgoblin",
		to = 25,
		from = 2
	},
	enemy_hobgoblin_walkingUp = {
		prefix = "hobgoblin",
		to = 25,
		from = 2
	},
	fx_hobgoblin_ground_hit = {
		prefix = "hobgoblin_decal_smoke",
		to = 16,
		from = 1
	},
	eb_juggernaut_attack = {
		prefix = "bossJuggernaut",
		to = 78,
		from = 49
	},
	eb_juggernaut_death = {
		prefix = "bossJuggernaut",
		to = 152,
		from = 127
	},
	eb_juggernaut_idle = {
		prefix = "bossJuggernaut",
		to = 78,
		from = 78
	},
	eb_juggernaut_shoot = {
		prefix = "bossJuggernaut",
		to = 125,
		from = 78
	},
	eb_juggernaut_walkingRightLeft = {
		prefix = "bossJuggernaut",
		to = 24,
		from = 1
	},
	eb_juggernaut_walkingUp = {
		prefix = "bossJuggernaut",
		to = 48,
		from = 25
	},
	fx_juggernaut_smoke = {
		prefix = "bossJuggernaut_smoke",
		to = 14,
		from = 1
	},
	bomb_juggernaut_spawner_open = {
		prefix = "bossJuggernaut_bombDecal",
		to = 35,
		from = 1
	},
	bomb_juggernaut_spawner_idle = {
		prefix = "bossJuggernaut_bombDecal",
		to = 35,
		from = 35
	},
	eb_jt_attack = {
		prefix = "boss_JT",
		to = 105,
		from = 66
	},
	eb_jt_breath = {
		prefix = "boss_JT",
		to = 165,
		from = 137
	},
	eb_jt_death_end = {
		prefix = "boss_JT",
		to = 261,
		from = 234
	},
	eb_jt_death = {
		prefix = "boss_JT",
		to = 210,
		from = 166
	},
	eb_jt_freeze = {
		prefix = "boss_JT",
		to = 136,
		from = 108
	},
	eb_jt_idle = {
		prefix = "boss_JT",
		to = 66,
		from = 66
	},
	eb_jt_walkingDown = {
		prefix = "boss_JT",
		to = 65,
		from = 34
	},
	eb_jt_walkingRightLeft = {
		prefix = "boss_JT",
		to = 33,
		from = 1
	},
	fx_jt_ground_hit = {
		prefix = "boss_JT_hitground_smoke",
		to = 14,
		from = 1
	},
	decal_jt_ground_hit = {
		prefix = "boss_JT_hitground_decal",
		to = 12,
		from = 1
	},
	decal_jt_tap = {
		prefix = "boss_JT_tap_notxt",
		to = 7,
		from = 1
	},
	mod_jt_start = {
		prefix = "boss_jt_tower_freeze",
		to = 10,
		from = 1
	},
	mod_jt_end = {
		prefix = "boss_jt_tower_unfreeze",
		to = 23,
		from = 1
	},
	fx_jt_tower_click = {
		prefix = "boss_JT_tapFeedback",
		to = 10,
		from = 1
	},
	eb_sarelgaz_attack = {
		prefix = "boss_sarelgaz",
		to = 66,
		from = 41
	},
	eb_sarelgaz_death = {
		prefix = "boss_sarelgaz",
		to = 94,
		from = 68
	},
	eb_sarelgaz_idle = {
		prefix = "boss_sarelgaz",
		to = 67,
		from = 67
	},
	eb_sarelgaz_walkingDown = {
		prefix = "boss_sarelgaz",
		to = 40,
		from = 21
	},
	eb_sarelgaz_walkingRightLeft = {
		prefix = "boss_sarelgaz",
		to = 20,
		from = 1
	},
	eb_gulthak_attack = {
		prefix = "boss_GulThak",
		to = 53,
		from = 35
	},
	eb_gulthak_death = {
		prefix = "boss_GulThak",
		to = 123,
		from = 89
	},
	eb_gulthak_heal = {
		prefix = "boss_GulThak",
		to = 86,
		from = 55
	},
	eb_gulthak_idle = {
		prefix = "boss_GulThak",
		to = 35,
		from = 35
	},
	eb_gulthak_walkingDown = {
		prefix = "boss_GulThak",
		to = 34,
		from = 18
	},
	eb_gulthak_walkingRightLeft = {
		prefix = "boss_GulThak",
		to = 17,
		from = 1
	},
	eb_gulthak_walkingUp = {
		prefix = "boss_GulThak",
		to = 17,
		from = 1
	},
	eb_greenmuck_attack = {
		prefix = "BossRotten",
		to = 53,
		from = 34
	},
	eb_greenmuck_death = {
		prefix = "BossRotten",
		to = 98,
		from = 87
	},
	eb_greenmuck_idle = {
		prefix = "BossRotten",
		to = 34,
		from = 34
	},
	eb_greenmuck_shoot = {
		prefix = "BossRotten",
		from = 56,
		to = 75,
		pre = {
			34,
			35
		},
		post = {
			34,
			34,
			34,
			34,
			34,
			34,
			34,
			34,
			34,
			34
		}
	},
	eb_greenmuck_walkingDown = {
		prefix = "BossRotten",
		to = 32,
		from = 17
	},
	eb_greenmuck_walkingRightLeft = {
		prefix = "BossRotten",
		to = 16,
		from = 1
	},
	eb_greenmuck_walkingUp = {
		prefix = "BossRotten",
		to = 32,
		from = 17
	},
	eb_kingpin_death = {
		prefix = "BossBandit",
		to = 41,
		from = 25
	},
	eb_kingpin_eat = {
		to = 84,
		from = 43,
		prefix = "BossBandit",
		post = {
			42,
			42,
			42,
			42,
			42
		}
	},
	eb_kingpin_heal = {
		to = 113,
		from = 88,
		prefix = "BossBandit",
		post = {
			42,
			42
		}
	},
	eb_kingpin_idle = {
		prefix = "BossBandit",
		to = 42,
		from = 42
	},
	eb_kingpin_walkingRightLeft = {
		prefix = "BossBandit",
		to = 24,
		from = 1
	},
	eb_ulgukhai_attack = {
		prefix = "TrollBoss",
		to = 98,
		from = 66
	},
	eb_ulgukhai_death = {
		prefix = "TrollBoss",
		to = 128,
		from = 99
	},
	eb_ulgukhai_idle = {
		prefix = "TrollBoss",
		to = 65,
		from = 65
	},
	eb_ulgukhai_walkingDown = {
		prefix = "TrollBoss",
		to = 64,
		from = 33
	},
	eb_ulgukhai_walkingRightLeft = {
		prefix = "TrollBoss",
		to = 32,
		from = 1
	},
	eb_ulgukhai_walkingUp = {
		prefix = "TrollBoss",
		to = 64,
		from = 33
	},
	eb_moloch_attack = {
		prefix = "Inferno_Moloch",
		to = 109,
		from = 84
	},
	eb_moloch_death = {
		prefix = "Inferno_Moloch",
		to = 232,
		from = 153
	},
	eb_moloch_horn_attack = {
		prefix = "Inferno_Moloch",
		to = 152,
		from = 110
	},
	eb_moloch_idle = {
		prefix = "Inferno_Moloch",
		to = 79,
		from = 79
	},
	eb_moloch_sitting = {
		prefix = "Inferno_Moloch",
		to = 65,
		from = 65
	},
	eb_moloch_raise = {
		prefix = "Inferno_Moloch",
		to = 78,
		from = 65
	},
	eb_moloch_walkingDown = {
		prefix = "Inferno_Moloch",
		to = 64,
		from = 33
	},
	eb_moloch_walkingRightLeft = {
		prefix = "Inferno_Moloch",
		to = 32,
		from = 1
	},
	eb_moloch_walkingUp = {
		prefix = "Inferno_Moloch",
		to = 32,
		from = 1
	},
	fx_moloch_rocks = {
		prefix = "Inferno_Moloch_Rocks",
		to = 17,
		from = 1
	},
	fx_moloch_ring = {
		prefix = "Inferno_Moloch_Ring",
		to = 11,
		from = 1
	},
	eb_myconid_attack = {
		prefix = "mushroomBoss",
		to = 74,
		from = 50
	},
	eb_myconid_death = {
		prefix = "mushroomBoss",
		to = 170,
		from = 104
	},
	eb_myconid_idle = {
		prefix = "mushroomBoss",
		to = 1,
		from = 1
	},
	eb_myconid_spores = {
		prefix = "mushroomBoss",
		to = 103,
		from = 75
	},
	eb_myconid_walkingDown = {
		prefix = "mushroomBoss",
		to = 49,
		from = 26
	},
	eb_myconid_walkingRightLeft = {
		prefix = "mushroomBoss",
		to = 25,
		from = 2
	},
	eb_myconid_walkingUp = {
		prefix = "mushroomBoss",
		to = 25,
		from = 2
	},
	fx_myconid_spores = {
		prefix = "mushroomBossCloud",
		to = 46,
		from = 1
	},
	eb_blackburn_attack = {
		prefix = "CB_Boss",
		to = 69,
		from = 29
	},
	eb_blackburn_death = {
		prefix = "CB_Boss",
		to = 186,
		from = 132
	},
	eb_blackburn_death_end = {
		prefix = "CB_Boss",
		to = 201,
		from = 187
	},
	eb_blackburn_idle = {
		prefix = "CB_Boss",
		to = 1,
		from = 1
	},
	eb_blackburn_smash = {
		prefix = "CB_Boss",
		to = 117,
		from = 70
	},
	eb_blackburn_walkingDown = {
		prefix = "CB_Boss",
		to = 27,
		from = 2
	},
	eb_blackburn_walkingRightLeft = {
		prefix = "CB_Boss",
		to = 27,
		from = 2
	},
	eb_blackburn_walkingUp = {
		prefix = "CB_Boss",
		to = 27,
		from = 2
	},
	fx_blackburn_smash = {
		prefix = "CB_Boss_groundHitFx",
		to = 16,
		from = 1
	},
	fx_blackburn_smash_ground = {
		prefix = "CB_Boss_groundHitDecal",
		to = 18,
		from = 1
	},
	mod_blackburn_tower = {
		prefix = "CB_Boss_towerDebuff",
		to = 18,
		from = 1
	},
	tower_faerie_dragon_egg_idle = {
		prefix = "fairy_dragon_egg",
		to = 1,
		from = 1
	},
	tower_faerie_dragon_egg_open = {
		prefix = "fairy_dragon_egg",
		to = 16,
		from = 1
	},
	faerie_dragon_idle = {
		prefix = "fairy_dragon",
		to = 18,
		from = 1
	},
	faerie_dragon_fly = {
		prefix = "fairy_dragon",
		to = 18,
		from = 1
	},
	faerie_dragon_rise = {
		prefix = "fairy_dragon",
		to = 78,
		from = 55
	},
	faerie_dragon_shoot = {
		prefix = "fairy_dragon",
		to = 53,
		from = 19
	},
	faerie_dragon_shoot_fx = {
		prefix = "fairy_dragon",
		to = 113,
		from = 79
	},
	faerie_dragon_proy_flying = {
		prefix = "fairy_dragon_proy",
		to = 1,
		from = 1
	},
	faerie_dragon_proy_hit = {
		prefix = "fairy_dragon_proy",
		to = 9,
		from = 2
	},
	mod_faerie_dragon_ground_start = {
		prefix = "fairy_dragon_freeze",
		to = 7,
		from = 1
	},
	mod_faerie_dragon_ground_end = {
		prefix = "fairy_dragon_freeze",
		to = 23,
		from = 8
	},
	mod_faerie_dragon_air_start = {
		prefix = "fairy_dragon_freeze_flying",
		to = 9,
		from = 1
	},
	mod_faerie_dragon_air_end = {
		prefix = "fairy_dragon_freeze_flying",
		to = 21,
		from = 10
	},
	rabbit_idle = {
		prefix = "rabbit",
		to = 8,
		from = 8
	},
	rabbit_walkingRightLeft = {
		prefix = "rabbit",
		to = 11,
		from = 1
	},
	rabbit_walkingUp = {
		prefix = "rabbit",
		to = 22,
		from = 12
	},
	rabbit_walkingDown = {
		prefix = "rabbit",
		to = 33,
		from = 23
	},
	rabbit_death = {
		prefix = "rabbit",
		to = 44,
		from = 34
	},
	soldier_pirate_captain_idle = {
			prefix = "soldier_pirate_cap",
			to = 1,
			from = 1
		},
		soldier_pirate_captain_running = {
			prefix = "soldier_pirate_cap",
			to = 6,
			from = 2
		},
		soldier_pirate_captain_attack = {
			to = 17,
			from = 7,
			prefix = "soldier_pirate_cap",
			post = {
				1
			}
		},
		soldier_pirate_captain_death = {
			prefix = "soldier_pirate_cap",
			to = 24,
			from = 17
		},
		soldier_pirate_flamer_idle = {
			prefix = "soldier_pirate_flamer",
			to = 1,
			from = 1
		},
		soldier_pirate_flamer_running = {
			prefix = "soldier_pirate_flamer",
			to = 6,
			from = 2
		},
		soldier_pirate_flamer_attack = {
			to = 38,
			from = 19,
			prefix = "soldier_pirate_flamer",
			post = {
				1
			}
		},
		soldier_pirate_flamer_ranged_attack = {
			to = 18,
			from = 7,
			prefix = "soldier_pirate_flamer",
			post = {
				1
			}
		},
		soldier_pirate_flamer_death = {
			prefix = "soldier_pirate_flamer",
			to = 45,
			from = 39
		},
		explosion_molotov = {
			prefix = "proy_molotov_explosion",
			to = 18,
			from = 1
		},
		soldier_pirate_anchor_idle = {
			prefix = "fatPirate",
			to = 1,
			from = 1
		},
		soldier_pirate_anchor_running = {
			prefix = "fatPirate",
			to = 23,
			from = 2
		},
		soldier_pirate_anchor_attack = {
			prefix = "fatPirate",
			to = 47,
			from = 24
		},
		soldier_pirate_anchor_death = {
			prefix = "fatPirate",
			to = 67,
			from = 48
		},
				soldier_amazona_idle = {
			prefix = "AmazonianGirl",
			to = 1,
			from = 1
		},
		soldier_amazona_running = {
			prefix = "AmazonianGirl",
			to = 6,
			from = 2
		},
		soldier_amazona_attack = {
			prefix = "AmazonianGirl",
			to = 22,
			from = 7
		},
		soldier_amazona_attack_2 = {
			prefix = "AmazonianGirl",
			to = 38,
			from = 23
		},
		soldier_amazona_death = {
			prefix = "AmazonianGirl",
			to = 45,
			from = 39
		},
		amazona_healing = {
			prefix = "AmazonGirl_healFx",
			to = 25,
			from = 1
		},
		tower_merc_camp_amazonas_idle = {
			prefix = "AmazonTower",
			to = 1,
			from = 1
		},
		tower_merc_camp_amazonas_open = {
			prefix = "AmazonTower",
			to = 4,
			from = 1
		},
		tower_merc_camp_amazonas_close = {
			prefix = "AmazonTower",
			to = 1,
			from = 4
		},
		shooterarcherhammerhold_idleDown = {
			prefix = "city_archer",
			to = 1,
			from = 1
		},
		shooterarcherhammerhold_idleUp = {
			prefix = "city_archer",
			to = 2,
			from = 2
		},
		shooterarcherhammerhold_shootingDown = {
			prefix = "city_archer",
			to = 10,
			from = 3
		},
		shooterarcherhammerhold_shootingUp = {
			prefix = "city_archer",
			to = 18,
			from = 11
		},
		tower_merc_camp_desert_idle = {
			prefix = "merc_camp_desert",
			to = 1,
			from = 1
		},
		tower_merc_camp_desert_open = {
			prefix = "merc_camp_desert",
			to = 4,
			from = 1
		},
		tower_merc_camp_desert_close = {
			prefix = "merc_camp_desert",
			to = 1,
			from = 4
		},
		tower_merc_camp_desert_fire = {
			prefix = "merc_camp_desert_fire",
			to = 12,
			from = 1
		},
				soldierlegionnaire_idle = {
			prefix = "soldier_legionnaire",
			to = 1,
			from = 1
		},
		soldierlegionnaire_running = {
			prefix = "soldier_legionnaire",
			to = 6,
			from = 2
		},
		soldierlegionnaire_attack = {
			prefix = "soldier_legionnaire",
			to = 17,
			from = 7
		},
		soldierlegionnaire_death = {
			prefix = "soldier_legionnaire",
			to = 30,
			from = 18
		},
		soldierdjinn_idle = {
			prefix = "soldier_djinn",
			to = 12,
			from = 1
		},
		soldierdjinn_running = {
			prefix = "soldier_djinn",
			to = 12,
			from = 1
		},
		soldierdjinn_attack = {
			to = 43,
			from = 25,
			prefix = "soldier_djinn",
			post = {
				1
			}
		},
		soldierdjinn_cast = {
			prefix = "soldier_djinn",
			to = 63,
			from = 44
		},
		soldierdjinn_death = {
			prefix = "soldier_djinn",
			to = 77,
			from = 64
		},
		fx_djinn_smoke = {
			prefix = "soldier_djinn_polysmoke",
			to = 14,
			from = 1
		},
		fx_djinn_frog = {
			prefix = "soldier_djinn_polyshapes",
			to = 56,
			from = 3
		},
	durax_hero_idle = {
		prefix = "durax_hero",
		to = 1,
		from = 1
	},
	durax_hero_running = {
		prefix = "durax_hero",
		to = 21,
		from = 2
	},
	durax_hero_attack = {
		prefix = "durax_hero",
		to = 37,
		from = 22
	},
	durax_hero_attack2 = {
		prefix = "durax_hero",
		to = 54,
		from = 38
	},
	durax_hero_armblade = {
		prefix = "durax_hero",
		to = 96,
		from = 55
	},
	durax_hero_crystallites = {
		prefix = "durax_hero",
		to = 120,
		from = 97
	},
	durax_hero_shardseed = {
		prefix = "durax_hero",
		to = 142,
		from = 121
	},
	durax_hero_lethalPrismStart = {
		prefix = "durax_hero",
		to = 148,
		from = 143
	},
	durax_hero_lethalPrismLoop = {
		prefix = "durax_hero",
		to = 179,
		from = 149
	},
	durax_hero_lethalPrismEnd = {
		prefix = "durax_hero",
		to = 187,
		from = 180
	},
	durax_hero_respawn = {
		prefix = "durax_hero",
		to = 215,
		from = 188
	},
	durax_hero_levelup = {
		prefix = "durax_hero",
		to = 215,
		from = 188
	},
	durax_hero_specialwalkLoop = {
		prefix = "durax_hero",
		to = 223,
		from = 216
	},
	durax_hero_death = {
		prefix = "durax_hero",
		to = 256,
		from = 224
	},
	fx_shardseed_hit = {
		prefix = "durax_hero_proy_explosion",
		to = 15,
		from = 1
	},
	ray_durax = {
		prefix = "durax_hero_lethalprism_ray",
		to = 25,
		from = 1
	},
	fx_ray_durax_hit = {
		prefix = "durax_hero_lethalprism_ray_hit",
		to = 8,
		from = 1
	},
	aura_durax = {
		prefix = "durax_hero_aura_floor",
		to = 16,
		from = 1
	},
	ps_durax_transfer = {
		prefix = "durax_hero_particle",
		to = 6,
		from = 1
	},
	fx_durax_ultimate_fang_1 = {
		prefix = "durax_hero_saphirefangultimate_single",
		to = 29,
		from = 1
	},
	fx_durax_ultimate_fang_2 = {
		prefix = "durax_hero_saphirefangultimate_multiple",
		to = 29,
		from = 1
	},
	fx_durax_ultimate_fang_extra_1 = {
		prefix = "durax_hero_saphirefangultimate_complement_1",
		to = 29,
		from = 1
	},
	fx_durax_ultimate_fang_extra_2 = {
		prefix = "durax_hero_saphirefangultimate_complement_2",
		to = 29,
		from = 1
	},
	hero_phoenix_idle = {
		prefix = "phoenix_hero",
		to = 18,
		from = 1
	},
	hero_phoenix_attack = {
		prefix = "phoenix_hero",
		to = 54,
		from = 19
	},
	hero_phoenix_birdThrow = {
		prefix = "phoenix_hero",
		to = 78,
		from = 55
	},
	hero_phoenix_suicide = {
		prefix = "phoenix_hero",
		to = 116,
		from = 79
	},
	hero_phoenix_death = {
		prefix = "phoenix_hero",
		to = 138,
		from = 117
	},
	hero_phoenix_egg_spawn = {
		prefix = "phoenix_hero",
		to = 155,
		from = 139
	},
	hero_phoenix_egg_idle = {
		prefix = "phoenix_hero",
		to = 169,
		from = 156
	},
	hero_phoenix_respawn = {
		prefix = "phoenix_hero",
		to = 191,
		from = 170
	},
	hero_phoenix_shadow = {
		prefix = "phoenix_hero",
		to = 192,
		from = 192
	},
	hero_phoenix_explosion = {
		prefix = "phoenix_hero",
		to = 210,
		from = 193
	},
	ray_phoenix = {
		prefix = "phoenix_hero_proy",
		to = 12,
		from = 1
	},
	fx_ray_phoenix_hit = {
		prefix = "phoenix_hero_proy_hit",
		to = 16,
		from = 1
	},
	ps_missile_phoenix = {
		prefix = "phoenix_hero_bird_particle",
		to = 8,
		from = 1
	},
	decal_flaming_path_fire = {
		prefix = "phoenix_hero_towerBurn_towerFire",
		to = 14,
		from = 1
	},
	fx_flaming_path_start = {
		prefix = "phoenix_hero_towerBurn_fire_in",
		to = 10,
		from = 1
	},
	fx_flaming_path_end = {
		prefix = "phoenix_hero_towerBurn_fire_out",
		to = 8,
		from = 1
	},
	phoenix_ultimate_place = {
		prefix = "phoenix_hero_egg",
		to = 6,
		from = 1
	},
	phoenix_ultimate_activate = {
		prefix = "phoenix_hero_egg",
		to = 15,
		from = 7
	},
	veznan_hero_idle = {
		prefix = "veznan_hero",
		to = 1,
		from = 1
	},
	veznan_hero_stand = {
		prefix = "veznan_hero",
		to = 35,
		from = 2
	},
	veznan_hero_running = {
		prefix = "veznan_hero",
		to = 51,
		from = 36
	},
	veznan_hero_shoot = {
		prefix = "veznan_hero",
		to = 78,
		from = 52
	},
	veznan_hero_death = {
		prefix = "veznan_hero",
		to = 102,
		from = 79
	},
	veznan_hero_respawn = {
		prefix = "veznan_hero",
		to = 121,
		from = 103
	},
	veznan_hero_levelup = {
		prefix = "veznan_hero",
		to = 121,
		from = 103
	},
	veznan_hero_soulBurnStart = {
		prefix = "veznan_hero",
		to = 132,
		from = 122
	},
	veznan_hero_soulBurnLoop = {
		prefix = "veznan_hero",
		to = 138,
		from = 133
	},
	veznan_hero_soulBurnEnd = {
		prefix = "veznan_hero",
		to = 159,
		from = 139
	},
	veznan_hero_shackles = {
		prefix = "veznan_hero",
		to = 183,
		from = 160
	},
	veznan_hero_arcaneNova = {
		prefix = "veznan_hero",
		to = 219,
		from = 184
	},
	veznan_hero_teleport_out = {
		prefix = "veznan_hero",
		to = 237,
		from = 220
	},
	veznan_hero_teleport_in = {
		prefix = "veznan_hero",
		to = 255,
		from = 238
	},
	veznan_hero_attack = {
		prefix = "veznan_hero",
		to = 274,
		from = 256
	},
	veznan_hero_bolt_flying = {
		prefix = "veznan_hero_proy",
		to = 2,
		from = 1
	},
	veznan_hero_bolt_hit = {
		prefix = "veznan_hero_proy",
		to = 10,
		from = 3
	},
	veznan_hero_soulBurn_proy_spawn_big = {
		prefix = "veznan_hero_soulBurn_Fx_big",
		to = 6,
		from = 1
	},
	veznan_hero_soulBurn_proy_spawn_small = {
		prefix = "veznan_hero_soulBurn_Fx_small",
		to = 6,
		from = 1
	},
	veznan_hero_soulBurn_proy_fly = {
		prefix = "veznan_hero_soulBurn_proy",
		to = 9,
		from = 1
	},
	veznan_hero_soulBurn_proy_hit = {
		prefix = "veznan_hero_soulBurn_proy",
		to = 17,
		from = 10
	},
	veznan_hero_soulBurn_desintegrate_big = {
		prefix = "veznan_hero_soulBurn_big",
		to = 16,
		from = 1
	},
	veznan_hero_soulBurn_desintegrate_small = {
		prefix = "veznan_hero_soulBurn_small",
		to = 16,
		from = 1
	},
	veznan_hero_shackles_big_start = {
		prefix = "veznan_hero_shackles_big",
		to = 11,
		from = 1
	},
	veznan_hero_shackles_big_loop = {
		prefix = "veznan_hero_shackles_big",
		to = 33,
		from = 12
	},
	veznan_hero_shackles_big_end = {
		prefix = "veznan_hero_shackles_big",
		to = 41,
		from = 34
	},
	veznan_hero_shackles_small_start = {
		prefix = "veznan_hero_shackles_small",
		to = 11,
		from = 1
	},
	veznan_hero_shackles_small_loop = {
		prefix = "veznan_hero_shackles_small",
		to = 33,
		from = 12
	},
	veznan_hero_shackles_small_end = {
		prefix = "veznan_hero_shackles_small",
		to = 41,
		from = 34
	},
	fx_veznan_arcanenova = {
		prefix = "veznan_hero_arcaneNova",
		to = 16,
		from = 1
	},
	fx_veznan_arcanenova_terrain = {
		prefix = "veznan_hero_arcaneNova_decal",
		to = 14,
		from = 1
	},
	veznan_demon_raise = {
		prefix = "veznan_hero_demon",
		to = 28,
		from = 1
	},
	veznan_demon_idle = {
		prefix = "veznan_hero_demon",
		to = 29,
		from = 29
	},
	veznan_demon_running = {
		prefix = "veznan_hero_demon",
		to = 45,
		from = 30
	},
	veznan_demon_attack = {
		prefix = "veznan_hero_demon",
		to = 67,
		from = 46
	},
	veznan_demon_shoot = {
		prefix = "veznan_hero_demon",
		to = 92,
		from = 68
	},
	veznan_demon_death = {
		prefix = "veznan_hero_demon",
		to = 113,
		from = 93
	},
	fx_fireball_veznan_demon_hit = {
		prefix = "veznan_hero_demon_proyHit",
		to = 13,
		from = 1
	},
	fx_fireball_veznan_demon_hit_air = {
		prefix = "veznan_hero_demon_proyHit_air",
		to = 18,
		from = 1
	},
	fireball_veznan_demon = {
		prefix = "veznan_hero_demon_proy",
		to = 12,
		from = 1
	},
			hero_pirate_idle = {
			prefix = "hero_pirate",
			to = 1,
			from = 1
		},
		hero_pirate_running = {
			prefix = "hero_pirate",
			to = 7,
			from = 2
		},
		hero_pirate_attack = {
			prefix = "hero_pirate",
			to = 23,
			from = 8
		},
		hero_pirate_death = {
			prefix = "hero_pirate",
			to = 220,
			from = 206
		},
		hero_pirate_respawn = {
			prefix = "hero_pirate",
			to = 171,
			from = 154
		},
		hero_pirate_levelup = {
			prefix = "hero_pirate",
			to = 171,
			from = 154
		},
		hero_pirate_shoot = {
			prefix = "hero_pirate",
			to = 51,
			from = 24
		},
		hero_pirate_shootDown = {
			prefix = "hero_pirate",
			to = 79,
			from = 52
		},
		hero_pirate_shootUp = {
			prefix = "hero_pirate",
			to = 107,
			from = 80
		},
		hero_pirate_kraken = {
			prefix = "hero_pirate",
			to = 153,
			from = 108
		},
		hero_pirate_bombing = {
			prefix = "hero_pirate",
			to = 205,
			from = 172
		},
		barrel_explosion = {
			prefix = "hero_pirate_barrelExplosion",
			to = 18,
			from = 2
		},
		barrel_fragment = {
			prefix = "hero_pirate_barrelFire",
			to = 6,
			from = 1
		},
		barrel_fragment_ground_explosion = {
			prefix = "hero_pirate_barrelFireExplosion",
			to = 14,
			from = 2
		},
		barrel_fragment_trail = {
			prefix = "hero_pirate_barrelFireParticle",
			to = 15,
			from = 1
		},
		kraken_water_start = {
			prefix = "hero_pirate_water",
			to = 8,
			from = 1
		},
		kraken_water_loop = {
			prefix = "hero_pirate_water",
			to = 24,
			from = 9
		},
		kraken_water_end = {
			prefix = "hero_pirate_water",
			to = 33,
			from = 25
		},
		kraken_tentacle_small_grab = {
			prefix = "hero_pirate_tentacle_small",
			to = 82,
			from = 2
		},
		kraken_tentacle_small_end = {
			prefix = "hero_pirate_tentacle_small",
			to = 91,
			from = 82
		},
		kraken_tentacle_big_grab = {
			prefix = "hero_pirate_tentacle_big",
			to = 82,
			from = 2
		},
		kraken_tentacle_big_end = {
			prefix = "hero_pirate_tentacle_big",
			to = 91,
			from = 82
		},
			hero_elves_denas_idle = {
		prefix = "denas_hero",
		to = 1,
		from = 1
	},
	hero_elves_denas_walk = {
		prefix = "denas_hero",
		to = 17,
		from = 2
	},
	hero_elves_denas_attack = {
		prefix = "denas_hero",
		to = 53,
		from = 18
	},
	hero_elves_denas_attack2 = {
		prefix = "denas_hero",
		to = 79,
		from = 54
	},
	hero_elves_denas_eat = {
		prefix = "denas_hero",
		to = 139,
		from = 80
	},
	hero_elves_denas_showOff = {
		prefix = "denas_hero",
		to = 217,
		from = 140
	},
	hero_elves_denas_specialAttack = {
		prefix = "denas_hero",
		to = 271,
		from = 218
	},
	hero_elves_denas_coinThrow = {
		prefix = "denas_hero",
		to = 391,
		from = 355
	},
	hero_elves_denas_death = {
		prefix = "denas_hero",
		to = 332,
		from = 307
	},
	hero_elves_denas_respawn = {
		prefix = "denas_hero",
		to = 354,
		from = 333
	},
	hero_elves_denas_levelup = {
		prefix = "denas_hero",
		to = 354,
		from = 333
	},
	hero_elves_denas_shieldThrow = {
		prefix = "denas_hero",
		to = 306,
		from = 272
	},
	fx_elves_denas_heal = {
		prefix = "denas_hero_healFx",
		to = 25,
		from = 1
	},
	fx_elves_denas_flash = {
		prefix = "denas_hero_flash",
		to = 3,
		from = 1
	},
	shield_elves_denas_loop = {
		prefix = "hero_denas_proy",
		to = 8,
		from = 1
	},
	shield_elves_denas_particle = {
		prefix = "hero_denas_proyParticle",
		to = 8,
		from = 1
	},
	fx_shield_elves_denas_hit = {
		prefix = "hero_denas_proyHit",
		to = 7,
		from = 1
	},
	elves_denas_guard_idle = {
		prefix = "denas_hero_guard",
		to = 1,
		from = 1
	},
	elves_denas_guard_running = {
		prefix = "denas_hero_guard",
		to = 6,
		from = 2
	},
	elves_denas_guard_attack = {
		prefix = "denas_hero_guard",
		to = 28,
		from = 7
	},
	elves_denas_guard_attack2 = {
		prefix = "denas_hero_guard",
		to = 52,
		from = 29
	},
	elves_denas_guard_death = {
		prefix = "denas_hero_guard",
		to = 60,
		from = 53
	},
	elves_denas_guard_respawn = {
		prefix = "denas_hero_guard",
		to = 79,
		from = 61
	},
	elves_denas_guard_raise = {
		prefix = "denas_hero_guard",
		to = 79,
		from = 61
	},
		hero_wizard_idle = {
			prefix = "hero_mage",
			to = 1,
			from = 1
		},
		hero_wizard_running = {
			prefix = "hero_mage",
			to = 17,
			from = 2
		},
		hero_wizard_shoot = {
			prefix = "hero_mage",
			to = 51,
			from = 18
		},
		hero_wizard_teleport_out = {
			prefix = "hero_mage",
			to = 83,
			from = 52
		},
		hero_wizard_teleport_in = {
			prefix = "hero_mage",
			to = 124,
			from = 86
		},
		hero_wizard_respawn = {
			prefix = "hero_mage",
			to = 124,
			from = 86
		},
		hero_wizard_death = {
			prefix = "hero_mage",
			to = 139,
			from = 125
		},
		hero_wizard_attack = {
			prefix = "hero_mage",
			to = 224,
			from = 201
		},
		hero_wizard_levelup = {
			prefix = "hero_mage",
			to = 243,
			from = 225
		},
		hero_wizard_missile_start = {
			prefix = "hero_mage",
			to = 153,
			from = 140
		},
		hero_wizard_missile_loop = {
			prefix = "hero_mage",
			to = 157,
			from = 157
		},
		hero_wizard_missile_end = {
			prefix = "hero_mage",
			to = 161,
			from = 158,
			pre = {
				154,
				154,
				154
			}
		},
		hero_wizard_disintegrate = {
			prefix = "hero_mage",
			to = 202,
			from = 162
		},
		fx_wizard_disintegrate = {
			prefix = "hero_mage_papers",
			to = 31,
			from = 1
		},
		ray_wizard = {
			prefix = "hero_mage_bolt",
			to = 14,
			from = 1
		},
		ray_wizard_ball = {
			prefix = "hero_mage_bolt_ball",
			to = 18,
			from = 1
		},
		missile_wizard_flying = {
			prefix = "hero_mage_proy",
			to = 6,
			from = 1
		},
		missile_wizard_hit = {
			prefix = "hero_mage_proy",
			to = 14,
			from = 7
		},
		missile_wizard_trail = {
			prefix = "hero_mage_proyParticle",
			to = 12,
			from = 1
		},
		missile_wizard_sparks1 = {
			prefix = "hero_mage_proyParticleSpk1",
			to = 10,
			from = 1
		},
		missile_wizard_sparks2 = {
			prefix = "hero_mage_proyParticleSpk2",
			to = 10,
			from = 1
		},
		missile_wizard_sparks3 = {
			prefix = "hero_mage_proyParticleSpk3",
			to = 10,
			from = 1
		},
		hero_minotaur_idle = {
			prefix = "minotaur",
			to = 1,
			from = 1
		},
		hero_minotaur_running = {
			prefix = "minotaur",
			to = 19,
			from = 2
		},
		hero_minotaur_attack = {
			prefix = "minotaur",
			to = 41,
			from = 20
		},
		hero_minotaur_death = {
			prefix = "minotaur",
			to = 233,
			from = 213
		},
		hero_minotaur_respawn = {
			prefix = "minotaur",
			to = 255,
			from = 234
		},
		hero_minotaur_levelup = {
			prefix = "minotaur",
			to = 255,
			from = 234
		},
		hero_minotaur_axe = {
			prefix = "minotaur",
			to = 75,
			from = 42
		},
		hero_minotaur_roar = {
			prefix = "minotaur",
			to = 183,
			from = 137
		},
		hero_minotaur_spin = {
			prefix = "minotaur",
			to = 103,
			from = 76
		},
		hero_minotaur_daedalus = {
			prefix = "minotaur",
			to = 136,
			from = 104
		},
		hero_minotaur_rush_start = {
			prefix = "minotaur",
			to = 191,
			from = 184
		},
		hero_minotaur_rush_loop = {
			prefix = "minotaur",
			to = 199,
			from = 192
		},
		hero_minotaur_rush_end = {
			prefix = "minotaur",
			to = 213,
			from = 200
		},
		decal_minotaur_roaroffury_horns = {
			prefix = "minotaur_towerBuff_horns",
			to = 12,
			from = 1
		},
		fx_minotaur_roarofury_scream = {
			prefix = "minotaur_scream",
			to = 36,
			from = 1
		},
		fx_minotaur_dust = {
			prefix = "minotaur_dust",
			to = 8,
			from = 1
		},
	eb_veznan_attack = {
		prefix = "boss_veznan",
		to = 124,
		from = 87
	},
	eb_veznan_idle = {
		prefix = "boss_veznan",
		to = 85,
		from = 85
	},
	eb_veznan_idleDown = {
		prefix = "boss_veznan",
		to = 86,
		from = 86
	},
	eb_veznan_laugh = {
		prefix = "boss_veznan",
		to = 385,
		from = 379
	},
	eb_veznan_spell = {
		prefix = "boss_veznan",
		to = 154,
		from = 127
	},
	eb_veznan_spellDown = {
		prefix = "boss_veznan",
		to = 185,
		from = 158
	},
	eb_veznan_walkAway = {
		prefix = "boss_veznan",
		to = 378,
		from = 343
	},
	eb_veznan_walkingDown = {
		prefix = "boss_veznan",
		to = 56,
		from = 29
	},
	eb_veznan_walkingRightLeft = {
		prefix = "boss_veznan",
		to = 28,
		from = 1
	},
	eb_veznan_walkingUp = {
		prefix = "boss_veznan",
		to = 84,
		from = 57
	},
	eb_veznan_demonTransform = {
		prefix = "boss_veznan",
		to = 244,
		from = 224,
		pre = {
			127,
			127,
			129,
			129,
			131,
			131,
			220,
			220,
			135,
			135
		}
	},
	eb_veznan_demon_attack = {
		prefix = "boss_veznan",
		to = 342,
		from = 295
	},
	eb_veznan_demon_idle = {
		prefix = "boss_veznan",
		to = 296,
		from = 296
	},
	eb_veznan_demon_walkingDown = {
		prefix = "boss_veznan",
		to = 294,
		from = 271
	},
	eb_veznan_demon_walkingRightLeft = {
		prefix = "boss_veznan",
		to = 270,
		from = 247
	},
	eb_veznan_demon_walkingUp = {
		prefix = "boss_veznan",
		to = 270,
		from = 247
	},
	eb_veznan_demon_death = {
		prefix = "boss_veznan",
		to = 536,
		from = 386
	},
	eb_veznan_demon_deathLoop = {
		prefix = "boss_veznan",
		to = 543,
		from = 537
	},
	eb_veznan_demon_deathEnd = {
		prefix = "boss_veznan",
		to = 537,
		from = 537
	},
	decal_veznan_strike = {
		prefix = "boss_veznan_unholystrike",
		to = 14,
		from = 1
	},
	fx_veznan_demon_fire = {
		to = 11,
		from = 1,
		prefix = "boss_veznan_demonFire",
		post = {
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10,
			11,
			23,
			23,
			25,
			26
		}
	},
	veznan_portal_idle = {
		prefix = "boss_veznan_infernalPortal",
		to = 1,
		from = 1
	},
	veznan_portal_start = {
		prefix = "boss_veznan_infernalPortal",
		to = 11,
		from = 1
	},
	veznan_portal_active = {
		prefix = "boss_veznan_infernalPortal",
		to = 20,
		from = 12
	},
	veznan_portal_end = {
		to = 10,
		from = 10,
		prefix = "boss_veznan_infernalPortal",
		post = {
			9,
			8,
			7,
			6,
			5,
			4,
			3,
			2,
			1,
			1
		}
	},
	mod_veznan_start = {
		prefix = "boss_veznan_towerHold",
		to = 32,
		from = 1
	},
	mod_veznan_preHold = {
		prefix = "boss_veznan_towerHold",
		to = 40,
		from = 33
	},
	mod_veznan_hold = {
		prefix = "boss_veznan_towerHold",
		to = 54,
		from = 41
	},
	mod_veznan_remove = {
		prefix = "boss_veznan_towerHold",
		to = 64,
		from = 55
	},
	decal_veznan_tap = {
		prefix = "boss_veznan_tap",
		to = 7,
		from = 1
	},
	decal_veznan_soul = {
		prefix = "boss_veznan_soul",
		to = 19,
		from = 11
	},
	decal_veznan_white_circle = {
		prefix = "boss_veznan_deathExplotion",
		to = 65,
		from = 1
	},
	eb_elder_shaman_cast = {
		prefix = "endless_boss",
		to = 36,
		from = 2
	},
	eb_elder_shaman_idle = {
		prefix = "endless_boss",
		to = 1,
		from = 2
	},
	elder_shaman_totem_orange_start = {
		prefix = "totem_orange",
		to = 10,
		from = 1
	},
	elder_shaman_totem_orange_end = {
		prefix = "totem_orange",
		to = 30,
		from = 11
	},
	elder_shaman_totem_orange_fx = {
		prefix = "totem_orange_fx",
		to = 37,
		from = 1
	},
	elder_shaman_totem_blue_start = {
		prefix = "totem_lightBlue",
		to = 10,
		from = 1
	},
	elder_shaman_totem_blue_end = {
		prefix = "totem_lightBlue",
		to = 30,
		from = 11
	},
	elder_shaman_totem_blue_fx = {
		prefix = "totem_lightBlue_fx",
		to = 18,
		from = 1
	},
	elder_shaman_totem_red_start = {
		prefix = "totem_red",
		to = 10,
		from = 1
	},
	elder_shaman_totem_red_end = {
		prefix = "totem_red",
		to = 30,
		from = 11
	},
	elder_shaman_totem_red_fx = {
		prefix = "totem_red_fx",
		to = 12,
		from = 1
	},
	re_farmer_1_idle = {
		prefix = "reinforce_A0",
		to = 1,
		from = 1
	},
	re_farmer_1_running = {
		prefix = "reinforce_A0",
		to = 6,
		from = 2
	},
	re_farmer_1_attack = {
		prefix = "reinforce_A0",
		to = 17,
		from = 7
	},
	re_farmer_2_idle = {
		prefix = "reinforce_B0",
		to = 1,
		from = 1
	},
	re_farmer_2_running = {
		prefix = "reinforce_B0",
		to = 6,
		from = 2
	},
	re_farmer_2_attack = {
		prefix = "reinforce_B0",
		to = 17,
		from = 7
	},
	re_farmer_3_idle = {
		prefix = "reinforce_C0",
		to = 1,
		from = 1
	},
	re_farmer_3_running = {
		prefix = "reinforce_C0",
		to = 6,
		from = 2
	},
	re_farmer_3_attack = {
		prefix = "reinforce_C0",
		to = 17,
		from = 7
	},
	re_farmer_well_fed_1_idle = {
		prefix = "reinforce_A0",
		to = 1,
		from = 1
	},
	re_farmer_well_fed_1_running = {
		prefix = "reinforce_A0",
		to = 6,
		from = 2
	},
	re_farmer_well_fed_1_attack = {
		prefix = "reinforce_A0",
		to = 17,
		from = 7
	},
	re_farmer_well_fed_2_idle = {
		prefix = "reinforce_B0",
		to = 1,
		from = 1
	},
	re_farmer_well_fed_2_running = {
		prefix = "reinforce_B0",
		to = 6,
		from = 2
	},
	re_farmer_well_fed_2_attack = {
		prefix = "reinforce_B0",
		to = 17,
		from = 7
	},
	re_farmer_well_fed_3_idle = {
		prefix = "reinforce_C0",
		to = 1,
		from = 1
	},
	re_farmer_well_fed_3_running = {
		prefix = "reinforce_C0",
		to = 6,
		from = 2
	},
	re_farmer_well_fed_3_attack = {
		prefix = "reinforce_C0",
		to = 17,
		from = 7
	},
	re_conscript_1_idle = {
		prefix = "reinforce_A1",
		to = 1,
		from = 1
	},
	re_conscript_1_running = {
		prefix = "reinforce_A1",
		to = 6,
		from = 2
	},
	re_conscript_1_attack = {
		prefix = "reinforce_A1",
		to = 17,
		from = 7
	},
	re_conscript_2_idle = {
		prefix = "reinforce_B1",
		to = 1,
		from = 1
	},
	re_conscript_2_running = {
		prefix = "reinforce_B1",
		to = 6,
		from = 2
	},
	re_conscript_2_attack = {
		prefix = "reinforce_B1",
		to = 17,
		from = 7
	},
	re_conscript_3_idle = {
		prefix = "reinforce_C1",
		to = 1,
		from = 1
	},
	re_conscript_3_running = {
		prefix = "reinforce_C1",
		to = 6,
		from = 2
	},
	re_conscript_3_attack = {
		prefix = "reinforce_C1",
		to = 17,
		from = 7
	},
	re_warrior_1_idle = {
		prefix = "reinforce_A2",
		to = 1,
		from = 1
	},
	re_warrior_1_running = {
		prefix = "reinforce_A2",
		to = 6,
		from = 2
	},
	re_warrior_1_attack = {
		prefix = "reinforce_A2",
		to = 17,
		from = 7
	},
	re_warrior_2_idle = {
		prefix = "reinforce_B2",
		to = 1,
		from = 1
	},
	re_warrior_2_running = {
		prefix = "reinforce_B2",
		to = 6,
		from = 2
	},
	re_warrior_2_attack = {
		prefix = "reinforce_B2",
		to = 17,
		from = 7
	},
	re_warrior_3_idle = {
		prefix = "reinforce_C2",
		to = 1,
		from = 1
	},
	re_warrior_3_running = {
		prefix = "reinforce_C2",
		to = 6,
		from = 2
	},
	re_warrior_3_attack = {
		prefix = "reinforce_C2",
		to = 17,
		from = 7
	},
	re_legionnaire_1_idle = {
		prefix = "reinforce_A3",
		to = 1,
		from = 1
	},
	re_legionnaire_1_running = {
		prefix = "reinforce_A3",
		to = 6,
		from = 2
	},
	re_legionnaire_1_attack = {
		prefix = "reinforce_A3",
		to = 17,
		from = 7
	},
	re_legionnaire_2_idle = {
		prefix = "reinforce_B3",
		to = 1,
		from = 1
	},
	re_legionnaire_2_running = {
		prefix = "reinforce_B3",
		to = 6,
		from = 2
	},
	re_legionnaire_2_attack = {
		prefix = "reinforce_B3",
		to = 17,
		from = 7
	},
	re_legionnaire_3_idle = {
		prefix = "reinforce_C3",
		to = 1,
		from = 1
	},
	re_legionnaire_3_running = {
		prefix = "reinforce_C3",
		to = 6,
		from = 2
	},
	re_legionnaire_3_attack = {
		prefix = "reinforce_C3",
		to = 17,
		from = 7
	},
	re_legionnaire_ranged_1_idle = {
		prefix = "reinforce_A3",
		to = 1,
		from = 1
	},
	re_legionnaire_ranged_1_running = {
		prefix = "reinforce_A3",
		to = 6,
		from = 2
	},
	re_legionnaire_ranged_1_attack = {
		prefix = "reinforce_A3",
		to = 17,
		from = 7
	},
	re_legionnaire_ranged_1_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "reinforce_A3",
		post = {
			1
		}
	},
	re_legionnaire_ranged_1_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "reinforce_A3",
		post = {
			1
		}
	},
	re_legionnaire_ranged_2_idle = {
		prefix = "reinforce_B3",
		to = 1,
		from = 1
	},
	re_legionnaire_ranged_2_running = {
		prefix = "reinforce_B3",
		to = 6,
		from = 2
	},
	re_legionnaire_ranged_2_attack = {
		prefix = "reinforce_B3",
		to = 17,
		from = 7
	},
	re_legionnaire_ranged_2_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "reinforce_B3",
		post = {
			1
		}
	},
	re_legionnaire_ranged_2_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "reinforce_B3",
		post = {
			1
		}
	},
	re_legionnaire_ranged_3_idle = {
		prefix = "reinforce_C3",
		to = 1,
		from = 1
	},
	re_legionnaire_ranged_3_running = {
		prefix = "reinforce_C3",
		to = 6,
		from = 2
	},
	re_legionnaire_ranged_3_attack = {
		prefix = "reinforce_C3",
		to = 17,
		from = 7
	},
	re_legionnaire_ranged_3_ranged_attack = {
		to = 26,
		from = 18,
		prefix = "reinforce_C3",
		post = {
			1
		}
	},
	re_legionnaire_ranged_3_ranged_attack_p = {
		to = 41,
		from = 33,
		prefix = "reinforce_C3",
		post = {
			1
		}
	},
	soldiermilitia_idle = {
		prefix = "soldier_lvl1",
		to = 1,
		from = 1
	},
	soldiermilitia_running = {
		prefix = "soldier_lvl1",
		to = 6,
		from = 2
	},
	soldiermilitia_attack = {
		prefix = "soldier_lvl1",
		to = 17,
		from = 7
	},
	soldiermilitia_death = {
		prefix = "soldier_lvl1",
		to = 23,
		from = 18
	},
	soldierfootmen_idle = {
		prefix = "soldier_lvl2",
		to = 1,
		from = 1
	},
	soldierfootmen_running = {
		prefix = "soldier_lvl2",
		to = 6,
		from = 2
	},
	soldiermilitia3_idle = {
		prefix = "Greenfin",
		to = 67,
		from = 67
	},
	soldiermilitia3_running = {
		prefix = "Greenfin",
		to = 22,
		from = 1
	},
	soldiermilitia3_attack = {
		prefix = "Greenfin",
		to = 76,
		from = 68
	},
	soldiermilitia3_death = {
		prefix = "Greenfin",
		to = 85,
		from = 77
	},
	soldiermilitia3_netAttack = {
		prefix = "Greenfin",
		to = 106,
		from = 86
	},
	soldiermilitia4_idle = {
		prefix = "GreenfinArmor",
		to = 67,
		from = 67
	},
	soldiermilitia4_running = {
		prefix = "GreenfinArmor",
		to = 22,
		from = 1
	},
	soldiermilitia4_attack = {
		prefix = "GreenfinArmor",
		to = 76,
		from = 68
	},
	soldiermilitia4_death = {
		prefix = "GreenfinArmor",
		to = 85,
		from = 77
	},
	soldiermilitia4_netAttack = {
		prefix = "GreenfinArmor",
		to = 106,
		from = 86
	},
	soldiermilitia5_idle = {
		prefix = "Redspine",
		to = 73,
		from = 73
	},
	soldiermilitia5_running = {
		prefix = "Redspine",
		to = 24,
		from = 1
	},
	soldiermilitia5_attack = {
		prefix = "Redspine",
		to = 94,
		from = 74
	},
	soldiermilitia5_death = {
		prefix = "Redspine",
		to = 175,
		from = 164
	},
	soldiermilitia5_rangedAttack = {
		prefix = "Redspine",
		to = 113,
		from = 95
	},
	soldierfootmen_idle = {
		prefix = "soldier_lvl2",
		to = 1,
		from = 1
	},
	soldierfootmen_running = {
		prefix = "soldier_lvl2",
		to = 6,
		from = 2
	},
	soldierfootmen_attack = {
		prefix = "soldier_lvl2",
		to = 17,
		from = 7
	},
	soldierfootmen_death = {
		prefix = "soldier_lvl2",
		to = 23,
		from = 18
	},
	soldierknight_idle = {
		prefix = "soldier_lvl3",
		to = 1,
		from = 1
	},
	soldierknight_running = {
		prefix = "soldier_lvl3",
		to = 6,
		from = 2
	},
	soldierknight_attack = {
		prefix = "soldier_lvl3",
		to = 17,
		from = 7
	},
	soldierknight_death = {
		prefix = "soldier_lvl3",
		to = 23,
		from = 18
	},
	soldier_elemental_idle = {
		prefix = "soldier_elemental",
		to = 1,
		from = 1
	},
	soldier_elemental_running = {
		prefix = "soldier_elemental",
		to = 26,
		from = 2
	},
	soldier_elemental_attack = {
		prefix = "soldier_elemental",
		to = 55,
		from = 27
	},
	soldier_elemental_death = {
		prefix = "soldier_elemental",
		to = 71,
		from = 56
	},
	soldier_elemental_raise = {
		prefix = "soldier_elemental",
		to = 91,
		from = 72
	},
	soldier_paladin_idle = {
		prefix = "soldier_lvl4_paladin",
		to = 1,
		from = 1
	},
	soldier_paladin_running = {
		prefix = "soldier_lvl4_paladin",
		to = 6,
		from = 2
	},
	soldier_paladin_attack = {
		prefix = "soldier_lvl4_paladin",
		to = 17,
		from = 7
	},
	soldier_paladin_attack2 = {
		prefix = "soldier_lvl4_paladin",
		to = 28,
		from = 18
	},
	soldier_paladin_dodge = {
		prefix = "soldier_lvl4_paladin",
		to = 98,
		from = 98
	},
	soldier_paladin_death = {
		prefix = "soldier_lvl4_paladin",
		to = 97,
		from = 91
	},
	soldier_paladin_holystrike = {
		prefix = "soldier_lvl4_paladin",
		to = 59,
		from = 31
	},
	soldier_paladin_healing = {
		prefix = "soldier_lvl4_paladin",
		to = 90,
		from = 60
	},
	decal_paladin_holystrike = {
		prefix = "decal_holystrike",
		to = 12,
		from = 1
	},
	soldier_barbarian_idle = {
		prefix = "soldier_lvl4_barbarian",
		to = 1,
		from = 1
	},
	soldier_barbarian_idle2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 2,
		from = 2
	},
	soldier_barbarian_running = {
		prefix = "soldier_lvl4_barbarian",
		to = 7,
		from = 3
	},
	soldier_barbarian_running2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 12,
		from = 8
	},
	soldier_barbarian_attack = {
		prefix = "soldier_lvl4_barbarian",
		to = 23,
		from = 13
	},
	soldier_barbarian_attack2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 42,
		from = 24
	},
	soldier_barbarian_shoot = {
		prefix = "soldier_lvl4_barbarian",
		to = 88,
		from = 73
	},
	soldier_barbarian_shoot2 = {
		prefix = "soldier_lvl4_barbarian",
		to = 72,
		from = 57
	},
	soldier_barbarian_twister = {
		to = 56,
		from = 43,
		prefix = "soldier_lvl4_barbarian",
		post = {
			1
		}
	},
	soldier_barbarian_twister2 = {
		to = 56,
		from = 43,
		prefix = "soldier_lvl4_barbarian",
		post = {
			2
		}
	},
	soldier_barbarian_death = {
		prefix = "soldier_lvl4_barbarian",
		to = 95,
		from = 89
	},
	soldier_elf_idle = {
		prefix = "elfSoldier",
		to = 1,
		from = 1
	},
	soldier_elf_running = {
		prefix = "elfSoldier",
		to = 6,
		from = 1
	},
	soldier_elf_attack = {
		prefix = "elfSoldier",
		to = 24,
		from = 7
	},
	soldier_elf_death = {
		prefix = "elfSoldier",
		to = 47,
		from = 40
	},
	soldier_elf_shoot = {
		prefix = "elfSoldier",
		to = 36,
		from = 25
	},
	soldier_sasquash_idle = {
		prefix = "sasquash",
		to = 1,
		from = 1
	},
	soldier_sasquash_running = {
		prefix = "sasquash",
		to = 26,
		from = 2
	},
	soldier_sasquash_attack = {
		prefix = "sasquash",
		to = 55,
		from = 29
	},
	soldier_sasquash_death = {
		prefix = "sasquash",
		to = 80,
		from = 56
	},
	soldier_sasquash2_idle = {
		prefix = "forest_troll",
		to = 73,
		from = 73
	},
	soldier_sasquash2_running = {
		prefix = "forest_troll",
		to = 25,
		from = 1
	},
	soldier_sasquash2_attack = {
		prefix = "forest_troll",
		to = 103,
		from = 73
	},
	soldier_sasquash2_death = {
		prefix = "forest_troll",
		to = 159,
		from = 126
	},
	soldier_s6_imperial_guard_idle = {
		prefix = "imperialGuard",
		to = 17,
		from = 17
	},
	soldier_s6_imperial_guard_running = {
		prefix = "imperialGuard",
		to = 6,
		from = 1
	},
	soldier_s6_imperial_guard_attack = {
		prefix = "imperialGuard",
		to = 17,
		from = 7
	},
	soldier_s6_imperial_guard_attack2 = {
		prefix = "imperialGuard",
		to = 28,
		from = 18
	},
	soldier_s6_imperial_guard_death = {
		prefix = "imperialGuard",
		to = 40,
		from = 29
	},
	shooterarcherlvl1_idleDown = {
		prefix = "tower_archer_lvl1_shooter",
		to = 1,
		from = 1
	},
	shooterarcherlvl1_idleUp = {
		prefix = "tower_archer_lvl1_shooter",
		to = 2,
		from = 2
	},
	shooterarcherlvl1_shootingDown = {
		prefix = "tower_archer_lvl1_shooter",
		to = 10,
		from = 3
	},
	shooterarcherlvl1_shootingUp = {
		prefix = "tower_archer_lvl1_shooter",
		to = 18,
		from = 11
	},
	shooterarcherlvl2_idleDown = {
		prefix = "tower_archer_lvl2_shooter",
		to = 1,
		from = 1
	},
	shooterarcherlvl2_idleUp = {
		prefix = "tower_archer_lvl2_shooter",
		to = 2,
		from = 2
	},
	shooterarcherlvl2_shootingDown = {
		prefix = "tower_archer_lvl2_shooter",
		to = 10,
		from = 3
	},
	shooterarcherlvl2_shootingUp = {
		prefix = "tower_archer_lvl2_shooter",
		to = 18,
		from = 11
	},
	shooterarcherlvl3_idleDown = {
		prefix = "tower_archer_lvl3_shooter",
		to = 1,
		from = 1
	},
	shooterarcherlvl3_idleUp = {
		prefix = "tower_archer_lvl3_shooter",
		to = 2,
		from = 2
	},
	shooterarcherlvl3_shootingDown = {
		prefix = "tower_archer_lvl3_shooter",
		to = 10,
		from = 3
	},
	shooterarcherlvl3_shootingUp = {
		prefix = "tower_archer_lvl3_shooter",
		to = 18,
		from = 11
	},
	towerbarracklvl1_door_open = {
		prefix = "tower_barracks_lvl1_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl2_door_open = {
		prefix = "tower_barracks_lvl2_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl3_door_open = {
		prefix = "tower_barracks_lvl3_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl1_door_close = {
		prefix = "tower_barracks_lvl1_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl2_door_close = {
		prefix = "tower_barracks_lvl2_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl3_door_close = {
		prefix = "tower_barracks_lvl3_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl4_paladin_door_open = {
		prefix = "tower_barracks_lvl4_Paladins_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl4_paladin_door_close = {
		prefix = "tower_barracks_lvl4_Paladins_layer2",
		to = 25,
		from = 22
	},
	towerbarracklvl4_barbarian_door_open = {
		prefix = "tower_barrack_lvl4_Barbarians_layer2",
		to = 5,
		from = 1
	},
	towerbarracklvl4_barbarian_door_close = {
		prefix = "tower_barrack_lvl4_Barbarians_layer2",
		to = 25,
		from = 22
	},
	tower_elf_door_open = {
		prefix = "elfTower_layer2",
		to = 5,
		from = 1
	},
	tower_elf_door_close = {
		prefix = "elfTower_layer2",
		to = 25,
		from = 22
	},
	shootermage_idleDown = {
		prefix = "mage_shooter",
		to = 1,
		from = 1
	},
	shootermage_idleUp = {
		prefix = "mage_shooter",
		to = 2,
		from = 2
	},
	shootermage_shootingDown = {
		prefix = "mage_shooter",
		to = 15,
		from = 3
	},
	shootermage_shootingUp = {
		prefix = "mage_shooter",
		to = 30,
		from = 17
	},
	towermagelvl1_idle = {
		prefix = "mage_lvl1",
		to = 1,
		from = 1
	},
	towermagelvl1_shoot = {
		prefix = "mage_lvl1",
		to = 12,
		from = 1
	},
	towermagelvl2_idle = {
		prefix = "mage_lvl2",
		to = 1,
		from = 1
	},
	towermagelvl2_shoot = {
		prefix = "mage_lvl2",
		to = 12,
		from = 1
	},
	towermagelvl3_idle = {
		prefix = "mage_lvl3",
		to = 1,
		from = 1
	},
	towermagelvl3_shoot = {
		prefix = "mage_lvl3",
		to = 12,
		from = 1
	},
	bolt_idle = {
		prefix = "magebolt",
		to = 2,
		from = 1
	},
	bolt_flying = {
		prefix = "magebolt",
		to = 2,
		from = 1
	},
	bolt_hit = {
		prefix = "magebolt",
		to = 10,
		from = 3
	},
	towerengineerlvl1_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl1_layer%i",
		to = 1,
		layer_from = 1
	},
	towerengineerlvl1_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl1_layer%i",
		to = 35,
		layer_from = 1
	},
	towerengineerlvl2_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl2_layer%i",
		to = 1,
		layer_from = 1
	},
	towerengineerlvl2_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl2_layer%i",
		to = 35,
		layer_from = 1
	},
	towerengineerlvl3_layerX_idle = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl3_layer%i",
		to = 1,
		layer_from = 1
	},
	towerengineerlvl3_layerX_shoot = {
		layer_to = 7,
		from = 1,
		layer_prefix = "tower_artillery_lvl3_layer%i",
		to = 35,
		layer_from = 1
	},
	tower_ranger_shooter_idleDown = {
		prefix = "tower_archer_ranger_shooter",
		to = 1,
		from = 1
	},
	tower_ranger_shooter_idleUp = {
		prefix = "tower_archer_ranger_shooter",
		to = 2,
		from = 2
	},
	tower_ranger_shooter_shootingDown = {
		prefix = "tower_archer_ranger_shooter",
		to = 10,
		from = 3
	},
	tower_ranger_shooter_shootingUp = {
		prefix = "tower_archer_ranger_shooter",
		to = 18,
		from = 11
	},
	tower_ranger_druid_idle = {
		prefix = "tower_archer_druid",
		to = 1,
		from = 1
	},
	tower_ranger_druid_shoot = {
		prefix = "tower_archer_druid",
		to = 41,
		from = 1
	},
	tower_musketeer_shooter_idleDown = {
		prefix = "tower_archer_musketeer_shooter",
		to = 1,
		from = 1
	},
	tower_musketeer_shooter_idleUp = {
		prefix = "tower_archer_musketeer_shooter",
		to = 2,
		from = 2
	},
	tower_musketeer_shooter_shootingDown = {
		to = 26,
		from = 1,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			1
		}
	},
	tower_musketeer_shooter_shootingUp = {
		to = 50,
		from = 27,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			2
		}
	},
	tower_musketeer_shooter_cannonShootDown = {
		to = 225,
		from = 194,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			1
		}
	},
	tower_musketeer_shooter_cannonShootUp = {
		to = 257,
		from = 226,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			2
		}
	},
	tower_musketeer_shooter_cannonFuseDown = {
		to = 161,
		from = 130,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			1
		}
	},
	tower_musketeer_shooter_cannonFuseUp = {
		to = 193,
		from = 162,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			2
		}
	},
	tower_musketeer_shooter_sniperShootDown = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				51,
				56
			},
			{
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56,
				56
			},
			{
				57,
				74
			},
			{
				1
			}
		}
	},
	tower_musketeer_shooter_sniperShootUp = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				75,
				80
			},
			{
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80,
				80
			},
			{
				81,
				98
			},
			{
				2
			}
		}
	},
	tower_musketeer_shooter_sniperSeekDown = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				99,
				107
			},
			{
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107,
				107
			},
			{
				116,
				121
			},
			{
				1
			}
		}
	},
	tower_musketeer_shooter_sniperSeekUp = {
		prefix = "tower_archer_musketeer_shooter",
		ranges = {
			{
				108,
				115
			},
			{
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115,
				115
			},
			{
				123,
				129
			},
			{
				2
			}
		}
	},
	tower_arcane_wizard_idle = {
		prefix = "arcane_tower",
		to = 1,
		from = 1
	},
	tower_arcane_wizard_shoot = {
		prefix = "arcane_tower",
		to = 39,
		from = 1
	},
	tower_arcane_wizard_teleport = {
		to = 49,
		from = 40,
		prefix = "arcane_tower",
		post = {
			1
		}
	},
	fx_tower_arcane_wizard_teleport = {
		prefix = "arcane_teleport_effect",
		to = 22,
		from = 1
	},
	tower_arcane_wizard_shooter_idleDown = {
		prefix = "arcane_shooter",
		to = 1,
		from = 1
	},
	tower_arcane_wizard_shooter_idleUp = {
		prefix = "arcane_shooter",
		to = 2,
		from = 2
	},
	tower_arcane_wizard_shooter_shootingDown = {
		to = 36,
		from = 3,
		prefix = "arcane_shooter",
		post = {
			1
		}
	},
	tower_arcane_wizard_shooter_shootingUp = {
		to = 69,
		from = 37,
		prefix = "arcane_shooter",
		post = {
			2
		}
	},
	tower_arcane_wizard_shooter_teleportDown = {
		prefix = "arcane_shooter",
		frames = {
			3,
			4,
			5,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			6,
			5,
			4,
			3,
			1
		}
	},
	tower_arcane_wizard_shooter_teleportUp = {
		prefix = "arcane_shooter",
		frames = {
			37,
			38,
			39,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			40,
			39,
			38,
			37,
			2
		}
	},
	ray_arcane = {
		prefix = "ray_arcane",
		to = 6,
		from = 1
	},
	ray_arcane_disintegrate = {
		prefix = "ray_desintegrate",
		to = 9,
		from = 1
	},
	mod_ray_arcane = {
		prefix = "arcanehit",
		to = 12,
		from = 1
	},
	aura_teleport_arcane = {
		prefix = "decal_teleportal",
		to = 23,
		from = 1
	},
	tower_sorcerer_idle = {
		prefix = "sorcerer_tower",
		to = 1,
		from = 1
	},
	tower_sorcerer_shoot = {
		prefix = "sorcerer_tower",
		to = 26,
		from = 1
	},
	tower_sorcerer_polymorph = {
		prefix = "sorcerer_tower",
		to = 26,
		from = 1
	},
	fx_tower_sorcerer_polymorph = {
		prefix = "fx_polymorph",
		to = 20,
		from = 1
	},
	tower_sorcerer_shooter_idleDown = {
		prefix = "sorcerer_shooter",
		to = 1,
		from = 1
	},
	tower_sorcerer_shooter_idleUp = {
		prefix = "sorcerer_shooter",
		to = 2,
		from = 2
	},
	tower_sorcerer_shooter_shootingDown = {
		prefix = "sorcerer_shooter",
		to = 22,
		from = 3
	},
	tower_sorcerer_shooter_shootingUp = {
		prefix = "sorcerer_shooter",
		to = 43,
		from = 23
	},
	tower_sorcerer_shooter_polymorphUp = {
		prefix = "sorcerer_shooter",
		to = 68,
		from = 44
	},
	tower_sorcerer_shooter_polymorphDown = {
		prefix = "sorcerer_shooter",
		to = 93,
		from = 69
	},
	bolt_sorcerer_idle = {
		prefix = "sorcererbolt_star",
		to = 8,
		from = 1
	},
	bolt_sorcerer_flying = {
		prefix = "sorcererbolt_star",
		to = 8,
		from = 1
	},
	bolt_sorcerer_hit = {
		prefix = "sorcererbolt",
		to = 16,
		from = 9
	},
	ray_sorcerer_polymorph = {
		prefix = "ray_polymorph",
		to = 10,
		from = 1
	},
	mod_sorcerer_curse_small = {
		prefix = "curse_small",
		to = 15,
		from = 1
	},
	mod_sorcerer_curse_medium = {
		prefix = "curse_big",
		to = 15,
		from = 1
	},
	mod_sorcerer_curse_large = {
		prefix = "curse_boss_type1",
		to = 15,
		from = 1
	},
	tower_bfg_idle = {
		prefix = "artillery_lvl4_bfg",
		to = 1,
		from = 1
	},
	tower_bfg_shoot = {
		prefix = "artillery_lvl4_bfg",
		to = 49,
		from = 1
	},
	tower_bfg_missile = {
		to = 77,
		from = 50,
		prefix = "artillery_lvl4_bfg",
		post = {
			1
		}
	},
	missile_bfg_flying = {
		prefix = "missile",
		to = 3,
		from = 1
	},
	tower_tesla_idle = {
		prefix = "artillery_lvl4_tesla",
		to = 1,
		from = 1
	},
	tower_tesla_shoot = {
		prefix = "artillery_lvl4_tesla",
		to = 65,
		from = 1
	},
	ray_tesla = {
		prefix = "ray_tesla",
		to = 13,
		from = 1
	},
	mod_tesla_hit_small = {
		prefix = "teslahit_small",
		to = 18,
		from = 1
	},
	mod_tesla_hit_medium = {
		prefix = "teslahit_big",
		to = 18,
		from = 1
	},
	mod_tesla_hit_large = {
		prefix = "teslahit_boss_type1",
		to = 18,
		from = 1
	},
	decal_tesla_overcharge = {
		prefix = "static_particle",
		to = 6,
		from = 1
	},
	tower_time_wizard_idle = {
		prefix = "time_wizard_tower",
		to = 9,
		from = 1
	},
	tower_time_wizard_shoot = {
		prefix = "time_wizard_tower",
		to = 63,
		from = 1
	},
	tower_time_wizard_sandstorm = {
		prefix = "time_wizard_tower",
		to = 89,
		from = 64
	},
	fx_tower_time_wizard_polymorph = {
		prefix = "fx_polymorph",
		to = 1,
		from = 1
	},
	tower_time_wizard_shooter_idleDown = {
		prefix = "time_wizard_shooter",
		to = 1,
		from = 1
	},
	tower_time_wizard_shooter_idleUp = {
		prefix = "time_wizard_shooter",
		to = 13,
		from = 13
	},
	tower_time_wizard_shooter_shootingDown = {
		prefix = "time_wizard_shooter",
		to = 12,
		from = 2
	},
	tower_time_wizard_shooter_shootingUp = {
		prefix = "time_wizard_shooter",
		to = 24,
		from = 14
	},
	tower_time_wizard_shooter_sandstormUp = {
		prefix = "time_wizard_shooter",
		to = 72,
		from = 49
	},
	tower_time_wizard_shooter_sandstormDown = {
		prefix = "time_wizard_shooter",
		to = 48,
		from = 25
	},
	bolt_time_wizard_idle = {
		prefix = "time_wizard_bolt",
		to = 8,
		from = 1
	},
	bolt_time_wizard_flying = {
		prefix = "time_wizard_bolt",
		to = 8,
		from = 1
	},
	bolt_time_wizard_hit = {
		prefix = "sorcererbolt",
		to = 16,
		from = 9
	},
	decal_sandstormtw = {
		prefix = "time_wizard_sandstorm",
		to = 24,
		from = 1
	},
		fx_time_wizard_word = {
		prefix = "time_wizard_word",
		to = 1,
		from = 1
	},
	soldier_ancient_guardian_idle = {
			prefix = "ancient_guardian",
			to = 1,
			from = 1
	},
	soldier_ancient_guardian_running = {
			prefix = "ancient_guardian",
			to = 20,
			from = 16
	},
	soldier_ancient_guardian_attack = {
			to = 30,
			from = 21,
			prefix = "ancient_guardian",
			post = {
				15
			}
	},
	soldier_ancient_guardian_raise = {
			prefix = "ancient_guardian",
			to = 14,
			from = 2
	},
	soldier_ancient_guardian_death = {
			prefix = "ancient_guardian",
			to = 63,
			from = 31
	},
	mod_ancient_aura = {
		prefix = "mod_ancient_guardian",
		to = 18,
		from = 1
	},
	fx_teleport_ancient_guardian_small = {
		prefix = "teleport_ancient_guardian",
		to = 14,
		from = 1
	},
	fx_teleport_ancient_guardian_big = {
		prefix = "teleport_ancient_guardian",
		to = 14,
		from = 1
	},
	tower_paladin_flag = {
		prefix = "paladinFlag",
		to = 9,
		from = 1
	},
	tower_sasquash_frozen = {
		prefix = "sasquash_frozen",
		to = 1,
		from = 1
	},
	tower_sasquash_unfreeze = {
		prefix = "sasquash_frozen",
		to = 42,
		from = 2
	},
	tower_sunray_layerX_disabled = {
		layer_to = 5,
		from = 1,
		layer_prefix = "sunrayTower_layer%i",
		to = 1,
		layer_from = 2
	},
	tower_sunray_layerX_charging = {
		layer_to = 5,
		from = 2,
		layer_prefix = "sunrayTower_layer%i",
		to = 21,
		layer_from = 2
	},
	tower_sunray_layerX_ready_start = {
		layer_to = 5,
		from = 22,
		layer_prefix = "sunrayTower_layer%i",
		to = 31,
		layer_from = 2
	},
	tower_sunray_layerX_ready_idle = {
		layer_to = 5,
		from = 32,
		layer_prefix = "sunrayTower_layer%i",
		to = 51,
		layer_from = 2
	},
	tower_sunray_layerX_shoot = {
		layer_to = 5,
		from = 52,
		layer_prefix = "sunrayTower_layer%i",
		to = 67,
		layer_from = 2
	},
	tower_sunray_shooter_up_idle = {
		prefix = "sorcerer_shooter",
		to = 2,
		from = 2
	},
	tower_sunray_shooter_up_charge = {
		prefix = "sorcerer_shooter",
		to = 93,
		from = 69
	},
	tower_sunray_shooter_down_idle = {
		prefix = "sorcerer_shooter",
		to = 1,
		from = 1
	},
	tower_sunray_shooter_down_charge = {
		prefix = "sorcerer_shooter",
		to = 68,
		from = 44
	},
	ray_sunray = {
		prefix = "sunray_Ray",
		to = 9,
		from = 1
	},
	fx_ray_sunray_hit = {
		prefix = "sunray_RayHit",
		to = 22,
		from = 1
	},
	hero_dracolich_idle = {
			prefix = "Halloween_hero_bones_layer1",
			to = 18,
			from = 1
		},
		hero_dracolich_death = {
			prefix = "Halloween_hero_bones_layer1",
			to = 97,
			from = 78
		},
		hero_dracolich_respawn = {
			prefix = "Halloween_hero_bones_layer1",
			to = 123,
			from = 98
		},
		hero_dracolich_levelup = {
			prefix = "Halloween_hero_bones_layer1",
			to = 1,
			from = 1
		},
		hero_dracolich_range_attack = {
			prefix = "Halloween_hero_bones_layer1",
			to = 77,
			from = 43
		},
		hero_dracolich_spinerain = {
			prefix = "Halloween_hero_bones_layer1",
			to = 42,
			from = 19
		},
		hero_dracolich_nova = {
			prefix = "Halloween_hero_bones_layer1",
			to = 149,
			from = 124
		},
		hero_dracolich_golem = {
			prefix = "Halloween_hero_bones_layer1",
			to = 42,
			from = 19
		},
		hero_dracolich_plague = {
			prefix = "Halloween_hero_bones_layer1",
			to = 77,
			from = 43
		},
		fx_dracolich_skeleton_glow = {
			prefix = "Halloween_hero_bones_layer2",
			to = 42,
			from = 19
		},
		fx_dracolich_explosion = {
			prefix = "Halloween_hero_bones_explosion",
			to = 14,
			from = 1
		},
		fx_dracolich_fireball_explosion_ground = {
			prefix = "Halloween_hero_bones_proyExplosion",
			to = 14,
			from = 1
		},
		fx_dracolich_fireball_explosion_air = {
			prefix = "Halloween_hero_bones_proyExplotionAir",
			to = 18,
			from = 1
		},
		dracolich_fireball_particle_1 = {
			prefix = "Halloween_hero_bones_proyParticle",
			to = 8,
			from = 1
		},
		dracolich_fireball_particle_2 = {
			prefix = "Halloween_hero_bones_proyParticle",
			to = 16,
			from = 9
		},
		dracolich_disease_big = {
			prefix = "Halloween_hero_bones_disease_big",
			to = 26,
			from = 1
		},
		dracolich_disease_small = {
			prefix = "Halloween_hero_bones_disease_small",
			to = 26,
			from = 1
		},
		dracolich_disease_explosion = {
			prefix = "Halloween_hero_bones_disease_explotion",
			to = 15,
			from = 1
		},
		dracolich_spine1_start = {
			prefix = "Halloween_hero_bones_attack",
			to = 30,
			from = 1
		},
		dracolich_spine1_end = {
			prefix = "Halloween_hero_bones_attack",
			to = 48,
			from = 31
		},
		dracolich_spine2_start = {
			prefix = "Halloween_hero_bones_attack",
			to = 78,
			from = 49
		},
		dracolich_spine2_end = {
			prefix = "Halloween_hero_bones_attack",
			to = 95,
			from = 79
		},
		dracolich_spine3_start = {
			prefix = "Halloween_hero_bones_attack",
			to = 126,
			from = 96
		},
		dracolich_spine3_end = {
			prefix = "Halloween_hero_bones_attack",
			to = 144,
			from = 127
		},
		dracolich_plague_carrier = {
			prefix = "Halloween_hero_bones_soul",
			to = 6,
			from = 1
		},
		soldier_dracolich_golem_raise = {
			prefix = "Halloween_hero_bones_golem",
			to = 49,
			from = 26
		},
		soldier_dracolich_golem_idle = {
			prefix = "Halloween_hero_bones_golem",
			to = 1,
			from = 1
		},
		soldier_dracolich_golem_running = {
			prefix = "Halloween_hero_bones_golem",
			to = 11,
			from = 2
		},
		soldier_dracolich_golem_attack = {
			prefix = "Halloween_hero_bones_golem",
			to = 25,
			from = 12
		},
		soldier_dracolich_golem_death = {
			prefix = "Halloween_hero_bones_golem",
			to = 72,
			from = 50
		},
	hero_alric_idle = {
			prefix = "hero_hammerhold",
			to = 1,
			from = 1
		},
		hero_alric_running = {
			prefix = "hero_hammerhold",
			to = 6,
			from = 2
		},
		hero_alric_attack = {
			prefix = "hero_hammerhold",
			to = 23,
			from = 7
		},
		hero_alric_attack2 = {
			prefix = "hero_hammerhold",
			to = 39,
			from = 24
		},
		hero_alric_death = {
			prefix = "hero_hammerhold",
			to = 111,
			from = 105
		},
		hero_alric_respawn = {
			prefix = "hero_hammerhold",
			to = 136,
			from = 118
		},
		hero_alric_levelup = {
			prefix = "hero_hammerhold",
			to = 136,
			from = 118
		},
		hero_alric_sandwarrior = {
			prefix = "hero_hammerhold",
			to = 104,
			from = 71
		},
		hero_alric_flurry_start = {
			prefix = "hero_hammerhold",
			to = 49,
			from = 40
		},
		hero_alric_flurry_loop = {
			prefix = "hero_hammerhold",
			to = 62,
			from = 50
		},
		hero_alric_flurry_end = {
			prefix = "hero_hammerhold",
			to = 70,
			from = 63
		},
		soldier_sand_warrior_raise = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 22,
			from = 1
		},
		soldier_sand_warrior_idle = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 22,
			from = 22
		},
		soldier_sand_warrior_start_walk = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 28,
			from = 23
		},
		soldier_sand_warrior_walk = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 36,
			from = 29
		},
		soldier_sand_warrior_stop_walk = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 45,
			from = 37
		},
		soldier_sand_warrior_attack = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 63,
			from = 46
		},
		soldier_sand_warrior_death = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 74,
			from = 64
		},
		soldier_sand_warrior_death_travel = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 82,
			from = 75
		},
		soldier_sand_warrior2_raise = {
			prefix = "CB_Zombie",
			to = 148,
			from = 115
		},
		soldier_sand_warrior2_idle = {
			prefix = "CB_Zombie",
			to = 72,
			from = 72
		},
		soldier_sand_warrior2_start_walk = {
			prefix = "CB_Zombie",
			to = 72,
			from = 72
		},
		soldier_sand_warrior2_walk = {
			prefix = "CB_Zombie",
			to = 23,
			from = 1
		},
		soldier_sand_warrior2_stop_walk = {
			prefix = "CB_Zombie",
			to = 72,
			from = 72
		},
		soldier_sand_warrior2_attack = {
			prefix = "CB_Zombie",
			to = 93,
			from = 73
		},
		soldier_sand_warrior2_death = {
			prefix = "CB_Zombie",
			to = 115,
			from = 148
		},
		soldier_sand_warrior2_death_travel = {
			prefix = "CB_Zombie",
			to = 115,
			from = 148
		},
		hero_crab_idle = {
			prefix = "Blacksurge",
			to = 147,
			from = 147
		},
		hero_crab_running = {
			prefix = "Blacksurge",
			to = 30,
			from = 1
		},
		hero_crab_attack = {
			prefix = "Blacksurge",
			to = 176,
			from = 148
		},
		hero_crab_respawn = {
			prefix = "Blacksurge",
			to = 245,
			from = 230
		},
		hero_crab_levelup = {
			prefix = "Blacksurge",
			to = 176,
			from = 148
		},
		hero_crab_death = {
			prefix = "Blacksurge",
			to = 262,
			from = 239
		},
		hero_crab_burrow_in = {
			prefix = "Blacksurge",
			to = 292,
			from = 263
		},
		hero_crab_burrow_out = {
			prefix = "Blacksurge",
			to = 292,
			from = 263
		},
		hero_crab_burrow_side_water = {
			prefix = "hero_crabman",
			to = 260,
			from = 246
		},
		hero_crab_burrow_up_water = {
			prefix = "hero_crabman",
			to = 274,
			from = 261
		},
		hero_crab_burrow_down_water = {
			prefix = "hero_crabman",
			to = 288,
			from = 275
		},
		hero_crab_burrow_side = {
			prefix = "Blacksurge",
			to = 292,
			from = 263
		},
		hero_crab_burrow_up = {
			prefix = "Blacksurge",
			to = 292,
			from = 263
		},
		hero_crab_burrow_down = {
			prefix = "Blacksurge",
			to = 292,
			from = 263
		},
		hero_crab_pincer = {
			prefix = "hero_crabman",
			to = 68,
			from = 42
		},
		hero_crab_cannon = {
			prefix = "hero_crabman",
			to = 118,
			from = 69
		},
		hero_crab_invuln = {
			prefix = "Blacksurge",
			to = 122,
			from = 111
		},
	hero_gerald_attack = {
		to = 17,
		from = 7,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_attack2 = {
		to = 28,
		from = 18,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_counter = {
		to = 76,
		from = 56,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_courage = {
		to = 132,
		from = 80,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_death = {
		prefix = "hero_barracks",
		to = 140,
		from = 133
	},
	hero_gerald_idle = {
		prefix = "hero_barracks",
		to = 1,
		from = 1
	},
	hero_gerald_levelup = {
		to = 55,
		from = 32,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_respawn = {
		to = 55,
		from = 37,
		prefix = "hero_barracks",
		post = {
			1
		}
	},
	hero_gerald_running = {
		prefix = "hero_barracks",
		to = 6,
		from = 2
	},
	hero_alleria_attack = {
		prefix = "hero_archer",
		to = 34,
		from = 19
	},
	hero_alleria_callofwild = {
		prefix = "hero_archer",
		to = 118,
		from = 80
	},
	hero_alleria_death = {
		prefix = "hero_archer",
		to = 125,
		from = 119
	},
	hero_alleria_idle = {
		prefix = "hero_archer",
		to = 1,
		from = 1
	},
	hero_alleria_levelup = {
		prefix = "hero_archer",
		to = 53,
		from = 36
	},
	hero_alleria_multishot = {
		prefix = "hero_archer",
		to = 79,
		from = 54
	},
	hero_alleria_respawn = {
		prefix = "hero_archer",
		to = 53,
		from = 36
	},
	hero_alleria_running = {
		prefix = "hero_archer",
		to = 6,
		from = 2
	},
	hero_alleria_shoot = {
		prefix = "hero_archer",
		to = 18,
		from = 7
	},
	soldier_alleria_attack = {
		prefix = "hero_archer_wildcat",
		to = 27,
		from = 14
	},
	soldier_alleria_death = {
		prefix = "hero_archer_wildcat",
		to = 64,
		from = 47
	},
	soldier_alleria_idle = {
		prefix = "hero_archer_wildcat",
		to = 1,
		from = 1
	},
	soldier_alleria_running = {
		prefix = "hero_archer_wildcat",
		to = 11,
		from = 2
	},
	hero_alleria2_idle = {
		prefix = "tower_archer_lvl3_shooter",
		to = 1,
		from = 1
	},
	hero_alleria2_walk = {
		prefix = "tower_archer_lvl3_shooter",
		to = 6,
		from = 2
	},
	hero_alleria2_shoot = {
		prefix = "tower_archer_lvl3_shooter",
		to = 10,
		from = 3
	},
	hero_alleria2_shoot2 = {
		prefix = "tower_archer_lvl3_shooter",
		to = 18,
		from = 11
	},
	hero_alleria2_attack = {
		prefix = "tower_archer_lvl3_shooter",
		to = 51,
		from = 25
	},
	hero_alleria2_shootSpecial = {
		prefix = "tower_archer_lvl3_shooter",
		to = 10,
		from = 3
	},
	hero_alleria2_death = {
		prefix = "tower_archer_lvl3_shooter",
		to = 88,
		from = 75
	},
	hero_alleria2_respawn = {
		prefix = "tower_archer_lvl3_shooter",
		to = 112,
		from = 89
	},
	hero_alleria3_idle = {
		prefix = "Bluegale",
		to = 100,
		from = 100
	},
	hero_alleria3_walk = {
		prefix = "Bluegale",
		to = 20,
		from = 1
	},
	hero_alleria3_shoot = {
		prefix = "Bluegale",
		to = 177,
		from = 132
	},
	hero_alleria3_shoot2 = {
		prefix = "Bluegale",
		to = 18,
		from = 11
	},
	hero_alleria3_attack = {
		prefix = "Bluegale",
		to = 131,
		from = 101
	},
	hero_alleria3_shootSpecial = {
		prefix = "Bluegale",
		to = 10,
		from = 3
	},
	hero_alleria3_death = {
		prefix = "Bluegale",
		to = 242,
		from = 218
	},
	hero_alleria3_respawn = {
		prefix = "Bluegale",
		to = 112,
		from = 89
	},
	alleria_wildcat_idle = {
		prefix = "hero_alleria_wildcat",
		to = 1,
		from = 1
	},
	alleria_wildcat_walk = {
		prefix = "hero_alleria_wildcat",
		to = 11,
		from = 2
	},
	alleria_wildcat_attack = {
		prefix = "hero_alleria_wildcat",
		to = 57,
		from = 12
	},
	alleria_wildcat_scared = {
		prefix = "hero_alleria_wildcat",
		to = 61,
		from = 58
	},
	alleria_wildcat_toSad = {
		prefix = "hero_alleria_wildcat",
		to = 73,
		from = 62
	},
	alleria_wildcat_sadIdle = {
		prefix = "hero_alleria_wildcat",
		to = 74,
		from = 74
	},
	alleria_wildcat_sadSigh = {
		prefix = "hero_alleria_wildcat",
		to = 90,
		from = 75
	},
	alleria_wildcat_toStand = {
		prefix = "hero_alleria_wildcat",
		to = 102,
		from = 91
	},
	soldier_alleria_spawn = {
		prefix = "hero_archer_wildcat",
		to = 46,
		from = 28
	},
	hero_malik_attack = {
		prefix = "hero_reinforce",
		to = 25,
		from = 8
	},
	hero_malik_attack2 = {
		prefix = "hero_reinforce",
		to = 42,
		from = 26
	},
	hero_malik_death = {
		prefix = "hero_reinforce",
		to = 139,
		from = 131
	},
	hero_malik_idle = {
		prefix = "hero_reinforce",
		to = 1,
		from = 1
	},
	hero_malik_levelup = {
		prefix = "hero_reinforce",
		to = 130,
		from = 108
	},
	hero_malik_respawn = {
		prefix = "hero_reinforce",
		to = 130,
		from = 112
	},
	hero_malik_running = {
		prefix = "hero_reinforce",
		to = 6,
		from = 2
	},
	hero_malik_smash = {
		prefix = "hero_reinforce",
		to = 106,
		from = 80
	},
	hero_malik_fissure = {
		prefix = "hero_reinforce",
		to = 79,
		from = 43
	},
	decal_malik_ring = {
		prefix = "hero_reinforce_ring",
		to = 11,
		from = 1
	},
	decal_malik_earthquake = {
		prefix = "hero_reinforce_rocks",
		to = 17,
		from = 1
	},
	hero_hacksaw_attack = {
		prefix = "Inferno_hero_Lumberjack",
		to = 52,
		from = 22
	},
	hero_hacksaw_death = {
		prefix = "Inferno_hero_Lumberjack",
		to = 157,
		from = 137
	},
	hero_hacksaw_idle = {
		prefix = "Inferno_hero_Lumberjack",
		to = 1,
		from = 1
	},
	hero_hacksaw_levelUp = {
		prefix = "Inferno_hero_Lumberjack",
		to = 136,
		from = 120
	},
	hero_hacksaw_respawn = {
		prefix = "Inferno_hero_Lumberjack",
		to = 136,
		from = 120
	},
	hero_hacksaw_running = {
		prefix = "Inferno_hero_Lumberjack",
		to = 21,
		from = 2
	},
	hero_hacksaw_sawblade = {
		prefix = "Inferno_hero_Lumberjack",
		to = 84,
		from = 53
	},
	hero_hacksaw_timber = {
		prefix = "Inferno_hero_Lumberjack",
		to = 119,
		from = 85
	},
	hacksaw_sawblade_idle = {
		prefix = "Inferno_hero_Lumberjack_proy",
		to = 1,
		from = 1
	},
	hacksaw_sawblade_flying = {
		prefix = "Inferno_hero_Lumberjack_proy",
		to = 4,
		from = 1
	},
	fx_hacksaw_sawblade_hit = {
		prefix = "Inferno_hero_Lumberjack_proyHit",
		to = 7,
		from = 1
	},
	ps_hacksaw_sawblade = {
		prefix = "Inferno_hero_Lumberjack_proyParticle",
		to = 12,
		from = 1
	},
	hero_thor_attack = {
		prefix = "thor",
		to = 68,
		from = 43
	},
	hero_thor_death = {
		prefix = "thor",
		to = 42,
		from = 8
	},
	hero_thor_idle = {
		prefix = "thor",
		to = 8,
		from = 8
	},
	hero_thor_levelUp = {
		prefix = "thor",
		to = 147,
		from = 131
	},
	hero_thor_respawn = {
		prefix = "thor",
		to = 147,
		from = 131
	},
	hero_thor_running = {
		prefix = "thor",
		to = 7,
		from = 1
	},
	hero_thor_chain = {
		prefix = "thor",
		to = 102,
		from = 69
	},
	hero_thor_thunderclap = {
		prefix = "thor",
		to = 130,
		from = 103
	},
	ray_hero_thor = {
		prefix = "HalloweenTesla_ray",
		to = 13,
		from = 1
	},
	hammer_hero_thor_idle = {
		prefix = "thor_hammer",
		to = 1,
		from = 1
	},
	hammer_hero_thor_flying = {
		prefix = "thor_hammer",
		to = 1,
		from = 1
	},
	mod_hero_thor_thunderclap = {
		prefix = "thor_lightening_layer2",
		to = 24,
		from = 1
	},
	mod_hero_thor_thunderclap_explosion = {
		prefix = "thor_lightening_layer1",
		to = 24,
		from = 1
	},
	fx_hero_thor_thunderclap_disipate = {
		prefix = "thor_lightening_layer0",
		to = 24,
		from = 1
	},
	hero_oni_attack = {
		prefix = "hero_oni",
		to = 45,
		from = 17
	},
	hero_oni_death = {
		prefix = "hero_oni",
		to = 236,
		from = 179
	},
	hero_oni_idle = {
		prefix = "hero_oni",
		to = 10,
		from = 1
	},
	hero_oni_levelUp = {
		prefix = "hero_oni",
		to = 178,
		from = 161
	},
	hero_oni_respawn = {
		prefix = "hero_oni",
		to = 178,
		from = 161
	},
	hero_oni_running = {
		prefix = "hero_oni",
		to = 16,
		from = 11
	},
	hero_oni_deathStrike = {
		prefix = "hero_oni",
		to = 160,
		from = 113
	},
	hero_oni_torment = {
		prefix = "hero_oni",
		to = 112,
		from = 45
	},
	decal_oni_torment_sword_1_in = {
		prefix = "hero_oni_sword1",
		to = 44,
		from = 1
	},
	decal_oni_torment_sword_1_out = {
		prefix = "hero_oni_sword1",
		to = 52,
		from = 46
	},
	decal_oni_torment_sword_2_in = {
		prefix = "hero_oni_sword2",
		to = 44,
		from = 1
	},
	decal_oni_torment_sword_2_out = {
		prefix = "hero_oni_sword2",
		to = 52,
		from = 46
	},
	decal_oni_torment_sword_3_in = {
		prefix = "hero_oni_sword3",
		to = 44,
		from = 1
	},
	decal_oni_torment_sword_3_out = {
		prefix = "hero_oni_sword3",
		to = 52,
		from = 46
	},
	hero_elora_attack = {
		prefix = "hero_frost",
		to = 30,
		from = 8
	},
	hero_elora_death = {
		prefix = "hero_frost",
		to = 133,
		from = 125
	},
	hero_elora_idle = {
		prefix = "hero_frost",
		to = 1,
		from = 1
	},
	hero_elora_levelUp = {
		prefix = "hero_frost",
		to = 152,
		from = 134
	},
	hero_elora_respawn = {
		prefix = "hero_frost",
		to = 152,
		from = 134
	},
	hero_elora_running = {
		prefix = "hero_frost",
		to = 7,
		from = 2
	},
	hero_elora_shoot = {
		prefix = "hero_frost",
		to = 57,
		from = 31
	},
	hero_elora_chill = {
		prefix = "hero_frost",
		to = 85,
		from = 58
	},
	hero_elora_iceStorm = {
		prefix = "hero_frost",
		to = 124,
		from = 86
	},
	ps_hero_elora_run = {
		prefix = "hero_frost_runParticle",
		to = 13,
		from = 1
	},
	hero_elora_frostEffect = {
		prefix = "hero_frost_idleEffect",
		to = 38,
		from = 1
	},
	bolt_elora_idle = {
		prefix = "hero_frost_bolt",
		to = 1,
		from = 1
	},
	bolt_elora_flying = {
		prefix = "hero_frost_bolt",
		to = 4,
		from = 1
	},
	fx_bolt_elora_hit = {
		prefix = "hero_frost_bolt",
		to = 12,
		from = 5
	},
	elora_ice_spike_1_start = {
		prefix = "hero_frost_spikes_1",
		to = 53,
		from = 1
	},
	elora_ice_spike_2_start = {
		prefix = "hero_frost_spikes_2",
		to = 53,
		from = 1
	},
	decal_elora_chill_1_start = {
		prefix = "hero_frost_groundFreeze_1",
		to = 11,
		from = 1
	},
	decal_elora_chill_2_start = {
		prefix = "hero_frost_groundFreeze_2",
		to = 11,
		from = 1
	},
	decal_elora_chill_3_start = {
		prefix = "hero_frost_groundFreeze_3",
		to = 11,
		from = 1
	},
	hero_bolin_attack = {
		prefix = "hero_artillery",
		to = 206,
		from = 191
	},
	hero_bolin_death = {
		prefix = "hero_artillery",
		to = 214,
		from = 207
	},
	hero_bolin_idle = {
		prefix = "hero_artillery",
		to = 1,
		from = 1
	},
	hero_bolin_levelUp = {
		prefix = "hero_artillery",
		to = 125,
		from = 109
	},
	hero_bolin_respawn = {
		prefix = "hero_artillery",
		to = 125,
		from = 109
	},
	hero_bolin_running = {
		prefix = "hero_artillery",
		to = 6,
		from = 2
	},
	hero_bolin_tar = {
		prefix = "hero_artillery",
		to = 171,
		from = 148
	},
	decal_bolin_tar_start = {
		prefix = "hero_artillery_brea_decal",
		to = 11,
		from = 1
	},
	decal_bolin_tar_end = {
		prefix = "hero_artillery_brea_decal",
		to = 17,
		from = 13
	},
	hero_bolin_mine = {
		prefix = "hero_artillery",
		to = 188,
		from = 173
	},
	decal_bolin_mine = {
		prefix = "hero_artillery_mine",
		to = 30,
		from = 1
	},
	hero_bolin_shootAimRightLeft = {
		prefix = "hero_artillery",
		to = 16,
		from = 7
	},
	hero_bolin_shootRightLeft = {
		prefix = "hero_artillery",
		to = 30,
		from = 20,
		pre = {
			13,
			13,
			13
		}
	},
	hero_bolin_shootAimDown = {
		prefix = "hero_artillery",
		to = 66,
		from = 58,
		pre = {
			1
		}
	},
	hero_bolin_shootDown = {
		prefix = "hero_artillery",
		to = 79,
		from = 67
	},
	hero_bolin_shootAimUp = {
		prefix = "hero_artillery",
		to = 41,
		from = 32,
		pre = {
			1
		}
	},
	hero_bolin_shootUp = {
		prefix = "hero_artillery",
		to = 56,
		from = 42
	},
	hero_bolin_reload = {
		prefix = "hero_artillery",
		to = 102,
		from = 82
	},
	hero_magnus_attack = {
		prefix = "hero_mage",
		to = 39,
		from = 18
	},
	hero_magnus_death = {
		prefix = "hero_mage",
		to = 169,
		from = 162
	},
	hero_magnus_idle = {
		prefix = "hero_mage",
		to = 1,
		from = 1
	},
	hero_magnus_levelUp = {
		prefix = "hero_mage",
		to = 68,
		from = 40
	},
	hero_magnus_respawn = {
		prefix = "hero_mage",
		to = 67,
		from = 51
	},
	hero_magnus_shoot = {
		prefix = "hero_mage",
		to = 93,
		from = 69
	},
	hero_magnus_running = {
		prefix = "hero_mage",
		to = 17,
		from = 2
	},
	hero_magnus_mirage = {
		prefix = "hero_mage",
		from = 143,
		to = 153,
		pre = {
			40
		},
		post = {
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			153,
			151,
			151,
			149,
			147,
			147,
			159,
			159,
			143
		}
	},
	hero_magnus_arcaneRain = {
		prefix = "hero_mage",
		to = 141,
		from = 103
	},
	hero_magnus_teleport_out = {
		prefix = "hero_mage",
		to = 179,
		from = 170,
		pre = {
			40,
			40,
			97,
			97,
			99,
			99,
			101,
			101
		}
	},
	hero_magnus_teleport_in = {
		prefix = "hero_mage",
		to = 179,
		from = 170
	},
	bolt_magnus_idle = {
		prefix = "hero_mage_bolt",
		to = 2,
		from = 1
	},
	bolt_magnus_flying = {
		prefix = "hero_mage_bolt",
		to = 2,
		from = 1
	},
	bolt_magnus_hit = {
		prefix = "hero_mage_bolt",
		to = 10,
		from = 3
	},
	magnus_arcane_rain_idle = {
		prefix = "hero_mage_rain",
		to = 1,
		from = 1
	},
	magnus_arcane_rain_drop = {
		prefix = "hero_mage_rain",
		to = 17,
		from = 1
	},
	soldier_magnus_illusion_attack = {
		prefix = "hero_mage",
		to = 39,
		from = 18
	},
	soldier_magnus_illusion_death = {
		prefix = "states_small",
		to = 72,
		from = 59
	},
	soldier_magnus_illusion_idle = {
		prefix = "hero_mage",
		to = 1,
		from = 1
	},
	soldier_magnus_illusion_running = {
		prefix = "hero_mage",
		to = 17,
		from = 2
	},
	soldier_magnus_illusion_shoot = {
		prefix = "hero_mage",
		to = 93,
		from = 69
	},
	soldier_magnus_illusion_raise = {
		to = 152,
		from = 151,
		prefix = "hero_mage",
		post = {
			149,
			147,
			147,
			159,
			159,
			143
		}
	},
	hero_denas_attack = {
		prefix = "hero_king",
		to = 25,
		from = 7
	},
	hero_denas_attackBarrell = {
		prefix = "hero_king",
		from = 189,
		to = 194,
		pre = {
			7,
			7
		},
		post = {
			15,
			15,
			17,
			17,
			19,
			19,
			21,
			21,
			21,
			24,
			7
		}
	},
	hero_denas_attackChicken = {
		prefix = "hero_king",
		from = 183,
		to = 188,
		pre = {
			7,
			7
		},
		post = {
			15,
			15,
			17,
			17,
			19,
			19,
			21,
			21,
			21,
			24,
			7
		}
	},
	hero_denas_attackBottle = {
		prefix = "hero_king",
		from = 195,
		to = 200,
		pre = {
			7,
			7
		},
		post = {
			15,
			15,
			17,
			17,
			19,
			19,
			21,
			21,
			21,
			24,
			7
		}
	},
	hero_denas_buffTowers = {
		prefix = "hero_king",
		frames = {
			24,
			7,
			7,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			27,
			27,
			28,
			28,
			28,
			27,
			7
		}
	},
	hero_denas_catapult = {
		prefix = "hero_king",
		to = 118,
		from = 80
	},
	hero_denas_death = {
		prefix = "hero_king",
		to = 155,
		from = 143
	},
	hero_denas_idle = {
		prefix = "hero_king",
		to = 1,
		from = 1
	},
	hero_denas_levelUp = {
		prefix = "hero_king",
		to = 182,
		from = 156
	},
	hero_denas_respawn = {
		prefix = "hero_king",
		to = 182,
		from = 162
	},
	hero_denas_shoot = {
		prefix = "hero_king",
		to = 25,
		from = 7
	},
	hero_denas_running = {
		prefix = "hero_king",
		to = 6,
		from = 2
	},
	hero_denas_cursing = {
		prefix = "hero_king_cursing",
		to = 7,
		from = 1
	},
	mod_denas_tower = {
		prefix = "hero_king_towerBuff",
		to = 18,
		from = 1
	},
	hero_ignus_attack = {
		prefix = "hero_elemental",
		to = 32,
		from = 14
	},
	hero_ignus_death = {
		prefix = "hero_elemental",
		to = 110,
		from = 95
	},
	hero_ignus_idle = {
		prefix = "hero_elemental",
		to = 1,
		from = 1
	},
	hero_ignus_levelUp = {
		prefix = "hero_elemental",
		to = 56,
		from = 33
	},
	hero_ignus_respawn = {
		prefix = "hero_elemental",
		to = 80,
		from = 67
	},
	hero_ignus_running = {
		prefix = "hero_elemental",
		to = 13,
		from = 2
	},
	hero_ignus_flamingFrenzy = {
		prefix = "hero_elemental",
		to = 56,
		from = 41
	},
	hero_ignus_surgeOfFlame = {
		prefix = "hero_elemental",
		to = 85,
		from = 81
	},
	hero_ignus_surgeOfFlame_end = {
		prefix = "hero_elemental",
		to = 94,
		from = 86
	},
	ps_hero_ignus_run = {
		prefix = "hero_elemental_particle",
		to = 14,
		from = 1
	},
	ps_hero_ignus_idle = {
		prefix = "hero_elemental_particle_idle",
		to = 13,
		from = 1
	},
	fx_burn_small = {
		prefix = "burn_small",
		to = 15,
		from = 1
	},
	fx_burn_big = {
		prefix = "burn_big",
		to = 15,
		from = 1
	},
	decal_ignus_flaming = {
		prefix = "hero_elemental_blast",
		to = 12,
		from = 1
	},
	ps_hero_ignus_smoke = {
		to = 2,
		from = 1,
		prefix = "fireball_particle",
		post = {
			2,
			2,
			3,
			4
		}
	},
	hero_ingvar_ancestors = {
		prefix = "hero_viking",
		to = 216,
		from = 175
	},
	hero_ingvar_attack = {
		prefix = "hero_viking",
		to = 38,
		from = 8
	},
	hero_ingvar_attack2 = {
		prefix = "hero_viking",
		to = 76,
		from = 39
	},
	hero_ingvar_death = {
		prefix = "hero_viking",
		to = 247,
		from = 240
	},
	hero_ingvar_idle = {
		prefix = "hero_viking",
		to = 1,
		from = 1
	},
	hero_ingvar_levelup = {
		prefix = "hero_viking",
		to = 239,
		from = 217
	},
	hero_ingvar_respawn = {
		prefix = "hero_viking",
		to = 239,
		from = 221
	},
	hero_ingvar_running = {
		prefix = "hero_viking",
		to = 7,
		from = 2
	},
	hero_ingvar_toBear = {
		prefix = "hero_viking",
		to = 96,
		from = 77
	},
	hero_ingvar_bear_attack = {
		to = 168,
		from = 112,
		prefix = "hero_viking",
		post = {
			97
		}
	},
	hero_ingvar_bear_idle = {
		prefix = "hero_viking",
		to = 97,
		from = 97
	},
	hero_ingvar_bear_running = {
		prefix = "hero_viking",
		to = 174,
		from = 169
	},
	hero_ingvar_bear_toViking = {
		prefix = "hero_viking",
		to = 111,
		from = 98
	},
	hero_ingvar2_ancestors = {
		prefix = "BloodShell",
		to = 79,
		from = 52
	},
	hero_ingvar2_attack = {
		prefix = "BloodShell",
		to = 79,
		from = 52
	},
	hero_ingvar2_attack2 = {
		prefix = "BloodShell",
		to = 79,
		from = 52
	},
	hero_ingvar2_death = {
		prefix = "BloodShell",
		to = 97,
		from = 80
	},
	hero_ingvar2_idle = {
		prefix = "BloodShell",
		to = 51,
		from = 51
	},
	hero_ingvar2_levelup = {
		prefix = "BloodShell",
		to = 88,
		from = 72
	},
	hero_ingvar2_respawn = {
		prefix = "BloodShell",
		to = 79,
		from = 52
	},
	hero_ingvar2_running = {
		prefix = "BloodShell",
		to = 6,
		from = 2
	},
	hero_ingvar2_toBear = {
		prefix = "hero_viking",
		to = 96,
		from = 77
	},
	hero_ingvar2_bear_attack = {
		to = 168,
		from = 112,
		prefix = "hero_viking",
		post = {
			97
		}
	},
	hero_ingvar2_bear_idle = {
		prefix = "hero_viking",
		to = 97,
		from = 97
	},
	hero_ingvar2_bear_running = {
		prefix = "hero_viking",
		to = 174,
		from = 169
	},
	hero_ingvar2_bear_toViking = {
		prefix = "hero_viking",
		to = 111,
		from = 98
	},
	hero_ingvar3_ancestors = {
		prefix = "boss_sarelgaz",
		to = 94,
		from = 68
	},
	hero_ingvar3_attack = {
		prefix = "boss_sarelgaz",
		to = 66,
		from = 41
	},
	hero_ingvar3_attack2 = {
		prefix = "boss_sarelgaz",
		to = 66,
		from = 41
	},
	hero_ingvar3_death = {
		prefix = "boss_sarelgaz",
		to = 94,
		from = 68
	},
	hero_ingvar3_idle = {
		prefix = "boss_sarelgaz",
		to = 67,
		from = 67
	},
	hero_ingvar3_levelup = {
		prefix = "boss_sarelgaz",
		to = 88,
		from = 72
	},
	hero_ingvar3_respawn = {
		prefix = "boss_sarelgaz",
		to = 79,
		from = 52
	},
	hero_ingvar3_running = {
		prefix = "boss_sarelgaz",
		to = 20,
		from = 1
	},
	hero_ingvar3_toBear = {
		prefix = "hero_viking",
		to = 96,
		from = 77
	},
	hero_ingvar3_bear_attack = {
		to = 168,
		from = 112,
		prefix = "hero_viking",
		post = {
			97
		}
	},
	hero_ingvar3_bear_idle = {
		prefix = "hero_viking",
		to = 97,
		from = 97
	},
	hero_ingvar3_bear_running = {
		prefix = "hero_viking",
		to = 174,
		from = 169
	},
	hero_ingvar3_bear_toViking = {
		prefix = "hero_viking",
		to = 111,
		from = 98
	},
	soldier_ingvar_ancestor_attack = {
		prefix = "hero_viking_ancestor",
		to = 33,
		from = 8
	},
	soldier_ingvar_ancestor_death = {
		prefix = "hero_viking_ancestor",
		to = 85,
		from = 69
	},
	soldier_ingvar_ancestor_idle = {
		prefix = "hero_viking_ancestor",
		to = 1,
		from = 1
	},
	soldier_ingvar_ancestor_raise = {
		prefix = "hero_viking_ancestor",
		to = 68,
		from = 34
	},
	soldier_ingvar_ancestor_running = {
		prefix = "hero_viking_ancestor",
		to = 7,
		from = 2
	},
	soldier_ingvar_ancestor2_attack = {
		prefix = "BloodShell",
		to = 79,
		from = 52
	},
	soldier_ingvar_ancestor2_death = {
		prefix = "BloodShell",
		to = 97,
		from = 80
	},
	soldier_ingvar_ancestor2_idle = {
		prefix = "BloodShell",
		to = 51,
		from = 51
	},
	soldier_ingvar_ancestor2_raise = {
		prefix = "BloodShell",
		to = 68,
		from = 34
	},
	soldier_ingvar_ancestor2_running = {
		prefix = "BloodShell",
		to = 6,
		from = 2
	},
	soldier_ingvar_ancestor3_attack = {
		prefix = "spider_medium",
		to = 46,
		from = 28
	},
	soldier_ingvar_ancestor3_death = {
		prefix = "spider_medium",
		to = 84,
		from = 70
	},
	soldier_ingvar_ancestor3_idle = {
		prefix = "spider_medium",
		to = 28,
		from = 28
	},
	soldier_ingvar_ancestor3_raise = {
		prefix = "spider_medium",
		to = 27,
		from = 19
	},
	soldier_ingvar_ancestor3_running = {
		prefix = "spider_medium",
		to = 9,
		from = 1
	},
	ps_hero_10yr_particle_fire = {
		prefix = "10yr_particle_fire",
		to = 13,
		from = 1
	},
	decal_10yr_bomb_spike = {
		prefix = "10yr_bomb_rocks",
		to = 17,
		from = 1
	},
	hero_10yr_respawn = {
		prefix = "hero_10yr_levelup",
		to = 14,
		from = 1
	},
	hero_10yr_idle = {
		prefix = "hero_10yr_idle",
		to = 1,
		from = 1
	},
	hero_10yr_running = {
		prefix = "hero_10yr_running",
		to = 14,
		from = 1
	},
	hero_10yr_death = {
		prefix = "hero_10yr_death",
		to = 58,
		from = 1
	},
	hero_10yr_levelup = {
		prefix = "hero_10yr_levelup",
		to = 14,
		from = 1
	},
	hero_10yr_teleport_out = {
		prefix = "hero_10yr_teleport_out",
		to = 14,
		from = 1
	},
	hero_10yr_teleport_in = {
		prefix = "hero_10yr_teleport_in",
		to = 14,
		from = 1
	},
	hero_10yr_attack = {
		prefix = "hero_10yr_attack",
		to = 39,
		from = 1
	},
	hero_10yr_attack2 = {
		prefix = "hero_10yr_attack2",
		to = 37,
		from = 1
	},
	hero_10yr_power_rain_start = {
		prefix = "hero_10yr_power_rain_start",
		to = 17,
		from = 1
	},
	hero_10yr_power_rain_loop = {
		prefix = "hero_10yr_power_rain_loop",
		to = 10,
		from = 1
	},
	hero_10yr_power_rain_end = {
		prefix = "hero_10yr_power_rain_end",
		to = 21,
		from = 1
	},
	hero_10yr_buffed_idle = {
		prefix = "hero_10yr_buffed_idle",
		to = 1,
		from = 1
	},
	hero_10yr_buffed_running = {
		prefix = "hero_10yr_buffed_running",
		to = 24,
		from = 1
	},
	hero_10yr_buffed_spin_start = {
		prefix = "hero_10yr_buffed_spin_start",
		to = 16,
		from = 1
	},
	hero_10yr_buffed_spin_loop = {
		prefix = "hero_10yr_buffed_spin_loop",
		to = 8,
		from = 1
	},
	hero_10yr_buffed_spin_end = {
		prefix = "hero_10yr_buffed_spin_end",
		to = 22,
		from = 1
	},
	hero_10yr_buffed_bomb = {
		prefix = "hero_10yr_buffed_bomb",
		to = 47,
		from = 1
	},
	hero_10yr_normal_to_buffed = {
		prefix = "hero_10yr_normal_to_buffed",
		to = 28,
		from = 1
	},
	hero_10yr_buffed_to_normal = {
		prefix = "hero_10yr_buffed_to_normal",
		to = 31,
		from = 1
	},
	decal_sheep_big_idle = {
		prefix = "sheep_big",
		to = 1,
		from = 1
	},
	decal_sheep_big_play = {
		prefix = "sheep_big",
		to = 27,
		from = 2
	},
	decal_sheep_small_idle = {
		prefix = "sheep_small",
		to = 1,
		from = 1
	},
	decal_sheep_small_play = {
		prefix = "sheep_small",
		to = 27,
		from = 2
	},
	decal_mill_big = {
		prefix = "molino_big",
		to = 16,
		from = 1
	},
	decal_mill_small = {
		prefix = "molino_small",
		to = 16,
		from = 1
	},
	decal_boat_small_idle = {
		prefix = "boat1",
		to = 33,
		from = 1
	},
	decal_boat_big_idle = {
		prefix = "boat2",
		to = 35,
		from = 1
	},
	decal_fish_jump = {
		prefix = "fish",
		to = 22,
		from = 1
	},
	decal_water_spark_play = {
		prefix = "water_sparks",
		to = 25,
		from = 1
	},
	decal_water_wave_play = {
		prefix = "water_wave",
		to = 13,
		from = 1
	},
	decal_goat_idle = {
		prefix = "goat",
		to = 1,
		from = 1
	},
	decal_goat_play = {
		prefix = "goat",
		to = 30,
		from = 2
	},
	decal_burner_big_idle = {
		prefix = "stage12_burnerBig",
		to = 12,
		from = 1
	},
	decal_burner_small_idle = {
		prefix = "stage12_burnerSmall",
		to = 12,
		from = 1
	},
	decal_fredo_idle = {
		prefix = "stage13_fredo",
		to = 1,
		from = 1
	},
	decal_fredo_release = {
		prefix = "stage13_fredo",
		to = 139,
		from = 11
	},
	decal_fredo_clicked = {
		prefix = "stage13_fredo",
		to = 10,
		from = 1
	},
	decal_orc_burner_idle = {
		prefix = "orc_burner",
		to = 12,
		from = 1
	},
	decal_orc_flag_idle = {
		prefix = "orc_flag",
		to = 17,
		from = 1
	},
	decal_swamp_bubble_jump = {
		prefix = "stage15_bubble",
		to = 48,
		from = 1
	},
	decal_demon_portal_big_active = {
		prefix = "stage15_portal",
		to = 24,
		from = 1
	},
	decal_s17_barricade_idle = {
		prefix = "stage17_barricade",
		to = 1,
		from = 1
	},
	decal_s17_barricade_destroy = {
		prefix = "stage17_barricade",
		to = 10,
		from = 2
	},
	decal_bandits_flag_idle = {
		prefix = "stage17_flag",
		to = 15,
		from = 1
	},
	decal_scrat_idle = {
		prefix = "Stage18_squirrel",
		ranges = {
			{
				1,
				15
			},
			{
				1,
				15
			},
			{
				20,
				44
			}
		}
	},
	decal_scrat_play = {
		prefix = "Stage18_squirrel",
		to = 139,
		from = 45
	},
	decal_scrat_ice_idle = {
		prefix = "Stage18_squirrel_ice",
		to = 1,
		from = 1
	},
	decal_scrat_ice_play = {
		prefix = "Stage18_squirrel_ice",
		to = 139,
		from = 45
	},
	decal_scrat_ice_end = {
		prefix = "Stage18_squirrel_ice",
		to = 139,
		from = 139
	},
	decal_scrat_touch_fx = {
		prefix = "Stage18_squirrel_touchFx",
		to = 12,
		from = 1
	},
	decal_troll_flag_idle = {
		prefix = "Stage19_flag",
		to = 18,
		from = 1
	},
	decal_troll_burner_idle = {
		prefix = "Stage19_burner",
		to = 11,
		from = 1
	},
	decal_frozen_mushroom_idle = {
		prefix = "FrozenMushroom",
		to = 1,
		from = 1
	},
	decal_frozen_mushroom_clicked = {
		prefix = "FrozenMushroom",
		to = 18,
		from = 2
	},
	decal_lava_fall_idle = {
		prefix = "Inferno_Stg20_LavaFall",
		to = 21,
		from = 1
	},
	decal_inferno_bubble_jump = {
		prefix = "Inferno_LavaBubble",
		to = 47,
		from = 1
	},
	decal_lava_splash_jump = {
		prefix = "Inferno_Lava",
		to = 30,
		from = 1
	},
	decal_inferno_portal_active = {
		prefix = "InfernoPortal",
		to = 24,
		from = 1
	},
	decal_inferno_ground_portal_active = {
		prefix = "InfernoGroundPortal",
		to = 16,
		from = 1
	},
	decal_s21_hellboy_idle = {
		prefix = "Inferno_Stg21_HellBoy",
		to = 8,
		from = 1
	},
	decal_s23_splinter_idle = {
		prefix = "splinter_noPizza",
		to = 1,
		from = 1
	},
	decal_s23_splinter_clicked = {
		prefix = "splinter_noPizza",
		to = 30,
		from = 2
	},
	decal_s23_splinter_pizza_idle = {
		prefix = "splinter",
		to = 1,
		from = 1
	},
	decal_s23_splinter_pizza_clicked = {
		prefix = "splinter",
		to = 47,
		from = 2
	},
	decal_bat_flying_play = {
		prefix = "Bat",
		to = 8,
		from = 1
	},
	decal_s24_nevermore_idle = {
		prefix = "neverMore",
		to = 1,
		from = 1
	},
	decal_s24_nevermore_clicked = {
		prefix = "neverMore",
		to = 50,
		from = 2
	},
	decal_s24_nevermore_fly = {
		prefix = "neverMore",
		to = 56,
		from = 51
	},
	decal_blackburn_weed_idle = {
		prefix = "CB_yuyo",
		to = 34,
		from = 1
	},
	decal_blackburn_waves_jump = {
		prefix = "CB_water_wave",
		to = 24,
		from = 1
	},
	decal_blackburn_bubble_jump = {
		prefix = "CB_bubble",
		to = 46,
		from = 1
	},
	decal_blackburn_smoke_jump = {
		prefix = "CB_smoke",
		to = 21,
		from = 1
	},
	decal_s25_nessie_idle = {
		prefix = "nessMonster",
		to = 1,
		from = 1
	},
	decal_s25_nessie_bubble_in = {
		prefix = "nessMonster",
		to = 9,
		from = 1
	},
	decal_s25_nessie_bubble_out = {
		prefix = "nessMonster",
		to = 41,
		from = 32
	},
	decal_s25_nessie_bubble_play = {
		prefix = "nessMonster",
		to = 31,
		from = 10
	},
	decal_s25_nessie_clicked = {
		prefix = "nessMonster",
		to = 168,
		from = 42
	},
	decal_s26_cage_idle = {
		prefix = "CB_Stg26_cage",
		to = 1,
		from = 1
	},
	decal_s26_cage_play = {
		prefix = "CB_Stg26_cage",
		to = 21,
		from = 1
	},
	decal_s26_hangmen_idle = {
		prefix = "CB_Stg26_hanged",
		to = 1,
		from = 1
	},
	decal_s26_hangmen_play = {
		prefix = "CB_Stg26_hanged",
		to = 35,
		from = 1
	},
	decal_s81_percussionist_idle = {
		prefix = "endless_boss_percusion",
		to = 1,
		from = 1
	},
	decal_s81_percussionist_play = {
		prefix = "endless_boss_percusion",
		to = 11,
		from = 2
	},
	mod_elder_shaman_speed = {
		prefix = "buff_magic",
		to = 22,
		from = 1
	},
	small_freeze_explosion = {
		prefix = "small_freeze_explosion",
		to = 21,
		from = 1
	},
	freeze_creep_ground_start = {
		prefix = "freeze_creep",
		to = 7,
		from = 1
	},
	freeze_creep_ground_end = {
		prefix = "freeze_creep",
		to = 23,
		from = 8
	},
	freeze_creep_air_start = {
		prefix = "freeze_creepFlying",
		to = 9,
		from = 1
	},
	freeze_creep_air_end = {
		prefix = "freeze_creepFlying",
		to = 21,
		from = 10
	},
	atomic_bomb_plane_wing = {
		prefix = "atomicBomb_plane_wing",
		to = 11,
		from = 1
	},
	atomic_bomb_plane_engine = {
		prefix = "atomicBomb_plane_engine",
		to = 6,
		from = 1
	},
	bolt_shaman_necro_flying = {
			prefix = "CanibalShamanNecroBolt",
			to = 2,
			from = 1
		},
		bolt_shaman_necro_hit = {
			prefix = "CanibalShamanNecroBolt",
			to = 10,
			from = 3
		},
		soldier_skeleton_idle = {
			prefix = "a_skeleton",
			to = 1,
			from = 1
		},
		soldier_skeleton_running = {
			prefix = "a_skeleton",
			to = 16,
			from = 1
		},
		soldier_skeleton_attack = {
			prefix = "a_skeleton",
			to = 38,
			from = 17
		},
		soldier_skeleton_death = {
			prefix = "a_skeleton",
			to = 59,
			from = 39
		},
		soldier_skeleton_raise = {
			prefix = "a_skeleton",
			to = 92,
			from = 60
		},
		soldier_skeleton_knight_idle = {
			prefix = "a_skeleton_warrior",
			to = 1,
			from = 1
		},
		soldier_skeleton_knight_running = {
			prefix = "a_skeleton_warrior",
			to = 16,
			from = 1
		},
		soldier_skeleton_knight_attack = {
			prefix = "a_skeleton_warrior",
			to = 38,
			from = 17
		},
		soldier_skeleton_knight_death = {
			prefix = "a_skeleton_warrior",
			to = 59,
			from = 39
		},
		soldier_skeleton_knight_raise = {
			prefix = "a_skeleton_warrior",
			to = 92,
			from = 60
		},
		soldier_death_rider_idle = {
			prefix = "NecromancerDeathKnight",
			to = 1,
			from = 1
		},
		soldier_death_rider_running = {
			prefix = "NecromancerDeathKnight",
			to = 6,
			from = 2
		},
		soldier_death_rider_attack = {
			to = 24,
			from = 7,
			prefix = "NecromancerDeathKnight",
			post = {
				1
			}
		},
		soldier_death_rider_raise = {
			prefix = "NecromancerDeathKnight",
			to = 47,
			from = 25
		},
		soldier_death_rider_death = {
			prefix = "NecromancerDeathKnight",
			to = 64,
			from = 48
		},
		soldier_death_rider_aura = {
			prefix = "NecromancerDeathKnight_Aura",
			to = 30,
			from = 1
		},
	shooternecromancer_idleDown = {
			prefix = "NecomancerMage",
			to = 1,
			from = 1
		},
		shooternecromancer_shootStartDown = {
			prefix = "NecomancerMage",
			to = 14,
			from = 1
		},
		shooternecromancer_shootLoopDown = {
			prefix = "NecomancerMage",
			to = 28,
			from = 15
		},
		shooternecromancer_shootEndDown = {
			prefix = "NecomancerMage",
			to = 31,
			from = 29
		},
		shooternecromancer_idleUp = {
			prefix = "NecomancerMage",
			to = 32,
			from = 32
		},
		shooternecromancer_shootStartUp = {
			prefix = "NecomancerMage",
			to = 45,
			from = 33
		},
		shooternecromancer_shootLoopUp = {
			prefix = "NecomancerMage",
			to = 59,
			from = 46
		},
		shooternecromancer_shootEndUp = {
			prefix = "NecomancerMage",
			to = 62,
			from = 60
		},
		shooternecromancer_pestilenceDown = {
			prefix = "NecomancerMage",
			to = 91,
			from = 63
		},
		shooternecromancer_pestilenceUp = {
			prefix = "NecomancerMage",
			to = 120,
			from = 92
		},
soldier_blade_idle = {
		prefix = "bladeSinger",
		to = 1,
		from = 1
	},
	soldier_blade_running = {
		prefix = "bladeSinger",
		to = 6,
		from = 2
	},
	soldier_blade_attack1 = {
		prefix = "bladeSinger",
		to = 23,
		from = 7
	},
	soldier_blade_attack2 = {
		prefix = "bladeSinger",
		to = 41,
		from = 24
	},
	soldier_blade_attack3 = {
		prefix = "bladeSinger",
		to = 62,
		from = 42
	},
	soldier_blade_dance_out = {
		prefix = "bladeSinger",
		to = 73,
		from = 63
	},
	soldier_blade_dance_hit1 = {
		prefix = "bladeSinger",
		to = 83,
		from = 74
	},
	soldier_blade_dance_hit2 = {
		prefix = "bladeSinger",
		to = 94,
		from = 84
	},
	soldier_blade_dance_hit3 = {
		prefix = "bladeSinger",
		to = 110,
		from = 95
	},
	soldier_blade_dance_in = {
		prefix = "bladeSinger",
		to = 118,
		from = 112
	},
	soldier_blade_death = {
		prefix = "bladeSinger",
		to = 125,
		from = 119
	},
	soldier_blade_perfect_parry = {
		prefix = "bladeSinger",
		to = 133,
		from = 126
	},
	tower_blade_door_open = {
		prefix = "barracks_towers_layer2",
		to = 80,
		from = 76
	},
	tower_blade_door_close = {
		prefix = "barracks_towers_layer2",
		to = 100,
		from = 97
	},
	tower_drow_door_open = {
		prefix = "mercenaryDraw_tower_layer2",
		to = 7,
		from = 1
	},
	tower_drow_door_close = {
		prefix = "mercenaryDraw_tower_layer2",
		to = 25,
		from = 21
	},
	soldier_drow_idle = {
		prefix = "mercenaryDraw",
		to = 1,
		from = 1
	},
	soldier_drow_running = {
		prefix = "mercenaryDraw",
		to = 6,
		from = 2
	},
	soldier_drow_healAttack = {
		prefix = "mercenaryDraw",
		to = 34,
		from = 7
	},
	soldier_drow_attack = {
		prefix = "mercenaryDraw",
		to = 57,
		from = 35
	},
	soldier_drow_shoot_start = {
		prefix = "mercenaryDraw",
		to = 67,
		from = 58
	},
	soldier_drow_shoot_loop = {
		prefix = "mercenaryDraw",
		to = 68,
		from = 68
	},
	soldier_drow_shoot_end = {
		prefix = "mercenaryDraw",
		to = 80,
		from = 69
	},
	soldier_drow_death = {
		prefix = "mercenaryDraw",
		to = 95,
		from = 81
	},
	soldier_drow_heal = {
		prefix = "mercenaryDraw",
		to = 115,
		from = 96
	},
	soldier_drow_blade_mail_decal = {
		prefix = "mercenaryDraw_decal",
		to = 30,
		from = 1
	},
	fx_dagger_drow_hit = {
		prefix = "mercenaryDraw_proyHit",
		to = 8,
		from = 1
	},
	dagger_drow_particle = {
		prefix = "mercenaryDraw_proyParticle",
		to = 8,
		from = 1
	},
	tower_ewok_door_open = {
		prefix = "ewok_hut",
		to = 6,
		from = 3
	},
	tower_ewok_door_close = {
		prefix = "ewok_hut",
		to = 27,
		from = 24
	},
	soldier_ewok_idle = {
		prefix = "ewok",
		to = 1,
		from = 1
	},
	soldier_ewok_running = {
		prefix = "ewok",
		to = 17,
		from = 2
	},
	soldier_ewok_attack = {
		prefix = "ewok",
		to = 29,
		from = 18
	},
	soldier_ewok_shield_start = {
		prefix = "ewok",
		to = 40,
		from = 30
	},
	soldier_ewok_shield_hit = {
		prefix = "ewok",
		to = 50,
		from = 41
	},
	soldier_ewok_shield_end = {
		prefix = "ewok",
		to = 55,
		from = 51
	},
	soldier_ewok_shoot = {
		prefix = "ewok",
		to = 72,
		from = 56
	},
	soldier_ewok_death = {
		prefix = "ewok",
		to = 80,
		from = 73
	},
	bullet_soldier_ewok = {
		prefix = "ewok_proy",
		to = 11,
		from = 1
	},
	galahadriansBastion_layerX_reload = {
		layer_to = 4,
		from = 1,
		layer_prefix = "galahadriansBastion_layer%i",
		to = 38,
		layer_from = 1
	},
	galahadriansBastion_layerX_shoot = {
		layer_to = 4,
		from = 39,
		layer_prefix = "galahadriansBastion_layer%i",
		to = 52,
		layer_from = 1
	},
	galahadriansBastion_layerX_idle = {
		layer_to = 4,
		from = 53,
		layer_prefix = "galahadriansBastion_layer%i",
		to = 53,
		layer_from = 1
	},
	galahadriansBastion_layerX_broken = {
		layer_to = 4,
		from = 54,
		layer_prefix = "galahadriansBastion_layer%i",
		to = 54,
		layer_from = 1
	},
	bullet_razor_edge_flying = {
		prefix = "galahadriansBastion_proy",
		to = 4,
		from = 1
	},
	bullet_razor_edge_smoke = {
		prefix = "galahadriansBastion_proy_particle",
		to = 16,
		from = 1
	},
	hero_voodoo_witch_idle = {
			prefix = "voodoo",
			to = 1,
			from = 1
		},
		hero_voodoo_witch_running = {
			prefix = "voodoo",
			to = 6,
			from = 2
		},
		hero_voodoo_witch_attack = {
			prefix = "voodoo",
			to = 29,
			from = 7
		},
		hero_voodoo_witch_death = {
			prefix = "voodoo",
			to = 139,
			from = 116
		},
		hero_voodoo_witch_respawn = {
			prefix = "voodoo",
			to = 159,
			from = 140
		},
		hero_voodoo_witch_levelup = {
			prefix = "voodoo",
			to = 159,
			from = 140
		},
		hero_voodoo_witch_magic = {
			prefix = "voodoo",
			to = 115,
			from = 54
		},
		hero_voodoo_witch_skull_sacrifice = {
			prefix = "voodoo",
			to = 159,
			from = 140
		},
		hero_voodoo_witch_shoot = {
			prefix = "voodoo",
			to = 53,
			from = 30
		},
		bolt_voodoo_witch_flying = {
			prefix = "voodoo_proy",
			to = 15,
			from = 1
		},
		bolt_voodoo_witch_hit = {
			prefix = "voodoo_proy",
			to = 25,
			from = 16
		},
		decal_voodoo_witch_death_aura = {
			prefix = "voodoo_buff_base",
			to = 80,
			from = 1
		},
		mod_voodoo_witch_magic = {
			prefix = "voodoo_nail",
			to = 29,
			from = 1
		},
		voodoo_witch_skull_idle = {
			prefix = "voodoo_skull",
			to = 1,
			from = 1
		},
		voodoo_witch_skull_shoot = {
			prefix = "voodoo_skull",
			to = 17,
			from = 2
		},
		fx_voodoo_witch_skull_explosion = {
			prefix = "voodoo_skull_exlposion",
			to = 16,
			from = 1
		},
		voodoo_skull_particle = {
			prefix = "voodoo_skull_particle",
			to = 8,
			from = 1
	},
	soldier_forest_idle = {
		prefix = "forestKeeper",
		to = 1,
		from = 1
	},
	soldier_forest_running = {
		prefix = "forestKeeper",
		to = 8,
		from = 2
	},
	soldier_forest_attack = {
		prefix = "forestKeeper",
		to = 24,
		from = 9
	},
	soldier_forest_ranged_attack = {
		prefix = "forestKeeper",
		to = 42,
		from = 25
	},
	soldier_forest_death = {
		prefix = "forestKeeper",
		to = 62,
		from = 43
	},
	soldier_forest_circle = {
		prefix = "forestKeeper",
		to = 95,
		from = 63
	},
	soldier_forest_oak_attack = {
		prefix = "forestKeeper",
		to = 121,
		from = 96
	},
	soldier_forest_eerie = {
		prefix = "forestKeeper",
		to = 153,
		from = 122
	},
	decal_mod_forest_circle = {
		prefix = "forestKeeper_soldierBuff_decal",
		to = 8,
		from = 1
	},
	decal_eerie_roots_1_start = {
		prefix = "forestKeeper_roots",
		to = 10,
		from = 1
	},
	decal_eerie_roots_1_end = {
		prefix = "forestKeeper_roots",
		to = 29,
		from = 11
	},
	decal_eerie_roots_1_loop = {
		prefix = "forestKeeper_roots",
		to = 45,
		from = 30
	},
	decal_eerie_roots_2_start = {
		prefix = "forestKeeper_roots2",
		to = 10,
		from = 1
	},
	decal_eerie_roots_2_end = {
		prefix = "forestKeeper_roots2",
		to = 29,
		from = 11
	},
	decal_eerie_roots_2_loop = {
		prefix = "forestKeeper_roots2",
		to = 45,
		from = 30
	},
	fx_spear_forest_oak_hit = {
		prefix = "forestKeeper_proySpecial_hit",
		to = 9,
		from = 1
	},
	tower_forest_door_open = {
		prefix = "barracks_towers_layer2",
		to = 101,
		from = 101
	},
	tower_forest_door_close = {
		prefix = "barracks_towers_layer2",
		to = 101,
		from = 101
	},
	fx_rock_explosion = {
		prefix = "artillery_thrower_explosion",
		to = 19,
		from = 1
	},
	fx_rock_druid_launch = {
		prefix = "artillery_henge_stoneLaunch",
		to = 10,
		from = 1
	},
	fx_arrow_arcane_hit = {
		prefix = "archer_arcane_proy",
		to = 9,
		from = 2
	},
	arcane_burst_explosion = {
		prefix = "archer_arcane_special_explosion",
		to = 14,
		from = 1
	},
	arcane_slumber_explosion = {
		prefix = "archer_arcane_sleep_explosion",
		to = 14,
		from = 1
	},
	arcane_slumber_bubbles_loop = {
		prefix = "archer_arcane_sleep_bubbles",
		to = 21,
		from = 1
	},
	arcane_slumber_z_loop = {
		prefix = "archer_arcane_sleep_z",
		to = 50,
		from = 1
	},
	fx_arrow_silver_mark_hit = {
		prefix = "archer_silver_mark_explotion",
		to = 9,
		from = 1
	},
	arrow_silver_mark_particle_1 = {
		prefix = "archer_silver_mark_particle1",
		to = 10,
		from = 1
	},
	arrow_silver_mark_particle_2 = {
		prefix = "archer_silver_mark_particle2",
		to = 10,
		from = 1
	},
	fx_arrow_silver_sentence_hit = {
		prefix = "archer_silver_instaKillFx",
		to = 10,
		from = 1
	},
	fx_arrow_silver_sentence_shot = {
		prefix = "archer_silver_instaKill_over",
		to = 10,
		from = 1
	},
	tower_archer_shooter_idleDown = {
		prefix = "archer_shooter",
		to = 10,
		from = 10
	},
	tower_archer_shooter_idleUp = {
		prefix = "archer_shooter",
		to = 20,
		from = 20
	},
	tower_archer_shooter_shootingDown = {
		prefix = "archer_shooter",
		to = 9,
		from = 1
	},
	tower_archer_shooter_shootingUp = {
		prefix = "archer_shooter",
		to = 19,
		from = 11
	},
	tower_arcane_shooter_idleDown = {
		prefix = "archer_arcane_shooter",
		to = 9,
		from = 9
	},
	tower_arcane_shooter_shootDown = {
		prefix = "archer_arcane_shooter",
		to = 9,
		from = 1
	},
	tower_arcane_shooter_idleUp = {
		prefix = "archer_arcane_shooter",
		to = 18,
		from = 18
	},
	tower_arcane_shooter_shootUp = {
		prefix = "archer_arcane_shooter",
		to = 18,
		from = 10
	},
	tower_arcane_shooter_specialDown = {
		prefix = "archer_arcane_shooter",
		to = 41,
		from = 19
	},
	tower_arcane_shooter_specialUp = {
		prefix = "archer_arcane_shooter",
		to = 64,
		from = 42
	},
	tower_arcane_bubbles = {
		prefix = "archer_arcane_decos",
		to = 21,
		from = 1
	},
	tower_silver_shooter_idleDown = {
		prefix = "archer_silver_shooter",
		to = 12,
		from = 1
	},
	tower_silver_shooter_idleUp = {
		prefix = "archer_silver_shooter",
		to = 24,
		from = 13
	},
	tower_silver_shooter_shootDown = {
		prefix = "archer_silver_shooter",
		to = 58,
		from = 41
	},
	tower_silver_shooter_shootUp = {
		prefix = "archer_silver_shooter",
		to = 76,
		from = 59
	},
	tower_silver_shooter_shootShortDown = {
		prefix = "archer_silver_shooter",
		to = 32,
		from = 25
	},
	tower_silver_shooter_shootShortUp = {
		prefix = "archer_silver_shooter",
		to = 40,
		from = 33
	},
	tower_silver_shooter_shootSpecialDown = {
		prefix = "archer_silver_shooter",
		to = 100,
		from = 77
	},
	tower_silver_shooter_shootSpecialUp = {
		prefix = "archer_silver_shooter",
		to = 124,
		from = 101
	},
	tower_silver_shooter_shootSpecialShortDown = {
		prefix = "archer_silver_shooter",
		to = 148,
		from = 125
	},
	tower_silver_shooter_shootSpecialShortUp = {
		prefix = "archer_silver_shooter",
		to = 172,
		from = 149
	},
	tower_silver_shooter_instakillDown = {
		prefix = "archer_silver_shooter",
		to = 196,
		from = 173
	},
	tower_silver_shooter_instakillUp = {
		prefix = "archer_silver_shooter",
		to = 220,
		from = 197
	},
	tower_mage_1_platform_shoot = {
		prefix = "mage_towers_layer2",
		to = 31,
		from = 1
	},
	tower_mage_1_platform_idle = {
		prefix = "mage_towers_layer2",
		to = 32,
		from = 32
	},
	tower_mage_2_platform_shoot = {
		prefix = "mage_towers_layer2",
		to = 63,
		from = 33
	},
	tower_mage_2_platform_idle = {
		prefix = "mage_towers_layer2",
		to = 64,
		from = 64
	},
	tower_mage_3_platform_shoot = {
		prefix = "mage_towers_layer2",
		to = 95,
		from = 65
	},
	tower_mage_3_platform_idle = {
		prefix = "mage_towers_layer2",
		to = 96,
		from = 96
	},
	tower_mage_shooter_shootingDown = {
		prefix = "mage_tower_shooter",
		to = 31,
		from = 1
	},
	tower_mage_shooter_idleDown = {
		prefix = "mage_tower_shooter",
		to = 32,
		from = 32
	},
	tower_mage_shooter_shootingUp = {
		prefix = "mage_tower_shooter",
		to = 63,
		from = 33
	},
	tower_mage_shooter_idleUp = {
		prefix = "mage_tower_shooter",
		to = 64,
		from = 64
	},
	bolt_elves_travel = {
		prefix = "mage_proy",
		to = 15,
		from = 1
	},
	bolt_elves_hit = {
		prefix = "mage_proy",
		to = 25,
		from = 16
	},
	tower_wild_magus_shooter_idleDown = {
		prefix = "mage_wild_shooter",
		to = 1,
		from = 1
	},
	tower_wild_magus_shooter_idleUp = {
		prefix = "mage_wild_shooter",
		to = 2,
		from = 2
	},
	tower_wild_magus_shooter_rh_shootDown = {
		prefix = "mage_wild_shooter",
		to = 10,
		from = 3
	},
	tower_wild_magus_shooter_lh_shootDown = {
		prefix = "mage_wild_shooter",
		to = 18,
		from = 11
	},
	tower_wild_magus_shooter_rh_shootUp = {
		prefix = "mage_wild_shooter",
		to = 26,
		from = 19
	},
	tower_wild_magus_shooter_lh_shootUp = {
		prefix = "mage_wild_shooter",
		to = 34,
		from = 27
	},
	tower_wild_magus_shooter_rayDown = {
		prefix = "mage_wild_shooter",
		to = 68,
		from = 35
	},
	tower_wild_magus_shooter_rayUp = {
		prefix = "mage_wild_shooter",
		to = 102,
		from = 69
	},
	tower_wild_magus_shooter_wardDown = {
		prefix = "mage_wild_shooter",
		to = 134,
		from = 103
	},
	tower_wild_magus_shooter_wardUp = {
		prefix = "mage_wild_shooter",
		to = 166,
		from = 135
	},
	tower_wild_magus_ward_rune = {
		prefix = "mage_wild_shooter",
		to = 193,
		from = 169
	},
	bolt_wild_magus_flying = {
		prefix = "mage_wild_proy",
		to = 8,
		from = 1
	},
	bolt_wild_magus_hit = {
		prefix = "mage_wild_proy",
		to = 32,
		from = 9
	},
	ray_wild_magus = {
		prefix = "mage_wild_ray",
		to = 16,
		from = 1
	},
	fx_ray_wild_magus_hit = {
		prefix = "mage_wild_ray_head",
		to = 14,
		from = 1
	},
	mod_eldritch = {
		prefix = "mage_wild_creepFx",
		to = 12,
		from = 1
	},
	fx_eldritch_explosion = {
		prefix = "mage_wild_explosion",
		to = 19,
		from = 1
	},
	mod_ward_decal = {
		prefix = "mage_wild_silence_decal",
		to = 15,
		from = 1
	},
	tower_high_elven_shooter_idleDown = {
		prefix = "mage_highElven_shooter",
		to = 1,
		from = 1
	},
	tower_high_elven_shooter_idleUp = {
		prefix = "mage_highElven_shooter",
		to = 2,
		from = 2
	},
	tower_high_elven_shooter_shootDown = {
		prefix = "mage_highElven_shooter",
		to = 40,
		from = 3
	},
	tower_high_elven_shooter_shootUp = {
		prefix = "mage_highElven_shooter",
		to = 78,
		from = 41
	},
	tower_high_elven_shooter_timeLapseDown = {
		prefix = "mage_highElven_shooter",
		to = 108,
		from = 79
	},
	tower_high_elven_shooter_timeLapseUp = {
		prefix = "mage_highElven_shooter",
		to = 138,
		from = 109
	},
	bolt_high_elven_weak_travel = {
		prefix = "mage_highElven_proy",
		to = 15,
		from = 1
	},
	bolt_high_elven_weak_hit = {
		prefix = "mage_highElven_proy",
		to = 25,
		from = 16
	},
	bolt_high_elven_strong_travel = {
		prefix = "mage_highElven_proyBig",
		to = 1,
		from = 1
	},
	bolt_high_elven_strong_hit = {
		prefix = "mage_highElven_proyBig",
		to = 17,
		from = 2
	},
	mod_timelapse_start = {
		prefix = "mage_highElven_energyBall",
		to = 28,
		from = 1
	},
	mod_timelapse_loop = {
		prefix = "mage_highElven_energyBall",
		to = 44,
		from = 29
	},
	mod_timelapse_end = {
		prefix = "mage_highElven_energyBall",
		to = 52,
		from = 45
	},
	high_elven_sentinel_small = {
		prefix = "mage_highElven_balls",
		to = 1,
		from = 1
	},
	high_elven_sentinel_big = {
		prefix = "mage_highElven_balls",
		to = 19,
		from = 2
	},
	high_elven_sentinel_shoot = {
		prefix = "mage_highElven_balls",
		to = 34,
		from = 21
	},
	high_elven_sentinel_particle = {
		prefix = "mage_highElven_balls",
		to = 20,
		from = 20
	},
	ray_high_elven_sentinel = {
		prefix = "mage_highElven_balls_ray",
		to = 4,
		from = 1
	},
	fx_ray_high_elven_sentinel_hit = {
		prefix = "mage_highElven_balls_hitFx_big",
		to = 10,
		from = 1
	},
	tower_rock_thrower_shooter_l1_idleDown = {
		prefix = "artillery_thrower",
		to = 1,
		from = 1
	},
	tower_rock_thrower_shooter_l1_loadDown = {
		prefix = "artillery_thrower",
		to = 49,
		from = 2
	},
	tower_rock_thrower_shooter_l1_shootDown = {
		prefix = "artillery_thrower",
		to = 73,
		from = 50
	},
	tower_rock_thrower_shooter_l1_idleUp = {
		prefix = "artillery_thrower",
		to = 74,
		from = 74
	},
	tower_rock_thrower_shooter_l1_loadUp = {
		prefix = "artillery_thrower",
		to = 122,
		from = 75
	},
	tower_rock_thrower_shooter_l1_shootUp = {
		prefix = "artillery_thrower",
		to = 145,
		from = 123
	},
	tower_rock_thrower_shooter_l2_idleDown = {
		prefix = "artillery_thrower_lvl2",
		to = 1,
		from = 1
	},
	tower_rock_thrower_shooter_l2_loadDown = {
		prefix = "artillery_thrower_lvl2",
		to = 49,
		from = 2
	},
	tower_rock_thrower_shooter_l2_shootDown = {
		prefix = "artillery_thrower_lvl2",
		to = 73,
		from = 50
	},
	tower_rock_thrower_shooter_l2_idleUp = {
		prefix = "artillery_thrower_lvl2",
		to = 74,
		from = 74
	},
	tower_rock_thrower_shooter_l2_loadUp = {
		prefix = "artillery_thrower_lvl2",
		to = 122,
		from = 75
	},
	tower_rock_thrower_shooter_l2_shootUp = {
		prefix = "artillery_thrower_lvl2",
		to = 145,
		from = 123
	},
	tower_rock_thrower_shooter_l3_idleDown = {
		prefix = "artillery_thrower_lvl3",
		to = 1,
		from = 1
	},
	tower_rock_thrower_shooter_l3_loadDown = {
		prefix = "artillery_thrower_lvl3",
		to = 49,
		from = 2
	},
	tower_rock_thrower_shooter_l3_shootDown = {
		prefix = "artillery_thrower_lvl3",
		to = 73,
		from = 50
	},
	tower_rock_thrower_shooter_l3_idleUp = {
		prefix = "artillery_thrower_lvl3",
		to = 74,
		from = 74
	},
	tower_rock_thrower_shooter_l3_loadUp = {
		prefix = "artillery_thrower_lvl3",
		to = 122,
		from = 75
	},
	tower_rock_thrower_shooter_l3_shootUp = {
		prefix = "artillery_thrower_lvl3",
		to = 145,
		from = 123
	},
	tower_rock_thrower_loading_stones_play = {
		prefix = "artillery_thrower_stones",
		to = 26,
		from = 1
	},
	tower_druid_shooter_idleDown = {
		prefix = "artillery_henge_druid1",
		to = 1,
		from = 1
	},
	tower_druid_shooter_castDown = {
		prefix = "artillery_henge_druid1",
		to = 29,
		from = 2
	},
	tower_druid_shooter_shootDown = {
		prefix = "artillery_henge_druid1",
		to = 51,
		from = 30
	},
	tower_druid_shooter_idleUp = {
		prefix = "artillery_henge_druid1",
		to = 52,
		from = 52
	},
	tower_druid_shooter_castUp = {
		prefix = "artillery_henge_druid1",
		to = 80,
		from = 53
	},
	tower_druid_shooter_shootUp = {
		prefix = "artillery_henge_druid1",
		to = 102,
		from = 81
	},
	tower_druid_shooter_nature_cast = {
		prefix = "artillery_henge_druid3",
		to = 57,
		from = 1
	},
	tower_druid_shooter_nature_idle = {
		prefix = "artillery_henge_druid3",
		to = 57,
		from = 57
	},
	tower_druid_shooter_sylvan_cast = {
		prefix = "artillery_henge_druid2",
		to = 46,
		from = 1
	},
	tower_druid_shooter_sylvan_idle = {
		prefix = "artillery_henge_druid2",
		to = 46,
		from = 46
	},
	mod_druid_sylvan_small = {
		prefix = "artillery_henge_curse_small",
		to = 22,
		from = 1
	},
	mod_druid_sylvan_big = {
		prefix = "artillery_henge_curse_big",
		to = 22,
		from = 1
	},
	mod_druid_sylvan_affected_small = {
		prefix = "artillery_henge_affected_small",
		to = 18,
		from = 1
	},
	mod_druid_sylvan_affected_big = {
		prefix = "artillery_henge_affected_big",
		to = 18,
		from = 1
	},
	ray_druid_sylvan = {
		prefix = "artillery_henge_curse_ray",
		to = 12,
		from = 1
	},
	druid_stone1_load = {
		prefix = "artillery_henge_chargeStone",
		to = 13,
		from = 1
	},
	druid_stone1_travel = {
		prefix = "artillery_henge_chargeStone",
		to = 13,
		from = 13
	},
	druid_stone2_load = {
		prefix = "artillery_henge_chargeStone",
		to = 26,
		from = 14
	},
	druid_stone2_travel = {
		prefix = "artillery_henge_chargeStone",
		to = 26,
		from = 26
	},
	druid_stone3_load = {
		prefix = "artillery_henge_chargeStone",
		to = 39,
		from = 27
	},
	druid_stone3_travel = {
		prefix = "artillery_henge_chargeStone",
		to = 39,
		from = 39
	},
	soldier_druid_bear_idle = {
		prefix = "artillery_henge_bear",
		to = 1,
		from = 1
	},
	soldier_druid_bear_walk = {
		prefix = "artillery_henge_bear",
		to = 13,
		from = 2
	},
	soldier_druid_bear_attack = {
		prefix = "artillery_henge_bear",
		to = 40,
		from = 18
	},
	soldier_druid_bear_idle2stance = {
		prefix = "artillery_henge_bear",
		to = 17,
		from = 14
	},
	soldier_druid_bear_stance2idle = {
		prefix = "artillery_henge_bear",
		to = 45,
		from = 41
	},
	soldier_druid_bear_spawn = {
		prefix = "artillery_henge_bear",
		to = 90,
		from = 46
	},
	soldier_druid_bear_death = {
		prefix = "artillery_henge_bear",
		to = 172,
		from = 121
	},
	fx_druid_bear_spawn_rune = {
		prefix = "artillery_henge_bear",
		to = 99,
		from = 91
	},
	fx_druid_bear_spawn_effect = {
		prefix = "artillery_henge_bear",
		to = 115,
		from = 100
	},
	fx_druid_bear_spawn_decal = {
		prefix = "artillery_henge_bear",
		to = 116,
		from = 116
	},
	fx_druid_bear_death_rune = {
		prefix = "artillery_henge_bear",
		to = 182,
		from = 173
	},
	fx_druid_bear_death_effect = {
		prefix = "artillery_henge_bear",
		to = 198,
		from = 183
	},
	decal_fiery_nut_scorched = {
		prefix = "artillery_tree_scorched",
		to = 20,
		from = 1
	},
	fx_fiery_nut_explosion = {
		prefix = "rodOfDragonfire_explosion",
		to = 14,
		from = 1
	},
	fx_clobber_smoke = {
		prefix = "EarthquakeTower_HitSmoke",
		to = 14,
		from = 1
	},
	fx_clobber_smoke_ring = {
		prefix = "artillery_tree_smoke",
		to = 10,
		from = 1
	},
	tower_entwood_blink = {
		prefix = "artillery_tree_blink",
		to = 8,
		from = 1
	},
	tower_entwood_layer1_idle = {
		prefix = "artillery_tree_layer1",
		to = 1,
		from = 1
	},
	tower_entwood_layer2_idle = {
		prefix = "artillery_tree_layer2",
		to = 1,
		from = 1
	},
	tower_entwood_layer3_idle = {
		prefix = "artillery_tree_layer3",
		to = 1,
		from = 1
	},
	tower_entwood_layer4_idle = {
		prefix = "artillery_tree_layer4",
		to = 1,
		from = 1
	},
	tower_entwood_layer5_idle = {
		prefix = "artillery_tree_layer5",
		to = 1,
		from = 1
	},
	tower_entwood_layer6_idle = {
		prefix = "artillery_tree_layer6",
		to = 1,
		from = 1
	},
	tower_entwood_layer7_idle = {
		prefix = "artillery_tree_layer7",
		to = 1,
		from = 1
	},
	tower_entwood_layer8_idle = {
		prefix = "artillery_tree_layer8",
		to = 1,
		from = 1
	},
	tower_entwood_layer9_idle = {
		prefix = "artillery_tree_layer9",
		to = 1,
		from = 1
	},
	tower_entwood_layer1_attack1 = {
		prefix = "artillery_tree_layer1",
		to = 58,
		from = 39
	},
	tower_entwood_layer2_attack1 = {
		prefix = "artillery_tree_layer2",
		to = 58,
		from = 39
	},
	tower_entwood_layer3_attack1 = {
		prefix = "artillery_tree_layer3",
		to = 58,
		from = 39
	},
	tower_entwood_layer4_attack1 = {
		prefix = "artillery_tree_layer4",
		to = 58,
		from = 39
	},
	tower_entwood_layer5_attack1 = {
		prefix = "artillery_tree_layer5",
		to = 58,
		from = 39
	},
	tower_entwood_layer6_attack1 = {
		prefix = "artillery_tree_layer6",
		to = 58,
		from = 39
	},
	tower_entwood_layer7_attack1 = {
		prefix = "artillery_tree_layer7",
		to = 58,
		from = 39
	},
	tower_entwood_layer8_attack1 = {
		prefix = "artillery_tree_layer8",
		to = 58,
		from = 39
	},
	tower_entwood_layer9_attack1 = {
		prefix = "artillery_tree_layer9",
		to = 58,
		from = 39
	},
	tower_entwood_layer1_special1 = {
		prefix = "artillery_tree_layer1",
		to = 115,
		from = 95
	},
	tower_entwood_layer2_special1 = {
		prefix = "artillery_tree_layer2",
		to = 115,
		from = 95
	},
	tower_entwood_layer3_special1 = {
		prefix = "artillery_tree_layer3",
		to = 115,
		from = 95
	},
	tower_entwood_layer4_special1 = {
		prefix = "artillery_tree_layer4",
		to = 115,
		from = 95
	},
	tower_entwood_layer5_special1 = {
		prefix = "artillery_tree_layer5",
		to = 115,
		from = 95
	},
	tower_entwood_layer6_special1 = {
		prefix = "artillery_tree_layer6",
		to = 115,
		from = 95
	},
	tower_entwood_layer7_special1 = {
		prefix = "artillery_tree_layer7",
		to = 115,
		from = 95
	},
	tower_entwood_layer8_special1 = {
		prefix = "artillery_tree_layer8",
		to = 115,
		from = 95
	},
	tower_entwood_layer9_special1 = {
		prefix = "artillery_tree_layer9",
		to = 115,
		from = 95
	},
	tower_entwood_layer1_special2 = {
		prefix = "artillery_tree_layer1",
		to = 153,
		from = 116
	},
	tower_entwood_layer2_special2 = {
		prefix = "artillery_tree_layer2",
		to = 153,
		from = 116
	},
	tower_entwood_layer3_special2 = {
		prefix = "artillery_tree_layer3",
		to = 153,
		from = 116
	},
	tower_entwood_layer4_special2 = {
		prefix = "artillery_tree_layer4",
		to = 153,
		from = 116
	},
	tower_entwood_layer5_special2 = {
		prefix = "artillery_tree_layer5",
		to = 153,
		from = 116
	},
	tower_entwood_layer6_special2 = {
		prefix = "artillery_tree_layer6",
		to = 153,
		from = 116
	},
	tower_entwood_layer7_special2 = {
		prefix = "artillery_tree_layer7",
		to = 153,
		from = 116
	},
	tower_entwood_layer8_special2 = {
		prefix = "artillery_tree_layer8",
		to = 153,
		from = 116
	},
	tower_entwood_layer9_special2 = {
		prefix = "artillery_tree_layer9",
		to = 153,
		from = 116
	},
	tower_entwood_layer1_attack1_charge = {
		prefix = "artillery_tree_layer1",
		to = 38,
		from = 2
	},
	tower_entwood_layer2_attack1_charge = {
		prefix = "artillery_tree_layer2",
		to = 38,
		from = 2
	},
	tower_entwood_layer3_attack1_charge = {
		prefix = "artillery_tree_layer3",
		to = 38,
		from = 2
	},
	tower_entwood_layer4_attack1_charge = {
		prefix = "artillery_tree_layer4",
		to = 38,
		from = 2
	},
	tower_entwood_layer5_attack1_charge = {
		prefix = "artillery_tree_layer5",
		to = 38,
		from = 2
	},
	tower_entwood_layer6_attack1_charge = {
		prefix = "artillery_tree_layer6",
		to = 38,
		from = 2
	},
	tower_entwood_layer7_attack1_charge = {
		prefix = "artillery_tree_layer7",
		to = 38,
		from = 2
	},
	tower_entwood_layer8_attack1_charge = {
		prefix = "artillery_tree_layer8",
		to = 38,
		from = 2
	},
	tower_entwood_layer9_attack1_charge = {
		prefix = "artillery_tree_layer9",
		to = 38,
		from = 2
	},
	tower_entwood_layer1_special1_charge = {
		prefix = "artillery_tree_layer1",
		to = 94,
		from = 59
	},
	tower_entwood_layer2_special1_charge = {
		prefix = "artillery_tree_layer2",
		to = 94,
		from = 59
	},
	tower_entwood_layer3_special1_charge = {
		prefix = "artillery_tree_layer3",
		to = 94,
		from = 59
	},
	tower_entwood_layer4_special1_charge = {
		prefix = "artillery_tree_layer4",
		to = 94,
		from = 59
	},
	tower_entwood_layer5_special1_charge = {
		prefix = "artillery_tree_layer5",
		to = 94,
		from = 59
	},
	tower_entwood_layer6_special1_charge = {
		prefix = "artillery_tree_layer6",
		to = 94,
		from = 59
	},
	tower_entwood_layer7_special1_charge = {
		prefix = "artillery_tree_layer7",
		to = 94,
		from = 59
	},
	tower_entwood_layer8_special1_charge = {
		prefix = "artillery_tree_layer8",
		to = 94,
		from = 59
	},
	tower_entwood_layer9_special1_charge = {
		prefix = "artillery_tree_layer9",
		to = 94,
		from = 59
	},
	tower_elven_barrack_1_door_open = {
		prefix = "barracks_towers_layer2",
		to = 5,
		from = 1
	},
	tower_elven_barrack_1_door_close = {
		prefix = "barracks_towers_layer2",
		to = 25,
		from = 22
	},
	tower_elven_barrack_2_door_open = {
		prefix = "barracks_towers_layer2",
		to = 30,
		from = 26
	},
	tower_elven_barrack_2_door_close = {
		prefix = "barracks_towers_layer2",
		to = 50,
		from = 47
	},
	tower_elven_barrack_3_door_open = {
		prefix = "barracks_towers_layer2",
		to = 55,
		from = 51
	},
	tower_elven_barrack_3_door_close = {
		prefix = "barracks_towers_layer2",
		to = 75,
		from = 72
	},
	tower_blade_door_open = {
		prefix = "barracks_towers_layer2",
		to = 80,
		from = 76
	},
	tower_blade_door_close = {
		prefix = "barracks_towers_layer2",
		to = 100,
		from = 97
	},
	tower_forest_door_open = {
		prefix = "barracks_towers_layer2",
		to = 101,
		from = 101
	},
	tower_forest_door_close = {
		prefix = "barracks_towers_layer2",
		to = 101,
		from = 101
	},
	tower_ewok_door_open = {
		prefix = "ewok_hut",
		to = 6,
		from = 3
	},
	tower_ewok_door_close = {
		prefix = "ewok_hut",
		to = 27,
		from = 24
	},
	tower_faerie_dragon_egg_idle = {
		prefix = "fairy_dragon_egg",
		to = 1,
		from = 1
	},
	tower_faerie_dragon_egg_open = {
		prefix = "fairy_dragon_egg",
		to = 16,
		from = 1
	},
	tower_drow_door_open = {
		prefix = "mercenaryDraw_tower_layer2",
		to = 7,
		from = 1
	},
	tower_drow_door_close = {
		prefix = "mercenaryDraw_tower_layer2",
		to = 25,
		from = 21
	},
	soldier_barrack_1_idle = {
		prefix = "soldiers_123",
		to = 1,
		from = 1
	},
	soldier_barrack_1_attack = {
		prefix = "soldiers_123",
		to = 22,
		from = 7
	},
	soldier_barrack_1_running = {
		prefix = "soldiers_123",
		to = 6,
		from = 2
	},
	soldier_barrack_1_death = {
		prefix = "soldiers_123",
		to = 31,
		from = 23
	},
	soldier_barrack_1_ranged_attack = {
		prefix = "soldiers_123",
		to = 64,
		from = 50
	},
	soldier_barrack_2_idle = {
		prefix = "soldiers_123",
		to = 32,
		from = 32
	},
	soldier_barrack_2_attack = {
		prefix = "soldiers_123",
		to = 49,
		from = 38
	},
	soldier_barrack_2_running = {
		prefix = "soldiers_123",
		to = 37,
		from = 33
	},
	soldier_barrack_2_death = {
		prefix = "soldiers_123",
		to = 73,
		from = 65
	},
	soldier_barrack_2_ranged_attack = {
		prefix = "soldiers_123",
		to = 64,
		from = 50
	},
	soldier_barrack_3_idle = {
		prefix = "soldiers_123",
		to = 74,
		from = 74
	},
	soldier_barrack_3_attack = {
		prefix = "soldiers_123",
		to = 97,
		from = 80
	},
	soldier_barrack_3_running = {
		prefix = "soldiers_123",
		to = 79,
		from = 75
	},
	soldier_barrack_3_death = {
		prefix = "soldiers_123",
		to = 120,
		from = 113
	},
	soldier_barrack_3_ranged_attack = {
		prefix = "soldiers_123",
		to = 112,
		from = 98
	},
	towerdwaarp_idle = {
			prefix = "EarthquakeTower",
			to = 1,
			from = 1
		},
		towerdwaarp_shoot = {
			prefix = "EarthquakeTower",
			to = 56,
			from = 1
		},
		towerdwaarp_drill = {
			prefix = "EarthquakeTower",
			to = 104,
			from = 57
		},
		towerdwaarp_siren = {
			prefix = "EarthquakeTower_Glow",
			to = 28,
			from = 1
		},
		towerdwaarp_lights = {
			prefix = "EarthquakeTower_lights",
			to = 8,
			from = 1
		},
		towerdwaarp_sfx_smoke = {
			prefix = "EarthquakeTower_HitSmoke",
			to = 14,
			from = 1
		},
		towerdwaarp_sfx_smokewater = {
			prefix = "EarthquakeTower_HitSmoke_water",
			to = 12,
			from = 1
		},
		towerdwaarp_sfx_vapor = {
			prefix = "EarthquakeTower_HitSmoke_waterFx",
			to = 46,
			from = 1
		},
		drill_ground = {
			prefix = "EarthquakeTower_drill",
			to = 25,
			from = 1
		},
		drill_water = {
			prefix = "EarthquakeTower_drill_water",
			to = 27,
			from = 1
		},
		shootercrossbow_idleDown = {
			prefix = "CossbowHunter_shooter",
			to = 1,
			from = 1
		},
		shootercrossbow_idleUp = {
			prefix = "CossbowHunter_shooter",
			to = 17,
			from = 17
		},
		shootercrossbow_shootingDown = {
			prefix = "CossbowHunter_shooter",
			to = 16,
			from = 2
		},
		shootercrossbow_shootingUp = {
			prefix = "CossbowHunter_shooter",
			to = 33,
			from = 19
		},
		shootercrossbow_multishotStartDown = {
			prefix = "CossbowHunter_shooter",
			to = 44,
			from = 34
		},
		shootercrossbow_multishotLoopDown = {
			prefix = "CossbowHunter_shooter",
			to = 50,
			from = 45
		},
		shootercrossbow_multishotEndDown = {
			prefix = "CossbowHunter_shooter",
			to = 55,
			from = 51
		},
		shootercrossbow_multishotStartUp = {
			prefix = "CossbowHunter_shooter",
			to = 66,
			from = 56
		},
		shootercrossbow_multishotLoopUp = {
			prefix = "CossbowHunter_shooter",
			to = 72,
			from = 67
		},
		shootercrossbow_multishotEndUp = {
			prefix = "CossbowHunter_shooter",
			to = 77,
			from = 73
		},
		crossbow_eagle_idle = {
			prefix = "CossbowHunter_hawk",
			to = 1,
			from = 1
		},
		crossbow_eagle_fly = {
			prefix = "CossbowHunter_hawk",
			to = 148,
			from = 2
		},
		crossbow_eagle_buff_idle = {
			prefix = "CossbowHunter_towerBuff_Fx",
			to = 19,
			from = 1
		},
		shooterarchmage_idleDown = {
			prefix = "ArchMageGuy",
			to = 1,
			from = 1
		},
		shooterarchmage_idleUp = {
			prefix = "ArchMageGuy",
			to = 31,
			from = 31
		},
		shooterarchmage_shootingDown = {
			prefix = "ArchMageGuy",
			to = 30,
			from = 1
		},
		shooterarchmage_shootingUp = {
			prefix = "ArchMageGuy",
			to = 60,
			from = 31
		},
		shooterarchmage_twisterDown = {
			prefix = "ArchMageGuy",
			to = 89,
			from = 61
		},
		shooterarchmage_twisterUp = {
			prefix = "ArchMageGuy",
			to = 117,
			from = 90
		},
		shooterarchmage_multipleDown = {
			prefix = "ArchMageGuy",
			to = 147,
			from = 118
		},
		shooterarchmage_multipleUp = {
			prefix = "ArchMageGuy",
			to = 170,
			from = 148
		},
		bolt_archmage_idle = {
			prefix = "proy_archbolt",
			to = 15,
			from = 1
		},
		bolt_archmage_flying = {
			prefix = "proy_archbolt",
			to = 16,
			from = 16
		},
		bolt_archmage_hit = {
			prefix = "proy_archbolt",
			to = 25,
			from = 16
		},
		bolt_blast_hit = {
			prefix = "states_small",
			to = 96,
			from = 83
		},
		twister_start = {
			prefix = "ArchMageTwister",
			to = 8,
			from = 1
		},
		twister_travel = {
			prefix = "ArchMageTwister",
			to = 16,
			from = 9
		},
		twister_end = {
			prefix = "ArchMageTwister",
			to = 24,
			from = 17
		},
		enemy_bloodshell_idle = {
			prefix = "BloodShell",
			to = 51,
			from = 51
		},
		enemy_bloodshell_walkingRightLeft = {
			prefix = "BloodShell",
			to = 18,
			from = 1
		},
		enemy_bloodshell_walkingUp = {
			prefix = "BloodShell",
			to = 34,
			from = 19
		},
		enemy_bloodshell_walkingDown = {
			prefix = "BloodShell",
			to = 50,
			from = 35
		},
		enemy_bloodshell_attack = {
			prefix = "BloodShell",
			to = 79,
			from = 52
		},
		enemy_bloodshell_death = {
			prefix = "BloodShell",
			to = 97,
			from = 80
		},
		enemy_bloodshell_water_idle = {
			prefix = "BloodShell",
			to = 113,
			from = 98
		},
		enemy_bloodshell_water_walkingRightLeft = {
			prefix = "BloodShell",
			to = 113,
			from = 98
		},
		enemy_bloodshell_water_walkingUp = {
			prefix = "BloodShell",
			to = 113,
			from = 98
		},
		enemy_bloodshell_water_walkingDown = {
			prefix = "BloodShell",
			to = 113,
			from = 98
		},
		enemy_bloodshell_water_death = {
			prefix = "BloodShell",
			to = 137,
			from = 114
		},
		soldiermilitia2_idle = {
		prefix = "BloodShell",
		to = 51,
		from = 51
	},
	soldiermilitia2_running = {
		prefix = "BloodShell",
		to = 6,
		from = 2
	},
	soldiermilitia2_attack = {
		prefix = "BloodShell",
		to = 79,
		from = 52
	},
	soldiermilitia2_death = {
		prefix = "BloodShell",
		to = 97,
		from = 80
	},
	soldiermilitia111_idle = {
		prefix = "Soldier_WarHammer",
		to = 1,
		from = 1
	},
	soldiermilitia111_running = {
		prefix = "Soldier_WarHammer",
		to = 45,
		from = 2
	},
	soldiermilitia111_attack = {
		prefix = "Soldier_WarHammer",
		to = 103,
		from = 46
	},
	soldiermilitia111_death = {
		prefix = "Soldier_WarHammer",
		to = 138,
		from = 104
	},
	soldiermilitia111_healing = {
		prefix = "Soldier_WarHammer",
		to = 167,
		from = 139
	},
	soldiermilitia333_idle = {
		prefix = "Soldier_PotbelliedDemon",
		to = 49,
		from = 1
	},
	soldiermilitia333_running = {
		prefix = "Soldier_PotbelliedDemon",
		to = 49,
		from = 1
	},
	soldiermilitia333_attack = {
		prefix = "Soldier_PotbelliedDemon",
		to = 109,
		from = 60
	},
	soldiermilitia333_death = {
		prefix = "Soldier_PotbelliedDemon",
		to = 141,
		from = 110
	},
	soldiermilitia444_idle = {
		prefix = "Soldier_ArchImage",
		to = 1,
		from = 1
	},
	soldiermilitia444_running = {
		prefix = "Soldier_ArchImage",
		to = 28,
		from = 1
	},
	soldiermilitia444_attack = {
		prefix = "Soldier_ArchImage",
		to = 67,
		from = 29
	},
	soldiermilitia444_death = {
		prefix = "Soldier_ArchImage",
		to = 100,
		from = 70
	},
	soldiermilitia444_ranged = {
		prefix = "Soldier_ArchImage",
		to = 150,
		from = 101
	},
	soldiermilitia555_idle = {
		prefix = "Soldier_Monster",
			to = 1,
			from = 1
	},
	soldiermilitia555_running = {
		prefix = "Soldier_Monster",
			to = 39,
			from = 1
	},
	soldiermilitia555_attack = {
		prefix = "Soldier_Monster",
			to = 77,
			from = 40
	},
	soldiermilitia555_death = {
		prefix = "Soldier_Monster",
			to = 125,
			from = 78
	},
	soldiermilitia666_idle = {
		prefix = "soldier_tree",
		to = 1,
		from = 1
	},
	soldiermilitia666_running = {
		prefix = "soldier_tree",
		to = 76,
		from = 2
	},
	soldiermilitia666_attack = {
		prefix = "soldier_tree",
		to = 102,
		from = 73
	},
	soldiermilitia666_death = {
		prefix = "soldier_tree",
		to = 112,
		from = 103
	},
	SoldierBioLizard_idle = {
		prefix = "Soldier_BioLizard",
		to = 1,
		from = 1
	},
	SoldierBioLizard_running = {
		prefix = "Soldier_BioLizard",
		to = 29,
		from = 2
	},
	SoldierBioLizard_attack = {
		prefix = "Soldier_BioLizard",
		to = 66,
		from = 30
	},
	SoldierBioLizard_death = {
		prefix = "Soldier_BioLizard",
		to = 99,
		from = 67
	},
	soldiermilitia777_idle = {
		prefix = "Soldier_Gelf",
		to = 1,
		from = 1
	},
	soldiermilitia777_running = {
		prefix = "Soldier_Gelf",
		to = 20,
		from = 2
	},
	soldiermilitia777_attack = {
		prefix = "Soldier_Gelf",
		to = 36,
		from = 21
	},
	soldiermilitia777_death = {
		prefix = "Soldier_Gelf",
		to = 72,
		from = 53
	},
	soldiermilitia777_shoot = {
		prefix = "Soldier_Gelf",
		to = 52,
		from = 37
	},
	soldiermilitia888_idle = {
		prefix = "Soldier_FlareBomber",
		to = 1,
		from = 1
	},
	soldiermilitia888_running = {
		prefix = "Soldier_FlareBomber",
		to = 30,
		from = 2
	},
	soldiermilitia888_attack = {
		prefix = "Soldier_FlareBomber",
		to = 56,
		from = 31
	},
	soldiermilitia888_death = {
		prefix = "Soldier_FlareBomber",
		to = 125,
		from = 103
	},
	soldiermilitia888_shoot = {
		prefix = "Soldier_FlareBomber",
		to = 102,
		from = 57
	},
	soldiermilitia999_idle = {
		prefix = "soldier_bloodsucker",
		to = 1,
		from = 1
	},
	soldiermilitia999_running = {
		prefix = "soldier_bloodsucker",
		to = 13,
		from = 2
	},
	soldiermilitia999_attack = {
		prefix = "soldier_bloodsucker",
		to = 39,
		from = 14
	},
	soldiermilitia999_attack2 = {
		prefix = "soldier_bloodsucker",
		to = 80,
		from = 53
	},
	soldiermilitia999_death = {
		prefix = "soldier_bloodsucker",
		to = 52,
		from = 44
	},
	soldiermilitia999_raise = {
		prefix = "soldier_bloodsucker",
		to = 44,
		from = 52
	},
			tower_frankenstein_l2_idle = {
			prefix = "HalloweenTesla_layer2",
			to = 1,
			from = 1
		},
		tower_frankenstein_l3_idle = {
			prefix = "HalloweenTesla_layer3",
			to = 1,
			from = 1
		},
		tower_frankenstein_l4_idle = {
			prefix = "HalloweenTesla_layer4",
			to = 1,
			from = 1
		},
		tower_frankenstein_l5_idle = {
			prefix = "HalloweenTesla_layer5",
			to = 1,
			from = 1
		},
		tower_frankenstein_l2_shoot = {
			prefix = "HalloweenTesla_layer2",
			to = 43,
			from = 1
		},
		tower_frankenstein_l3_shoot = {
			prefix = "HalloweenTesla_layer3",
			to = 43,
			from = 1
		},
		tower_frankenstein_l4_shoot = {
			prefix = "HalloweenTesla_layer4",
			to = 43,
			from = 1
		},
		tower_frankenstein_l5_shoot = {
			prefix = "HalloweenTesla_layer5",
			to = 43,
			from = 1
		},
		tower_frankenstein_charge_l1_idle = {
			to = 42,
			from = 1,
			prefix = "HalloweenTesla_chargeLoop_layer1",
			post = {
				1
			}
		},
		tower_frankenstein_charge_l2_idle = {
			to = 42,
			from = 1,
			prefix = "HalloweenTesla_chargeLoop_layer2",
			post = {
				1
			}
		},
		tower_frankenstein_drcrazy_idle = {
			prefix = "HalloweenTesla_DrCrazy_layer1",
			to = 26,
			from = 1
		},
		tower_frankenstein_helmet_l1_idle = {
			prefix = "HalloweenTesla_Frankie_layer1",
			to = 1,
			from = 1
		},
		tower_frankenstein_helmet_l1_release = {
			prefix = "HalloweenTesla_Frankie_layer1",
			to = 90,
			from = 1
		},
		tower_frankenstein_helmet_l2_idle = {
			prefix = "HalloweenTesla_Frankie_layer2",
			to = 1,
			from = 1
		},
		tower_frankenstein_helmet_l2_release = {
			prefix = "HalloweenTesla_Frankie_layer2",
			to = 90,
			from = 1
		},
		ray_frankenstein = {
			prefix = "HalloweenTesla_ray",
			to = 13,
			from = 1
		},
		ray_frankenstein_fx = {
			prefix = "TowerHalloween_lightning_hit",
			to = 18,
			from = 1
		},
		soldier_frankie_lvl1_idle = {
			prefix = "Halloween_Frankie_lvl1",
			to = 51,
			from = 51
		},
		soldier_frankie_lvl1_running = {
			prefix = "Halloween_Frankie_lvl1",
			to = 22,
			from = 1
		},
		soldier_frankie_lvl1_attack = {
			prefix = "Halloween_Frankie_lvl1",
			to = 51,
			from = 23
		},
		soldier_frankie_lvl1_raise = {
			prefix = "Halloween_Frankie_lvl1",
			to = 114,
			from = 82
		},
		soldier_frankie_lvl1_death = {
			prefix = "Halloween_Frankie_lvl1",
			to = 81,
			from = 52
		},
		soldier_frankie_lvl2_idle = {
			prefix = "Halloween_Frankie_lvl2",
			to = 51,
			from = 51
		},
		soldier_frankie_lvl2_running = {
			prefix = "Halloween_Frankie_lvl2",
			to = 22,
			from = 1
		},
		soldier_frankie_lvl2_attack = {
			prefix = "Halloween_Frankie_lvl2",
			to = 51,
			from = 23
		},
		soldier_frankie_lvl2_raise = {
			prefix = "Halloween_Frankie_lvl2",
			to = 114,
			from = 82
		},
		soldier_frankie_lvl2_death = {
			prefix = "Halloween_Frankie_lvl2",
			to = 81,
			from = 52
		},
		soldier_frankie_lvl3_idle = {
			prefix = "Halloween_Frankie_lvl3",
			to = 51,
			from = 51
		},
		soldier_frankie_lvl3_running = {
			prefix = "Halloween_Frankie_lvl3",
			to = 22,
			from = 1
		},
		soldier_frankie_lvl3_attack = {
			prefix = "Halloween_Frankie_lvl3",
			to = 51,
			from = 23
		},
		soldier_frankie_lvl3_raise = {
			prefix = "Halloween_Frankie_lvl3",
			to = 157,
			from = 125
		},
		soldier_frankie_lvl3_death = {
			prefix = "Halloween_Frankie_lvl3",
			to = 124,
			from = 95
		},
		soldier_frankie_lvl3_pound = {
			prefix = "Halloween_Frankie_lvl3",
			to = 94,
			from = 52
		},
		frankie_punch_decal = {
			prefix = "Halloween_Frankie_PunchDecal",
			to = 13,
			from = 1
		},
		frankie_punch_fx = {
			prefix = "Halloween_Frankie_PunchFx",
			to = 20,
			from = 1
		},
					towerbarrackdwarf_door_open = {
			prefix = "DwarfHall",
			to = 4,
			from = 1
		},
		towerbarrackdwarf_door_close = {
			prefix = "DwarfHall",
			to = 7,
			from = 4
		},
		soldierdwarf_idle = {
			prefix = "DwarfWarrior",
			to = 1,
			from = 1
		},
		soldierdwarf_running = {
			prefix = "DwarfWarrior",
			to = 6,
			from = 2
		},
		soldierdwarf_attack = {
			prefix = "DwarfWarrior",
			to = 21,
			from = 7
		},
		soldierdwarf_beer = {
			prefix = "DwarfWarrior",
			to = 55,
			from = 22
		},
		soldierdwarf_death = {
			prefix = "DwarfWarrior",
			to = 64,
			from = 56
		},
		dwarf_beer_aura = {
			prefix = "DwarfWarrior_Aura",
			to = 30,
			from = 1
		},
		dwarf_beer_bubbles = {
			prefix = "DwarfWarrior_Bubbles",
			to = 22,
			from = 1
		},
		shooterarcherdwarf_idleDown = {
			prefix = "DwarfShooter",
			to = 1,
			from = 1
		},
		shooterarcherdwarf_idleUp = {
			prefix = "DwarfShooter",
			to = 1,
			from = 1
		},
		shooterarcherdwarf_shootingDown = {
			prefix = "DwarfShooter",
			to = 26,
			from = 2
		},
		shooterarcherdwarf_shootingUp = {
			prefix = "DwarfShooter",
			to = 52,
			from = 28
		},
		shooterarcherdwarf_shootBarrelDown = {
			prefix = "DwarfShooter",
			to = 86,
			from = 54
		},
		shooterarcherdwarf_shootBarrelUp = {
			prefix = "DwarfShooter",
			to = 120,
			from = 87
		},
		fx_rifle_smoke = {
			prefix = "fx_rifle_smoke",
			to = 11,
			from = 1
		},
		hero_dwarf_idle = {
			prefix = "BloodShell",
			to = 51,
			from = 51
		},
		hero_dwarf_running = {
			prefix = "BloodShell",
			to = 6,
			from = 2
		},
		hero_dwarf_attack = {
			prefix = "BloodShell",
			to = 79,
			from = 52
		},
		hero_dwarf_attack2 = {
			prefix = "BloodShell",
			to = 79,
			from = 52
		},
		hero_dwarf_death = {
			prefix = "BloodShell",
			to = 97,
			from = 80
		},
		hero_dwarf_respawn = {
			prefix = "BloodShell",
			to = 88,
			from = 72
		},
		hero_dwarf_levelup = {
			prefix = "BloodShell",
			to = 88,
			from = 72
		},
		hero_dwarf2_idle = {
			prefix = "Pillager",
			to = 79,
			from = 79
		},
		hero_dwarf2_running = {
			prefix = "Pillager",
			to = 26,
			from = 1
		},
		hero_dwarf2_attack = {
			prefix = "Pillager",
			to = 103,
			from = 80
		},
		hero_dwarf2_attack2 = {
			prefix = "Pillager",
			to = 103,
			from = 80
		},
		hero_dwarf2_death = {
			prefix = "Pillager",
			to = 144,
			from = 127
		},
		hero_dwarf2_respawn = {
			prefix = "Pillager",
			to = 88,
			from = 72
		},
		hero_dwarf2_levelup = {
			prefix = "Pillager",
			to = 88,
			from = 72
		},
		hero_dwarf2_idle = {
			prefix = "Pillager",
			to = 79,
			from = 79
		},
		hero_dwarf2_running = {
			prefix = "Pillager",
			to = 26,
			from = 1
		},
		hero_dwarf2_attack = {
			prefix = "Pillager",
			to = 103,
			from = 80
		},
		hero_dwarf2_attack2 = {
			prefix = "Pillager",
			to = 103,
			from = 80
		},
		hero_dwarf2_death = {
			prefix = "Pillager",
			to = 144,
			from = 127
		},
		hero_dwarf2_respawn = {
			prefix = "Pillager",
			to = 88,
			from = 72
		},
		hero_dwarf2_levelup = {
			prefix = "Pillager",
			to = 88,
			from = 72
		},
		hero_dwarf3_idle = {
			prefix = "boss_veznan",
			to = 85,
			from = 85
		},
		hero_dwarf3_running = {
			prefix = "boss_veznan",
			to = 28,
			from = 1
		},
		hero_dwarf3_attack = {
			prefix = "boss_veznan",
			to = 124,
			from = 87
		},
		hero_dwarf3_attack2 = {
			prefix = "boss_veznan",
			to = 124,
			from = 87
		},
		hero_dwarf3_death = {
			prefix = "boss_veznan",
			to = 536,
			from = 386
		},
		hero_dwarf3_respawn = {
			prefix = "boss_veznan",
			to = 88,
			from = 72
		},
		hero_dwarf3_levelup = {
			prefix = "boss_veznan",
			to = 88,
			from = 72
		},
		hero_dwarf514_idle = {
			prefix = "NecromancerDeathKnight",
			to = 1,
			from = 1
		},
		hero_dwarf514_running = {
			prefix = "NecromancerDeathKnight",
			to = 6,
			from = 2
		},
		hero_dwarf514_attack = {
			to = 24,
			from = 7,
			prefix = "NecromancerDeathKnight",
			post = {
			1
			}
		},
		hero_dwarf514_attack2 = {
			to = 24,
			from = 7,
			prefix = "NecromancerDeathKnight",
			post = {
			1
			}
		},
		hero_dwarf514_death = {
			prefix = "NecromancerDeathKnight",
			to = 48,
			from = 64
		},
		hero_dwarf514_respawn = {
			prefix = "NecromancerDeathKnight",
			to = 47,
			from = 25
		},
		hero_dwarf514_levelup = {
			prefix = "NecromancerDeathKnight",
			to = 47,
			from = 25
		},
		silence_small = {
			prefix = "silence_small",
			to = 9,
			from = 1
		},
		silence_big = {
			prefix = "silence_big",
			to = 9,
			from = 1
		},
		weakness_small = {
			prefix = "weakness_small",
			to = 11,
			from = 1
		},
		weakness_big = {
			prefix = "weakness_big",
			to = 11,
			from = 1
		},
		shootertotem_idleDown = {
			prefix = "TotemTower_Shooter",
			to = 1,
			from = 1
		},
		shootertotem_idleUp = {
			prefix = "TotemTower_Shooter",
			to = 23,
			from = 23
		},
		shootertotem_shootingDown = {
			prefix = "TotemTower_Shooter",
			to = 22,
			from = 2
		},
		shootertotem_shootingUp = {
			prefix = "TotemTower_Shooter",
			to = 44,
			from = 24
		},
		totem_eyes_upper = {
			prefix = "TotemTower_EyesUp",
			to = 26,
			from = 1
		},
		totem_eyes_lower = {
			prefix = "TotemTower_EyesDown",
			to = 26,
			from = 1
		},
		totem_fire = {
			prefix = "TotemTower-Fire",
			to = 12,
			from = 1
		},
		totem_red_start = {
			prefix = "TotemTower_RedTotem",
			to = 10,
			from = 1
		},
		totem_red_end = {
			prefix = "TotemTower_RedTotem",
			to = 29,
			from = 11
		},
		totem_violet_start = {
			prefix = "TotemTower_VioletTotem",
			to = 10,
			from = 1
		},
		totem_violet_end = {
			prefix = "TotemTower_VioletTotem",
			to = 29,
			from = 11
		},
		totem_water_fx_enter = {
			prefix = "TotemTower_Totem_waterFx",
			to = 14,
			from = 1
		},
		totem_water_fx_exit = {
			prefix = "TotemTower_Totem_waterFx",
			to = 28,
			from = 15
		},
		soldier_gryphon_guard_idle = {
		prefix = "tower_archer_ranger_shooter",
		to = 1,
		from = 1
	},
	soldier_gryphon_guard_running = {
		prefix = "tower_archer_ranger_shooter",
		to = 6,
		from = 2
	},
	soldier_gryphon_guard_shoot = {
		prefix = "tower_archer_ranger_shooter",
		to = 10,
		from = 3
	},
	soldier_gryphon_guard888_idle = {
		prefix = "tower_archer_druid",
		to = 1,
		from = 1
	},
	soldier_gryphon_guard888_running = {
		prefix = "tower_archer_ranger_shooter",
		to = 6,
		from = 2
	},
	soldier_gryphon_guard888_shoot = {
		prefix = "tower_archer_druid",
		to = 41,
		from = 1
	},
	soldier_gryphon_guard514_idle = {
		prefix = "mage_lvl3",
		to = 1,
		from = 1
	},
	soldier_gryphon_guard514_running = {
		prefix = "tower_archer_ranger_shooter",
		to = 6,
		from = 2
	},
	soldier_gryphon_guard514_shoot = {
		prefix = "tower_archer_druid",
		to = 41,
		from = 1
	},
	soldier_gryphon_guard2_idle = {
		prefix = "arcane_shooter",
		to = 1,
		from = 1
	},
	soldier_gryphon_guard2_running = {
		prefix = "arcane_shooter",
		to = 6,
		from = 2
	},
	soldier_gryphon_guard2_shoot = {
		to = 36,
		from = 3,
		prefix = "arcane_shooter",
		post = {
			1
		}
	},
	hero_priest_idle = {
			prefix = "hero_priest",
			to = 24,
			from = 1
		},
		hero_priest_running = {
			prefix = "hero_priest",
			to = 29,
			from = 25
		},
		hero_priest_attack = {
			prefix = "hero_priest",
			to = 51,
			from = 30
		},
		hero_priest_holylight = {
			prefix = "hero_priest",
			to = 82,
			from = 52
		},
		hero_priest_death = {
			prefix = "hero_priest",
			to = 90,
			from = 83
		},
		hero_priest_consecrate = {
			prefix = "hero_priest",
			to = 121,
			from = 91
		},
		hero_priest_teleport_out = {
			prefix = "hero_priest",
			to = 146,
			from = 122
		},
		hero_priest_teleport_in = {
			prefix = "hero_priest",
			to = 167,
			from = 147
		},
		hero_priest_respawn = {
			prefix = "hero_priest",
			to = 167,
			from = 147
		},
		hero_priest_shoot = {
			prefix = "hero_priest",
			to = 193,
			from = 168
		},
		hero_priest_levelup = {
			prefix = "hero_priest",
			to = 209,
			from = 193
		},
		bolt_priest_idle = {
			prefix = "hero_priest_bolt",
			to = 2,
			from = 1
		},
		bolt_priest_flying = {
			prefix = "hero_priest_bolt",
			to = 2,
			from = 1
		},
		bolt_priest_hit = {
			prefix = "hero_priest_bolt",
			to = 10,
			from = 3
		},
		fx_priest_heal = {
			prefix = "hero_priest_healFx",
			to = 25,
			from = 1
		},
		fx_priest_revive = {
			prefix = "hero_priest_revive",
			to = 17,
			from = 1
		},
		decal_priest_armor = {
			prefix = "hero_barracks_buff",
			to = 28,
			from = 1
		},
		fx_priest_armor = {
			prefix = "hero_priest_shieldFx",
			to = 20,
			from = 1
		},
		decal_priest_consecrate = {
			prefix = "hero_priest_swords",
			to = 24,
			from = 1
		},
		decal_tusken_idle = {
			prefix = "tower_archer_musketeer_shooter",
			to = 1,
			from = 1
		},
		decal_tusken_shoot = {
			to = 26,
		from = 1,
		prefix = "tower_archer_musketeer_shooter",
		post = {
			1
		}
		},
		soldier_gryphon_guard666_idle = {
		prefix = "mage_shooter",
		to = 1,
		from = 1
	},
	soldier_gryphon_guard666_running = {
		prefix = "mage_lvl3",
		to = 6,
		from = 2
	},
	soldier_gryphon_guard666_shoot = {
		prefix = "mage_shooter",
		to = 15,
		from = 3
	},
	soldier_gryphon_guard333_idle = {
		prefix = "rotten_thing",
		to = 196,
		from = 196
	},
	soldier_gryphon_guard333_running = {
		prefix = "rotten_thing",
		to = 196,
		from = 2
	},
	soldier_gryphon_guard333_shoot = {
		to = 127,
		from = 102,
		prefix = "rotten_thing",
		post = {
			127
		}
	},
	hero_beastmaster_idle = {
			prefix = "Redspine",
			to = 73,
			from = 73
		},
		hero_beastmaster_running = {
			prefix = "Redspine",
			to = 24,
			from = 1
		},
		hero_beastmaster_attack = {
			prefix = "Redspine",
			to = 94,
			from = 74
		},
		hero_beastmaster_rangedAttack = {
			prefix = "Redspine",
			to = 113,
			from = 95
		},
		hero_beastmaster_lash = {
			prefix = "Redspine",
			to = 59,
			from = 32
		},
		hero_beastmaster_pets = {
			prefix = "Redspine",
			to = 113,
			from = 95
		},
		hero_beastmaster_stampede = {
			prefix = "Redspine",
			to = 113,
			from = 106
		},
		hero_beastmaster_respawn = {
			prefix = "Redspine",
			to = 163,
			from = 150
		},
		hero_beastmaster_levelup = {
			prefix = "Redspine",
			to = 163,
			from = 150
		},
		hero_beastmaster_death = {
			prefix = "Redspine",
			to = 175,
			from = 164
		},
		beastmaster_boar_idle = {
			prefix = "GreenfinArmor",
			to = 67,
			from = 67
		},
		beastmaster_boar_running = {
			prefix = "GreenfinArmor",
			to = 22,
			from = 1
		},
		beastmaster_boar_attack = {
			prefix = "GreenfinArmor",
			to = 76,
			from = 68
		},
		beastmaster_boar_death = {
			prefix = "GreenfinArmor",
			to = 85,
			from = 77
		},
		beastmaster_boar_netAttack = {
			prefix = "GreenfinArmor",
			to = 106,
			from = 86
		},
		beastmaster_boar_spawn = {
			prefix = "GreenfinArmor",
			to = 43,
			from = 25
		},
		decal_falcon_idle = {
			prefix = "Redspine",
			to = 73,
			from = 73
		},
		decal_falcon_attack_fly = {
			prefix = "Redspine",
			to = 24,
			from = 1
		},
		decal_falcon_attack_hit = {
			prefix = "Redspine",
			to = 113,
			from = 95
		},
		decal_falcon_respawn = {
			prefix = "Redspine",
			to = 48,
			from = 25
		},
		decal_falcon_death = {
			prefix = "Redspine",
			to = 113,
			from = 95
		},
		decal_rhino_walkingRightLeft = {
			prefix = "hero_beastMaster_Rhyno",
			to = 11,
			from = 1
		},
		decal_rhino_walkingUp = {
			prefix = "hero_beastMaster_Rhyno",
			to = 22,
			from = 12
		},
		decal_rhino_walkingDown = {
			prefix = "hero_beastMaster_Rhyno",
			to = 33,
			from = 23
		},
		greenfin_net_small_start = {
			prefix = "GreenfinNets",
			to = 9,
			from = 1
		},
		greenfin_net_small_loop = {
			prefix = "GreenfinNets",
			to = 10,
			from = 10
		},
		greenfin_net_small_end = {
			prefix = "GreenfinNets",
			to = 16,
			from = 11
		},
		greenfin_net_big_start = {
			prefix = "GreenfinNetsBig",
			to = 9,
			from = 1
		},
		greenfin_net_big_loop = {
			prefix = "GreenfinNetsBig",
			to = 10,
			from = 10
		},
		greenfin_net_big_end = {
			prefix = "GreenfinNetsBig",
			to = 16,
			from = 11
		},
		babyAshbite_idle = {
		prefix = "babyAshbite",
		to = 18,
		from = 1
	},
	babyAshbite_death = {
		prefix = "babyAshbite",
		to = 63,
		from = 47
	},
	babyAshbite_respawn = {
		prefix = "babyAshbite",
		to = 84,
		from = 65
	},
	babyAshbite_hatch = {
		prefix = "babyAshbite",
		to = 98,
		from = 85
	},
	babyAshbite_shoot = {
		prefix = "babyAshbite",
		to = 46,
		from = 19
	},
	babyAshbite_special = {
		prefix = "babyAshbite",
		to = 145,
		from = 100
	},
	babyAshbite_specialFireGlow = {
		prefix = "babyAshbite",
		to = 191,
		from = 146
	},
	fireball_baby_ashbite = {
		prefix = "babyAshbite_proy",
		to = 10,
		from = 1
	},
	fx_fireball_baby_ashbite_hit = {
		prefix = "babyAshbite_proyHit",
		to = 15,
		from = 1
	},
	fx_fireball_baby_ashbite_hit_air = {
		prefix = "babyAshbite_proyHitAir",
		to = 14,
		from = 1
	},
	baby_ashbite_breath_particle = {
		prefix = "babyAshbite_specialFire_particle",
		to = 6,
		from = 1
	},
	baby_ashbite_breath_fire = {
		prefix = "babyAshbite_specialFire_fire",
		to = 18,
		from = 1
	},
	baby_ashbite_breath_fire_decal = {
		prefix = "babyAshbite_fireDecal",
		to = 32,
		from = 1
	},
	baby_ashbite_fierymist_particle = {
		prefix = "babyAshbite_smokeParticle",
		to = 10,
		from = 1
	},
	baby_ashbite_fierymist_decal = {
		prefix = "babyAshbite_smokeDecal",
		to = 27,
		from = 1
	},
	towerassassin_door_open = {
			prefix = "tower_assasins_layer2",
			to = 5,
			from = 1
		},
		towerassassin_door_close = {
			prefix = "tower_assasins_layer2",
			to = 25,
			from = 22
		},
		soldierassassin_idle = {
			prefix = "Soldier_Assassin",
			to = 1,
			from = 1
		},
		soldierassassin_running = {
			prefix = "Soldier_Assassin",
			to = 6,
			from = 2
		},
		soldierassassin_attack = {
			to = 18,
			from = 7,
			prefix = "Soldier_Assassin",
			post = {
				1
			}
		},
		soldierassassin_death = {
			prefix = "Soldier_Assassin",
			to = 79,
			from = 70
		},
		soldierassassin_sneak = {
			prefix = "Soldier_Assassin",
			to = 43,
			from = 19
		},
		soldierassassin_dodge = {
			prefix = "Soldier_Assassin",
			to = 54,
			from = 44
		},
		soldierassassin_counter = {
			prefix = "Soldier_Assassin",
			to = 69,
			from = 55
		},
		towertemplar_door_open = {
			prefix = "tower_templars_layer2",
			to = 5,
			from = 1
		},
		towertemplar_door_close = {
			prefix = "tower_templars_layer2",
			to = 25,
			from = 22
		},
		towertemplar_fire_idle = {
			prefix = "TemplarTower_Fire",
			to = 12,
			from = 1
		},
		soldiertemplar_idle = {
			prefix = "Templar",
			to = 1,
			from = 1
		},
		soldiertemplar_idle2 = {
			prefix = "Templar",
			to = 2,
			from = 2
		},
		soldiertemplar_running = {
			prefix = "Templar",
			to = 8,
			from = 3
		},
		soldiertemplar_attack = {
			prefix = "Templar",
			to = 35,
			from = 9
		},
		soldiertemplar_attack_wait = {
			prefix = "Templar",
			to = 35,
			from = 35
		},
		soldiertemplar_death = {
			prefix = "Templar",
			to = 103,
			from = 96
		},
		soldiertemplar_holygrail = {
			prefix = "Templar",
			to = 64,
			from = 37
		},
		soldiertemplar_blood = {
			prefix = "Templar",
			to = 96,
			from = 65
		},
		hero_wilbur_layerX_idle = {
		layer_to = 4,
		from = 1,
		layer_prefix = "hero_wilburg_layer%i",
		to = 12,
		layer_from = 1
	},
	hero_wilbur_layerX_projectile = {
		layer_to = 4,
		from = 13,
		layer_prefix = "hero_wilburg_layer%i",
		to = 28,
		layer_from = 1
	},
	hero_wilbur_layerX_shoot = {
		layer_to = 4,
		from = 45,
		layer_prefix = "hero_wilburg_layer%i",
		to = 56,
		layer_from = 1
	},
	hero_wilbur_layerX_smokeStart = {
		layer_to = 4,
		from = 57,
		layer_prefix = "hero_wilburg_layer%i",
		to = 80,
		layer_from = 1
	},
	hero_wilbur_layerX_smokeLoop = {
		layer_to = 4,
		from = 81,
		layer_prefix = "hero_wilburg_layer%i",
		to = 89,
		layer_from = 1
	},
	hero_wilbur_layerX_smokeEnd = {
		layer_to = 4,
		from = 90,
		layer_prefix = "hero_wilburg_layer%i",
		to = 95,
		layer_from = 1
	},
	hero_wilbur_layerX_box = {
		layer_to = 4,
		from = 96,
		layer_prefix = "hero_wilburg_layer%i",
		to = 129,
		layer_from = 1
	},
	hero_wilbur_layerX_death = {
		layer_to = 4,
		from = 130,
		layer_prefix = "hero_wilburg_layer%i",
		to = 159,
		layer_from = 1
	},
	hero_wilbur_layerX_respawn = {
		layer_to = 4,
		from = 160,
		layer_prefix = "hero_wilburg_layer%i",
		to = 181,
		layer_from = 1
	},
	fx_shot_wilbur_flash = {
		prefix = "hero_wilburg_flash_shoot",
		to = 6,
		from = 1
	},
	fx_shot_wilbur_hit = {
		prefix = "hero_wilburg_shoot_floor",
		to = 12,
		from = 1
	},
	missile_wilbur_flying = {
		prefix = "hero_wilburg_missile",
		to = 3,
		from = 1
	},
	fx_wilbur_smoke_start = {
		prefix = "hero_wilburg_smoke",
		to = 12,
		from = 1
	},
	decal_wilbur_smoke = {
		prefix = "hero_wilburg_bomb_decal",
		to = 27,
		from = 1
	},
	box_wilbur_open = {
		prefix = "hero_wilburg_box_hit",
		to = 13,
		from = 1
	},
	fx_box_wilbur_smoke_a = {
		prefix = "hero_wilburg_box_hit_smoke_a",
		to = 11,
		from = 1
	},
	fx_box_wilbur_smoke_b = {
		prefix = "hero_wilburg_box_hit_smoke_b",
		to = 8,
		from = 1
	},
	bomb_wilbur_idle = {
		prefix = "hero_wilburg_bomb_box",
		to = 1,
		from = 1
	},
	bomb_wilbur_walkingRightLeft = {
		prefix = "hero_wilburg_bomb_box",
		to = 9,
		from = 1
	},
	bomb_wilbur_walkingUp = {
		prefix = "hero_wilburg_bomb_box",
		to = 18,
		from = 10
	},
	bomb_wilbur_walkingDown = {
		prefix = "hero_wilburg_bomb_box",
		to = 27,
		from = 19
	},
	bomb_wilbur_death = {
		prefix = "hero_wilburg_bomb_box",
		to = 48,
		from = 28
	},
	wilbur_drone_idle = {
		prefix = "hero_wilburg_drones",
		to = 14,
		from = 1
	},
	wilbur_drone_shoot = {
		prefix = "hero_wilburg_drones",
		to = 29,
		from = 15
	},
	ray_bluegale = {
			prefix = "Bluegale_ray",
			to = 16,
			from = 1
		},
		hero_giant_idle = {
			prefix = "hero_giant",
			to = 1,
			from = 1
		},
		hero_giant_running = {
			prefix = "hero_giant",
			to = 25,
			from = 2
		},
		hero_giant_attack = {
			prefix = "hero_giant",
			to = 42,
			from = 26
		},
		hero_giant_death = {
			prefix = "hero_giant",
			to = 130,
			from = 118
		},
		hero_giant_respawn = {
			prefix = "hero_giant",
			to = 146,
			from = 132
		},
		hero_giant_levelup = {
			prefix = "hero_giant",
			to = 146,
			from = 132
		},
		hero_giant_ranged = {
			prefix = "hero_giant",
			to = 99,
			from = 69
		},
		hero_giant_stomp = {
			prefix = "hero_giant",
			to = 116,
			from = 100
		},
		hero_giant_massive = {
			prefix = "hero_giant",
			to = 67,
			from = 43
		},
		hero_giant_death_remains = {
			prefix = "hero_giant",
			to = 131,
			from = 131
		},
		hero_giant_death_rocks = {
			prefix = "hero_giant",
			to = 162,
			from = 148
		},
		giant_bastion_decal = {
			prefix = "hero_giant_decal",
			to = 21,
			from = 1
		},
		giant_ice_small = {
			prefix = "hero_giant_ice_small",
			to = 12,
			from = 1
		},
		giant_ice_big = {
			prefix = "hero_giant_ice_big",
			to = 12,
			from = 1
		},
		giant_boulder_explosion = {
			prefix = "hero_giant_proy",
			to = 15,
			from = 2
		},
		giant_stomp_stones = {
			prefix = "hero_giant_stones",
			to = 15,
			from = 2
		},
		hero_alien_idle = {
			prefix = "hero_alien",
			to = 1,
			from = 1
		},
		hero_alien_running = {
			prefix = "hero_alien",
			to = 6,
			from = 2
		},
		hero_alien_attack = {
			prefix = "hero_alien",
			to = 32,
			from = 7
		},
		hero_alien_shoot = {
			prefix = "hero_alien",
			to = 61,
			from = 33
		},
		hero_alien_purification = {
			prefix = "hero_alien",
			to = 104,
			from = 62
		},
		hero_alien_abduction = {
			prefix = "hero_alien",
			to = 138,
			from = 105
		},
		hero_alien_selfdestruct = {
			prefix = "hero_alien",
			to = 203,
			from = 138
		},
		hero_alien_death = {
			prefix = "hero_alien",
			to = 215,
			from = 204
		},
		hero_alien_respawn = {
			prefix = "hero_alien",
			to = 232,
			from = 216
		},
		hero_alien_levelup = {
			prefix = "hero_alien",
			to = 232,
			from = 216
		},
		alien_glaive = {
			prefix = "hero_alien_proy",
			to = 8,
			from = 1
		},
		alien_glaive_hit = {
			prefix = "hero_alien_proyHit",
			to = 7,
			from = 1
		},
		alien_glaive_trail = {
			prefix = "hero_alien_proyParticle",
			to = 12,
			from = 1
		},
		alien_abduction_ship_beam = {
			prefix = "hero_alien_motherShip_Attack",
			to = 35,
			from = 1
		},
		alien_abduction_ship_lightning_1 = {
			prefix = "hero_alien_motherShip_Lightening",
			to = 12,
			from = 1
		},
		alien_abduction_ship_lightning_2 = {
			prefix = "hero_alien_motherShip_Lightening2",
			to = 12,
			from = 1
		},
		alien_drone_appear_long = {
			prefix = "hero_alien_ship",
			to = 16,
			from = 1
		},
		alien_drone_appear_short = {
			prefix = "hero_alien_ship",
			to = 16,
			from = 13
		},
		alien_drone_idle = {
			prefix = "hero_alien_ship",
			to = 30,
			from = 17
		},
		alien_drone_disappear_long = {
			prefix = "hero_alien_ship",
			to = 46,
			from = 31
		},
		alien_drone_disappear_short = {
			prefix = "hero_alien_ship",
			to = 34,
			from = 31
		},
		alien_drone_attack_beam = {
			prefix = "hero_alien_shipAttack",
			to = 8,
			from = 1
		},
		alien_drone_attack_decal = {
			prefix = "hero_alien_shipAttackDecal",
			to = 12,
			from = 1
		},
		hero_vanhelsing_idle = {
			prefix = "Halloween_hero_vhelsing",
			to = 1,
			from = 1
		},
		hero_vanhelsing_running = {
			prefix = "Halloween_hero_vhelsing",
			to = 5,
			from = 2
		},
		hero_vanhelsing_attack = {
			prefix = "Halloween_hero_vhelsing",
			to = 91,
			from = 71
		},
		hero_vanhelsing_death = {
			prefix = "Halloween_hero_vhelsing",
			to = 631,
			from = 623
		},
		hero_vanhelsing_respawn = {
			prefix = "Halloween_hero_vhelsing",
			to = 622,
			from = 603
		},
		hero_vanhelsing_levelup = {
			prefix = "Halloween_hero_vhelsing",
			to = 622,
			from = 603
		},
		hero_vanhelsing_ghost_start = {
			prefix = "Halloween_hero_vhelsing",
			to = 570,
			from = 555
		},
		hero_vanhelsing_ghost_running = {
			prefix = "Halloween_hero_vhelsing",
			to = 602,
			from = 571
		},
		hero_vanhelsing_ghost_idle = {
			prefix = "Halloween_hero_vhelsing",
			to = 602,
			from = 571
		},
		hero_vanhelsing_grenade = {
			prefix = "Halloween_hero_vhelsing",
			to = 510,
			from = 483
		},
		hero_vanhelsing_relic = {
			prefix = "Halloween_hero_vhelsing",
			to = 554,
			from = 511
		},
		hero_vanhelsing_ranged_side = {
			prefix = "Halloween_hero_vhelsing",
			to = 26,
			from = 6
		},
		hero_vanhelsing_ranged_down = {
			prefix = "Halloween_hero_vhelsing",
			to = 48,
			from = 27
		},
		hero_vanhelsing_ranged_up = {
			prefix = "Halloween_hero_vhelsing",
			to = 70,
			from = 49
		},
		hero_vanhelsing_silver_side = {
			prefix = "Halloween_hero_vhelsing",
			to = 365,
			from = 307
		},
		hero_vanhelsing_silver_down = {
			prefix = "Halloween_hero_vhelsing",
			to = 423,
			from = 366
		},
		hero_vanhelsing_silver_up = {
			prefix = "Halloween_hero_vhelsing",
			to = 482,
			from = 424
		},
		hero_vanhelsing_multi_start_side = {
			prefix = "Halloween_hero_vhelsing",
			to = 129,
			from = 92
		},
		hero_vanhelsing_multi_loop_side = {
			prefix = "Halloween_hero_vhelsing",
			to = 140,
			from = 130
		},
		hero_vanhelsing_multi_end_side = {
			prefix = "Halloween_hero_vhelsing",
			to = 164,
			from = 141
		},
		hero_vanhelsing_multi_start_up = {
			prefix = "Halloween_hero_vhelsing",
			to = 272,
			from = 236
		},
		hero_vanhelsing_multi_loop_up = {
			prefix = "Halloween_hero_vhelsing",
			to = 282,
			from = 273
		},
		hero_vanhelsing_multi_end_up = {
			prefix = "Halloween_hero_vhelsing",
			to = 306,
			from = 289
		},
		hero_vanhelsing_multi_start_down = {
			prefix = "Halloween_hero_vhelsing",
			to = 200,
			from = 165
		},
		hero_vanhelsing_multi_loop_down = {
			prefix = "Halloween_hero_vhelsing",
			to = 211,
			from = 201
		},
		hero_vanhelsing_multi_end_down = {
			prefix = "Halloween_hero_vhelsing",
			to = 235,
			from = 212
		},
		vanhelsing_crosshair = {
			prefix = "Halloween_hero_vhelsing_sniper",
			to = 16,
			from = 1
		},
		vanhelsing_grenade_explosion = {
			prefix = "Halloween_hero_vhelsing_waterExplosion",
			to = 18,
			from = 1
		},
		vanhelsing_silence_big = {
			prefix = "Halloween_hero_vhelsing_waterFx_big",
			to = 18,
			from = 1
		},
		vanhelsing_silence_small = {
			prefix = "Halloween_hero_vhelsing_waterFx_small",
			to = 18,
			from = 1
		},
		vanhelsing_relic = {
			prefix = "Halloween_hero_vhelsing_shield",
			to = 23,
			from = 1
		},
		hero_alric_idle = {
			prefix = "hero_hammerhold",
			to = 1,
			from = 1
		},
		hero_alric_running = {
			prefix = "hero_hammerhold",
			to = 6,
			from = 2
		},
		hero_alric_attack = {
			prefix = "hero_hammerhold",
			to = 23,
			from = 7
		},
		hero_alric_attack2 = {
			prefix = "hero_hammerhold",
			to = 39,
			from = 24
		},
		hero_alric_death = {
			prefix = "hero_hammerhold",
			to = 111,
			from = 105
		},
		hero_alric_respawn = {
			prefix = "hero_hammerhold",
			to = 136,
			from = 118
		},
		hero_alric_levelup = {
			prefix = "hero_hammerhold",
			to = 136,
			from = 118
		},
		hero_alric_sandwarrior = {
			prefix = "hero_hammerhold",
			to = 104,
			from = 71
		},
		hero_alric_flurry_start = {
			prefix = "hero_hammerhold",
			to = 49,
			from = 40
		},
		hero_alric_flurry_loop = {
			prefix = "hero_hammerhold",
			to = 62,
			from = 50
		},
		hero_alric_flurry_end = {
			prefix = "hero_hammerhold",
			to = 70,
			from = 63
		},
		soldier_sand_warrior_raise = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 22,
			from = 1
		},
		soldier_sand_warrior_idle = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 22,
			from = 22
		},
		soldier_sand_warrior_start_walk = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 28,
			from = 23
		},
		soldier_sand_warrior_walk = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 36,
			from = 29
		},
		soldier_sand_warrior_stop_walk = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 45,
			from = 37
		},
		soldier_sand_warrior_attack = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 63,
			from = 46
		},
		soldier_sand_warrior_death = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 74,
			from = 64
		},
		soldier_sand_warrior_death_travel = {
			prefix = "hero_hammerhold_sandWarrior",
			to = 82,
			from = 75
		},
		pirate_watchtower_shooter_idleDown = {
			prefix = "pirateTower_shooter",
			to = 1,
			from = 1
		},
		pirate_watchtower_shooter_idleUp = {
			prefix = "pirateTower_shooter",
			to = 70,
			from = 70
		},
		pirate_watchtower_shooter_shootingDown = {
			prefix = "pirateTower_shooter",
			to = 35,
			from = 2
		},
		pirate_watchtower_shooter_shootingUp = {
			prefix = "pirateTower_shooter",
			to = 70,
			from = 36
		},
		pirate_watchtower_flag = {
			prefix = "pirateTower_flag",
			to = 15,
			from = 1
		},
		pirate_watchtower_parrot_idle = {
			prefix = "pirateTower_bird",
			to = 12,
			from = 1
		},
		pirate_watchtower_parrot_fly = {
			prefix = "pirateTower_bird",
			to = 12,
			from = 1
		},
		pirate_watchtower_parrot_carry = {
			prefix = "pirateTower_bird",
			to = 19,
			from = 13
		},
		Soldier_Monster_idle = {
			prefix = "Soldier_Monster",
			to = 1,
			from = 1
		},
		Soldier_Monster_running = {
			prefix = "Soldier_Monster",
			to = 39,
			from = 1
		},
		Soldier_Monster_attack = {
			prefix = "Soldier_Monster",
			to = 77,
			from = 40
		},
				enemy_desertraider_idle = {
			prefix = "desertRaider",
			to = 67,
			from = 67
		},
		enemy_desertraider_walkingRightLeft = {
			prefix = "desertRaider",
			to = 22,
			from = 1
		},
		enemy_desertraider_walkingUp = {
			prefix = "desertRaider",
			to = 44,
			from = 23
		},
		enemy_desertraider_walkingDown = {
			prefix = "desertRaider",
			to = 66,
			from = 45
		},
		enemy_desertraider_attack = {
			prefix = "desertRaider",
			to = 77,
			from = 67
		},
		enemy_desertraider_death = {
			prefix = "desertRaider",
			to = 106,
			from = 101
		},
				enemy_immortal_idle = {
			prefix = "desertImmortal",
			to = 67,
			from = 67
		},
		enemy_immortal_walkingRightLeft = {
			prefix = "desertImmortal",
			to = 22,
			from = 1
		},
		enemy_immortal_walkingUp = {
			prefix = "desertImmortal",
			to = 44,
			from = 23
		},
		enemy_immortal_walkingDown = {
			prefix = "desertImmortal",
			to = 66,
			from = 45
		},
		enemy_immortal_attack = {
			prefix = "desertImmortal",
			to = 87,
			from = 67
		},
		enemy_immortal_death = {
			prefix = "desertImmortal",
			to = 124,
			from = 111
		},
				enemy_desertarcher_idle = {
			prefix = "desertArcher",
			to = 67,
			from = 67
		},
		enemy_desertarcher_walkingRightLeft = {
			prefix = "desertArcher",
			to = 22,
			from = 1
		},
		enemy_desertarcher_walkingUp = {
			prefix = "desertArcher",
			to = 44,
			from = 23
		},
		enemy_desertarcher_walkingDown = {
			prefix = "desertArcher",
			to = 66,
			from = 45
		},
		enemy_desertarcher_attack = {
			prefix = "desertArcher",
			to = 74,
			from = 68
		},
		enemy_desertarcher_rangedAttack = {
			prefix = "desertArcher",
			to = 88,
			from = 75
		},
		enemy_desertarcher_death = {
			prefix = "desertArcher",
			to = 119,
			from = 112
		},
		enemy_scorpion_idle = {
			prefix = "scorpion",
			to = 46,
			from = 46
		},
		enemy_scorpion_walkingRightLeft = {
			prefix = "scorpion",
			to = 9,
			from = 1
		},
		enemy_scorpion_walkingUp = {
			prefix = "scorpion",
			to = 18,
			from = 10
		},
		enemy_scorpion_walkingDown = {
			prefix = "scorpion",
			to = 27,
			from = 19
		},
		enemy_scorpion_attack = {
			prefix = "scorpion",
			to = 46,
			from = 29
		},
		enemy_scorpion_poison = {
			prefix = "scorpion",
			to = 66,
			from = 47
		},
		enemy_scorpion_death = {
			prefix = "scorpion",
			to = 99,
			from = 90
		},
				enemy_tremor_idle = {
			prefix = "tremor",
			to = 44,
			from = 44
		},
		enemy_tremor_walkingRightLeft = {
			prefix = "tremor",
			to = 14,
			from = 1
		},
		enemy_tremor_walkingUp = {
			prefix = "tremor",
			to = 28,
			from = 15
		},
		enemy_tremor_walkingDown = {
			prefix = "tremor",
			to = 42,
			from = 29
		},
		enemy_tremor_attack = {
			prefix = "tremor",
			to = 62,
			from = 43
		},
		enemy_tremor_death = {
			prefix = "tremor",
			to = 97,
			from = 83
		},
		enemy_tremor_raise = {
			prefix = "tremor",
			to = 75,
			from = 64
		},
		enemy_tremor_burrow = {
			prefix = "tremor",
			to = 82,
			from = 78
		},
		enemy_tremor_teleport = {
			prefix = "states_flying_small",
			to = 10,
			from = 1
		},
				enemy_executioner_idle = {
			prefix = "desertExecutioner",
			to = 73,
			from = 73
		},
		enemy_executioner_walkingRightLeft = {
			prefix = "desertExecutioner",
			to = 24,
			from = 1
		},
		enemy_executioner_walkingDown = {
			prefix = "desertExecutioner",
			to = 48,
			from = 25
		},
		enemy_executioner_walkingUp = {
			prefix = "desertExecutioner",
			to = 72,
			from = 49
		},
		enemy_executioner_attack = {
			prefix = "desertExecutioner",
			to = 99,
			from = 73
		},
		enemy_executioner_death = {
			prefix = "desertExecutioner",
			to = 120,
			from = 100
		},
		ground_hit_smoke = {
			prefix = "fx_smoke_hitground",
			to = 14,
			from = 1
		},
		ground_hit_decal = {
			prefix = "decal_smoke_hitground",
			to = 12,
			from = 1
		},
		
		enemy_munra_idle = {
			prefix = "desertMunra",
			to = 74,
			from = 74
		},
		enemy_munra_walkingRightLeft = {
			prefix = "desertMunra",
			to = 24,
			from = 1
		},
		enemy_munra_walkingUp = {
			prefix = "desertMunra",
			to = 48,
			from = 25
		},
		enemy_munra_walkingDown = {
			prefix = "desertMunra",
			to = 72,
			from = 49
		},
		enemy_munra_attack = {
			prefix = "desertMunra",
			to = 94,
			from = 73
		},
		enemy_munra_ranged_attack = {
			prefix = "desertMunra",
			to = 117,
			from = 95
		},
		enemy_munra_heal = {
			prefix = "desertMunra",
			to = 117,
			from = 95
		},
		enemy_munra_summon = {
			prefix = "desertMunra",
			to = 165,
			from = 119
		},
		enemy_munra_death = {
			prefix = "desertMunra",
			to = 200,
			from = 189
		},
		munra_sarcophagus_start = {
			prefix = "desertMunra_Sarcophagus",
			to = 49,
			from = 1
		},
		munra_sarcophagus_end = {
			prefix = "desertMunra_Sarcophagus",
			to = 63,
			from = 50
		},
		bolt_munra_flying = {
			prefix = "MunraBolt",
			to = 2,
			from = 1
		},
		bolt_munra_hit = {
			prefix = "MunraBolt",
			to = 10,
			from = 3
		},
		enemy_fallen_idle = {
			prefix = "fallen",
			to = 67,
			from = 67
		},
		enemy_fallen_walkingRightLeft = {
			prefix = "fallen",
			to = 16,
			from = 1
		},
		enemy_fallen_walkingUp = {
			prefix = "fallen",
			to = 32,
			from = 17
		},
		enemy_fallen_walkingDown = {
			prefix = "fallen",
			to = 47,
			from = 33
		},
		enemy_fallen_attack = {
			prefix = "fallen",
			to = 67,
			from = 48
		},
		enemy_fallen_death = {
			prefix = "fallen",
			to = 113,
			from = 93
		},
		enemy_fallen_raise = {
			prefix = "fallen",
			to = 146,
			from = 114
		},
		enemy_desertthug_idle = {
			prefix = "desertThug",
			to = 67,
			from = 67
		},
		enemy_desertthug_walkingRightLeft = {
			prefix = "desertThug",
			to = 22,
			from = 1
		},
		enemy_desertthug_walkingUp = {
			prefix = "desertThug",
			to = 44,
			from = 23
		},
		enemy_desertthug_walkingDown = {
			prefix = "desertThug",
			to = 66,
			from = 45
		},
		enemy_desertthug_attack = {
			prefix = "desertThug",
			to = 77,
			from = 67
		},
		enemy_desertthug_death = {
			prefix = "desertThug",
			to = 106,
			from = 101
		},
		Soldier_Monster_attack2 = {
			prefix = "Soldier_Monster",
			to = 77,
			from = 40
		},
		Soldier_Monster_death = {
			prefix = "Soldier_Monster",
			to = 125,
			from = 78
		},
		Soldier_Monster_respawn = {
			prefix = "Soldier_Monster",
			to = 1,
			from = 1
		},
		Soldier_Monster_levelup = {
			prefix = "Soldier_Monster",
			to = 1,
			from = 1
		},
		
}
local o = {
	animations = a
}

return o
