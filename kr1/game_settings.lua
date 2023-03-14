local GS = {
	gameplay_tips_count = 21,
	early_wave_reward_per_second = 1,
	max_stars = 140,
	max_difficulty = DIFFICULTY_HARD,
	difficulty_soldier_hp_max_factor = {
		1.2,
		1,
		1
	},
	difficulty_enemy_hp_max_factor = {
		0.8,
		1,
		1.2
	},
	difficulty_enemy_speed_factor = {
		1.28,
		1.28,
		1.28
	},
	main_campaign_levels = 12,
	last_level = 28,
	endless_levels_count = 1,
	level_ranges = {
		{
			1,
			12
		},
		{
			13
		},
		{
			14,
			27,
			28,
			list = true
		},
		{
			15,
			22,
			list = true
		},
		{
			16,
			17
		},
		{
			18,
			19
		},
		{
			20,
			21
		},
		{
			23,
			26
		},
		{
			29
		}
	},
	default_hero = nil,
	hero_xp_thresholds = {
		300,
		900,
		2000,
		4000,
		8000,
		12000,
		16000,
		20000,
		26000
	},
	hero_xp_ephemeral = true,
	hero_level_expected = {},
	hero_xp_gain_per_difficulty_mode = {
		[DIFFICULTY_EASY] = 1,
		[DIFFICULTY_NORMAL] = 1,
		[DIFFICULTY_HARD] = 1
	},
	skill_points_for_hero_level = {
		0,
		4,
		8,
		12,
		16,
		20,
		24,
		28,
		32,
		36
	},
	endless_gems_for_wave = 1,
	gems_factor_per_mode = {
		0.8,
		0.48,
		0.48
	},
	gems_per_level = {
		100,
		150,
		200,
		250,
		250,
		300,
		300,
		300,
		400,
		400,
		400,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500,
		500
	},
	encyclopedia_tower_fmt = "encyclopedia_towers_00%02i",
	encyclopedia_tower_thumb_fmt = "encyclopedia_tower_thumbs_00%02i",
	encyclopedia_enemy_fmt = "encyclopedia_creeps_00%02i",
	encyclopedia_enemy_thumb_fmt = "encyclopedia_creep_thumbs_00%02i",
	encyclopedia_enemies = {
		{
			always_shown = true,
			name = "enemy_goblin"
		},
		{
			name = "enemy_fat_orc"
		},
		{
			name = "enemy_shaman"
		},
		{
			name = "enemy_ogre"
		},
		{
			name = "enemy_bandit"
		},
		{
			name = "enemy_brigand"
		},
		{
			name = "enemy_marauder"
		},
		{
			name = "enemy_spider_small"
		},
		{
			name = "enemy_spider_big"
		},
		{
			name = "enemy_gargoyle"
		},
		{
			name = "enemy_shadow_archer"
		},
		{
			name = "enemy_dark_knight"
		},
		{
			name = "enemy_wolf_small"
		},
		{
			name = "enemy_wolf"
		},
		{
			name = "enemy_golem_head"
		},
		{
			name = "enemy_whitewolf"
		},
		{
			name = "enemy_troll"
		},
		{
			name = "enemy_troll_axe_thrower"
		},
		{
			name = "enemy_troll_chieftain"
		},
		{
			name = "enemy_yeti"
		},
		{
			name = "enemy_rocketeer"
		},
		{
			name = "enemy_slayer"
		},
		{
			name = "enemy_demon"
		},
		{
			name = "enemy_demon_mage"
		},
		{
			name = "enemy_demon_wolf"
		},
		{
			name = "enemy_demon_imp"
		},
		{
			name = "enemy_skeleton"
		},
		{
			name = "enemy_skeleton_big"
		},
		{
			name = "enemy_necromancer"
		},
		{
			name = "enemy_lava_elemental"
		},
		{
			name = "enemy_sarelgaz_small"
		},
		{
			name = "eb_juggernaut"
		},
		{
			name = "eb_jt"
		},
		{
			name = "eb_veznan"
		},
		{
			name = "eb_sarelgaz"
		},
		{
			name = "enemy_goblin_zapper"
		},
		{
			name = "enemy_orc_armored"
		},
		{
			name = "enemy_orc_rider"
		},
		{
			name = "enemy_forest_troll"
		},
		{
			name = "eb_gulthak"
		},
		{
			name = "enemy_zombie"
		},
		{
			name = "enemy_spider_rotten"
		},
		{
			name = "enemy_rotten_tree"
		},
		{
			name = "enemy_swamp_thing"
		},
		{
			name = "eb_greenmuck"
		},
		{
			name = "enemy_raider"
		},
		{
			name = "enemy_pillager"
		},
		{
			name = "eb_kingpin"
		},
		{
			name = "enemy_troll_skater"
		},
		{
			name = "enemy_troll_brute"
		},
		{
			name = "eb_ulgukhai"
		},
		{
			name = "enemy_demon_legion"
		},
		{
			name = "enemy_demon_flareon"
		},
		{
			name = "enemy_demon_gulaemon"
		},
		{
			name = "enemy_demon_cerberus"
		},
		{
			name = "eb_moloch"
		},
		{
			name = "enemy_rotten_lesser"
		},
		{
			name = "eb_myconid"
		},
		{
			name = "enemy_halloween_zombie"
		},
		{
			name = "enemy_giant_rat"
		},
		{
			name = "enemy_wererat"
		},
		{
			name = "enemy_fallen_knight"
		},
		{
			name = "enemy_spectral_knight"
		},
		{
			name = "enemy_abomination"
		},
		{
			name = "enemy_witch"
		},
		{
			name = "enemy_werewolf"
		},
		{
			name = "enemy_lycan"
		},
		{
			name = "eb_blackburn"
		}
	}
}

for i = #GS.encyclopedia_enemies, 1, -1 do
	if GS.encyclopedia_enemies[i].target and GS.encyclopedia_enemies[i].target ~= KR_TARGET then
		table.remove(GS.encyclopedia_enemies, i)
	end
end

return GS
