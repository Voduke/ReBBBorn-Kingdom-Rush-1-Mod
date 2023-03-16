local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local E = require("entity_db")
local i18n = require("i18n")

require("constants")

local anchor_y = 0
local image_x = 0
local image_y, tt = nil
local scripts = require("game_scripts")
local scripts3 = require("game_scripts_3")
local scripts2 = require("game_scripts_2")
local scripts114 = require("scripts")
local mylua = require("mylua")

require("templates")

local IS_PHONE = KR_TARGET == "phone"
local IS_PHONE_OR_TABLET = KR_TARGET == "phone" or KR_TARGET == "tablet"
local IS_CONSOLE = KR_TARGET == "console"

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local function vv(v1)
	return {
		x = v1,
		y = v1
	}
end

local function r(x, y, w, h)
	return {
		pos = v(x, y),
		size = v(w, h)
	}
end

local function fts(v)
	return v/FPS
end

local function adx(v)
	return v - anchor_x*image_x
end

local function ady(v)
	return v - anchor_y*image_y
end

local function np(pi, spi, ni)
	return {
		dir = 1,
		pi = pi,
		spi = spi,
		ni = ni
	}
end

local function d2r(d)
	return (d*math.pi)/180
end

local function RT(name, ref)
	return E:register_t(name, ref)
end

local function AC(tpl, ...)
	return E:add_comps(tpl, ...)
end

local function CC(comp_name)
	return E:clone_c(comp_name)
end

tt = E.register_t(E, "pop_crit", "pop")
tt.render.sprites[1].name = "pop_0003"
tt = E.register_t(E, "pop_headshot", "pop")
tt.render.sprites[1].name = "pop_0007"
tt = E.register_t(E, "pop_bladesinger", "pop")
tt.render.sprites[1].name = "elven_pops_0014"
tt = E.register_t(E, "pop_eldritch_mage", "pop")
tt.render.sprites[1].name = "elven_pops_0001"
tt = E.register_t(E, "pop_tree_archer", "pop")
tt.render.sprites[1].name = "elven_pops_0002"
tt = E.register_t(E, "pop_elven_barrack1", "pop")
tt.render.sprites[1].name = "elven_pops_0003"
tt = E.register_t(E, "pop_elven_barrack2", "pop")
tt.render.sprites[1].name = "elven_pops_0004"
tt = E.register_t(E, "pop_artillery", "pop")
tt.render.sprites[1].name = "elven_pops_0005"
tt = E.register_t(E, "pop_wild_mage", "pop")
tt.render.sprites[1].name = "elven_pops_0006"
tt = E.register_t(E, "pop_high_elven", "pop")
tt.render.sprites[1].name = "elven_pops_0007"
tt = E.register_t(E, "pop_arcane", "pop")
tt.render.sprites[1].name = "elven_pops_0009"
tt = E.register_t(E, "pop_golden", "pop")
tt.render.sprites[1].name = "elven_pops_0010"
tt = E.register_t(E, "pop_death", "pop")
tt.render.sprites[1].name = "elven_pops_0011"
tt = E.register_t(E, "pop_druid_henge", "pop")
tt.render.sprites[1].name = "elven_pops_0016"
tt = E.register_t(E, "pop_entwood", "pop")
tt.render.sprites[1].name = "elven_pops_0017"
tt = E.register_t(E, "pop_crit_mages", "pop")
tt.render.sprites[1].name = "elven_pops_0023"
tt = E.register_t(E, "pop_crit_wild_magus", "pop")
tt.render.sprites[1].name = "elven_pops_0024"
tt = E.register_t(E, "pop_crit_high_elven", "pop")
tt.render.sprites[1].name = "elven_pops_0025"
tt = E.register_t(E, "ps_arrow_arcane_special")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "archer_arcane_particle"
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_y = {
	1,
	0
}
tt.particle_system.emission_rate = 30
tt = E.register_t(E, "ps_arrow_silver_mark")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.names = {
	"arrow_silver_mark_particle_1",
	"arrow_silver_mark_particle_2"
}
tt.particle_system.loop = false
tt.particle_system.cycle_names = true
tt.particle_system.animated = true
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.scales_y = {
	0.85,
	0.85
}
tt.particle_system.scales_x = {
	0.85,
	0.85
}
tt.particle_system.emission_rate = 30
tt = E.register_t(E, "ps_bolt_elves_1")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "mage_proy_particle"
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
	fts(15),
	fts(15)
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_x = {
	0.8,
	0.25
}
tt.particle_system.scales_y = {
	0.8,
	0.25
}
tt.particle_system.emission_rate = 60
tt = E.register_t(E, "ps_bolt_elves_2", "ps_bolt_elves_1")
tt.particle_system.scales_x = {
	0.9,
	0.25
}
tt.particle_system.scales_y = {
	0.9,
	0.25
}
tt = E.register_t(E, "ps_bolt_elves_3", "ps_bolt_elves_1")
tt.particle_system.scales_x = {
	1,
	0.25
}
tt.particle_system.scales_y = {
	1,
	0.25
}
tt = E.register_t(E, "ps_bolt_high_elven", "ps_bolt_elves_1")
tt.particle_system.name = "mage_highElven_proy_particle"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.scales_y = {
	1,
	0.5
}
tt = E.register_t(E, "ps_bolt_wild_magus")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "mage_wild_proy_particle"
tt.particle_system.alphas = {
	180,
	12
}
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.scales_y = {
	1,
	0.5
}
tt.particle_system.scales_x = {
	1,
	0.5
}
tt.particle_system.emission_rate = 60
tt = E.register_t(E, "ps_high_elven_sentinel")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "mage_highElven_balls_0020"
tt.particle_system.animated = false
tt.particle_system.alphas = {
	200,
	0
}
tt.particle_system.particle_lifetime = {
	fts(5),
	fts(5)
}
tt.particle_system.scales_y = {
	0.8,
	0.8
}
tt.particle_system.scales_x = {
	0.8,
	0.8
}
tt.particle_system.emission_rate = 60
tt.particle_system.z = Z_OBJECTS
tt.particle_system.draw_order = 4
tt.particle_system.sort_y = nil
tt = E.register_t(E, "fx_forest_circle", "fx")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].name = "forestKeeper_circle1_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "forestKeeper_circle1_0001"
tt.render.sprites[2].animated = false
tt.tween.remove = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(2),
		255
	},
	{
		fts(16),
		255
	},
	{
		fts(29),
		0
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0.2, 0.2)
	},
	{
		fts(8),
		v(0.6, 0.6)
	}
}
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "r"
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		fts(20),
		-math.pi/4
	}
}
tt.tween.props[3].loop = true
tt.tween.props[4] = table.deepclone(tt.tween.props[1])
tt.tween.props[4].sprite_id = 2
tt.tween.props[5] = table.deepclone(tt.tween.props[2])
tt.tween.props[5].keys = {
	{
		0,
		v(0.5, 0.5)
	},
	{
		fts(8),
		v(1, 1)
	}
}
tt.tween.props[5].sprite_id = 2
tt.tween.props[6] = table.deepclone(tt.tween.props[3])
tt.tween.props[6].keys = {
	{
		0,
		0
	},
	{
		fts(20),
		math.pi/4
	}
}
tt.tween.props[6].sprite_id = 2
tt = E.register_t(E, "fx_bolt_elves_hit", "fx")
tt.render.sprites[1].name = "bolt_elves_hit"
tt = E.register_t(E, "fx_bolt_high_elven_weak_hit", "fx")
tt.render.sprites[1].name = "bolt_high_elven_weak_hit"
tt = E.register_t(E, "fx_bolt_high_elven_strong_hit", "fx")
tt.render.sprites[1].name = "bolt_high_elven_strong_hit"
tt = E.register_t(E, "fx_rock_explosion", "fx")
tt.render.sprites[1].name = "fx_rock_explosion"
tt.render.sprites[1].anchor.y = 0.23684210526315788
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = E.register_t(E, "fx_fiery_nut_explosion", "fx")
tt.render.sprites[1].name = "fx_fiery_nut_explosion"
tt.render.sprites[1].anchor.y = 0.19791666666666666
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = E.register_t(E, "fx_rock_druid_launch", "fx")
tt.render.sprites[1].name = "fx_rock_druid_launch"
tt = E.register_t(E, "fx_arrow_arcane_hit", "fx")
tt.render.sprites[1].name = "fx_arrow_arcane_hit"
tt = E.register_t(E, "fx_soldier_barrack_revive", "fx")
tt.render.sprites[1].name = "fx_soldier_barrack_revive"
tt.render.sprites[1].anchor.y = 0.15
tt = E.register_t(E, "fx_arcane_slumber_explosion", "fx")
tt.render.sprites[1].name = "arcane_slumber_explosion"
tt.render.sprites[1].anchor.y = 0.32051282051282054
tt = E.register_t(E, "fx_arrow_silver_mark_hit", "fx")
tt.render.sprites[1].name = "fx_arrow_silver_mark_hit"
tt.render.sprites[1].sort_y_offset = -20
tt = E.register_t(E, "fx_arrow_silver_sentence_hit", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].name = "fx_arrow_silver_sentence_hit"
tt.sound_events.insert = "TowerGoldenBowInstakill"
tt = E.register_t(E, "fx_arrow_silver_sentence_shot", "fx")
tt.render.sprites[1].name = "fx_arrow_silver_sentence_shot"
tt = E.register_t(E, "fx_wild_magus_hit", "fx")
tt.render.sprites[1].name = "bolt_wild_magus_hit"
tt = E.register_t(E, "fx_ray_wild_magus_hit", "fx")
tt.render.sprites[1].name = "fx_ray_wild_magus_hit"
tt = E.register_t(E, "fx_eldritch_explosion", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].name = "fx_eldritch_explosion"
tt.render.sprites[1].sort_y_offset = -5
tt.sound_events.insert = "TowerWildMagusDoomExplote"
tt = E.register_t(E, "fx_druid_bear_spawn_rune", "decal")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].anchor = v(0.48148148148148145, 0.7291666666666666)
tt.render.sprites[1].name = "fx_druid_bear_spawn_rune"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_EFFECTS
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(9),
		255
	},
	{
		fts(15),
		255
	},
	{
		fts(25),
		64
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		fts(0),
		v(1, 1)
	},
	{
		fts(9),
		v(1, 1)
	},
	{
		fts(11),
		v(0.77, 0.77)
	},
	{
		fts(13),
		v(0.85, 0.85)
	},
	{
		fts(19),
		v(0.65, 0.45)
	}
}
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "offset"
tt.tween.props[3].keys = {
	{
		0,
		v(0, 32)
	},
	{
		fts(9),
		v(0, 32)
	},
	{
		fts(13),
		v(0, 32)
	},
	{
		fts(25),
		v(0, 4)
	}
}
tt = E.register_t(E, "fx_druid_bear_spawn_effect", "fx")
tt.render.sprites[1].name = "fx_druid_bear_spawn_effect"
tt.render.sprites[1].anchor = v(0.5, 0.28125)
tt = E.register_t(E, "fx_druid_bear_spawn_decal", "decal")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].anchor = v(0.5, 0.28125)
tt.render.sprites[1].name = "fx_druid_bear_spawn_decal"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(6),
		0
	},
	{
		fts(7),
		255
	},
	{
		fts(26),
		255
	},
	{
		fts(36),
		102
	},
	{
		fts(41),
		0
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		fts(0),
		v(0.35, 0.35)
	},
	{
		fts(6),
		v(0.35, 0.35)
	},
	{
		fts(10),
		v(1, 1)
	},
	{
		fts(16),
		v(0.8, 0.8)
	}
}
tt = E.register_t(E, "fx_druid_bear_death_rune", "fx_druid_bear_spawn_rune")
tt.render.sprites[1].name = "fx_druid_bear_death_rune"
tt.render.sprites[1].time_offset = fts(-38)
tt.render.sprites[1].sort_y_offset = -1
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].time_offset = fts(-28)
tt.tween.props[2].keys = {
	{
		0,
		v(1, 1)
	}
}
tt.tween.props[3].keys = {
	{
		0,
		v(0, 20)
	},
	{
		fts(10),
		v(0, 36)
	},
	{
		fts(19),
		v(0, 40)
	}
}
tt.tween.props[3].time_offset = fts(-28)
tt = E.register_t(E, "fx_druid_bear_death_effect", "fx_druid_bear_spawn_effect")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].name = "fx_druid_bear_death_effect"
tt.render.sprites[1].time_offset = fts(-28)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(1),
		255
	}
}
tt.tween.props[1].time_offset = fts(-28)
tt = E.register_t(E, "fx_druid_bear_death_decal", "fx_druid_bear_spawn_decal")
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(1),
		255
	},
	{
		fts(4),
		255
	},
	{
		fts(12),
		0
	}
}
tt.tween.props[1].time_offset = fts(-28)
tt.tween.props[2].keys = {
	{
		fts(0),
		v(0.4, 0.35)
	},
	{
		fts(6),
		v(0.77, 0.77)
	},
	{
		fts(10),
		v(0.86, 0.86)
	}
}
tt.tween.props[2].time_offset = fts(-28)
tt = E.register_t(E, "fx_clobber_smoke", "fx")
tt.render.sprites[1].name = "fx_clobber_smoke"
tt = E.register_t(E, "fx_clobber_smoke_ring", "fx")
tt.render.sprites[1].name = "fx_clobber_smoke_ring"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "decal_arcane_burst_ground", "decal_tween")
tt.render.sprites[1].name = "archer_arcane_special_decal1"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "archer_arcane_special_decal2"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(4),
		255
	},
	{
		fts(6),
		0
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(4),
		v(1.84, 1.84)
	},
	{
		fts(6),
		v(2.17, 2.17)
	}
}
tt.tween.props[2].sprite_id = 1
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		255
	},
	{
		fts(4),
		48
	},
	{
		fts(9),
		0
	}
}
tt.tween.props[3].sprite_id = 2
tt.tween.props[4] = E.clone_c(E, "tween_prop")
tt.tween.props[4].name = "scale"
tt.tween.props[4].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(4),
		v(1.64, 1.64)
	},
	{
		fts(6),
		v(2.07, 2.07)
	}
}
tt.tween.props[4].sprite_id = 2
tt = E.register_t(E, "decal_rock_crater", "decal_tween")
tt.tween.props[1].keys = {
	{
		1,
		255
	},
	{
		2.5,
		0
	}
}
tt.render.sprites[1].name = "artillery_thrower_explosion_decal"
tt.render.sprites[1].animated = false
tt = E.register_t(E, "decal_clobber_1", "decal_tween")
tt.render.sprites[1].name = "EarthquakeTower_HitDecal1"
tt.render.sprites[1].animated = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1,
		255
	},
	{
		2.5,
		0
	}
}
tt = E.register_t(E, "decal_clobber_2", "decal_clobber_1")
tt.render.sprites[1].name = "EarthquakeTower_HitDecal2"
tt = E.register_t(E, "decal_eerie_root_1", "decal_scripted")
tt.render.sprites[1].prefix = "decal_eerie_roots_1"
tt.render.sprites[1].anchor.y = 0.1875
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "start"
tt.render.sprites[1].hidden = true
tt.main_script.update = scripts2.decal_eerie_root.update
tt.vis_flags = bor(F_RANGED)
tt.vis_bans = bor(F_FRIEND)
tt = E.register_t(E, "decal_eerie_root_2", "decal_eerie_root_1")
tt.render.sprites[1].prefix = "decal_eerie_roots_2"
tt.render.sprites[1].anchor.y = 0.14285714285714285
tt = E.register_t(E, "fx_ground_hit2", "fx")
tt.render.sprites[1].name = "ground_hit_smoke"
tt.render.sprites[1].anchor.y = 0.27
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.render.sprites[1].shader_args = {
	tint_factor = 0.3333,
	tint_color = {
		0.1,
		0.1,
		1.8,
		1.8,
	}
}
tt = RT("ps_shotgun_musketeer", "particle_system")
tt.particle_system.animated = true
tt.particle_system.emission_rate = 20
tt.particle_system.loop = false
tt.particle_system.name = "ps_shotgun_musketeer"
tt.particle_system.particle_lifetime = {
	fts(13),
	fts(13)
}
tt.particle_system.track_rotation = true
tt = RT("ps_bolt_sorcerer", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.emit_area_spread = v(6, 6)
tt.particle_system.emission_rate = 60
tt.particle_system.name = "sorcererbolt_particle"
tt.particle_system.particle_lifetime = {
	fts(2),
	fts(5)
}
tt.particle_system.rotation_spread = math.pi
tt.particle_system.scale_var = {
	0.8,
	0.6
}
tt.particle_system.scales_x = {
	1,
	0.3
}
tt.particle_system.scales_y = {
	1,
	0.3
}
tt = RT("ps_tesla_overcharge", "particle_system")
tt.particle_system.name = "decal_tesla_overcharge"
tt.particle_system.animated = true
tt.particle_system.particle_lifetime = {
	0.7,
	1
}
tt.particle_system.alphas = {
	0,
	255,
	255,
	0
}
tt.particle_system.scales_x = {
	1,
	0.45
}
tt.particle_system.scales_y = {
	1,
	0.45
}
tt.particle_system.scale_same_aspect = true
tt.particle_system.scale_var = {
	0.5,
	1.5
}
tt.particle_system.emit_spread = math.pi*2
tt.particle_system.emit_duration = fts(7)
tt.particle_system.emit_rotation = 0
tt.particle_system.emit_speed = {
	120,
	120
}
tt.particle_system.emission_rate = 90
tt.particle_system.source_lifetime = 2
tt.particle_system.z = Z_OBJECTS
tt = E.register_t(E, "ps_arrow_multishot_hero_alleria")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "hero_archer_arrow_particle"
tt.particle_system.animated = false
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.particle_lifetime = {
	0.1,
	0.1
}
tt.particle_system.emission_rate = 30
tt.particle_system.track_rotation = true
tt.particle_system.z = Z_BULLETS
tt = E.register_t(E, "ps_flare_flareon", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.emission_rate = 40
tt.particle_system.emit_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "Stage9_lavaShotParticle"
tt.particle_system.particle_lifetime = {
	0.35,
	0.7
}
tt.particle_system.scale_same_aspect = true
tt.particle_system.scale_var = {
	0.6,
	0.8
}
tt.particle_system.scales_x = {
	0.8,
	1.6
}
tt.particle_system.scales_y = {
	0.8,
	1.6
}
tt.particle_system.emit_rotation_spread = math.pi
tt = RT("ps_veznan_soul", "particle_system")
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.emission_rate = 60
tt.particle_system.emission_spread = v(6, 6)
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.emit_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "boss_veznan_soul_particle"
tt.particle_system.particle_lifetime = {
	fts(4),
	fts(8)
}
tt.particle_system.scale_same_aspect = true
tt.particle_system.scale_var = {
	0.8,
	1.2
}
tt.particle_system.scales_x = {
	1,
	0.3
}
tt.particle_system.scales_y = {
	1,
	0.3
}
tt = RT("ps_hacksaw_sawblade")

AC(tt, "pos", "particle_system")

tt.particle_system.alphas = {
	255,
	200,
	0,
	0
}
tt.particle_system.animated = true
tt.particle_system.emission_rate = 120
tt.particle_system.emit_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "ps_hacksaw_sawblade"
tt.particle_system.particle_lifetime = {
	fts(12),
	fts(12)
}
tt.particle_system.scales_x = {
	1,
	0.5
}
tt.particle_system.scales_y = {
	1.5,
	0.5
}
tt = RT("ps_elora_run")

AC(tt, "pos", "particle_system")

tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.emission_rate = 10
tt.particle_system.loop = false
tt.particle_system.z = Z_DECALS + 1
tt.particle_system.name = "ps_hero_elora_run"
tt.particle_system.particle_lifetime = {
	0.8,
	1
}
tt = RT("ps_hero_ignus_idle", "particle_system")
tt.particle_system.name = "ps_hero_ignus_idle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	0.5,
	0.5
}
tt.particle_system.alphas = {
	255,
	255
}
tt.particle_system.emit_duration = nil
tt.particle_system.emit_direction = d2r(90)
tt.particle_system.emit_speed = {
	30,
	30
}
tt.particle_system.emission_rate = 2.5
tt.particle_system.source_lifetime = nil
tt.particle_system.z = Z_OBJECTS
tt = RT("ps_ignus_run")

AC(tt, "pos", "particle_system")

tt.particle_system.alphas = {
	255,
	200,
	0
}
tt.particle_system.anchor = v(0.5, 0.1)
tt.particle_system.animated = true
tt.particle_system.emission_rate = 10
tt.particle_system.loop = false
tt.particle_system.z = Z_DECALS + 1
tt.particle_system.name = "ps_hero_ignus_run"
tt.particle_system.particle_lifetime = {
	0.6,
	0.8
}
tt = RT("ps_hero_ignus_smoke", "ps_power_fireball")
tt.particle_system.scales_x = {
	2,
	3
}
tt.particle_system.scales_y = {
	2,
	3
}
tt.particle_system.emission_rate = 30
tt.particle_system.emit_offset = v(0, 17)
tt.particle_system.name = "ps_hero_ignus_smoke"
tt.particle_system.sort_y_offset = -16
tt.particle_system.z = Z_OBJECTS
tt = RT("ps_hero_10yr_idle", "particle_system")
tt.particle_system.name = "ps_hero_10yr_particle_fire"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	0.5,
	0.5
}
tt.particle_system.alphas = {
	255,
	255
}
tt.particle_system.emit_duration = nil
tt.particle_system.emit_direction = d2r(90)
tt.particle_system.emit_speed = {
	30,
	30
}
tt.particle_system.emission_rate = 2.5
tt.particle_system.source_lifetime = nil
tt.particle_system.z = Z_OBJECTS
tt = RT("ps_stage_snow")

AC(tt, "pos", "particle_system")

tt.pos = v(512, 768)
tt.particle_system.alphas = {
	255,
	255,
	255,
	0
}
tt.particle_system.emission_rate = 8
tt.particle_system.emit_area_spread = v(1200, 10)
tt.particle_system.emit_direction = (math.pi*3)/2
tt.particle_system.emit_speed = {
	30,
	40
}
tt.particle_system.emit_spread = math.pi/8
tt.particle_system.particle_lifetime = {
	20,
	30
}
tt.particle_system.scale_var = {
	0.4,
	0.7
}
tt.particle_system.ts_offset = -20
tt.particle_system.z = Z_OBJECTS_SKY
tt.particle_system.name = "Copo"
tt = RT("fx_teleport_arcane", "fx")
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].prefix = "fx_teleport_arcane"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt = RT("fx_explosion_shrapnel", "fx")
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].prefix = "explosion"
tt.render.sprites[1].name = "shrapnel"
tt = RT("fx_bolt_sorcerer_hit", "fx")
tt.render.sprites[1].prefix = "bolt_sorcerer"
tt.render.sprites[1].name = "hit"
tt = RT("fx_mod_polymorph_sorcerer_small", "fx")
tt.render.sprites[1].name = "fx_mod_polymorph_sorcerer_small"
tt.render.sprites[1].anchor.y = 0.5
tt = RT("fx_mod_polymorph_sorcerer_big", "fx_mod_polymorph_sorcerer_small")
tt.render.sprites[1].name = "fx_mod_polymorph_sorcerer_big"
tt = RT("fx_hacksaw_sawblade_hit", "fx")
tt.render.sprites[1].prefix = "fx_hacksaw_sawblade"
tt.render.sprites[1].name = "hit"
tt = RT("fx_hero_thor_thunderclap_disipate", "fx")
tt.render.sprites[1].name = "fx_hero_thor_thunderclap_disipate"
tt.render.sprites[1].anchor = v(0.5, 0.15)
tt.render.sprites[1].z = Z_EFFECTS
tt = RT("fx_bolt_elora_hit", "fx")
tt.render.sprites[1].prefix = "fx_bolt_elora"
tt.render.sprites[1].name = "hit"
tt = RT("fx_bolt_magnus_hit", "fx")
tt.render.sprites[1].name = "bolt_magnus_hit"
tt = E.register_t(E, "fx_ignus_burn", "fx")
tt.render.sprites[1].prefix = "fx_burn"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt = RT("fx_juggernaut_smoke", "fx")
tt.render.sprites[1].name = "fx_juggernaut_smoke"
tt.render.sprites[1].anchor.y = 0.27
tt = RT("fx_jt_tower_click", "fx")
tt.render.sprites[1].name = "fx_jt_tower_click"
tt.render.sprites[1].anchor.y = 0.3
tt = RT("fx_moloch_ring", "fx")
tt.render.sprites[1].name = "fx_moloch_ring"
tt.render.sprites[1].z = Z_DECALS
tt = RT("fx_moloch_rocks", "fx")
tt.render.sprites[1].name = "fx_moloch_rocks"
tt.render.sprites[1].anchor.y = 0.24242424242424243
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("fx_myconid_spores", "fx")
tt.render.sprites[1].name = "fx_myconid_spores"
tt.render.sprites[1].anchor.y = 0.8
tt = RT("fx_blackburn_smash", "fx")
tt.render.sprites[1].name = "fx_blackburn_smash"
tt.render.sprites[1].anchor.y = 0.1588785046728972
tt = RT("fx_veznan_demon_fire", "fx")
tt.render.sprites[1].name = "fx_veznan_demon_fire"
tt = E.register_t(E, "fx_explosion_rotten_shot", "fx")
tt.render.sprites[1].name = "explosion_rotten_shot"
tt.render.sprites[1].anchor = v(0.5, 0.33783783783783783)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt = E.register_t(E, "fx_explosion_flareon_flare", "fx")
tt.render.sprites[1].name = "explosion_flare_flareon"
tt.render.sprites[1].anchor = v(0.5, 0.25)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -2
tt = RT("fx_bolt_necromancer_hit", "fx")
tt.render.sprites[1].prefix = "bolt_necromancer"
tt.render.sprites[1].name = "hit"
tt = RT("fx_demon_portal_out", "fx")
tt.render.sprites[1].prefix = "fx_demon_portal_out"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big"
}
tt = RT("fx_bolt_witch_hit", "fx")
tt.render.sprites[1].name = "fx_bolt_witch_hit"
tt = E.register_t(E, "fx_hobgoblin_ground_hit", "fx")
tt.render.sprites[1].name = "fx_hobgoblin_ground_hit"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].draw_order = 2
tt = RT("decal_paladin_holystrike", "decal_timed")
tt.render.sprites[1].name = "decal_paladin_holystrike"
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_malik_ring", "decal_timed")
tt.render.sprites[1].name = "decal_malik_ring"
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_malik_earthquake", "decal_bomb_crater")
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "decal_malik_earthquake"
tt.render.sprites[2].hide_after_runs = 1
tt.render.sprites[2].anchor.y = 0.24
tt = E.register_t(E, "decal_oni_torment_sword", "decal_scripted")
tt.render.sprites[1].prefix = "decal_oni_torment_sword_1"
tt.render.sprites[1].name = "in"
tt.render.sprites[1].anchor.y = 0.16666666666666666
tt.main_script.update = scripts.decal_oni_torment_sword.update
tt.duration = 0.5
tt.delay = 0.01
tt.sword_names = {
	"decal_oni_torment_sword_1",
	"decal_oni_torment_sword_2",
	"decal_oni_torment_sword_3",
	"decal_oni_torment_sword_1"
}
tt = RT("magnus_arcane_rain_controller", "decal_scripted")

AC(tt, "tween")

tt.main_script.update = scripts.magnus_arcane_rain_controller.update
tt.duration = nil
tt.count = nil
tt.spawn_time = fts(6)
tt.initial_angle = d2r(0)
tt.angle_increment = d2r(70)
tt.entity = "magnus_arcane_rain"
tt.decal = "decal_magnus_arcane_rain"
tt.render.sprites[1].name = "hero_mage_rain_decal"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.remove = false
tt.tween.disabled = true
tt = E.register_t(E, "magnus_arcane_rain")

AC(tt, "render", "main_script", "pos")

tt.damage_type = DAMAGE_TRUE
tt.damage_radius = 40
tt.damage_min = 20
tt.damage_max = 20
tt.hit_time = fts(10)
tt.damage_flags = F_AREA
tt.main_script.update = scripts.magnus_arcane_rain.update
tt.render.sprites[1].prefix = "magnus_arcane_rain"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0.5, 0.07)
tt.sound = "HeroMageRainDrop"
tt = RT("denas_cursing", "decal_scripted")
tt.render.sprites[1].name = "hero_denas_cursing"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_OBJECTS
tt.duration = fts(36)
tt.offset = v(0, 25)
tt.main_script.update = scripts.denas_cursing.update
tt = RT("denas_catapult_controller", "decal_scripted")

AC(tt, "tween", "sound_events")

tt.count = nil
tt.bullet = "denas_catapult_rock"
tt.main_script.update = scripts.denas_catapult_controller.update
tt.initial_angle = d2r(0)
tt.initial_delay = 0.25
tt.rock_delay = {
	fts(2),
	fts(8)
}
tt.angle_increment = d2r(60)
tt.rock_offset = v(90, 100)
tt.exit_time = 0.5 + fts(45)
tt.render.sprites[1].name = "hero_king_catapultDecal"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.2,
		255
	}
}
tt.tween.remove = false
tt.sound_events.shoot = "BombShootSound"
tt = RT("denas_buffing_circle", "decal_timed")

AC(tt, "tween")

tt.render.sprites[1].name = "hero_king_glow"
tt.render.sprites[1].anchor = v(0.5, 0.26)
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.disabled = false
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		25.5
	},
	{
		0.33,
		255
	},
	{
		1,
		0
	}
}
tt.tween.props[2] = CC("tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0.7, 0.7)
	},
	{
		1,
		v(1.8, 1.8)
	}
}
tt.tween.remove = true
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0.7, 0.7)
	},
	{
		1,
		v(1.8, 1.8)
	}
}
tt.tween.remove = true
tt = RT("decal_ignus_flaming", "decal_timed")
tt.render.sprites[1].name = "decal_ignus_flaming"
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_ingvar_attack", "decal_tween")
tt.render.sprites[1].name = "hero_viking_axeDecal"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		0,
		200
	},
	{
		1,
		200
	},
	{
		1.5,
		0
	}
}
tt = RT("decal_jt_ground_hit", "decal_timed")
tt.render.sprites[1].name = "decal_jt_ground_hit"
tt.render.sprites[1].z = Z_DECALS
tt = RT("decal_jt_tap", "decal_loop")
tt.render.sprites[1].random_ts = fts(7)
tt.render.sprites[1].name = "decal_jt_tap"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y = -40
tt.render.sprites[1].offset = v(20, 40)
tt = RT("decal_blackburn_smash_ground", "decal_timed")
tt.render.sprites[1].name = "fx_blackburn_smash_ground"
tt.render.sprites[1].z = Z_DECALS
tt = RT("veznan_portal", "decal_scripted")

AC(tt, "editor")

tt.render.sprites[1].prefix = "veznan_portal"
tt.render.sprites[1].z = Z_DECALS
tt.fx_out = "fx_demon_portal_out"
tt.main_script.update = scripts.veznan_portal.update
tt.out_nodes = nil
tt.spawn_groups = {
	{
		{
			0.5,
			{
				{
					4,
					7,
					"enemy_demon"
				}
			}
		},
		{
			0.8,
			{
				{
					3,
					3,
					"enemy_demon_wolf"
				}
			}
		},
		{
			1,
			{
				{
					5,
					5,
					"enemy_demon"
				},
				{
					1,
					1,
					"enemy_demon_mage"
				}
			}
		}
	},
	{
		{
			0.5,
			{
				{
					2,
					5,
					"enemy_demon"
				}
			}
		},
		{
			0.8,
			{
				{
					2,
					2,
					"enemy_demon_wolf"
				}
			}
		},
		{
			1,
			{
				{
					3,
					3,
					"enemy_demon"
				}
			}
		}
	},
	{
		{
			1,
			{
				{
					7,
					7,
					"enemy_demon_wolf"
				}
			}
		}
	}
}
tt.portal_idx = 1
tt.spawn_interval = fts(30)
tt.pi = 1
tt = E.register_t(E, "decal_s12_shoutbox", "decal_tween")

E.add_comps(E, tt, "texts")

tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "boss_veznan_taunts_love_0001"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[2].offset = v(-3, 6)
tt.texts.list[1].text = "Hello world"
tt.texts.list[1].size = v(164, 70)
tt.texts.list[1].font_name = "taunts"
tt.texts.list[1].font_size = 24
tt.texts.list[1].color = {
	233,
	189,
	255
}
tt.texts.list[1].line_height = i18n.cjk(i18n, 1, 1)
tt.texts.list[1].sprite_id = 2
tt.texts.list[1].fit_height = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.25,
		255
	},
	{
		"this.duration-0.25",
		255
	},
	{
		"this.duration",
		0
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "scale"
tt.tween.props[3].keys = {
	{
		0,
		v(1.01, 1.01)
	},
	{
		0.4,
		v(0.99, 0.99)
	},
	{
		0.8,
		v(1.01, 1.01)
	}
}
tt.tween.props[3].sprite_id = 1
tt.tween.props[3].loop = true
tt.tween.props[4] = table.deepclone(tt.tween.props[3])
tt.tween.props[4].sprite_id = 2
tt.tween.remove = true
tt = RT("decal_veznan_strike", "decal_timed")
tt.render.sprites[1].name = "decal_veznan_strike"
tt.render.sprites[1].z = Z_DECALS
tt = RT("veznan_soul", "decal_scripted")
tt.angle_variation = d2r(5)
tt.duration = 8
tt.main_script.update = scripts.veznan_soul.update
tt.max_angle = d2r(70)
tt.min_angle = d2r(-70)
tt.particles_name = "ps_veznan_soul"
tt.render.sprites[1].name = "decal_veznan_soul"
tt.render.sprites[1].z = Z_EFFECTS
tt.speed = {
	FPS*6,
	FPS*15
}
tt = RT("decal_eb_veznan_white_circle", "decal_tween")
tt.render.sprites[1].name = "decal_veznan_white_circle"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		vv(1)
	},
	{
		fts(65),
		vv(1)
	},
	{
		fts(65) + 0.5,
		vv(20)
	},
	{
		fts(65) + 4.5,
		vv(20)
	}
}
tt = RT("decal_hobgoblin_ground_hit", "decal_tween")
tt.tween.props[1].keys = {
	{
		1,
		255
	},
	{
		2.5,
		0
	}
}
tt.render.sprites[1].name = "hobgoblin_decal"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].animated = false
tt = RT("tower_holder")

AC(tt, "tower", "tower_holder", "pos", "render", "ui", "editor", "editor_script")

tt.ui.click_rect = r(-40, -12, 80, 46)
tt.ui.has_nav_mesh = true
tt.tower.level = 1
tt.tower.type = "holder"
tt.tower.can_be_mod = false
tt.tower_holder.preview_ids = {
	archer = 2,
	engineer = 5,
	barrack = 3,
	mage = 4,
	tree_archer = 6,
	rock_thrower = 9,
	elven_barrack = 7,
	eldritch_mage = 8
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "build_terrain_%04i"
tt.render.sprites[1].offset = v(0, 17)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "tower_preview_archer"
tt.render.sprites[2].animated = false
tt.render.sprites[2].hidden = true
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[2].alpha = 180
tt.render.sprites[3] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[3].name = "tower_preview_barrack"
tt.render.sprites[3].offset = v(0, 38)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[4].name = "tower_preview_mage"
tt.render.sprites[4].offset = v(0, 30)
tt.render.sprites[5] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[5].name = "tower_preview_artillery"
tt.render.sprites[5].offset = v(0, 41)
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].name = "tower_preview_tree_archer"
tt.render.sprites[6].animated = false
tt.render.sprites[6].hidden = true
tt.render.sprites[6].offset = v(0, 34)
tt.render.sprites[6].alpha = 180
tt.render.sprites[7] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[7].name = "tower_preview_elven_barracks"
tt.render.sprites[7].offset = v(0, 34)
tt.render.sprites[8] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[8].name = "tower_preview_eldritch_mage"
tt.render.sprites[8].offset = v(0, 36)
tt.render.sprites[9] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[9].name = "tower_preview_rock_thrower"
tt.render.sprites[9].offset = v(0, 26)
tt.editor.props = {
	{
		"tower.terrain_style",
		PT_NUMBER
	},
	{
		"tower.default_rally_pos",
		PT_COORDS
	},
	{
		"tower.holder_id",
		PT_STRING
	},
	{
		"ui.nav_mesh_id",
		PT_STRING
	},
	{
		"editor.game_mode",
		PT_NUMBER
	}
}
tt.editor_script.insert = scripts.editor_tower.insert
tt.editor_script.remove = scripts.editor_tower.remove
tt.editor_script.insert = scripts2.editor_tower.insert
tt.editor_script.remove = scripts2.editor_tower.remove
tt = RT("tower_holder_grass", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_GRASS
tt.render.sprites[1].name = "build_terrain_0001"
tt = RT("tower_holder_snow", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_SNOW
tt.render.sprites[1].name = "build_terrain_0002"
tt = RT("tower_holder_wasteland", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_WASTELAND
tt.render.sprites[1].name = "build_terrain_0003"
tt = RT("tower_holder_blackburn", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_BLACKBURN
tt.render.sprites[1].name = "build_terrain_0008"
tt = RT("tower_build_archer", "tower_build")
tt.build_name = "tower_archer_1"
tt.render.sprites[2].name = "tower_constructing_0004"
tt.render.sprites[2].offset = v(0, 39)
tt = RT("tower_build_barrack", "tower_build_archer")
tt.build_name = "tower_barrack_1"
tt.render.sprites[2].name = "tower_constructing_0002"
tt.render.sprites[2].offset = v(0, 40)
tt = RT("tower_build_mage", "tower_build_archer")
tt.build_name = "tower_mage_1"
tt.render.sprites[2].name = "tower_constructing_0003"
tt.render.sprites[2].offset = v(0, 31)
tt = RT("tower_build_engineer", "tower_build_archer")
tt.build_name = "tower_engineer_1"
tt.render.sprites[2].name = "tower_constructing_0001"
tt.render.sprites[2].offset = v(0, 41)
tt = E.register_t(E, "tower_build_tree_archer", "tower_build")
tt.build_name = "tower_tree_archer_1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "build_tree_archer"
tt.render.sprites[2].offset = v(0, 32)
tt = E.register_t(E, "tower_build_elven_barrack", "tower_build")
tt.build_name = "tower_elven_barrack_1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "build_elven_barracks"
tt.render.sprites[2].offset = v(0, 34)
tt = E.register_t(E, "tower_build_eldritch_mage", "tower_build")
tt.build_name = "tower_eldritch_mage_1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "build_eldritch_mage"
tt.render.sprites[2].offset = v(0, 24)
tt = E.register_t(E, "tower_build_rock_thrower", "tower_build")
tt.build_name = "tower_rock_thrower_1"
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2].name = "build_artillery"
tt.render.sprites[2].offset = v(0, 26)
tt = RT("tower_mage_1", "tower")

AC(tt, "attacks")

tt.tower.type = "mage"
tt.tower.level = 1
tt.tower.price = 100
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0003") or "info_portraits_towers_0010"
tt.info.enc_icon = 3
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.insert = scripts.tower_mage.insert
tt.main_script.update = scripts.tower_mage.update
tt.attacks.range = 140
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_1"
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].bullet_start_offset = {
	v(8, 66),
	v(-5, 62)
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "towermagelvl1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shootermage"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(1, 57)
tt.render.sid_tower = 2
tt.render.sid_shooter = 3
tt.sound_events.insert = "MageTaunt"
tt = RT("tower_mage_2", "tower_mage_1")
tt.info.enc_icon = 7
tt.tower.level = 2
tt.tower.price = 160
tt.attacks.range = 160
tt.attacks.list[1].bullet = "bolt_2"
tt.attacks.list[1].bullet_start_offset = {
	v(8, 66),
	v(-5, 64)
}
tt.render.sprites[2].prefix = "towermagelvl2"
tt.render.sprites[3].offset = v(1, 57)
tt = RT("tower_mage_3", "tower_mage_1")
tt.info.enc_icon = 11
tt.tower.level = 3
tt.tower.price = 240
tt.attacks.range = 180
tt.attacks.list[1].bullet = "bolt_3"
tt.attacks.list[1].bullet_start_offset = {
	v(8, 70),
	v(-5, 69)
}
tt.render.sprites[2].prefix = "towermagelvl3"
tt.render.sprites[3].offset = v(1, 62)
tt = RT("tower_engineer_1", "tower")

AC(tt, "attacks")

tt.tower.type = "engineer"
tt.tower.level = 1
tt.tower.price = 125
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0004") or "info_portraits_towers_0003"
tt.info.enc_icon = 4
tt.main_script.insert = scripts.tower_engineer.insert
tt.main_script.update = scripts.tower_engineer.update
tt.attacks.range = 160
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "bomb"
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].shoot_time = fts(12)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].bullet_start_offset = v(0, 50)
tt.attacks.list[1].node_prediction = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 15)

for i = 2, 8, 1 do
	tt.render.sprites[i] = E.clone_c(E, "sprite")
	tt.render.sprites[i].prefix = "towerengineerlvl1_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 41)
end

tt.sound_events.insert = "EngineerTaunt"
tt = RT("tower_engineer_2", "tower_engineer_1")
tt.info.enc_icon = 8
tt.tower.level = 2
tt.tower.price = 220
tt.attacks.list[1].bullet = "bomb_dynamite"
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].shoot_time = fts(12)
tt.attacks.list[1].bullet_start_offset = v(0, 53)

for i = 2, 8, 1 do
	tt.render.sprites[i] = E.clone_c(E, "sprite")
	tt.render.sprites[i].prefix = "towerengineerlvl2_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 42)
end

tt = RT("tower_engineer_3", "tower_engineer_1")
tt.info.enc_icon = 12
tt.tower.level = 3
tt.tower.price = 320
tt.attacks.range = 179.20000000000002
tt.attacks.list[1].bullet = "bomb_black"
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].shoot_time = fts(12)
tt.attacks.list[1].bullet_start_offset = v(0, 57)

for i = 2, 8, 1 do
	tt.render.sprites[i] = E.clone_c(E, "sprite")
	tt.render.sprites[i].prefix = "towerengineerlvl3_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 43)
end

tt = RT("tower_archer_1", "tower")

AC(tt, "attacks")

tt.tower.type = "archer"
tt.tower.level = 1
tt.tower.price = 70
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0001"
tt.info.enc_icon = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_tower_0001"
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooterarcherlvl1"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(-9, 51)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "shooterarcherlvl1"
tt.render.sprites[4].name = "idleDown"
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[4].offset = v(9, 51)
tt.main_script.insert = scripts.tower_archer.insert
tt.main_script.update = scripts.tower_archer.update
tt.main_script.remove = scripts.tower_archer.remove
tt.attacks.range = 140
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "arrow_1"
tt.attacks.list[1].cooldown = 0.8
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(-10, 50),
	v(10, 50)
}
tt.sound_events.insert = "ArcherTaunt"
tt = RT("tower_archer_2", "tower_archer_1")
tt.info.enc_icon = 5
tt.tower.level = 2
tt.tower.price = 110
tt.render.sprites[2].name = "archer_tower_0002"
tt.render.sprites[3].prefix = "shooterarcherlvl2"
tt.render.sprites[3].offset = v(-9, 52)
tt.render.sprites[4].prefix = "shooterarcherlvl2"
tt.render.sprites[4].offset = v(9, 52)
tt.attacks.range = 160
tt.attacks.list[1].bullet = "arrow_2"
tt.attacks.list[1].cooldown = 0.6
tt = RT("tower_archer_3", "tower_archer_1")
tt.info.enc_icon = 9
tt.tower.level = 3
tt.tower.price = 160
tt.render.sprites[2].name = "archer_tower_0003"
tt.render.sprites[3].prefix = "shooterarcherlvl3"
tt.render.sprites[3].offset = v(-9, 57)
tt.render.sprites[4].prefix = "shooterarcherlvl3"
tt.render.sprites[4].offset = v(9, 57)
tt.attacks.range = 180
tt.attacks.list[1].bullet = "arrow_3"
tt.attacks.list[1].cooldown = 0.5
tt = E.register_t(E, "hero_alleria2", "stage_hero")

E.add_comps(E, tt, "melee", "ranged")

image_y = 66
anchor_y = 0.25
tt.health.armor = 0
tt.health.dead_lifetime = 15
tt.health.hp_max = 210
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 3
tt.hero.xp = 11299
tt.hero.tombstone_show_time = fts(90)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = "hero_portraits_0019"
tt.info.i18n_key = "HERO_ARCHER"
tt.info.portrait = "info_portraits_sc_0064"
tt.info.damage_icon = "arrow"
tt.fixed_mode = nil
tt.main_script.insert = scripts2.hero_alleria.insert
tt.main_script.update = scripts2.hero_alleria.update
tt.motion.max_speed = FPS*3
tt.regen.cooldown = 1
tt.regen.health = 23
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_alleria2"
tt.render.sprites[1].angles = {
	walk = {
		"walk"
	},
	ranged = {
		"shoot"
	}
}
tt.soldier.melee_slot_offset.x = 2
tt.sound_events.change_rally_point = "ElvesHeroAlleriaTaunt"
tt.sound_events.death = "ElvesHeroAlleriaDeath"
tt.sound_events.insert = "ElvesHeroAlleriaTauntIntro"
tt.sound_events.respawn = "ElvesHeroAlleriaTauntIntro"
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 15
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.range = 65
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].bullet = "arrow_hero_alleria"
tt.ranged.attacks[1].bullet_start_offset = {
	v(9, 24)
}
tt.ranged.attacks[1].cooldown = 1
tt.ranged.attacks[1].max_range = 9e+99
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].node_prediction = fts(11)
tt.ranged.attacks[1].shoot_time = fts(11)
tt.ranged.attacks[2] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[2].animation = "shootSpecial"
tt.ranged.attacks[2].bullet = "arrow_multishot_hero_alleria"
tt.ranged.attacks[2].bullet_start_offset = {
	v(9, 24)
}
tt.ranged.attacks[2].cooldown = 9e+9
tt.ranged.attacks[2].max_range = 200
tt.ranged.attacks[2].min_range = 40
tt.ranged.attacks[2].node_prediction = fts(13)
tt.ranged.attacks[2].shoot_time = fts(13)
tt.ranged.attacks[2].sound = "ElvesHeroAlleriaShoot"
tt = E.register_t(E, "hero_alleria3", "stage_hero")

E.add_comps(E, tt, "melee", "ranged", "auras")

anchor_y = 0.20689655172413793
image_y = 116
tt.health.armor = 0
tt.health.dead_lifetime = 45
tt.health.hp_max = 2400
tt.health_bar.offset = v(0, 57)
tt.health.immune_to = DAMAGE_MAGICAL
tt.health.magic_armor = 0
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_blue"
tt.auras.list[1].cooldown = 0
tt.hero.level = 10
tt.hero.xp = 11299
tt.hero.tombstone_show_time = fts(90)
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = "hero_portraits_1231"
tt.info.i18n_key = "HERO_ARCHER"
tt.info.portrait = "info_portraits_enemies_0045"
tt.info.damage_icon = "arrow"
tt.fixed_mode = nil
tt.main_script.insert = scripts2.hero_alleria.insert
tt.main_script.update = mylua.blue.update
tt.motion.max_speed = FPS*3
tt.regen.cooldown = 1
tt.regen.health = 200
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_alleria3"
tt.render.sprites[1].angles = {
	walk = {
		"walk"
	}
}
tt.soldier.melee_slot_offset.x = 30
tt.sound_events.change_rally_point = "ElvesHeroAlleriaTaunt"
tt.sound_events.death = "ElvesHeroAlleriaDeath"
tt.sound_events.insert = "ElvesHeroAlleriaTauntIntro"
tt.sound_events.respawn = "ElvesHeroAlleriaTauntIntro"
tt.ui.click_rect = r(-25, -10, 50, 60)
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(0, 20)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 60
tt.melee.attacks[1].hit_time = fts(30)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].pop = {
	"pop_zap_sorcerer2"
}
tt.melee.attacks[1].pop_chance = 0.15
tt.melee.attacks[1].pop_conds = DR_KILL
tt.melee.range = 85
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "ray_bluegale"
tt.ranged.attacks[1].bullet_start_offset = {
	v(27, 70)
}
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].node_prediction = fts(11)
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[2] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[2].animation = "shoot"
tt.ranged.attacks[2].bullet = "ray_bluegale2"
tt.ranged.attacks[2].bullet_start_offset = {
	v(27, 70)
}
tt.ranged.attacks[2].cooldown = 25
tt.ranged.attacks[2].max_range = 185
tt.ranged.attacks[2].min_range = 40
tt.ranged.attacks[2].node_prediction = fts(13)
tt.ranged.attacks[2].shoot_time = fts(18)
tt.ranged.attacks[2].sound = "ElvesHeroAlleriaShoot"
tt = RT("ray_bluegale", "bullet")
tt.bullet.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_TRUE)
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_sunray_hit"
tt.bullet.damage_max = 45
tt.bullet.damage_min = 25
tt.image_width = 82
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].name = "ray_bluegale"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.track_target = true
tt.ray_duration = fts(9)
tt.ray_y_scales = {
	0.4,
	0.6,
	0.8,
	1
}
tt.bullet.pop = {
	"pop_bzzt2"
}
tt.bullet.pop_chance = 0.2
tt.bullet.pop_conds = DR_KILL
tt.sound_events.insert = "SaurianSavantAttack"
tt = RT("ray_bluegale2", "bullet")
tt.bullet.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_INSTAKILL)
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_sunray_hit"
tt.bullet.damage_max = 45
tt.bullet.damage_min = 25
tt.image_width = 82
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].name = "ray_bluegale"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.track_target = true
tt.ray_duration = fts(9)
tt.ray_y_scales = {
	0.4,
	0.6,
	0.8,
	1
}
tt.bullet.pop = {
	"pop_bzzt3"
}
tt.bullet.pop_chance = 0.3
tt.sound_events.insert = "SaurianSavantAttack"
tt = E.register_t(E, "hero_alleria_fixed", "hero_alleria2")
tt.fixed_mode = true
tt.health.ignore_damage = true
tt.health_bar.hidden = true
tt.vis.bans = F_ALL
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.ui.can_click = false
tt.ui.can_select = false
tt.ranged.attacks[1].bullet = "arrow_3"
tt.ranged.attacks[1].max_range = 9e+9
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[2].bullet = "arrow_multishot_hero_alleria_fixed"
tt.ranged.attacks[2].cooldown = 9e+99
tt.ranged.attacks[2].max_range = 600
tt.ranged.attacks[2].min_range = 0
tt = E.register_t(E, "alleria_cat", "soldier")

E.add_comps(E, tt, "nav_grid")

anchor_y = 0.2619047619047619
image_y = 42
tt.behaviour_attack = {
	min_cooldown = 2,
	max_cooldown = 3
}
tt.behaviour_attack.cooldown = tt.behaviour_attack.min_cooldown
tt.behaviour_attack.animation = "attack"
tt.behaviour_attack.sound = "ElvesAlleriaCatHit"
tt.behaviour_attack.hit_time = fts(9)
tt.behaviour_attack.min_distance = 10
tt.behaviour_attack.max_distance = 100
tt.behaviour_attack.y_offset = -6
tt.behaviour_scared = {
	min_cooldown = fts(150),
	max_cooldown = fts(160)
}
tt.behaviour_scared.cooldown = tt.behaviour_scared.min_cooldown
tt.behaviour_scared.animation = "scared"
tt.health.armor = 0
tt.health.hp_max = 150
tt.health.ignore_damage = true
tt.health_bar.hidden = true
tt.info.i18n_key = "HERO_ARCHER_WILDCAT"
tt.main_script.update = scripts2.alleria_cat.update
tt.motion.max_speed = 69
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "alleria_wildcat"
tt.render.sprites[1].angles = {
	walk = {
		"walk"
	}
}
tt.ui.can_click = false
tt.ui.can_select = false
tt.unit.hit_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.unit.hide_after_death = true
tt.unit.explode_fx = nil
tt.vis.bans = F_ALL
tt = E.register_t(E, "tower_tree_archer_1", "tower")

E.add_comps(E, tt, "attacks")

tt.tower.type = "tree_archer"
tt.tower.level = 1
tt.tower.price = 70
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0001"
tt.info.enc_icon = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_towers_0001"
tt.render.sprites[2].offset = v(0, 33)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_archer_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(0, 42)
tt.main_script.insert = scripts2.tower_archer.insert
tt.main_script.update = scripts2.tower_archer.update
tt.main_script.remove = scripts2.tower_archer.remove
tt.attacks.range = 160
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "elven_arrow_1"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 44)
}
tt.sound_events.insert = "ElvesArcherTaunt"
tt = E.register_t(E, "tower_tree_archer_2", "tower_tree_archer_1")
tt.info.enc_icon = 5
tt.tower.level = 2
tt.tower.price = 110
tt.render.sprites[2].name = "archer_towers_0002"
tt.render.sprites[3].offset = v(-14, 43)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset = v(16, 48)
tt.attacks.range = 180
tt.attacks.list[1].bullet = "elven_arrow_2"
tt.attacks.list[1].bullet_start_offset = {
	v(-14, 45),
	v(16, 50)
}
tt.attacks.list[1].cooldown = 0.6
tt = E.register_t(E, "tower_tree_archer_3", "tower_tree_archer_1")
tt.info.enc_icon = 9
tt.tower.level = 3
tt.tower.price = 160
tt.tower.size = TOWER_SIZE_LARGE
tt.render.sprites[2].name = "archer_towers_0003"
tt.render.sprites[3].offset = v(-14, 42)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset = v(-3, 62)
tt.render.sprites[5] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[5].offset = v(16, 49)
tt.attacks.range = 200
tt.attacks.list[1].bullet = "elven_arrow_3"
tt.attacks.list[1].bullet_start_offset = {
	v(-14, 44),
	v(-3, 64),
	v(16, 51)
}
tt.attacks.list[1].cooldown = 0.4
tt = E.register_t(E, "tower_arcane", "tower")

E.add_comps(E, tt, "attacks", "powers")

image_y = 90
tt.tower.type = "arcane"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 17
tt.info.fn = scripts2.tower_arcane.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0009"
tt.powers.burst = E.clone_c(E, "power")
tt.powers.burst.price_base = 200
tt.powers.burst.price_inc = 200
tt.powers.burst.attack_idx = 2
tt.powers.burst.enc_icon = 2
tt.powers.slumber = E.clone_c(E, "power")
tt.powers.slumber.price_base = 120
tt.powers.slumber.price_inc = 120
tt.powers.slumber.attack_idx = 3
tt.powers.slumber.enc_icon = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_towers_0004"
tt.render.sprites[2].offset = v(0, 33)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_arcane_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	special = {
		"specialUp",
		"specialDown"
	}
}
tt.render.sprites[3].offset = v(-9, 57)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset.x = 9
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].animated = false
tt.render.sprites[5].name = "archer_arcane_top"
tt.render.sprites[5].offset = v(0, 33)
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].name = "tower_arcane_bubbles"
tt.render.sprites[6].offset = v(-15, 17)
tt.render.sprites[7] = table.deepclone(tt.render.sprites[6])
tt.render.sprites[7].offset.x = 13
tt.render.sprites[7].ts = fts(15)
tt.main_script.insert = scripts2.tower_arcane.insert
tt.main_script.update = scripts2.tower_arcane.update
tt.attacks.range = 200
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "arrow_arcane"
tt.attacks.list[1].cooldown = 0.8
tt.attacks.list[1].shoot_time = fts(4)
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet_start_offset = {
	v(9, 4),
	v(6, -5)
}
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].animation = "special"
tt.attacks.list[2].bullet = "arrow_arcane_burst"
tt.attacks.list[2].cooldown = 12
tt.attacks.list[2].cooldown_inc = 0
tt.attacks.list[2].shoot_time = fts(13)
tt.attacks.list[3] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[3].animation = "special"
tt.attacks.list[3].cooldown = 24
tt.attacks.list[3].cooldown_inc = -4
tt.attacks.list[3].bullet = "arrow_arcane_slumber"
tt.attacks.list[3].shoot_time = fts(13)
tt.attacks.list[3].vis_bans = bor(F_BOSS)
tt.attacks.list[3].vis_flags = bor(F_STUN)
tt.sound_events.insert = "ElvesArcherArcaneTaunt"
tt = E.register_t(E, "tower_silver", "tower")

E.add_comps(E, tt, "attacks", "powers")

image_y = 90
tt.info.enc_icon = 18
tt.tower.type = "silver"
tt.tower.level = 1
tt.tower.price = 275
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 300
tt.attacks.short_range = 162.5
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animations = {
	"shoot",
	"shoot_long"
}
tt.attacks.list[1].bullet = "arrow_silver_long"
tt.attacks.list[1].bullets = {
	"arrow_silver",
	"arrow_silver_long"
}
tt.attacks.list[1].cooldowns = {
	0.7,
	1.5
}
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].critical_chances = {
	0.03,
	0.06
}
tt.attacks.list[1].shoot_times = {
	fts(6),
	fts(15)
}
tt.attacks.list[1].bullet_start_offsets = {
	{
		v(9, 4),
		v(6, -5)
	},
	{
		v(9, 4),
		v(6, -5)
	}
}
tt.attacks.list[1].use_obsidian_upgrade = true
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].animations = {
	"sentence",
	"sentence"
}
tt.attacks.list[2].bullets = {
	"arrow_silver_sentence",
	"arrow_silver_sentence_long"
}
tt.attacks.list[2].chance = 0
tt.attacks.list[2].cooldowns = {
	0.7,
	1.25
}
tt.attacks.list[2].cooldown = 0.7
tt.attacks.list[2].shoot_times = {
	fts(13),
	fts(13)
}
tt.attacks.list[2].bullet_start_offsets = {
	{
		v(9, 4),
		v(6, -5)
	},
	{
		v(9, 4),
		v(6, -5)
	}
}
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_INSTAKILL)
tt.attacks.list[2].vis_bans = F_BOSS
tt.attacks.list[2].shot_fx = "fx_arrow_silver_sentence_shot"
tt.attacks.list[2].sound = "TowerGoldenBowInstakillArrowShot"
tt.attacks.list[2].use_obsidian_upgrade = true
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].animations = {
	"mark",
	"mark_long"
}
tt.attacks.list[3].cooldown = 10
tt.attacks.list[3].bullets = {
	"arrow_silver_mark",
	"arrow_silver_mark_long"
}
tt.attacks.list[3].bullet_start_offsets = {
	{
		v(9, 4),
		v(6, -5)
	},
	{
		v(9, 4),
		v(6, -5)
	}
}
tt.attacks.list[3].shoot_times = {
	fts(21),
	fts(21)
}
tt.attacks.list[3].sound = "TowerGoldenBowFlareShot"
tt.attacks.list[3].sound_args = {
	delay = fts(15)
}
tt.attacks.list[3].vis_bans = bor(F_BOSS)
tt.attacks.list[3].use_obsidian_upgrade = true
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0010"
tt.info.fn = scripts2.tower_silver.get_info
tt.powers.sentence = E.clone_c(E, "power")
tt.powers.sentence.attack_idx = 2
tt.powers.sentence.price_base = 400
tt.powers.sentence.price_inc = 400
tt.powers.sentence.chances = {
	{
		0.025,
		0.05,
		0.075
	},
	{
		0.05,
		0.1,
		0.15
	}
}
tt.powers.sentence.enc_icon = 3
tt.powers.mark = E.clone_c(E, "power")
tt.powers.mark.attack_idx = 3
tt.powers.mark.price_base = 200
tt.powers.mark.price_inc = 150
tt.powers.mark.enc_icon = 4
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_towers_0005"
tt.render.sprites[2].offset = v(0, 33)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_silver_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootShortUp",
		"shootShortDown"
	},
	shoot_long = {
		"shootUp",
		"shootDown"
	},
	mark = {
		"shootSpecialShortUp",
		"shootSpecialShortDown"
	},
	mark_long = {
		"shootSpecialUp",
		"shootSpecialDown"
	},
	sentence = {
		"instakillUp",
		"instakillDown"
	}
}
tt.render.sprites[3].offset = v(0, 62)
tt.main_script.update = scripts2.tower_silver.update
tt.sound_events.insert = "ElvesArcherGoldenBowTaunt"
tt = E.register_t(E, "tower_eldritch_mage_1", "tower")

E.add_comps(E, tt, "attacks", "tween")

tt.tower.type = "eldritch_mage"
tt.tower.level = 1
tt.tower.price = 100
tt.info.enc_icon = 3
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0003"
tt.info.fn = scripts2.tower_mage.get_info
tt.main_script.insert = scripts2.tower_mage.insert
tt.main_script.update = scripts2.tower_mage.update
tt.attacks.range = 145
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_elves_1"
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(19)
tt.attacks.list[1].bullet_start_offset = {
	v(8, 68),
	v(-8, 68)
}
tt.attacks.list[1].loops = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "mage_towers_layer1_0001"
tt.render.sprites[2].offset = v(0, 36)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_mage_1_platform"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].offset = v(0, 36)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "tower_mage_shooter"
tt.render.sprites[4].name = "idleDown"
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[4].anchor.y = 0
tt.render.sprites[4].offset = v(2, 35)
tt.render.sid_tower = 3
tt.render.sid_shooter = 4
tt.sound_events.insert = "ElvesMageTaunt"
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 35)
	},
	{
		1,
		v(0, 37)
	},
	{
		2,
		v(0, 35)
	}
}
tt.tween.props[1].sprite_id = 3
tt.tween.props[1].loop = true
tt.tween.props[1].ts = 0
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].keys = {
	{
		0,
		v(2, 34)
	},
	{
		1,
		v(2, 36)
	},
	{
		2,
		v(2, 34)
	}
}
tt.tween.props[2].sprite_id = 4
tt.tween.props[2].loop = true
tt.tween.props[2].ts = 0
tt = E.register_t(E, "tower_eldritch_mage_2", "tower_eldritch_mage_1")
tt.info.enc_icon = 7
tt.tower.level = 2
tt.tower.price = 160
tt.attacks.list[1].bullet = "bolt_elves_2"
tt.attacks.list[1].bullet_start_offset = {
	v(10, 58),
	v(-10, 58)
}
tt.attacks.list[1].cooldown = 1.5
tt.attacks.range = 160
tt.render.sprites[2].name = "mage_towers_layer1_0064"
tt.render.sprites[3].prefix = "tower_mage_2_platform"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 37)
	},
	{
		1,
		v(0, 39)
	},
	{
		2,
		v(0, 37)
	}
}
tt.tween.props[2].keys = {
	{
		0,
		v(2, 38)
	},
	{
		1,
		v(2, 40)
	},
	{
		2,
		v(2, 38)
	}
}
tt = E.register_t(E, "tower_eldritch_mage_3", "tower_eldritch_mage_1")
tt.info.enc_icon = 11
tt.tower.level = 3
tt.tower.price = 250
tt.attacks.list[1].bullet = "bolt_elves_3"
tt.attacks.list[1].bullet_start_offset = {
	v(10, 60),
	v(-10, 60)
}
tt.attacks.list[1].cooldown = 1.5
tt.attacks.range = 195
tt.render.sprites[2].name = "mage_towers_layer1_0096"
tt.render.sprites[3].prefix = "tower_mage_3_platform"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 39)
	},
	{
		1,
		v(0, 41)
	},
	{
		2,
		v(0, 39)
	}
}
tt.tween.props[2].keys = {
	{
		0,
		v(2, 42)
	},
	{
		1,
		v(2, 44)
	},
	{
		2,
		v(2, 42)
	}
}
tt = E.register_t(E, "tower_wild_magus", "tower")

E.add_comps(E, tt, "attacks", "powers", "tween")

tt.info.enc_icon = 16
tt.info.i18n_key = "TOWER_MAGE_WILD_MAGUS"
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0007"
tt.info.fn = scripts2.tower_mage.get_info
tt.main_script.update = scripts2.tower_wild_magus.update
tt.tower.type = "wild_magus"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 180
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animations = {
	"shoot_rh",
	"shoot_lh"
}
tt.attacks.list[1].bullet = "bolt_wild_magus"
tt.attacks.list[1].bullet_start_offset = {
	{
		v(10, 42),
		v(4, 24)
	},
	{
		v(-6, 38),
		v(12, 26)
	}
}
tt.attacks.list[1].cooldown = 0.3
tt.attacks.list[1].shoot_time = fts(4)
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].animation = "ray"
tt.attacks.list[2].bullet = "ray_wild_magus"
tt.attacks.list[2].bullet_start_offset = {
	v(0, 38),
	v(0, 32)
}
tt.attacks.list[2].cooldown = 28
tt.attacks.list[2].shoot_time = fts(20)
tt.attacks.list[2].sound = "TowerWildMagusDoomCast"
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_INSTAKILL)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[3] = E.clone_c(E, "spell_attack")
tt.attacks.list[3].cooldown = 10
tt.attacks.list[3].spell = "mod_ward"
tt.attacks.list[3].animation = "ward"
tt.attacks.list[3].cast_time = fts(14)
tt.attacks.list[3].vis_bans = bor(F_BOSS, F_CLIFF)
tt.attacks.list[3].vis_flags = bor(F_RANGED)
tt.attacks.list[3].sound = "TowerWildMagusDisruptionCast"
tt.powers.eldritch = E.clone_c(E, "power")
tt.powers.eldritch.attack_idx = 2
tt.powers.eldritch.price_base = 350
tt.powers.eldritch.price_inc = 200
tt.powers.eldritch.cooldowns = {
	28,
	24,
	20
}
tt.powers.eldritch.enc_icon = 16
tt.powers.ward = E.clone_c(E, "power")
tt.powers.ward.attack_idx = 3
tt.powers.ward.price_base = 175
tt.powers.ward.price_inc = 175
tt.powers.ward.target_count = {
	2,
	4,
	6
}
tt.powers.ward.enc_icon = 17
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "mage_towers_layer1_0097"
tt.render.sprites[2].offset = v(0, 36)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].animated = false
tt.render.sprites[3].name = "mage_towers_layer2_0097"
tt.render.sprites[3].offset = v(0, 36)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "tower_wild_magus_shooter"
tt.render.sprites[4].name = "idleDown"
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot_rh = {
		"rh_shootUp",
		"rh_shootDown"
	},
	shoot_lh = {
		"lh_shootUp",
		"lh_shootDown"
	},
	ray = {
		"rayUp",
		"rayDown"
	},
	ward = {
		"wardUp",
		"wardDown"
	}
}
tt.render.sprites[4].anchor.y = 0
tt.render.sprites[4].offset = v(2, 22)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].name = "mage_wild_shooter_0167"
tt.render.sprites[5].animated = false
tt.render.sprites[5].anchor.y = 0
tt.render.sprites[5].hidden = true
tt.render.sprites[5].offset = v(0, 22)
tt.render.sprites[6] = table.deepclone(tt.render.sprites[5])
tt.render.sprites[6].name = "mage_wild_shooter_0168"
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].name = "tower_wild_magus_ward_rune"
tt.render.sprites[7].anchor.y = 0
tt.render.sprites[7].animated = true
tt.render.sprites[7].offset = v(0, 22)
tt.render.sprites[7].hidden = true

for i = 1, 10, 1 do
	local s = E.clone_c(E, "sprite")
	s.name = string.format("mage_wild_stones_%04i", i)
	s.animated = false
	s.offset.y = 36
	s.sort_y_offset = (i < 4 and 1) or -1
	tt.render.sprites[#tt.render.sprites + 1] = s
end

tt.render.sid_tower = 3
tt.render.sid_shooter = 4
tt.render.sid_rune = 7
tt.sound_events.insert = "ElvesMageWildMagusTaunt"
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 35)
	},
	{
		1,
		v(0, 37)
	},
	{
		2,
		v(0, 35)
	}
}
tt.tween.props[1].sprite_id = 3
tt.tween.props[1].loop = true
tt.tween.props[1].ts = 0
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].keys = {
	{
		0,
		v(0, 19)
	},
	{
		1,
		v(0, 21)
	},
	{
		2,
		v(0, 19)
	}
}
tt.tween.props[2].sprite_id = 4
tt.tween.props[2].loop = true
tt.tween.props[2].ts = 0
tt.tween.props[3] = table.deepclone(tt.tween.props[2])
tt.tween.props[3].sprite_id = 5
tt.tween.props[4] = table.deepclone(tt.tween.props[2])
tt.tween.props[4].sprite_id = 6
tt.tween.props[5] = table.deepclone(tt.tween.props[2])
tt.tween.props[5].sprite_id = 7
tt.tween.props[6] = E.clone_c(E, "tween_prop")
tt.tween.props[6].keys = {
	{
		0,
		0
	},
	{
		fts(2),
		0
	},
	{
		fts(16),
		255
	},
	{
		fts(25),
		255
	},
	{
		fts(30),
		0
	}
}
tt.tween.props[6].sprite_id = 5
tt.tween.props[7] = table.deepclone(tt.tween.props[6])
tt.tween.props[7].sprite_id = 6

for i = 1, 10, 1 do
	local t = E.clone_c(E, "tween_prop")
	t.sprite_id = tt.render.sid_rune + i
	t.name = "offset"
	t.keys = {
		{
			0,
			v(0, 35)
		},
		{
			1,
			v(0, 37)
		},
		{
			2,
			v(0, 35)
		}
	}
	t.ts = math.random()
	t.loop = true
	tt.tween.props[#tt.tween.props + 1] = t
end
tt = E.register_t(E, "tower_high_elven", "tower")

E.add_comps(E, tt, "attacks", "powers", "tween")

tt.info.enc_icon = 15
tt.info.fn = scripts2.tower_high_elven.get_info
tt.info.i18n_key = "TOWER_MAGE_HIGH_ELVEN"
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0008"
tt.main_script.update = scripts2.tower_high_elven.update
tt.main_script.remove = scripts2.tower_high_elven.remove
tt.tower.type = "high_elven"
tt.tower.level = 1
tt.tower.price = 275
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 180
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_high_elven_strong"
tt.attacks.list[1].bullets = {
	"bolt_high_elven_strong",
	"bolt_high_elven_weak",
	"bolt_high_elven_weak"
}
tt.attacks.list[1].bullet_start_offset = v(0, 75)
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(30)
tt.attacks.list[2] = E.clone_c(E, "spell_attack")
tt.attacks.list[2].animation = "timelapse"
tt.attacks.list[2].spell = "mod_timelapse"
tt.attacks.list[2].cooldown = 16
tt.attacks.list[2].shoot_time = fts(5)
tt.attacks.list[2].min_count = 2
tt.attacks.list[2].vis_flags = bor(F_RANGED)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].sound = "TowerHighMageTimecast"
tt.attacks.list[3] = E.clone_c(E, "custom_attack")
tt.powers.timelapse = E.clone_c(E, "power")
tt.powers.timelapse.attack_idx = 2
tt.powers.timelapse.price_base = 175
tt.powers.timelapse.price_inc = 175
tt.powers.timelapse.target_count = {
	2,
	3,
	4
}
tt.powers.timelapse.enc_icon = 18
tt.powers.sentinel = E.clone_c(E, "power")
tt.powers.sentinel.attack_idx = 3
tt.powers.sentinel.max_level = 3
tt.powers.sentinel.price_base = 200
tt.powers.sentinel.price_inc = 200
tt.powers.sentinel.enc_icon = 19
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "mage_towers_layer1_0098"
tt.render.sprites[2].offset = v(0, 36)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_high_elven_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	timelapse = {
		"timeLapseUp",
		"timeLapseDown"
	}
}
tt.render.sprites[3].anchor.y = 0
tt.render.sprites[3].offset = v(0, -5)
tt.render.sprites[3].draw_order = 5
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "mage_highElven_glow"
tt.render.sprites[4].animated = false
tt.render.sprites[4].offset = tt.render.sprites[2].offset
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.16,
		255
	},
	{
		0.42000000000000004,
		255
	},
	{
		0.68,
		0
	}
}
tt.tween.props[1].sprite_id = 4
tt.tween.props[1].ts = -10
tt.sound_events.insert = "ElvesMageHighElvenTaunt"
tt = E.register_t(E, "high_elven_sentinel", "decal_scripted")

E.add_comps(E, tt, "force_motion", "ranged", "tween")

tt.charge_time = 5
tt.flight_height = 50
tt.force_motion.max_a = 135000
tt.force_motion.max_v = 450
tt.force_motion.ramp_radius = 10
tt.main_script.update = scripts2.high_elven_sentinel.update
tt.owner = nil
tt.owner_idx = nil
tt.tower_rotation_speed = (math.pi*7.5)/180*30
tt.tower_rotation_offset = v(0, -6)
tt.tower_rotation_radius = 20
tt.wait_time = 4
tt.wait_spent_time = 1
tt.particles_name = "ps_high_elven_sentinel"
tt.ranged.attacks[1].bullet = "ray_high_elven_sentinel"
tt.ranged.attacks[1].shoot_time = fts(9)
tt.ranged.attacks[1].cooldown = 0.5
tt.ranged.attacks[1].search_cooldown = 0.25
tt.ranged.attacks[1].shoot_range = 25
tt.ranged.attacks[1].launch_range = 300
tt.ranged.attacks[1].max_range = 300
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet_start_offset = v(0, 0)
tt.ranged.attacks[1].vis_flags = F_RANGED
tt.ranged.attacks[1].vis_bans = 0
tt.ranged.attacks[1].max_shots = 10
tt.render.sprites[1].prefix = "high_elven_sentinel"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[1].draw_order = 4
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].hidden = true
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		v(0.75, 1)
	},
	{
		fts(10),
		v(1, 1)
	}
}
tt.tween.props[2].name = "scale"
tt = E.register_t(E, "tower_rock_thrower_1", "tower")

E.add_comps(E, tt, "attacks")

tt.tower.type = "rock_thrower"
tt.tower.level = 1
tt.tower.price = 125
tt.tower.range_offset = v(0, 10)
tt.info.enc_icon = 4
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0004"
tt.main_script.update = scripts2.tower_rock_thrower.update
tt.attacks.range = 160
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "rock_1"
tt.attacks.list[1].cooldown = 2.8
tt.attacks.list[1].shoot_time = fts(9)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].bullet_start_offset = v(0, 46)
tt.attacks.list[1].node_prediction = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 26)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "artillery_base_0001"
tt.render.sprites[2].offset = v(0, 26)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_rock_thrower_loading_stones"
tt.render.sprites[3].name = "play"
tt.render.sprites[3].offsets = {
	v(12, 32),
	v(-12, 32)
}
tt.render.sprites[3].draw_order = 7
tt.render.sprites[3].hide_after_runs = 1
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "tower_rock_thrower_shooter_l1"
tt.render.sprites[4].name = "idleDown"
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	load = {
		"loadUp",
		"loadDown"
	}
}
tt.render.sprites[4].angles_flip_horizontal = {
	true,
	false
}
tt.render.sprites[4].anchor.y = 0
tt.render.sprites[4].offset = v(0, 12)
tt.render.sprites[4].group = "shooters"
tt.sound_events.insert = "ElvesRockTaunt"
tt = E.register_t(E, "tower_rock_thrower_2", "tower_rock_thrower_1")
tt.info.enc_icon = 8
tt.tower.level = 2
tt.tower.price = 220
tt.attacks.range = 175
tt.attacks.list[1].bullet = "rock_2"
tt.attacks.list[1].bullet_start_offset = v(0, 47)
tt.render.sprites[2].name = "artillery_base_0002"
tt.render.sprites[3].offsets = {
	v(12, 33),
	v(-12, 33)
}
tt.render.sprites[4].offset = v(0, 13)
tt.render.sprites[5] = table.deepclone(tt.render.sprites[4])
tt.render.sprites[5].prefix = "tower_rock_thrower_shooter_l2"
tt = E.register_t(E, "tower_rock_thrower_3", "tower_rock_thrower_2")
tt.info.enc_icon = 12
tt.tower.level = 3
tt.tower.price = 320
tt.tower.size = TOWER_SIZE_LARGE
tt.attacks.range = 195
tt.attacks.list[1].bullet = "rock_3"
tt.attacks.list[1].bullet_start_offset = v(0, 51)
tt.render.sprites[2].name = "artillery_base_0003"
tt.render.sprites[3].offsets = {
	v(12, 37),
	v(-12, 37)
}
tt.render.sprites[4].offset = v(0, 17)
tt.render.sprites[5].offset = v(0, 17)
tt.render.sprites[6] = table.deepclone(tt.render.sprites[4])
tt.render.sprites[6].prefix = "tower_rock_thrower_shooter_l3"
tt = E.register_t(E, "tower_druid", "tower")

E.add_comps(E, tt, "attacks", "powers", "barrack")

tt.tower.type = "druid"
tt.tower.level = 1
tt.tower.price = 350
tt.tower.range_offset = v(0, 10)
tt.info.enc_icon = 13
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0012"
tt.info.i18n_key = "TOWER_DRUID_HENGE"
tt.main_script.insert = scripts2.tower_barrack.insert
tt.main_script.update = scripts2.tower_druid.update
tt.main_script.remove = scripts2.tower_druid.remove
tt.attacks.range = 190
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "rock_druid"
tt.attacks.list[1].cooldown = 1.4
tt.attacks.list[1].shoot_time = fts(9)
tt.attacks.list[1].max_loaded_bullets = 3
tt.attacks.list[1].storage_offsets = {
	v(-25, 77),
	v(34, 72),
	v(5, 99)
}
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].sound = "TowerDruidHengeRockThrow"
tt.attacks.list[1].node_prediction = fts(35)
tt.barrack.rally_range = 145
tt.barrack.rally_radius = 25
tt.barrack.soldier_type = "soldier_druid_bear"
tt.barrack.max_soldiers = 1
tt.powers.nature = E.clone_c(E, "power")
tt.powers.nature.price_base = 200
tt.powers.nature.price_inc = 200
tt.powers.nature.max_level = 3
tt.powers.nature.entity = "druid_shooter_nature"
tt.powers.nature.enc_icon = 12
tt.powers.nature.name = "NATURES_FRIEND"
tt.powers.sylvan = E.clone_c(E, "power")
tt.powers.sylvan.price_base = 200
tt.powers.sylvan.price_inc = 200
tt.powers.sylvan.entity = "druid_shooter_sylvan"
tt.powers.sylvan.enc_icon = 13
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 26)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "artillery_base_0005"
tt.render.sprites[2].offset = v(0, 26)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_druid_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootUp",
		"shootDown"
	},
	load = {
		"castUp",
		"castDown"
	}
}
tt.render.sprites[3].anchor.y = 0.08333333333333333
tt.render.sprites[3].offset = v(0, 44)
tt.sound_events.insert = "ElvesRockHengeTaunt"
tt.sound_events.change_rally_point = "SoldierDruidBearRallyChange"
tt = E.register_t(E, "druid_shooter_sylvan", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.render.sprites[1].prefix = "tower_druid_shooter_sylvan"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(-24, 23)
tt.render.sprites[1].anchor.y = 0.06818181818181818
tt.render.sprites[1].draw_order = 2
tt.attacks.list[1] = E.clone_c(E, "spell_attack")
tt.attacks.list[1].spell = "mod_druid_sylvan"
tt.attacks.list[1].cooldown = 10
tt.attacks.list[1].range = 175
tt.attacks.list[1].excluded_templates = {
	"enemy_ogre_magi",
	"enemy_goblin",
	"enemy_zombie",
	"enemy_skeleton",
	"enemy_wolf_small",
	"enemy_halloween_zombie",
	"enemy_spider_tiny",
	"enemy_spider_rotten_tiny"
}
tt.attacks.list[1].cast_time = fts(20)
tt.attacks.list[1].sound = "TowerDruidHengeSylvanCurseCast"
tt.attacks.list[1].vis_flags = bor(F_RANGED, F_MOD)
tt.main_script.update = scripts2.druid_shooter_sylvan.update
tt = E.register_t(E, "druid_shooter_nature", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.render.sprites[1].prefix = "tower_druid_shooter_nature"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(22, 17)
tt.render.sprites[1].anchor.y = 0.15217391304347827
tt.render.sprites[1].draw_order = 2
tt.attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.attacks.list[1].animation = "cast"
tt.attacks.list[1].cooldown = 15
tt.attacks.list[1].entity = "soldier_druid_bear"
tt.attacks.list[1].spawn_time = fts(10)
tt.main_script.update = scripts2.druid_shooter_nature.update
tt = E.register_t(E, "tower_entwood", "tower")

E.add_comps(E, tt, "attacks", "powers")

tt.tower.type = "entwood"
tt.tower.level = 1
tt.tower.price = 400
tt.tower.range_offset = v(0, 10)
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 14
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0011"
tt.main_script.insert = scripts2.tower_entwood.insert
tt.main_script.update = scripts2.tower_entwood.update
tt.attacks.range = 210
tt.attacks.load_time = fts(54)
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "attack1"
tt.attacks.list[1].bullet = "rock_entwood"
tt.attacks.list[1].cooldown = 3.5
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[1].bullet_start_offset = v(-38, 94)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].node_prediction = true
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].bullet = "rock_firey_nut"
tt.attacks.list[2].cooldown = 18
tt.attacks.list[2].animation = "special1"
tt.attacks.list[3] = E.clone_c(E, "area_attack")
tt.attacks.list[3].animation = "special2"
tt.attacks.list[3].cooldown = 14
tt.attacks.list[3].damage_bans = F_FLYING
tt.attacks.list[3].damage_flags = F_AREA
tt.attacks.list[3].damage_radius = 240
tt.attacks.list[3].damage_type = DAMAGE_TRUE
tt.attacks.list[3].hit_time = fts(20)
tt.attacks.list[3].min_count = 2
tt.attacks.list[3].range = 210
tt.attacks.list[3].sound = "TowerEntwoodClobber"
tt.attacks.list[3].stun_chances = {
	1,
	1,
	1,
	1
}
tt.attacks.list[3].stun_mod = "mod_clobber"
tt.attacks.list[3].vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[3].vis_flags = F_RANGED
tt.powers.clobber = E.clone_c(E, "power")
tt.powers.clobber.price_base = 200
tt.powers.clobber.price_inc = 200
tt.powers.clobber.attack_idx = 3
tt.powers.clobber.stun_durations = {
	1,
	2,
	3
}
tt.powers.clobber.damage_values = {
	50,
	75,
	100
}
tt.powers.clobber.enc_icon = 14
tt.powers.fiery_nuts = E.clone_c(E, "power")
tt.powers.fiery_nuts.price_base = 300
tt.powers.fiery_nuts.price_inc = 300
tt.powers.fiery_nuts.attack_idx = 2
tt.powers.fiery_nuts.enc_icon = 15
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)

for i = 2, 10, 1 do
	tt.render.sprites[i] = E.clone_c(E, "sprite")
	tt.render.sprites[i].prefix = "tower_entwood_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 42)
	tt.render.sprites[i].group = "layers"
	tt.render.sprites[i].loop = false
end

tt.render.sprites[11] = E.clone_c(E, "sprite")
tt.render.sprites[11].name = "tower_entwood_blink"
tt.render.sprites[11].loop = false
tt.render.sprites[11].offset = v(0, 42)
tt.sound_events.insert = "ElvesRockEntwoodTaunt"
tt = E.register_t(E, "tower_elven_barrack_1", "tower")

E.add_comps(E, tt, "barrack")

tt.barrack.rally_range = 145
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "soldier_barrack_1"
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)
tt.info.enc_icon = 2
tt.info.fn = scripts2.tower_barrack.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0002"
tt.main_script.insert = scripts2.tower_barrack.insert
tt.main_script.remove = scripts2.tower_barrack.remove
tt.main_script.update = scripts2.tower_barrack.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "barracks_towers_layer1_0001"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 34)
tt.render.sprites[3].prefix = "tower_elven_barrack_1_door"
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "ElvesBarrackTaunt"
tt.sound_events.insert = "ElvesBarrackTaunt"
tt.tower.level = 1
tt.tower.price = 80
tt.tower.type = "elven_barrack"
tt = E.register_t(E, "tower_elven_barrack_1_s", "tower")

E.add_comps(E, tt, "barrack")

tt.barrack.rally_range = 175
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "soldier_barrack_3"
tt.barrack.max_soldiers = 3
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)
tt.info.enc_icon = 2
tt.info.fn = scripts2.tower_barrack.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0002"
tt.main_script.insert = scripts2.tower_barrack.insert
tt.main_script.remove = scripts2.tower_barrack.remove
tt.main_script.update = scripts2.tower_barrack.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "barracks_towers_layer1_0051"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 34)
tt.render.sprites[3].prefix = "tower_elven_barrack_3_door"
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "ElvesBarrackTaunt"
tt.tower.level = 1
tt.tower.price = 0
tt.tower.type = "tower_elven_barrack_1_s"
tt = E.register_t(E, "tower_elven_barrack_1_b", "tower")

E.add_comps(E, tt, "barrack")

tt.barrack.rally_range = 175
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "soldier_barrack_3"
tt.barrack.max_soldiers = 3
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)
tt.info.fn = scripts2.tower_barrack.get_info
tt.main_script.insert = scripts2.tower_barrack.insert
tt.main_script.remove = scripts2.tower_barrack.remove
tt.main_script.update = scripts2.tower_barrack.update
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0002"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "barracks_towers_layer1_0051"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 34)
tt.render.sprites[3].prefix = "tower_elven_barrack_3_door"
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "ElvesBarrackTaunt"
tt.tower.level = 1
tt.tower.price = 0
tt.tower.type = "tower_elven_barrack_1_b"
tt = E.register_t(E, "tower_archer_1_b", "tower")

AC(tt, "attacks")

tt.tower.type = "tower_archer_1_b"
tt.tower.level = 1
tt.tower.price = 0
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0001"
tt.info.enc_icon = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_tower_0003"
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooterarcherlvl3"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(-9, 57)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "shooterarcherlvl3"
tt.render.sprites[4].name = "idleDown"
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[4].offset = v(9, 57)
tt.main_script.insert = scripts.tower_archer.insert
tt.main_script.update = scripts.tower_archer.update
tt.main_script.remove = scripts.tower_archer.remove
tt.attacks.range = 220
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "arrow_3"
tt.attacks.list[1].cooldown = 0.5
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(-10, 50),
	v(10, 50)
}
tt = E.register_t(E, "tower_archer_1_d", "tower")

AC(tt, "attacks")

tt.tower.type = "tower_archer_1_d"
tt.tower.level = 1
tt.tower.price = 0
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0001"
tt.info.enc_icon = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_tower_0003"
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooterarcherlvl3"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(-9, 57)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "shooterarcherlvl3"
tt.render.sprites[4].name = "idleDown"
tt.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[4].offset = v(9, 57)
tt.main_script.insert = scripts.tower_archer.insert
tt.main_script.update = scripts.tower_archer.update
tt.main_script.remove = scripts.tower_archer.remove
tt.attacks.range = 220
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "arrow_3"
tt.attacks.list[1].cooldown = 0.5
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(-10, 50),
	v(10, 50)
}
tt = E.register_t(E, "tower_engineer_1_s", "tower")

AC(tt, "attacks")

tt.tower.type = "tower_engineer_1_s"
tt.tower.level = 1
tt.tower.price = 0
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0004") or "info_portraits_towers_0003"
tt.info.enc_icon = 4
tt.main_script.insert = scripts.tower_engineer.insert
tt.main_script.update = scripts.tower_engineer.update
tt.attacks.range = 199.20000000000002
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "bomb_black"
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].shoot_time = fts(12)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].bullet_start_offset = v(0, 57)
tt.attacks.list[1].node_prediction = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 15)

for i = 2, 8, 1 do
	tt.render.sprites[i] = E.clone_c(E, "sprite")
	tt.render.sprites[i].prefix = "towerengineerlvl3_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 43)
end

tt = E.register_t(E, "tower_engineer_1_o", "tower")

AC(tt, "attacks")

tt.tower.type = "tower_engineer_1_o"
tt.tower.level = 1
tt.tower.price = 0
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0004") or "info_portraits_towers_0003"
tt.info.enc_icon = 4
tt.main_script.insert = scripts.tower_engineer.insert
tt.main_script.update = scripts.tower_engineer.update
tt.attacks.range = 199.20000000000002
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "bomb_black"
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].shoot_time = fts(12)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[1].bullet_start_offset = v(0, 57)
tt.attacks.list[1].node_prediction = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_%04i"
tt.render.sprites[1].offset = v(0, 15)

for i = 2, 8, 1 do
	tt.render.sprites[i] = E.clone_c(E, "sprite")
	tt.render.sprites[i].prefix = "towerengineerlvl3_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 43)
end

tt = E.register_t(E, "tower_mage_1_a", "tower")

AC(tt, "attacks")

tt.tower.type = "tower_mage_1_a"
tt.tower.level = 1
tt.tower.price = 0
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0003") or "info_portraits_towers_0010"
tt.info.enc_icon = 3
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.insert = scripts.tower_mage.insert
tt.main_script.update = scripts.tower_mage.update
tt.attacks.range = 200
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_3"
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].bullet_start_offset = {
	v(8, 70),
	v(-5, 69)
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "towermagelvl3"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shootermage"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(1, 62)
tt.render.sid_tower = 2
tt.render.sid_shooter = 3
tt = E.register_t(E, "tower_mage_1_d", "tower")

AC(tt, "attacks")

tt.tower.type = "tower_mage_1_d"
tt.tower.level = 1
tt.tower.price = 0
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0003") or "info_portraits_towers_0010"
tt.info.enc_icon = 3
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.insert = scripts.tower_mage.insert
tt.main_script.update = scripts.tower_mage.update
tt.attacks.range = 200
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_3"
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].bullet_start_offset = {
	v(8, 70),
	v(-5, 69)
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "towermagelvl3"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shootermage"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(1, 62)
tt.render.sid_tower = 2
tt.render.sid_shooter = 3
tt = E.register_t(E, "tower_barrack_2_g", "tower")

AC(tt, "barrack")

tt.tower.type = "tower_barrack_2_g"
tt.tower.level = 1
tt.tower.price = 0
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0002") or "info_portraits_towers_0007"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_barracks_lvl3_layer1_0001"
tt.render.sprites[2].offset = v(0, 38)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "towerbarracklvl3_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 38)
tt.barrack.soldier_type = "soldier_knight"
tt.barrack.rally_range = 175
tt.barrack.max_soldiers = 3
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_barrack.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.change_rally_point = "BarrackTaunt"
tt = E.register_t(E, "tower_barrack_2_f", "tower")

AC(tt, "barrack")

tt.tower.type = "tower_barrack_2_f"
tt.tower.level = 1
tt.tower.price = 0
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0002") or "info_portraits_towers_0007"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_barracks_lvl3_layer1_0001"
tt.render.sprites[2].offset = v(0, 38)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "towerbarracklvl3_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 38)
tt.barrack.soldier_type = "soldier_knight"
tt.barrack.rally_range = 175
tt.barrack.max_soldiers = 3
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_barrack.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.change_rally_point = "BarrackTaunt"
tt = E.register_t(E, "tower_elven_barrack_2", "tower_elven_barrack_1")
tt.info.enc_icon = 6
tt.barrack.soldier_type = "soldier_barrack_2"
tt.render.sprites[2].name = "barracks_towers_layer1_0026"
tt.render.sprites[3].prefix = "tower_elven_barrack_2_door"
tt.tower.level = 2
tt.tower.price = 160
tt = E.register_t(E, "tower_elven_barrack_3", "tower_elven_barrack_1")
tt.info.enc_icon = 10
tt.barrack.soldier_type = "soldier_barrack_3"
tt.render.sprites[2].name = "barracks_towers_layer1_0051"
tt.render.sprites[3].prefix = "tower_elven_barrack_3_door"
tt.tower.level = 3
tt.tower.price = 250
tt = E.register_t(E, "soldier_barrack_1", "soldier_militia")

E.add_comps(E, tt, "revive")

image_y = 46
anchor_y = 0.25
tt.health.armor = 0.3
tt.health.dead_lifetime = 14
tt.health.hp_max = 50
tt.health_bar.offset = v(0, 27)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = "portraits_sc_0133"
tt.info.random_name_count = 25
tt.info.random_name_format = "ELVES_SOLDIER_BARRACKS_%i_NAME"
tt.main_script.insert = scripts.soldier_barrack.insert
tt.main_script.remove = scripts.soldier_barrack.remove
tt.main_script.update = scripts.soldier_barrack.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].pop = {
	"pop_elven_barrack1",
	"pop_elven_barrack2"
}
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 7
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldier_barrack_1"
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt = E.register_t(E, "soldier_barrack_2", "soldier_barrack_1")

E.add_comps(E, tt, "ranged")

image_y = 46
anchor_y = 0.25
tt.health.armor = 0.4
tt.health.hp_max = 90
tt.health_bar.offset = v(0, 27)
tt.info.portrait = "portraits_sc_0134"
tt.melee.attacks[1].damage_max = 8
tt.melee.attacks[1].damage_min = 4
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet = "arrow_soldier_barrack_2"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 10)
}
tt.ranged.attacks[1].cooldown = fts(15) + 1.2
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = fts(5)
tt.regen.health = 15
tt.render.sprites[1].prefix = "soldier_barrack_2"
tt = E.register_t(E, "soldier_barrack_3", "soldier_barrack_2")
image_y = 46
anchor_y = image_y/11
tt.health.armor = 0.5
tt.health.hp_max = 140
tt.health_bar.offset = v(0, 32)
tt.info.portrait = "portraits_sc_0135"
tt.melee.attacks[1].damage_max = 12
tt.melee.attacks[1].damage_min = 10
tt.ranged.attacks[1].bullet = "arrow_soldier_barrack_3"
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 25
tt.regen.health = 15
tt.render.sprites[1].prefix = "soldier_barrack_3"
tt.unit.mod_offset = v(0, 12)
tt = E.register_t(E, "soldier_druid_bear", "soldier")

E.add_comps(E, tt, "melee", "count_group")

tt.count_group.name = "soldier_druid_bear"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.health.armor = 0.4
tt.health.magic_armor = 0.5
tt.health.hp_max = 350
tt.health_bar.offsets = {
	idle = v(0, 40),
	standing = v(0, 55)
}
tt.health_bar.offset = tt.health_bar.offsets.idle
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 10
tt.info.fn = scripts2.soldier_barrack.get_info
tt.info.portrait = "portraits_sc_0132"
tt.info.random_name_format = "ELVES_SOLDIER_BEAR_%i_NAME"
tt.info.random_name_count = 2
tt.main_script.insert = scripts2.soldier_barrack.insert
tt.main_script.update = scripts2.soldier_druid_bear.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "TowerDruidHengeBearAttack"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.cooldown = 0.5
tt.regen.health = 25
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = 0.28125
tt.render.sprites[1].angles = {
	walk = {
		"walk"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_druid_bear"
tt.soldier.melee_slot_offset = v(10, 0)
tt.sound_events.insert = "TowerDruidHengeBearSummon"
tt.sound_events.death = "TowerDruidHengeBearDeath"
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_EAT, F_POISON, F_LYCAN, F_POLYMORPH)
tt = RT("tower_barrack_1", "tower")

AC(tt, "barrack")

tt.tower.type = "barrack"
tt.tower.level = 1
tt.tower.price = 70
tt.info.fn = scripts.tower_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0002") or "info_portraits_towers_0007"
tt.info.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "tower_barracks_lvl1_layer1_0001"
tt.render.sprites[2].offset = v(0, 38)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "towerbarracklvl1_door"
tt.render.sprites[3].name = "close"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 38)
tt.barrack.soldier_type = "soldier_militia"
tt.barrack.rally_range = 145
tt.barrack.max_soldiers = 3
tt.barrack.respawn_offset = v(0, 0)
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_barrack.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.insert = "BarrackTaunt"
tt.sound_events.change_rally_point = "BarrackTaunt"
tt = RT("tower_barrack_2", "tower_barrack_1")
tt.info.enc_icon = 6
tt.tower.level = 2
tt.tower.price = 110
tt.render.sprites[2].name = "tower_barracks_lvl2_layer1_0001"
tt.render.sprites[3].prefix = "towerbarracklvl2_door"
tt.barrack.soldier_type = "soldier_footmen"
tt = RT("tower_barrack_3", "tower_barrack_1")
tt.info.enc_icon = 10
tt.tower.level = 3
tt.tower.price = 160
tt.render.sprites[2].name = "tower_barracks_lvl3_layer1_0001"
tt.render.sprites[3].prefix = "towerbarracklvl3_door"
tt.barrack.soldier_type = "soldier_knight"
tt = RT("tower_arcane_wizard", "tower_mage_1")

AC(tt, "attacks", "powers")

image_y = 90
tt.tower.type = "arcane_wizard"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 15
tt.info.i18n_key = "TOWER_ARCANE"
tt.info.fn = scripts.tower_arcane_wizard.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0005") or "info_portraits_towers_0008"
tt.powers.disintegrate = CC("power")
tt.powers.disintegrate.price_base = 300
tt.powers.disintegrate.price_inc = 175
tt.powers.disintegrate.cooldown_base = 22
tt.powers.disintegrate.cooldown_inc = -2
tt.powers.disintegrate.enc_icon = 15
tt.powers.disintegrate.name = "DESINTEGRATE"
tt.powers.teleport = CC("power")
tt.powers.teleport.price_base = 300
tt.powers.teleport.price_inc = 100
tt.powers.teleport.max_count_base = 3
tt.powers.teleport.max_count_inc = 1
tt.powers.teleport.enc_icon = 16
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_arcane_wizard"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 40)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_arcane_wizard_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	teleport = {
		"teleportUp",
		"teleportDown"
	}
}
tt.render.sprites[3].offset = v(0, 58)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_arcane_wizard_teleport"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(-1, 90)
tt.main_script.update = scripts.tower_arcane_wizard.update
tt.sound_events.insert = "MageArcaneTaunt"
tt.attacks.range = 200
tt.attacks.min_cooldown = 2
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "ray_arcane"
tt.attacks.list[1].cooldown = 2
tt.attacks.list[1].node_prediction = fts(5)
tt.attacks.list[1].shoot_time = fts(20)
tt.attacks.list[1].bullet_start_offset = v(0, 76)
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].bullet = "ray_arcane_disintegrate"
tt.attacks.list[2].cooldown = 20
tt.attacks.list[2].vis_flags = bor(F_DISINTEGRATED)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[3] = CC("aura_attack")
tt.attacks.list[3].animation = "teleport"
tt.attacks.list[3].shoot_time = fts(4)
tt.attacks.list[3].cooldown = 10
tt.attacks.list[3].aura = "aura_teleport_arcane"
tt.attacks.list[3].min_nodes = 15
tt.attacks.list[3].node_prediction = fts(4)
tt.attacks.list[3].vis_flags = bor(F_RANGED, F_MOD, F_TELEPORT)
tt.attacks.list[3].vis_bans = bor(F_BOSS, F_FREEZE)
tt = RT("tower_sorcerer", "tower_mage_1")

AC(tt, "attacks", "powers", "barrack")

image_y = 74
tt.tower.type = "sorcerer"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 19
tt.info.i18n_key = "TOWER_SORCERER"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0006") or "info_portraits_towers_0011"
tt.barrack.soldier_type = "soldier_elemental"
tt.barrack.rally_range = 180
tt.powers.polymorph = CC("power")
tt.powers.polymorph.price_base = 325
tt.powers.polymorph.price_inc = 175
tt.powers.polymorph.cooldown_base = 22
tt.powers.polymorph.cooldown_inc = -2
tt.powers.polymorph.enc_icon = 1
tt.powers.polymorph.name = "POLIMORPH"
tt.powers.elemental = CC("power")
tt.powers.elemental.price_base = 350
tt.powers.elemental.price_inc = 150
tt.powers.elemental.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_sorcerer"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_sorcerer_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	polymorph = {
		"polymorphUp",
		"polymorphDown"
	}
}
tt.render.sprites[3].offset = v(1, 64)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_sorcerer_polymorph"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(0, 80)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].hide_after_runs = 1
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_sorcerer.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.insert = "MageSorcererTaunt"
tt.sound_events.change_rally_point = "RockElementalRally"
tt.attacks.range = 200
tt.attacks.min_cooldown = 1.5
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_sorcerer"
tt.attacks.list[1].bullet_start_offset = {
	v(8, 68),
	v(-6, 68)
}
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(11)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].bullet_start_offset = {
	v(0, 78),
	v(0, 78)
}
tt.attacks.list[2].animation = "polymorph"
tt.attacks.list[2].bullet = "ray_sorcerer_polymorph"
tt.attacks.list[2].cooldown = 20
tt.attacks.list[2].shoot_time = fts(9)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED, F_POLYMORPH)
tt = RT("tower_time_wizard", "tower_mage_1")

AC(tt, "attacks", "powers", "barrack")

image_y = 74
tt.tower.type = "time_wizard"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 19
tt.info.i18n_key = "TOWER_TIME_WIZARD"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0006") or "info_portraits_towers_0011"
tt.barrack.soldier_type = "soldier_time_traveler"
tt.barrack.rally_range = 180
tt.powers.polymorph = CC("power")
tt.powers.polymorph.price_base = 325
tt.powers.polymorph.price_inc = 175
tt.powers.polymorph.cooldown_base = 22
tt.powers.polymorph.cooldown_inc = -2
tt.powers.polymorph.enc_icon = 1
tt.powers.polymorph.name = "SANDSTORM"
tt.powers.elemental = CC("power")
tt.powers.elemental.price_base = 350
tt.powers.elemental.price_inc = 150
tt.powers.elemental.enc_icon = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_time_wizard"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_time_wizard_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	sandstorm = {
		"sandstormUp",
		"sandstormDown"
	}
}
tt.render.sprites[3].offset = v(1, 64)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_time_wizard_polymorph"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(0, 80)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].hide_after_runs = 1
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = scripts.tower_sorcerer.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.insert = "MageTimeWizardTaunt"
tt.sound_events.change_rally_point = "RockElementalRally"
tt.attacks.range = 275
tt.attacks.min_cooldown = 0.5
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_time_wizard"
tt.attacks.list[1].bullet_start_offset = {
	v(8, 84),
	v(-6, 84)
}
tt.attacks.list[1].cooldown = 2
tt.attacks.list[1].shoot_time = fts(7)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].bullet_start_offset = {
	v(8, 84),
	v(-6, 84)
}
tt.attacks.list[2].animation = "sandstorm"
tt.attacks.list[2].bullet = "time_wizard_sandstorm"
tt.attacks.list[2].cooldown = 1
tt.attacks.list[2].shoot_time = fts(7)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED, F_POLYMORPH)
tt = RT("tower_sorcerer_cheat", "tower_mage_1")

AC(tt, "attacks", "powers", "barrack")

image_y = 74
tt.tower.type = "sorcerer"
tt.tower.level = 1
tt.tower.price = 0
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 19
tt.info.i18n_key = "TOWER_SORCERER"
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_towers_0006" or "info_portraits_towers_0011"
tt.barrack.soldier_type = "soldier_elemental_cheat"
tt.barrack.rally_range = 250
tt.powers.polymorph = CC("power")
tt.powers.polymorph.price_base = 0
tt.powers.polymorph.price_inc = 0
tt.powers.polymorph.cooldown_base = 22
tt.powers.polymorph.cooldown_inc = -2
tt.powers.polymorph.enc_icon = 1
tt.powers.polymorph.name = "POLIMORPH"
tt.powers.elemental = CC("power")
tt.powers.elemental.price_base = 0
tt.powers.elemental.price_inc = 0
tt.powers.elemental.enc_icon = 2
tt.powers.elemental.max_level = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_sorcerer"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[2].shader = "p_tint"
tt.render.sprites[2].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_sorcerer_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	polymorph = {
		"polymorphUp",
		"polymorphDown"
	}
}
tt.render.sprites[3].offset = v(1, 64)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_sorcerer_polymorph"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(0, 80)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].hide_after_runs = 1
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = mylua.tower_sorcerer.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.insert = "MageSorcererTaunt"
tt.sound_events.change_rally_point = "RockElementalRally"
tt.attacks.range = 280
tt.attacks.min_cooldown = 1.2
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_sorcerer_cheat"
tt.attacks.list[1].count = 3
tt.attacks.list[1].entity = "re_farmer_sorcerer"
tt.attacks.list[1].entity_chance = 0.3
tt.attacks.list[1].bullet_start_offset = {
	v(8, 68),
	v(-6, 68)
}
tt.attacks.list[1].cooldown = 1.2
tt.attacks.list[1].shoot_time = fts(11)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].entity_chance = 0.33
tt.attacks.list[2].bullet_start_offset = {
	v(0, 78),
	v(0, 78)
}
tt.attacks.list[2].animation = "polymorph"
tt.attacks.list[2].entity = "soldier_gryphon_guard666"
tt.attacks.list[2].bullet = "ray_sorcerer_polymorph"
tt.attacks.list[2].count = 3
tt.attacks.list[2].cooldown = 13
tt.attacks.list[2].shoot_time = fts(9)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED, F_POLYMORPH)
tt = E.register_t(E, "soldier_militia2", "soldier_militia")

E.add_comps(E, tt, "melee", "auras")

image_y = 52
anchor_y = 0.17
tt.health.dead_lifetime = 10
tt.health.hp_max = 1
tt.health_bar.offset = v(0, 25.16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = "info_portraits_sc_0017"
tt.info.random_name_count = 40
tt.info.random_name_format = "SOLDIER_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_soldier_death_spawns2"
tt.auras.list[1].cooldown = 0
tt.melee.range = 60
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 5
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia"
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))
tt = RT("soldier_elemental_cheat", "soldier_militia")

AC(tt, "melee")

image_y = 64
anchor_y = 0.15384615384615385
tt.health.armor = 0.4
tt.health.armor_inc = 0.25
tt.health.dead_lifetime = 10
tt.health.hp_max = 3000
tt.health.hp_inc = 1000
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "SOLDIER_ELEMENTAL"
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0017" or "info_portraits_sc_0017"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 9e+99
tt.melee.attacks[1].damage_inc = 150
tt.melee.attacks[1].damage_max = 200
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].damage_radius = 66.6
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].mod = "mod_10yr_stun"
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.5
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].pop_chance = 1
tt.melee.attacks[2].chance = 0.1
tt.melee.attacks[2].chance_inc = 0.05
tt.melee.attacks[2].damage_type = DAMAGE_EXPLOSION
tt.melee.attacks[2].damage_inc = 300
tt.melee.attacks[2].damage_max = 500
tt.melee.attacks[2].damage_min = 300
tt.melee.attacks[2].mod = "mod_10yr_stun"
tt.melee.range = 87
tt.motion.max_speed = 30
tt.speed_inc = 10
tt.regen.health = 200
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_elemental"
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "RockElementalDeath"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)
tt = E.register_t(E, "soldier_gryphon_guard666", "soldier_militia")

E.add_comps(E, tt, "ranged")

tt.health.hp_max = 1
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health_bar = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 0
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "bolt_3_golden"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 10)
}
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].max_range = 200
tt.ranged.attacks[1].min_range = 1
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].prefix = "soldier_gryphon_guard666"
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt.ui = nil
tt.unit.hit_offset = v(0, 10)
tt.unit.level = 1
tt.unit.mod_offset = v(0, 21)
tt.vis.bans = bor(tt.vis.bans, F_RANGED)
tt.vis.bans = bor(F_BLOCK, F_RANGED)
tt = E.register_t(E, "tower_necromancer", "tower")

E.add_comps(E, tt, "barrack", "attacks", "powers", "auras", "tween")

tt.tower.type = "necromancer"
tt.tower.level = 1
tt.tower.price = 300
tt.info.fn = scripts3.tower_mage.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "1111"
tt.info.enc_icon = 15
tt.powers.pestilence = E.clone_c(E, "power")
tt.powers.pestilence.price_base = 250
tt.powers.pestilence.price_inc = 200
tt.powers.pestilence.enc_icon = 35
tt.powers.rider = E.clone_c(E, "power")
tt.powers.rider.price_base = 300
tt.powers.rider.price_inc = 100
tt.powers.rider.enc_icon = 34
tt.main_script.insert = scripts3.tower_necromancer.insert
tt.main_script.update = scripts3.tower_necromancer.update
tt.main_script.remove = scripts3.tower_barrack.remove
tt.barrack.soldier_type = "soldier_death_rider"
tt.barrack.rally_range = 179.20000000000002
tt.attacks.range = 198.4
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "bolt_necromancer_2"
tt.attacks.list[1].cooldown = 1
tt.attacks.list[1].shoot_time = fts(3)
tt.attacks.list[1].bullet_start_offset = {
  v(9, 71),
  v(-9, 71)
}
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].bullet = "pestilence"
tt.attacks.list[2].cooldown = 15
tt.attacks.list[2].shoot_time = fts(6)
tt.attacks.list[2].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_POISON)
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "necromancer_aura"
tt.auras.list[1].cooldown = 0
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 7)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "NecromancerTower"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooternecromancer"
tt.render.sprites[3].angles = {
  idle = {
    "idleUp",
    "idleDown"
  },
  shoot_start = {
    "shootStartUp",
    "shootStartDown"
  },
  shoot_loop = {
    "shootLoopUp",
    "shootLoopDown"
  },
  shoot_end = {
    "shootEndUp",
    "shootEndDown"
  },
  pestilence = {
    "pestilenceUp",
    "pestilenceDown"
  }
}
tt.render.sprites[3].offset = v(0, 60)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].animated = false
tt.render.sprites[4].name = "NecromancerTowerGlow"
tt.render.sprites[4].offset = v(0, 34)
tt.render.sprites[4].hidden = true
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].name = "towernecromancer_fx"
tt.render.sprites[5].offset = v(0, 52)
tt.render.sprites[5].hidden = true
tt.tween.remove = false
tt.tween.reverse = false
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
  {
    0,
    0
  },
  {
    1,
    255
  }
}
tt.tween.props[1].sprite_id = 4
tt.skeletons_count = 0
tt.sound_events.insert = "NecromancerTauntReady"
tt.sound_events.change_rally_point = "DeathKnightTaunt"
tt = E.register_t(E, "bolt_necromancer_2", "bolt")
tt.render.sprites[1].prefix = "bolt_necromancer"
tt.bullet.damage_min = 20
tt.bullet.damage_max = 70
tt.bullet.hit_fx = "fx_bolt_necromancer2_hit"
tt.bullet.particles_name = "ps_bolt_necromancer_trail"
tt.bullet.pop = {
	"pop_sishh"
}
tt.sound_events.insert = "NecromancerBolt"
local fx_bolt_necromancer_hit = E.register_t(E, "fx_bolt_necromancer2_hit", "fx")
fx_bolt_necromancer_hit.render.sprites[1].name = "bolt_necromancer_hit"
tt = E.register_t(E, "ps_bolt_necromancer_trail")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "proy_Necromancer_particle"
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
	0.4,
	2
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_x = {
	1,
	3.5
}
tt.particle_system.scales_y = {
	1,
	3.5
}
tt.particle_system.scale_var = {
	0.45,
	0.9
}
tt.particle_system.scale_same_aspect = false
tt.particle_system.emit_spread = math.pi
tt.particle_system.emission_rate = 30
tt = E.register_t(E, "pestilence", "aura")
tt.aura.mod = "mod_pestilence"
tt.aura.duration = 1
tt.aura.duration_inc = 3
tt.aura.cycle_time = fts(10)
tt.aura.radius = 75
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD, F_POISON)
tt.main_script.insert = scripts3.pestilence.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.sound_events.insert = "NecromancerPestilence"
tt = E.register_t(E, "soldier_death_rider", "soldier")

E.add_comps(E, tt, "melee", "auras")

tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "death_rider_aura"
tt.health.armor = 0.3
tt.health.armor_inc = 0.1
tt.health.dead_lifetime = 12
tt.health.hp_inc = 50
tt.health.hp_max = 200
tt.health_bar.offset = v(0, 47.76)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts3.soldier_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0006") or "info_portraits_soldiers_0006"
tt.main_script.insert = scripts3.soldier_barrack.insert
tt.main_script.update = scripts3.soldier_barrack.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_inc = 10
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 76.8
tt.motion.max_speed = 100
tt.regen.cooldown = 1
tt.regen.health = 25
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = 0.18
tt.render.sprites[1].angles = {
  walk = {
    "running"
  }
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_death_rider"
tt.soldier.melee_slot_offset = v(15, 0)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POLYMORPH, F_POISON, F_LYCAN, F_CANNIBALIZE)
tt = E.register_t(E, "soldier_time_traveler", "soldier")

E.add_comps(E, tt, "melee", "ranged", "auras")
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "time_traveler_aura"
tt.health.armor = 0.3
tt.health.armor_inc = 0.1
tt.health.dead_lifetime = 12
tt.health.hp_inc = 50
tt.health.hp_max = 20000
tt.health_bar.offset = v(0, 47.76)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts3.soldier_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0006") or "info_portraits_soldiers_0006"
tt.main_script.insert = scripts3.soldier_barrack.insert
tt.main_script.update = scripts3.soldier_barrack.update
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].damage_inc = 10
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].mod = "mod_teleport_arcane"
tt.melee.range = 76.8
tt.motion.max_speed = 100
tt.regen.cooldown = 1
tt.regen.health = 25
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = 0.18
tt.render.sprites[1].angles = {
  walk = {
    "running"
  }
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_death_rider"
tt.soldier.melee_slot_offset = v(15, 0)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POLYMORPH, F_POISON, F_LYCAN, F_CANNIBALIZE)
tt = E.register_t(E, "death_rider_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = "mod_death_rider"
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 128
tt.aura.track_source = true
tt.aura.allowed_templates = {
  "soldier_skeleton",
  "soldier_skeleton_knight",
  "soldier_sand_warrior",
  "soldier_dracolich_golem",
  "soldier_elemental",
  "soldier_frankenstein",
  "soldier_ingvar_ancestor",
  "soldier_magnus_illusion"
}
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.render.sprites[1].name = "soldier_death_rider_aura"
tt.render.sprites[1].loop = true
tt = E.register_t(E, "time_traveler_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = "mod_time_traveler"
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 275
tt.aura.track_source = true
tt.aura.allowed_templates = {
  "soldier_skeleton",
  "soldier_skeleton_knight",
  "soldier_sand_warrior",
  "soldier_dracolich_golem",
  "soldier_elemental",
  "soldier_frankenstein",
  "soldier_ingvar_ancestor",
  "soldier_magnus_illusion",
  "hero_gerald",
  "reinforcement"
}
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.render.sprites[1].name = "soldier_death_rider_aura"
tt.render.sprites[1].loop = true
tt = E.register_t(E, "necromancer_aura", "aura")
tt.main_script.update = scripts3.necromancer_aura.update
tt.aura.cycle_time = 0.5
tt.aura.duration = -1
tt.min_health_for_knight = 500
tt.count_group_name = "skeletons"
tt.count_group_type = COUNT_GROUP_CONCURRENT
tt.count_group_max = 30
tt.max_skeletons_tower = 8
tt = E.register_t(E, "mod_death_rider", "modifier")

E.add_comps(E, tt, "render")

tt.inflicted_damage_factor = 1.5
tt.extra_armor = 0.3
tt.modifier.duration = 1
tt.modifier.use_mod_offset = false
tt.render.sprites[1].name = "NecromancerSkeletonAura"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.main_script.insert = scripts3.mod_death_rider.insert
tt.main_script.remove = scripts3.mod_death_rider.remove
tt.main_script.update = scripts3.mod_track_target.update
tt = E.register_t(E, "soldier_skeleton", "soldier_militia")

E.add_comps(E, tt, "count_group")

anchor_y = 0.18
image_y = 38
tt.count_group.name = "skeletons"
tt.health.dead_lifetime = 3
tt.health.hp_max = 40
tt.health_bar.offset = v(0, ady(38))
tt.info.fn = scripts3.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_soldiers_0007"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 1
tt.melee.range = 51.2
tt.regen = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_skeleton"
tt.sound_events.insert = "NecromancerSummon"
tt.vis.bans = bor(F_POLYMORPH, F_CANNIBALIZE, F_POISON, F_LYCAN)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.marker_offset = v(0, ady(7))
tt.unit.mod_offset = v(0, ady(18))
tt = E.register_t(E, "soldier_skeleton_knight", "soldier_skeleton")

E.add_comps(E, tt, "count_group")

anchor_y = 0.18
image_y = 50
tt.count_group.name = "skeletons"
tt.health.armor = 0.3
tt.health.hp_max = 80
tt.health_bar.offset = v(0, ady(47))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0008") or "info_portraits_soldiers_0008"
tt.info.random_name_format = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 2
tt.melee.range = 38.4
tt.render.sprites[1].anchor.y = 0.18
tt.render.sprites[1].prefix = "soldier_skeleton_knight"
tt.sound_events.insert = "NecromancerSummon"
tt = E.register_t(E, "soldier_skeleton_knight2", "soldier_militia")

E.add_comps(E, tt, "melee", "nav_path")

anchor_y = 0.18
image_y = 50
tt.health.armor = 0.75
tt.health.hp_max = 400
tt.health_bar.offset = v(0, ady(47))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0008") or "info_portraits_soldiers_0008"
tt.main_script.update = mylua.walk_soldier.update
tt.nav_path.dir = -1
tt.info.i18n_key = "BIO"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.enc_icon = 43
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
"twoface_spawns"
}
tt.melee.attacks[1].pop_chance = 0.04
tt.melee.attacks[1].mod = "mod_twoface_damage_extra"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].sound = "TwoFaceAttackSound"
tt.melee.attacks[2].mod = "mod_possess"
tt.melee.attacks[2].chance = 0.05
tt.melee.range = 63
tt.regen.cooldown = 1
tt.regen.health = 20
tt.motion.max_speed = FPS*3.5
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf514"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.render.sprites[1].alpha = 180
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_POLYMORPH, F_CANNIBALIZE, F_POISON, F_LYCAN)
tt = E.register_t(E, "soldier_skeleton2", "soldier_militia")

E.add_comps(E, tt, "melee", "nav_path")

anchor_y = 0.18
image_y = 50
tt.health.armor = 0
tt.health.hp_max = 250
tt.health_bar.offset = v(0, ady(47))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0008") or "info_portraits_soldiers_0008"
tt.main_script.update = mylua.walk_soldier.update
tt.nav_path.dir = -1
tt.info.i18n_key = "BIO"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.enc_icon = 43
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.range = 63
tt.regen.cooldown = 1
tt.regen.health = 20
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "soldier_skeleton"
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_POLYMORPH, F_CANNIBALIZE, F_POISON, F_LYCAN)
tt = E.register_t(E, "tower_archmage", "tower")

E.add_comps(E, tt, "attacks", "powers")

tt.tower.type = "archmage"
tt.tower.level = 1
tt.tower.price = 300
tt.info.fn = scripts.tower_mage.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "1124"
tt.info.enc_icon = 16
tt.powers.twister = E.clone_c(E, "power")
tt.powers.twister.price_base = 300
tt.powers.twister.price_inc = 200
tt.powers.twister.enc_icon = 32
tt.powers.blast = E.clone_c(E, "power")
tt.powers.blast.price_base = 200
tt.powers.blast.price_inc = 200
tt.powers.blast.name = "CRITICAL"
tt.powers.blast.enc_icon = 33
tt.main_script.insert = scripts3.tower_archmage.insert
tt.main_script.remove = scripts3.tower_archmage.remove
tt.main_script.update = scripts3.tower_archmage.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "ArchMageTower"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooterarchmage"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
  idle = {
    "idleUp",
    "idleDown"
  },
  shoot = {
    "shootingUp",
    "shootingDown"
  },
  twister = {
    "twisterUp",
    "twisterDown"
  },
  multiple = {
    "multipleUp",
    "multipleDown"
  }
}
tt.render.sprites[3].offset = v(2, 61)
tt.attacks.range = 198.4
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet_start_offset = {
  v(13, 72),
  v(-9, 70)
}
tt.attacks.list[1].bullet = "bolt_archmage"
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(19)
tt.attacks.list[1].max_stored_bullets = 3
tt.attacks.list[1].storage_offsets = {
  v(3, 81),
  v(-20, 58),
  v(24, 56)
}
tt.attacks.list[1].payload_chance = 1
tt.attacks.list[1].payload_bullet = "bolt_blast"
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_TWISTER)
tt.attacks.list[2].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.attacks.list[2].animation = "twister"
tt.attacks.list[2].bullet = "twister"
tt.attacks.list[2].cooldown = 22
tt.attacks.list[2].shoot_time = fts(17)
tt.attacks.list[2].chance = 0.1
tt.attacks.list[2].chance_inc = 5
tt.attacks.list[2].nodes_limit = 30
tt.sound_events.insert = "ArchmageTauntReady"
tt = E.register_t(E, "bolt_archmage", "bolt")
tt.render.sprites[1].prefix = "bolt_archmage"
tt.bullet.mod = nil
tt.bullet.damage_min = 60
tt.bullet.damage_max = 120
tt.bullet.hit_fx = "fx_bolt_archmage_hit"
tt.bullet.pop = {
  "pop_zapow"
}
tt.bullet.store = nil
tt.bullet.store_sort_y_offset = -65
tt.bullet.particles_name = "ps_bolt_archmage_trail"
tt.sound_events.travel = "ArchmageBoltTravel"
tt.sound_events.summon = "ArchmageBoltSummon"
tt = E.register_t(E, "bolt_blast", "bullet")
tt.main_script.insert = scripts3.bolt_blast.insert
tt.main_script.update = scripts3.bolt_blast.update
tt.render.sprites[1].prefix = "bolt_blast"
tt.render.sprites[1].name = "hit"
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_inc = 20
tt.bullet.damage_radius = 45
tt.bullet.damage_radius_inc = 0
tt.bullet.damage_flags = F_AREA
tt.sound_events.insert = "ArchmageCriticalExplosion"
tt = E.register_t(E, "twister", "aura")

E.add_comps(E, tt, "nav_path", "motion", "render")

tt.main_script.insert = scripts3.twister.insert
tt.main_script.update = scripts3.twister.update
tt.damage_type = DAMAGE_TRUE
tt.pickup_range = 25.6
tt.max_times_applied = 3
tt.motion.max_speed = 46.08
tt.damage_min = 0
tt.damage_max = 0
tt.damage_inc = 75
tt.damage_type = DAMAGE_TRUE
tt.enemies_max = 1
tt.enemies_inc = 3
tt.nodes = 15
tt.nodes_inc = 5
tt.nodes_limit = 15
tt.picked_enemies = {}
tt.render.sprites[1].prefix = "twister"
tt.render.sprites[1].anchor.y = 0.14
tt.aura.vis_flags = bor(F_RANGED, F_TWISTER)
tt.aura.vis_bans = bor(F_CLIFF, F_BOSS)
tt = E.register_t(E, "ps_bolt_archmage_trail")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "proy_archbolt_particle"
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
  0.2,
  0.2
}
tt.particle_system.alphas = {
  255,
  12
}
tt.particle_system.scales_y = {
  0.8,
  0.05
}
tt.particle_system.emission_rate = 30
tt = E.register_t(E, "fx_bolt_archmage_hit", "fx")
tt.render.sprites[1].name = "bolt_archmage_hit"
tt = RT("tower_sorcerer_2", "tower_mage_1")

AC(tt, "attacks", "powers", "barrack")

image_y = 74
tt.tower.type = "sorcerer"
tt.tower.level = 1
tt.tower.price = 0
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 19
tt.info.i18n_key = "TOWER_SORCERER"
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_towers_0006" or "info_portraits_towers_0011"
tt.barrack.soldier_type = "soldier_elemental_2"
tt.barrack.rally_range = 225
tt.powers.polymorph = CC("power")
tt.powers.polymorph.price_base = 375
tt.powers.polymorph.price_inc = 225
tt.powers.polymorph.cooldown_base = 22
tt.powers.polymorph.cooldown_inc = -2
tt.powers.polymorph.enc_icon = 1
tt.powers.polymorph.name = "POLIMORPH"
tt.powers.elemental = CC("power")
tt.powers.elemental.price_base = 400
tt.powers.elemental.price_inc = 250
tt.powers.elemental.enc_icon = 2
tt.powers.elemental.max_level = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_mage_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_sorcerer"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_sorcerer_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
  idle = {
    "idleUp",
    "idleDown"
  },
  shoot = {
    "shootingUp",
    "shootingDown"
  },
  polymorph = {
    "polymorphUp",
    "polymorphDown"
  }
}
tt.render.sprites[3].offset = v(1, 64)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_sorcerer_polymorph"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(0, 80)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].hide_after_runs = 1
tt.info.fn = scripts.tower_mage.get_info
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.update = mylua.tower_sorcerer.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.sound_events.insert = "MageSorcererTaunt"
tt.sound_events.change_rally_point = "RockElementalRally"
tt.attacks.range = 210
tt.attacks.min_cooldown = 1
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bolt_sorcerer"
tt.attacks.list[1].count = 2
tt.attacks.list[1].entity = "re_farmer_sorcerer"
tt.attacks.list[1].entity_chance = 0.1
tt.attacks.list[1].bullet_start_offset = {
  v(8, 68),
  v(-6, 68)
}
tt.attacks.list[1].cooldown = 1.2
tt.attacks.list[1].shoot_time = fts(11)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].entity_chance = 0.15
tt.attacks.list[2].bullet_start_offset = {
  v(0, 78),
  v(0, 78)
}
tt.attacks.list[2].animation = "polymorph"
tt.attacks.list[2].entity = "re_farmer_sorcerer_2"
tt.attacks.list[2].bullet = "ray_sorcerer_polymorph"
tt.attacks.list[2].count = 2
tt.attacks.list[2].cooldown = 13
tt.attacks.list[2].shoot_time = fts(9)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED, F_POLYMORPH)
tt = RT("tower_bfg", "tower")

AC(tt, "attacks", "powers")

image_y = 120
tt.tower.type = "bfg"
tt.tower.level = 1
tt.tower.price = 450
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 16
tt.info.i18n_key = "TOWER_BFG"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0012") or "info_portraits_towers_0002"
tt.powers.missile = CC("power")
tt.powers.missile.price_base = 300
tt.powers.missile.price_inc = 150
tt.powers.missile.range_inc_factor = 0.333
tt.powers.missile.damage_inc = 50
tt.powers.missile.enc_icon = 17
tt.powers.cluster = CC("power")
tt.powers.cluster.price_base = 250
tt.powers.cluster.price_inc = 225
tt.powers.cluster.fragment_count_base = 4
tt.powers.cluster.fragment_count_inc = 3
tt.powers.cluster.enc_icon = 18
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_bfg_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_bfg"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 51)
tt.main_script.update = scripts.tower_bfg.update
tt.sound_events.insert = "EngineerBfgTaunt"
tt.attacks.min_cooldown = 3.65
tt.attacks.range = 180
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "bomb_bfg"
tt.attacks.list[1].bullet_start_offset = v(0, 64)
tt.attacks.list[1].cooldown = 3.65
tt.attacks.list[1].node_prediction = fts(25)
tt.attacks.list[1].range = 180
tt.attacks.list[1].shoot_time = fts(23)
tt.attacks.list[1].vis_bans = bor(F_FLYING)
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].animation = "missile"
tt.attacks.list[2].bullet = "missile_bfg"
tt.attacks.list[2].bullet_start_offset = v(-24, 64)
tt.attacks.list[2].cooldown = 12
tt.attacks.list[2].cooldown_mixed = 12
tt.attacks.list[2].cooldown_flying = 6
tt.attacks.list[2].launch_vector = v(12, 110)
tt.attacks.list[2].range_base = 180
tt.attacks.list[2].range = nil
tt.attacks.list[2].shoot_time = fts(14)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED)
tt.attacks.list[3] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[3].bullet = "bomb_bfg_cluster"
tt.attacks.list[3].cooldown = 15
tt.attacks.list[3].node_prediction = fts(44)
tt = RT("tower_tesla", "tower")

AC(tt, "attacks", "powers")

image_y = 96
tt.tower.type = "tesla"
tt.tower.level = 1
tt.tower.price = 375
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 20
tt.info.fn = scripts.tower_tesla.get_info
tt.info.i18n_key = "TOWER_TESLA"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0011") or "info_portraits_towers_0009"
tt.powers.bolt = CC("power")
tt.powers.bolt.price_base = 200
tt.powers.bolt.price_inc = 200
tt.powers.bolt.max_level = 3
tt.powers.bolt.jumps_base = 2
tt.powers.bolt.jumps_inc = 1
tt.powers.bolt.enc_icon = 11
tt.powers.bolt.name = "CHARGED_BOLT"
tt.powers.overcharge = CC("power")
tt.powers.overcharge.price_base = 200
tt.powers.overcharge.price_inc = 200
tt.powers.overcharge.enc_icon = 10
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_tesla_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_tesla"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 40)
tt.main_script.update = scripts.tower_tesla.update
tt.sound_events.insert = "EngineerTeslaTaunt"
tt.attacks.min_cooldown = 2.2
tt.attacks.range = 165
tt.attacks.range_check_factor = 1.2
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "ray_tesla"
tt.attacks.list[1].bullet_start_offset = v(7, 79)
tt.attacks.list[1].cooldown = 2.2
tt.attacks.list[1].range = 165
tt.attacks.list[1].node_prediction = fts(18)
tt.attacks.list[1].shoot_time = fts(48)
tt.attacks.list[1].sound_shoot = "TeslaAttack"
tt.attacks.list[2] = CC("aura_attack")
tt.attacks.list[2].aura = "aura_tesla_overcharge"
tt.attacks.list[2].bullet_start_offset = v(0, 15)
tt = RT("soldier_elemental_2", "soldier_militia")

AC(tt, "melee", "auras")

image_y = 64
anchor_y = 0.15384615384615385
tt.health.armor = 0.4
tt.health.armor_inc = 0.25
tt.health.dead_lifetime = 10
tt.health.hp_max = 700
tt.health.hp_inc = 250
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "SOLDIER_ELEMENTAL"
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0017" or "info_portraits_sc_0017"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 8
tt.melee.attacks[1].damage_inc = 35
tt.melee.attacks[1].damage_max = 90
tt.melee.attacks[1].damage_min = 60
tt.melee.attacks[1].damage_radius = 38.4
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].mod = "mod_elemental_stun"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
  "pop_whaam",
  "pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.5
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].pop_chance = 1
tt.melee.attacks[2].chance = 0.1
tt.melee.attacks[2].chance_inc = 0.05
tt.melee.attacks[2].damage_type = DAMAGE_EXPLOSION
tt.melee.attacks[2].damage_inc = 30
tt.melee.attacks[2].damage_max = 50
tt.melee.attacks[2].damage_min = 30
tt.melee.range = 77
tt.motion.max_speed = 39
tt.speed_inc = 10
tt.regen.health = 200
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
  walk = {
    "running"
  }
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_elemental"
tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "RockElementalDeath"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN, F_POISON, F_BLOOD)
tt = RT("mod_elemental_stun", "mod_stun")
tt.modifier.duration = 1
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = 0
tt = E.register_t(E, "decal_dwaarp_smoke", "decal_timed")
tt.render.sprites[1].prefix = "towerdwaarp_sfx"
tt.render.sprites[1].name = "smoke"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "decal_dwaarp_smoke_water", "decal_timed")
tt.render.sprites[1].prefix = "towerdwaarp_sfx"
tt.render.sprites[1].name = "smokewater"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "decal_dwaarp_pulse", "decal_tween")
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
  {
    0,
    v(1, 1)
  },
  {
    0.32,
    v(2.4, 2.4)
  }
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
  {
    0,
    255
  },
  {
    0.32,
    0
  }
}
tt.tween.props[2].sprite_id = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "EarthquakeTower_HitDecal3"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "decal_dwaarp_scorched", "decal_tween")
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
  {
    0,
    0
  },
  {
    0.1,
    255
  },
  {
    3,
    255
  },
  {
    3.6,
    0
  }
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "EarthquakeTower_Lava1"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "decal_dwaarp_tower_scorched", "decal_tween")
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
  {
    0,
    0
  },
  {
    0.1,
    255
  },
  {
    3,
    255
  },
  {
    3.6,
    0
  }
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "EarthquakeTower_Lava"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "decal_dwaarp_scorched_water", "decal_timed")
tt.timed.duration = 3
tt.timed.runs = nil
tt.render.sprites[1].prefix = "towerdwaarp_sfx"
tt.render.sprites[1].name = "vapor"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].loop = true
tt = E.register_t(E, "tower_dwaarp", "tower")

E.add_comps(E, tt, "attacks", "powers")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0333"
tt.info.enc_icon = 1
tt.tower.type = "dwaarp"
tt.tower.price = 400
tt.powers.drill = E.clone_c(E, "power")
tt.powers.drill.price_base = 400
tt.powers.drill.price_inc = 200
tt.powers.drill.enc_icon = 1
tt.powers.lava = E.clone_c(E, "power")
tt.powers.lava.price_base = 300
tt.powers.lava.price_inc = 300
tt.powers.lava.name = "BLAST"
tt.powers.lava.enc_icon = 1
tt.main_script.insert = scripts3.tower_dwaarp.insert
tt.main_script.update = scripts3.tower_dwaarp.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "EarthquakeTower_Base"
tt.render.sprites[2].offset = v(0, 40)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "towerdwaarp"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(0, 40)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "towerdwaarp"
tt.render.sprites[4].name = "siren"
tt.render.sprites[4].loop = true
tt.render.sprites[4].offset = v(1, 76)
tt.render.sprites[4].hidden = true
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].prefix = "towerdwaarp"
tt.render.sprites[5].name = "lights"
tt.render.sprites[5].loop = true
tt.render.sprites[5].offset = (IS_PHONE_OR_TABLET and v(0, 40)) or v(-3, 40)
tt.render.sprites[5].hidden = true
tt.attacks.range = 179.20000000000002
tt.attacks.list[1] = E.clone_c(E, "area_attack")
tt.attacks.list[1].vis_flags = F_RANGED
tt.attacks.list[1].vis_bans = F_FLYING
tt.attacks.list[1].damage_flags = F_AREA
tt.attacks.list[1].damage_bans = F_FLYING
tt.attacks.list[1].cooldown = 3
tt.attacks.list[1].hit_time = fts(13)
tt.attacks.list[1].mod = "mod_slow_dwaarp"
tt.attacks.list[1].damage_min = 25
tt.attacks.list[1].damage_max = 45
tt.attacks.list[1].sound = "EarthquakeAttack"
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].bullet = "lava"
tt.attacks.list[2].cooldown = 15
tt.attacks.list[2].hit_time = fts(13)
tt.attacks.list[2].sound = "EarthquakeLavaSmash"
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].vis_flags = bit.bor(F_DRILL, F_RANGED)
tt.attacks.list[3].vis_bans = bit.bor(F_FLYING, F_CLIFF, F_BOSS)
tt.attacks.list[3].bullet = "drill"
tt.attacks.list[3].cooldown = 29
tt.attacks.list[3].cooldown_inc = -3
tt.attacks.list[3].hit_time = fts(46)
tt.attacks.list[3].sound = "EarthquakeDrillIn"
tt.sound_events.insert = "EarthquakeTauntReady"
tt = E.register_t(E, "drill", "bullet")
tt.bullet.pop = {
  "pop_splat"
}
tt.render.sprites[1].anchor = v(0.5, 0.3)
tt.render.sprites[1].prefix = "drill"
tt.render.sprites[1].name = "ground"
tt.render.sprites[1].z = Z_OBJECTS
tt.hit_time = fts(3)
tt.main_script.update = scripts3.drill.update
tt.sound_events.insert = "EarthquakeDrillOut"
tt = E.register_t(E, "tower_mech", "tower")

E.add_comps(E, tt, "barrack", "powers")

tt.tower.type = "mecha"
tt.tower.level = 1
tt.tower.price = 375
tt.info.fn = scripts3.tower_mech.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "1919"
tt.info.enc_icon = 20
tt.powers.missile = E.clone_c(E, "power")
tt.powers.missile.price_base = 300
tt.powers.missile.price_inc = 300
tt.powers.missile.max_level = 2
tt.powers.missile.enc_icon = 38
tt.powers.oil = E.clone_c(E, "power")
tt.powers.oil.price_base = 250
tt.powers.oil.price_inc = 200
tt.powers.oil.name = "WASTE"
tt.powers.oil.enc_icon = 39
tt.main_script.insert = scripts3.tower_mech.insert
tt.main_script.update = scripts3.tower_mech.update
tt.main_script.remove = scripts3.tower_barrack.remove
tt.barrack.soldier_type = "soldier_mecha"
tt.barrack.rally_range = 175
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 6)

for i = 2, 10, 1 do
	tt.render.sprites[i] = E.clone_c(E, "sprite")
	tt.render.sprites[i].prefix = "towermecha_layer" .. i - 1
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].offset = v(0, 46)
	tt.render.sprites[i].z = Z_TOWER_BASES
end

tt.render.sprites[10].z = Z_OBJECTS
tt.sound_events.insert = {
	"MechTauntReady",
	"MechSpawn"
}
tt.sound_events.change_rally_point = "MechTaunt"
tt.ui.click_rect = r(-40, -10, 80, 50)
tt = E.register_t(E, "soldier_mecha")

E.add_comps(E, tt, "pos", "render", "motion", "nav_rally", "main_script", "vis", "idle_flip", "attacks", "powers")

tt.powers.missile = E.clone_c(E, "power")
tt.powers.oil = E.clone_c(E, "power")
tt.idle_flip.cooldown = 5
tt.idle_flip.last_dir = 1
tt.idle_flip.walk_dist = 27
tt.main_script.insert = scripts3.soldier_mecha.insert
tt.main_script.remove = scripts3.soldier_mecha.remove
tt.main_script.update = scripts3.soldier_mecha.update
tt.vis.bans = F_RANGED
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].prefix = "soldiermecha"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].anchor.y = 0.11
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "soldiermechaoil"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].anchor.y = 0.11
tt.motion.max_speed = 60
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "bomb_mecha"
tt.attacks.list[1].vis_bans = F_FLYING
tt.attacks.list[1].animations = {
	"bombleft",
	"bombright"
}
tt.attacks.list[1].hit_times = {
	fts(12),
	fts(10)
}
tt.attacks.list[1].max_range = 128
tt.attacks.list[1].start_offsets = {
	v(-17, 79),
	v(-28, 70)
}
tt.attacks.list[1].cooldown = fts(24) + 0.2
tt.attacks.list[1].node_prediction = true
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].bullet = "missile_mecha"
tt.attacks.list[2].power_name = "missile"
tt.attacks.list[2].animation_pre = "missilestart"
tt.attacks.list[2].animation = "missileloop"
tt.attacks.list[2].animation_post = "missileend"
tt.attacks.list[2].cooldown = 8
tt.attacks.list[2].max_range = 224
tt.attacks.list[2].burst = 0
tt.attacks.list[2].burst_inc = 2
tt.attacks.list[2].start_offsets = {
	v(33, 44),
	v(46, 57)
}
tt.attacks.list[2].hit_times = {
	fts(3),
	fts(12)
}
tt.attacks.list[2].launch_vector = v(math.random(80, 240), math.random(15, 60))
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].bullet = "oil_mecha"
tt.attacks.list[3].power_name = "oil"
tt.attacks.list[3].vis_bans = F_FLYING
tt.attacks.list[3].animation = "oilposture"
tt.attacks.list[3].cooldown = 10
tt.attacks.list[3].hit_time = fts(17)
tt.attacks.list[3].start_offset = v(-24, 0)
tt.attacks.list[3].sprite_ids = {
	1,
	2
}
tt.attacks.list[3].max_range = 57.6
tt = E.register_t(E, "bomb_mecha", "bomb")
tt.render.sprites[1].name = "mech_bomb"
tt.bullet.flight_time = fts(26)
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.damage_min = 25
tt.bullet.damage_max = 55
tt.bullet.damage_radius = 57.599999999999994
tt = E.register_t(E, "missile_mecha", "bullet")
tt.render.sprites[1].prefix = "missile_mecha"
tt.render.sprites[1].loop = true
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.min_speed = 300
tt.bullet.max_speed = 450
tt.bullet.turn_speed = (math.pi*10)/180*30
tt.bullet.acceleration_factor = 0.1
tt.bullet.hit_fx = "fx_explosion_air"
tt.bullet.hit_fx_air = "fx_explosion_air"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.damage_min = 20
tt.bullet.damage_max = 80
tt.bullet.damage_radius = 41.25
tt.bullet.vis_flags = F_RANGED
tt.bullet.damage_flags = F_AREA
tt.bullet.particles_name = "ps_missile_mecha"
tt.bullet.retarget_range = 99999
tt.main_script.insert = scripts3.missile.insert
tt.main_script.update = scripts3.missile.update
tt.sound_events.insert = "RocketLaunchSound"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.hit_water = "RTWaterExplosion"
tt = E.register_t(E, "ps_missile_mecha", "ps_missile")
tt = E.register_t(E, "oil_mecha", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.mod = "mod_slow_oil"
tt.aura.duration = 2
tt.aura.duration_inc = 2
tt.aura.cycle_time = 0.3
tt.aura.radius = 51.2
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "Mecha_Shit"
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		"this.actual_duration-0.6",
		255
	},
	{
		"this.actual_duration",
		0
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0.6, 0.6)
	},
	{
		0.3,
		v(1, 1)
	}
}
tt.tween.remove = false
tt.sound_events.insert = "MechOil"
tt = E.register_t(E, "decal_crossbow_eagle_preview", "decal_tween")
tt.render.sprites[1].name = "CrossbowHunterDecalDotted"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.32)
tt.render.sprites[1].offset.y = 0
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].loop = true
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.25,
		v(1.15, 1.15)
	},
	{
		0.5,
		v(1, 1)
	}
}
tt = E.register_t(E, "decal_tusken", "decal_scripted")

E.add_comps(E, tt, "bullet_attack")

tt.render.sprites[1].prefix = "decal_tusken"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.main_script.update = scripts3.decal_tusken.update
tt.bullet_attack.max_range = 9e+99
tt.bullet_attack.bullet = "shotgun_musketeer"
tt.bullet_attack.shoot_time = fts(2)
tt.bullet_attack.cooldown_min = 5
tt.bullet_attack.cooldown_max = 5
tt.bullet_attack.bullet_start_offset = v(3, 7)
tt = E.register_t(E, "tower_crossbow", "tower_archer_1")

E.add_comps(E, tt, "powers")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "1113"
tt.info.enc_icon = 17
tt.tower.type = "crossbow"
tt.tower.price = 230
tt.powers.multishot = E.clone_c(E, "power")
tt.powers.multishot.price_base = 250
tt.powers.multishot.price_inc = 150
tt.powers.multishot.name = "BARRAGE"
tt.powers.multishot.enc_icon = 28
tt.powers.eagle = E.clone_c(E, "power")
tt.powers.eagle.price_base = 200
tt.powers.eagle.price_inc = 200
tt.powers.eagle.name = "FALCONER"
tt.powers.eagle.enc_icon = 29
tt.main_script.insert = scripts3.tower_crossbow.insert
tt.main_script.update = scripts3.tower_crossbow.update
tt.main_script.remove = scripts3.tower_crossbow.remove
tt.attacks.range = 198.4
tt.attacks.list[1].bullet = "arrow_crossbow"
tt.attacks.list[1].cooldown = 0.5
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].bullet_start_offset = {
  v(-11, 60),
  v(11, 60)
}
tt.attacks.list[1].critical_chance = 0.1
tt.attacks.list[1].critical_chance_inc = 0.05
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].bullet = "multishot_crossbow"
tt.attacks.list[2].cooldown = 5
tt.attacks.list[2].shoot_time = fts(1)
tt.attacks.list[2].cycle_time = fts(3)
tt.attacks.list[2].shots = 4
tt.attacks.list[2].shots_inc = 2
tt.attacks.list[2].near_range = 64
tt.attacks.list[2].bullet_start_offset = {
  v(-11, 60),
  v(11, 60)
}
tt.attacks.list[3] = E.clone_c(E, "mod_attack")
tt.attacks.list[3].mod = "mod_crossbow_eagle"
tt.attacks.list[3].cooldown = 0.5
tt.attacks.list[3].fly_cooldown = 10
tt.attacks.list[3].range = 128
tt.attacks.list[3].range_inc = 32
tt.attacks.list[3].excluded_templates = {
  "tower_barrack_1",
  "tower_barrack_2",
  "tower_barrack_3",
  "tower_forest",
  "tower_blade",
  "tower_barbarian",
  "tower_paladin"
}
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 7)
tt.render.sprites[2].name = "CossbowHunter_tower"
tt.render.sprites[2].offset = v(0, 33)
tt.render.sprites[3].prefix = "shootercrossbow"
tt.render.sprites[3].offset = v(-9, 58)
tt.render.sprites[3].angles.multishot_start = {
  "multishotStartUp",
  "multishotStartDown"
}
tt.render.sprites[3].angles.multishot_loop = {
  "multishotLoopUp",
  "multishotLoopDown"
}
tt.render.sprites[3].angles.multishot_end = {
  "multishotEndUp",
  "multishotEndDown"
}
tt.render.sprites[4].prefix = "shootercrossbow"
tt.render.sprites[4].offset = v(12, 58)
tt.render.sprites[4].angles.multishot_start = {
  "multishotStartUp",
  "multishotStartDown"
}
tt.render.sprites[4].angles.multishot_loop = {
  "multishotLoopUp",
  "multishotLoopDown"
}
tt.render.sprites[4].angles.multishot_end = {
  "multishotEndUp",
  "multishotEndDown"
}
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].prefix = "crossbow_eagle"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(2, 53)
tt.render.sprites[5].hidden = true
tt.render.sprites[5].draw_order = 6
tt.sound_events.insert = "CrossbowTauntReady"
tt = E.register_t(E, "arrow_crossbow", "arrow")
tt.bullet.flight_time = fts(16)
tt.bullet.damage_min = 15
tt.bullet.damage_max = 23
tt.bullet.pop = {
  "pop_shunt_violet"
}
tt = E.register_t(E, "multishot_crossbow", "shotgun")
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.min_speed = FPS*20
tt.bullet.max_speed = FPS*20
tt.bullet.damage_min = 30
tt.bullet.damage_max = 40
tt.bullet.hide_radius = 12
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.miss_fx_water = "fx_splash_small"
tt.render.sprites[1].name = "proy_crossbow_special"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "ArrowSound"
tt = E.register_t(E, "mod_crossbow_eagle", "modifier")

E.add_comps(E, tt, "render", "tween")

tt.range_factor = 1.05
tt.range_factor_inc = 0.05
tt.main_script.insert = scripts3.mod_crossbow_eagle.insert
tt.main_script.remove = scripts3.mod_crossbow_eagle.remove
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].loop = true
tt.tween.props[1].keys = {
  {
    0,
    v(1, 1)
  },
  {
    0.5,
    v(0.9, 0.9)
  },
  {
    1,
    v(1, 1)
  }
}
tt.render.sprites[1].name = "CossbowHunter_towerBuff"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.21
tt.render.sprites[1].z = Z_TOWER_BASES + 1

for i, p in ipairs({
  v(22, 45),
  v(40, 35),
  v(58, 30),
  v(77, 35),
  v(95, 45)
}) do
  tt.render.sprites[i + 1] = E.clone_c(E, "sprite")
  tt.render.sprites[i + 1].prefix = "crossbow_eagle_buff"
  tt.render.sprites[i + 1].name = "idle"
  tt.render.sprites[i + 1].anchor.y = 0.21
  tt.render.sprites[i + 1].offset = v(p.x - 58, p.y - 27)
  tt.render.sprites[i + 1].ts = math.random()
end
tt = E.register_t(E, "tower_frankenstein", "tower")

E.add_comps(E, tt, "barrack", "attacks", "powers")

tt.tower.type = "frankenstein"
tt.tower.level = 1
tt.tower.price = 293
tt.info.fn = scripts3.tower_frankenstein.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0022"
tt.powers.lightning = E.clone_c(E, "power")
tt.powers.lightning.price_base = 187
tt.powers.lightning.price_inc = 113
tt.powers.frankie = E.clone_c(E, "power")
tt.powers.frankie.price_base = 150
tt.powers.frankie.price_inc = 150
tt.main_script.insert = scripts3.tower_frankenstein.insert
tt.main_script.update = scripts3.tower_frankenstein.update
tt.main_script.remove = scripts3.tower_barrack.remove
tt.barrack.soldier_type = "soldier_frankenstein"
tt.barrack.rally_range = 179.20000000000002
tt.attacks.range = 220
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "ray_frankenstein"
tt.attacks.list[1].cooldown = 2.5
tt.attacks.list[1].shoot_time = fts(23)
tt.attacks.list[1].bullet_start_offset = v(0, 80)
tt.attacks.list[1].sound = "TeslaAttack"
tt.attacks.list[1].node_prediction = fts(11.5)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "HalloweenTesla_layer1_0001"
tt.render.sprites[2].offset = v(0, 40)

for i = 1, 4, 1 do
	tt.render.sprites[i + 2] = E.clone_c(E, "sprite")
	tt.render.sprites[i + 2].prefix = "tower_frankenstein_l" .. i + 1
	tt.render.sprites[i + 2].name = "idle"
	tt.render.sprites[i + 2].offset = v(0, 40)
end

for i = 1, 2, 1 do
	tt.render.sprites[i + 6] = E.clone_c(E, "sprite")
	tt.render.sprites[i + 6].prefix = "tower_frankenstein_charge_l" .. i
	tt.render.sprites[i + 6].name = "idle"
	tt.render.sprites[i + 6].offset = v(0, 40)
	tt.render.sprites[i + 6].loop = false
end

tt.render.sprites[9] = E.clone_c(E, "sprite")
tt.render.sprites[9].prefix = "tower_frankenstein_drcrazy"
tt.render.sprites[9].name = "idle"
tt.render.sprites[9].offset = v(0, 40)
tt.render.sprites[9].loop = false
tt.render.sprites[10] = E.clone_c(E, "sprite")
tt.render.sprites[10].animated = false
tt.render.sprites[10].name = "Halloween_Frankie_lvl1_0051"
tt.render.sprites[10].offset = v(2, 10)
tt.render.sprites[10].flip_x = true

for i = 1, 2, 1 do
	tt.render.sprites[i + 10] = E.clone_c(E, "sprite")
	tt.render.sprites[i + 10].prefix = "tower_frankenstein_helmet_l" .. i
	tt.render.sprites[i + 10].name = "idle"
	tt.render.sprites[i + 10].offset = v(0, 40)
	tt.render.sprites[i + 10].loop = false
end

tt.sound_events.change_rally_point = "HWFrankensteinTaunt"
tt = E.register_t(E, "ray_frankenstein", "bullet")
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_frankenstein"
tt.bounces = nil
tt.bounces_lvl = {
	[0] = 0,
	2,
	3,
	4
}
tt.bounce_range = 100
tt.bounce_vis_flags = F_RANGED
tt.bounce_vis_bans = 0
tt.bounce_damage_factor = 1
tt.bounce_damage_factor_min = 1
tt.bounce_damage_factor_inc = -0.25
tt.bounce_delay = fts(2)
tt.seen_targets = {}
tt.frankie_heal_hp = 10
tt.image_width = 98
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_frankenstein"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt.main_script.insert = scripts3.ray_frankenstein.insert
tt.main_script.update = scripts3.ray_frankenstein.update
tt = E.register_t(E, "mod_ray_frankenstein", "modifier")

E.add_comps(E, tt, "render", "dps")

tt.modifier.duration = fts(18)
tt.dps.damage_min = 44
tt.dps.damage_max = 66
tt.dps.damage_inc = 11
tt.dps.damage_type = DAMAGE_ELECTRICAL
tt.dps.damage_every = 1
tt.dps.pop = {
	"pop_bzzt"
}
tt.dps.pop_chance = 1
tt.dps.pop_conds = DR_KILL
tt.render.sprites[1].name = "ray_frankenstein_fx"
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts3.mod_dps.insert
tt.main_script.update = scripts3.mod_dps.update
tt = E.register_t(E, "soldier_frankenstein", "soldier")

E.add_comps(E, tt, "melee")

image_y = 90
anchor_y = 25/image_y
tt.health.armor_lvls = {
	0.2,
	0.4,
	0.6
}
tt.health.armor = tt.health.armor_lvls[1]
tt.health.dead_lifetime = 12
tt.health.hp_max = 550
tt.health_bar.offset = v(0, 48)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts3.soldier_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0093") or "info_portraits_soldiers_0030"
tt.main_script.insert = scripts3.soldier_barrack.insert
tt.main_script.update = scripts3.soldier_barrack.update
tt.melee.attacks[1].cooldown_lvls = {
	2,
	1,
	1
}
tt.melee.attacks[1].cooldown = tt.melee.attacks[1].cooldown_lvls[1]
tt.melee.attacks[1].damage_max_lvls = {
	20,
	50,
	50
}
tt.melee.attacks[1].damage_max = tt.melee.attacks[1].damage_max_lvls[1]
tt.melee.attacks[1].damage_min_lvls = {
	10,
	30,
	30
}
tt.melee.attacks[1].damage_min = tt.melee.attacks[1].damage_min_lvls[1]
tt.melee.attacks[1].hit_time = fts(17)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "pound"
tt.melee.attacks[2].cooldown = 6
tt.melee.attacks[2].damage_max = 150
tt.melee.attacks[2].damage_min = 150
tt.melee.attacks[2].damage_radius = 130
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(24)
tt.melee.attacks[2].hit_fx = "fx_frankenstein_pound"
tt.melee.range = 77
tt.motion.max_speed = 45
tt.regen.cooldown = 1
tt.regen.health = 35
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix_lvls = {
	"soldier_frankie_lvl1",
	"soldier_frankie_lvl2",
	"soldier_frankie_lvl3"
}
tt.render.sprites[1].prefix = tt.render.sprites[1].prefix_lvls[1]
tt.soldier.melee_slot_offset = v(15, 0)
tt.unit.hit_offset = v(0, 17)
tt.unit.marker_offset = v(0, 0)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POLYMORPH, F_POISON, F_LYCAN, F_STUN, F_NET)
tt = E.register_t(E, "fx_frankenstein_pound", "decal_scripted")

E.add_comps(E, tt, "tween")

tt.main_script.insert = scripts3.fx_frankenstein_pound.insert
tt.render.sprites[1].name = "frankie_punch_decal"
tt.render.sprites[1].anchor.y = 0.2777777777777778
tt.render.sprites[1].loop = false

for i = 1, 5, 1 do
	tt.render.sprites[i + 1] = E.clone_c(E, "sprite")
	tt.render.sprites[i + 1].name = "frankie_punch_fx"
	tt.render.sprites[i + 1].loop = true
	tt.render.sprites[i + 1].anchor.y = 0.2777777777777778
	tt.render.sprites[i + 1].z = Z_DECALS
	tt.tween.props[i*2 - 1] = E.clone_c(E, "tween_prop")
	tt.tween.props[i*2 - 1].name = "alpha"
	tt.tween.props[i*2 - 1].sprite_id = i + 1
	tt.tween.props[i*2 - 1].keys = {
		{
			0,
			255
		},
		{
			fts(10),
			204
		},
		{
			fts(16),
			0
		}
	}
	tt.tween.props[i*2] = E.clone_c(E, "tween_prop")
	tt.tween.props[i*2].name = "offset"
	tt.tween.props[i*2].sprite_id = i + 1
end

tt.tween.remove = true
tt = E.register_t(E, "tower_pirate_watchtower", "tower_archer_1")

E.add_comps(E, tt, "powers")

tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "pirate_watchtower_shotgun"
tt.attacks.list[1].bullet_start_offset = {
	v(0, 73)
}
tt.attacks.list[1].cooldown = 3.5
tt.attacks.list[1].shoot_time = fts(14)
tt.attacks.range = 217.6
tt.info.fn = scripts3.tower_pirate_watchtower.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0020"
tt.main_script.update = scripts3.tower_pirate_watchtower.update
tt.powers.reduce_cooldown = E.clone_c(E, "power")
tt.powers.reduce_cooldown.price_base = 75
tt.powers.reduce_cooldown.price_inc = 75
tt.powers.reduce_cooldown.values = {
	2.4,
	1.7,
	1.2
}
tt.powers.parrot = E.clone_c(E, "power")
tt.powers.parrot.price_base = 250
tt.powers.parrot.price_inc = 250
tt.powers.parrot.max_level = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "pirateTower"
tt.render.sprites[1].offset = v(0, 23)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "pirateTower"
tt.render.sprites[2].offset = v(0, 50)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].offset = v(0, 71)
tt.render.sprites[3].prefix = "pirate_watchtower_shooter"
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "pirate_watchtower_flag"
tt.render.sprites[4].offset = v(0, 50)
tt.sound_events.insert = nil
tt.tower.price = 115
tt.tower.type = "pirate_watchtower"
tt = E.register_t(E, "pirate_watchtower_shotgun", "shotgun")
tt.bullet.level = 0
tt.bullet.damage_min = 40
tt.bullet.damage_max = 60
tt.bullet.damage_inc = 30
tt.bullet.min_speed = FPS*40
tt.bullet.max_speed = FPS*40
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.miss_fx_water = "fx_splash_small"
tt.bullet.start_fx = "fx_rifle_smoke"
tt.sound_events.insert = "ShotgunSound"
tt = E.register_t(E, "pirate_watchtower_parrot", "decal_scripted")

E.add_comps(E, tt, "force_motion", "custom_attack")

anchor_y = 0.5
image_y = 30
tt.flight_height = 60
tt.flight_speed_idle = 100
tt.ramp_dist_idle = 100
tt.flight_speed_busy = 150
tt.ramp_dist_busy = 50
tt.bombs_pos = nil
tt.idle_pos = nil
tt.main_script.update = scripts3.pirate_watchtower_parrot.update
tt.custom_attack = E.clone_c(E, "custom_attack")
tt.custom_attack.min_range = 40
tt.custom_attack.max_range = 40
tt.custom_attack.bullet = "pirate_watchtower_bomb"
tt.custom_attack.cooldown = 2
tt.custom_attack.damage_type = DAMAGE_EXPLOSIVE
tt.custom_attack.vis_flags = F_RANGED
tt.custom_attack.vis_bans = F_FLYING
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "pirate_watchtower_parrot"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop_forced = true
tt.render.sprites[1].sort_y_offset = -12
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.owner = nil
tt = E.register_t(E, "pirate_watchtower_bomb", "bomb")
tt.bullet.flight_time = fts(10)
tt.bullet.rotation_speed = 0
tt.bullet.damage_max = 40
tt.bullet.damage_min = 40
tt.bullet.hide_radius = nil
tt.render.sprites[1].name = "pirateTower_bomb"
tt.sound_events.insert = nil
tt = E.register_t(E, "tower_archer_dwarf", "tower_archer_1")

E.add_comps(E, tt, "powers")

tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "dwarf_shotgun"
tt.attacks.list[1].bullet_start_offset = {
	v(-15, 55),
	v(15, 55)
}
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(14)
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].animation = "shoot_barrel"
tt.attacks.list[2].bullet = "dwarf_barrel"
tt.attacks.list[2].bullet_start_offset = {
	v(-15, 68),
	v(15, 68)
}
tt.attacks.list[2].cooldown = 6
tt.attacks.list[2].disabled = true
tt.attacks.list[2].power_name = "barrel"
tt.attacks.list[2].shoot_time = fts(22)
tt.attacks.list[2].vis_bans = F_FLYING
tt.attacks.list[2].node_prediction = fts(22) + fts(26)
tt.attacks.range = 217.6
tt.info.fn = scripts3.tower_archer_dwarf.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0017"
tt.main_script.update = scripts3.tower_archer_dwarf.update
tt.powers.barrel = E.clone_c(E, "power")
tt.powers.barrel.price_base = 250
tt.powers.barrel.price_inc = 150
tt.powers.extra_damage = E.clone_c(E, "power")
tt.powers.extra_damage.price_base = 200
tt.powers.extra_damage.price_inc = 200
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 9)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "DwarfRiflemen"
tt.render.sprites[2].offset = v(0, 31)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	shoot_barrel = {
		"shootBarrelUp",
		"shootBarrelDown"
	}
}
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].offset = v(-12, 58)
tt.render.sprites[3].prefix = "shooterarcherdwarf"
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset = v(12, 58)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].animated = false
tt.render.sprites[5].name = "DwarfRiflemenTop"
tt.render.sprites[5].offset = v(0, 31)
tt.sound_events.insert = nil
tt.tower.price = 230
tt.tower.type = "archer_dwarf"
tt.sound_events.insert = "DwarfArcherTaunt2"
tt = E.register_t(E, "dwarf_shotgun", "shotgun")
tt.bullet.level = 0
tt.bullet.damage_min = 35
tt.bullet.damage_max = 65
tt.bullet.damage_inc = 30
tt.bullet.min_speed = FPS*40
tt.bullet.max_speed = FPS*40
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.start_fx = "fx_rifle_smoke"
tt.sound_events.insert = "ShotgunSound"
tt = E.register_t(E, "dwarf_barrel", "bomb")
tt.bullet.damage_max = 40
tt.bullet.damage_max_inc = 60
tt.bullet.damage_min = 40
tt.bullet.damage_min_inc = 20
tt.bullet.damage_radius = 80
tt.bullet.damage_radius_inc = 0
tt.bullet.flight_time = fts(26)
tt.bullet.level = 0
tt.render.sprites[1].name = "DwarfShooter_Barril"
tt.sound_events.insert = "AxeSound"
tt = E.register_t(E, "tower_barrack_dwarf", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.barrack.rally_range = 179.20000000000002
tt.barrack.soldier_type = "soldier_dwarf"
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0018"
tt.powers.armor = E.clone_c(E, "power")
tt.powers.armor.max_level = 2
tt.powers.armor.price_base = 125
tt.powers.armor.price_inc = 200
tt.powers.beer = E.clone_c(E, "power")
tt.powers.beer.price_base = 200
tt.powers.beer.price_inc = 100
tt.powers.hammer = E.clone_c(E, "power")
tt.powers.hammer.price_base = 75
tt.powers.hammer.price_inc = 75
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "DwarfHall_0001"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[2].hidden = true
tt.render.sprites[3].prefix = "towerbarrackdwarf_door"
tt.render.sprites[3].offset = v(0, 30)
tt.sound_events.insert = "DwarfTaunt"
tt.sound_events.change_rally_point = "DwarfTaunt"
tt.tower.can_be_mod = false
tt.tower.price = 180
tt.tower.type = "barrack_dwarf"
tt = E.register_t(E, "soldier_dwarf", "soldier_militia")
image_y = 42
anchor_y = 0.21428571428571427

E.add_comps(E, tt, "powers")

tt.beer = {
	animation = "beer",
	cooldown = 10,
	hp_trigger_factor = 0.8,
	mod = "mod_dwarf_beer",
	ts = 0
}
tt.health.armor = 0.25
tt.health.armor_inc = 0.2
tt.health.armor_power_name = "armor"
tt.health.dead_lifetime = 15
tt.health.hp_max = 220
tt.health_bar.offset = v(0, ady(41))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0066") or "info_portraits_soldiers_0028"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_DWARF_RANDOM_%i_NAME"
tt.main_script.update = scripts3.soldier_dwarf.update
tt.melee.attacks[1].damage_inc = 6
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].power_name = "hammer"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.cooldown = 1
tt.melee.range = 64
tt.motion.max_speed = FPS*2.5
tt.powers.armor = E.clone_c(E, "power")
tt.powers.beer = E.clone_c(E, "power")
tt.powers.hammer = E.clone_c(E, "power")
tt.regen.health = 22
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "soldierdwarf"
tt.unit.marker_offset = v(0, ady(9))
tt = E.register_t(E, "mod_dwarf_beer", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 5
tt.hps.heal_max = 5
tt.hps.heal_every = 0.25
tt.modifier.duration = 1
tt.modifier.duration_inc = 3
tt.modifier.use_mod_offset = false
tt.render.sprites[1].name = "dwarf_beer_aura"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "dwarf_beer_bubbles"
tt.render.sprites[2].loop = true
tt.render.sprites[2].offset.y = 10
tt.render.sprites[2].z = Z_EFFECTS
tt.main_script.insert = scripts3.mod_hps.insert
tt.main_script.update = scripts3.mod_hps.update
tt = E.register_t(E, "tower_totem", "tower_archer_1")

E.add_comps(E, tt, "powers")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "1888"
tt.info.enc_icon = 18
tt.tower.type = "totem"
tt.tower.price = 230
tt.powers.weakness = E.clone_c(E, "power")
tt.powers.weakness.price_base = 250
tt.powers.weakness.price_inc = 200
tt.powers.weakness.enc_icon = 30
tt.powers.silence = E.clone_c(E, "power")
tt.powers.silence.price_base = 150
tt.powers.silence.price_inc = 150
tt.powers.silence.name = "SPIRITS"
tt.powers.silence.enc_icon = 31
tt.main_script.insert = scripts3.tower_totem.insert
tt.main_script.update = scripts3.tower_totem.update
tt.attacks.range = 179.20000000000002
tt.attacks.list[1].bullet = "axe_totem"
tt.attacks.list[1].cooldown = 0.8
tt.attacks.list[1].shoot_time = fts(8)
tt.attacks.list[1].bullet_start_offset = {
  v(-12, 72),
  v(12, 72)
}
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.attacks.list[2].bullet = "totem_weakness"
tt.attacks.list[2].cooldown = 9
tt.attacks.list[2].vis_bans = bor(F_CLIFF)
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].bullet = "totem_silence"
tt.attacks.list[3].cooldown = 8
tt.attacks.list[3].vis_bans = bor(F_CLIFF, F_BOSS)
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 6)
tt.render.sprites[2].name = "TotemTower"
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[3].prefix = "shootertotem"
tt.render.sprites[3].offset = v(-10, 58)
tt.render.sprites[4].prefix = "shootertotem"
tt.render.sprites[4].offset = v(10, 58)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].name = "totem_fire"
tt.render.sprites[5].offset = v(-25, 10)
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].name = "totem_fire"
tt.render.sprites[6].offset = v(25, 10)
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].name = "totem_eyes_lower"
tt.render.sprites[7].offset = v(0, 17)
tt.render.sprites[7].hidden = true
tt.render.sprites[7].loop = false
tt.render.sprites[8] = E.clone_c(E, "sprite")
tt.render.sprites[8].name = "totem_eyes_upper"
tt.render.sprites[8].offset = v(0, 41)
tt.render.sprites[8].hidden = true
tt.render.sprites[8].loop = false
tt.sound_events.insert = "TotemTauntReady"
tt = E.register_t(E, "axe_totem", "arrow")
tt.render.sprites[1].name = "TotemAxe_0001"
tt.render.sprites[1].animated = false
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = "TotemAxe_0002"
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.damage_min = 25
tt.bullet.damage_max = 40
tt.bullet.pop = {
  "pop_thunk"
}
tt.bullet.pop_chance = 1
tt.bullet.pop_conds = DR_KILL
tt.sound_events.insert = "AxeSound"
tt = E.register_t(E, "totem_silence", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.mod = "mod_silence_totem"
tt.aura.cycle_time = 0.3
tt.aura.duration = 2
tt.aura.duration_inc = 2
tt.aura.radius = 105
tt.aura.vis_bans = F_BOSS
tt.aura.vis_flags = F_MOD
tt.render.sprites[1].name = "TotemTower_GroundEffect-Violet_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = v(0.64, 0.64)
tt.render.sprites[1].alpha = 50
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "TotemTower_GroundEffect-Violet_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "totem_violet"
tt.render.sprites[3].name = "start"
tt.render.sprites[3].loop = false
tt.render.sprites[3].anchor = v(0.5, 0.11)
tt.main_script.update = scripts3.aura_totem.update
tt.sound_events.insert = "TotemSpirits"
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
  {
    0,
    v(0.64, 0.64)
  },
  {
    fts(15),
    v(1, 1)
  },
  {
    fts(30),
    v(1.6, 1.6)
  }
}
tt.tween.props[1].loop = true
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
  {
    0,
    50
  },
  {
    fts(10),
    255
  },
  {
    fts(20),
    255
  },
  {
    fts(30),
    0
  }
}
tt.tween.props[2].loop = true
tt = E.register_t(E, "totem_weakness", "totem_silence")
tt.aura.mod = "mod_weakness_totem"
tt.aura.duration = 0
tt.aura.duration_inc = 3
tt.aura.vis_bans = 0
tt.render.sprites[1].name = "TotemTower_GroundEffect-Red_0002"
tt.render.sprites[2].name = "TotemTower_GroundEffect-Red_0001"
tt.render.sprites[3].prefix = "totem_red"
tt.render.sprites[3].anchor = v(0.45, 0.17)
tt.sound_events.insert = "TotemWeakness"
tt = E.register_t(E, "mod_silence_totem", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = 1
tt.modifier.bans = {
  "mod_demon_shield",
  "mod_shaman_heal",
  "mod_spectral_knight",
  "mod_troll_rage",
  "mod_troll_heal",
  "mod_rocketeer_speed_buff",
  "mod_lycanthropy"
}
tt.modifier.remove_banned = true
tt.main_script.insert = scripts3.mod_silence.insert
tt.main_script.remove = scripts3.mod_silence.remove
tt.main_script.update = scripts3.mod_track_target.update
tt.render.sprites[1].prefix = "silence"
tt.render.sprites[1].size_names = {
  "small",
  "big",
  "big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = true
tt.render.sprites[1].draw_order = 2
tt = E.register_t(E, "mod_weakness_totem", "modifier")

E.add_comps(E, tt, "render")

tt.inflicted_damage_factor = 0.5
tt.received_damage_factor = 1.4
tt.modifier.duration = 1.5
tt.modifier.resets_same = false
tt.modifier.use_mod_offset = false
tt.main_script.insert = scripts3.mod_damage_factors.insert
tt.main_script.remove = scripts3.mod_damage_factors.remove
tt.main_script.update = scripts3.mod_track_target.update
tt.render.sprites[1].prefix = "weakness"
tt.render.sprites[1].size_names = {
  "small",
  "big",
  "big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt = RT("tower_ranger", "tower_archer_1")

AC(tt, "attacks", "powers")

image_y = 90
tt.tower.type = "ranger"
tt.tower.level = 1
tt.tower.price = 230
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 13
tt.info.i18n_key = "TOWER_RANGERS"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0010") or "info_portraits_towers_0006"
tt.powers.poison = CC("power")
tt.powers.poison.price_base = 200
tt.powers.poison.price_inc = 200
tt.powers.poison.mod = "mod_ranger_poison"
tt.powers.poison.enc_icon = 8
tt.powers.thorn = CC("power")
tt.powers.thorn.price_base = 225
tt.powers.thorn.price_inc = 225
tt.powers.thorn.aura = "aura_ranger_thorn"
tt.powers.thorn.enc_icon = 9
tt.powers.thorn.name = "thorns"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_ranger_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_tower_0005"
tt.render.sprites[2].offset = v(0, 40)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_ranger_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(-8, 65)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset.x = 8
tt.render.sprites[5] = CC("sprite")
tt.render.sprites[5].prefix = "tower_ranger_druid"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].hidden = true
tt.render.sprites[5].offset = v(31, 15)
tt.main_script.update = scripts.tower_ranger.update
tt.attacks.range = 200
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "arrow_ranger"
tt.attacks.list[1].cooldown = 0.4
tt.attacks.list[1].shoot_time = fts(4)
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet_start_offset = {
	v(8, 4),
	v(4, -5)
}
tt.sound_events.insert = "ArcherRangerTaunt"
tt = E.register_t(E, "soldier_gryphon_guard", "soldier_militia")

E.add_comps(E, tt, "ranged")

tt.health.hp_max = 1
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health_bar = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 0
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "arrow_ranger"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 10)
}
tt.ranged.attacks[1].cooldown = 0.4
tt.ranged.attacks[1].max_range = 480
tt.ranged.attacks[1].min_range = 1
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].prefix = "soldier_gryphon_guard"
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.ui = nil
tt.unit.hit_offset = v(0, 10)
tt.unit.level = 1
tt.unit.mod_offset = v(0, 21)
tt.vis.bans = bor(tt.vis.bans, F_RANGED)
tt.vis.bans = bor(F_BLOCK, F_RANGED)
tt = E.register_t(E, "soldier_gryphon_guard514", "soldier_militia")

E.add_comps(E, tt, "ranged", "auras")

tt.health.hp_max = 1
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health_bar = nil
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_skeleton_mage_114"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E.clone_c(E, "aura_attack")
tt.auras.list[2].name = "aura_mage_heal"
tt.auras.list[2].cooldown = 0
tt.auras.list[3] = E.clone_c(E, "aura_attack")
tt.auras.list[3].name = "aura_soldier_levelup"
tt.auras.list[3].cooldown = 0
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 0
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "arrow_ranger"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 10)
}
tt.ranged.attacks[1].cooldown = 9e+99
tt.ranged.attacks[1].max_range = 1
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].prefix = "soldier_gryphon_guard514"
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.render.sprites[1].scale = v(0.9, 1.6)
tt.ui = nil
tt.unit.hit_offset = v(0, 10)
tt.unit.level = 1
tt.unit.mod_offset = v(0, 21)
tt.vis.bans = bor(tt.vis.bans, F_RANGED)
tt.vis.bans = bor(F_BLOCK, F_RANGED)
tt = E.register_t(E, "aura_skeleton_mage_114", "aura")

E.add_comps(E, tt, "render")

tt.aura.duration = -1
tt.aura.mod = "mod_skeleton_mage_114"
tt.aura.cycle_time = 0.5
tt.aura.radius = 256
tt.aura.filter_source = true
tt.aura.track_source = true
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "mod_skeleton_mage_114", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].name = "mod_troll_rage"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.main_script.insert = scripts2.mod_gnoll_boss.insert
tt.main_script.remove = scripts2.mod_gnoll_boss.remove
tt.main_script.update = scripts2.mod_track_target.update
tt.modifier.duration = 3
tt.modifier.use_mod_offset = true
tt.extra_health_factor = 0.5
tt.inflicted_damage_factor = 1.2
tt = E.register_t(E, "aura_mage_heal", "aura")

E.add_comps(E, tt, "render")

tt.aura.duration = -1
tt.aura.mod = "mod_mage_heal"
tt.aura.cycle_time = 0.5
tt.aura.radius = 256
tt.aura.filter_source = true
tt.aura.track_source = true
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "mod_mage_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 4
tt.hps.heal_max = 4
tt.hps.heal_every = 1
tt.render.sprites[1].prefix = "healing"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(24)
tt.modifier.allows_duplicates = true
tt = E.register_t(E, "blackburn_aura2", "aura")
tt.main_script.update = scripts.blackburn_aura.update
tt.aura.cycle_time = 0.5
tt.aura.duration = -1
tt.aura.radius = 256
tt.aura.raise_entity = "enemy_giant_rat2"
tt.count_group_name = "blackburn_skeletons"
tt.count_group_type = COUNT_GROUP_CONCURRENT
tt.count_group_max = 9e+99
tt = E.register_t(E, "soldier_gryphon_guard114", "soldier_gryphon_guard")
tt.ranged.attacks[1].cooldown = 0.8
tt.ranged.attacks[1].max_range = 400
tt = E.register_t(E, "soldier_gryphon_guard888", "soldier_militia")

E.add_comps(E, tt, "ranged")

tt.health.hp_max = 1
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health_bar = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 0
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "arrow_druid"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 10)
}
tt.ranged.attacks[1].cooldown = 10
tt.ranged.attacks[1].max_range = 185
tt.ranged.attacks[1].min_range = 1
tt.ranged.attacks[1].shoot_time = fts(16)
tt.ranged.attacks[1].chance = 1
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].bullet = "arrow_druid_2"
tt.ranged.attacks[2].chance = 0.5
tt.render.sprites[1].prefix = "soldier_gryphon_guard888"
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.ui = nil
tt.unit.hit_offset = v(0, 10)
tt.unit.level = 1
tt.unit.mod_offset = v(0, 21)
tt.vis.bans = bor(tt.vis.bans, F_RANGED)
tt.vis.bans = bor(F_BLOCK, F_RANGED)
tt = E.register_t(E, "soldier_gryphon_guard0", "soldier_gryphon_guard")
tt.ranged.attacks[1].bullet = "arrow_ranger_mod"
tt = E.register_t(E, "soldier_gryphon_guard_thing", "soldier_militia")

E.add_comps(E, tt, "ranged")

anchor_y = 0.24
anchor_x = 0.5
image_y = 87
image_x = 108
tt.health.hp_max = 1
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health_bar = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 0
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "bomb_swamp_thing_soldier"
tt.ranged.attacks[1].bullet_start_offset = {
	v(adx(66), ady(86))
}
tt.ranged.attacks[1].cooldown = 5
tt.ranged.attacks[1].max_range = 9e+99
tt.ranged.attacks[1].min_range = 1
tt.ranged.attacks[1].shoot_time = fts(13)
tt.render.sprites[1].prefix = "soldier_gryphon_guard333"
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.ui = nil
tt.unit.hit_offset = v(0, 10)
tt.unit.level = 1
tt.unit.mod_offset = v(0, 21)
tt.vis.bans = bor(tt.vis.bans, F_RANGED)
tt.vis.bans = bor(F_BLOCK, F_RANGED)
tt = E.register_t(E, "soldier_gryphon_guard2", "soldier_militia")

E.add_comps(E, tt, "ranged")

tt.health.hp_max = 1
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health_bar = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 0
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "ray_arcane"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 10)
}
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].max_range = 480
tt.ranged.attacks[1].min_range = 1
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].prefix = "soldier_gryphon_guard2"
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.ui = nil
tt.unit.hit_offset = v(0, 10)
tt.unit.level = 1
tt.unit.mod_offset = v(0, 21)
tt.vis.bans = bor(tt.vis.bans, F_RANGED)
tt.vis.bans = bor(F_BLOCK, F_RANGED)
tt = RT("tower_musketeer", "tower_archer_1")

AC(tt, "attacks", "powers")

image_y = 90
tt.tower.type = "musketeer"
tt.tower.level = 1
tt.tower.price = 230
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 17
tt.info.i18n_key = "TOWER_MUSKETEERS"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0009") or "info_portraits_towers_0004"
tt.powers.sniper = CC("power")
tt.powers.sniper.attack_idx = 2
tt.powers.sniper.price_base = 250
tt.powers.sniper.price_inc = 250
tt.powers.sniper.damage_factor_inc = 0.2
tt.powers.sniper.instakill_chance_inc = 0.2
tt.powers.sniper.enc_icon = 3
tt.powers.shrapnel = CC("power")
tt.powers.shrapnel.attack_idx = 3
tt.powers.shrapnel.price_base = 300
tt.powers.shrapnel.price_inc = 300
tt.powers.shrapnel.enc_icon = 4
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_musketeer_%04i"
tt.render.sprites[1].offset = v(0, 14)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_tower_0004"
tt.render.sprites[2].offset = v(0, 37)
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].prefix = "tower_musketeer_shooter"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	},
	sniper_shoot = {
		"sniperShootUp",
		"sniperShootDown"
	},
	sniper_seek = {
		"sniperSeekUp",
		"sniperSeekDown"
	},
	cannon_shoot = {
		"cannonShootUp",
		"cannonShootDown"
	},
	cannon_fuse = {
		"cannonFuseUp",
		"cannonFuseDown"
	}
}
tt.render.sprites[3].offset = v(-8, 56)
tt.render.sprites[4] = table.deepclone(tt.render.sprites[3])
tt.render.sprites[4].offset.x = 8
tt.main_script.update = scripts.tower_musketeer.update
tt.sound_events.insert = "ArcherMusketeerTaunt"
tt.attacks.range = 235
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "shotgun_musketeer"
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(6)
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet_start_offset = {
	v(6, 8),
	v(4, -5)
}
tt.attacks.list[2] = CC("bullet_attack")
tt.attacks.list[2].animation = "sniper_shoot"
tt.attacks.list[2].animation_seeker = "sniper_seek"
tt.attacks.list[2].bullet = "shotgun_musketeer_sniper"
tt.attacks.list[2].bullet_start_offset = tt.attacks.list[1].bullet_start_offset
tt.attacks.list[2].cooldown = 14
tt.attacks.list[2].power_name = "sniper"
tt.attacks.list[2].shoot_time = fts(22)
tt.attacks.list[2].vis_flags = bor(F_INSTAKILL)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].range = tt.attacks.range*1.5
tt.attacks.list[3] = table.deepclone(tt.attacks.list[2])
tt.attacks.list[3].chance = 0
tt.attacks.list[3].bullet = "shotgun_musketeer_sniper_instakill"
tt.attacks.list[4] = CC("bullet_attack")
tt.attacks.list[4].animation = "cannon_shoot"
tt.attacks.list[4].animation_seeker = "cannon_fuse"
tt.attacks.list[4].bullet = "bomb_musketeer"
tt.attacks.list[4].loops = 6
tt.attacks.list[4].bullet_start_offset = tt.attacks.list[1].bullet_start_offset
tt.attacks.list[4].cooldown = 9
tt.attacks.list[4].power_name = "shrapnel"
tt.attacks.list[4].range = tt.attacks.range*0.5
tt.attacks.list[4].shoot_time = fts(16)
tt.attacks.list[4].node_prediction = fts(6)
tt.attacks.list[4].min_spread = 12.5
tt.attacks.list[4].max_spread = 32.5
tt.attacks.list[4].vis_bans = bor(F_FLYING)
tt.attacks.list[4].shoot_fx = "fx_rifle_smoke"
tt = RT("tower_imperial_patrol", "tower_barrack_1")

AC(tt, "powers")

tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0007") or "info_portraits_towers_0005"
tt.info.enc_icon = 14
tt.info.i18n_key = "TOWER_IMPERIAL_PATROL"
tt.tower.type = "imperial_patrol"
tt.tower.price = 230
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "soldier_s6_imperial_guard"
tt.barrack.rally_range = 145
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2].name = "tower_barracks_lvl4_Paladins_layer1_0001"
tt.render.sprites[2].offset = v(0, 39)
tt.render.sprites[3].prefix = "towerbarracklvl4_paladin_door"
tt.render.sprites[3].offset = v(0, 39)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "tower_paladin_flag"
tt.render.sprites[4].offset = v(7, 72)
tt.sound_events.insert = "BarrackPaladinTaunt"
tt.sound_events.change_rally_point = "BarrackPaladinTaunt"
tt = RT("tower_paladin", "tower_barrack_1")

AC(tt, "powers")

tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0007") or "info_portraits_towers_0005"
tt.info.enc_icon = 14
tt.info.i18n_key = "TOWER_PALADINS"
tt.tower.type = "paladin"
tt.tower.price = 230
tt.powers.healing = E.clone_c(E, "power")
tt.powers.healing.price_base = 150
tt.powers.healing.price_inc = 150
tt.powers.healing.enc_icon = 6
tt.powers.shield = E.clone_c(E, "power")
tt.powers.shield.price_base = 250
tt.powers.shield.price_inc = 100
tt.powers.shield.max_level = 1
tt.powers.shield.enc_icon = 7
tt.powers.holystrike = E.clone_c(E, "power")
tt.powers.holystrike.price_base = 220
tt.powers.holystrike.price_inc = 150
tt.powers.holystrike.enc_icon = 5
tt.powers.holystrike.name = "HOLY_STRIKE"
tt.barrack.soldier_type = "soldier_paladin"
tt.barrack.rally_range = 145
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2].name = "tower_barracks_lvl4_Paladins_layer1_0001"
tt.render.sprites[2].offset = v(0, 39)
tt.render.sprites[3].prefix = "towerbarracklvl4_paladin_door"
tt.render.sprites[3].offset = v(0, 39)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "tower_paladin_flag"
tt.render.sprites[4].offset = v(7, 72)
tt.sound_events.insert = "BarrackPaladinTaunt"
tt.sound_events.change_rally_point = "BarrackPaladinTaunt"
tt = RT("tower_barbarian", "tower_barrack_1")

AC(tt, "powers")

tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0008") or "info_portraits_towers_0012"
tt.info.enc_icon = 18
tt.info.i18n_key = "TOWER_BARBARIANS"
tt.tower.type = "barbarian"
tt.tower.price = 230
tt.powers.dual = E.clone_c(E, "power")
tt.powers.dual.price_base = 150
tt.powers.dual.price_inc = 150
tt.powers.dual.enc_icon = 12
tt.powers.dual.name = "DOUBLE_AXE"
tt.powers.twister = E.clone_c(E, "power")
tt.powers.twister.price_base = 200
tt.powers.twister.price_inc = 150
tt.powers.twister.enc_icon = 13
tt.powers.throwing = E.clone_c(E, "power")
tt.powers.throwing.price_base = 200
tt.powers.throwing.price_inc = 100
tt.powers.throwing.enc_icon = 14
tt.powers.throwing.name = "THROWING_AXES"
tt.barrack.soldier_type = "soldier_barbarian"
tt.barrack.rally_range = 145
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 13)
tt.render.sprites[2].name = "tower_barrack_lvl4_Barbarians_layer1_0001"
tt.render.sprites[2].offset = v(0, 39)
tt.render.sprites[3].prefix = "towerbarracklvl4_barbarian_door"
tt.render.sprites[3].offset = v(0, 39)
tt.sound_events.insert = "BarrackBarbarianTaunt"
tt.sound_events.change_rally_point = "BarrackBarbarianTaunt"
tt = RT("dagger_drow", "bullet")
tt.bullet.damage_max = 30
tt.bullet.damage_min = 15
tt.bullet.hide_radius = 6
tt.bullet.hit_distance = 22
tt.bullet.hit_fx = "fx_dagger_drow_hit"
tt.bullet.particles_name = "ps_dagger_drow"
tt.bullet.predict_target_pos = true
tt.flight_time_range = {
	fts(9),
	fts(16)
}
tt.main_script.insert = scripts2.dagger_drow.insert
tt.main_script.update = scripts2.arrow.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "mercenaryDraw_proy"
tt = RT("mod_life_drain_drow", "modifier")

AC(tt, "render")

tt.heal_factor = 2
tt.heal_remove_modifiers = {
	"mod_drider_poison",
	"mod_son_of_mactans_poison",
	"mod_rotten_lesser_pestilence",
	"mod_poison_giant_rat",
	"mod_myconid_poison"
}
tt.main_script.insert = scripts2.mod_heal_on_damage.insert
tt.main_script.update = scripts2.mod_heal_on_damage.update
tt.modifier.use_mod_offset = false
tt.render.sprites[1].name = "soldier_drow_heal"
tt.render.sprites[1].anchor.y = 0.2037037037037037
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].hide_after_runs = 1
tt = RT("ps_dagger_drow")

AC(tt, "pos", "particle_system")

tt.particle_system.name = "dagger_drow_particle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(8)
}
tt.particle_system.emission_rate = 30
tt.particle_system.z = Z_BULLET_PARTICLES
tt = E.register_t(E, "fx_dagger_drow_hit", "fx")
tt.render.sprites[1].name = "fx_dagger_drow_hit"
tt = E.register_t(E, "tower_blade", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.enc_icon = 18
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_2222"
tt.barrack.soldier_type = "soldier_blade"
tt.powers.perfect_parry = E.clone_c(E, "power")
tt.powers.perfect_parry.price_base = 225
tt.powers.perfect_parry.price_inc = 225
tt.powers.perfect_parry.enc_icon = 116
tt.powers.blade_dance = E.clone_c(E, "power")
tt.powers.blade_dance.price_base = 250
tt.powers.blade_dance.price_inc = 250
tt.powers.blade_dance.enc_icon = 115
tt.powers.swirling = E.clone_c(E, "power")
tt.powers.swirling.price_base = 100
tt.powers.swirling.price_inc = 100
tt.powers.swirling.max_level = 3
tt.powers.swirling.enc_icon = 117
tt.powers.swirling.name = "SWIRLING_EDGE"
tt.render.sprites[2].name = "barracks_towers_layer1_0076"
tt.render.sprites[3].prefix = "tower_blade_door"
tt.sound_events.change_rally_point = "ElvesBarrackBladesingerTaunt"
tt.sound_events.insert = "ElvesBarrackBladesingerTaunt"
tt.tower.price = 275
tt.tower.type = "blade"
tt = E.register_t(E, "soldier_blade", "soldier_militia")

E.add_comps(E, tt, "powers", "revive", "dodge", "timed_attacks")

image_y = 42
anchor_y = 0.25
tt.dodge.animation = "dodge"
tt.dodge.chance = 0
tt.dodge.chance_inc = 0.1
tt.dodge.counter_attack = E.clone_c(E, "area_attack")
tt.dodge.counter_attack.animation = "perfect_parry"
tt.dodge.counter_attack.duration = 2
tt.dodge.counter_attack.damage_every = fts(5)
tt.dodge.counter_attack.damage_max = 3
tt.dodge.counter_attack.damage_min = 3
tt.dodge.counter_attack.damage_radius = 50
tt.dodge.counter_attack.damage_type = DAMAGE_TRUE
tt.dodge.counter_attack.hit_time = fts(5)
tt.dodge.counter_attack.sound = "TowerBladesingerPerfectParry"
tt.dodge.power_name = "perfect_parry"
tt.dodge.ranged = true
tt.health.armor = 0.5
tt.health.dead_lifetime = 15
tt.health.hp_max = 200
tt.health.on_damage = scripts2.soldier_blade.on_damage
tt.info.portrait = "portraits_sc_0136"
tt.main_script.insert = scripts2.soldier_blade.insert
tt.main_script.update = scripts2.soldier_blade.update
tt.melee.attacks[1].animation = "attack1"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 14
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].damage_inc = 5
tt.melee.attacks[1].cooldown_inc = -0.1
tt.melee.attacks[1].pop = {
  "pop_bladesinger"
}
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[1].power_name = "swirling"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.33
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[3].animation = "attack3"
tt.melee.attacks[3].chance = 0.5
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 60
tt.motion.max_speed = 75
tt.powers.perfect_parry = E.clone_c(E, "power")
tt.powers.blade_dance = E.clone_c(E, "power")
tt.powers.blade_dance.damage_max = {
  35,
  47,
  56
}
tt.powers.blade_dance.damage_min = {
  25,
  35,
  40
}
tt.powers.blade_dance.hits = {
  2,
  3,
  4
}
tt.powers.swirling = E.clone_c(E, "power")
tt.regen.health = 25
tt.render.sprites[1].prefix = "soldier_blade"
tt.render.sprites[1].anchor.y = anchor_y
tt.revive.disabled = true
tt.revive.chance = 0.10
tt.revive.health_recover = 1
tt.revive.fx = "fx_soldier_barrack_revive"
tt.soldier.melee_slot_offset = v(5, 0)
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].cooldown = 9
tt.timed_attacks.list[1].damage_max = 1919810
tt.timed_attacks.list[1].damage_min = 114514
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].max_range = 125
tt.timed_attacks.list[1].hits = 114514
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_STUN)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_BOSS, F_WATER)
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(5)
tt.timed_attacks.list[1].sound = "TowerBladesingerBladedance"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt = E.register_t(E, "soldier_forest", "soldier_militia")

E.add_comps(E, tt, "powers", "revive", "timed_attacks", "ranged")

image_y = 114
anchor_y = 0.25
tt.health.armor = 0
tt.health.dead_lifetime = 12
tt.health.hp_max = 300
tt.health_bar.offset = v(0, 54)
tt.info.portrait = "portraits_sc_0137"
tt.info.random_name_format = "ELVES_SOLDIER_FOREST_KEEPER_%i_NAME"
tt.info.random_name_count = 11
tt.main_script.insert = scripts2.soldier_forest.insert
tt.main_script.update = scripts2.soldier_forest.update
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 1.3
tt.melee.attacks[1].damage_max = 36
tt.melee.attacks[1].damage_min = 24
tt.melee.attacks[1].pop = {
  "pop_forest_keeper"
}
tt.melee.attacks[1].forced_cooldown = true
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 49.5
tt.motion.max_speed = 60
tt.powers.circle = E.clone_c(E, "power")
tt.powers.eerie = E.clone_c(E, "power")
tt.powers.oak = E.clone_c(E, "power")
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet = "spear_forest"
tt.ranged.attacks[1].bullet_start_offset = {
  v(0, 35)
}
tt.ranged.attacks[1].cooldown = fts(18) + 2.5
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 22.5
tt.ranged.attacks[1].shoot_time = fts(8)
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].animation = "oak_attack"
tt.ranged.attacks[2].bullet = "spear_forest_oak"
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].shoot_time = fts(14)
tt.regen.health = 35
tt.render.sprites[1].prefix = "soldier_forest"
tt.render.sprites[1].anchor.y = anchor_y
tt.revive.disabled = true
tt.revive.chance = 0.10
tt.revive.health_recover = 1
tt.revive.fx = "fx_soldier_barrack_revive"
tt.soldier.melee_slot_offset = v(5, 0)
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "circle"
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].cooldown = 10
tt.timed_attacks.list[1].max_range = 150
tt.timed_attacks.list[1].mod = "mod_forest_circle"
tt.timed_attacks.list[1].sound = "TowerForestKeeperCircleOfHealing"
tt.timed_attacks.list[1].trigger_hp_factor = 0.8
tt.timed_attacks.list[1].vis_bans = bor(F_ENEMY)
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[2] = E.clone_c(E, "aura_attack")
tt.timed_attacks.list[2].animation = "eerie"
tt.timed_attacks.list[2].cast_time = fts(20)
tt.timed_attacks.list[2].cooldown = 16
tt.timed_attacks.list[2].max_range = 110
tt.timed_attacks.list[2].max_range_inc = 15
tt.timed_attacks.list[2].bullet = "aura_forest_eerie"
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING, F_BOSS)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.ui.click_rect = r(-10, -2, 20, 35)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 25)
tt.unit.hit_offset = v(0, 25)

tt = E.register_t(E, "soldier_testwizard", "soldier_militia")

E.add_comps(E, tt, "powers", "revive", "timed_attacks", "ranged")

image_y = 114
anchor_y = 0.25
tt.health.armor = 0
tt.health.dead_lifetime = 12
tt.health.hp_max = 300
tt.health_bar.offset = v(0, 54)
tt.info.portrait = "portraits_sc_0137"
tt.info.random_name_format = "ELVES_SOLDIER_FOREST_KEEPER_%i_NAME"
tt.info.random_name_count = 11
tt.main_script.insert = scripts2.soldier_forest.insert
tt.main_script.update = scripts2.soldier_forest.update
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 1.3
tt.melee.attacks[1].damage_max = 36
tt.melee.attacks[1].damage_min = 24
tt.melee.attacks[1].pop = {
  "pop_forest_keeper"
}
tt.melee.attacks[1].forced_cooldown = true
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 49.5
tt.motion.max_speed = 60
tt.powers.circle = E.clone_c(E, "power")
tt.powers.eerie = E.clone_c(E, "power")
tt.powers.oak = E.clone_c(E, "power")
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet = "spear_forest"
tt.ranged.attacks[1].bullet_start_offset = {
  v(0, 35)
}
tt.ranged.attacks[1].cooldown = fts(18) + 2.5
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 22.5
tt.ranged.attacks[1].shoot_time = fts(8)
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].animation = "oak_attack"
tt.ranged.attacks[2].bullet = "spear_forest_oak"
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].shoot_time = fts(14)
tt.regen.health = 35
tt.render.sprites[1].prefix = "soldier_forest"
tt.render.sprites[1].anchor.y = anchor_y
tt.revive.disabled = true
tt.revive.chance = 0.10
tt.revive.health_recover = 1
tt.revive.fx = "fx_soldier_barrack_revive"
tt.soldier.melee_slot_offset = v(5, 0)
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "circle"
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].cooldown = 10
tt.timed_attacks.list[1].max_range = 150
tt.timed_attacks.list[1].mod = "mod_forest_circle"
tt.timed_attacks.list[1].sound = "TowerForestKeeperCircleOfHealing"
tt.timed_attacks.list[1].trigger_hp_factor = 0.8
tt.timed_attacks.list[1].vis_bans = bor(F_ENEMY)
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[2] = E.clone_c(E, "aura_attack")
tt.timed_attacks.list[2].animation = "eerie"
tt.timed_attacks.list[2].cast_time = fts(20)
tt.timed_attacks.list[2].cooldown = 16
tt.timed_attacks.list[2].max_range = 110
tt.timed_attacks.list[2].max_range_inc = 15
tt.timed_attacks.list[2].bullet = "aura_forest_eerie"
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING, F_BOSS)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.ui.click_rect = r(-10, -2, 20, 35)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 25)
tt.unit.hit_offset = v(0, 25)
tt = RT("tower_drow", "tower_barrack_1")

AC(tt, "powers")

tt.barrack.soldier_type = "soldier_drow"
tt.info.i18n_key = "ELVES_TOWER_SPECIAL_DROW"
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0016"
tt.powers.life_drain = CC("power")
tt.powers.life_drain.price_base = 250
tt.powers.life_drain.price_inc = 150
tt.powers.double_dagger = CC("power")
tt.powers.double_dagger.price_base = 200
tt.powers.double_dagger.price_inc = 150
tt.powers.double_dagger.max_level = 1
tt.powers.blade_mail = CC("power")
tt.powers.blade_mail.price_base = 175
tt.powers.blade_mail.price_inc = 175
tt.render.sprites[1].name = "terrains_0003"
tt.render.sprites[2].name = "mercenaryDraw_tower_layer1_0001"
tt.render.sprites[2].offset = v(0, 29)
tt.render.sprites[3].prefix = "tower_drow_door"
tt.render.sprites[3].offset = v(0, 29)
tt.sound_events.change_rally_point = "ElvesDrowTaunt"
tt.sound_events.mute_on_level_insert = true
tt.tower.price = 300
tt.tower.type = "drow"
tt = RT("soldier_drow", "soldier_militia")

AC(tt, "powers", "ranged", "track_damage")

tt.health.armor = 0.4
tt.health.dead_lifetime = 12
tt.health.hp_max = 300
tt.regen.health = 35
tt.health.spiked_armor = 0
tt.info.portrait = "portraits_sc_0061"
tt.info.random_name_format = "ELVES_SOLDIER_DROW_%i_NAME"
tt.info.random_name_count = 15
tt.main_script.insert = scripts2.soldier_drow.insert
tt.main_script.update = scripts2.soldier_drow.update
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].animation = "healAttack"
tt.melee.attacks[2].track_damage = true
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].damage_inc = 20
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].cooldown = 4
tt.melee.attacks[2].hit_time = fts(12)
tt.melee.attacks[2].power_name = "life_drain"
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 65
tt.motion.max_speed = 75
tt.powers.life_drain = CC("power")
tt.powers.double_dagger = CC("power")
tt.powers.blade_mail = CC("power")
tt.powers.blade_mail.spiked_armor = {
	0.25,
	0.5,
	0.75
}
tt.ranged.attacks[1].bullet = "dagger_drow"
tt.ranged.attacks[1].animations = {
	"shoot_start",
	"shoot_loop",
	"shoot_end"
}
tt.ranged.attacks[1].bullet_start_offset = {
	v(14, 12)
}
tt.ranged.attacks[1].cooldown = fts(22) + 1
tt.ranged.attacks[1].loops = 1
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_times = {
	0
}
tt.ranged.attacks[1].power_name = "double_dagger"
tt.render.sprites[1].prefix = "soldier_drow"
tt.render.sprites[1].anchor.y = 0.2037037037037037
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].hidden = true
tt.render.sprites[2].name = "soldier_drow_blade_mail_decal"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].ignore_start = true
tt.track_damage.mod = "mod_life_drain_drow"
tt.unit.mod_offset = v(0, 15)
tt.vis.flags = bor(tt.vis.flags, F_DARK_ELF)
tt = E.register_t(E, "pop_ewoks", "pop")
tt.render.sprites[1].name = "elven_pops_0008"
tt = E.register_t(E, "tower_ewok_holder")

E.add_comps(E, tt, "tower", "tower_holder", "pos", "render", "ui", "info", "editor")

tt.tower.type = "holder_ewok"
tt.tower.level = 1
tt.tower.can_be_mod = false
tt.info.i18n_key = "ELVES_EWOK_TOWER"
tt.info.fn = scripts2.tower_ewok_holder.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0013"
tt.render.sprites[1].name = "terrains_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "ewok_hut_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 32)
tt.ui.click_rect = r(-40, -10, 80, 90)
tt = E.register_t(E, "tower_ewok", "tower")

E.add_comps(E, tt, "barrack")

tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0013"
tt.barrack.max_soldiers = 4
tt.barrack.rally_range = 200
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "soldier_ewok"
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)
tt.info.i18n_key = "ELVES_EWOK_TOWER"
tt.info.fn = scripts2.tower_barrack.get_info
tt.main_script.insert = scripts2.tower_barrack.insert
tt.main_script.remove = scripts2.tower_barrack.remove
tt.main_script.update = scripts2.tower_barrack_mercenaries.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_0001"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "ewok_hut_0002"
tt.render.sprites[2].offset = v(0, 32)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 32)
tt.render.sprites[3].prefix = "tower_ewok_door"
tt.render.door_sid = 3
tt.sound_events.change_rally_point = "ElvesEwokTaunt"
tt.sound_events.insert = "GUITowerBuilding"
tt.sound_events.mute_on_level_insert = true
tt.tower.can_be_mod = false
tt.tower.level = 1
tt.tower.price = 25
tt.tower.terrain_style = nil
tt.tower.type = "ewok"
tt.ui.click_rect = r(-40, -10, 80, 90)
tt = E.register_t(E, "soldier_ewok", "soldier_militia")

E.add_comps(E, tt, "dodge", "ranged")

image_y = 36
anchor_y = image_y/200
tt.dodge.animation_end = "shield_end"
tt.dodge.animation_hit = "shield_hit"
tt.dodge.animation_start = "shield_start"
tt.dodge.can_dodge = function (store, this)
	this.dodge.last_hit_ts = store.tick_ts

	return this.health.hp <= this.health.hp_max*0.5
end
tt.dodge.chance = 1
tt.dodge.cooldown = 20
tt.dodge.duration = 4
tt.dodge.ranged = true
tt.dodge.time_before_hit = 0
tt.health.armor = 0
tt.health.dead_lifetime = 3
tt.health.hp_max = 100
tt.health_bar.offset = v(0, 29)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = "portraits_sc_0060"
tt.info.random_name_count = 6
tt.info.random_name_format = "ELVES_SOLDIER_EWOK_%i_NAME"
tt.main_script.insert = scripts2.soldier_barrack.insert
tt.main_script.remove = scripts2.soldier_barrack.remove
tt.main_script.update = scripts2.soldier_ewok.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 7
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].pop = {
	"pop_ewoks"
}
tt.melee.attacks[1].pop_chance = 0.1
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 50
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "bullet_soldier_ewok"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 10)
}
tt.ranged.attacks[1].cooldown = 1.3
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = fts(11)
tt.regen.cooldown = 0.5
tt.regen.health = 15
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldier_ewok"
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.insert = "ElvesEwokTaunt"
tt.ui.click_rect = r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.unit.price = 100
tt = E.register_t(E, "bullet_soldier_ewok", "arrow")
tt.bullet.damage_max = 20
tt.bullet.damage_min = 16
tt.bullet.align_with_trajectory = true
tt.bullet.prediction_error = false
tt.bullet.reset_to_target_pos = true
tt.bullet.miss_decal = nil
tt.render.sprites[1].name = "bullet_soldier_ewok"
tt.render.sprites[1].animated = true
tt = E.register_t(E, "decal_s05_tree_round", "decal")
tt.render.sprites[1].name = "stage5_tree"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.13953488372093023
tt = E.register_t(E, "decal_s05_tree_pine", "decal")
tt.render.sprites[1].name = "stage5_pine"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.08333333333333333
tt = RT("tower_bastion_holder")

AC(tt, "tower", "tower_holder", "pos", "render", "ui", "info", "editor", "editor_script")

tt.editor.props = {
	{
		"tower.default_rally_pos",
		PT_COORDS
	},
	{
		"tower.holder_id",
		PT_STRING
	},
	{
		"editor.game_mode",
		PT_NUMBER
	}
}
tt.editor_script.insert = scripts2.editor_tower.insert
tt.editor_script.remove = scripts2.editor_tower.remove
tt.tower.type = "holder_bastion"
tt.tower.level = 1
tt.tower.can_be_mod = false
tt.tower.menu_offset = v(-10, 16)
tt.info.fn = scripts2.tower_bastion.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0020"
tt.info.i18n_key = "ELVES_TOWER_BASTION_BROKEN"
tt.render.sprites[1].name = "galahadriansBastion_layer2_0054"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.3153846153846154
tt.render.sprites[1].offset = (IS_CONSOLE and v(0, 24)) or v(0, -9)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "galahadriansBastion_layer2_0054"
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0.3153846153846154
tt.ui.click_rect = r(-40, -10, 80, 90)
tt = RT("tower_bastion", "tower")

AC(tt, "attacks", "powers")

tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0020"
tt.info.i18n_key = "ELVES_TOWER_BASTION"
tt.info.fn = scripts2.tower_bastion.get_info
tt.main_script.insert = scripts2.tower_bastion.insert
tt.main_script.update = scripts2.tower_bastion.update
tt.powers.razor_edge = CC("power")
tt.powers.razor_edge.max_level = 2
tt.powers.razor_edge.price_base = 300
tt.powers.razor_edge.price_inc = 300
tt.powers.razor_edge.attack_idx = 1
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "galahadriansBastion_layer2_0053"
tt.render.sprites[1].anchor.y = 0.3153846153846154
tt.render.sprites[1].offset = (IS_CONSOLE and v(0, 24)) or v(0, -9)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true

for i = 1, 4, 1 do
	local s = CC("sprite")
	s.prefix = "galahadriansBastion_layer" .. i
	s.name = "idle"
	s.anchor.y = 0.3153846153846154
	s.group = "animated"
	tt.render.sprites[i + 1] = s
end


tt.tower.type = "bastion"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.menu_offset = v(-10, 16)
tt.ui.click_rect = r(-50, -10, 100, 80)
tt.attacks.hide_range = true
tt.attacks.range = 225
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "bullet_razor_edge"
tt.attacks.list[1].payload_name = "aura_razor_edge"
tt.attacks.list[1].bullet_start_offset = {
	v(40, 33)
}
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(9)
tt.attacks.list[1].sound_shoot = "ElvesTowerBastionShot"
tt.attacks.list[1].vis_bans = bor(F_FLYING, F_FRIEND)
tt.attacks.list[1].vis_flags = bor(F_RANGED)
tt.sound_events.insert = "ElvesTowerBastionInsertTaunt"
tt = RT("bullet_razor_edge", "bolt")
tt.bullet.payload = "aura_razor_edge"
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.acceleration_factor = 0.3
tt.bullet.ignore_rotation = true
tt.bullet.hit_fx = nil
tt.bullet.max_speed = 450
tt.bullet.min_speed = 150
tt.bullet.pop = nil
tt.render.sprites[1].prefix = "bullet_razor_edge"
tt.render.sprites[1].name = "flying"
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt = RT("aura_razor_edge", "aura")

AC(tt, "render", "tween")

tt.aura.cycle_time = fts(6)
tt.aura.damage_min = 2
tt.aura.damage_max = 4
tt.aura.damage_inc = 4
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.radius = 75
tt.aura.duration = 1
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.aura.vis_flags = bor(F_RANGED)
tt.main_script.insert = scripts2.aura_razor_edge.insert
tt.main_script.update = scripts2.aura_apply_damage.update
tt.render.sprites[1].name = "bullet_razor_edge_flying"
tt.render.sprites[1].loop = true
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.2,
		255
	},
	{
		"this.aura.duration-0.2",
		255
	},
	{
		"this.aura.duration",
		0
	}
}

for i = 2, 4, 1 do
	local s = CC("sprite")
	s.name = "bullet_razor_edge_smoke"
	s.loop = true
	s.random_ts = 0.4
	s.anchor.y = 0
	s.offset.x = ({
		0,
		-15,
		0,
		15
	})[i]
	s.offset.y = ({
		0,
		-20,
		-5,
		-20
	})[i]
	tt.render.sprites[i] = s
	tt.tween.props[i] = table.deepclone(tt.tween.props[1])
	tt.tween.props[i].sprite_id = i
	tt.tween.props[i].keys[1][2] = 0
end
tt = E.register_t(E, "tower_forest", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.enc_icon = 19
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_1234"
tt.info.i18n_key = "TOWER_FOREST_KEEPERS"
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "soldier_forest"
tt.barrack.rally_angle_offset = math.pi/3
tt.powers.circle = E.clone_c(E, "power")
tt.powers.circle.price_base = 200
tt.powers.circle.price_inc = 200
tt.powers.circle.enc_icon = 9
tt.powers.eerie = E.clone_c(E, "power")
tt.powers.eerie.price_base = 285
tt.powers.eerie.price_inc = 285
tt.powers.eerie.max_level = 2
tt.powers.eerie.enc_icon = 10
tt.powers.oak = E.clone_c(E, "power")
tt.powers.oak.price_base = 300
tt.powers.oak.price_inc = 250
tt.powers.oak.enc_icon = 11
tt.render.sprites[2].name = "barracks_towers_layer1_0101"
tt.render.sprites[3].prefix = "tower_forest_door"
tt.render.sprites[3].hidden = true
tt.sound_events.change_rally_point = "ElvesBarrackForestKeeperTaunt"
tt.sound_events.insert = "ElvesBarrackForestKeeperTaunt"
tt.tower.price = 300
tt.tower.type = "forest"
tt = E.register_t(E, "mod_forest_circle", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.render.sprites[1].name = "decal_mod_forest_circle"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "forestKeeper_soldierBuff"
tt.render.sprites[2].animated = false
tt.render.sprites[2].sort_y_offset = -1
tt.render.sprites[2].anchor.y = 0.21428571428571427
tt.modifier.duration = 7
tt.modifier.use_mod_offset = false
tt.modifier.bans = {
	"mod_rotten_lesser_pestilence",
	"mod_poison_giant_rat",
	"mod_wererat_poison",
	"mod_myconid_poison",
	"mod_witch_frog",
	"mod_lycanthropy",
	"mod_flareon_burn",
	"mod_blackburn_stun",
	"mod_burning_floor_burn"
}
tt.modifier.remove_banned = true
tt.hps.heal_min = 0
tt.hps.heal_max = 0
tt.hps.heal_inc = 6
tt.hps.heal_every = 0.2
tt.main_script.insert = scripts2.mod_hps.insert
tt.main_script.update = scripts2.mod_hps.update
tt = E.register_t(E, "mod_forest_eerie_slow", "mod_slow")
tt.modifier.duration = 0.5
tt.slow.factor = 0.5
tt = E.register_t(E, "mod_forest_eerie_dps", "modifier")

E.add_comps(E, tt, "dps")

tt.dps.damage_max = 2
tt.dps.damage_min = 2
tt.dps.damage_inc = 1
tt.dps.damage_every = fts(5)
tt.modifier.duration = 0.5
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dps.update
tt = E.register_t(E, "spear_forest", "arrow")
tt.bullet.damage_max = 69
tt.bullet.damage_min = 45
tt.bullet.miss_decal = "forestKeeper_proy_0002-f"
tt.bullet.miss_decal_anchor = v(1, 0.5)
tt.bullet.flight_time = fts(14)
tt.bullet.hide_radius = 1
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "forestKeeper_proy_0001-f"
tt.render.sprites[1].anchor.x = 0.8260869565217391
tt.sound_events.insert = "TowerForestKeeperNormalSpear"
tt = E.register_t(E, "spear_forest_oak", "spear_forest")
tt.bullet.damage_max = 55
tt.bullet.damage_min = 55
tt.bullet.damage_inc = 35
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.miss_decal = "forestKeeper_proySpecial_0002-f"
tt.bullet.hit_fx = "fx_spear_forest_oak_hit"
tt.render.sprites[1].name = "forestKeeper_proySpecial_0001-f"
tt.sound_events.insert = "TowerForestKeeperAncientSpear"
tt = E.register_t(E, "aura_forest_eerie", "aura")
tt.aura.mods = {
  "mod_forest_eerie_slow",
  "mod_forest_eerie_dps"
}
tt.aura.radius = 60
tt.aura.duration = 1.5
tt.aura.duration_inc = 2
tt.aura.cycle_time = fts(5)
tt.aura.vis_flags = bor(F_MOD)
tt.aura.vis_bans = bor(F_FLYING, F_FRIEND)
tt.main_script.insert = scripts2.aura_forest_eerie.insert
tt.main_script.update = scripts2.aura_apply_mod.update
tt.roots_count = 9
tt.roots_count_inc = 3
tt.sound_events.insert = "TowerForestKeeperEerieGarden"
tt = E.register_t(E, "fx_spear_forest_oak_hit", "fx")
tt.render.sprites[1].name = "fx_spear_forest_oak_hit"
tt = E.register_t(E, "pop_forest_keeper", "pop")
tt = E.register_t(E, "tower_faerie_dragon", "tower")
E.add_comps(E, tt, "powers", "attacks")

tt.attacks.list[1] = E.clone_c(E, "custom_attack")
tt.attacks.list[1].cooldown = 2.5
tt.attacks.list[1].vis_flags = bor(F_RANGED, F_STUN, F_FREEZE)
tt.attacks.list[1].vis_bans = bor(F_BOSS)
tt.attacks.range = 175
tt.info.i18n_key = "ELVES_TOWER_SPECIAL_FAERIE_DRAGONS"
tt.info.fn = scripts2.tower_faerie_dragon.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0018"
tt.main_script.update = scripts2.tower_faerie_dragon.update
tt.powers.more_dragons = E.clone_c(E, "power")
tt.powers.more_dragons.price_base = 0
tt.powers.more_dragons.price_inc = 75
tt.powers.more_dragons.max_level = 2
tt.powers.more_dragons.idle_offsets = {
	v(-12, 7),
	v(28, -3)
}
tt.powers.improve_shot = E.clone_c(E, "power")
tt.powers.improve_shot.price_base = 125
tt.powers.improve_shot.price_inc = 125
tt.powers.improve_shot.max_level = 2
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_0002"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "fairy_dragon_tower"
tt.render.sprites[2].offset = v(0, 36)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "tower_faerie_dragon_egg"
tt.render.sprites[3].offset = v(-19, 50)
tt.render.sprites[3].r = d2r(15)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "tower_faerie_dragon_egg"
tt.render.sprites[4].offset = v(25, 41)
tt.render.sprites[4].r = d2r(-6)
tt.sound_events.insert = nil
tt.tower.menu_offset = v(2, 20)
tt.tower.price = 125
tt.tower.type = "faerie_dragon"
tt = E.register_t(E, "faerie_dragon", "decal_scripted")

E.add_comps(E, tt, "force_motion", "custom_attack")

anchor_y = 0.5
image_y = 30
tt.flight_height = 80
tt.flight_speed_idle = 80
tt.flight_speed_busy = 120
tt.ramp_dist_idle = 80
tt.ramp_dist_busy = 80
tt.idle_pos = nil
tt.main_script.update = scripts2.faerie_dragon.update
tt.custom_attack = E.clone_c(E, "bullet_attack")
tt.custom_attack.bullet = "bolt_faerie_dragon"
tt.custom_attack.shoot_time = fts(12)
tt.custom_attack.bullet_start_offset = {
	v(13, -30)
}
tt.custom_attack.cooldown = 3
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "faerie_dragon"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop_forced = true
tt.render.sprites[1].sort_y_offset = -12
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.owner = nil
tt = E.register_t(E, "bolt_faerie_dragon", "bolt")
tt.render.sprites[1].prefix = "faerie_dragon_proy"
tt.bullet.damage_min = 25
tt.bullet.damage_max = 45
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.acceleration_factor = 0.25
tt.bullet.min_speed = 90
tt.bullet.max_speed = 180
tt.bullet.hit_fx = "fx_bolt_faerie_dragon"
tt.bullet.mod = "mod_faerie_dragon"
tt.sound_events.insert = "ElvesFaeryDragonAttack"
tt = E.register_t(E, "fx_bolt_faerie_dragon", "fx")
tt.render.sprites[1].name = "faerie_dragon_proy_hit"
tt = E.register_t(E, "fx_faerie_dragon_shoot", "fx")
tt.render.sprites[1].name = "faerie_dragon_shoot_fx"
tt = E.register_t(E, "mod_faerie_dragon", "mod_freeze")

E.add_comps(E, tt, "render")

tt.modifier.duration = nil
tt.render.sprites[1].prefix = "mod_faerie_dragon"
tt.render.sprites[1].sort_y_offset = -2
tt.custom_offsets = {
	flying = v(-5, 28)
}
tt.custom_suffixes = {
	flying = "_air"
}
tt.custom_animations = {
	"start",
	"end"
}
tt.freeze_decal_name = "decal_faerie_dragon_freeze_enemy"
tt.sound_events.insert = "ElvesFaeryDragonAttackCristalization"
tt = E.register_t(E, "mod_faerie_dragon_l0", "mod_faerie_dragon")
tt.modifier.duration = 1
tt = E.register_t(E, "mod_faerie_dragon_l1", "mod_faerie_dragon")
tt.modifier.duration = 1.5
tt = E.register_t(E, "mod_faerie_dragon_l2", "mod_faerie_dragon")
tt.modifier.duration = 2
tt = E.register_t(E, "decal_faerie_dragon_freeze_enemy", "decal_freeze_enemy")
tt.shader_args = {
	tint_color = {
		0.9725490196078431,
		0.6627450980392157,
		0.9882352941176471,
		1
	}
}
tt = E.register_t(E, "bullet_pixie_instakill", "arrow")
tt.bullet.flight_time = fts(12)
tt.bullet.rotation_speed = (FPS*45*math.pi)/180
tt.bullet.damage_type = bor(DAMAGE_EAT, DAMAGE_NO_SPAWNS)
tt.bullet.ignore_hit_offset = true
tt.bullet.hit_blood_fx = nil
tt.bullet.hit_fx = "fx_bullet_pixie_instakill_hit_"
tt.bullet.pop = nil
tt.render.sprites[1].name = "pixie_mushroom"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "ElvesGnomeDesintegrate"
tt = E.register_t(E, "bullet_pixie_poison", "bullet_pixie_instakill")
tt.bullet.mod = "mod_pixie_poison"
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_fx = "fx_bullet_pixie_poison_hit_"
tt.render.sprites[1].name = "pixie_bottle"
tt.sound_events.insert = nil
tt = E.register_t(E, "pop_faerie_steal", "pop")
tt.render.sprites[1].name = "elven_pops_0013"
tt = E.register_t(E, "mod_teleport_mage", "mod_teleport")
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.modifier.vis_bans = bor(F_BOSS)
tt.max_times_applied = 2
tt.nodes_offset = -20
tt.nodeslimit = 10
tt.delay_start = fts(2)
tt.hold_time = 0.34
tt.delay_end = fts(2)
tt = E.register_t(E, "mod_pixie_poison", "mod_poison")
tt.dps.damage_every = fts(8)
tt.dps.damage_max = 10
tt.dps.damage_min = 10
tt.modifier.duration = 3
tt = E.register_t(E, "mod_pixie_polymorph", "mod_polymorph")
tt.polymorph.custom_entity_names.default = "enemy_rabbit"
tt.polymorph.hit_fx_sizes = {
	"fx_mod_pixie_polymorph_small",
	"fx_mod_pixie_polymorph_big",
	"fx_mod_pixie_polymorph_big"
}
tt = E.register_t(E, "mod_pixie_pickpocket", "modifier")

E.add_comps(E, tt, "pickpocket")

tt.modifier.level = 0
tt.main_script.insert = scripts2.mod_pixie_pickpocket.insert
tt.pickpocket.steal_min = {
	[0] = 1,
	2,
	3,
	4
}
tt.pickpocket.steal_max = {
	[0] = 3,
	4,
	5,
	6
}
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.pop = {
	"pop_faerie_steal"
}
tt = E.register_t(E, "fx_mod_pixie_polymorph_big", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].anchor.y = 0.11764705882352941
tt.render.sprites[1].name = "fx_mod_pixie_polymorph"
tt.sound_events.insert = "ElvesGnomePolymorf"
tt = E.register_t(E, "fx_mod_pixie_polymorph_small", "fx_mod_pixie_polymorph_big")
tt.render.sprites[1].scale = vv(0.8)
tt = E.register_t(E, "fx_mod_pixie_teleport", "fx")
tt.render.sprites[1].prefix = "fx_mod_pixie_teleport"
tt.render.sprites[1].size_names = {
	"small",
	"small",
	"big"
}
tt = E.register_t(E, "fx_bullet_pixie_instakill_hit_big", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].anchor.y = 0.11764705882352941
tt.render.sprites[1].name = "fx_bullet_pixie_instakill_hit"
tt.sound_events.insert = "BombExplosionSound"
tt = E.register_t(E, "fx_bullet_pixie_instakill_hit_small", "fx_bullet_pixie_instakill_hit_big")
tt.render.sprites[1].scale = vv(0.8)
tt = E.register_t(E, "fx_bullet_pixie_poison_hit_big", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].anchor.y = 0
tt.render.sprites[1].name = "fx_bullet_pixie_poison_hit"
tt.sound_events.insert = "ElvesGnomePoison"
tt = E.register_t(E, "fx_bullet_pixie_poison_hit_small", "fx_bullet_pixie_poison_hit_big")
tt.render.sprites[1].scale = vv(0.8)
tt = E.register_t(E, "mod_pixie_teleport", "mod_teleport_mage")

E.add_comps(E, tt, "sound_events")

tt.max_times_applied = nil
tt.hold_time = fts(10)
tt.nodes_offset = -50
tt.fx_start = "fx_mod_pixie_teleport"
tt.fx_end = "fx_mod_pixie_teleport"
tt.sound_events.insert = "ElvesGnomeTeleport"
tt = E.register_t(E, "tower_pixie", "tower")

E.add_comps(E, tt, "powers", "attacks")

tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet_start_offset = v(10, 11)
tt.attacks.list[1].bullet = "bullet_pixie_instakill"
tt.attacks.list[1].vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[1].vis_flags = bor(F_RANGED, F_STUN, F_INSTAKILL)
tt.attacks.list[1].chance = 0
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].animation = "shoot"
tt.attacks.list[2].bullet = "bullet_pixie_poison"
tt.attacks.list[2].vis_flags = bor(F_RANGED, F_STUN, F_POISON)
tt.attacks.list[2].chance = 0
tt.attacks.list[3] = E.clone_c(E, "mod_attack")
tt.attacks.list[3].animation = "attack"
tt.attacks.list[3].mod = "mod_pixie_polymorph"
tt.attacks.list[3].vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[3].vis_flags = bor(F_RANGED, F_STUN, F_POLYMORPH)
tt.attacks.list[3].chance = 0.1
tt.attacks.list[4] = E.clone_c(E, "mod_attack")
tt.attacks.list[4].animation = "harvester"
tt.attacks.list[4].mod = "mod_pixie_pickpocket"
tt.attacks.list[4].vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[4].vis_flags = bor(F_RANGED, F_STUN)
tt.attacks.list[4].chance = 0.9
tt.attacks.list[4].check_gold_bag = true
tt.attacks.list[5] = E.clone_c(E, "mod_attack")
tt.attacks.list[5].animation = "attack"
tt.attacks.list[5].mod = "mod_pixie_teleport"
tt.attacks.list[5].vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[5].vis_flags = bor(F_RANGED, F_STUN, F_TELEPORT)
tt.attacks.list[5].chance = 0
tt.attacks.hide_range = true
tt.attacks.range = 190
tt.attacks.cooldown = fts(10)
tt.attacks.enemy_cooldown = 3
tt.attacks.pixie_cooldown = 5
tt.attacks.excluded_templates = {
	"enemy_rabbit"
}
tt.info.i18n_key = "ELVES_TOWER_PIXIE"
tt.info.fn = scripts2.tower_pixie.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers_") or "info_portraits_towers_") .. "0017"
tt.main_script.update = scripts2.tower_pixie.update
tt.powers.cream = E.clone_c(E, "power")
tt.powers.cream.price_base = 200
tt.powers.cream.price_inc = 200
tt.powers.cream.max_level = 2
tt.powers.cream.idle_offsets = {
	v(-18, -1),
	v(21, -3),
	v(5, -9)
}
tt.powers.total = E.clone_c(E, "power")
tt.powers.total.price_base = 200
tt.powers.total.price_inc = 200
tt.powers.total.max_level = 3
tt.powers.total.chances = {
	{
		0,
		0,
		0.1
	},
	{
		0.2,
		0.1,
		0.2
	},
	{
		0.1,
		0.1,
		0.1
	},
	{
		0.7,
		0.6,
		0.5
	},
	{
		0,
		0.2,
		0.1
	}
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_0002"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "pixie_tower"
tt.render.sprites[2].offset = v(0, 15)
tt.render.sprites[2].sort_y_offset = 15
tt.sound_events.insert = nil
tt.tower.menu_offset = v(0, 6)
tt.tower.price = 230
tt.tower.type = "pixie"
tt = E.register_t(E, "decal_pixie", "decal_scripted")

E.add_comps(E, tt, "idle_flip", "soldier", "unit")

tt.idle_flip.animations = {
	"idle",
	"scratch"
}
tt.idle_flip.cooldown = fts(90)
tt.idle_flip.loop = false
tt.main_script.update = scripts2.decal_pixie.update
tt.render.sprites[1].prefix = "decal_pixie"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = 0.09090909090909091
tt.soldier.melee_slot_offset = v(0, 0)
tt.attack_ts = 0
tt.target_id = nil
tt.attack = nil
tt.attack_level = nil
tt = E.register_t(E, "ray_neptune", "bullet")
tt.image_width = 358
tt.main_script.update = scripts3.ray_neptune.update
tt.render.sprites[1].name = "ray_neptune"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min_levels = {
	300,
	600,
	950
}
tt.bullet.damage_max_levels = {
	400,
	800,
	1150
}
tt.bullet.damage_radius = 65
tt.bullet.damage_rect = r(-40, -2, 80, 50)
tt.bullet.hit_fx = "fx_ray_neptune_explosion"
tt.sound_events.insert = "PolymorphSound"
tt = E.register_t(E, "fx_ray_neptune_explosion", "decal_timed")
tt.render.sprites[1].name = "ray_neptune_explosion"
tt.render.sprites[1].anchor.y = 0.24444444444444444
tt.render.sprites[1].z = Z_BULLETS
tt = E.register_t(E, "tower_neptune_holder")

E.add_comps(E, tt, "tower", "tower_holder", "pos", "render", "ui", "info")

tt.tower.level = 1
tt.tower.type = "holder_neptune"
tt.tower.can_be_mod = false
tt.info.fn = scripts3.tower_neptune_holder.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers") or "info_portraits_towers") .. "_0013"
tt.render.sprites[1].name = "neptuno_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 3)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "neptuno_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 39)
tt.ui.click_rect = r(-40, -10, 80, 90)
tt = E.register_t(E, "tower_neptune", "tower")

E.add_comps(E, tt, "powers", "user_selection", "attacks")

tt.tower.level = 1
tt.tower.type = "neptune"
tt.tower.price = 500
tt.tower.can_be_mod = false
tt.tower.terrain_style = nil
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0021"
tt.info.fn = scripts3.tower_neptune.get_info
tt.ui.click_rect = r(-40, -10, 80, 90)
tt.powers.ray = E.clone_c(E, "power")
tt.powers.ray.level = 1
tt.powers.ray.max_level = 3
tt.powers.ray.price_inc = 500
tt.main_script.insert = scripts3.tower_neptune.insert
tt.main_script.update = scripts3.tower_neptune.update
tt.render.sprites[1].name = "neptuno_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 3)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "towerneptune_trident_glow"
tt.render.sprites[2].offset = v(0, 39)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "neptuno_0002"
tt.render.sprites[3].animated = false
tt.render.sprites[3].offset = v(0, 39)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "towerneptune"
tt.render.sprites[4].name = "charged"
tt.render.sprites[4].offset = v(0, 39)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].prefix = "towerneptune_gems_3"
tt.render.sprites[5].name = "ready"
tt.render.sprites[5].offset = v(0, 39)
tt.render.sprites[5].fps = 15
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].prefix = "towerneptune_gems_1"
tt.render.sprites[6].name = "empty"
tt.render.sprites[6].offset = v(0, 39)
tt.render.sprites[6].fps = 15
tt.render.sprites[6].hidden = true
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].prefix = "towerneptune_gems_2"
tt.render.sprites[7].name = "empty"
tt.render.sprites[7].offset = v(0, 39)
tt.render.sprites[7].fps = 15
tt.render.sprites[7].hidden = true
tt.render.sprites[8] = E.clone_c(E, "sprite")
tt.render.sprites[8].prefix = "towerneptune_gems_eyes"
tt.render.sprites[8].name = "empty"
tt.render.sprites[8].offset = v(0, 39)
tt.render.sprites[8].loop = false
tt.render.sprites[9] = E.clone_c(E, "sprite")
tt.render.sprites[9].prefix = "towerneptune_gems_trident"
tt.render.sprites[9].name = "empty"
tt.render.sprites[9].offset = v(0, 39)
tt.render.sprites[9].loop = false
tt.render.sprites[10] = E.clone_c(E, "sprite")
tt.render.sprites[10].prefix = "towerneptune_tip_glow"
tt.render.sprites[10].name = "pick"
tt.render.sprites[10].offset = v(17, 105)
tt.render.sprites[10].hidden = true
tt.sound_events.insert = "GUITowerBuilding"
tt.sound_events.mute_on_level_insert = true
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "ray_neptune"
tt.attacks.list[1].cooldown = 30
tt.attacks.list[1].bullet_start_offset = v(17, 105)

tt = E.register_t(E, "tower_templar", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "1235"
tt.info.enc_icon = 19
tt.tower.type = "templar"
tt.tower.price = 230
tt.powers.holygrail = E.clone_c(E, "power")
tt.powers.holygrail.price_base = 300
tt.powers.holygrail.price_inc = 100
tt.powers.holygrail.name = "HOLY"
tt.powers.holygrail.enc_icon = 25
tt.powers.extralife = E.clone_c(E, "power")
tt.powers.extralife.price_base = 150
tt.powers.extralife.price_inc = 150
tt.powers.extralife.name = "TOUGHNESS"
tt.powers.extralife.enc_icon = 27
tt.powers.blood = E.clone_c(E, "power")
tt.powers.blood.price_base = 150
tt.powers.blood.price_inc = 100
tt.powers.blood.name = "ARTERIAL"
tt.powers.blood.enc_icon = 26
tt.barrack.soldier_type = "soldier_templar"
tt.barrack.rally_range = 147.20000000000002
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "tower_templars_layer1_0001"
tt.render.sprites[2].offset = v(0, 34)
tt.render.sprites[3].prefix = "towertemplar_door"
tt.render.sprites[3].offset = v(0, 34)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "towertemplar_fire"
tt.render.sprites[4].offset = v(-17, 19)
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].prefix = "towertemplar_fire"
tt.render.sprites[5].offset = v(18, 19)
tt.render.sprites[5].ts = 0.08
tt.sound_events.insert = "TemplarTauntReady"
tt.sound_events.change_rally_point = "TemplarTaunt"
tt = E.register_t(E, "soldier_templar", "soldier_militia")

E.add_comps(E, tt, "revive", "powers")

anchor_y = 0.19
image_y = 42
tt.health.armor = 0.4
tt.health.dead_lifetime = 15
tt.health.hp_inc = 75
tt.health.hp_max = 250
tt.health.power_name = "extralife"
tt.health_bar.offset = v(0, ady(40))
tt.idle_flip.animations = {
  "idle",
  "idle2"
}
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0004") or "info_portraits_soldiers_1345"
tt.info.random_name_count = 20
tt.info.random_name_format = "SOLDIER_TEMPLAR_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 45
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "blood"
tt.melee.attacks[2].chance = 0.2
tt.melee.attacks[2].damage_max = 40
tt.melee.attacks[2].damage_min = 40
tt.melee.attacks[2].damage_inc = 20
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(20)
tt.melee.attacks[2].mod = "mod_blood"
tt.melee.attacks[2].pop = nil
tt.melee.attacks[2].power_name = "blood"
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].sound_hit = "TemplarArterial"
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = bor(F_BLOCK, F_BLOOD)
tt.melee.arrived_slot_animation = "attack_wait"
tt.melee.cooldown = fts(13) + 1.5
tt.melee.range = 64
tt.motion.max_speed = 75
tt.powers.blood = E.clone_c(E, "power")
tt.powers.extralife = E.clone_c(E, "power")
tt.powers.holygrail = E.clone_c(E, "power")
tt.regen.health = 50
tt.render.sprites[1].prefix = "soldiertemplar"
tt.render.sprites[1].anchor.y = anchor_y
tt.revive.animation = "holygrail"
tt.revive.chance = 0.1
tt.revive.chance_inc = 0.15
tt.revive.health_recover = 0.05
tt.revive.health_recover_inc = 0
tt.revive.hit_time = fts(10)
tt.revive.power_name = "holygrail"
tt.revive.sound = "TemplarHolygrail"
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(7))
tt.unit.mod_offset = v(0, ady(23))
tt = E.register_t(E, "tower_assassin", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0666"
tt.info.enc_icon = 20
tt.tower.type = "assassin"
tt.tower.price = 230
tt.powers.sneak = E.clone_c(E, "power")
tt.powers.sneak.price_base = 150
tt.powers.sneak.price_inc = 100
tt.powers.sneak.enc_icon = 24
tt.powers.pickpocket = E.clone_c(E, "power")
tt.powers.pickpocket.price_base = 100
tt.powers.pickpocket.price_inc = 100
tt.powers.pickpocket.max_level = 2
tt.powers.pickpocket.name = "PICK"
tt.powers.pickpocket.enc_icon = 22
tt.powers.counter = E.clone_c(E, "power")
tt.powers.counter.price_base = 150
tt.powers.counter.price_inc = 100
tt.powers.counter.enc_icon = 23
tt.barrack.soldier_type = "soldier_assassin"
tt.barrack.rally_range = 147.20000000000002
tt.render.sprites[1].name = "terrain_specials_%04i"
tt.render.sprites[1].offset = v(0, 8)
tt.render.sprites[2].name = "tower_assasins_layer1_0005"
tt.render.sprites[2].offset = v(0, 30)
tt.render.sprites[3].prefix = "towerassassin_door"
tt.render.sprites[3].offset = v(0, 30)
tt.sound_events.insert = "AssassinTauntReady"
tt.sound_events.change_rally_point = "AssassinTaunt"
tt = E.register_t(E, "soldier_assassin", "soldier_militia")

E.add_comps(E, tt, "powers", "dodge", "cloak", "pickpocket")

anchor_y = 0.19
image_y = 42
tt.cloak.alpha = 154
tt.cloak.bans = F_RANGED
tt.dodge.animation = "dodge"
tt.dodge.chance = 0.4
tt.dodge.chance_inc = 0.1
tt.dodge.counter_attack = E.clone_c(E, "melee_attack")
tt.dodge.counter_attack.animation = "counter"
tt.dodge.counter_attack.cooldown = 0
tt.dodge.counter_attack.damage_inc = 10
tt.dodge.counter_attack.damage_max = 14
tt.dodge.counter_attack.damage_min = 10
tt.dodge.counter_attack.hit_time = fts(8)
tt.dodge.counter_attack.power_name = "counter"
tt.dodge.power_name = "counter"
tt.health.armor = 0
tt.health.dead_lifetime = 10
tt.health.hp_max = 200
tt.health_bar.offset = v(0, 32.86)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0005") or "info_portraits_soldiers_0005"
tt.info.random_name_count = 20
tt.info.random_name_format = "SOLDIER_ASSASSIN_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = fts(13) + 0.6
tt.melee.attacks[1].damage_max = 14
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "sneak"
tt.melee.attacks[2].chance = 0.15
tt.melee.attacks[2].chance_inc = 0.05
tt.melee.attacks[2].cooldown = fts(24) + 0.6
tt.melee.attacks[2].damage_inc = 75
tt.melee.attacks[2].damage_max = 75
tt.melee.attacks[2].damage_min = 25
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].pop = nil
tt.melee.attacks[2].power_name = "sneak"
tt.melee.attacks[2].forced_cooldown = true
tt.melee.attacks[2].sound_hit = "AssassinSneakAttack"
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.attacks[3] = E.clone_c(E, "melee_attack")
tt.melee.attacks[3].animation = "sneak"
tt.melee.attacks[3].chance = 0
tt.melee.attacks[3].chance_inc = 0
tt.melee.attacks[3].cooldown = fts(24) + 0.6
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_time = fts(15)
tt.melee.attacks[3].instakill = true
tt.melee.attacks[3].pop = {
  "pop_instakill"
}
tt.melee.attacks[3].power_name = "sneak"
tt.melee.attacks[3].forced_cooldown = true
tt.melee.attacks[3].sound_hit = "AssassinSneakAttack"
tt.melee.attacks[3].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 64
tt.motion.max_speed = 75
tt.pickpocket.chance = 0
tt.pickpocket.chance_inc = 0.3
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.power_name = "pickpocket"
tt.pickpocket.sound = "AssassinGold"
tt.pickpocket.steal_max = 5
tt.pickpocket.steal_min = 3
tt.powers.counter = E.clone_c(E, "power")
tt.powers.pickpocket = E.clone_c(E, "power")
tt.powers.sneak = E.clone_c(E, "power")
tt.regen.health = 40
tt.render.sprites[1].prefix = "soldierassassin"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))
tt = E.register_t(E, "tower_barrack_pirates", "tower")

E.add_comps(E, tt, "barrack")

tt.tower.type = "mercenaries_pirates"
tt.tower.level = 1
tt.tower.can_be_mod = false
tt.info.fn = scripts3.tower_barrack_mercenaries.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0014"
tt.main_script.update = scripts3.tower_barrack_mercenaries.update
tt.main_script.remove = scripts3.tower_barrack.remove
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "tower_merc_camp_pirates"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 35)
tt.barrack.soldier_type = "soldier_pirate_captain"
tt.barrack.rally_range = 145.28
tt.barrack.respawn_offset = v(0, 0)
tt = E.register_t(E, "tower_barrack_pirates_w_flamer", "tower_barrack_pirates")
tt.tower.price = 175
tt.tower.type = "mercenaries_pirates_w_flamer"
tt = E.register_t(E, "tower_barrack_pirates_w_anchor", "tower_barrack_pirates")
tt.tower.type = "mercenaries_pirates_w_anchor"
tt = E.register_t(E, "tower_barrack_amazonas", "tower_barrack_pirates")
tt.tower.price = 175
tt.tower.type = "mercenaries_amazonas"
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0015"
tt.render.sprites[2].prefix = "tower_merc_camp_amazonas"
tt.barrack.soldier_type = "soldier_amazona"
tt.sound_events.change_rally_point = "AmazonTaunt"
tt = E.register_t(E, "tower_barrack_mercenaries", "tower_barrack_pirates")
tt.tower.price = 175
tt.tower.type = "mercenaries_desert"
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0013"
tt.render.sprites[2].prefix = "tower_merc_camp_desert"
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "tower_merc_camp_desert_fire"
tt.render.sprites[3].offset = v(-23, 15)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "tower_merc_camp_desert_fire"
tt.render.sprites[4].offset = v(23, 15)
tt.render.sprites[4].ts = 0.08
tt.barrack.soldier_type = "soldier_legionnaire"
tt.barrack.rally_range = 145.28
tt.barrack.respawn_offset = v(0, 0)
tt = E.register_t(E, "soldier_legionnaire", "soldier_militia")
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 250
tt.info.fn = scripts3.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0022") or "info_portraits_soldiers_0022"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_LEGIONNAIRE_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.range = 64
tt.regen.cooldown = 0.5
tt.regen.health = 25
tt.render.sprites[1].prefix = "soldierlegionnaire"
tt.unit.price = 75
tt.vis.bans = bor(tt.vis.bans)
tt.sound_events.insert = "LegionnaireTaunt"
tt.sound_events.change_rally_point = "LegionnaireTaunt"
tt = E.register_t(E, "soldier_djinn", "soldier_militia")
anchor_y = 0.14
image_y = 54

E.add_comps(E, tt, "timed_attacks")

tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 350
tt.health_bar.offset = v(0, ady(58))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts3.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0023") or "info_portraits_soldiers_0023"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_DJINN_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.range = 64
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 0.5
tt.regen.health = 20
tt.render.sprites[1].prefix = "soldierdjinn"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(10, 0)
tt.timed_attacks.list[1] = E.clone_c(E, "spell_attack")
tt.timed_attacks.list[1].spell = "spell_djinn"
tt.timed_attacks.list[1].max_range = 145.28
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].vis_flags = F_POLYMORPH
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_BOSS)
tt.timed_attacks.list[1].cast_time = fts(9)
tt.unit.hide_after_death = true
tt.unit.marker_offset = v(0, ady(4))
tt.unit.mod_offset = v(0, 30)
tt.unit.price = 350
tt.vis.bans = bor(tt.vis.bans)
tt.sound_events.insert = "GenieTaunt"
tt.sound_events.change_rally_point = "GenieTaunt"
tt = E.register_t(E, "spell_djinn", "spell")
tt.main_script.insert = scripts3.spell_djinn.insert
tt.fx_options = {
	"fx_djinn_frog",
	"fx_djinn_chest",
	"fx_djinn_harp"
}
tt = E.register_t(E, "fx_djinn_frog", "fx")
tt.render.sprites[1].name = "fx_djinn_frog"
tt.render.sprites[1].anchor.y = 0.16
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "fx_djinn_chest", "decal_timed")
tt.render.sprites[1].name = "soldier_djinn_polyshapes_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.16
tt.timed.duration = 4
tt = E.register_t(E, "fx_djinn_harp", "decal_timed")
tt.render.sprites[1].name = "soldier_djinn_polyshapes_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.16
tt.timed.duration = 4
tt = E.register_t(E, "tower_archer_hammerhold", "tower")

E.add_comps(E, tt, "attacks")

tt.tower.type = "archer_hammerhold"
tt.tower.level = 1
tt.tower.price = 200
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0019"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 12)
tt.render.sprites[1].hidden = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "city_tower"
tt.render.sprites[2].offset = v(0, 28)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "shooterarcherhammerhold"
tt.render.sprites[3].name = "idleDown"
tt.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tt.render.sprites[3].offset = v(0, 59)
tt.main_script.insert = scripts3.tower_archer.insert
tt.main_script.update = scripts3.tower_archer.update
tt.main_script.remove = scripts3.tower_archer.remove
tt.attacks.range = 225
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "arrow_hammerhold"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 50)
}
tt = E.register_t(E, "arrow_hammerhold", "arrow")
tt.bullet.damage_min = 50
tt.bullet.damage_max = 50
tt = E.register_t(E, "soldier_amazona", "soldier_militia")

E.add_comps(E, tt, "track_kills", "auras")

anchor_y = 0.35
image_y = 70
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 300
tt.health_bar.offset = v(0, ady(56))
tt.info.fn = scripts3.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0026") or "info_portraits_soldiers_0027"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_AMAZONAS_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 36
tt.melee.attacks[1].damage_min = 14
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "attack_2"
tt.melee.attacks[2].chance = 0.3
tt.melee.attacks[2].damage_max = 36
tt.melee.attacks[2].damage_min = 14
tt.melee.attacks[2].damage_radius = 51.2
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[2].hit_time = fts(8)
tt.melee.attacks[2].damage_bans = bor(F_FLYING, F_FRIEND, F_HERO)
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].not_first = true
tt.melee.attacks[2].signal = "whirlwind"
tt.melee.cooldown = 1
tt.melee.range = 64
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 0.5
tt.regen.health = 30
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "soldier_amazona"
tt.sound_events.insert = "AmazonTaunt"
tt.sound_events.change_rally_point = "AmazonTaunt"
tt.track_kills.mod = "amazona_heal_mod"
tt.unit.marker_offset = v(0, ady(23))
tt.unit.mod_offset = v(0, 17)
tt.unit.price = 75
tt = E.register_t(E, "amazona_heal_mod", "modifier")

E.add_comps(E, tt, "render", "heal_on_kill")

tt.main_script.insert = scripts3.mod_heal_on_kill.insert
tt.main_script.update = scripts3.mod_heal_on_kill.update
tt.heal_on_kill.hp = 50
tt = E.register_t(E, "soldier_pirate_captain", "soldier_militia")

E.add_comps(E, tt, "pickpocket")

anchor_y = 0.21
image_y = 36
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 250
tt.health_bar.offset = v(0, ady(37))
tt.info.fn = scripts3.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0024") or "info_portraits_soldiers_0024"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_PIRATES_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.range = 64
tt.motion.max_speed = FPS*2.5
tt.pickpocket.chance = 0.3
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.steal_max = 6
tt.pickpocket.steal_min = 2
tt.regen.cooldown = 0.5
tt.regen.health = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "soldier_pirate_captain"
tt.sound_events.insert = "PiratesTaunt"
tt.sound_events.change_rally_point = "PiratesTaunt"
tt.unit.mod_offset = v(0, 18)
tt.unit.price = 75
tt = E.register_t(E, "soldier_pirate_flamer", "soldier_militia")

E.add_comps(E, tt, "ranged")

anchor_y = 0.16
image_y = 36
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 125
tt.health_bar.offset = v(0, ady(32))
tt.info.fn = scripts3.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0025") or "info_portraits_soldiers_0025"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_PIRATES_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 15
tt.melee.range = 64
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 0.5
tt.regen.health = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "soldier_pirate_flamer"
tt.unit.marker_offset = v(0, ady(5))
tt.unit.mod_offset = v(0, 16)
tt.unit.price = 150
tt.ranged.attacks[1].bullet = "bomb_molotov"
tt.ranged.attacks[1].shoot_time = fts(5)
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.ranged.attacks[1].max_range = 166.4
tt.ranged.attacks[1].min_range = 25.6
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 15)
}
tt.ranged.attacks[1].shot_sound = "AxeSound"
tt.ranged.attacks[1].vis_bans = F_FLYING
tt.ranged.attacks[1].node_prediction = fts(23)
tt.ranged.attacks[1].ignore_hit_offset = true
tt.sound_events.insert = "PiratesTaunt"
tt.sound_events.change_rally_point = "PiratesTaunt"
tt = E.register_t(E, "bomb_molotov", "bomb")
tt.render.sprites[1].name = "proy_molotov"
tt.bullet.flight_time = fts(18)
tt.bullet.damage_min = 10
tt.bullet.damage_max = 30
tt.bullet.damage_radius = 48
tt.bullet.hit_fx = "fx_explosion_molotov"
tt.sound_events.insert = "AxeSound"
tt = E.register_t(E, "fx_explosion_molotov", "fx")
tt.render.sprites[1].name = "explosion_molotov"
tt.render.sprites[1].anchor.y = 0.18
tt = E.register_t(E, "soldier_pirate_anchor", "soldier_militia")
anchor_y = 0.2037037037037037
image_y = 108
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 600
tt.health_bar.offset = v(0, 52)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts3.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0079") or "info_portraits_soldiers_0026"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_PIRATES_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 110
tt.melee.attacks[1].damage_min = 90
tt.melee.attacks[1].cooldown = 2
tt.melee.range = 64
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 1
tt.regen.health = 90
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "soldier_pirate_anchor"
tt.ui.click_rect = r(-20, -12, 40, 60)
tt.unit.marker_offset = v(0, -1)
tt.unit.mod_offset = v(0, 16)
tt.unit.price = 130
tt.unit.size = UNIT_SIZE_MEDIUM
tt.sound_events.insert = "PirateBigTaunt"
tt.sound_events.change_rally_point = "PirateBigTaunt"
tt = RT("tower_ewok_rework", "tower_barrack_1")

tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0008") or "info_portraits_towers_0012"
tt.info.enc_icon = 18
tt.info.i18n_key = "ELVES_EWOK_TOWER_RE"
tt.barrack.max_soldiers = 5
tt.tower.type = "ewok_re"
tt.tower.price = 230
tt.barrack.soldier_type = "soldier_ewok_re"
tt.barrack.rally_range = 160
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrains_0001"
tt.render.sprites[1].offset = v(0, 10)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "ewok_hut_0002"
tt.render.sprites[2].offset = v(0, 32)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 32)
tt.render.sprites[3].prefix = "tower_ewok_door"
tt.render.door_sid = 3
tt.sound_events.change_rally_point = "ElvesEwokTaunt"
tt = E.register_t(E, "soldier_ewok_re", "soldier_militia")

E.add_comps(E, tt, "dodge", "ranged")

image_y = 36
anchor_y = image_y/200
tt.dodge.animation_end = "shield_end"
tt.dodge.animation_hit = "shield_hit"
tt.dodge.animation_start = "shield_start"
tt.dodge.can_dodge = function (store, this)
	this.dodge.last_hit_ts = store.tick_ts

	return this.health.hp <= this.health.hp_max*0.5
end
tt.dodge.chance = 1
tt.dodge.cooldown = 20
tt.dodge.duration = 4
tt.dodge.ranged = true
tt.dodge.time_before_hit = 0
tt.health.armor = 0
tt.health.dead_lifetime = 3
tt.health.hp_max = 100
tt.health.dead_lifetime = 10
tt.health_bar.offset = v(0, 29)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.info.portrait = "portraits_sc_0060"
tt.info.random_name_count = 6
tt.info.random_name_format = "ELVES_SOLDIER_EWOK_%i_NAME"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 7
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].pop = {
	"pop_ewoks"
}
tt.melee.attacks[1].pop_chance = 0.1
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 50
tt.motion.max_speed = 75
tt.ranged.attacks[1].bullet = "bullet_soldier_ewok"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 10)
}
tt.ranged.attacks[1].cooldown = 1.3
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = fts(11)
tt.regen.cooldown = 0.5
tt.regen.health = 15
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldier_ewok"
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.insert = "ElvesEwokTaunt"
tt.ui.click_rect = r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt = E.register_t(E, "tower_barrack_amazonas_re", "tower_barrack_1")
tt.tower.price = 200
tt.tower.type = "mercenaries_amazonas_re"
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0015"
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 2)
tt.render.sprites[2].name = "tower_merc_camp_amazonas"
tt.render.sprites[2].offset = v(0, 20)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 20)
tt.render.sprites[3].prefix = "tower_merc_camp_amazonas"
tt.render.door_sid = 3
tt.barrack.soldier_type = "soldier_amazona_re"
tt.sound_events.change_rally_point = "AmazonTaunt"
tt = E.register_t(E, "soldier_amazona_re", "soldier_militia")

E.add_comps(E, tt, "track_kills", "auras")

anchor_y = 0.35
image_y = 70
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 300
tt.health.dead_lifetime = 10
tt.health_bar.offset = v(0, ady(56))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0026") or "info_portraits_soldiers_0027"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_AMAZONAS_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 36
tt.melee.attacks[1].damage_min = 24
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "attack_2"
tt.melee.attacks[2].chance = 0.3
tt.melee.attacks[2].damage_max = 36
tt.melee.attacks[2].damage_min = 24
tt.melee.attacks[2].damage_radius = 51.2
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[2].hit_time = fts(8)
tt.melee.attacks[2].damage_bans = bor(F_FLYING, F_FRIEND, F_HERO)
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].not_first = true
tt.melee.attacks[2].signal = "whirlwind"
tt.melee.cooldown = 1
tt.melee.range = 64
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 0.5
tt.regen.health = 30
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "soldier_amazona"
tt.sound_events.change_rally_point = "AmazonTaunt"
tt.track_kills.mod = "amazona_heal_mod"
tt.unit.marker_offset = v(0, ady(23))
tt.unit.mod_offset = v(0, 17)
tt.unit.price = 75
tt = RT("tower_elf_kr1", "tower_barrack_1")

AC(tt, "powers")

tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0008") or "info_portraits_towers_0012"
tt.info.enc_icon = 18
tt.info.i18n_key = "TOWER_ELF_KR1"
tt.barrack.max_soldiers = 4
tt.tower.type = "elf_kr1"
tt.tower.price = 270
tt.powers.throwing = E.clone_c(E, "power")
tt.powers.throwing.price_base = 150
tt.powers.throwing.price_inc = 150
tt.powers.throwing.enc_icon = 14
tt.powers.throwing.name = "THROWING_AXES"
tt.powers.dual = E.clone_c(E, "power")
tt.powers.dual.price_base = 200
tt.powers.dual.price_inc = 200
tt.powers.dual.enc_icon = 12
tt.powers.dual.name = "DOUBLE_AXE"
tt.powers.armor = E.clone_c(E, "power")
tt.powers.armor.max_level = 2
tt.powers.armor.price_base = 200
tt.powers.armor.price_inc = 200
tt.barrack.soldier_type = "soldier_elf_kr1"
tt.barrack.rally_range = 160
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 2)
tt.render.sprites[2].name = "Tower_elf_kr1_layer1_0001"
tt.render.sprites[2].offset = v(0, 20)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 20)
tt.render.sprites[3].prefix = "Tower_elf_kr1_door"
tt.render.door_sid = 3
tt.sound_events.insert = "ElfTaunt"
tt.sound_events.change_rally_point = "ElfTaunt"
tt = RT("soldier_elf_kr1", "soldier_militia")

E.add_comps(E, tt, "powers", "ranged")

anchor_y = 0.3
image_y = 62
tt.health.armor = 0
tt.health.immune_to = DAMAGE_MAGICAL
tt.health.armor_inc = 0.25
tt.health.armor_power_name = "armor"
tt.health.dead_lifetime = 10
tt.health.hp_max = 75
tt.health_bar.offset = v(0, ady(48))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0044") or "info_portraits_sc_0044"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_ELVES_RANDOM_%i_NAME"
tt.motion.max_speed = 95
tt.powers.dual = E.clone_c(E, "power")
tt.powers.armor = E.clone_c(E, "power")
tt.powers.throwing = E.clone_c(E, "power")
tt.ranged.attacks[1].bullet = "arrow_elf"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 12)
}
tt.ranged.attacks[1].cooldown = fts(14) + 3
tt.ranged.attacks[1].disabled = false
tt.ranged.attacks[1].level = 0
tt.ranged.attacks[1].max_range = 205
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].power_name = "throwing"
tt.ranged.attacks[1].range_inc = 15
tt.ranged.attacks[1].shoot_time = fts(7)
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.regen.health = 10
tt.render.sprites[1].prefix = "soldier_elf_kr1"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(5, 0)
tt.melee.cooldown = fts(11) + 1
tt.melee.range = 60
tt.melee.attacks[1].damage_inc = 5
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].power_name = "dual"
tt.ranged.range_while_blocking = false
tt.ranged.go_back_during_cooldown = true
tt.ranged.attacks[1].bullet = "arrow_elf"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 16)
}
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.ranged.attacks[1].max_range = 205
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(7)
tt = RT("tower_elf_holder")

AC(tt, "tower", "tower_holder", "pos", "render", "ui", "info", "editor", "editor_script")

tt.tower.type = "holder_elf"
tt.tower.level = 1
tt.tower.can_be_mod = false
tt.info.i18n_key = "SPECIAL_ELF"
tt.info.fn = scripts.tower_elf_holder.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers") or "info_portraits_towers") .. "_0013"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 2)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "elfTower_layer1_0026"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 20)
tt.ui.click_rect = r(-40, -10, 80, 90)
tt.ui.has_nav_mesh = true
tt.editor.props = {
	{
		"tower.terrain_style",
		PT_NUMBER
	},
	{
		"tower.default_rally_pos",
		PT_COORDS
	},
	{
		"tower.holder_id",
		PT_STRING
	},
	{
		"ui.nav_mesh_id",
		PT_STRING
	},
	{
		"editor.game_mode",
		PT_NUMBER
	}
}
tt.editor_script.insert = scripts.editor_tower.insert
tt.editor_script.remove = scripts.editor_tower.remove
tt = RT("tower_elf", "tower")

AC(tt, "barrack")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers") or "info_portraits_towers") .. "_0013"
tt.barrack.max_soldiers = 4
tt.barrack.rally_range = 145
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "soldier_elf"
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)
tt.info.i18n_key = "SPECIAL_ELF"
tt.info.fn = scripts.tower_elf_holder.get_info
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.remove = scripts.tower_barrack.remove
tt.main_script.update = scripts.tower_barrack_mercenaries.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_barrack_%04i"
tt.render.sprites[1].offset = v(0, 2)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "elfTower_layer1_0001"
tt.render.sprites[2].offset = v(0, 20)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "close"
tt.render.sprites[3].offset = v(0, 20)
tt.render.sprites[3].prefix = "tower_elf_door"
tt.render.door_sid = 3
tt.sound_events.change_rally_point = "ElfTaunt"
tt.sound_events.insert = "GUITowerBuilding"
tt.sound_events.mute_on_level_insert = true
tt.tower.can_be_mod = false
tt.tower.level = 1
tt.tower.price = 100
tt.tower.terrain_style = nil
tt.tower.type = "elf"
tt.ui.click_rect = r(-40, -10, 80, 90)
tt = E.register_t(E, "ps_emit_breath_baby_ashbite")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "baby_ashbite_breath_particle"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.source_lifetime = fts(20)
tt = E.register_t(E, "ps_emit_fiery_mist_baby_ashbite")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "baby_ashbite_fierymist_particle"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.source_lifetime = fts(20)
tt = E.register_t(E, "tower_holder_baby_ashbite", "tower")

E.add_comps(E, tt, "tower", "tower_holder", "pos", "render", "ui", "info", "tween")

tt.tower.level = 1
tt.tower.type = "holder_baby_ashbite"
tt.tower.can_be_mod = false
tt.info.fn = scripts2.tower_baby_ashbite.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers_") or "info_portraits_towers_") .. "0119"
tt.info.i18n_key = "ELVES_BABY_ASHBITE_TOWER"
tt.info.damage_icon = "fireball"
tt.render.sprites[1].name = "babyAshbite_tower_layer1_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 26)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "babyAshbite_tower_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 26)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "babyAshbite_tower_layer2_0001"
tt.render.sprites[3].animated = false
tt.render.sprites[3].offset = v(0, 26)
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "babyAshbite_tower_layer2_0004"
tt.render.sprites[4].animated = false
tt.render.sprites[4].offset = v(0, 26)
tt.ui.click_rect = r(-40, -10, 80, 90)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		2,
		255
	},
	{
		2.5,
		255
	},
	{
		4.5,
		0
	}
}
tt.tween.props[1].sprite_id = 4
tt.tween.props[1].loop = true
tt = E.register_t(E, "tower_baby_ashbite", "tower")

E.add_comps(E, tt, "barrack", "powers")

tt.tower.can_be_mod = false
tt.tower.hide_dust = true
tt.tower.type = "baby_ashbite"
tt.tower.level = 1
tt.tower.price = 650
tt.info.fn = scripts2.tower_baby_ashbite.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers_") or "info_portraits_towers_") .. "0119"
tt.info.i18n_key = "ELVES_BABY_ASHBITE_TOWER"
tt.info.damage_icon = "fireball"
tt.render.sprites[1].name = "babyAshbite_tower_layer1_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 26)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "babyAshbite_tower_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(0, 26)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "babyAshbite_tower_layer2_0005"
tt.render.sprites[3].animated = false
tt.render.sprites[3].offset = v(0, 26)
tt.barrack.soldier_type = "soldier_baby_ashbite"
tt.barrack.rally_range = 350
tt.barrack.rally_anywhere = true
tt.barrack.respawn_offset = v(-4, 26)
tt.barrack.max_soldiers = 1
tt.main_script.insert = scripts2.tower_barrack.insert
tt.main_script.update = scripts2.tower_baby_ashbite.update
tt.main_script.remove = scripts2.tower_barrack.remove
tt.sound_events.insert = "ElvesAshbiteDeath"
tt.sound_events.change_rally_point = "ElvesAshbiteConfirm"
tt.powers.blazing_breath = E.clone_c(E, "power")
tt.powers.blazing_breath.price_base = 300
tt.powers.blazing_breath.price_inc = 200
tt.powers.blazing_breath.max_level = 3
tt.powers.fiery_mist = E.clone_c(E, "power")
tt.powers.fiery_mist.price_base = 350
tt.powers.fiery_mist.price_inc = 150
tt.powers.fiery_mist.max_level = 1
tt = E.register_t(E, "soldier_baby_ashbite", "soldier")

E.add_comps(E, tt, "ranged", "powers")

tt.health.armor = 0
tt.health.dead_lifetime = 25
tt.health.hp_max = 550
tt.health.ignore_delete_after = true
tt.health_bar.offset = v(0, 120)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 1
tt.info.fn = scripts2.soldier_baby_ashbite.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0114"
tt.info.i18n_key = "ELVES_BABY_ASHBITE"
tt.info.damage_icon = "fireball"
tt.main_script.insert = scripts2.soldier_baby_ashbite.insert
tt.main_script.update = scripts2.soldier_baby_ashbite.update
tt.motion.max_speed = 90
tt.regen.cooldown = 1
tt.regen.health = 30
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = 0.0625
tt.render.sprites[1].angles = {
	walk = {
		"idle"
	}
}
tt.render.sprites[1].prefix = "babyAshbite"
tt.render.sprites[1].sync_idx = 8
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "babyAshbite_0099"
tt.render.sprites[2].anchor.y = 0.0625
tt.soldier.melee_slot_offset = v(0, 0)
tt.ui.click_rect = r(-40, 70, 80, 30)
tt.unit.hit_offset = v(0, 84)
tt.unit.hide_after_death = false
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, ady(25))
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_POISON, F_POLYMORPH)
tt.vis.flags = bor(tt.vis.flags, F_HERO, F_FLYING)
tt.powers.blazing_breath = E.clone_c(E, "power")
tt.powers.fiery_mist = E.clone_c(E, "power")
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].bullet = "fireball_baby_ashbite"
tt.ranged.attacks[1].bullet_start_offset = {
	v(28, 70)
}
tt.ranged.attacks[1].cooldown = fts(12) + 1.1
tt.ranged.attacks[1].min_range = 30
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].sound_shoot = "ElvesAshbiteSpit"
tt.ranged.attacks[1].node_prediction = nil
tt.ranged.attacks[2] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[2].level = 0
tt.ranged.attacks[2].power_name = "blazing_breath"
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].bullet = "breath_baby_ashbite"
tt.ranged.attacks[2].bullet_start_offset = {
	v(24, 66)
}
tt.ranged.attacks[2].cooldown = 8
tt.ranged.attacks[2].min_range = 30
tt.ranged.attacks[2].max_range = 150
tt.ranged.attacks[2].shoot_time = fts(9)
tt.ranged.attacks[2].sync_animation = true
tt.ranged.attacks[2].animation = "special"
tt.ranged.attacks[2].sound = "ElvesAshbiteFlameThrower"
tt.ranged.attacks[2].vis_bans = F_FLYING
tt.ranged.attacks[3] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[3].level = 0
tt.ranged.attacks[3].power_name = "fiery_mist"
tt.ranged.attacks[3].disabled = true
tt.ranged.attacks[3].bullet = "fierymist_baby_ashbite"
tt.ranged.attacks[3].bullet_start_offset = {
	v(24, 66)
}
tt.ranged.attacks[3].cooldown = 10
tt.ranged.attacks[3].min_range = 40
tt.ranged.attacks[3].max_range = 150
tt.ranged.attacks[3].shoot_time = fts(9)
tt.ranged.attacks[3].sync_animation = true
tt.ranged.attacks[3].animation = "special"
tt.ranged.attacks[3].vis_bans = F_FLYING
tt.ranged.attacks[3].sound = "ElvesAshbiteSmoke"
tt = E.register_t(E, "fireball_baby_ashbite", "bullet")
tt.render.sprites[1].name = "fireball_baby_ashbite"
tt.render.sprites[1].z = Z_BULLETS
tt.bullet.damage_min = 62
tt.bullet.damage_max = 87
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_radius = 30
tt.bullet.min_speed = 240
tt.bullet.max_speed = 240
tt.bullet.node_prediction = true
tt.bullet.g = nil
tt.bullet.hit_fx = "fx_fireball_baby_ashbite_hit"
tt.bullet.hit_fx_air = "fx_fireball_baby_ashbite_hit_air"
tt.bullet.vis_flags = F_RANGED
tt.main_script.update = scripts2.fireball.update
tt.sound_events.hit = "ElvesAshbiteFireball"
tt = E.register_t(E, "fx_fireball_baby_ashbite_hit", "fx")
tt.render.sprites[1].name = "fx_fireball_baby_ashbite_hit"
tt.render.sprites[1].anchor.y = 0.24
tt = E.register_t(E, "fx_fireball_baby_ashbite_hit_air", "fx")
tt.render.sprites[1].name = "fx_fireball_baby_ashbite_hit_air"
tt.render.sprites[1].anchor.y = 0.24
tt = E.register_t(E, "breath_baby_ashbite", "bullet")
tt.render = nil
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.min_speed = 240
tt.bullet.max_speed = 240
tt.bullet.g = nil
tt.bullet.vis_flags = F_RANGED
tt.bullet.emit_decal = "decal_emit_breath_baby_ashbite"
tt.bullet.node_prediction = true
tt.bullet.hit_fx = "fx_breath_baby_ashbite_hit"
tt.bullet.hit_decal = "aura_breath_baby_ashbite"
tt.main_script.update = scripts2.fireball.update
tt = E.register_t(E, "decal_emit_breath_baby_ashbite", "decal_scripted")
tt.duration = fts(18)
tt.render.sprites[1].name = "babyAshbite_0158"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.6909090909090909, 0.5416666666666666)
tt.render.sprites[1].z = Z_EFFECTS
tt.emit_ps = "ps_emit_breath_baby_ashbite"
tt.main_script.update = scripts2.decal_emit_breath_baby_ashbite.update
tt.flight_time = nil
tt = E.register_t(E, "fx_breath_baby_ashbite_hit", "fx")
tt.render.sprites[1].name = "baby_ashbite_breath_fire"
tt.render.sprites[1].anchor.y = 0.35714285714285715
tt = E.register_t(E, "aura_breath_baby_ashbite", "aura")

E.add_comps(E, tt, "tween", "render")

tt.main_script.update = scripts2.aura_apply_damage.update
tt.aura.duration = fts(30)
tt.aura.damage_inc = 15
tt.aura.damage_min = 10
tt.aura.damage_max = 10
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.radius = 60
tt.aura.cycle_time = fts(5)
tt.aura.vis_bans = bor(F_FRIEND)
tt.render.sprites[1].name = "baby_ashbite_breath_fire_decal"
tt.render.sprites[1].anchor.y = 0.38095238095238093
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = false
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "babyAshbite_specialFire_decal"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_DECALS
tt.tween.remove = false
tt.tween.props[1].sprite_id = 2
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(20),
		0
	}
}
tt = E.register_t(E, "fierymist_baby_ashbite", "breath_baby_ashbite")
tt.bullet.emit_decal = "decal_emit_fiery_mist_baby_ashbite"
tt.bullet.hit_decal = "aura_fiery_mist_baby_ashbite"
tt.bullet.hit_fx = nil
tt = E.register_t(E, "decal_emit_fiery_mist_baby_ashbite", "decal_emit_breath_baby_ashbite")
tt.duration = fts(18)
tt.render.sprites[1].hidden = true
tt.emit_ps = "ps_emit_fiery_mist_baby_ashbite"
tt = E.register_t(E, "aura_fiery_mist_baby_ashbite", "aura")
tt.main_script.update = scripts2.aura_fiery_mist_baby_ashbite.update
tt.fx = "decal_fiery_mist_baby_ashbite"
tt.aura.duration = 4
tt.aura.mod = "mod_slow_baby_ashbite"
tt.aura.cycle_time = 0.25
tt.aura.damage_inc = (25*tt.aura.cycle_time)/tt.aura.duration
tt.aura.damage_min = (75*tt.aura.cycle_time)/tt.aura.duration
tt.aura.damage_max = (75*tt.aura.cycle_time)/tt.aura.duration
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.radius = 50
tt.aura.vis_bans = bor(F_FRIEND)
tt = E.register_t(E, "mod_slow_baby_ashbite", "mod_slow")
tt.slow.factor = 0.4
tt.slow.factor_inc = 0
tt = E.register_t(E, "decal_fiery_mist_baby_ashbite", "decal_tween")
tt.render.sprites[1].name = "baby_ashbite_fierymist_decal"
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor.y = 0.25
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(6),
		255
	},
	{
		"this.duration-0.2",
		255
	},
	{
		"this.duration",
		0
	}
}
tt = RT("tower_sasquash_holder")

AC(tt, "tower", "tower_holder", "pos", "render", "ui", "info", "editor", "main_script")

tt.tower.type = "holder_sasquash"
tt.tower.level = 1
tt.tower.can_be_mod = false
tt.main_script.update = scripts.tower_sasquash_holder.update
tt.info.i18n_key = "SPECIAL_SASQUASH_REPAIR"
tt.info.fn = scripts.tower_barrack_mercenaries.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers") or "info_portraits_towers") .. "_0014"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "sasquash_frozen_0001"
tt.render.sprites[1].offset = v(-9, 13)
tt.render.sprites[1].z = Z_TOWER_BASES - 2
tt.ui.click_rect = r(-40, -30, 80, 90)
tt.unfreeze_radius = 60
tt.unfreeze_fx = "fx_tower_sasquash_unfreeze"
tt.unfreeze_upgrade_to = "tower_sasquash"
tt.unfreeze_rect = r(290, 480, 120, 90)
tt = RT("fx_tower_sasquash_unfreeze", "fx")
tt.render.sprites[1].name = "tower_sasquash_unfreeze"
tt.render.sprites[1].offset = v(-9, 13)
tt.render.sprites[1].z = Z_EFFECTS
tt = RT("tower_sasquash", "tower")

AC(tt, "barrack")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers") or "info_portraits_towers") .. "_0014"
tt.barrack.max_soldiers = 1
tt.barrack.rally_range = 288
tt.barrack.respawn_offset = v(-60, 0)
tt.barrack.soldier_type = "soldier_sasquash"
tt.barrack.has_door = nil
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)
tt.info.i18n_key = "SPECIAL_SASQUASH"
tt.info.fn = scripts.tower_sasquash_holder.get_info
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.remove = scripts.tower_barrack.remove
tt.main_script.update = scripts.tower_barrack_mercenaries.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "sasquash_cave_inside"
tt.render.sprites[1].offset = v(-9, 13)
tt.render.sprites[1].z = Z_TOWER_BASES - 2
tt.sound_events.change_rally_point = "SasquashRally"
tt.sound_events.insert = nil
tt.sound_events.mute_on_level_insert = true
tt.tower.can_be_mod = false
tt.tower.can_be_sold = false
tt.tower.level = 1
tt.tower.price = 0
tt.tower.terrain_style = nil
tt.tower.type = "sasquash"
tt.ui.click_rect = r(-40, -30, 80, 90)
tt.ui.has_nav_mesh = true
tt = RT("tower_sasquash_2", "tower")

AC(tt, "barrack")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers") or "info_portraits_towers") .. "_0014"
tt.barrack.max_soldiers = 1
tt.barrack.rally_range = 9e+99
tt.barrack.respawn_offset = v(-60, 0)
tt.barrack.soldier_type = "soldier_sasquash"
tt.barrack.has_door = nil
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)
tt.info.i18n_key = "SPECIAL_SASQUASH"
tt.info.fn = scripts.tower_sasquash_holder.get_info
tt.main_script.insert = scripts.tower_barrack.insert
tt.main_script.remove = scripts.tower_barrack.remove
tt.main_script.update = scripts.tower_barrack_mercenaries.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "forest_troll_0159"
tt.render.sprites[1].offset = v(-9, 13)
tt.render.sprites[1].z = Z_TOWER_BASES - 2
tt.sound_events.change_rally_point = "SasquashRally"
tt.sound_events.insert = nil
tt.sound_events.mute_on_level_insert = true
tt.tower.can_be_mod = false
tt.tower.can_be_sold = false
tt.tower.level = 1
tt.tower.price = 0
tt.tower.terrain_style = nil
tt.tower.type = "sasquash_2"
tt.ui.click_rect = r(-40, -30, 80, 90)
tt.ui.has_nav_mesh = true
tt = RT("tower_betrayer", "tower")

AC(tt, "barrack")

tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers") or "info_portraits_towers") .. "_0014"
tt.barrack.max_soldiers = 4
tt.barrack.rally_range = 275
tt.barrack.respawn_offset = v(-60, 0)
tt.barrack.soldier_type = "soldier_bandit"
tt.barrack.has_door = nil
tt.editor.props = table.append(tt.editor.props, {
	{
		"barrack.rally_pos",
		PT_COORDS
	}
}, true)


AC(tt, "powers", "user_selection", "attacks")

tt.tower.level = 1
tt.tower.type = "sunray"
tt.tower.price = 500
tt.tower.can_be_mod = false
tt.tower.terrain_style = nil
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0015") or "info_portraits_towers_0015"
tt.info.fn = scripts.tower_sunray.get_info
tt.info.i18n_key = "SPECIAL_SUNRAY"
tt.ui.click_rect = r(-55, -40, 110, 130)
tt.powers.ray = E.clone_c(E, "power")
tt.powers.ray.level = 0
tt.powers.ray.max_level = 4
tt.powers.ray.price_base = 100
tt.powers.ray.price_inc = 100
tt.main_script.insert = scripts.tower_sunray.insert
tt.main_script.update = scripts.tower_sunray.update
tt.render.sprites[1].name = "sunrayTower_layer1_0068"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = (IS_CONSOLE and v(-6.5, 25)) or v(-6, 51)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "sunrayTower_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(-6, 25)

for i = 3, 6, 1 do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].name = "disabled"
	tt.render.sprites[i].offset = v(-6, 25)
	tt.render.sprites[i].prefix = "tower_sunray_layer" .. i - 1
	tt.render.sprites[i].group = "tower"
end

for i = 7, 10, 1 do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].animated = true
	tt.render.sprites[i].hidden = true
	tt.render.sprites[i].anchor.y = 0.11764705882352941
	tt.render.sprites[i].prefix = "tower_sunray_shooter_" .. ((i%2 == 0 and "down") or "up")
end

tt.render.sprites[7].offset = v(33, -10)
tt.render.sprites[8].offset = v(-25, 22)
tt.render.sprites[9].offset = v(-29, -11)
tt.render.sprites[10].offset = v(30, 22)
tt.sound_events.mute_on_level_insert = true
tt.user_selection.can_select_point_fn = scripts.tower_sunray.can_select_point
tt.user_selection.custom_pointer_name = "sunray_tower"
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "ray_sunray"
tt.attacks.list[1].cooldown = 19
tt.attacks.list[1].cooldown_base = 22
tt.attacks.list[1].cooldown_inc = -3
tt.attacks.list[1].bullet_start_offset = v(0, 80)
tt.attacks.list[1].range = 2000
tt.attacks.list[1].shoot_time = fts(3)
tt = RT("tower_sunray", "tower")

AC(tt, "powers", "user_selection", "attacks")

tt.tower.level = 1
tt.tower.type = "sunray"
tt.tower.price = 260
tt.tower.can_be_mod = false
tt.tower.terrain_style = nil
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0015") or "info_portraits_towers_0015"
tt.info.fn = scripts.tower_sunray.get_info
tt.info.i18n_key = "SPECIAL_SUNRAY"
tt.ui.click_rect = r(-55, -40, 110, 130)
tt.powers.ray = E.clone_c(E, "power")
tt.powers.ray.level = 0
tt.powers.ray.max_level = 4
tt.powers.ray.price_base = 100
tt.powers.ray.price_inc = 100
tt.main_script.insert = scripts.tower_sunray.insert
tt.main_script.update = scripts.tower_sunray.update
tt.render.sprites[1].name = "sunrayTower_layer1_0068"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = (IS_CONSOLE and v(-6.5, 25)) or v(-6, 51)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "sunrayTower_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(-6, 25)

for i = 3, 6, 1 do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].name = "disabled"
	tt.render.sprites[i].offset = v(-6, 25)
	tt.render.sprites[i].prefix = "tower_sunray_layer" .. i - 1
	tt.render.sprites[i].group = "tower"
end

for i = 7, 10, 1 do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].animated = true
	tt.render.sprites[i].hidden = true
	tt.render.sprites[i].anchor.y = 0.11764705882352941
	tt.render.sprites[i].prefix = "tower_sunray_shooter_" .. ((i%2 == 0 and "down") or "up")
end

tt.render.sprites[7].offset = v(33, -10)
tt.render.sprites[8].offset = v(-25, 22)
tt.render.sprites[9].offset = v(-29, -11)
tt.render.sprites[10].offset = v(30, 22)
tt.sound_events.mute_on_level_insert = true
tt.user_selection.can_select_point_fn = scripts.tower_sunray.can_select_point
tt.user_selection.custom_pointer_name = "sunray_tower"
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "ray_sunray"
tt.attacks.list[1].cooldown = 19
tt.attacks.list[1].cooldown_base = 22
tt.attacks.list[1].cooldown_inc = -3
tt.attacks.list[1].bullet_start_offset = v(0, 80)
tt.attacks.list[1].range = 2000
tt.attacks.list[1].shoot_time = fts(3)
tt = RT("tower_sunray_mini", "tower")

AC(tt, "powers", "user_selection", "attacks")

tt.tower.level = 1
tt.tower.type = "sunray_mini"
tt.tower.price = 260
tt.tower.can_be_mod = false
tt.tower.terrain_style = nil
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0015") or "info_portraits_towers_0015"
tt.info.fn = scripts.tower_sunray.get_info
tt.info.i18n_key = "SPECIAL_SUNRAY"
tt.ui.click_rect = r(-55, -40, 110, 130)
tt.powers.ray = E.clone_c(E, "power")
tt.powers.ray.level = 0
tt.powers.ray.max_level = 4
tt.powers.ray.price_base = 0
tt.powers.ray.price_inc = 100
tt.main_script.insert = scripts.tower_sunray.insert
tt.main_script.update = scripts.tower_sunray.update
tt.render.sprites[1].name = "sunrayTower_layer1_0068"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = (IS_CONSOLE and v(-6.5, 25)) or v(-6, 51)
tt.render.sprites[1].hidden = true
tt.render.sprites[1].hover_off_hidden = true
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "sunrayTower_layer1_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].offset = v(-6, 25)

for i = 3, 6, 1 do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].name = "disabled"
	tt.render.sprites[i].offset = v(-6, 25)
	tt.render.sprites[i].prefix = "tower_sunray_layer" .. i - 1
	tt.render.sprites[i].group = "tower"
end

for i = 7, 10, 1 do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].animated = true
	tt.render.sprites[i].hidden = true
	tt.render.sprites[i].anchor.y = 0.11764705882352941
	tt.render.sprites[i].prefix = "tower_sunray_shooter_" .. ((i%2 == 0 and "down") or "up")
end

tt.render.sprites[7].offset = v(33, -10)
tt.render.sprites[8].offset = v(-25, 22)
tt.render.sprites[9].offset = v(-29, -11)
tt.render.sprites[10].offset = v(30, 22)
tt.sound_events.mute_on_level_insert = true
tt.user_selection.can_select_point_fn = scripts.tower_sunray.can_select_point
tt.user_selection.custom_pointer_name = "sunray_tower"
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "ray_sunray_mini"
tt.attacks.list[1].cooldown = 19
tt.attacks.list[1].cooldown_base = 22
tt.attacks.list[1].cooldown_inc = -3
tt.attacks.list[1].bullet_start_offset = v(0, 80)
tt.attacks.list[1].range = 2000
tt.attacks.list[1].shoot_time = fts(3)
tt = RT("soldier_elemental", "soldier_militia")

AC(tt, "melee")

image_y = 64
anchor_y = 0.15384615384615385
tt.health.armor = 0.3
tt.health.armor_inc = 0.1
tt.health.dead_lifetime = 8
tt.health.hp_max = 500
tt.health.hp_inc = 100
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "SOLDIER_ELEMENTAL"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0017") or "info_portraits_sc_0017"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 4
tt.melee.attacks[1].damage_inc = 10
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].damage_radius = 37.5
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.range = 75
tt.motion.max_speed = 39
tt.regen.health = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_elemental"
tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "RockElementalDeath"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)
tt = RT("soldier_elemental_big", "soldier_militia")

AC(tt, "melee")

image_y = 64
anchor_y = 0.15384615384615385
tt.health.armor = 0.75
tt.health.armor_inc = 0.1
tt.health.dead_lifetime = 8
tt.health.hp_max = 3500
tt.health.hp_inc = 100
tt.health_bar.offset = v(0, 55)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "SOLDIER_ELEMENTAL"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0017") or "info_portraits_sc_0017"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 4
tt.melee.attacks[1].damage_inc = 10
tt.melee.attacks[1].damage_max = 150
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].damage_radius = 37.5
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
	"pop_whaam",
	"pop_kapow"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.range = 75
tt.motion.max_speed = 39
tt.regen.health = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_elemental"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.soldier.melee_slot_offset = v(15, 0)
tt.sound_events.insert = "RockElementalDeath"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect = r(-25, -2, 50, 52)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 16)
tt.vis.bans = bor(F_LYCAN)
tt = RT("soldier_paladin", "soldier_militia")

E.add_comps(E, tt, "powers", "timed_actions")

anchor_y = 0.17
image_y = 42
tt.health.armor = 0.5
tt.health.dead_lifetime = 14
tt.health.hp_max = 200
tt.health.armor_power_name = "shield"
tt.health.armor_inc = 0.15
tt.health_bar.offset = v(0, ady(40))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0004") or "info_portraits_sc_0004"
tt.info.random_name_count = 20
tt.info.random_name_format = "SOLDIER_PALADIN_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[3] = E.clone_c(E, "area_attack")
tt.melee.attacks[3].animation = "holystrike"
tt.melee.attacks[3].chance = 0.1
tt.melee.attacks[3].damage_max = 0
tt.melee.attacks[3].damage_min = 0
tt.melee.attacks[3].damage_max_inc = 45
tt.melee.attacks[3].damage_min_inc = 25
tt.melee.attacks[3].damage_radius = 50
tt.melee.attacks[3].damage_type = DAMAGE_TRUE
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_decal = "decal_paladin_holystrike"
tt.melee.attacks[3].hit_offset = v(22, 0)
tt.melee.attacks[3].hit_time = fts(15)
tt.melee.attacks[3].level = 0
tt.melee.attacks[3].pop = nil
tt.melee.attacks[3].power_name = "holystrike"
tt.melee.attacks[3].shared_cooldown = true
tt.melee.attacks[3].signal = "holystrike"
tt.melee.attacks[3].vis_bans = bor(F_FLYING)
tt.melee.attacks[3].vis_flags = bor(F_BLOCK)
tt.melee.cooldown = fts(13) + 1
tt.melee.range = 60
tt.motion.max_speed = 75
tt.powers.healing = E.clone_c(E, "power")
tt.powers.shield = E.clone_c(E, "power")
tt.powers.holystrike = E.clone_c(E, "power")
tt.regen.health = 25
tt.render.sprites[1].prefix = "soldier_paladin"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(5, 0)
tt.timed_actions.list[1] = CC("mod_attack")
tt.timed_actions.list[1].animation = "healing"
tt.timed_actions.list[1].cast_time = fts(17)
tt.timed_actions.list[1].cooldown = 10
tt.timed_actions.list[1].disabled = true
tt.timed_actions.list[1].fn_can = function (t, s, a)
	return t.health.hp < a.min_health_factor*t.health.hp_max
end
tt.timed_actions.list[1].level = 0
tt.timed_actions.list[1].min_health_factor = 0.7
tt.timed_actions.list[1].mod = "mod_healing_paladin"
tt.timed_actions.list[1].power_name = "healing"
tt.timed_actions.list[1].sound = "HealingSound"

tt = RT("soldier_barbarian", "soldier_militia")

E.add_comps(E, tt, "powers", "ranged")

anchor_y = 0.3
image_y = 62
tt.health.armor = 0
tt.health.dead_lifetime = 10
tt.health.hp_max = 250
tt.health_bar.offset = v(0, ady(48))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0005") or "info_portraits_sc_0005"
tt.info.random_name_count = 20
tt.info.random_name_format = "SOLDIER_BARBARIAN_RANDOM_%i_NAME"
tt.motion.max_speed = 85
tt.powers.dual = E.clone_c(E, "power")
tt.powers.dual.on_power_upgrade = scripts.soldier_barbarian.on_power_upgrade
tt.powers.twister = E.clone_c(E, "power")
tt.powers.throwing = E.clone_c(E, "power")
tt.regen.health = 50
tt.render.sprites[1].prefix = "soldier_barbarian"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(5, 0)
tt.melee.cooldown = fts(11) + 1
tt.melee.range = 60
tt.melee.attacks[1].damage_inc = 10
tt.melee.attacks[1].damage_max = 24
tt.melee.attacks[1].damage_min = 16
tt.melee.attacks[1].power_name = "dual"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "twister"
tt.melee.attacks[2].chance = 0.1
tt.melee.attacks[2].chance_inc = 0.05
tt.melee.attacks[2].damage_inc = 20
tt.melee.attacks[2].damage_max = 30
tt.melee.attacks[2].damage_min = 10
tt.melee.attacks[2].damage_radius = 40
tt.melee.attacks[2].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(7)
tt.melee.attacks[2].level = 0
tt.melee.attacks[2].pop = nil
tt.melee.attacks[2].power_name = "twister"
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].vis_bans = bor(F_FLYING)
tt.melee.attacks[2].vis_flags = bor(F_BLOCK)
tt.ranged.go_back_during_cooldown = true
tt.ranged.range_while_blocking = true
tt.ranged.attacks[1].bullet = "axe_barbarian"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 12)
}
tt.ranged.attacks[1].cooldown = fts(14) + 3
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].level = 0
tt.ranged.attacks[1].max_range = 155
tt.ranged.attacks[1].min_range = 55
tt.ranged.attacks[1].power_name = "throwing"
tt.ranged.attacks[1].range_inc = 13
tt.ranged.attacks[1].shoot_time = fts(7)
tt = RT("soldier_elf", "soldier_militia")

AC(tt, "ranged")

image_y = 32
anchor_y = 0.19
tt.health.hp_max = 100
tt.health_bar.offset = v(0, ady(31))
tt.health.dead_lifetime = 3
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0044") or "info_portraits_sc_0044"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_ELVES_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 25
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].track_damage = true
tt.melee.range = 75
tt.ranged.go_back_during_cooldown = true
tt.ranged.attacks[1].bullet = "arrow_elf"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 16)
}
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.ranged.attacks[1].max_range = 205
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(7)
tt.regen.cooldown = 1
tt.regen.health = 20
tt.render.sprites[1].prefix = "soldier_elf"
tt.sound_events.insert = "ElfTaunt"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, ady(22))
tt.unit.price = 100
tt = RT("soldier_sasquash", "soldier_militia")
image_y = 80
anchor_y = 0.17
tt.health.hp_max = 2500
tt.health_bar.offset = v(0, ady(73))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 3
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0034") or "info_portraits_sc_0034"
tt.info.i18n_key = "SOLDIER_SASQUASH"
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_sasquash.insert
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 110
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 35
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].pop = {
	"pop_kapow",
	"pop_whaam"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].pop_conds = DR_KILL
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.range = 83
tt.motion.max_speed = 49.5
tt.regen.cooldown = 1
tt.regen.health = 250
tt.render.sprites[1].prefix = "soldier_sasquash"
tt.soldier.melee_slot_offset = v(25, 0)
tt.sound_events.insert = "SasquashReady"
tt.ui.click_rect = r(-20, 0, 40, 40)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, ady(30))
tt.unit.price = 400
tt = RT("soldier_sasquash_2", "soldier_militia")

AC(tt, "auras")

image_y = 80
anchor_y = 0.17
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_forest_troll_regen"
tt.auras.list[1].cooldown = 0
tt.health.hp_max = 4000
tt.health_bar.offset = v(0, ady(73))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 3
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0034") or "info_portraits_sc_0034"
tt.info.i18n_key = "SOLDIER_SASQUASH"
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_sasquash.insert
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 35
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].pop = {
	"pop_kapow",
	"pop_whaam"
}
tt.melee.attacks[1].pop_chance = 0.3
tt.melee.attacks[1].pop_conds = DR_KILL
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.range = 83
tt.motion.max_speed = 49.5
tt.regen.cooldown = fts(4)
tt.regen.health = 4
tt.render.sprites[1].prefix = "soldier_sasquash2"
tt.soldier.melee_slot_offset = v(25, 0)
tt.sound_events.insert = "SasquashReady"
tt.ui.click_rect = r(-20, 0, 40, 40)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, ady(30))
tt.unit.price = 400
tt = RT("soldier_s6_imperial_guard", "soldier_militia")

AC(tt, "editor")

anchor_y = 0.15
anchor_x = 0.5
image_y = 41
image_x = 58
tt.health.armor = 0.4
tt.health.dead_lifetime = 3
tt.health.hp_max = 250
tt.health_bar.offset = v(adx(28), ady(40))
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0026") or "info_portraits_sc_0026"
tt.info.random_name_count = 20
tt.info.random_name_format = "SOLDIER_PALADIN_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[2].hit_time = fts(6)
tt.melee.cooldown = 1
tt.melee.range = 72.5
tt.motion.max_speed = 60
tt.regen.health = 25
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "soldier_s6_imperial_guard"
tt.soldier.melee_slot_offset = v(8, 0)
tt.unit.mod_offset = v(adx(27), ady(22))
tt.editor.props = {
	{
		"editor.game_mode",
		PT_NUMBER
	}
}
tt.editor.overrides = {
	["health.hp"] = 250
}
tt = RT("re_farmer", "soldier_militia")

AC(tt, "reinforcement", "tween")

image_y = 44
anchor_y = 0.1590909090909091
tt.cooldown = 10
tt.health.armor = 0
tt.health.hp_max = 30
tt.health_bar.offset = v(0, ady(32))
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.info.portrait_idxs = {
	15,
	16,
	14
}
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 2
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.range = 60
tt.motion.max_speed = 60
tt.regen.cooldown = 1
tt.regen.health = 3
tt.reinforcement.duration = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.sound_events.insert = "ReinforcementTaunt"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.remove = false
tt.tween.reverse = false
tt.unit.level = 0
tt.vis.bans = bor(F_SKELETON, F_CANNIBALIZE, F_LYCAN)
tt = RT("re_farmer_sorcerer", "re_farmer")
tt.reinforcement.duration = 6
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.cooldown = 0.7
tt.health.hp_max = 50
tt.health.magic_armor = 0.4
tt.health.immune_to = bor(DAMAGE_PHYSICAL, DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL, DAMAGE_MODIFIER, DAMAGE_EAT)
tt.vis.bans = bor(tt.vis.bans, F_MOD, F_POISON, F_BURN, F_BLOOD)
tt.sound_events.insert = nil
tt.health.dead_lifetime = fts(10)
tt.health_bar.offset = v(0, 40)
tt.info.fn = scripts2.soldier_reinforcement.get_info
image_y = 80
anchor_y = 12 / image_y
tt.info.portrait = (IS_PHONE and "portraits_sc_0026") or "info_portraits_sc_0026"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.motion.max_speed = 6 * FPS
tt.reinforcement.fade = nil
tt.reinforcement.fade_out = true
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.unit.blood_color = BLOOD_NONE
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "soldier_s6_imperial_guard"
tt.sound_events.insert = nil
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.remove = false
tt.tween.disabled = true
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt = RT("re_farmer_sorcerer_2", "re_farmer")
tt.reinforcement.duration = 9e+99
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].damage_radius = 38.5
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.cooldown = 2.5
tt.health.hp_max = 666
tt.health.magic_armor = 0.6
tt.health.armor = 0.65
tt.regen.health = 666
tt.vis.bans = bor(tt.vis.bans, F_MOD, F_POISON, F_BURN, F_BLOOD, F_LYCAN)
tt.sound_events.insert = nil
tt.health.dead_lifetime = fts(10)
tt.health_bar.offset = v(0, 40)
tt.info.fn = scripts2.soldier_reinforcement.get_info
image_y = 64
anchor_y = 0.25
tt.info.i18n_key = "SOLDIER_ELEMENTAL"
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_sc_0017" or "info_portraits_sc_0017"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.motion.max_speed = 0.8 * FPS
tt.reinforcement.fade = nil
tt.reinforcement.fade_out = true
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.unit.blood_color = BLOOD_NONE
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_elemental"
tt.sound_events.insert = nil
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.remove = false
tt.tween.disabled = true
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt = RT("re_farmer_well_fed", "re_farmer")
tt.unit.level = 1
tt.health.hp_max = 50
tt.health.armor = 0
tt.regen.health = 6
tt.melee.attacks[1].damage_max = 3
tt = RT("re_conscript", "re_farmer")
tt.info.portrait_idxs = {
	41,
	38,
	35
}
tt.unit.level = 2
tt.health.hp_max = 70
tt.health.armor = 0.1
tt.regen.health = 9
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].damage_max = 4
tt = RT("re_warrior", "re_farmer")
tt.info.portrait_idxs = {
	42,
	39,
	36
}
tt.unit.level = 3
tt.health.hp_max = 90
tt.health.armor = 0.2
tt.regen.health = 12
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].damage_max = 6
tt = RT("re_legionnaire", "re_farmer")
tt.info.portrait_idxs = {
	43,
	40,
	37
}
tt.unit.level = 4
tt.health.hp_max = 110
tt.health.armor = 0.3
tt.health_bar.offset = v(0, ady(34))
tt.regen.health = 15
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].damage_max = 10
tt = RT("re_legionnaire_ranged", "re_legionnaire")

AC(tt, "ranged")

tt.unit.level = 5
tt.ranged.attacks[1].bullet = "spear_legionnaire"
tt.ranged.attacks[1].shoot_time = fts(3)
tt.ranged.attacks[1].cooldown = fts(12) + 1
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 27
tt.ranged.attacks[1].animation = (IS_PHONE_OR_TABLET and "ranged_attack_p") or "ranged_attack"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 13)
}

for i = 1, 3, 1 do
	for j, name in ipairs({
		"re_farmer",
		"re_farmer_well_fed",
		"re_conscript",
		"re_warrior",
		"re_legionnaire",
		"re_legionnaire_ranged"
	}) do
		local fn = name .. "_" .. i
		local base_t = E.get_template(E, name)
		local t = RT(fn, base_t)
		t.render.sprites[1].prefix = fn

		if IS_PHONE_OR_TABLET then
			t.info.portrait = string.format("portraits_sc_00%02d", t.info.portrait_idxs[i])
		else
			t.info.portrait = string.format("info_portraits_sc_00%02d", t.info.portrait_idxs[i])
		end
	end
end

for i = 1, 3, 1 do
	E.set_template(E, "re_current_" .. i, E.get_template(E, "re_farmer_" .. i))
end

tt = RT("soldier_alleria_wildcat", "soldier")

E.add_comps(E, tt, "melee", "nav_grid")

anchor_y = 0.28
image_y = 42
tt.fn_level_up = scripts.soldier_alleria_wildcat.level_up
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0007") or "info_portraits_hero_0007"
tt.health.armor = 0
tt.health.armor_magic = 0.5
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 35)
tt.info.fn = scripts.soldier_alleria_wildcat.get_info
tt.info.i18n_key = "HERO_ARCHER_WILDCAT"
tt.main_script.insert = scripts.soldier_alleria_wildcat.insert
tt.main_script.update = scripts.soldier_alleria_wildcat.update
tt.melee.attacks[1].cooldown = 0.6
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].vis_bans = bor(F_FLYING)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "HeroArcherWildCatHit"
tt.melee.range = 80
tt.motion.max_speed = 90
tt.regen.health = 75
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].prefix = "soldier_alleria"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.soldier.melee_slot_offset.x = 5
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -10, 40, 40)) or r(-15, -5, 30, 30)
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, 14)
tt.unit.hide_after_death = true
tt.unit.explode_fx = nil
tt.vis.bans = bor(F_SKELETON, F_CANNIBALIZE)
tt = RT("soldier_magnus_illusion", "soldier_militia")

AC(tt, "reinforcement", "ranged", "tween")

image_y = 76
image_x = 60
anchor_y = 0.14
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 33)
tt.health.dead_lifetime = fts(14)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0005") or "info_portraits_hero_0004"
tt.info.i18n_key = "HERO_MAGE_SHADOW"
tt.info.random_name_format = nil
tt.info.fn = scripts.soldier_magnus_illusion.get_info
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.range = 45
tt.reinforcement.duration = 10
tt.reinforcement.fade = nil
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].bullet = "bolt_magnus_illusion"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 23)
}
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].damage_max = nil
tt.ranged.attacks[1].damage_min = nil
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].cooldown = fts(33)
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "soldier_magnus_illusion"
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].alpha = 180
tt.tween.props[1].name = "offset"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 0)
	},
	{
		fts(6),
		v(0, 0)
	}
}
tt.tween.remove = false
tt.tween.run_once = true
tt.ui.click_rect = r(-13, -5, 26, 32)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.price = 0
tt.vis.bans = bor(F_LYCAN, F_SKELETON, F_CANNIBALIZE)
tt = RT("soldier_ingvar_ancestor", "soldier_militia")

AC(tt, "reinforcement", "melee")

image_y = 60
image_x = 72
anchor_y = 0.17
tt.health.armor = 0.25
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 46)
tt.health.dead_lifetime = fts(30)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0011") or "info_portraits_hero_0011"
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "HERO_VIKING_ANCESTOR"
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.remove = scripts.soldier_reinforcement.remove
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.range = 80
tt.motion.max_speed = FPS*2.3
tt.reinforcement.duration = 10
tt.reinforcement.fade = nil
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "soldier_ingvar_ancestor"
tt.ui.click_rect = r(-13, 0, 26, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.price = 0
tt.vis.bans = bor(F_LYCAN, F_SKELETON, F_CANNIBALIZE, F_POISON)
tt = E.register_t(E, "hero_priest", "hero")

E.add_comps(E, tt, "melee", "ranged", "teleport", "timed_attacks")

anchor_y = 0.18
image_y = 134
tt.hero.level_stats.hp_max = {
	180,
	200,
	220,
	240,
	260,
	280,
	300,
	320,
	340,
	360
}
tt.hero.level_stats.regen_health = {
	23,
	25,
	28,
	30,
	33,
	35,
	38,
	40,
	43,
	45
}
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.melee_damage_min = {
	4,
	5,
	6,
	6,
	7,
	8,
	9,
	9,
	10,
	11
}
tt.hero.level_stats.melee_damage_max = {
	12,
	14,
	17,
	19,
	21,
	23,
	26,
	28,
	30,
	32
}
tt.hero.level_stats.ranged_damage_min = {
	4,
	5,
	6,
	6,
	7,
	8,
	9,
	9,
	10,
	11
}
tt.hero.level_stats.ranged_damage_max = {
	12,
	14,
	17,
	19,
	21,
	23,
	26,
	28,
	30,
	32
}
tt.hero.skills.holylight = E.clone_c(E, "hero_skill")
tt.hero.skills.holylight.heal_hp = {
	25,
	50,
	75
}
tt.hero.skills.holylight.heal_count = {
	2,
	3,
	4
}
tt.hero.skills.holylight.revive_chance = {
	0.1,
	0.2,
	0.3
}
tt.hero.skills.holylight.xp_gain_factor = 12
tt.hero.skills.consecrate = E.clone_c(E, "hero_skill")
tt.hero.skills.consecrate.duration = {
	6,
	10,
	14
}
tt.hero.skills.consecrate.extra_damage = {
	0.15,
	0.2,
	0.25
}
tt.hero.skills.consecrate.xp_gain_factor = 18
tt.hero.skills.wingsoflight = E.clone_c(E, "hero_skill")
tt.hero.skills.wingsoflight.range = 100
tt.hero.skills.wingsoflight.duration = {
	10,
	20,
	30
}
tt.hero.skills.wingsoflight.armor = 0.2
tt.hero.skills.wingsoflight.count = {
	2,
	4,
	6
}
tt.hero.skills.blessedarmor = E.clone_c(E, "hero_skill")
tt.hero.skills.blessedarmor.armor = {
	0.25,
	0.5,
	0.75
}
tt.hero.skills.divinehealth = E.clone_c(E, "hero_skill")
tt.hero.skills.divinehealth.extra_hp = {
	30,
	90,
	180
}
tt.hero.skills.divinehealth.regen_factor = {
	1.06,
	1.18,
	1.36
}
tt.hero.skills.holylight.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.holylight.hr_icon = 16
tt.hero.skills.holylight.hr_order = 1
tt.hero.skills.consecrate.hr_cost = {
	2,
	2,
	3
}
tt.hero.skills.consecrate.hr_icon = 17
tt.hero.skills.consecrate.hr_order = 2
tt.hero.skills.wingsoflight.hr_cost = {
	3,
	1,
	1
}
tt.hero.skills.wingsoflight.hr_icon = 18
tt.hero.skills.wingsoflight.hr_order = 3
tt.hero.skills.blessedarmor.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.blessedarmor.hr_icon = 19
tt.hero.skills.blessedarmor.hr_order = 4
tt.hero.skills.divinehealth.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.divinehealth.hr_icon = 20
tt.hero.skills.divinehealth.hr_order = 5
tt.health.armor = 114514
tt.health.dead_lifetime = 15
tt.health.hp_max = 1919810
tt.health_bar.offset = v(0, 37)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_priest.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_priest.get_info
tt.info.hero_portrait = "hero_portraits_0115"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0005") or "info_portraits_heroes_0335"
tt.info.damage_icon = "magic"
tt.main_script.insert = scripts3.hero_priest.insert
tt.main_script.update = scripts3.hero_priest.update
tt.motion.max_speed = 90
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_priest"
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HeroPriestTaunt"
tt.sound_events.death = "HeroPriestDeath"
tt.sound_events.respawn = "HeroPriestTauntIntro"
tt.sound_events.insert = "HeroPriestTauntIntro"
tt.sound_events.hero_room_select = "HeroPriestTauntSelect"
tt.teleport.min_distance = 100
tt.teleport.sound = "HeroPriestWings"
tt.teleport.disabled = true
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -1)
tt.unit.mod_offset = v(0, 13.88)
tt.melee.range = 51.2
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].damage_type = DAMAGE_MAGICAL
tt.melee.attacks[1].xp_gain_factor = 0.7
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].bullet = "bolt_priest"
tt.ranged.attacks[1].cooldown = fts(13) + 1
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 34)
}
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "holylight"
tt.timed_attacks.list[1].cooldown = 6
tt.timed_attacks.list[1].max_per_cast = 1
tt.timed_attacks.list[1].mod = "mod_priest_heal"
tt.timed_attacks.list[1].revive_chance = 0
tt.timed_attacks.list[1].range = 125
tt.timed_attacks.list[1].shoot_time = fts(4)
tt.timed_attacks.list[1].sound = "HeroPriestHolyLight"
tt.timed_attacks.list[1].excluded_templates = {
	"soldier_mecha"
}
tt.timed_attacks.list[2] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].animation = "consecrate"
tt.timed_attacks.list[2].cooldown = 8
tt.timed_attacks.list[2].excluded_templates = {
	"tower_barrack_1",
  "tower_barrack_2",
  "tower_barrack_3",
  "tower_forest",
  "tower_blade",
  "tower_barbarian",
  "tower_paladin"
}
tt.timed_attacks.list[2].mod = "mod_priest_consecrate"
tt.timed_attacks.list[2].range = 150
tt.timed_attacks.list[2].shoot_time = fts(15)
tt.timed_attacks.list[2].sound = "HeroPriestConsecrate"
tt = E.register_t(E, "bolt_priest", "bolt")
tt.bullet.xp_gain_factor = 0.7
tt.render.sprites[1].prefix = "bolt_priest"
tt.bullet.damage_min = 114514
tt.bullet.damage_max = 1919810
tt = E.register_t(E, "mod_priest_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.modifier.duration = fts(24)
tt.hps.heal_min = 25
tt.hps.heal_max = 25
tt.hps.heal_every = 9e+99
tt.render.sprites[1].name = "fx_priest_heal"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts3.mod_hps.insert
tt.main_script.update = scripts3.mod_hps.update
tt = E.register_t(E, "fx_priest_revive", "fx")
tt.render.sprites[1].name = "fx_priest_revive"
tt.render.sprites[1].anchor.y = 0.15
tt = E.register_t(E, "fx_priest_wave_out", "decal_tween")
tt.render.sprites[1].name = "hero_priest_healWave"
tt.render.sprites[1].animated = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(2.4, 2.4)
	},
	{
		0.32,
		v(1, 1)
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		0.32,
		0
	}
}
tt = E.register_t(E, "fx_priest_wave_in", "fx_priest_wave_out")
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.32,
		v(2.4, 2.4)
	}
}
tt = E.register_t(E, "mod_priest_armor", "modifier")

E.add_comps(E, tt, "render", "armor_buff")

tt.modifier.duration = nil
tt.modifier.use_mod_offset = false
tt.armor_buff.max_factor = 0.2
tt.armor_buff.step_factor = 0.2
tt.armor_buff.cycle_time = 1e+99
tt.main_script.insert = scripts3.mod_armor_buff.insert
tt.main_script.remove = scripts3.mod_armor_buff.remove
tt.main_script.update = scripts3.mod_armor_buff.update
tt.render.sprites[1].name = "decal_priest_armor"
tt.render.sprites[1].anchor = v(0.51, 0.17307692307692307)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "fx_priest_armor"
tt.render.sprites[2].anchor.x = 0.51
tt.render.sprites[2].loop = false
tt.render.sprites[2].hide_after_runs = 1
tt = E.register_t(E, "mod_priest_consecrate", "modifier")

E.add_comps(E, tt, "render", "tween")

tt.render.sprites[1].name = "decal_priest_consecrate"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].anchor.y = 0.32
tt.render.sprites[1].offset.y = 7
tt.main_script.update = scripts3.mod_priest_consecrate.update
tt.modifier.duration = nil
tt.extra_damage = nil
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt = E.register_t(E, "soldier_sand_warrior", "unit")

E.add_comps(E, tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events")

anchor_y = 0.2
image_y = 36
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0012") or "info_portraits_heroes_0012"
tt.health.armor = 0
tt.health.hp_inc = 40
tt.health.hp_max = 20
tt.health_bar.offset = v(0, ady(39))
tt.info.fn = scripts3.soldier_sand_warrior.get_info
tt.info.i18n_key = "HERO_ALRIC_SANDWARRIORS"
tt.lifespan.duration = nil
tt.main_script.insert = scripts3.soldier_sand_warrior.insert
tt.main_script.update = scripts3.soldier_sand_warrior.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.range = 64
tt.motion.max_speed = 60
tt.nav_path.dir = -1
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_sand_warrior"
tt.soldier.melee_slot_offset.x = 5
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_LYCAN)
tt.vis.flags = F_FRIEND
tt = E.register_t(E, "hero_alric", "hero")

E.add_comps(E, tt, "melee", "timed_attacks")

anchor_y = 0.09
image_y = 90
tt.hero.level_stats.armor = {
	0.2,
	0.25,
	0.3,
	0.35,
	0.4,
	0.45,
	0.5,
	0.55,
	0.6,
	0.65
}
tt.hero.level_stats.hp_max = {
	245,
	260,
	275,
	290,
	305,
	320,
	335,
	350,
	365,
	380
}
tt.hero.level_stats.melee_damage_max = {
	10,
	12,
	14,
	16,
	18,
	20,
	22,
	24,
	26,
	28
}
tt.hero.level_stats.melee_damage_min = {
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15
}
tt.hero.level_stats.regen_health = {
	25,
	26,
	28,
	29,
	31,
	32,
	34,
	35,
	37,
	38
}
tt.hero.skills.flurry = E.clone_c(E, "hero_skill")
tt.hero.skills.flurry.cooldown = {
	6,
	6,
	6
}
tt.hero.skills.flurry.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.flurry.hr_icon = 4
tt.hero.skills.flurry.hr_order = 4
tt.hero.skills.flurry.loops = {
	1,
	2,
	3
}
tt.hero.skills.flurry.xp_gain_factor = 25
tt.hero.skills.sandwarriors = E.clone_c(E, "hero_skill")
tt.hero.skills.sandwarriors.count = {
	1,
	2,
	3
}
tt.hero.skills.sandwarriors.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.sandwarriors.hr_icon = 5
tt.hero.skills.sandwarriors.hr_order = 5
tt.hero.skills.sandwarriors.lifespan = {
	7,
	8,
	9
}
tt.hero.skills.sandwarriors.xp_gain_factor = 35
tt.hero.skills.spikedarmor = E.clone_c(E, "hero_skill")
tt.hero.skills.spikedarmor.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.spikedarmor.hr_icon = 2
tt.hero.skills.spikedarmor.hr_order = 2
tt.hero.skills.spikedarmor.values = {
	0.1,
	0.3,
	0.6
}
tt.hero.skills.swordsmanship = E.clone_c(E, "hero_skill")
tt.hero.skills.swordsmanship.extra_damage = {
	2,
	6,
	12
}
tt.hero.skills.swordsmanship.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.swordsmanship.hr_icon = 1
tt.hero.skills.swordsmanship.hr_order = 1
tt.hero.skills.toughness = E.clone_c(E, "hero_skill")
tt.hero.skills.toughness.hp_max = {
	30,
	90,
	180
}
tt.hero.skills.toughness.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.toughness.hr_icon = 3
tt.hero.skills.toughness.hr_order = 3
tt.hero.skills.toughness.regen = {
	6,
	18,
	36
}
tt.health.armor = nil
tt.health.dead_lifetime = 20
tt.health.hp_max = nil
tt.health.spiked_armor = 0
tt.health_bar.offset = v(0, ady(44))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_alric.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_alric.get_info
tt.info.hero_portrait = "hero_portraits_0001"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0001") or "info_portraits_heroes_0001"
tt.main_script.insert = scripts3.hero_alric.insert
tt.main_script.update = scripts3.hero_alric.update
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.95
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[3] = E.clone_c(E, "melee_attack")
tt.melee.attacks[3].animations = {
	"flurry_start",
	"flurry_loop",
	"flurry_end"
}
tt.melee.attacks[3].cooldown = 6
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_times = {
	fts(4),
	fts(9)
}
tt.melee.attacks[3].interrupt_loop_on_dead_target = true
tt.melee.attacks[3].loopable = true
tt.melee.attacks[3].loops = 1
tt.melee.attacks[3].sound_loop = "HeroAlricFlurry"
tt.melee.attacks[3].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.attacks[3].xp_from_skill = "flurry"
tt.melee.cooldown = 1
tt.melee.range = 83.2
tt.motion.max_speed = 66
tt.regen.cooldown = 1
tt.regen.health = tt.hero.level_stats.regen_health[1]
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_alric"
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HeroAlricTaunt"
tt.sound_events.death = "HeroAlricDeath"
tt.sound_events.respawn = "HeroAlricTauntIntro"
tt.sound_events.insert = "HeroAlricTauntIntro"
tt.sound_events.hero_room_select = "HeroAlricTauntSelect"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animation = "sandwarrior"
tt.timed_attacks.list[1].cooldown = 10
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_sand_warrior"
tt.timed_attacks.list[1].range_nodes = 40
tt.timed_attacks.list[1].spawn_time = fts(10)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.timed_attacks.list[1].vis_flags = 0
tt.timed_attacks.list[1].sound = "HeroAlricSandwarrior"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -1)
tt.unit.mod_offset = v(0, 19.9)
tt = E.register_t(E, "hero_alric2", "hero_alric")
tt.hero.level = 10
tt.hero.skills.toughness.level = 3
tt.hero.skills.swordsmanship.level = 3
tt.hero.skills.spikedarmor.level = 3
tt.hero.skills.sandwarriors.level = 3
tt.hero.skills.flurry.level = 3
tt = E.register_t(E, "hero_giant", "hero")

E.add_comps(E, tt, "auras", "melee", "ranged", "timed_attacks")

anchor_y = 0.19117647058823528
image_y = 88
tt.hero.level_stats.hp_max = {
	330,
	360,
	390,
	420,
	450,
	480,
	510,
	540,
	570,
	600
}
tt.hero.level_stats.regen_health = {
	17,
	18,
	20,
	21,
	23,
	24,
	26,
	27,
	29,
	30
}
tt.hero.level_stats.armor = {
	0.23,
	0.26,
	0.29,
	0.32,
	0.35,
	0.38,
	0.41,
	0.44,
	0.47,
	0.5
}
tt.hero.level_stats.melee_damage_min = {
	10,
	12,
	14,
	15,
	17,
	18,
	20,
	21,
	23,
	24
}
tt.hero.level_stats.melee_damage_max = {
	16,
	18,
	20,
	23,
	25,
	27,
	30,
	32,
	34,
	37
}
tt.hero.skills.boulderthrow = E.clone_c(E, "hero_skill")
tt.hero.skills.boulderthrow.damage_min = {
	20,
	40,
	60
}
tt.hero.skills.boulderthrow.damage_max = {
	40,
	60,
	100
}
tt.hero.skills.stomp = E.clone_c(E, "hero_skill")
tt.hero.skills.stomp.damage = {
	12,
	14,
	16
}
tt.hero.skills.stomp.loops = {
	2,
	3,
	4
}
tt.hero.skills.stomp.stun_duration = {
	2,
	3,
	4
}
tt.hero.skills.stomp.xp_gain_factor = 40
tt.hero.skills.bastion = E.clone_c(E, "hero_skill")
tt.hero.skills.bastion.damage_per_tick = {
	2,
	3,
	3
}
tt.hero.skills.bastion.max_damage = {
	6,
	12,
	18
}
tt.hero.skills.massivedamage = E.clone_c(E, "hero_skill")
tt.hero.skills.massivedamage.chance = {
	0.1,
	0.2,
	0.3
}
tt.hero.skills.massivedamage.extra_damage = {
	60,
	120,
	180
}
tt.hero.skills.massivedamage.health_factor = 3
tt.hero.skills.massivedamage.xp_gain_factor = 70
tt.hero.skills.hardrock = E.clone_c(E, "hero_skill")
tt.hero.skills.hardrock.extra_hp = {
	50,
	150,
	300
}
tt.hero.skills.boulderthrow.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.boulderthrow.hr_icon = 27
tt.hero.skills.boulderthrow.hr_order = 1
tt.hero.skills.stomp.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.stomp.hr_icon = 28
tt.hero.skills.stomp.hr_order = 2
tt.hero.skills.bastion.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.bastion.hr_icon = 29
tt.hero.skills.bastion.hr_order = 3
tt.hero.skills.massivedamage.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.massivedamage.hr_icon = 26
tt.hero.skills.massivedamage.hr_order = 4
tt.hero.skills.hardrock.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.hardrock.hr_icon = 30
tt.hero.skills.hardrock.hr_order = 5
tt.hero.level = 10
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].disabled = true
tt.auras.list[1].name = "aura_giant_bastion"
tt.health.armor = tt.hero.level_stats.armor[1]
tt.health.dead_lifetime = 25
tt.health.hp_max = tt.hero.level_stats.hp_max[1]
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_giant.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_giant.get_info
tt.info.hero_portrait = "hero_portraits_0108"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0008") or "info_portraits_heroes_0008"
tt.main_script.insert = scripts3.hero_giant.insert
tt.main_script.update = scripts3.hero_giant.update
tt.motion.max_speed = 48
tt.regen.cooldown = 1
tt.regen.health = tt.hero.level_stats.regen_health[1]
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_giant"
tt.soldier.melee_slot_offset.x = 18
tt.sound_events.change_rally_point = "HeroGiantTaunt"
tt.sound_events.death = "HeroGiantDeath"
tt.sound_events.respawn = "HeroGiantTauntIntro"
tt.sound_events.insert = "HeroGiantTauntIntro"
tt.sound_events.hero_room_select = "HeroGiantTauntSelect"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-35, -15, 70, 70)) or r(-25, 0, 50, 45)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0.28)
tt.unit.mod_offset = v(0, 23)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(tt.vis.bans, F_POISON)
tt.melee.range = 70.4
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].damage_max = 333
tt.melee.attacks[1].damage_min = 333
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].cooldown = 1.3
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.85
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].animation = "massive"
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].cooldown = 12
tt.melee.attacks[2].mod = "mod_giant_massivedamage"
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.attacks[2].xp_from_skill = "massivedamage"
tt.melee.attacks[2].sound = "HeroGiantMassiveDamage"
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].bullet = "giant_boulder"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 77)
}
tt.ranged.attacks[1].cooldown = 13
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 300
tt.ranged.attacks[1].min_range = 100
tt.ranged.attacks[1].shoot_time = fts(20)
tt.ranged.attacks[1].vis_bans = bor(F_FLYING)
tt.ranged.attacks[1].sound = "HeroGiantBoulder"
tt.ranged.attacks[1].node_prediction = fts(40)
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "stomp"
tt.timed_attacks.list[1].cooldown = 14
tt.timed_attacks.list[1].damage = nil
tt.timed_attacks.list[1].damage_bans = bor(F_FLYING)
tt.timed_attacks.list[1].damage_flags = bor(F_AREA)
tt.timed_attacks.list[1].damage_radius = 150
tt.timed_attacks.list[1].damage_type = DAMAGE_PHYSICAL
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_times = {
	fts(4),
	fts(12)
}
tt.timed_attacks.list[1].loops = 333
tt.timed_attacks.list[1].max_range = 76.8
tt.timed_attacks.list[1].stun_chance = 0.5
tt.timed_attacks.list[1].trigger_min_enemies = 2
tt.timed_attacks.list[1].trigger_min_hp = 100
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1].stun_vis_flags = F_STUN
tt.timed_attacks.list[1].stun_vis_bans = bor(F_CLIFF, F_BOSS, F_FLYING)
tt = E.register_t(E, "hero_giant2", "hero_giant")
tt.hero.skills.boulderthrow.level = 3
tt.hero.skills.bastion.level = 3
tt.hero.skills.massivedamage.level = 3
tt.hero.skills.hardrock.level = 3
tt.hero.skills.stomp.level = 3
tt = E.register_t(E, "giant_death_remains", "decal_tween")
tt.render.sprites[1].name = "hero_giant_death_remains"
tt.render.sprites[1].anchor.y = 0.19117647058823528
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "hero_giant_death_rocks"
tt.render.sprites[2].anchor.y = 0.19117647058823528
tt.render.sprites[2].time_offset = -fts(12)
tt.tween.remove = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(12),
		0
	},
	{
		fts(26),
		255
	},
	{
		fts(45),
		255
	},
	{
		fts(60),
		0
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		fts(12),
		0
	},
	{
		fts(13),
		255
	},
	{
		fts(25),
		0
	},
	{
		fts(27),
		0
	}
}
tt.tween.props[2].sprite_id = 2
tt = E.register_t(E, "aura_giant_bastion", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.duration = -1
tt.aura.track_source = true
tt.main_script.update = scripts3.aura_giant_bastion.update
tt.render.sprites[1].name = "giant_bastion_decal"
tt.render.sprites[1].loop = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].scale = v(0, 0)
tt.render.sprites[1].anchor.y = 0.19117647058823528
tt.max_distance = 100
tt.tick_time = 5
tt.damage_per_tick = 333
tt.max_damage = 333
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt = E.register_t(E, "mod_giant_massivedamage", "modifier")

E.add_comps(E, tt, "render", "tween")

tt.instakill_chance = 333
tt.instakill_min_hp = 333
tt.damage_min = 333
tt.damage_max = 333
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].name = "giant_ice"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].size_anchors_y = {
	0.19,
	0.22,
	0.22
}
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(12),
		255
	},
	{
		fts(12) + 0.25,
		0
	}
}
tt.tween.remove = true
tt.main_script.insert = scripts3.mod_giant_massivedamage.insert
tt = E.register_t(E, "mod_giant_slow", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = 0.5
tt = E.register_t(E, "mod_giant_stun", "mod_shock_and_awe")
tt.modifier.duration = 555
tt = E.register_t(E, "giant_stomp_decal", "decal_timed")
tt.render.sprites[1].name = "giant_stomp_stones"
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "giant_boulder", "bomb")
tt.bullet.damage_min = 999
tt.bullet.damage_max = 999
tt.bullet.damage_radius = 86.4
tt.bullet.flight_time = fts(20)
tt.bullet.g = (fts(1)*fts(1))/-1.5
tt.bullet.hit_fx = "fx_giant_boulder_explosion"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.hit_fx_sort_y_offset = nil
tt.sound_events.hit = "HeroGiantExplosionRock"
tt.sound_events.hit_water = "RTWaterExplosion"
tt.sound_events.insert = nil
tt.render.sprites[1].name = "hero_giant_proy_0001"
tt.main_script.insert = scripts3.giant_boulder.insert
tt = E.register_t(E, "fx_giant_boulder_explosion", "fx")
tt.render.sprites[1].name = "giant_boulder_explosion"
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "hero_alien", "hero")

E.add_comps(E, tt, "melee", "ranged", "selfdestruct", "timed_attacks")

anchor_y = 0.31
image_y = 112
tt.hero.level_stats.hp_max = {
	220,
	240,
	260,
	280,
	300,
	320,
	340,
	360,
	380,
	400
}
tt.hero.level_stats.regen_health = {
	18,
	20,
	22,
	23,
	25,
	27,
	28,
	30,
	32,
	33
}
tt.hero.level_stats.armor = {
	0.13,
	0.16,
	0.19,
	0.22,
	0.25,
	0.28,
	0.31,
	0.34,
	0.37,
	0.4
}
tt.hero.level_stats.melee_damage_min = {
	8,
	10,
	11,
	13,
	14,
	16,
	18,
	19,
	21,
	22
}
tt.hero.level_stats.melee_damage_max = {
	12,
	14,
	17,
	19,
	22,
	24,
	26,
	29,
	31,
	34
}
tt.hero.skills.energyglaive = E.clone_c(E, "hero_skill")
tt.hero.skills.energyglaive.damage = {
	22,
	30,
	35
}
tt.hero.skills.energyglaive.bounce_chance = {
	0.3,
	0.4,
	0.5
}
tt.hero.skills.purificationprotocol = E.clone_c(E, "hero_skill")
tt.hero.skills.purificationprotocol.duration = {
	1,
	2,
	3
}
tt.hero.skills.abduction = E.clone_c(E, "hero_skill")
tt.hero.skills.abduction.total_targets = {
	1,
	2,
	3
}
tt.hero.skills.abduction.total_hp = {
	250,
	600,
	1000
}
tt.hero.skills.vibroblades = E.clone_c(E, "hero_skill")
tt.hero.skills.vibroblades.extra_damage = {
	5,
	10,
	15
}
tt.hero.skills.vibroblades.damage_type = DAMAGE_TRUE
tt.hero.skills.finalcountdown = E.clone_c(E, "hero_skill")
tt.hero.skills.finalcountdown.damage = {
	100,
	160,
	220
}
tt.hero.skills.energyglaive.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.energyglaive.hr_icon = 38
tt.hero.skills.energyglaive.hr_order = 1
tt.hero.skills.purificationprotocol.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.purificationprotocol.hr_icon = 36
tt.hero.skills.purificationprotocol.hr_order = 2
tt.hero.skills.abduction.hr_cost = {
	3,
	4,
	4
}
tt.hero.skills.abduction.hr_icon = 37
tt.hero.skills.abduction.hr_order = 3
tt.hero.skills.vibroblades.hr_cost = {
	2,
	1,
	1
}
tt.hero.skills.vibroblades.hr_icon = 40
tt.hero.skills.vibroblades.hr_order = 4
tt.hero.skills.finalcountdown.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.finalcountdown.hr_icon = 39
tt.hero.skills.finalcountdown.hr_order = 5
tt.health.armor = 333333333333
tt.health.dead_lifetime = 25
tt.health.hp_max = 333333333
tt.hero.level = 10
tt.health_bar.offset = v(0, 41)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_alien.level_up
tt.hero.tombstone_show_time = fts(66)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_alien.get_info
tt.info.hero_portrait = "hero_portraits_0107"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0007") or "info_portraits_heroes_0007"
tt.main_script.insert = scripts3.hero_alien.insert
tt.main_script.update = scripts3.hero_alien.update
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_alien"
tt.soldier.melee_slot_offset.x = 13
tt.sound_events.change_rally_point = "HeroAlienTaunt"
tt.sound_events.death = "HeroAlienDeath"
tt.sound_events.respawn = "HeroAlienTauntIntro"
tt.sound_events.insert = "HeroAlienTauntIntro"
tt.sound_events.hero_room_select = "HeroAlienTauntSelect"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15.28)
tt.melee.range = 75
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.9
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].bullet = "alien_glaive"
tt.ranged.attacks[1].cooldown = fts(28) + 6
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 125
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(22, 16)
}
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].animation = "abduction"
tt.timed_attacks.list[1].cooldown = 25
tt.timed_attacks.list[1].entity = "alien_abduction_ship"
tt.timed_attacks.list[1].range = 200
tt.timed_attacks.list[1].attack_radius = 33
tt.timed_attacks.list[1].spawn_time = fts(10)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER, F_BOSS)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].sound = "HeroAlienAbduction"
tt.timed_attacks.list[1].invalid_templates = {
	"enemy_spider_tiny",
	"enemy_sheep_ground",
	"enemy_sheep_fly"
}
tt.timed_attacks.list[1].total_health = nil
tt.timed_attacks.list[1].total_targets = nil
tt.timed_attacks.list[2] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].animation = "purification"
tt.timed_attacks.list[2].cooldown = 16
tt.timed_attacks.list[2].entity = "alien_purification_drone"
tt.timed_attacks.list[2].range = 125
tt.timed_attacks.list[2].spawn_time = fts(34)
tt.timed_attacks.list[2].vis_bans = bor(F_BOSS)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].invalid_templates = {
	"enemy_spider_tiny",
	"enemy_sheep_ground",
	"enemy_sheep_fly"
}
tt.timed_attacks.list[2].total_health = nil
tt.timed_attacks.list[2].total_targets = nil
tt.selfdestruct.damage = nil
tt.selfdestruct.damage_radius = 75
tt.selfdestruct.damage_type = DAMAGE_TRUE
tt.selfdestruct.disabled = true
tt.selfdestruct.hit_time = fts(48)
tt.selfdestruct.sound_hit = "HeroAlienExplosion"
tt = E.register_t(E, "hero_alien2", "hero_alien")
tt.hero.skills.energyglaive.level = 3
tt.hero.skills.purificationprotocol.level = 3
tt.hero.skills.abduction.level = 3
tt.hero.skills.vibroblades.level = 3
tt.hero.skills.finalcountdown.level = 3
tt = E.register_t(E, "alien_glaive", "bullet")
tt.main_script.update = scripts3.alien_glaive.update
tt.render.sprites[1].name = "alien_glaive"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.particles_name = "ps_alien_glaive_trail"
tt.bullet.hit_fx = "fx_alien_glaive_hit"
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 150
tt.bullet.max_speed = 300
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.xp_gain_factor = 0.9
tt.bounce_chance = 3333333333
tt.bounce_range = 150
tt.sound_events.insert = "HeroAlienDiscoThrow"
tt = E.register_t(E, "fx_alien_glaive_hit", "fx")
tt.render.sprites[1].name = "alien_glaive_hit"
tt = E.register_t(E, "ps_alien_glaive_trail")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "alien_glaive_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(12),
	fts(12)
}
tt.particle_system.scales_x = {
	1.5,
	1.5
}
tt.particle_system.scales_y = {
	1.5,
	0.5
}
tt.particle_system.emission_rate = 40
tt.particle_system.track_rotation = true
tt = E.register_t(E, "alien_abduction_ship", "decal_scripted")

E.add_comps(E, tt, "sound_events", "tween")

tt.main_script.update = scripts3.alien_abduction_ship.update
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].anchor.y = 0.12
tt.render.sprites[1].name = "hero_alien_motherShip_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].draw_order = 3
tt.render.sprites[2].name = "hero_alien_motherShip_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor.y = 0.12
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].draw_order = 1
tt.render.sprites[3].hidden = true
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "alien_abduction_ship_beam"
tt.render.sprites[3].anchor.y = 0.12
tt.render.sprites[3].offset.y = 20
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].z = Z_DECALS
tt.render.sprites[4].name = "hero_alien_motherShip_0003"
tt.render.sprites[4].animated = false
tt.render.sprites[4].anchor.y = 0.12
tt.tween.remove = true
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].loop = true
tt.tween.props[1].interp = "sine"
tt.tween.props[1].name = "offset"
tt.tween.props[1].keys = {
	{
		0,
		v(0, -4)
	},
	{
		0.5,
		v(0, 4)
	},
	{
		1,
		v(0, -4)
	}
}
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].sprite_id = 1
tt.tween.props[3].name = "hidden"
tt.tween.props[4] = E.clone_c(E, "tween_prop")
tt.tween.props[4].sprite_id = 2
tt.tween.props[5] = E.clone_c(E, "tween_prop")
tt.tween.props[5].sprite_id = 4
local fd = 0.65
local ad = fts(34)
local ti1 = 0
local ti2 = fd
local ti3 = fd*2
local to1 = ti3 + ad
local to2 = ti3 + ad + fd
local to3 = ti3 + ad + fd*2
tt.tween.props[3].keys = {
	{
		ti1,
		true
	},
	{
		ti2,
		false
	},
	{
		to2,
		true
	}
}
tt.tween.props[4].keys = {
	{
		ti1,
		0
	},
	{
		ti2,
		255
	},
	{
		ti3,
		0
	},
	{
		to1,
		0
	},
	{
		to2,
		255
	},
	{
		to3,
		0
	}
}
tt.tween.props[5].keys = {
	{
		ti1,
		0
	},
	{
		ti2,
		255
	},
	{
		to2,
		255
	},
	{
		to3,
		0
	}
}
local ox = 100
local oy = 28
local rays = {
	{
		v(ox - 47, oy - 152),
		fts(0),
		"1"
	},
	{
		v(ox - 106, oy - 175),
		fts(5),
		"1"
	},
	{
		v(ox - 49, oy - 170),
		fts(10),
		"1"
	},
	{
		v(ox - 84, oy - 146),
		fts(10),
		"2"
	},
	{
		v(ox - 142, oy - 157),
		fts(15),
		"2"
	},
	{
		v(ox - 58, oy - 181),
		fts(20),
		"2"
	}
}

for _, r in pairs(rays) do
	local poff, tdel, name = unpack(r)
	local s = E.clone_c(E, "sprite")
	s.loop = true
	s.animated = true
	s.prefix = "alien_abduction_ship_lightning"
	s.name = name
	s.z = Z_BULLETS

	table.insert(tt.render.sprites, s)

	local t = E.clone_c(E, "tween_prop")
	t.keys = {
		{
			ti1,
			0
		},
		{
			ti1 + tdel,
			0
		},
		{
			ti1 + tdel + 0.2,
			255
		},
		{
			ti1 + tdel + 0.45,
			255
		},
		{
			ti1 + tdel + 0.65,
			0
		},
		{
			to1,
			0
		},
		{
			to1 + tdel,
			0
		},
		{
			to1 + tdel + 0.2,
			255
		},
		{
			to1 + tdel + 0.45,
			255
		},
		{
			to1 + tdel + 0.65,
			0
		}
	}
	t.sprite_id = #tt.render.sprites

	table.insert(tt.tween.props, t)

	local tb = table.deepclone(tt.tween.props[1])
	tb.keys = {
		{
			0,
			v(poff.x, poff.y - 4)
		},
		{
			0.5,
			v(poff.x, poff.y + 4)
		},
		{
			1,
			v(poff.x, poff.y - 4)
		}
	}
	tb.sprite_id = #tt.render.sprites

	table.insert(tt.tween.props, tb)
end

tt = E.register_t(E, "abducted_enemy_decal", "decal_tween")
tt.tween.disabled = true
tt.tween.remove = true
tt.tween.props[1].keys = {
	{
		0,
		200
	},
	{
		0.25,
		178
	},
	{
		0.55,
		0
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].keys = {
	{
		0,
		v(0, 0)
	},
	{
		"U.frandom(0.1,0.2)",
		v(0, 10)
	},
	{
		0.55,
		v(0, 60)
	}
}
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "r"
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		0.55,
		"math.random(-20,20)*math.pi/180"
	}
}
tt = E.register_t(E, "alien_purification_drone", "decal_scripted")

E.add_comps(E, tt, "sound_events", "dps")

tt.render.sprites[1].name = "alien_drone_attack_beam"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].anchor.y = 0.08
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "alien_drone"
tt.render.sprites[2].name = "appear_long"
tt.render.sprites[2].anchor.y = 0.08
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "alien_drone_attack_decal"
tt.render.sprites[3].hidden = true
tt.render.sprites[3].anchor.y = 0.17
tt.sound_events.insert = "HeroAlienDrone"
tt.sound_events.finish = "HeroAlienDroneLeave"
tt.sound_events.loop = "HeroAlienDroneLoop"
tt.main_script.update = scripts3.alien_purification_drone.update
tt.dps.damage_max = 16
tt.dps.damage_every = fts(6)
tt.dps.damage_type = DAMAGE_TRUE
tt.jump_range = 150
tt.switch_targets_every = fts(31)
tt.vis_bans = bor(F_BOSS)
tt.vis_flags = bor(F_RANGED)
tt.duration = 33333333333
tt = E.register_t(E, "hero_van_helsing", "hero")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks")

image_y = 98
anchor_y = 0.26
tt.hero.level_stats.hp_max = {
	275,
	300,
	325,
	350,
	375,
	400,
	425,
	450,
	475,
	500
}
tt.hero.level_stats.regen_health = {
	23,
	25,
	28,
	30,
	33,
	35,
	38,
	40,
	43,
	45
}
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.damage_min = {
	13,
	17,
	20,
	24,
	28,
	31,
	35,
	38,
	42,
	46
}
tt.hero.level_stats.damage_max = {
	20,
	25,
	31,
	36,
	41,
	47,
	52,
	58,
	63,
	68
}
tt.hero.level_stats.ranged_damage_min = {
	13,
	17,
	20,
	24,
	28,
	31,
	35,
	38,
	42,
	46
}
tt.hero.level_stats.ranged_damage_max = {
	20,
	25,
	31,
	36,
	41,
	47,
	52,
	58,
	63,
	68
}
tt.hero.skills.multishoot = E.clone_c(E, "hero_skill")
tt.hero.skills.multishoot.loops = {
	4,
	6,
	8
}
tt.hero.skills.multishoot.xp_gain_factor = 30
tt.hero.skills.silverbullet = E.clone_c(E, "hero_skill")
tt.hero.skills.silverbullet.damage = {
	140,
	230,
	320
}
tt.hero.skills.silverbullet.xp_gain_factor = 50
tt.hero.skills.holygrenade = E.clone_c(E, "hero_skill")
tt.hero.skills.holygrenade.silence_duration = {
	5,
	10,
	15
}
tt.hero.skills.holygrenade.xp_gain_factor = 150
tt.hero.skills.relicofpower = E.clone_c(E, "hero_skill")
tt.hero.skills.relicofpower.armor_reduce_factor = {
	0.25,
	0.5,
	1
}
tt.hero.skills.relicofpower.xp_gain_factor = 150
tt.hero.skills.beaconoflight = E.clone_c(E, "hero_skill")
tt.hero.skills.beaconoflight.inflicted_damage_factor = {
	1.25,
	1.35,
	1.5
}
tt.hero.skills.multishoot.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.multishoot.hr_icon = 56
tt.hero.skills.multishoot.hr_order = 1
tt.hero.skills.silverbullet.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.silverbullet.hr_icon = 57
tt.hero.skills.silverbullet.hr_order = 2
tt.hero.skills.holygrenade.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.holygrenade.hr_icon = 58
tt.hero.skills.holygrenade.hr_order = 3
tt.hero.skills.relicofpower.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.relicofpower.hr_icon = 59
tt.hero.skills.relicofpower.hr_order = 4
tt.hero.skills.beaconoflight.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.beaconoflight.hr_icon = 60
tt.hero.skills.beaconoflight.hr_order = 5
tt.hero.level = 10
tt.health.armor = 33333
tt.health.dead_lifetime = 15
tt.health.hp_max = 33333333
tt.health_bar.offset = v(0, 39)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_van_helsing.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 10
tt.info.fn = scripts3.hero_van_helsing.get_info
tt.info.hero_portrait = "hero_portraits_0114"
tt.info.hero_portrait_alive = "hero_portraits_0114"
tt.info.hero_portrait_dead = "hero_portraits_0115"
tt.info.hero_portrait_always_on = nil
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0017") or "info_portraits_heroes_0016"
tt.info.portrait_alive = (IS_PHONE_OR_TABLET and "portraits_hero_0017") or "info_portraits_heroes_0016"
tt.info.portrait_dead = (IS_PHONE_OR_TABLET and "portraits_hero_0018") or "info_portraits_heroes_0023"
tt.main_script.insert = scripts3.hero_van_helsing.insert
tt.main_script.update = scripts3.hero_van_helsing.update
tt.motion.max_speed = 90
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_vanhelsing"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	ranged = {
		"ranged_side",
		"ranged_up",
		"ranged_down"
	},
	multi_start = {
		"multi_start_side",
		"multi_start_up",
		"multi_start_down"
	},
	multi_loop = {
		"multi_loop_side",
		"multi_loop_up",
		"multi_loop_down"
	},
	multi_end = {
		"multi_end_side",
		"multi_end_up",
		"multi_end_down"
	},
	silverbullet = {
		"silver_side",
		"silver_up",
		"silver_down"
	}
}
tt.render.sprites[1].angles_custom = {
	silverbullet = {
		35,
		145,
		210,
		335
	}
}
tt.render.sprites[1].angles_flip_vertical = {
	silverbullet = true,
	multi_start = true,
	multi_loop = true,
	ranged = true,
	multi_end = true
}
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroVanHelsingTaunt"
tt.sound_events.death = "HeroVanHelsingDeath"
tt.sound_events.respawn = "HeroVanHelsingTauntIntro"
tt.sound_events.insert = "HeroVanHelsingTauntIntro"
tt.sound_events.hero_room_select = "HeroVanHelsingTauntSelect"
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.melee.range = 51.2
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].cooldown = fts(23) - 1.5 + fts(9)
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.6
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].animation = "relic"
tt.melee.attacks[2].cooldown = 20
tt.melee.attacks[2].mod = "mod_van_helsing_relic"
tt.melee.attacks[2].xp_from_skill = "relicofpower"
tt.melee.attacks[2].sound = "HeroVanHelsingRelic"
tt.melee.attacks[2].hit_time = fts(13)
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.melee.attacks[2].fn_can = scripts3.hero_van_helsing.can_relic
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].bullet = "van_helsing_shotgun"
tt.ranged.attacks[1].bullet_start_offset = {
	v(24, ady(44)),
	v(18, ady(68)),
	v(16, ady(26))
}
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(8)
tt.ranged.attacks[1].cooldown = 1.5
tt.timed_attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].animations = {
	"multi_start",
	"multi_loop",
	"multi_end"
}
tt.timed_attacks.list[1].bullet = "van_helsing_shotgun"
tt.timed_attacks.list[1].bullet_start_offset = tt.ranged.attacks[1].bullet_start_offset
tt.timed_attacks.list[1].shoot_time = fts(39)
tt.timed_attacks.list[1].loops = 3333
tt.timed_attacks.list[1].max_range = 140
tt.timed_attacks.list[1].min_range = 50
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].search_range = 75
tt.timed_attacks.list[1].search_min_count = 2
tt.timed_attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].animation = "silverbullet"
tt.timed_attacks.list[2].bullet = "van_helsing_silverbullet"
tt.timed_attacks.list[2].bullet_start_offset = {
	v(24, ady(42)),
	v(22, ady(62)),
	v(12, ady(22))
}
tt.timed_attacks.list[2].crosshair_time = fts(12)
tt.timed_attacks.list[2].crosshair_name = "mod_van_helsing_crosshair"
tt.timed_attacks.list[2].shoot_time = fts(23)
tt.timed_attacks.list[2].loops = nil
tt.timed_attacks.list[2].max_range = 210
tt.timed_attacks.list[2].min_range = 50
tt.timed_attacks.list[2].cooldown = 12
tt.timed_attacks.list[2].nodes_to_defend = 20
tt.timed_attacks.list[2].werewolf_damage_factor = 2
tt.timed_attacks.list[2].filter_damage_factor = 2
tt.timed_attacks.list[2].avg_dmg = 0
tt.timed_attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].animation = "grenade"
tt.timed_attacks.list[3].bullet = "van_helsing_grenade"
tt.timed_attacks.list[3].bullet_start_offset = {
	v(16, ady(54))
}
tt.timed_attacks.list[3].shoot_time = fts(16)
tt.timed_attacks.list[3].max_range = 150
tt.timed_attacks.list[3].min_range = 50
tt.timed_attacks.list[3].cooldown = 15
tt = E.register_t(E, "hero_van_helsing2", "hero_van_helsing")
tt.hero.skills.beaconoflight.level = 3
tt.hero.skills.relicofpower.level = 3
tt.hero.skills.holygrenade.level = 3
tt.hero.skills.silverbullet.level = 3
tt.hero.skills.multishoot.level = 3
tt = E.register_t(E, "van_helsing_shotgun", "shotgun")
tt.bullet.damage_min = 40
tt.bullet.damage_max = 40
tt.bullet.min_speed = FPS*40
tt.bullet.max_speed = FPS*40
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.miss_fx_water = "fx_splash_small"
tt.sound_events.insert = "ShotgunSound"
tt.bullet.xp_gain_factor = 0.6
tt.bullet.pop = nil
tt = E.register_t(E, "van_helsing_silverbullet", "van_helsing_shotgun")
tt.bullet.damage_type = bor(DAMAGE_TRUE, DAMAGE_FX_EXPLODE)
tt.bullet.damage_max = 3333
tt.bullet.damage_min = 333
tt.sound_events.insert = "SniperSound"
tt.bullet.xp_gain_factor = nil
tt = E.register_t(E, "mod_van_helsing_crosshair", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].name = "vanhelsing_crosshair"
tt.render.sprites[1].sort_y_offset = -2
tt.main_script.update = scripts3.mod_track_target.update
tt.modifier.duration = fts(16)
tt = E.register_t(E, "van_helsing_grenade", "bullet")
tt.bullet.damage_radius = 80
tt.bullet.flight_time = fts(25)
tt.bullet.hide_radius = 4
tt.bullet.hit_fx = "van_helsing_grenade_explosion"
tt.bullet.mod = "mod_van_helsing_silence"
tt.bullet.rotation_speed = (FPS*20*math.pi)/180
tt.main_script.insert = scripts3.bomb.insert
tt.main_script.update = scripts3.van_helsing_grenade.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "Halloween_hero_vhelsing_water"
tt = E.register_t(E, "mod_van_helsing_silence", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = nil
tt.modifier.bans = {
	 "mod_demon_shield",
  "mod_shaman_heal",
  "mod_spectral_knight"
}
tt.modifier.remove_banned = true
tt.main_script.insert = scripts3.mod_silence.insert
tt.main_script.remove = scripts3.mod_silence.remove
tt.main_script.update = scripts3.mod_track_target.update
tt.render.sprites[1].prefix = "vanhelsing_silence"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = true
tt.render.sprites[1].sort_y_offset = -2
tt = E.register_t(E, "van_helsing_grenade_explosion", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].name = "vanhelsing_grenade_explosion"
tt.render.sprites[1].sort_y_offset = -4
tt.render.sprites[1].anchor.y = 0.25
tt.render.sprites[1].z = Z_OBJECTS
tt.sound_events.insert = "HeroVanHelsingHolyWater"
tt = E.register_t(E, "mod_van_helsing_relic", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].name = "vanhelsing_relic"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].anchor.y = 0
tt.main_script.update = scripts3.mod_van_helsing_relic.update
tt.armor_reduce_factor = 3333333
tt.remove_mods = {
	 "mod_demon_shield",
  "mod_shaman_heal",
  "mod_spectral_knight"
}
tt = E.register_t(E, "van_helsing_beacon_aura", "aura")
tt.aura.mod = "mod_van_helsing_beacon"
tt.aura.cycle_time = 0.5
tt.aura.duration = -1
tt.aura.radius = 150
tt.aura.track_source = true
tt.aura.track_dead = true
tt.aura.filter_source = true
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt = E.register_t(E, "mod_van_helsing_beacon", "modifier")

E.add_comps(E, tt, "render")

tt.inflicted_damage_factor = nil
tt.main_script.insert = scripts3.mod_van_helsing_beacon.insert
tt.main_script.remove = scripts3.mod_van_helsing_beacon.remove
tt.main_script.update = scripts3.mod_track_target.update
tt.modifier.duration = 1
tt.modifier.use_mod_offset = false
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "Halloween_hero_vhelsing_buffeffect"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "hero_crab", "hero")

E.add_comps(E, tt, "water", "melee", "ranged", "timed_attacks", "auras")

anchor_y = 0.31
image_y = 74
tt.hero.level_stats.hp_max = {
	320,
	340,
	360,
	380,
	400,
	420,
	440,
	460,
	480,
	1200
}
tt.hero.level_stats.regen_health = {
	16,
	17,
	18,
	19,
	20,
	21,
	22,
	23,
	24,
	175
}
tt.hero.level_stats.armor = {
	0.17,
	0.19,
	0.21,
	0.23,
	0.25,
	0.27,
	0.29,
	0.31,
	0.33,
	0.7
}
tt.hero.level_stats.melee_damage_min = {
	6,
	7,
	8,
	9,
	10,
	11,
	11,
	12,
	13,
	30
}
tt.hero.level_stats.melee_damage_max = {
	18,
	21,
	23,
	26,
	29,
	32,
	34,
	37,
	40,
	50
}
tt.hero.skills.hookedclaw = E.clone_c(E, "hero_skill")
tt.hero.skills.hookedclaw.extra_damage = {
	5,
	10,
	0
}
tt.hero.skills.battlehardened = E.clone_c(E, "hero_skill")
tt.hero.skills.battlehardened.chance = {
	0.35,
	0.5,
	0.65
}
tt.hero.skills.battlehardened.xp_gain_factor = 100
tt.hero.skills.pincerattack = E.clone_c(E, "hero_skill")
tt.hero.skills.pincerattack.damage_min = {
	15,
	25,
	50
}
tt.hero.skills.pincerattack.damage_max = {
	25,
	75,
	100
}
tt.hero.skills.pincerattack.xp_gain_factor = 80
tt.hero.skills.shouldercannon = E.clone_c(E, "hero_skill")
tt.hero.skills.shouldercannon.damage = {
	30,
	45,
	70
}
tt.hero.skills.shouldercannon.slow_factor = {
	0.6,
	0.5,
	0.4
}
tt.hero.skills.shouldercannon.slow_duration = {
	4,
	5,
	8
}
tt.hero.skills.shouldercannon.xp_gain_factor = 30
tt.hero.skills.burrow = E.clone_c(E, "hero_skill")
tt.hero.skills.burrow.range = {
	100,
	110,
	120
}
tt.hero.skills.burrow.extra_speed = {
	33,
	54,
	87
}
tt.hero.skills.burrow.damage_radius = {
	100,
	110,
	120
}
tt.hero.skills.hookedclaw.hr_cost = {
	2,
	2,
	3
}
tt.hero.skills.hookedclaw.hr_icon = 46
tt.hero.skills.hookedclaw.hr_order = 1
tt.hero.skills.battlehardened.hr_cost = {
	2,
	1,
	1
}
tt.hero.skills.battlehardened.hr_icon = 47
tt.hero.skills.battlehardened.hr_order = 2
tt.hero.skills.pincerattack.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.pincerattack.hr_icon = 48
tt.hero.skills.pincerattack.hr_order = 3
tt.hero.skills.shouldercannon.hr_cost = {
	2,
	2,
	3
}
tt.hero.skills.shouldercannon.hr_icon = 49
tt.hero.skills.shouldercannon.hr_order = 4
tt.hero.skills.burrow.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.burrow.hr_icon = 50
tt.hero.skills.burrow.hr_order = 5
tt.health.armor = nil
tt.health.dead_lifetime = 20
tt.health.hp_max = nil
tt.health.on_damage = scripts3.hero_crab.on_damage
tt.health_bar.offset = v(0, ady(72))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_crab.level_up
tt.hero.tombstone_show_time = fts(66)
tt.idle_flip.cooldown = 5
tt.info.fn = scripts3.hero_crab.get_info
tt.info.hero_portrait = "hero_portraits_1146"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0015") or "info_portraits_enemies_0047"
tt.main_script.insert = scripts3.hero_crab.insert
tt.main_script.update = mylua.crab.update
tt.motion.max_speed = 57
tt.regen.cooldown = 1
tt.regen.health = 33333
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_crab"
tt.render.sprites[1].angles.walk = {
	"running"
}
tt.render.sprites[1].angles.burrow_land = {
	"burrow_side",
	"burrow_up",
	"burrow_down"
}
tt.render.sprites[1].angles.burrow_water = {
	"burrow_side_water",
	"burrow_up_water",
	"burrow_down_water"
}
tt.soldier.melee_slot_offset.x = 20
tt.sound_events.change_rally_point = "HeroCrabTaunt"
tt.sound_events.death = "HeroCrabDeath"
tt.sound_events.respawn = "HeroCrabTauntIntro"
tt.sound_events.insert = "HeroCrabTauntIntro"
tt.sound_events.hero_room_select = "HeroCrabTauntSelect"
tt.sound_events.water_splash = "SpecialMermaid"
tt.sound_events.burrow_in = "HeroCrabBurrowIn"
tt.sound_events.burrow_out = "HeroCrabBurrowOut"
tt.ui.click_rect = r(-30, -10, 60, 55)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, ady(23))
tt.unit.mod_offset = v(0, ady(42))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.burrow = {
	disabled = true,
	extra_speed = nil,
	damage_radius = nil,
	health_bar_offset = v(0, tt.health_bar.offset.y - 8),
	hit_offset = v(0, 15),
	min_distance = 100,
	mod_offset = v(0, ady(37))
}
tt.invuln = {
	animation = "invuln",
	aura = nil,
	aura_name = "aura_crab_invuln",
	chance = nil,
	cooldown = 8,
	disabled = true,
	duration = 6,
	exclude_damage_types = bor(DAMAGE_INSTAKILL, DAMAGE_DISINTEGRATE, DAMAGE_DISINTEGRATE_BOSS, DAMAGE_EAT),
	sound = "HeroCrabShield",
	trigger_factor = 0.6,
	ts = 0,
	pending = nil
}
tt.melee.cooldown = 1
tt.melee.range = 83.2
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(28)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].xp_gain_factor = 0.85
tt.melee.attacks[1].sound = "MeleeSword"
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].animation = "cannon"
tt.ranged.attacks[1].bullet = "crab_water_bomb"
tt.ranged.attacks[1].bullet_start_offset = {
	v(9, 50)
}
tt.ranged.attacks[1].cooldown = 9e+99
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 256
tt.ranged.attacks[1].min_range = 19.2
tt.ranged.attacks[1].shoot_time = fts(30)
tt.ranged.attacks[1].vis_bans = bor(F_FLYING)
tt.ranged.attacks[1].xp_from_skill = "shouldercannon"
tt.ranged.attacks[1].node_prediction = fts(61)
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "pincer"
tt.timed_attacks.list[1].cooldown = 9e+99
tt.timed_attacks.list[1].damage_flags = bor(F_AREA)
tt.timed_attacks.list[1].damage_max = 333
tt.timed_attacks.list[1].damage_min = 33333333
tt.timed_attacks.list[1].damage_size = v(120, 25)
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(12)
tt.timed_attacks.list[1].max_range = 110
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].sound = "HeroCrabPrincer"
tt.timed_attacks.list[1].xp_from_skill = "pincerattack"
tt = E.register_t(E, "crab_water_bomb", "bomb")
tt.bullet.damage_radius = 65
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.flight_time = fts(31)
tt.bullet.g = (fts(1)*fts(1))/-1
tt.bullet.hit_decal = nil
tt.bullet.hit_fx = "fx_crab_water_bomb_explosion"
tt.bullet.hit_fx_water = "fx_crab_water_bomb_explosion"
tt.bullet.hit_payload = "aura_slow_water_bomb"
tt.sound_events.insert = "HeroCrabCannon"
tt.sound_events.hit = "HeroCrabCannonExplosion"
tt.sound_events.hit_water = "HeroGiantExplosionRock"
tt.render.sprites[1].name = "hero_crabman_proy"
tt = E.register_t(E, "aura_slow_water_bomb", "aura")
tt.aura.mod = "mod_slow_water_bomb"
tt.aura.cycle_time = fts(1)
tt.aura.duration = fts(5)
tt.aura.radius = 65
tt.aura.vis_bans = F_FRIEND
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt = E.register_t(E, "mod_slow_water_bomb", "mod_slow")
tt.modifier.duration = nil
tt.slow.factor = nil
tt = E.register_t(E, "fx_crab_water_bomb_explosion", "fx")
tt.render.sprites[1].name = "fx_hero_crab_splash"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor.y = 0.21212121212121213
tt.render.sprites[1].sort_y_offset = -5
tt = E.register_t(E, "aura_crab_invuln", "aura")

E.add_comps(E, tt, "render", "tween")

local dur = 4
tt.aura.duration = dur
tt.aura.track_source = true
tt.main_script.update = scripts3.aura_crab_invuln.update
tt.render.sprites[1].name = "fx_hero_crab_bubbles"
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor.y = 0.09722222222222222
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_crabman_invulnerable_effect"
tt.render.sprites[2].anchor.y = 0.09722222222222222
tt.render.sprites[2].scale = v(0, 0)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(11),
		0
	},
	{
		fts(16),
		255
	},
	{
		dur,
		255
	},
	{
		dur + fts(15),
		0
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].sprite_id = 2
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		fts(19),
		255
	},
	{
		dur,
		255
	},
	{
		dur + fts(15),
		0
	}
}
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "scale"
tt.tween.props[3].sprite_id = 2
tt.tween.props[3].keys = {
	{
		0,
		v(0, 0)
	},
	{
		fts(20),
		v(0.75, 0.85)
	}
}
tt.tween.props[4] = E.clone_c(E, "tween_prop")
tt.tween.props[4].disabled = true
tt.tween.props[4].name = "scale"
tt.tween.props[4].sprite_id = 2
tt.tween.props[4].keys = {
	{
		0,
		v(0.75, 0.85)
	},
	{
		fts(10),
		v(0.8, 0.8)
	},
	{
		fts(20),
		v(0.75, 0.85)
	}
}
tt.tween.props[4].loop = true
tt = RT("hero_crab_2", "hero_crab")
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_spawn_soldiers"
tt.auras.list[1].cooldown = 0
tt.motion.max_speed = 9 * FPS
tt.hero_insert = false
tt = RT("aura_spawn_soldiers", "aura")

E:add_comps(tt, "render")

tt.main_script.update = mylua.aura_spawn_pet.update
tt.aura.duration = 9e+99
tt.aura.one_king = false
tt.aura.pet_max_level = true
tt.aura.node_list = {
-4,
-6,
-8,
8,
6,
4
}
tt.aura.pet_names = {
"hero_van_helsing2",
"hero_alien2",
"hero_giant2",
"hero_alric2"
}
tt = RT("aura_spawn_soldiers2", "aura")

E:add_comps(tt, "render")

tt.main_script.update = mylua.aura_spawn_pet.update
tt.aura.duration = 9e+99
tt.aura.one_king = false
tt.aura.pet_max_level = true
tt.aura.node_list = {
-4,
-6,
-8,
8,
6,
4
}
tt.aura.pet_names = {
"Soldier_Monster"
}
tt = RT("hero_gerald", "hero")

AC(tt, "melee", "timed_attacks", "dodge")

anchor_y = 0.12
anchor_x = 0.5
image_y = 110
image_x = 92
tt.hero.fixed_stat_attack = 6
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 5
tt.hero.level_stats.armor = {
	0.3,
	0.3,
	0.4,
	0.4,
	0.5,
	0.5,
	0.6,
	0.6,
	0.7,
	0.8
}
tt.hero.level_stats.hp_max = {
	400,
	420,
	440,
	460,
	480,
	500,
	520,
	540,
	560,
	580
}
tt.hero.level_stats.melee_damage_max = {
	18,
	20,
	23,
	25,
	28,
	30,
	33,
	35,
	38,
	40
}
tt.hero.level_stats.melee_damage_min = {
	11,
	12,
	14,
	15,
	17,
	18,
	20,
	21,
	23,
	24
}
tt.hero.level_stats.regen_health = {
	100,
	105,
	110,
	115,
	120,
	125,
	130,
	135,
	140,
	145
}
tt.hero.skills.block_counter = CC("hero_skill")
tt.hero.skills.block_counter.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.block_counter.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.courage = CC("hero_skill")
tt.hero.skills.courage.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.courage.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_gerald.level_up
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "heroPortrait_portraits_0002"
tt.info.i18n_key = "HERO_PALADIN"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0002") or "info_portraits_hero_0005"
tt.main_script.update = scripts.hero_gerald.update
tt.motion.max_speed = FPS*2.2
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.12)
tt.render.sprites[1].prefix = "hero_gerald"
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].xp_gain_factor = 3
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.range = 55
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "courage"
tt.timed_attacks.list[1].cooldown = fts(55) + 6
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].mod = "mod_gerald_courage"
tt.timed_attacks.list[1].range = 90
tt.timed_attacks.list[1].shoot_time = fts(17)
tt.timed_attacks.list[1].sound = "HeroPaladinValor"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(3)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_MOD)
tt.timed_attacks.list[1].vis_bans = bor(F_HERO)
tt.dodge.animation = "counter"
tt.dodge.can_dodge = scripts.hero_gerald.fn_can_dodge
tt.dodge.chance = 0
tt.dodge.chance_base = 0
tt.dodge.chance_inc = 0.2
tt.dodge.time_before_hit = fts(4)
tt.dodge.low_chance_factor = 0.5
tt.dodge.counter_attack = E.clone_c(E, "melee_attack")
tt.dodge.counter_attack.animation = "counter"
tt.dodge.counter_attack.damage_type = bor(DAMAGE_TRUE, DAMAGE_NO_DODGE)
tt.dodge.counter_attack.reflected_damage_factor = 0.5
tt.dodge.counter_attack.reflected_damage_factor_inc = 0.5
tt.dodge.counter_attack.hit_time = fts(5)
tt.dodge.counter_attack.sound = "HeroPaladinDeflect"
tt = RT("hero_bloodshell", "hero")

AC(tt, "melee", "timed_attacks", "dodge")

anchor_y = 0.12
anchor_x = 0.5
image_y = 110
image_x = 92
tt.hero.fixed_stat_attack = 6
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 5
tt.hero.level_stats.armor = {
	0.3,
	0.3,
	0.4,
	0.4,
	0.5,
	0.5,
	0.6,
	0.6,
	0.7,
	0.8
}
tt.hero.level_stats.hp_max = {
	400,
	420,
	440,
	460,
	480,
	500,
	520,
	540,
	560,
	3200
}
tt.hero.level_stats.melee_damage_max = {
	18,
	20,
	23,
	25,
	28,
	30,
	33,
	35,
	38,
	120
}
tt.hero.level_stats.melee_damage_min = {
	11,
	12,
	14,
	15,
	17,
	18,
	20,
	21,
	23,
	100
}
tt.hero.level_stats.regen_health = {
	100,
	105,
	110,
	115,
	120,
	125,
	130,
	135,
	140,
	200
}
tt.hero.skills.block_counter = CC("hero_skill")
tt.hero.skills.block_counter.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.block_counter.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.courage = CC("hero_skill")
tt.hero.skills.courage.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.courage.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_gerald.level_up
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "heroPortrait_portraits_0002"
tt.info.i18n_key = "HERO_PALADIN"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0002") or "info_portraits_hero_0005"
tt.main_script.update = scripts.hero_gerald.update
tt.motion.max_speed = FPS*2.2
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.12)
tt.render.sprites[1].prefix = "enemy_bloodshell"
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroPaladinTaunt"
tt.sound_events.death = "HeroPaladinDeath"
tt.sound_events.hero_room_select = "HeroPaladinTauntSelect"
tt.sound_events.insert = "HeroPaladinTauntIntro"
tt.sound_events.respawn = "HeroPaladinTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].xp_gain_factor = 3
tt.melee.attacks[1].hit_time = fts(16)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = nil
tt.melee.attacks[2].chance = 0
tt.melee.range = 65
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = nil
tt.timed_attacks.list[1].cooldown = 9e+99
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].mod = "mod_gerald_courage"
tt.timed_attacks.list[1].range = 90
tt.timed_attacks.list[1].shoot_time = fts(17)
tt.timed_attacks.list[1].sound = "HeroPaladinValor"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(3)
}
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_MOD)
tt.timed_attacks.list[1].vis_bans = bor(F_HERO)
tt.dodge.animation = nil
tt.dodge.can_dodge = scripts.hero_gerald.fn_can_dodge
tt.dodge.chance = 0
tt.dodge.chance_base = 0
tt.dodge.chance_inc = 0
tt.dodge.time_before_hit = fts(4)
tt.dodge.low_chance_factor = 0.3333333333333333
tt.dodge.counter_attack = E.clone_c(E, "melee_attack")
tt.dodge.counter_attack.animation = nil
tt.dodge.counter_attack.damage_type = bor(DAMAGE_TRUE, DAMAGE_NO_DODGE)
tt.dodge.counter_attack.reflected_damage_factor = 0.5
tt.dodge.counter_attack.reflected_damage_factor_inc = 0.5
tt.dodge.counter_attack.hit_time = fts(5)
tt.dodge.counter_attack.sound = "HeroPaladinDeflect"
tt = E.register_t(E, "hero_beastmaster", "hero")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks", "ranged")

anchor_y = 0.22
image_y = 64
tt.hero.level_stats.hp_max = {
	280,
	310,
	340,
	370,
	400,
	430,
	460,
	490,
	520,
	2000
}
tt.hero.level_stats.regen_health = {
	23,
	26,
	28,
	31,
	33,
	36,
	38,
	41,
	43,
	250
}
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.melee_damage_min = {
	8,
	9,
	10,
	10,
	11,
	12,
	13,
	14,
	14,
	30
}
tt.hero.level_stats.melee_damage_max = {
	12,
	13,
	14,
	16,
	17,
	18,
	19,
	20,
	22,
	45
}
tt.hero.skills.boarmaster = E.clone_c(E, "hero_skill")
tt.hero.skills.boarmaster.boars = {
	1,
	2,
	4
}
tt.hero.skills.boarmaster.hp_max = {
	160,
	160,
	500
}
tt.hero.skills.stampede = E.clone_c(E, "hero_skill")
tt.hero.skills.stampede.rhinos = {
	2,
	3,
	4
}
tt.hero.skills.stampede.duration = {
	3,
	4,
	5
}
tt.hero.skills.stampede.stun_chance = {
	0.25,
	0.3,
	0.35
}
tt.hero.skills.stampede.stun_duration = {
	fts(45),
	fts(75),
	fts(105)
}
tt.hero.skills.stampede.xp_gain_factor = 70
tt.hero.skills.falconer = E.clone_c(E, "hero_skill")
tt.hero.skills.falconer.fake_hp = {
	40,
	50,
	600
}
tt.hero.skills.falconer.max_range = {
	110,
	125,
	125
}
tt.hero.skills.falconer.damage_min = {
	3,
	9,
	120
}
tt.hero.skills.falconer.damage_max = {
	9,
	27,
	150
}
tt.hero.skills.deeplashes = E.clone_c(E, "hero_skill")
tt.hero.skills.deeplashes.damage = {
	14,
	26,
	36
}
tt.hero.skills.deeplashes.blood_damage = {
	12,
	36,
	72
}
tt.hero.skills.deeplashes.xp_gain_factor = 30
tt.hero.skills.regeneration = E.clone_c(E, "hero_skill")
tt.hero.skills.regeneration.hp = {
	1,
	1,
	3
}
tt.hero.skills.regeneration.cooldown = {
	fts(10),
	fts(5),
	0.2
}
tt.hero.skills.boarmaster.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.boarmaster.hr_icon = 21
tt.hero.skills.boarmaster.hr_order = 1
tt.hero.skills.stampede.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.stampede.hr_icon = 22
tt.hero.skills.stampede.hr_order = 2
tt.hero.skills.falconer.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.falconer.hr_icon = 23
tt.hero.skills.falconer.hr_order = 3
tt.hero.skills.deeplashes.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.deeplashes.hr_icon = 24
tt.hero.skills.deeplashes.hr_order = 4
tt.hero.skills.regeneration.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.regeneration.hr_icon = 25
tt.hero.skills.regeneration.hr_order = 5
tt.health.armor = 99999999999999999
tt.health.dead_lifetime = 25
tt.health.hp_max = 999999999999
tt.health_bar.offset = v(0, 49)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_beastmaster.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_beastmaster.get_info
tt.info.hero_portrait = "hero_portraits_1888"
tt.info.i18n_key = "BIGQ"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0003") or "info_portraits_enemies_0046"
tt.main_script.insert = scripts3.hero_beastmaster.insert
tt.main_script.update = scripts3.hero_beastmaster.update
tt.hero.level = 10
tt.hero.skills.boarmaster.level = 3
tt.hero.skills.stampede.level = 3
tt.hero.skills.deeplashes.level = 3
tt.hero.skills.falconer.level = 3
tt.hero.skills.regeneration.level = 3
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_beastmaster"
tt.soldier.melee_slot_offset.x = 25
tt.sound_events.change_rally_point = "HeroBeastMasterTaunt"
tt.sound_events.death = "HeroBeastMasterDeath"
tt.sound_events.respawn = "HeroBeastMasterTauntIntro"
tt.sound_events.insert = "HeroBeastMasterTauntIntro"
tt.sound_events.hero_room_select = "HeroBeastMasterTauntSelect"
tt.ui.click_rect = r(-20, -5, 40, 60)
tt.unit.hit_offset = v(0, 17)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 18)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.melee.range = 75
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.95
tt.melee.attacks[1].pop = {
	"fish_spawns"
}
tt.melee.attacks[1].pop_chance = 0.15
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].animation = "lash"
tt.melee.attacks[2].cooldown = 9e+99
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = bor(F_BLOCK, F_BLOOD)
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].sound = "HeroBeastMasterAttack"
tt.melee.attacks[2].mod = "mod_beastmaster_lash"
tt.melee.attacks[2].pop = nil
tt.melee.attacks[2].xp_gain_factor = 0.8
tt.melee.attacks[2].xp_from_skill = "deeplashes"
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "rangedAttack"
tt.ranged.attacks[1].bullet = "harpoon_redspine"
tt.ranged.attacks[1].bullet_start_offset = {
  v(0, 40)
}
tt.ranged.attacks[1].cooldown = 3
tt.ranged.attacks[1].max_range = 125
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_time = fts(8)
tt.falcons_max = 0
tt.falcons_name = "beastmaster_falcon"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animation = "stampede"
tt.timed_attacks.list[1].cooldown = 9e+99
tt.timed_attacks.list[1].count = nil
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "beastmaster_rhino"
tt.timed_attacks.list[1].range_nodes_max = 40
tt.timed_attacks.list[1].range_nodes_min = 5
tt.timed_attacks.list[1].sound = "HeroBeastMasterSummonRhinos"
tt.timed_attacks.list[1].spawn_time = fts(15)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_WATER, F_CLIFF)
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[2] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[2].animation = "pets"
tt.timed_attacks.list[2].cooldown = 16
tt.timed_attacks.list[2].max = nil
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "beastmaster_boar"
tt.timed_attacks.list[2].sound = "HeroBeastMasterSummonBoar"
tt.timed_attacks.list[2].spawn_time = fts(35)
tt = E.register_t(E, "harpoon_redspine", "arrow")
tt.render.sprites[1].name = "Redspine_spear"
tt.render.sprites[1].animated = false
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.flight_time = fts(10)
tt.bullet.mod = "mod_greenfin_net"
tt.bullet.miss_decal = "Redspine_spear_decal"
tt.bullet.pop = nil
tt = E.register_t(E, "harpoon_redspine2", "arrow")
tt.render.sprites[1].name = "Redspine_spear"
tt.render.sprites[1].animated = false
tt.bullet.damage_min = 100
tt.bullet.damage_max = 130
tt.bullet.flight_time = fts(10)
tt.bullet.miss_decal = "Redspine_spear_decal"
tt.bullet.pop = nil
tt = E.register_t(E, "aura_beastmaster_regeneration", "aura")

E.add_comps(E, tt, "hps")

tt.hps.heal_min = 666
tt.hps.heal_max = 888
tt.hps.heal_every = 666
tt.main_script.update = scripts3.aura_beastmaster_regeneration.update
tt = E.register_t(E, "mod_beastmaster_lash", "modifier")

E.add_comps(E, tt, "dps")

tt.modifier.duration = 6
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.fx = "fx_bleeding"
tt.dps.fx_with_blood_color = true
tt.dps.fx_tracks_target = true
tt.main_script.insert = scripts3.mod_dps.insert
tt.main_script.update = scripts3.mod_dps.update
tt = E.register_t(E, "beastmaster_rhino", "decal_scripted")

E.add_comps(E, tt, "nav_path", "motion", "sound_events", "tween")

anchor_y = 0.45
image_y = 172
tt.attack = E.clone_c(E, "area_attack")
tt.attack.cooldown = fts(6)
tt.attack.damage = 0
tt.attack.damage_radius = 0
tt.attack.damage_type = DAMAGE_PHYSICAL
tt.attack.mod = "mod_beastmaster_rhino"
tt.attack.damage_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.attack.damage_flags = F_AREA
tt.attack.mod_chance = nil
tt.duration = nil
tt.main_script.insert = scripts3.beastmaster_rhino.insert
tt.main_script.update = scripts3.beastmaster_rhino.update
tt.motion.max_speed = 90
tt.nav_path.dir = -1
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].angles_custom = {
	walk = {
		55,
		135,
		240,
		315
	}
}
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].loop_forced = true
tt.render.sprites[1].prefix = "decal_rhino"
tt.sound_events.insert = "HeroBeastMasterStampede"
tt.sound_events.insert_args = {
	ignore = 1
}
tt.sound_events.remove_stop = "HeroBeastMasterStampede"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	},
	{
		"this.duration",
		255
	},
	{
		"this.duration+0.5",
		0
	}
}
tt.tween.remove = true
tt = E.register_t(E, "beastmaster_boar", "soldier")

E.add_comps(E, tt, "melee", "nav_grid", "ranged")

anchor_y = 0.185
image_y = 54
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0010") or "info_portraits_enemies_0043"
tt.info.i18n_key = "SMALLQ"
tt.health.armor = 0
tt.health.hp_max = nil
tt.health_bar.offset = v(0, ady(47))
tt.info.fn = scripts3.beastmaster_boar.get_info
tt.main_script.insert = scripts3.beastmaster_boar.insert
tt.main_script.update = scripts3.beastmaster_boar.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "HeroBeastMasterBoarAttack"
tt.melee.attacks[1].xp_gain_factor = 0.85
tt.melee.attacks[1].pop = {
	"fish_spawns"
}
tt.melee.attacks[1].pop_chance = 0.08
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "netAttack"
tt.melee.attacks[2].cooldown = 8
tt.melee.attacks[2].hit_time = fts(9)
tt.melee.attacks[2].mod = "mod_greenfin_net"
tt.melee.attacks[2].vis_flags = bor(F_STUN, F_NET)
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "netAttack"
tt.ranged.attacks[1].bullet = "harpoon_redspine"
tt.ranged.attacks[1].bullet_start_offset = {
	v(9, 24)
}
tt.ranged.attacks[1].cooldown = 5
tt.ranged.attacks[1].max_range = 125
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].node_prediction = fts(11)
tt.ranged.attacks[1].shoot_time = fts(11)
tt.melee.range = 85
tt.motion.max_speed = 69
tt.regen.health = 50
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "beastmaster_boar"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.soldier.melee_slot_offset.x = 18
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, ady(9))
tt.unit.mod_offset = v(2, ady(23))
tt.unit.hide_after_death = true
tt.unit.explode_fx = nil
tt.vis.bans = bor(F_SKELETON, F_CANNIBALIZE)
tt = E.register_t(E, "beastmaster_boar2", "soldier_militia")

E.add_comps(E, tt, "melee", "nav_grid", "ranged", "nav_path")

anchor_y = 0.185
image_y = 54
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0010") or "info_portraits_enemies_0043"
tt.info.i18n_key = "SMALLQ"
tt.health.armor = 0
tt.health.hp_max = 450
tt.health_bar.offset = v(0, ady(47))
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 14
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "HeroBeastMasterBoarAttack"
tt.melee.attacks[1].xp_gain_factor = 0.85
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "netAttack"
tt.melee.attacks[2].cooldown = 8
tt.melee.attacks[2].hit_time = fts(9)
tt.melee.attacks[2].mod = "mod_greenfin_net"
tt.melee.attacks[2].vis_flags = bor(F_STUN, F_NET)
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "netAttack"
tt.ranged.attacks[1].bullet = "harpoon_redspine"
tt.ranged.attacks[1].bullet_start_offset = {
	v(9, 24)
}
tt.ranged.attacks[1].cooldown = 5
tt.ranged.attacks[1].max_range = 135
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].node_prediction = fts(11)
tt.ranged.attacks[1].shoot_time = fts(9)
tt.melee.range = 85
tt.motion.max_speed = 69
tt.regen.health = 50
tt.regen.cooldown = 1
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia3"
tt.soldier.melee_slot_offset.x = 18
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, ady(9))
tt.unit.mod_offset = v(2, ady(23))
tt.unit.hide_after_death = true
tt.unit.explode_fx = nil
tt.vis.bans = bor(F_SKELETON, F_CANNIBALIZE)
tt = E.register_t(E, "beastmaster_boar3", "soldier_militia")

E.add_comps(E, tt, "melee", "nav_grid", "ranged", "nav_path")

anchor_y = 0.22
image_y = 64
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0010") or "info_portraits_enemies_0043"
tt.info.i18n_key = "SMALLQ"
tt.health.armor = 0
tt.health.hp_max = 1700
tt.health_bar.offset = v(0, 49)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 35
tt.melee.attacks[1].damage_min = 25
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "HeroBeastMasterBoarAttack"
tt.melee.attacks[1].xp_gain_factor = 0.85
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "rangedAttack"
tt.ranged.attacks[1].bullet = "harpoon_redspine2"
tt.ranged.attacks[1].bullet_start_offset = {
	v(9, 24)
}
tt.ranged.attacks[1].cooldown = 3
tt.ranged.attacks[1].max_range = 135
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].node_prediction = fts(11)
tt.ranged.attacks[1].shoot_time = fts(8)
tt.melee.range = 85
tt.motion.max_speed = 69
tt.regen.health = 100
tt.regen.cooldown = 1
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia5"
tt.soldier.melee_slot_offset.x = 18
tt.ui.click_rect = r(-20, -5, 40, 60)
tt.unit.hit_offset = v(0, 17)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 18)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_SKELETON, F_CANNIBALIZE)
tt = E.register_t(E, "enemy_deviltide", "beastmaster_boar2")
tt.health.armor = 0.5
tt.health.hp_max = 500
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0072") or "info_portraits_enemies_0044"
tt.info.enc_icon = 47
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.motion.max_speed = 75
tt.render.sprites[1].prefix = "soldiermilitia4"
tt = E.register_t(E, "enemy_deviltide2", "enemy_deviltide")
tt.melee.attacks[1].pop = {
	"fish_spawns"
}
tt.melee.attacks[1].pop_chance = 0
tt.render.sprites[1].prefix = "soldiermilitia3"
tt.health.armor = 0
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 14
tt.melee.attacks[1].damage_min = 6
tt.motion.max_speed = 57.599999999999994
tt.health.hp_max = 450
tt.main_script.update = mylua.walk_soldier.update
tt.nav_path.dir = -1
tt = E.register_t(E, "mod_greenfin_net", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts114.mod_stun.insert
tt.main_script.update = scripts114.mod_stun.update
tt.main_script.remove = scripts114.mod_stun.remove
tt.modifier.duration = 6
tt.modifier.animation_phases = true
tt.render.sprites[1].prefix = "greenfin_net"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_anchors = {
	v(0.5, 0.5),
	v(0.5, 0.5),
	v(0.5, 0.5)
}
tt.render.sprites[1].anchor = v(0.5, 10)
tt = E.register_t(E, "mod_beastmaster_rhino", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts3.mod_stun.insert
tt.main_script.update = scripts3.mod_stun.update
tt.main_script.remove = scripts3.mod_stun.remove
tt.modifier.duration = nil
tt.render.sprites[1].prefix = "stun"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt = E.register_t(E, "beastmaster_falcon", "decal_scripted")

E.add_comps(E, tt, "force_motion", "info", "ui", "custom_attack")

anchor_y = 0.5
image_y = 54
tt.fake_hp = nil
tt.main_script.update = scripts3.beastmaster_falcon.update
tt.info.fn = scripts3.beastmaster_falcon.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0011") or "info_portraits_enemies_0046"
tt.info.i18n_key = "BIGQ"
tt.flight_speed = 45
tt.flight_height = 80
tt.custom_attack = E.clone_c(E, "custom_attack")
tt.custom_attack.min_range = 10
tt.custom_attack.max_range = nil
tt.custom_attack.damage_min = nil
tt.custom_attack.damage_max = nil
tt.custom_attack.cooldown = 3
tt.custom_attack.xp_gain_factor = 0.85
tt.custom_attack.damage_type = DAMAGE_PHYSICAL
tt.custom_attack.vis_flags = F_RANGED
tt.custom_attack.vis_bans = 0
tt.custom_attack.sound = "HeroBeastMasterFalconAttack"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "decal_falcon"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].scale = v(0.6, 0.6)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.ui.click_rect = r(-15, 65, 30, 30)
tt.owner = nil
tt = RT("hero_dwarf", "stage_hero")

AC(tt, "melee", "timed_attacks", "auras")

image_y = 94
anchor_y = 0.26
image_y = 116
image_x = 142
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 5
tt.hero.level_stats.armor = {
	0.1,
	0.1,
	0.15,
	0.15,
	0.2,
	0.2,
	0.25,
	0.25,
	0.3,
	0.95
}
tt.hero.level_stats.hp_max = {
	430,
	460,
	490,
	520,
	550,
	580,
	610,
	640,
	670,
	3200
}
tt.hero.level_stats.melee_damage_max = {
	38,
	41,
	45,
	49,
	53,
	56,
	60,
	64,
	68,
	120
}
tt.hero.level_stats.melee_damage_min = {
	23,
	25,
	27,
	29,
	32,
	34,
	36,
	38,
	41,
	100
}
tt.hero.level_stats.regen_health = {
	108,
	115,
	123,
	130,
	138,
	145,
	153,
	160,
	168,
	300
}
tt.hero.skills.ancestors_call = CC("hero_skill")
tt.hero.skills.ancestors_call.count = {
	1,
	2,
	4
}
tt.hero.skills.ancestors_call.hp_max = {
	100,
	150,
	320
}
tt.hero.skills.ancestors_call.damage_min = {
	2,
	4,
	10
}
tt.hero.skills.ancestors_call.damage_max = {
	6,
	8,
	12
}
tt.hero.skills.ancestors_call.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.ancestors_call.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.bear = CC("hero_skill")
tt.hero.skills.bear.damage_min = {
	20,
	30,
	40
}
tt.hero.skills.bear.damage_max = {
	40,
	50,
	60
}
tt.hero.skills.bear.duration = {
	10,
	12,
	14
}
tt.hero.skills.bear.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.bear.xp_gain = {
	100,
	200,
	300
}
tt.auras.list[1] = CC("aura_attack")
tt.auras.list[1].name = "aura_ingvar_bear_regenerate"
tt.health.dead_lifetime = 40
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_ingvar.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.fn = scripts.hero_ingvar.get_info
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_8888"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_enemies_0048"
tt.main_script.update = scripts.hero_ingvar.update
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "hero_ingvar2"
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTauntIntro"
tt.sound_events.change_rally_point_viking = "DwarfHeroTauntIntro"
tt.sound_events.change_rally_point_bear = "DwarfHeroTauntIntro"
tt.sound_events.death = "DwarfHeroTauntIntro"
tt.sound_events.hero_room_select = "DwarfHeroTauntIntro"
tt.sound_events.insert = "DwarfHeroTauntIntro"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt.melee.range = 83.2
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "DwarfHeroTauntIntro"
tt.melee.attacks[1].hit_decal = "decal_ingvar_attack"
tt.melee.attacks[1].hit_offset = v(48, -1)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].hit_offset = v(-25, 2)
tt.melee.attacks[3] = CC("melee_attack")
tt.melee.attacks[3].animations = {
	nil,
	"attack"
}
tt.melee.attacks[3].cooldown = 9e+99
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].hit_times = {
	fts(10),
	fts(25),
	fts(41)
}
tt.melee.attacks[3].loopable = true
tt.melee.attacks[3].loops = 1
tt.melee.attacks[3].sound_hit = "HeroVikingAttackHit"
tt.melee.attacks[3].sound = "HeroVikingBearAttackStart"
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.attacks[3].xp_gain_factor = 2
tt.timed_attacks.list[1] = CC("spawn_attack")
tt.timed_attacks.list[1].animation = "ancestors"
tt.timed_attacks.list[1].cooldown = 18
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_ingvar_ancestor2"
tt.timed_attacks.list[1].sound = "DwarfHeroTauntIntro"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(5)
}
tt.timed_attacks.list[1].nodes_offset = {
	4,
	8
}
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].cooldown = 9e+99
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].duration = nil
tt.timed_attacks.list[2].transform_health_factor = 0.6
tt.timed_attacks.list[2].immune_to = bor(DAMAGE_BASE_TYPES, DAMAGE_MODIFIER)
tt.timed_attacks.list[2].sound = "DwarfHeroTauntIntro"
tt = RT("hero_spider", "hero")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.1484375
anchor_x = 0.5
image_y = 128
image_x = 220
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 5
tt.hero.level_stats.armor = {
	0.1,
	0.1,
	0.15,
	0.15,
	0.2,
	0.2,
	0.25,
	0.25,
	0.3,
	0.0
}
tt.hero.level_stats.hp_max = {
	430,
	460,
	490,
	520,
	550,
	580,
	610,
	640,
	670,
	4500
}
tt.hero.level_stats.melee_damage_max = {
	38,
	41,
	45,
	49,
	53,
	56,
	60,
	64,
	68,
	200
}
tt.hero.level_stats.melee_damage_min = {
	23,
	25,
	27,
	29,
	32,
	34,
	36,
	38,
	41,
	100
}
tt.hero.level_stats.regen_health = {
	108,
	115,
	123,
	130,
	138,
	145,
	153,
	160,
	168,
	1000
}
tt.hero.skills.ancestors_call = CC("hero_skill")
tt.hero.skills.ancestors_call.count = {
	1,
	2,
	8
}
tt.hero.skills.ancestors_call.hp_max = {
	100,
	150,
	250
}
tt.hero.skills.ancestors_call.damage_min = {
	2,
	4,
	15
}
tt.hero.skills.ancestors_call.damage_max = {
	6,
	8,
	25
}
tt.hero.skills.ancestors_call.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.ancestors_call.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.bear = CC("hero_skill")
tt.hero.skills.bear.damage_min = {
	20,
	30,
	40
}
tt.hero.skills.bear.damage_max = {
	40,
	50,
	60
}
tt.hero.skills.bear.duration = {
	10,
	12,
	14
}
tt.hero.skills.bear.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.bear.xp_gain = {
	100,
	200,
	300
}
tt.auras.list[1] = CC("aura_attack")
tt.auras.list[1].name = "aura_ingvar_bear_regenerate"
tt.health.magic_armor = 0.8
tt.health.dead_lifetime = 66
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_ingvar.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.fn = scripts.hero_ingvar.get_info
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_4321"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0057"
tt.info.i18n_key = "BIGSPIDER"
tt.main_script.update = scripts.hero_ingvar.update
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "hero_ingvar3"
tt.render.sprites[1].scale = v(0.5, 0.5)
tt.soldier.melee_slot_offset.x = 26
tt.sound_events.change_rally_point = "DwarfHeroTauntIntro"
tt.sound_events.change_rally_point_viking = "DwarfHeroTauntIntro"
tt.sound_events.change_rally_point_bear = "DwarfHeroTauntIntro"
tt.sound_events.death = "DwarfHeroTauntIntro"
tt.sound_events.hero_room_select = "DwarfHeroTauntIntro"
tt.sound_events.insert = "DwarfHeroTauntIntro"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.ui.click_rect = r(-45, 0, 90, 80)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.can_explode = false
tt.unit.can_disintegrate = false
tt.unit.fade_time_after_death = 2
tt.unit.hit_offset = v(0, 45)
tt.unit.marker_hidden = true
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 45)
tt.unit.size = UNIT_SIZE_LARGE
tt.melee.range = 83.2
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "DwarfHeroTauntIntro"
tt.melee.attacks[1].hit_decal = "decal_ingvar_attack"
tt.melee.attacks[1].hit_offset = v(48, -1)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].hit_offset = v(-25, 2)
tt.melee.attacks[3] = CC("melee_attack")
tt.melee.attacks[3].animations = {
	nil,
	"attack"
}
tt.melee.attacks[3].cooldown = 9e+99
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].hit_times = {
	fts(10),
	fts(25),
	fts(41)
}
tt.melee.attacks[3].loopable = true
tt.melee.attacks[3].loops = 1
tt.melee.attacks[3].sound_hit = "HeroVikingAttackHit"
tt.melee.attacks[3].sound = "HeroVikingBearAttackStart"
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.attacks[3].xp_gain_factor = 2
tt.timed_attacks.list[1] = CC("spawn_attack")
tt.timed_attacks.list[1].animation = "ancestors"
tt.timed_attacks.list[1].cooldown = 18
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_ingvar_ancestor3"
tt.timed_attacks.list[1].sound = "DwarfHeroTauntIntro"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(5)
}
tt.timed_attacks.list[1].nodes_offset = {
	4,
	8
}
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].cooldown = 9e+99
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].duration = nil
tt.timed_attacks.list[2].transform_health_factor = 0.6
tt.timed_attacks.list[2].immune_to = bor(DAMAGE_BASE_TYPES, DAMAGE_MODIFIER)
tt.timed_attacks.list[2].sound = "DwarfHeroTauntIntro"
tt = E.register_t(E, "hero_dwarf666", "stage_hero")

E.add_comps(E, tt, "melee")

image_y = 94
anchor_y = 0.26
tt.health.armor = 0.95
tt.health.dead_lifetime = 40
tt.health.hp_max = 3200
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_8888"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_enemies_0048"
tt.main_script.insert = scripts3.hero_dwarf.insert
tt.main_script.update = scripts3.hero_dwarf.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].hit_time = fts(16)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].cooldown = 9e+99
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].damage_radius = 60
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].hit_decal = "fx_dwarf_area_quake"
tt.melee.attacks[2].hit_fx = "fx_dwarf_area_ring"
tt.melee.attacks[2].hit_offset = v(29, 0)
tt.melee.attacks[2].hit_time = fts(29)
tt.melee.attacks[2].pop = {
"hero_elves_denas_ultimate"
}
tt.melee.attacks[2].pop_conds = DR_DAMAGE
tt.melee.attacks[2].pop_chance = 1
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_8888"
tt.melee.range = 89
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 1
tt.regen.health = 300
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt = E.register_t(E, "fx_dwarf_area_quake", "decal_timed")
tt.render.sprites[1].name = "fx_dwarf_area_quake"
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].offset.y = 2
tt.render.sprites[1].scale = v(0.8, 0.8)
tt.render.sprites[1].alpha = 166
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].offset.y = -22
tt = E.register_t(E, "fx_dwarf_area_ring", "decal_timed")
tt.render.sprites[1].name = "fx_dwarf_area_ring"
tt.render.sprites[1].z = Z_DECALS - 1

E:add_comps(tt, "pos", "main_script", "sound_events", "render")

tt.cooldown = 60
tt.spawn_offsets = {
	v(25, 0),
	v(-25, 0),
	v(25, 20),
	v(25, -20),
	v(-25, 20),
	v(-25, -20),
	v(0, 40),
	v(0, -40)
}
tt = RT("fx_bolt_veznan_hit", "fx")
tt.render.sprites[1].name = "veznan_hero_bolt_hit"
tt.pop_y_offset = 0
tt = E.register_t(E, "pop_mage", "pop")
tt.render.sprites[1].name = "elven_pops_0001"
tt.entity = "guard_spawn"
tt = RT("ps_fireball_veznan_demon")

AC(tt, "pos", "particle_system")

tt.particle_system.alphas = {
	255,
	40
}
tt.particle_system.animated = false
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "veznan_hero_demon_proyParticle"
tt.particle_system.particle_lifetime = {
	fts(9),
	fts(11)
}
tt.particle_system.scales_x = {
	1,
	1.5
}
tt.particle_system.scales_y = {
	1,
	1.5
}
tt.particle_system.scale_same_aspect = false
tt.particle_system.scale_var = {
	0.35,
	0.8
}
tt = E.register_t(E, "ps_veznan_soulburn")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "veznan_hero_soulBurn_particle"
tt.particle_system.animated = false
tt.particle_system.loop = false
tt.particle_system.emission_rate = 30
tt.particle_system.particle_lifetime = {
	fts(4),
	fts(12)
}
tt.particle_system.scales_x = {
	1,
	1.25
}
tt.particle_system.scales_y = {
	1,
	1.25
}
tt.particle_system.scale_var = {
	0.25,
	1
}
tt.particle_system.alphas = {
	255,
	0
}
tt = RT("fx_veznan_arcanenova", "fx")
tt.render.sprites[1].name = "fx_veznan_arcanenova"
tt.render.sprites[1].anchor.y = 0.11904761904761904
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("fx_veznan_soulburn", "decal_tween")
tt.render.sprites[1].prefix = "veznan_hero_soulBurn_desintegrate"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = false
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].anchor.y = 0.15217391304347827
tt.tween.props[1].keys = {
	{
		0.5,
		255
	},
	{
		1,
		0
	}
}
tt = RT("fx_veznan_soulburn_ball_spawn", "fx")
tt.render.sprites[1].prefix = "veznan_hero_soulBurn_proy_spawn"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt = RT("decal_veznan_arcanenova", "decal_bomb_crater")
tt.render.sprites[1].name = "veznan_hero_arcaneNova_terrainDecal"
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "fx_veznan_arcanenova_terrain"
tt.render.sprites[2].hide_after_runs = 1
tt.render.sprites[2].z = Z_DECALS
tt = RT("decal_veznan_soulburn_ball", "decal_scripted")
tt.render.sprites[1].prefix = "veznan_hero_soulBurn_proy"
tt.render.sprites[1].name = "fly"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].hidden = true
tt.from = nil
tt.to = nil
tt.target = nil
tt.speed = FPS*14
tt.offset = v(-5, 5)
tt.particles_name = "ps_veznan_soulburn"
tt.spawn_fx = "fx_veznan_soulburn_ball_spawn"
tt.main_script.update = scripts2.decal_veznan_soulburn_ball.update
tt = RT("soldier_veznan_demon", "soldier_militia")

AC(tt, "reinforcement", "ranged")

tt.health.armor = 0
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 65)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts2.soldier_reinforcement.get_info
tt.info.portrait = "portraits_sc_0058"
tt.info.random_name_count = 8
tt.info.random_name_format = "ELVES_SOLDIER_VEZNAN_DEMON_%i_NAME"
tt.main_script.insert = scripts2.soldier_reinforcement.insert
tt.main_script.update = scripts2.soldier_reinforcement.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].mod = "mod_veznan_demon_fire"
tt.melee.continue_in_cooldown = true
tt.melee.fn_can_pick = function (soldier, target)
	return target.template_name ~= "enemy_mantaray"
end
tt.melee.range = 65
tt.motion.max_speed = 75
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 65
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].bullet = "fireball_veznan_demon"
tt.ranged.attacks[1].bullet_start_offset = {
	v(25, 42)
}
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].node_prediction = fts(25)
tt.regen = nil
tt.reinforcement.duration = 30
tt.reinforcement.fade = nil
tt.render.sprites[1].anchor.y = 0.1
tt.render.sprites[1].prefix = "veznan_demon"
tt.render.sprites[1].name = "raise"
tt.soldier.melee_slot_offset = v(10, 0)
tt.sound_events.death = "ElvesHeroVeznanDemonDeath"
tt.ui.click_rect = r(-10, 0, 20, 30)
tt.unit.level = 0
tt.unit.hit_offset = v(0, 30)
tt.unit.mod_offset = v(0, 28)
tt.unit.hide_after_death = true
tt.vis.flags = bor(tt.vis.flags, F_HERO)
tt.vis.bans = bor(F_POISON, F_NET, F_STUN, F_BURN, F_DRIDER_POISON)
tt = RT("fireball_veznan_demon", "bullet")
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_radius = 40
tt.bullet.damage_max = nil
tt.bullet.damage_mix = nil
tt.bullet.mod = "mod_veznan_demon_fire"
tt.bullet.node_prediction = nil
tt.bullet.flight_time = fts(12)
tt.bullet.particles_name = "ps_fireball_veznan_demon"
tt.bullet.hit_fx_air = "fx_fireball_veznan_demon_hit_air"
tt.bullet.hit_fx = "fx_fireball_veznan_demon_hit"
tt.bullet.vis_flags = F_RANGED
tt.main_script.update = scripts2.fireball.update
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.x = 0.7352941176470589
tt.render.sprites[1].name = "fireball_veznan_demon"
tt.sound_events.insert = "ElvesHeroVeznanDemonFireballThrow"
tt.sound_events.hit = "ElvesHeroVeznanDemonFireballHit"
tt = RT("bolt_veznan", "bolt")
tt.render.sprites[1].prefix = "veznan_hero_bolt"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.acceleration_factor = 0.1
tt.bullet.min_speed = 30
tt.bullet.max_speed = 300
tt.bullet.hit_fx = "fx_bolt_veznan_hit"
tt.bullet.xp_gain_factor = 0.38
tt.sound_events.insert = "ElvesHeroVeznanRangeShoot"
tt.bullet.pop = {
	"pop_high_elven"
}
tt = RT("mod_veznan_ultimate_stun", "mod_stun")
tt.modifier.duration = 2
tt = RT("mod_veznan_demon_fire", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts2.mod_track_target.insert
tt.main_script.update = scripts2.mod_track_target.update
tt.modifier.duration = fts(29)
tt.modifier.resets_same = true
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].draw_order = 10
tt = RT("mod_veznan_arcanenova", "mod_slow")
tt.modifier.duration = 2
tt.slow.factor = 0.5
tt = RT("mod_veznan_shackles_stun", "mod_stun")
tt.render.sprites[1].prefix = "veznan_hero_shackles"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_anchors = {
	v(0.5, 0.7222222222222222),
	v(0.5, 0.5483870967741935),
	v(0.5, 0.4838709677419355)
}
tt.modifier.animation_phases = true
tt.modifier.duration = 3
tt = RT("mod_veznan_shackles_dps", "modifier")

AC(tt, "dps")

tt.modifier.duration = 3
tt.dps.damage_min = 2
tt.dps.damage_max = 2
tt.dps.damage_every = fts(5)
tt.dps.damage_type = DAMAGE_TRUE
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dps.update
tt = E.register_t(E, "kraken_aura", "aura")
tt.main_script.insert = scripts3.kraken_aura.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.aura.mod = "mod_stun_kraken"
tt.aura.cycle_time = fts(10)
tt.aura.duration = 3
tt.aura.radius = 40
tt.aura.vis_flags = bor(F_RANGED)
tt.aura.vis_bans = bor(F_BOSS, F_FLYING, F_WATER, F_CLIFF, F_FRIEND, F_HERO)
tt.max_active_targets = 2
tt.active_targets_count = 0
tt = E.register_t(E, "kraken_aura_slow", "aura")
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt.aura.mod = "mod_slow_kraken"
tt.aura.cycle_time = fts(10)
tt.aura.duration = 3
tt.aura.radius = 40
tt.aura.vis_flags = bor(F_RANGED)
tt.aura.vis_bans = bor(F_BOSS, F_FLYING, F_WATER, F_CLIFF, F_FRIEND, F_HERO)
tt = E.register_t(E, "pirate_exploding_barrel", "bomb")
tt.bullet.flight_time = fts(20)
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.hide_radius = nil
tt.bullet.hit_fx = "fx_barrel_explosion"
tt.sound_events.hit = nil
tt.sound_events.insert = "HeroPirateExplosiveBarrel"
tt.render.sprites[1].name = "hero_pirate_barrelProyectile"
tt.render.sprites[1].animated = false
tt.main_script.update = scripts3.pirate_exploding_barrel.update
tt.fragments = 0
tt = E.register_t(E, "fx_barrel_explosion", "fx")
tt.render.sprites[1].name = "barrel_explosion"
tt.render.sprites[1].z = Z_BULLETS
tt = E.register_t(E, "barrel_fragment", "bomb")
tt.bullet.align_with_trajectory = true
tt.bullet.flight_time = fts(16)
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_radius = 38.4
tt.bullet.hit_fx = "fx_fragment_ground_explosion"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.particles_name = "ps_barrel_fragment"
tt.bullet.pop = nil
tt.sound_events.insert = nil
tt.render.sprites[1].name = "barrel_fragment"
tt.render.sprites[1].animated = true
tt.render.sprites[1].anchor.x = 0.68
tt = E.register_t(E, "ps_barrel_fragment")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "barrel_fragment_trail"
tt.particle_system.animated = true
tt.particle_system.animation_fps = 60
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	0.2,
	0.4
}
tt.particle_system.emission_rate = 60
tt.particle_system.scale_var = {
	0.4,
	1
}
tt.particle_system.scales_x = {
	1,
	1.5
}
tt.particle_system.scales_y = {
	1,
	1.5
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.scale_same_aspect = false
tt = E.register_t(E, "fx_fragment_ground_explosion", "fx")
tt.render.sprites[1].name = "barrel_fragment_ground_explosion"
tt.render.sprites[1].anchor = v(0.5, 0.22)
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "decal_kraken", "decal_scripted")

E.add_comps(E, tt, "render", "sound_events")

tt.main_script.update = scripts3.decal_kraken.update
tt.render.sprites[1].prefix = "kraken_water"
tt.render.sprites[1].z = Z_DECALS
tt.duration = 3
tt.main_script.update = scripts2.hero_wilbur_ultimate.update
tt.sound_events.insert = "ElvesHeroDenasKingsguardTaunt"
tt.can_fire_fn = scripts2.hero_elves_denas_ultimate.can_fire_fn
tt = RT("guard_spawn")

E:add_comps(tt, "pos", "main_script", "sound_events", "render", "aura")

tt.cooldown = 0
tt.entity = "soldier_shell"
tt.main_script.update = scripts2.hero_veznan_ultimate.update
tt.pop_y_offset = 0
tt.can_fire_fn = scripts2.hero_veznan_ultimate.can_fire_fn
tt.mod = "mod_malik_stun"
tt.range = 65
tt.vis_bans = bor(F_BOSS)
tt.vis_flags = bor(F_MOD, F_STUN)
tt = RT("soldier_ingvar_ancestor2", "soldier_militia")

AC(tt, "reinforcement", "melee")

image_y = 60
image_x = 72
anchor_y = 0.1
tt.health.armor = 0.75
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 46)
tt.health.dead_lifetime = fts(30)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_enemies_0048"
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "SMALLSHELL"
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.remove = scripts.soldier_reinforcement.remove
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.range = 128
tt.motion.max_speed = FPS*2.3
tt.reinforcement.duration = 16
tt.reinforcement.fade = nil
tt.regen.cooldown = 1
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldier_ingvar_ancestor2"
tt.render.sprites[1].scale = v(0.5, 0.5)
tt.ui.click_rect = r(-13, 0, 26, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.price = 0
tt.vis.bans = bor(F_LYCAN, F_SKELETON, F_CANNIBALIZE)
tt = RT("soldier_ingvar_ancestor3", "soldier_militia")

AC(tt, "reinforcement", "melee")

image_y = 60
image_x = 72
anchor_y = 0.1
tt.health.magic_armor = 0.6
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 46)
tt.health.dead_lifetime = fts(30)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0021"
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "SMALLSPIDER"
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.remove = scripts.soldier_reinforcement.remove
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.range = 128
tt.motion.max_speed = FPS*2.3
tt.reinforcement.duration = 15
tt.reinforcement.fade = nil
tt.regen.cooldown = 1
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldier_ingvar_ancestor3"
tt.ui.click_rect = r(-13, 0, 26, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.price = 0
tt.vis.bans = bor(F_LYCAN, F_SKELETON, F_CANNIBALIZE)
tt = E.register_t(E, "hero_minotaur", "hero")

E.add_comps(E, tt, "melee", "timed_attacks")

image_y = 110
anchor_y = 0.26
tt.hero.level_stats.hp_max = {
	325,
	350,
	375,
	400,
	425,
	450,
	475,
	500,
	525,
	550
}
tt.hero.level_stats.regen_health = {
	23,
	25,
	27,
	29,
	30,
	32,
	34,
	36,
	38,
	50
}
tt.hero.level_stats.armor = {
	0.13,
	0.16,
	0.19,
	0.22,
	0.25,
	0.28,
	0.31,
	0.34,
	0.37,
	0.4
}
tt.hero.level_stats.damage_min = {
	15,
	17,
	19,
	21,
	23,
	25,
	27,
	29,
	30,
	32
}
tt.hero.level_stats.damage_max = {
	30,
	31,
	33,
	35,
	37,
	39,
	41,
	43,
	45,
	48
}
tt.hero.skills.bullrush = E.clone_c(E, "hero_skill")
tt.hero.skills.bullrush.xp_gain_factor = 15
tt.hero.skills.bullrush.damage_min = {
	40,
	50,
	60
}
tt.hero.skills.bullrush.damage_max = {
	40,
	50,
	60
}
tt.hero.skills.bullrush.run_damage_min = {
	20,
	35,
	50
}
tt.hero.skills.bullrush.run_damage_max = {
	20,
	35,
	50
}
tt.hero.skills.bullrush.duration = {
	2,
	3,
	4
}
tt.hero.skills.bloodaxe = E.clone_c(E, "hero_skill")
tt.hero.skills.bloodaxe.damage_factor = {
	2,
	3,
	4
}
tt.hero.skills.bloodaxe.xp_gain_factor = 7
tt.hero.skills.daedalusmaze = E.clone_c(E, "hero_skill")
tt.hero.skills.daedalusmaze.xp_gain_factor = 25
tt.hero.skills.daedalusmaze.duration = {
	2,
	4,
	6
}
tt.hero.skills.roaroffury = E.clone_c(E, "hero_skill")
tt.hero.skills.roaroffury.extra_damage = {
	0.25,
	0.5,
	0.75
}
tt.hero.skills.roaroffury.xp_gain_factor = 120
tt.hero.skills.doomspin = E.clone_c(E, "hero_skill")
tt.hero.skills.doomspin.damage_min = {
	40,
	60,
	80
}
tt.hero.skills.doomspin.damage_max = {
	80,
	100,
	120
}
tt.hero.skills.doomspin.xp_gain_factor = 25
tt.hero.skills.bullrush.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.bullrush.hr_icon = 66
tt.hero.skills.bullrush.hr_order = 1
tt.hero.skills.bloodaxe.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.bloodaxe.hr_icon = 67
tt.hero.skills.bloodaxe.hr_order = 2
tt.hero.skills.daedalusmaze.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.daedalusmaze.hr_icon = 68
tt.hero.skills.daedalusmaze.hr_order = 3
tt.hero.skills.roaroffury.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.roaroffury.hr_icon = 69
tt.hero.skills.roaroffury.hr_order = 4
tt.hero.skills.doomspin.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.doomspin.hr_icon = 70
tt.hero.skills.doomspin.hr_order = 5
tt.health.armor = nil
tt.health.dead_lifetime = 20
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 56)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_minotaur.level_up
tt.hero.tombstone_show_time = fts(90)
tt.idle_flip.cooldown = 10
tt.info.fn = scripts3.hero_minotaur.get_info
tt.info.hero_portrait = "hero_portraits_0018"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0022") or "info_portraits_heroes_0018"
tt.main_script.insert = scripts3.hero_minotaur.insert
tt.main_script.update = scripts3.hero_minotaur.update
tt.motion.max_speed = 90
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_minotaur"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.soldier.melee_slot_offset = v(20, 0)
tt.sound_events.change_rally_point = "HeroMinotaurTaunt"
tt.sound_events.death = "HeroMinotaurDeath"
tt.sound_events.respawn = "HeroMinotaurTauntIntro"
tt.sound_events.insert = "HeroMinotaurTauntIntro"
tt.sound_events.hero_room_select = "HeroMinotaurTauntSelect"
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.45
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "axe"
tt.melee.attacks[2].chance = 0.3333
tt.melee.attacks[2].damage_type = bor(DAMAGE_FX_EXPLODE, DAMAGE_TRUE)
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_decal = "decal_minotaur_bloodaxe"
tt.melee.attacks[2].hit_offset = v(40, -5)
tt.melee.attacks[2].hit_time = fts(18)
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].sound = "HeroMinotaurBloodAxe"
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = F_BLOCK
tt.melee.attacks[2].xp_from_skill = "bloodaxe"
tt.melee.range = 65
tt.melee.cooldown = fts(21) - 1.5 + fts(8)
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "spin"
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].damage_radius = 90
tt.timed_attacks.list[1].damage_type = DAMAGE_PHYSICAL
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(14)
tt.timed_attacks.list[1].max_range = tt.timed_attacks.list[1].damage_radius
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].sound = "HeroMinotaurDoomSpin"
tt.timed_attacks.list[2] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[2].animation = "roar"
tt.timed_attacks.list[2].cooldown = 30
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].excluded_templates = {
	"tower_barrack_1",
	"tower_barrack_2",
	"tower_barrack_3",
	"tower_paladin",
	"tower_barbarian",
	"tower_assassin",
	"tower_templar",
	"tower_blade",
	"tower_forest",
	"tower_barrack_amazonas",
	"tower_barrack_dwarf",
}
tt.timed_attacks.list[2].mod = "mod_minotaur_roaroffury"
tt.timed_attacks.list[2].sound = "HeroMinotaurRoarOfFury"
tt.timed_attacks.list[2].shoot_time = fts(9)
tt.timed_attacks.list[2].shoot_fx = "fx_minotaur_roarofury_scream"
tt.timed_attacks.list[3] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[3].animations = {
	"rush_start",
	"rush_loop",
	"rush_end"
}
tt.timed_attacks.list[3].cooldown = 12
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].damage_type = DAMAGE_PHYSICAL
tt.timed_attacks.list[3].max_range = 250
tt.timed_attacks.list[3].min_range = 100
tt.timed_attacks.list[3].mod = "mod_minotaur_stun"
tt.timed_attacks.list[3].sound = "HeroMinotaurBullRush"
tt.timed_attacks.list[3].speed_factor = 4
tt.timed_attacks.list[3].stun_range = 50
tt.timed_attacks.list[3].stun_vis_bans = bor(F_FLYING, F_CLIFF, F_WATER, F_FRIEND, F_BOSS, F_HERO)
tt.timed_attacks.list[3].stun_vis_flags = bor(F_RANGED, F_STUN)
tt.timed_attacks.list[3].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER, F_FRIEND, F_HERO)
tt.timed_attacks.list[3].vis_flags = bor(F_BLOCK, F_RANGED)
tt.timed_attacks.list[3].nodes_limit = 20
tt.timed_attacks.list[4] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[4].animation = "daedalus"
tt.timed_attacks.list[4].cooldown = 15
tt.timed_attacks.list[4].disabled = true
tt.timed_attacks.list[4].invalid_terrains = bor(TERRAIN_WATER, TERRAIN_CLIFF, TERRAIN_NOWALK)
tt.timed_attacks.list[4].max_range = 9999
tt.timed_attacks.list[4].min_range = 200
tt.timed_attacks.list[4].mod = "mod_minotaur_daedalus"
tt.timed_attacks.list[4].nodes_limit = 10
tt.timed_attacks.list[4].node_offset = -5
tt.timed_attacks.list[4].sound = "HeroMinotaurDaedalusMaze"
tt.timed_attacks.list[4].vis_flags = bor(F_BLOCK, F_RANGED, F_TELEPORT)
tt.timed_attacks.list[4].vis_bans = bor(F_BOSS, F_FLYING, F_CLIFF, F_WATER, F_STUN)
tt = E.register_t(E, "daedalus_enemy_decal", "decal_tween")
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.5,
		0
	}
}
tt = E.register_t(E, "mod_minotaur_daedalus", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = nil
tt.main_script.queue = scripts3.mod_minotaur_daedalus.queue
tt.main_script.update = scripts3.mod_minotaur_daedalus.update
tt.render.sprites[1].prefix = "stun"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "loop"
tt.render.sprites[1].sort_y_offset = -1
tt.render.sprites[1].hidden = true
tt = E.register_t(E, "decal_minotaur_daedalus", "decal_tween")
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	},
	{
		1,
		0
	}
}
tt.render.sprites[1].name = "minotaur_decal_"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "mod_minotaur_stun", "mod_shock_and_awe")
tt.modifier.duration = nil
tt = E.register_t(E, "mod_minotaur_dust", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.use_mod_offset = false
tt.modifier.duration = 999
tt.main_script.update = scripts3.mod_track_target.update
tt.render.sprites[1].name = "fx_minotaur_dust"
tt.render.sprites[1].loop = true
tt = E.register_t(E, "ps_minotaur_bullrush")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.alphas = {
	0,
	255,
	255,
	0
}
tt.particle_system.animated = false
tt.particle_system.emission_rate = 30
tt.particle_system.emit_area_spread = v(4, 4)
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.emit_speed = {
	15,
	30
}
tt.particle_system.emit_spread = math.pi
tt.particle_system.name = "minotaur_particle1"
tt.particle_system.particle_lifetime = {
	fts(8),
	fts(12)
}
tt.particle_system.scale_var = {
	0.8,
	1.2
}
tt.particle_system.scales_x = {
	0.5,
	1.5
}
tt.particle_system.scales_y = {
	0.5,
	1.5
}
tt = E.register_t(E, "mod_minotaur_roaroffury", "modifier")

E.add_comps(E, tt, "render", "tween")

tt.render.sprites[1].name = "minotaur_towerBuff_base_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.19166666666666668
tt.render.sprites[1].sort_y_offset = -1
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "decal_minotaur_roaroffury_horns"
tt.render.sprites[2].anchor.y = 0.19166666666666668
tt.render.sprites[2].sort_y_offset = -1
tt = E.register_t(E, "fx_minotaur_roarofury_scream", "fx")
tt.render.sprites[1].name = "fx_minotaur_roarofury_scream"
tt = E.register_t(E, "decal_minotaur_bloodaxe", "decal_tween")
tt.tween.props[1].keys = {
	{
		fts(50),
		255
	},
	{
		fts(60),
		0
	}
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "minotaur_axeDecal"
tt = E.register_t(E, "soldier_shell", "soldier_militia")

E.add_comps(E, tt, "melee")

image_y = 52
anchor_y = 0.17
tt.health.hp_max = 320
tt.health.armor = 0.75
tt.health_bar.offset = v(0, 25.16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_enemies_0048"
tt.info.random_name_count = 40
tt.info.random_name_format = "SOLDIER_RANDOM_%i_NAME"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 12
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 66
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 5
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia2"
tt.render.sprites[1].scale = v(0.5, 0.5)
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))
tt = E.register_t(E, "hero_dwarf_2", "stage_hero")

E.add_comps(E, tt, "melee")

image_y = 94
anchor_y = 0.26
tt.health.magic_armor = 0.9
tt.health.dead_lifetime = 30
tt.health.hp_max = 2800
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0071"
tt.main_script.insert = scripts3.hero_dwarf.insert
tt.main_script.update = scripts3.hero_dwarf.update
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].cooldown = 9e+99
tt.melee.attacks[2].damage_max = 120
tt.melee.attacks[2].damage_min = 60
tt.melee.attacks[2].damage_radius = 60
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].hit_decal = "fx_dwarf_area_quake"
tt.melee.attacks[2].hit_fx = "fx_dwarf_area_ring"
tt.melee.attacks[2].hit_offset = v(29, 0)
tt.melee.attacks[2].hit_time = fts(29)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.melee.range = 90
tt.motion.max_speed = FPS*2.4
tt.regen.cooldown = 1
tt.regen.health = 250
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf2"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt = E.register_t(E, "Soldier_Monster", "stage_hero")

E.add_comps(E, tt, "melee", "auras")

image_y = 94
anchor_y = 0.26
tt.health.magic_armor = 0.8
tt.health.dead_lifetime = 5
tt.health.hp_max = 750
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_soldier_death_spawns2_4"
tt.auras.list[2] = E.clone_c(E, "aura_attack")
tt.auras.list[2].cooldown = 0
tt.auras.list[2].name = "aura_soldier_death_spawns2_5"
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 5
tt.info.fn = scripts3.hero_basic.get_info_melee
tt.info.i18n_key = "MONSTER"
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0119"
tt.main_script.insert = scripts3.hero_dwarf.insert
tt.main_script.update = mylua.a_dwarf.update
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].count = 8
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 62.5
tt.melee.attacks[1].hit_fx = "fx_ground_hit2"
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(26)
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].cooldown = 9e+99
tt.melee.attacks[2].mod = "mod_teleport_arcane"
tt.melee.attacks[2].damage_max = 120
tt.melee.attacks[2].damage_min = 60
tt.melee.attacks[2].damage_radius = 60
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].hit_decal = "fx_dwarf_area_quake"
tt.melee.attacks[2].hit_fx = "fx_dwarf_area_ring"
tt.melee.attacks[2].hit_offset = v(29, 0)
tt.melee.attacks[2].hit_time = fts(29)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.melee.range = 135
tt.motion.max_speed = FPS*1.8
tt.regen.cooldown = 1
tt.regen.health = 3
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "Soldier_Monster"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.soldier.melee_slot_offset.x = 10
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt = RT("Soldier_Monster2", "soldier_militia")

AC(tt, "reinforcement", "melee")

image_y = 60
image_x = 72
anchor_y = 0.1
tt.health.magic_armor = 0.6
tt.health.hp_max = 300
tt.health_bar.offset = v(0, 46)
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health.dead_lifetime = fts(30)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0021"
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "MONSTER"
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.remove = scripts.soldier_reinforcement.remove
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].count = 9e+99
tt.melee.attacks[1].damage_max = 160
tt.melee.attacks[1].damage_min = 80
tt.melee.attacks[1].damage_radius = 62.5
tt.melee.attacks[1].hit_fx = "fx_ground_hit2"
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(26)
tt.melee.range = 158
tt.motion.max_speed = FPS*2.8
tt.reinforcement.duration = 5
tt.reinforcement.fade = nil
tt.regen.cooldown = 1
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].alpha = 180
tt.render.sprites[1].prefix = "soldiermilitia555"
tt.ui.click_rect = r(-13, 0, 26, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.price = 0
tt.vis.bans = bor(F_LYCAN, F_SKELETON, F_CANNIBALIZE)
tt = E.register_t(E, "hero_wizard", "hero")

E.add_comps(E, tt, "teleport", "melee", "ranged", "timed_attacks")

anchor_y = 0.22
image_y = 78
tt.hero.level_stats.hp_max = {
	115,
	130,
	145,
	160,
	175,
	190,
	205,
	220,
	235,
	250
}
tt.hero.level_stats.regen_health = {
	12,
	13,
	15,
	16,
	18,
	19,
	21,
	22,
	24,
	25
}
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.melee_damage_min = {
	3,
	4,
	4,
	5,
	5,
	6,
	6,
	7,
	7,
	8
}
tt.hero.level_stats.melee_damage_max = {
	9,
	11,
	12,
	14,
	15,
	17,
	18,
	20,
	21,
	23
}
tt.hero.level_stats.ranged_damage_min = {
	27,
	30,
	33,
	36,
	39,
	42,
	45,
	48,
	51,
	54
}
tt.hero.level_stats.ranged_damage_max = {
	45,
	48,
	51,
	54,
	57,
	60,
	63,
	66,
	69,
	72
}
tt.hero.skills.magicmissile = E.clone_c(E, "hero_skill")
tt.hero.skills.magicmissile.count = {
	5,
	10,
	15
}
tt.hero.skills.magicmissile.damage = {
	20,
	25,
	30
}
tt.hero.skills.magicmissile.xp_gain_factor = 15
tt.hero.skills.chainspell = E.clone_c(E, "hero_skill")
tt.hero.skills.chainspell.bounces = {
	1,
	2,
	3
}
tt.hero.skills.chainspell.xp_gain_factor = 20
tt.hero.skills.disintegrate = E.clone_c(E, "hero_skill")
tt.hero.skills.disintegrate.total_damage = {
	400,
	600,
	800
}
tt.hero.skills.disintegrate.count = {
	10,
	15,
	20
}
tt.hero.skills.disintegrate.xp_gain_factor = 100
tt.hero.skills.arcanereach = E.clone_c(E, "hero_skill")
tt.hero.skills.arcanereach.extra_range_factor = {
	0.25,
	0.5,
	0.75
}
tt.hero.skills.arcanefocus = E.clone_c(E, "hero_skill")
tt.hero.skills.arcanefocus.extra_damage = {
	18,
	27,
	36
}
tt.hero.skills.magicmissile.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.magicmissile.hr_icon = 32
tt.hero.skills.magicmissile.hr_order = 1
tt.hero.skills.chainspell.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.chainspell.hr_icon = 31
tt.hero.skills.chainspell.hr_order = 2
tt.hero.skills.disintegrate.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.disintegrate.hr_icon = 35
tt.hero.skills.disintegrate.hr_order = 3
tt.hero.skills.arcanereach.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.arcanereach.hr_icon = 33
tt.hero.skills.arcanereach.hr_order = 4
tt.hero.skills.arcanefocus.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.arcanefocus.hr_icon = 34
tt.hero.skills.arcanefocus.hr_order = 5
tt.health.armor = nil
tt.health.dead_lifetime = 15
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 36)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts2.hero_wizard.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts2.hero_wizard.get_info
tt.info.hero_portrait = "hero_portraits_0006"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0006") or "info_portraits_heroes_0006"
tt.info.damage_icon = "magic"
tt.main_script.insert = scripts2.hero_wizard.insert
tt.main_script.update = scripts2.hero_wizard.update
tt.motion.max_speed = 45
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_wizard"
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HeroWizardTaunt"
tt.sound_events.death = "HeroWizardDeath"
tt.sound_events.respawn = "HeroWizardTauntIntro"
tt.sound_events.insert = "HeroWizardTauntIntro"
tt.sound_events.hero_room_select = "HeroWizardTauntSelect"
tt.teleport.min_distance = 100
tt.teleport.sound = "HeroWizardTeleport"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -0.16)
tt.unit.mod_offset = v(0, 12.84)
tt.melee.range = 40
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].damage_type = DAMAGE_MAGICAL
tt.melee.attacks[1].xp_gain_factor = 0.45
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].animation = "disintegrate"
tt.timed_attacks.list[1].hit_time = fts(15)
tt.timed_attacks.list[1].max_range = 60
tt.timed_attacks.list[1].damage_radius = 150
tt.timed_attacks.list[1].cooldown = 30
tt.timed_attacks.list[1].vis_bans = bor(F_CLIFF, F_BOSS)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].total_damage = nil
tt.timed_attacks.list[1].count = nil
tt.timed_attacks.list[1].sound = "HeroWizardDesintegrate"
tt.timed_attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].bullet = "missile_wizard"
tt.timed_attacks.list[2].bullet_start_offset = {
	v(-16, 36)
}
tt.timed_attacks.list[2].shoot_times = {
	fts(3)
}
tt.timed_attacks.list[2].loops = nil
tt.timed_attacks.list[2].animations = {
	"missile_start",
	"missile_loop",
	"missile_end"
}
tt.timed_attacks.list[2].cooldown = 15
tt.timed_attacks.list[2].max_range = 350
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].sound = "HeroWizardMissileSummon"
tt.timed_attacks.list[2].xp_from_skill = "magicmissile"
tt.ranged.forced_cooldown = 1.5
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].bullet = "ray_wizard"
tt.ranged.attacks[1].bullet_start_offset = {
	v(17, 35)
}
tt.ranged.attacks[1].check_target_before_shot = true
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].node_prediction = fts(19)
tt.ranged.attacks[1].shoot_time = fts(19)
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].cooldown = 6
tt.ranged.attacks[2].bullet = "ray_wizard_chain"
tt.ranged.attacks[2].xp_from_skill = "chainspell"
tt = E.register_t(E, "fx_wizard_disintegrate", "fx")
tt.render.sprites[1].name = "fx_wizard_disintegrate"
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "ray_wizard", "bullet")
tt.bullet.xp_gain_factor = 0.45
tt.bullet.mod = "mod_ray_wizard"
tt.bullet.hit_time = fts(1)
tt.bullet.hit_fx = "fx_ray_wizard"
tt.image_width = 114
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_wizard"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "HeroWizardShoot"
tt.bounces = 0
tt.seen_targets = {}
tt.main_script.insert = scripts2.ray_wizard_chain.insert
tt.main_script.update = scripts2.ray_wizard_chain.update
tt = E.register_t(E, "ray_wizard_chain", "ray_wizard")
tt.bounces = nil
tt.bounce_range = 125
tt.bounce_vis_flags = F_RANGED
tt.bounce_vis_bans = 0
tt.bullet.xp_gain_factor = nil
tt = E.register_t(E, "mod_ray_wizard", "modifier")
tt.modifier.duration = fts(18)
tt.damage_min = nil
tt.damage_max = nil
tt.damage_type = DAMAGE_MAGICAL
tt.damage_every = 0.03333333333333333
tt.pop = {
	"pop_bzzt"
}
tt.pop_chance = 1
tt.pop_conds = DR_KILL
tt.main_script.insert = scripts2.mod_ray_wizard.insert
tt.main_script.update = scripts2.mod_ray_wizard.update
tt = E.register_t(E, "fx_ray_wizard", "fx")
tt.render.sprites[1].name = "ray_wizard_ball"
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].loop = false
tt = E.register_t(E, "missile_wizard", "bullet")
tt.render.sprites[1].prefix = "missile_wizard"
tt.bullet.retarget_range = 9999
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.min_speed = 270
tt.bullet.max_speed = 330
tt.bullet.turn_speed = (math.pi*20)/180*30
tt.bullet.acceleration_factor = 0.1
tt.bullet.hit_fx = "fx_missile_wizard_hit"
tt.bullet.hit_fx_air = "fx_missile_wizard_hit"
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.vis_flags = F_RANGED
tt.main_script.update = scripts2.missile.update
tt.main_script.insert = scripts2.missile_wizard.insert
tt.sound_events.hit = "HeroWizardMissileHit"
tt = E.register_t(E, "fx_missile_wizard_hit", "fx")
tt.render.sprites[1].name = "missile_wizard_hit"
tt.render.sprites[1].z = Z_BULLETS
tt = E.register_t(E, "ps_missile_wizard")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "missile_wizard_trail"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	0.3,
	0.3
}
tt.particle_system.emission_rate = 50
tt = E.register_t(E, "ps_missile_wizard_sparks")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "missile_wizard_sparks1"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.track_rotation = true
tt.particle_system.particle_lifetime = {
	0.35,
	0.35
}
tt.particle_system.emission_rate = 20
tt = E.register_t(E, "hero_dwarf_3", "stage_hero")

E.add_comps(E, tt, "melee")

anchor_y = 0.17010309278350516
anchor_x = 0.5
image_y = 194
image_x = 214
tt.health.magic_armor = 0
tt.health.dead_lifetime = 30
tt.health.hp_max = 6666
tt.health_bar.offset = v(0, 43)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_0113"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0056"
tt.main_script.insert = scripts3.hero_dwarf.insert
tt.main_script.update = scripts3.hero_dwarf.update
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 8
tt.melee.attacks[1].damage_min = 666
tt.melee.attacks[1].damage_max = 999
tt.melee.attacks[1].damage_radius = 75
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_offset = v(-10, -2)
tt.melee.attacks[1].hit_time = fts(17)
tt.melee.attacks[1].hit_decal = "decal_veznan_strike"
tt.melee.attacks[1].sound_hit = "VeznanAttack"
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].cooldown = 9e+99
tt.melee.attacks[2].damage_max = 120
tt.melee.attacks[2].damage_min = 60
tt.melee.attacks[2].damage_radius = 60
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].hit_decal = "fx_dwarf_area_quake"
tt.melee.attacks[2].hit_fx = "fx_dwarf_area_ring"
tt.melee.attacks[2].hit_offset = v(29, 0)
tt.melee.attacks[2].hit_time = fts(29)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_0113"
tt.melee.range = 90
tt.motion.max_speed = FPS*2.4
tt.regen.cooldown = 1
tt.regen.health = 250
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf3"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 12)
tt = E.register_t(E, "hero_dwarf_4", "stage_hero")

E.add_comps(E, tt, "melee", "auras")

image_y = 94
anchor_y = 0.26
tt.health.armor = 0.75
tt.health.dead_lifetime = 30
tt.health.hp_max = 800
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0071"
tt.main_script.insert = scripts3.hero_dwarf.insert
tt.main_script.update = mylua.a_dwarf.update
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_soldier_death_spawns_3"
tt.auras.list[2] = E.clone_c(E, "aura_attack")
tt.auras.list[2].cooldown = 0
tt.auras.list[2].name = "aura_soldier_death_spawns_4"
tt.hero_insert = false
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 80
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
"twoface_spawns"
}
tt.melee.attacks[1].pop_chance = 0.02
tt.melee.attacks[1].mod = "mod_twoface_damage_extra"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].sound = "TwoFaceAttackSound"
tt.melee.attacks[2].mod = "mod_possess"
tt.melee.attacks[2].chance = 0.05
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.melee.range = 90
tt.motion.max_speed = FPS*3.5
tt.regen.cooldown = 1
tt.regen.health = 10
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf514"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt = E.register_t(E, "hero_dwarf_5", "stage_hero")

E.add_comps(E, tt, "melee", "auras")

image_y = 94
anchor_y = 0.26
tt.health.armor = 0.75
tt.health.dead_lifetime = 30
tt.health.hp_max = 400
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0071"
tt.main_script.insert = scripts3.hero_dwarf.insert
tt.main_script.update = mylua.a_dwarf.update
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "hero_re_farmer"
tt.auras.list[2] = E.clone_c(E, "aura_attack")
tt.auras.list[2].cooldown = 0
tt.auras.list[2].name = "hero_death_spawns"
tt.hero_insert = true
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].pop = {
"twoface_spawns"
}
tt.melee.attacks[1].pop_chance = 0.02
tt.melee.attacks[1].mod = "mod_twoface_damage_extra"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].sound = "TwoFaceAttackSound"
tt.melee.attacks[2].mod = "mod_possess"
tt.melee.attacks[2].chance = 0.05
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.melee.range = 90
tt.motion.max_speed = FPS*3.5
tt.regen.cooldown = 1
tt.regen.health = 10
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf514"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.render.sprites[1].alpha = 180
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt = E.register_t(E, "hero_dwarf_6", "stage_hero")

E.add_comps(E, tt, "melee", "auras")

image_y = 94
anchor_y = 0.26
tt.health.armor = 0.75
tt.health.dead_lifetime = 30
tt.health.hp_max = 800
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0071"
tt.main_script.insert = scripts3.hero_dwarf.insert
tt.main_script.update = mylua.a_dwarf.update
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "hero_re_farmer2"
tt.hero_insert = true
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 325
tt.melee.attacks[1].damage_min = 250
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].mod = "mod_twoface_damage_extra"
tt.melee.attacks[1].pop = {
"twoface_spawns"
}
tt.melee.attacks[1].pop_chance = 0.04
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].sound = "TwoFaceAttackSound"
tt.melee.attacks[2].mod = "mod_possess"
tt.melee.attacks[2].chance = 0.05
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0002") or "hero_portraits_6666"
tt.melee.range = 90
tt.motion.max_speed = FPS*3.5
tt.regen.cooldown = 1
tt.regen.health = 10
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf514"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	},
	idle = {
	"idle"
	}
}
tt.render.sprites[1].alpha = 180
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		0.7,
		0.7,
		1.55,
	}
}
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt = RT("twoface_spawns", "decal_scripted")

tt.pop_y_offset = 0
tt.main_script.update = mylua.hero_insert.update
tt.entity = "hero_dwarf_5"
tt.entity_max = 9e+99
tt = E.register_t(E, "hero_dracolich", "hero")

E.add_comps(E, tt, "ranged", "timed_attacks")

image_y = 308
anchor_y = 0.12962962962962962
tt.hero.level_stats.hp_max = {
	425,
	450,
	475,
	500,
	525,
	550,
	575,
	600,
	625,
	650
}
tt.hero.level_stats.regen_health = {
	17,
	18,
	19,
	20,
	21,
	22,
	23,
	24,
	25,
	26
}
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.ranged_damage_min = {
	6,
	8,
	9,
	11,
	12,
	14,
	15,
	17,
	18,
	30
}
tt.hero.level_stats.ranged_damage_max = {
	18,
	23,
	27,
	32,
	36,
	41,
	45,
	50,
	54,
	60
}
tt.hero.level_stats.disease_damage = {
	2,
	2,
	3,
	3,
	4,
	4,
	5,
	5,
	6,
	9
}
tt.hero.skills.spinerain = E.clone_c(E, "hero_skill")
tt.hero.skills.spinerain.count = {
	6,
	8,
	30
}
tt.hero.skills.spinerain.damage_min = {
	12,
	16,
	25
}
tt.hero.skills.spinerain.damage_max = {
	36,
	40,
	45
}
tt.hero.skills.spinerain.xp_gain_factor = 60
tt.hero.skills.bonegolem = E.clone_c(E, "hero_skill")
tt.hero.skills.bonegolem.hp_max = {
	80,
	120,
	250
}
tt.hero.skills.bonegolem.damage_min = {
	2,
	4,
	8
}
tt.hero.skills.bonegolem.damage_max = {
	6,
	8,
	12
}
tt.hero.skills.bonegolem.duration = {
	20,
	30,
	60
}
tt.hero.skills.bonegolem.xp_gain_factor = 30
tt.hero.skills.plaguecarrier = E.clone_c(E, "hero_skill")
tt.hero.skills.plaguecarrier.xp_gain_factor = 120
tt.hero.skills.plaguecarrier.count = {
	6,
	8,
	25
}
tt.hero.skills.plaguecarrier.duration = {
	4,
	5,
	15
}
tt.hero.skills.diseasenova = E.clone_c(E, "hero_skill")
tt.hero.skills.diseasenova.xp_gain_factor = 120
tt.hero.skills.diseasenova.damage_min = {
	50,
	100,
	200
}
tt.hero.skills.diseasenova.damage_max = {
	50,
	100,
	200
}
tt.hero.skills.unstabledisease = E.clone_c(E, "hero_skill")
tt.hero.skills.unstabledisease.spread_damage = {
	30,
	60,
	100
}
tt.hero.skills.unstabledisease.xp_gain_factor = 5
tt.hero.use_custom_spawn_point = true
tt.hero.skills.spinerain.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.spinerain.hr_icon = 61
tt.hero.skills.spinerain.hr_order = 1
tt.hero.skills.bonegolem.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.bonegolem.hr_icon = 62
tt.hero.skills.bonegolem.hr_order = 2
tt.hero.skills.plaguecarrier.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.plaguecarrier.hr_icon = 63
tt.hero.skills.plaguecarrier.hr_order = 3
tt.hero.skills.diseasenova.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.diseasenova.hr_icon = 64
tt.hero.skills.diseasenova.hr_order = 4
tt.hero.skills.unstabledisease.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.unstabledisease.hr_icon = 65
tt.hero.skills.unstabledisease.hr_order = 5
tt.health.armor = 0
tt.health.dead_lifetime = 30
tt.health.hp_max = 114514
tt.health_bar.offset = v(0, 157)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.draw_order = -1
tt.health_bar.sort_y_offset = -200
tt.hero.fn_level_up = scripts3.hero_dracolich.level_up
tt.hero.tombstone_show_time = nil
tt.hero.level = 10
tt.hero.skills.spinerain.level = 3
tt.hero.skills.bonegolem.level = 3
tt.hero.skills.plaguecarrier.level = 3
tt.hero.skills.diseasenova.level = 3
tt.hero.skills.unstabledisease.level = 3
tt.idle_flip.cooldown = 10
tt.info.fn = scripts3.hero_dracolich.get_info
tt.info.hero_portrait = "hero_portraits_1234"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0019") or "info_portraits_heroes_1234"
tt.info.damage_icon = "magic"
tt.info.i18n_key = "HERO_DRACOLICH"
tt.main_script.insert = scripts3.hero_dracolich.insert
tt.main_script.update = scripts3.hero_dracolich.update
tt.motion.max_speed = 90
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.regen.cooldown = 1
tt.regen.health = 1919810
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_dracolich"
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].sort_y_offset = -200
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "Halloween_hero_bones_layer1_0160"
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].alpha = 100
tt.sound_events.change_rally_point = "HeroDracolichTaunt"
tt.sound_events.death = "HeroDracolichDeath"
tt.sound_events.respawn = "HeroDracolichRespawn"
tt.sound_events.insert = "HeroDracolichTauntIntro"
tt.sound_events.hero_room_select = "HeroDracolichTauntSelect"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-35, 50, 70, 70)) or r(-25, 70, 50, 45)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 98)
tt.unit.hide_after_death = true
tt.unit.marker_offset = v(0, -0.15)
tt.unit.mod_offset = v(0, 101)
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_POISON)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].bullet = "fireball_dracolich"
tt.ranged.attacks[1].bullet_start_offset = {
	v(35, 85)
}
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 120
tt.ranged.attacks[1].shoot_time = fts(16)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].animation = "range_attack"
tt.ranged.attacks[1].estimated_flight_time = 1
tt.ranged.attacks[1].sound = "HeroDracolichAttack"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animation = "golem"
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_dracolich_golem"
tt.timed_attacks.list[1].sound = "HeroDracolichSpawnDog"
tt.timed_attacks.list[1].spawn_time = fts(10)
tt.timed_attacks.list[1].vis_flags = F_BLOCK
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].min_range = 25
tt.timed_attacks.list[1].max_range = 75
tt.timed_attacks.list[2] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[2].animation = "spinerain"
tt.timed_attacks.list[2].cooldown = 20
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "dracolich_spine"
tt.timed_attacks.list[2].spawn_time = fts(11)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 125
tt.timed_attacks.list[3] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[3].animation = "nova"
tt.timed_attacks.list[3].cooldown = 29
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].damage_max = 1919810
tt.timed_attacks.list[3].damage_min = 114514
tt.timed_attacks.list[3].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[3].hit_time = fts(20)
tt.timed_attacks.list[3].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[3].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[3].min_range = 0
tt.timed_attacks.list[3].max_range = 75
tt.timed_attacks.list[3].min_count = 3
tt.timed_attacks.list[3].sound = "HeroDracolichKamikaze"
tt.timed_attacks.list[3].respawn_delay = 1
tt.timed_attacks.list[3].respawn_sound = "HeroDracolichRespawn"
tt.timed_attacks.list[3].mod = "mod_dracolich_disease"
tt.timed_attacks.list[4] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[4].animation = "plague"
tt.timed_attacks.list[4].cooldown = 20
tt.timed_attacks.list[4].disabled = true
tt.timed_attacks.list[4].entity = "dracolich_plague_carrier"
tt.timed_attacks.list[4].spawn_offset = v(43, 81)
tt.timed_attacks.list[4].spawn_time = fts(11)
tt.timed_attacks.list[4].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[4].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[4].range_nodes_max = 50
tt.timed_attacks.list[4].range_nodes_min = 10
tt.timed_attacks.list[4].sound = "HeroDracolichSoulsPlague"
tt.timed_attacks.list[4].count = 114514
tt = E.register_t(E, "fx_fireball_dracolich_decal", "decal_tween")
tt.render.sprites[1].name = "Halloween_hero_bones_proyExplosion_decal"
tt.render.sprites[1].animated = false
tt.tween.props[1].keys = {
	{
		fts(17),
		255
	},
	{
		fts(27),
		0
	}
}
tt = E.register_t(E, "fx_fireball_dracolich_ground", "fx")
tt.render.sprites[1].name = "fx_dracolich_fireball_explosion_ground"
tt.render.sprites[1].anchor.y = 0.20512820512820512
tt.render.sprites[1].sort_y_offset = -5
tt = E.register_t(E, "fx_fireball_dracolich_air", "fx")
tt.render.sprites[1].name = "fx_dracolich_fireball_explosion_air"
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].scale = v(0.7, 0.7)
tt = E.register_t(E, "fx_dracolich_nova_cloud", "decal_tween")
tt.render.sprites[1].name = "Halloween_hero_bones_particle"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = v(0.75, 0.75)
tt.tween.props[1].keys = {
	{
		0,
		127
	},
	{
		fts(20),
		0
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "offset"
tt.tween.props[2].keys = {}
tt = E.register_t(E, "fx_dracolich_nova_explosion", "fx")
tt.render.sprites[1].name = "fx_dracolich_explosion"
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].sort_y_offset = -1
tt = E.register_t(E, "fx_dracolich_nova_decal", "decal_tween")
tt.render.sprites[1].name = "Halloween_hero_bones_explosion_decal"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].keys = {
	{
		fts(40),
		255
	},
	{
		fts(45),
		0
	}
}
tt = E.register_t(E, "dracolich_spine", "bullet")

E.add_comps(E, tt, "tween")

tt.main_script.update = scripts3.dracolich_spine.update
tt.bullet.damage_max = 114514000
tt.bullet.damage_min = 1919810
tt.bullet.damage_radius = 50
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = F_FRIEND
tt.bullet.mod = "mod_dracolich_disease"
tt.bullet.hit_time = fts(4)
tt.bullet.duration = 2
tt.render.sprites[1].prefix = "dracolich_spine"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].anchor.y = 0.09027777777777778
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "Halloween_hero_bones_attackDecal"
tt.render.sprites[2].z = Z_DECALS
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(3),
		0
	},
	{
		fts(6),
		255
	},
	{
		tt.bullet.duration,
		255
	},
	{
		tt.bullet.duration + fts(10),
		0
	}
}
tt.tween.props[1].sprite_id = 2
tt.sound_events.delayed_insert = "HeroDracolichBoneRain"
tt = E.register_t(E, "ps_fireball_dracolich")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "dracolich_fireball_particle_1"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(16)
}
tt.particle_system.scale_var = {
	0.78,
	1.43
}
tt.particle_system.scales_x = {
	1,
	1.25
}
tt.particle_system.scales_y = {
	1,
	1.25
}
tt.particle_system.emission_rate = 20
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.alphas = {
	255,
	0
}
tt = E.register_t(E, "fireball_dracolich", "bullet")
tt.render.sprites[1].name = "Halloween_hero_bones_proy"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor.x = 0.69
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.min_speed = 390
tt.bullet.max_speed = 390
tt.bullet.hit_fx = "fx_fireball_dracolich_ground"
tt.bullet.hit_fx_air = "fx_fireball_dracolich_air"
tt.bullet.hit_decal = "fx_fireball_dracolich_decal"
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 40
tt.bullet.xp_gain_factor = 0.8
tt.bullet.particles_name = "ps_fireball_dracolich"
tt.bullet.vis_flags = F_RANGED
tt.bullet.mod = nil
tt.main_script.update = scripts3.fireball_dragon.update
tt.sound_events.hit = "HeroDragonAttackHit"
tt = E.register_t(E, "mod_dracolich_disease", "modifier")

E.add_comps(E, tt, "render", "dps")

tt.modifier.duration = 4
tt.modifier.vis_flags = F_MOD
tt.render.sprites[1].prefix = "dracolich_disease"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt.dps.damage_min = 114514
tt.dps.damage_max = 1919810
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 1
tt.dps.kill = true
tt.spread_active = false
tt.spread_radius = 60
tt.spread_damage = nil
tt.spread_fx = "fx_dracolich_disease_explosion"
tt.main_script.insert = scripts3.mod_dps.insert
tt.main_script.update = scripts3.mod_dps.update
tt.main_script.remove = scripts3.mod_dracolich_disease.remove
tt = E.register_t(E, "fx_dracolich_disease_explosion", "fx")
tt.render.sprites[1].name = "dracolich_disease_explosion"
tt = E.register_t(E, "fx_dracolich_skeleton_glow", "fx")
tt.render.sprites[1].name = "fx_dracolich_skeleton_glow"
tt = E.register_t(E, "soldier_dracolich_golem", "soldier")

E.add_comps(E, tt, "melee", "nav_grid", "reinforcement")

image_y = 48
anchor_y = 0.16666666666666666
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0021") or "info_portraits_heroes_0222"
tt.health.armor = 0
tt.health.hp_max = 114514
tt.health_bar.offset = v(0, 36)
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.reinforcement.duration = 1919810
tt.reinforcement.fade = false
tt.main_script.insert = scripts3.soldier_reinforcement.insert
tt.main_script.update = scripts3.soldier_reinforcement.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 1919810
tt.melee.attacks[1].damage_min = 114514
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 85
tt.motion.max_speed = 60
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_dracolich_golem"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.soldier.melee_slot_offset.x = 20
tt.sound_events.death = "DeathSkeleton"
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, 18)
tt.unit.explode_fx = nil
tt.vis.bans = bor(F_POISON, F_SKELETON, F_LYCAN, F_CANNIBALIZE)
tt = E.register_t(E, "dracolich_plague_carrier", "aura")

E.add_comps(E, tt, "render", "nav_path", "motion", "tween")

tt.aura.duration = 114514
tt.aura.duration_var = 0.5
tt.aura.damage_min = 10
tt.aura.damage_max = 15
tt.aura.damage_radius = 45
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.damage_cycle = fts(3)
tt.aura.damage_flags = F_AREA
tt.aura.damage_bans = 0
tt.aura.mod = "mod_dracolich_disease"
tt.motion.max_speed = FPS*3.5
tt.motion.max_speed_var = FPS*0.25
tt.main_script.insert = scripts3.dracolich_plague_carrier.insert
tt.main_script.update = scripts3.dracolich_plague_carrier.update
tt.render.sprites[1].name = "dracolich_plague_carrier"
tt.render.sprites[1].sort_y_offset = -21
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.disabled = true
tt.tween.remove = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		tt.aura.duration_var,
		0
	}
}
tt = E.register_t(E, "ps_dracolich_plague", "ps_bolt_necromancer_trail")
tt.particle_system.particle_lifetime = {
	fts(15),
	fts(25)
}
tt.particle_system.scales_x = {
	0.75,
	2.5
}
tt.particle_system.scales_y = {
	0.75,
	2.5
}
tt.particle_system.scale_var = {
	0.5,
	1
}
tt.particle_system.emission_rate = 10
tt.particle_system.sort_y_offset = -20
tt.particle_system.z = Z_OBJECTS
tt = RT("ps_durax_transfer")

AC(tt, "pos", "particle_system")

tt.particle_system.name = "ps_durax_transfer"
tt.particle_system.animated = true
tt.particle_system.animation_fps = 15
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(12),
	fts(12)
}
tt.particle_system.emission_rate = 30
tt.particle_system.emit_offset = v(0, 16)
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.sort_y_offset = 2
tt = RT("ps_durax_clone_transfer", "ps_durax_transfer")
tt.particle_system.alphas = {
	150
}
tt = RT("fx_durax_ultimate_fang_1", "decal_tween")
tt.render.sprites[1].name = "fx_durax_ultimate_fang_1"
tt.render.sprites[1].anchor.y = 0.26666666666666666
tt.render.sprites[1].loop = false
tt.render.sprites[1].size_scales = {
	vv(0.7),
	vv(1),
	vv(1)
}
tt.tween.props[1].keys = {
	{
		1,
		255
	},
	{
		1.2,
		0
	}
}
tt = RT("fx_durax_ultimate_fang_2", "fx_durax_ultimate_fang_1")
tt.render.sprites[1].name = "fx_durax_ultimate_fang_2"
tt = RT("fx_durax_ultimate_fang_extra_1", "decal_tween")
tt.render.sprites[1].name = "fx_durax_ultimate_fang_extra_1"
tt.render.sprites[1].anchor.y = 0.20588235294117646
tt.render.sprites[1].loop = false
tt.tween.props[1].keys = {
	{
		1,
		255
	},
	{
		1.2,
		0
	}
}
tt = RT("fx_durax_ultimate_fang_extra_2", "fx_durax_ultimate_fang_extra_1")
tt.render.sprites[1].name = "fx_durax_ultimate_fang_extra_2"
tt = E.register_t(E, "fx_ray_durax_hit", "fx")
tt.render.sprites[1].name = "fx_ray_durax_hit"
tt = RT("fx_shardseed_hit", "fx")

AC(tt, "sound_events")

tt.render.sprites[1].name = "fx_shardseed_hit"
tt.render.sprites[1].anchor.y = 0.46296296296296297
tt.sound_events.insert = "ElvesHeroDuraxShardSpearHit"
tt = RT("decal_durax", "decal")
tt.render.sprites[1].name = "aura_durax"
tt = E.register_t(E, "hero_pirate", "hero")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks", "pickpocket")

anchor_y = 0.18
image_y = 88
tt.hero.level_stats.hp_max = {
	225,
	250,
	275,
	300,
	325,
	350,
	375,
	400,
	425,
	450
}
tt.hero.level_stats.armor = {
	0.1,
	0.11,
	0.12,
	0.14,
	0.15,
	0.16,
	0.17,
	0.18,
	0.19,
	0.2
}
tt.hero.level_stats.regen_health = {
	23,
	25,
	28,
	30,
	33,
	35,
	38,
	40,
	43,
	45
}
tt.hero.level_stats.melee_damage_min = {
	7,
	8,
	10,
	12,
	13,
	15,
	17,
	18,
	20,
	22
}
tt.hero.level_stats.melee_damage_max = {
	12,
	16,
	19,
	22,
	25,
	28,
	31,
	34,
	37,
	41
}
tt.hero.level_stats.ranged_damage_min = {
	45,
	50,
	55,
	60,
	65,
	70,
	75,
	80,
	85,
	90
}
tt.hero.level_stats.ranged_damage_max = {
	69,
	72,
	79,
	85,
	90,
	98,
	105,
	114,
	121,
	128
}
tt.hero.fn_level_up = scripts3.hero_pirate.level_up
tt.hero.tombstone_show_time = fts(60)
tt.hero.skills.swordsmanship = E.clone_c(E, "hero_skill")
tt.hero.skills.swordsmanship.extra_damage = {
	3,
	9,
	18
}
tt.hero.skills.looting = E.clone_c(E, "hero_skill")
tt.hero.skills.looting.percent = {
	0.1,
	0.2,
	0.4
}
tt.hero.skills.toughness = E.clone_c(E, "hero_skill")
tt.hero.skills.toughness.hp_max = {
	30,
	90,
	180
}
tt.hero.skills.toughness.regen = {
	15,
	30,
	45
}
tt.hero.skills.kraken = E.clone_c(E, "hero_skill")
tt.hero.skills.kraken.slow_factor = {
	0.75,
	0.5,
	0.25
}
tt.hero.skills.kraken.max_enemies = {
	4,
	5,
	8
}
tt.hero.skills.kraken.xp_gain_factor = 70
tt.hero.skills.scattershot = E.clone_c(E, "hero_skill")
tt.hero.skills.scattershot.fragments = {
	4,
	6,
	9
}
tt.hero.skills.scattershot.fragment_damage = {
	15,
	18,
	20
}
tt.hero.skills.scattershot.xp_gain_factor = 45
tt.hero.skills.swordsmanship.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.swordsmanship.hr_icon = (IS_PHONE_OR_TABLET and 9) or 14
tt.hero.skills.swordsmanship.hr_order = 1
tt.hero.skills.looting.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.looting.hr_icon = (IS_PHONE_OR_TABLET and 6) or 11
tt.hero.skills.looting.hr_order = 2
tt.hero.skills.toughness.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.toughness.hr_icon = (IS_PHONE_OR_TABLET and 10) or 15
tt.hero.skills.toughness.hr_order = 3
tt.hero.skills.scattershot.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.scattershot.hr_icon = (IS_PHONE_OR_TABLET and 7) or 12
tt.hero.skills.scattershot.hr_order = 4
tt.hero.skills.kraken.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.kraken.hr_icon = (IS_PHONE_OR_TABLET and 8) or 13
tt.hero.skills.kraken.hr_order = 5
tt.health.armor = tt.hero.level_stats.armor[1]
tt.health.dead_lifetime = 20
tt.health.hp_max = tt.hero.level_stats.hp_max[1]
tt.health_bar.offset = v(0, 38.16)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.idle_flip.cooldown = 1
tt.info.fn = scripts3.hero_pirate.get_info
tt.info.hero_portrait = "hero_portraits_0004"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0004") or "info_portraits_heroes_0004"
tt.main_script.insert = scripts3.hero_pirate.insert
tt.main_script.update = scripts3.hero_pirate.update
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.75
tt.melee.range = 50
tt.motion.max_speed = 90
tt.pickpocket.chance = 0.3
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.steal_max = 10
tt.pickpocket.steal_min = 5
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "pirate_shotgun"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 18),
	v(15, 10),
	v(19, 20)
}
tt.ranged.attacks[1].cooldown = 6
tt.ranged.attacks[1].max_range = 100
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(15)
tt.regen.cooldown = 1
tt.regen.health = tt.hero.level_stats.regen_health[1]
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	shoot = {
		"shoot",
		"shootUp",
		"shootDown"
	},
	walk = {
		"running"
	}
}
tt.render.sprites[1].angles_custom = {
	45,
	135,
	210,
	315
}
tt.render.sprites[1].angles_flip_vertical = {
	shoot = true
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_pirate"
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HeroPirateTaunt"
tt.sound_events.death = "HeroPirateDeath"
tt.sound_events.respawn = "HeroPirateTauntIntro"
tt.sound_events.insert = "HeroPirateTauntIntro"
tt.sound_events.hero_room_select = "HeroPirateTauntSelect"
tt.timed_attacks.list[1] = E.clone_c(E, "aura_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 100
tt.timed_attacks.list[1].bullet = "kraken_aura"
tt.timed_attacks.list[1].animation = "kraken"
tt.timed_attacks.list[1].shoot_time = fts(15)
tt.timed_attacks.list[1].sound = "HeroPirateKraken"
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER, F_BOSS)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].min_enemies_nearby = 1
tt.timed_attacks.list[1].nearby_range = 60
tt.timed_attacks.list[2] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[2].animation = "bombing"
tt.timed_attacks.list[2].bullet = "pirate_exploding_barrel"
tt.timed_attacks.list[2].bullet_start_offset = {
	v(-5, 16)
}
tt.timed_attacks.list[2].cooldown = 16
tt.timed_attacks.list[2].max_range = 100
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].shoot_time = fts(9.5)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[2].disabled = true
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -0.84)
tt.unit.mod_offset = v(0, 14.16)
tt = E.register_t(E, "pirate_shotgun", "shotgun")
tt.bullet.level = 0
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.min_speed = FPS*40
tt.bullet.max_speed = FPS*40
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.miss_fx_water = "fx_splash_small"
tt.bullet.xp_gain_factor = 0.75
tt.render.sprites[1].hidden = true
tt.sound_events.insert = "ShotgunSound"
tt = E.register_t(E, "pirate_loot_aura", "aura")
tt.aura.mod = "mod_pirate_loot"
tt.aura.cycle_time = fts(10)
tt.aura.requires_alive_source = true
tt.aura.duration = -1
tt.aura.radius = 110
tt.aura.track_source = true
tt.aura.track_dead = true
tt.aura.filter_source = true
tt.aura.vis_bans = bor(F_FRIEND, F_BOSS)
tt.aura.vis_flags = bor(F_MOD, F_RANGED)
tt.main_script.insert = scripts3.aura_apply_mod.insert
tt.main_script.update = scripts3.aura_apply_mod.update
tt = E.register_t(E, "mod_pirate_loot", "modifier")
tt.modifier.duration = fts(13)
tt.main_script.insert = scripts3.mod_pirate_loot.insert
tt.main_script.update = scripts3.mod_pirate_loot.update
tt.percent = nil
tt.extra_loot = 0
tt = E.register_t(E, "mod_stun_kraken", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.replaces_lower = false
tt.modifier.resets_same = false
tt.modifier.use_mod_offset = false
tt.render.sprites[1].prefix = "kraken_tentacle"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "grab"
tt.render.sprites[1].size_anchors_y = {
	0.325,
	0.28,
	0.28
}
tt.main_script.insert = scripts3.mod_stun_kraken.insert
tt.main_script.remove = scripts3.mod_stun_kraken.remove
tt.main_script.update = scripts3.mod_stun_kraken.update
tt = E.register_t(E, "mod_dps_kraken", "modifier")

E.add_comps(E, tt, "dps")

tt.modifier.level = 1
tt.modifier.duration = 3
tt.dps.damage_min = 30
tt.dps.damage_max = 30
tt.dps.damage_every = fts(10)
tt.main_script.insert = scripts3.mod_dps.insert
tt.main_script.update = scripts3.mod_dps.update
tt = E.register_t(E, "mod_slow_kraken", "mod_slow")
tt.modifier.duration = fts(10)
tt.slow.factor = 0.5
tt = RT("hero_veznan", "hero")

AC(tt, "melee", "ranged", "timed_attacks", "teleport")

tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.hp_max = {
	185,
	200,
	215,
	230,
	245,
	260,
	275,
	290,
	305,
	375
}
tt.hero.level_stats.melee_damage_max = {
	8,
	10,
	11,
	12,
	13,
	14,
	16,
	17,
	18,
	20
}
tt.hero.level_stats.melee_damage_min = {
	6,
	6,
	7,
	8,
	9,
	10,
	10,
	11,
	12,
	13
}
tt.hero.level_stats.regen_health = {
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20,
	24
}
tt.hero.level_stats.ranged_damage_min = {
	11,
	12,
	14,
	15,
	17,
	18,
	20,
	21,
	23,
	28
}
tt.hero.level_stats.ranged_damage_max = {
	32,
	36,
	41,
	45,
	50,
	54,
	59,
	63,
	68,
	76
}
tt.hero.skills.soulburn = E.clone_c(E, "hero_skill")
tt.hero.skills.soulburn.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.soulburn.hr_icon = "0026"
tt.hero.skills.soulburn.hr_order = 1
tt.hero.skills.soulburn.total_hp = {
	250,
	500,
	750
}
tt.hero.skills.soulburn.xp_gain = {
	105,
	210,
	315
}
tt.hero.skills.shackles = E.clone_c(E, "hero_skill")
tt.hero.skills.shackles.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.shackles.hr_icon = "0027"
tt.hero.skills.shackles.hr_order = 2
tt.hero.skills.shackles.max_count = {
	1,
	3,
	8
}
tt.hero.skills.shackles.xp_gain = {
	25,
	75,
	150
}
tt.hero.skills.hermeticinsight = E.clone_c(E, "hero_skill")
tt.hero.skills.hermeticinsight.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.hermeticinsight.hr_icon = "0028"
tt.hero.skills.hermeticinsight.hr_order = 3
tt.hero.skills.hermeticinsight.range_factor = {
	1.1,
	1.2,
	1.7
}
tt.hero.skills.arcanenova = E.clone_c(E, "hero_skill")
tt.hero.skills.arcanenova.damage_min = {
	28,
	46,
	75
}
tt.hero.skills.arcanenova.damage_max = {
	52,
	86,
	150
}
tt.hero.skills.arcanenova.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.arcanenova.hr_icon = "0029"
tt.hero.skills.arcanenova.hr_order = 4
tt.hero.skills.arcanenova.xp_gain = {
	45,
	90,
	135
}
tt.hero.skills.ultimate = E.clone_c(E, "hero_skill")
tt.hero.skills.ultimate.controller_name = "hero_veznan_ultimate"
tt.hero.skills.ultimate.stun_duration = {
	[0] = 2,
	3,
	4,
	5
}
tt.hero.skills.ultimate.soldier_hp_max = {
	[0] = 666,
	999,
	1337,
	1666
}
tt.hero.skills.ultimate.soldier_damage_max = {
	[0] = 50,
	90,
	115,
	130
}
tt.hero.skills.ultimate.soldier_damage_min = {
	[0] = 30,
	50,
	65,
	80
}
tt.hero.skills.ultimate.hr_cost = {
	4,
	4,
	4
}
tt.hero.skills.ultimate.hr_icon = "0030"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.key = "DARKPACT"
tt.health.dead_lifetime = 20
tt.health_bar.offset = v(0, 41)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts2.hero_veznan.level_up
tt.hero.tombstone_show_time = fts(90)
tt.info.damage_icon = "magic"
tt.info.fn = scripts2.hero_basic.get_info_ranged
tt.info.hero_portrait = "hero_portraits_0006"
tt.info.i18n_key = "HERO_ELVES_VEZNAN"
tt.info.portrait = ((IS_PHONE and "portraits_hero") or "info_portraits_heroes") .. "_0006"
tt.info.ultimate_icon = "0006"
tt.main_script.update = scripts2.hero_veznan.update
tt.motion.max_speed = FPS*2
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = 0.125
tt.render.sprites[1].prefix = "veznan_hero"
tt.soldier.melee_slot_offset = v(3, 0)
tt.sound_events.change_rally_point = "ElvesHeroVeznanTaunt"
tt.sound_events.death = "ElvesHeroVeznanDeath"
tt.sound_events.respawn = "ElvesHeroVeznanTauntIntro"
tt.sound_events.insert = "ElvesHeroVeznanTauntIntro"
tt.sound_events.hero_room_select = "ElvesHeroVeznanTauntSelect"
tt.teleport.min_distance = 100
tt.teleport.sound = "ElvesHeroVeznanTeleport"
tt.unit.hit_offset = v(0, 15)
tt.unit.mod_offset = v(0, 15)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 0.38
tt.melee.range = 55
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 20
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].bullet = "bolt_veznan"
tt.ranged.attacks[1].bullet_start_offset = {
	v(20, 40)
}
tt.ranged.attacks[1].shoot_time = fts(11)
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].animations = {
	"soulBurnStart",
	"soulBurnLoop",
	"soulBurnEnd"
}
tt.timed_attacks.list[1].ball = "decal_veznan_soulburn_ball"
tt.timed_attacks.list[1].balls_dest_offset = v(17, 36)
tt.timed_attacks.list[1].cast_time = fts(8)
tt.timed_attacks.list[1].cooldown = 35
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_fx = "fx_veznan_soulburn"
tt.timed_attacks.list[1].radius = 110
tt.timed_attacks.list[1].range = 140
tt.timed_attacks.list[1].sound = "ElvesHeroVeznanSoulBurn"
tt.timed_attacks.list[1].total_hp = nil
tt.timed_attacks.list[1].vis_bans = bor(F_BOSS)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED, F_INSTAKILL)
tt.timed_attacks.list[2] = CC("mod_attack")
tt.timed_attacks.list[2].animation = "shackles"
tt.timed_attacks.list[2].cast_sound = "ElvesHeroVeznanMagicSchackles"
tt.timed_attacks.list[2].cast_time = fts(14)
tt.timed_attacks.list[2].cooldown = 20
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].max_count = nil
tt.timed_attacks.list[2].mods = {
	"mod_veznan_shackles_stun",
	"mod_veznan_shackles_dps"
}
tt.timed_attacks.list[2].radius = 100
tt.timed_attacks.list[2].range = 150
tt.timed_attacks.list[2].vis_bans = bor(F_BOSS)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED, F_MOD, F_STUN)
tt.timed_attacks.list[3] = CC("area_attack")
tt.timed_attacks.list[3].animation = "arcaneNova"
tt.timed_attacks.list[3].cast_sound = "ElvesHeroVeznanArcaneNova"
tt.timed_attacks.list[3].cooldown = 18
tt.timed_attacks.list[3].damage_max = nil
tt.timed_attacks.list[3].damage_min = nil
tt.timed_attacks.list[3].damage_radius = 125
tt.timed_attacks.list[3].damage_type = DAMAGE_MAGICAL
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].hit_decal = "decal_veznan_arcanenova"
tt.timed_attacks.list[3].hit_fx = "fx_veznan_arcanenova"
tt.timed_attacks.list[3].hit_time = fts(25)
tt.timed_attacks.list[3].max_range = 165
tt.timed_attacks.list[3].min_range = 75
tt.timed_attacks.list[3].min_count = 2
tt.timed_attacks.list[3].mod = "mod_veznan_arcanenova"
tt.timed_attacks.list[3].vis_bans = 0
tt.timed_attacks.list[3].vis_flags = bor(F_RANGED)
tt = RT("hero_veznan_ultimate")

E.add_comps(E, tt, "pos", "main_script", "sound_events")

tt.can_fire_fn = scripts2.hero_veznan_ultimate.can_fire_fn
tt.cooldown = 120
tt.entity = "soldier_veznan_demon"
tt.main_script.update = scripts2.hero_veznan_ultimate.update
tt.mod = "mod_veznan_ultimate_stun"
tt.range = 65
tt.sound_events.insert = "ElvesHeroVeznanDarkPact"
tt.vis_bans = bor(F_BOSS)
tt.vis_flags = bor(F_MOD, F_STUN)
tt = RT("hero_durax", "hero")

AC(tt, "melee", "ranged", "timed_attacks", "transfer")

tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0.3
}
tt.hero.level_stats.hp_max = {
	280,
	300,
	320,
	340,
	360,
	380,
	400,
	420,
	440,
	480
}
tt.hero.level_stats.melee_damage_max = {
	12,
	13,
	15,
	16,
	18,
	19,
	21,
	22,
	24,
	27
}
tt.hero.level_stats.melee_damage_min = {
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	18
}
tt.hero.level_stats.regen_health = {
	23,
	25,
	27,
	28,
	30,
	32,
	33,
	35,
	37,
	40
}
tt.hero.skills.crystallites = E.clone_c(E, "hero_skill")
tt.hero.skills.crystallites.duration = {
	25,
	50,
	100
}
tt.hero.skills.crystallites.hr_cost = {
	5,
	5,
	5
}
tt.hero.skills.crystallites.hr_icon = "0056"
tt.hero.skills.crystallites.hr_order = 1
tt.hero.skills.crystallites.xp_gain = {
	205,
	410,
	615
}
tt.hero.skills.armsword = E.clone_c(E, "hero_skill")
tt.hero.skills.armsword.hr_cost = {
	1,
	1,
	2
}
tt.hero.skills.armsword.hr_icon = "0057"
tt.hero.skills.armsword.hr_order = 2
tt.hero.skills.armsword.xp_gain = {
	28,
	56,
	112
}
tt.hero.skills.armsword.damage = {
	60,
	100,
	220
}
tt.hero.skills.lethal_prism = E.clone_c(E, "hero_skill")
tt.hero.skills.lethal_prism.hr_cost = {
	1,
	1,
	2
}
tt.hero.skills.lethal_prism.hr_icon = "0058"
tt.hero.skills.lethal_prism.hr_order = 3
tt.hero.skills.lethal_prism.damage_max = {
	40,
	45,
	65
}
tt.hero.skills.lethal_prism.damage_min = {
	20,
	25,
	55
}
tt.hero.skills.lethal_prism.ray_count = {
	2,
	3,
	5
}
tt.hero.skills.lethal_prism.xp_gain = {
	19,
	38,
	76
}
tt.hero.skills.shardseed = E.clone_c(E, "hero_skill")
tt.hero.skills.shardseed.hr_cost = {
	1,
	1,
	2
}
tt.hero.skills.shardseed.hr_icon = "0059"
tt.hero.skills.shardseed.hr_order = 4
tt.hero.skills.shardseed.damage = {
	45,
	90,
	220
}
tt.hero.skills.shardseed.xp_gain = {
	28,
	56,
	112
}
tt.hero.skills.ultimate = E.clone_c(E, "hero_skill")
tt.hero.skills.ultimate.controller_name = "hero_durax_ultimate"
tt.hero.skills.ultimate.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.ultimate.hr_icon = "0060"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.key = "CRYSTAL_PRISON"
tt.hero.skills.ultimate.max_count = {
	[0] = 4,
	6,
	8,
	10
}
tt.hero.skills.ultimate.damage = {
	[0] = 300,
	400,
	800,
	1400
}
tt.health.dead_lifetime = 21
tt.health_bar.offset = v(0, 65)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts2.hero_durax.level_up
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts2.hero_durax.get_info
tt.info.hero_portrait = "hero_portraits_0012"
tt.info.i18n_key = "HERO_ELVES_DURAX"
tt.info.portrait = ((IS_PHONE and "portraits_hero") or "info_portraits_heroes") .. "_0012"
tt.info.ultimate_icon = "0012"
tt.main_script.update = scripts2.hero_durax.update
tt.motion.max_speed = FPS*2
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = 0.2308
tt.render.sprites[1].prefix = "durax_hero"
tt.soldier.melee_slot_offset = v(0, 0)
tt.sound_events.change_rally_point = "ElvesHeroDuraxTaunt"
tt.sound_events.death = "ElvesHeroDuraxDeath"
tt.sound_events.insert = "ElvesHeroDuraxTauntIntro"
tt.sound_events.respawn = "ElvesHeroDuraxTauntIntro"
tt.sound_events.hero_room_select = "ElvesHeroDuraxTauntSelect"
tt.unit.hit_offset = v(0, 23)
tt.unit.mod_offset = v(0, 23)
tt.transfer.extra_speed = FPS*5.5
tt.transfer.min_distance = 100
tt.transfer.sound_loop = "ElvesHeroDuraxWalkLoop"
tt.transfer.animations = {
	"lethalPrismStart",
	"specialwalkLoop",
	"lethalPrismEnd"
}
tt.transfer.particles_name = "ps_durax_transfer"
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[1].xp_gain_factor = 0.66
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[3] = CC("melee_attack")
tt.melee.attacks[3].animation = "armblade"
tt.melee.attacks[3].cooldown = 20
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].damage_type = DAMAGE_TRUE
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_time = fts(27)
tt.melee.attacks[3].sound = "ElvesHeroDuraxArmblade"
tt.melee.attacks[3].xp_from_skill = "armsword"
tt.melee.cooldown = 1
tt.melee.range = 75
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animation = "shardseed"
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].max_range = 250
tt.ranged.attacks[1].min_range = 125
tt.ranged.attacks[1].cooldown = 25
tt.ranged.attacks[1].bullet = "spear_durax"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-17, 55)
}
tt.ranged.attacks[1].shoot_time = fts(9)
tt.ranged.attacks[1].xp_from_skill = "shardseed"
tt.timed_attacks.list[1] = CC("bullet_attack")
tt.timed_attacks.list[1].animations = {
	"lethalPrismStart",
	"lethalPrismLoop",
	"lethalPrismEnd"
}
tt.timed_attacks.list[1].bullet = "ray_durax"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(0, 20)
}
tt.timed_attacks.list[1].cooldown = 20
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].range = 150
tt.timed_attacks.list[1].ray_cooldown = fts(10)
tt.timed_attacks.list[1].ray_count = nil
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].xp_from_skill = "lethal_prism"
tt.timed_attacks.list[2] = CC("spawn_attack")
tt.timed_attacks.list[2].animation = "crystallites"
tt.timed_attacks.list[2].cooldown = 50
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "hero_durax_clone"
tt.timed_attacks.list[2].nodes_offset = {
	5,
	14
}
tt.timed_attacks.list[2].sound = "ElvesHeroDuraxCrystallites"
tt.timed_attacks.list[2].spawn_offset = v(22, 0)
tt.timed_attacks.list[2].spawn_time = fts(19)
tt.timed_attacks.list[2].xp_from_skill = "cristallites"
tt = RT("hero_durax_ultimate")

AC(tt, "pos", "main_script", "sound_events")

tt.can_fire_fn = scripts2.hero_durax_ultimate.can_fire_fn
tt.cooldown = 45
tt.max_count = nil
tt.range = 75
tt.main_script.update = scripts2.hero_durax_ultimate.update
tt.damage = nil
tt.damage_type = DAMAGE_TRUE
tt.vis_flags = bor(F_MOD)
tt.vis_bans = bor(F_FLYING)
tt.sound_events.insert = "ElvesHeroDuraxUltimate"
tt.mod_slow = "mod_durax_slow"
tt.mod_stun = "mod_durax_stun"
tt.hit_blood_fx = "fx_blood_splat"
tt = RT("hero_durax_clone", "hero_durax")

AC(tt, "tween")

tt.clone = {
	duration = nil
}
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.25,
	tint_color = {
		0,
		0.75,
		1,
		1
	}
}
tt.health.dead_lifetime = 3
tt.sound_events.change_rally_point = "ElvesHeroDuraxTaunt"
tt.sound_events.death = "ElvesHeroDuraxDeath"
tt.sound_events.insert = nil
tt.ranged.attacks[1].bullet = "spear_durax_clone"
tt.health.ignore_delete_after = nil
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		2,
		255
	},
	{
		3,
		0
	}
}
tt.transfer.particles_name = "ps_durax_clone_transfer"
tt = RT("ray_durax", "bullet")
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.hit_fx = "fx_ray_durax_hit"
tt.bullet.hit_time = fts(5)
tt.image_width = 164
tt.track_target = true
tt.main_script.update = scripts2.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "ray_durax"
tt.sound_events.insert = "ElvesHeroDuraxLethalPrismShoot"
tt = RT("spear_durax", "arrow")
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.flight_time = fts(16)
tt.bullet.hide_radius = 1
tt.bullet.hit_fx = "fx_shardseed_hit"
tt.bullet.miss_decal = "durax_hero_proy_0002-f"
tt.bullet.miss_decal_anchor = v(1, 0.5)
tt.bullet.prediction_error = false
tt.bullet.predict_target_pos = true
tt.bullet.reset_to_target_pos = true
tt.bullet.xp_gain_factor = 0.35
tt.render.sprites[1].anchor.x = 0.8214285714285714
tt.render.sprites[1].name = "durax_hero_proy_0001-f"
tt.sound_events.insert = "ElvesHeroDuraxShardSpearThrow"
tt = RT("spear_durax_clone", "spear_durax")
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_color = {
		0,
		1,
		1,
		1
	}
}
tt = RT("mod_durax_slow", "mod_slow")
tt.modifier.duration = fts(15)
tt.slow.factor = 0.9
tt = RT("mod_durax_stun", "mod_stun")
tt.modifier.duration = fts(20)
tt.modifier.vis_bans = F_BOSS
tt = RT("decal_phoenix_ultimate", "decal_rock_crater")
tt.render.sprites[1].name = "phoenix_hero_egg_decal"
tt = RT("decal_phoenix_flaming_path_pulse", "decal_tween")
tt.render.sprites[1].name = "phoenix_hero_towerBurn_Circle"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.32,
		v(2.4, 2.4)
	}
}
tt.tween.props[2] = CC("tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		0.32,
		0
	}
}
tt = RT("ps_missile_phoenix")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.animation_fps = 50
tt.particle_system.emission_rate = 50
tt.particle_system.emit_area_spread = v(4, 4)
tt.particle_system.loop = false
tt.particle_system.name = "ps_missile_phoenix"
tt.particle_system.particle_lifetime = {
	0.14,
	0.18
}
tt.particle_system.spin = {
	-0.3,
	0.3
}
tt.particle_system.track_rotation = true
tt = RT("ps_missile_phoenix_small", "ps_missile_phoenix")
tt.particle_system.scale_var = {
	0.65,
	0.65
}
tt.particle_system.emit_area_spread = v(2, 2)
tt = RT("hero_wilbur", "hero")

AC(tt, "ranged", "timed_attacks")

tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.hp_max = {
	300,
	330,
	360,
	390,
	420,
	450,
	480,
	510,
	540,
	570
}
tt.hero.level_stats.melee_damage_max = {
	8,
	10,
	11,
	12,
	13,
	14,
	16,
	17,
	18,
	19
}
tt.hero.level_stats.melee_damage_min = {
	6,
	6,
	7,
	8,
	9,
	10,
	10,
	11,
	12,
	13
}
tt.hero.level_stats.regen_health = {
	18,
	19,
	21,
	22,
	24,
	25,
	27,
	28,
	30,
	31
}
tt.hero.level_stats.ranged_damage_max = {
	14,
	16,
	18,
	20,
	22,
	24,
	26,
	28,
	30,
	32
}
tt.hero.level_stats.ranged_damage_min = {
	10,
	11,
	12,
	13,
	15,
	16,
	17,
	19,
	20,
	21
}
tt.hero.skills.missile = E.clone_c(E, "hero_skill")
tt.hero.skills.missile.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.missile.hr_icon = "0076"
tt.hero.skills.missile.hr_order = 1
tt.hero.skills.missile.damage_max = {
	40,
	80,
	120
}
tt.hero.skills.missile.damage_min = {
	28,
	56,
	84
}
tt.hero.skills.missile.xp_gain = {
	100,
	150,
	225
}
tt.hero.skills.smoke = E.clone_c(E, "hero_skill")
tt.hero.skills.smoke.duration = {
	3,
	4,
	5
}
tt.hero.skills.smoke.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.smoke.hr_icon = "0077"
tt.hero.skills.smoke.hr_order = 2
tt.hero.skills.smoke.slow_factor = {
	0.8,
	0.6,
	0.4
}
tt.hero.skills.smoke.xp_gain = {
	50,
	75,
	100
}
tt.hero.skills.box = E.clone_c(E, "hero_skill")
tt.hero.skills.box.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.box.hr_icon = "0078"
tt.hero.skills.box.hr_order = 3
tt.hero.skills.box.count = {
	1,
	2,
	3
}
tt.hero.skills.box.xp_gain = {
	50,
	100,
	200
}
tt.hero.skills.engine = E.clone_c(E, "hero_skill")
tt.hero.skills.engine.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.engine.hr_icon = "0079"
tt.hero.skills.engine.hr_order = 4
tt.hero.skills.engine.speed_factor = {
	1.2,
	1.4,
	1.6
}
tt.hero.skills.ultimate = E.clone_c(E, "hero_skill")
tt.hero.skills.ultimate.controller_name = "hero_wilbur_ultimate"
tt.hero.skills.ultimate.damage = {
	[0] = 4,
	8,
	12,
	16
}
tt.hero.skills.ultimate.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.ultimate.hr_icon = "0080"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.key = "DRONES"
tt.health.dead_lifetime = 30
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 140)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.hero.fn_level_up = scripts2.hero_wilbur.level_up
tt.hero.tombstone_show_time = nil
tt.hero.use_custom_spawn_point = true
tt.idle_flip.cooldown = 10
tt.info.damage_icon = "arrow"
tt.info.fn = scripts2.hero_wilbur.get_info
tt.info.hero_portrait = "hero_portraits_1223"
tt.info.i18n_key = "HERO_ELVES_GYRO"
tt.info.portrait = ((IS_PHONE and "portraits_hero") or "info_portraits_heroes") .. "_1223"
tt.info.ultimate_icon = "0016"
tt.main_script.insert = scripts2.hero_wilbur.insert
tt.main_script.update = scripts2.hero_wilbur.update
tt.motion.max_speed = FPS*1.8
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.regen.cooldown = 1

for i = 1, 4, 1 do
	tt.render.sprites[i] = CC("sprite")
	tt.render.sprites[i].anchor.y = 0.065
	tt.render.sprites[i].prefix = "hero_wilbur_layer" .. i
	tt.render.sprites[i].name = "idle"
	tt.render.sprites[i].angles = {
		walk = {
			"idle"
		}
	}
	tt.render.sprites[i].group = (i == 3 and "gun") or nil
	tt.render.sprites[i].z = Z_FLYING_HEROES
end

tt.render.sprites[5] = CC("sprite")
tt.render.sprites[5].alpha = 150
tt.render.sprites[5].anchor.y = 0.04032258064516129
tt.render.sprites[5].animated = false
tt.render.sprites[5].name = "decal_wilbur_shadow"
tt.soldier.melee_slot_offset = v(0, 0)
tt.sound_events.change_rally_point = "ElvesHeroGyroTaunt"
tt.sound_events.death = "ElvesHeroGyroDeath"
tt.sound_events.hero_room_select = "ElvesHeroGyroTauntSelect"
tt.sound_events.insert = "ElvesHeroGyroTauntIntro"
tt.sound_events.respawn = "ElvesHeroGyroTauntIntro"
tt.ui.click_rect = r(-25, 50, 50, 55)
tt.unit.hit_offset = v(0, 90)
tt.unit.hide_after_death = true
tt.unit.mod_offset = v(0, 80)
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animations = {
	nil,
	"shoot"
}
tt.ranged.attacks[1].bullet = "shot_wilbur"
tt.ranged.attacks[1].bullet_start_offset = {
	v(19, 44)
}
tt.ranged.attacks[1].cooldown = 0.8
tt.ranged.attacks[1].loops = 1
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_times = {
	0,
	fts(6),
	fts(12)
}
tt.ranged.attacks[1].sprite_group = "gun"
tt.ranged.attacks[1].sound = "ElvesHeroGyroAttack"
tt.ranged.attacks[2] = CC("bullet_attack")
tt.ranged.attacks[2].animations = {
	nil,
	"projectile"
}
tt.ranged.attacks[2].bullet = "missile_wilbur"
tt.ranged.attacks[2].bullet_shot_start_offset = {
	v(-24, 87),
	v(-5, 123)
}
tt.ranged.attacks[2].cooldown = 25
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].filter_fn = scripts2.hero_wilbur.missile_filter_fn
tt.ranged.attacks[2].loops = 1
tt.ranged.attacks[2].max_range = 500
tt.ranged.attacks[2].min_range = 20
tt.ranged.attacks[2].node_prediction = 2
tt.ranged.attacks[2].shoot_times = {
	fts(5),
	fts(8)
}
tt.ranged.attacks[2].xp_from_skill_once = "missile"
tt.timed_attacks.list[1] = CC("aura_attack")
tt.timed_attacks.list[1].animations = {
	"smokeStart",
	"smokeLoop",
	"smokeEnd"
}
tt.timed_attacks.list[1].bullet = "aura_smoke_wilbur"
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].max_range = 20
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].node_prediction = fts(24) + 0.25
tt.timed_attacks.list[1].sound = "ElvesHeroGyroSmokeLaunch"
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = F_FLYING
tt.timed_attacks.list[1].xp_from_skill = "smoke"
tt.timed_attacks.list[2] = CC("bullet_attack")
tt.timed_attacks.list[2].animation = "box"
tt.timed_attacks.list[2].bullet = "box_wilbur"
tt.timed_attacks.list[2].bullet_start_offset = v(35, 115)
tt.timed_attacks.list[2].cooldown = 22
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].payload = "aura_box_wilbur"
tt.timed_attacks.list[2].range_nodes_max = 200
tt.timed_attacks.list[2].range_nodes_min = 10
tt.timed_attacks.list[2].max_path_dist = 50
tt.timed_attacks.list[2].shoot_time = fts(12)
tt.timed_attacks.list[2].sound = "ElvesHeroGyroBoombBox"
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED, F_BLOCK)
tt.timed_attacks.list[2].vis_bans = F_FLYING
tt.timed_attacks.list[2].xp_from_skill = "box"
tt = RT("hero_wilbur_ultimate")

AC(tt, "pos", "main_script", "sound_events")

tt.can_fire_fn = scripts2.hero_wilbur_ultimate.can_fire_fn
tt.cooldown = 40
tt.main_script.update = scripts2.hero_wilbur_ultimate.update
tt.sound_events.insert = "ElvesHeroGyroDronesSpawn"
tt.entity = "drone_wilbur"
tt.spawn_offsets = {
	v(0, 25),
	v(15, 0),
	v(-15, 0),
	v(0, -25)
}
tt = RT("drone_wilbur", "decal_scripted")

AC(tt, "force_motion", "custom_attack", "sound_events", "tween")

tt.main_script.update = scripts2.drone_wilbur.update
tt.flight_height = 70
tt.force_motion.max_a = 1200
tt.force_motion.max_v = 360
tt.force_motion.ramp_radius = 30
tt.force_motion.fr = 0.05
tt.force_motion.a_step = 20
tt.duration = 8
tt.start_ts = nil
tt.render.sprites[1].prefix = "wilbur_drone"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].offset = v(0, tt.flight_height)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.custom_attack.hit_time = fts(2)
tt.custom_attack.hit_cycles = 3
tt.custom_attack.hit_delay = fts(2)
tt.custom_attack.range_sets = {
	{
		0,
		100
	},
	{
		100,
		1e+99
	}
}
tt.custom_attack.max_shots = 16
tt.custom_attack.search_cooldown = 0.1
tt.custom_attack.cooldown = 0.25
tt.custom_attack.animation = "shoot"
tt.custom_attack.sound = "ElvesHeroGyroDronesAttack"
tt.custom_attack.sound_chance = 0.5
tt.custom_attack.damage_min = nil
tt.custom_attack.damage_max = nil
tt.custom_attack.damage_type = DAMAGE_TRUE
tt.custom_attack.vis_flags = F_RANGED
tt.custom_attack.vis_bans = 0
tt.custom_attack.shoot_range = 25
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt.tween.props[1].loop = true
tt.tween.props[1].keys = {
	{
		0,
		v(0, tt.flight_height + 2)
	},
	{
		0.4,
		v(0, tt.flight_height - 2)
	},
	{
		0.8,
		v(0, tt.flight_height + 2)
	}
}
tt.tween.props[1].interp = "sine"
tt = RT("aura_rabbit_kamihare", "aura")
tt.aura.cycles = 1
tt.aura.damage_min = 30
tt.aura.damage_max = 40
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.radius = 37.5
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.vis_flags = bor(F_RANGED)
tt.main_script.update = scripts2.aura_apply_damage.update
tt = RT("ps_missile_wilbur")

AC(tt, "pos", "particle_system")

tt.particle_system.name = "hero_wilburg_missile_particle"
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
	1.6,
	1.8
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_x = {
	1,
	3
}
tt.particle_system.scales_y = {
	1,
	3
}
tt.particle_system.scale_var = {
	0.4,
	0.95
}
tt.particle_system.scale_same_aspect = false
tt.particle_system.emit_spread = math.pi
tt.particle_system.emission_rate = 30
tt = RT("shot_wilbur", "bullet")
tt.bullet.hit_fx = "fx_shot_wilbur_hit"
tt.bullet.shoot_fx = "fx_shot_wilbur_flash"
tt.bullet.flight_time = fts(8)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.xp_gain_factor = 0.38
tt.main_script.update = scripts2.shot_wilbur.update
tt.render = nil
tt = RT("missile_wilbur", "bullet")
tt.bullet.acceleration_factor = 0.05
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 60
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.first_retarget_range = 300
tt.bullet.hit_fx = "fx_explosion_air"
tt.bullet.hit_fx_air = "fx_explosion_air"
tt.bullet.max_speed = 360
tt.bullet.min_speed = 240
tt.bullet.particles_name = "ps_missile_wilbur"
tt.bullet.retarget_range = 99999
tt.bullet.turn_speed = (math.pi*10)/180*30
tt.bullet.vis_bans = 0
tt.bullet.vis_flags = F_RANGED
tt.bullet.damage_flags = F_AREA
tt.bullet.max_seek_angle = 0.2
tt.bullet.rot_dir_from_long_angle = true
tt.main_script.insert = scripts2.missile_wilbur.insert
tt.main_script.update = scripts2.missile.update
tt.render.sprites[1].prefix = "missile_wilbur"
tt.render.sprites[1].scale = vv(0.75)
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.insert = "RocketLaunchSound"
tt = RT("box_wilbur", "bomb")
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = fts(30)
tt.bullet.hide_radius = nil
tt.bullet.pop = nil
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.g = (fts(1)*fts(1))/-1
tt.bullet.rotation_speed = (FPS*-15*math.pi)/180
tt.sound_events.insert = nil
tt.render.sprites[1].name = "hero_wilburg_box"
tt.render.sprites[1].animated = false
tt = RT("rabbit_kamihare", "decal_scripted")

AC(tt, "nav_path", "motion", "custom_attack")

tt.render.sprites[1].prefix = "rabbit"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].anchor.y = 0.20512820512820512
tt.main_script.update = scripts2.rabbit_kamihare.update
tt.nav_path.dir = -1
tt.motion.max_speed = FPS*1.25
tt.duration = 100
tt.custom_attack.max_range = 25
tt.custom_attack.vis_flags = bor(F_RANGED)
tt.custom_attack.vis_bans = bor(F_FLYING)
tt.custom_attack.aura = "aura_rabbit_kamihare"
tt.custom_attack.hit_fx = "fx_rabbit_kamihare_explode"
tt = RT("aura_smoke_wilbur", "aura")

AC(tt, "render", "tween")

tt.aura.cycle_time = 0.2
tt.aura.duration = nil
tt.aura.mod = "mod_slow_wilbur"
tt.aura.radius = 60
tt.aura.vis_bans = bor(F_FRIEND)
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts2.aura_apply_mod.update

for i, offset in ipairs({
	v(25, -20),
	v(-11, -20),
	v(7, 5)
}) do
	local s = CC("sprite")
	s.name = "decal_wilbur_smoke"
	s.offset = offset
	s.anchor.y = 0.15
	s.scale = v(1, 1)
	tt.render.sprites[i] = s
	tt.tween.props[i*2 - 1] = CC("tween_prop")
	tt.tween.props[i*2 - 1].keys = {
		{
			0,
			0
		},
		{
			0.6,
			255
		},
		{
			"this.aura.duration-0.6",
			255
		},
		{
			"this.aura.duration",
			0
		}
	}
	tt.tween.props[i*2 - 1].sprite_id = i
	tt.tween.props[i*2] = CC("tween_prop")
	tt.tween.props[i*2].keys = {
		{
			0,
			vv(0.3)
		},
		{
			fts(13),
			vv(1.1)
		},
		{
			fts(15),
			vv(1)
		}
	}
	tt.tween.props[i*2].name = "scale"
	tt.tween.props[i*2].sprite_id = i
end

tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].anchor.y = 0.14545454545454545
tt.render.sprites[4].name = "fx_wilbur_smoke_start"
tt.render.sprites[4].hide_after_runs = 1
tt.tween.remove = false
tt = RT("bomb_wilbur", "rabbit_kamihare")

AC(tt, "sound_events")

tt.render.sprites[1].prefix = "bomb_wilbur"
tt.render.sprites[1].anchor.y = 0.11666666666666667
tt.render.sprites[1].random_ts = 0.5
tt.main_script.update = scripts2.rabbit_kamihare.update
tt.motion.max_speed = FPS*2
tt.duration = 100
tt.custom_attack.max_range = 30
tt.custom_attack.vis_flags = bor(F_RANGED)
tt.custom_attack.vis_bans = bor(F_FLYING)
tt.custom_attack.aura = "aura_bomb_wilbur"
tt.custom_attack.hit_fx = nil
tt.sound_events.insert = "ElvesHeroGyroBombsMarch"
tt.sound_events.remove_stop = "ElvesHeroGyroBombsMarch"
tt = RT("aura_bomb_wilbur", "aura_rabbit_kamihare")
tt.aura.damage_min = 110
tt.aura.damage_max = 155
tt.aura.radius = 30
tt.sound_events.insert = "BombExplosionSound"
tt = RT("aura_box_wilbur", "decal_scripted")

AC(tt, "spawner", "sound_events")

tt.render.sprites[1].anchor.y = 0.25
tt.render.sprites[1].name = "box_wilbur_open"
tt.render.sprites[1].loop = false
tt.spawner.entity = "bomb_wilbur"
tt.spawner.spawn_time = fts(10)
tt.spawner.count = nil
tt.sound_events.insert = "ElvesHeroGyroBoombBoxTouchdown"
tt.main_script.update = scripts2.aura_box_wilbur.update
tt = RT("mod_slow_wilbur", "mod_slow")
tt.slow.factor = nil
tt = RT("aura_bobbing_wilbur", "aura")
tt.aura.duration = -1
tt.main_script.update = scripts2.aura_wilbur_bobbing.update
tt = RT("fx_box_wilbur_smoke_a", "fx")
tt.render.sprites[1].name = "fx_box_wilbur_smoke_a"
tt.render.sprites[1].z = Z_OBJECTS
tt = RT("fx_box_wilbur_smoke_b", "fx")
tt.render.sprites[1].name = "fx_box_wilbur_smoke_b"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -5
tt = RT("fx_fireball_veznan_demon_hit_air", "fx")
tt.render.sprites[1].name = "fx_fireball_veznan_demon_hit_air"
tt.render.sprites[1].anchor.y = 0.25925925925925924
tt = RT("fx_fireball_veznan_demon_hit", "fx")
tt.render.sprites[1].name = "fx_fireball_veznan_demon_hit"
tt.render.sprites[1].anchor.y = 0.25925925925925924
tt = RT("fx_missile_wilbur_hit", "fx_fireball_veznan_demon_hit")
tt.render.sprites[1].scale = vv(1.4)
tt = RT("fx_missile_wilbur_hit_air", "fx_fireball_veznan_demon_hit_air")
tt.render.sprites[1].scale = vv(1.4)
tt = RT("fx_shot_wilbur_flash", "fx")
tt.render.sprites[1].name = "fx_shot_wilbur_flash"
tt = RT("fx_shot_wilbur_hit", "fx")
tt.render.sprites[1].name = "fx_shot_wilbur_hit"
tt.render.sprites[1].anchor.y = 0.19230769230769232
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "power_hero_control")

E.add_comps(E, tt, "user_power", "pos", "main_script", "user_selection")

tt.main_script.insert = scripts2.power_hero_control.insert
tt.user_selection.can_select_point_fn = scripts2.power_hero_control.can_select_point

E.set_template(E, "user_power_1", E.get_template(E, "power_fireball_control"))
E.set_template(E, "user_power_2", E.get_template(E, "power_reinforcements_control"))
E.set_template(E, "user_power_3", E.get_template(E, "power_hero_control"))
tt = RT("mod_phoenix_egg", "mod_lava")
tt.modifier.duration = 2
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_inc = 0
tt.dps.damage_every = fts(6)
tt = RT("mod_phoenix_flaming_path", "modifier")

AC(tt, "custom_attack", "render", "tween")

tt.main_script.update = scripts2.mod_phoenix_flaming_path.update
tt.modifier.duration = 6.5
tt.custom_attack = CC("custom_attack")
tt.custom_attack.damage = nil
tt.custom_attack.cooldown = 2
tt.custom_attack.fx = "decal_phoenix_flaming_path_pulse"
tt.custom_attack.fx_start = "fx_flaming_path_start"
tt.custom_attack.fx_end = "fx_flaming_path_end"
tt.custom_attack.hit_time = 0.1
tt = RT("aura_phoenix_egg", "aura")

AC(tt, "render")

tt.render.sprites[1].prefix = "hero_phoenix_egg"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].hidden = true
tt.main_script.update = scripts2.aura_phoenix_egg.update
tt.aura.cycle_time = fts(6)
tt.aura.radius = 50
tt.aura.vis_flags = F_RANGED
tt.aura.vis_bans = F_FLYING
tt.aura.mod = "mod_phoenix_egg"
tt.aura.duration = 5
tt.custom_attack = CC("custom_attack")
tt.custom_attack.radius = 90
tt.custom_attack.damage_max = nil
tt.custom_attack.damage_min = nil
tt.custom_attack.damage_type = DAMAGE_TRUE
tt.custom_attack.vis_flags = F_RANGED
tt.custom_attack.hit_fx = "fx_phoenix_explosion"
tt = RT("aura_phoenix_purification", "aura")
tt.aura.cycle_time = fts(9)
tt.aura.duration = -1
tt.aura.mod = "mod_phoenix_purification"
tt.aura.radius = 125
tt.aura.targets_per_cycle = nil
tt.aura.track_source = true
tt.aura.track_dead = true
tt.aura.vis_flags = bor(F_RANGED, F_MOD)
tt.aura.vis_bans = bor(F_FRIEND)
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts2.aura_apply_mod.update
tt = RT("aura_ray_phoenix", "aura")
tt.main_script.insert = scripts2.aura_ray_phoenix.insert
tt.main_script.update = scripts2.aura_apply_damage.update
tt.aura.cycles = 1
tt.aura.damage_min = nil
tt.aura.damage_max = nil
tt.aura.damage_inc = nil
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.radius = 45
tt.aura.vis_bans = bor(F_FRIEND)
tt = RT("ray_phoenix", "bullet")
tt.image_width = 120
tt.main_script.update = scripts2.ray_simple.update
tt.render.sprites[1].name = "ray_phoenix"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.hit_fx = "fx_ray_phoenix_hit"
tt.bullet.hit_fx_ignore_hit_offset = true
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_time = fts(4)
tt.bullet.hit_payload = "aura_ray_phoenix"
tt.track_target = true
tt = RT("missile_phoenix", "bullet")
tt.bullet.acceleration_factor = 0.05
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = nil
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.first_retarget_range = 300
tt.bullet.hit_fx = "fx_ray_phoenix_hit"
tt.bullet.hit_fx_ignore_hit_offset = true
tt.bullet.max_speed = 540
tt.bullet.min_speed = 420
tt.bullet.particles_name = "ps_missile_phoenix"
tt.bullet.retarget_range = 99999
tt.bullet.speed_var = 60
tt.bullet.turn_helicoidal_factor = 2
tt.bullet.turn_speed = (math.pi*10)/180*30
tt.bullet.vis_bans = 0
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_flags = F_RANGED
tt.bullet.xp_gain_factor = 0.12
tt.main_script.insert = scripts2.missile_phoenix.insert
tt.main_script.update = scripts2.missile.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "phoenix_hero_bird"
tt.sound_events.hit = "ElvesHeroPhoenixBlazingOffspringHit"
tt = RT("missile_phoenix_small", "missile_phoenix")
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.particles_name = "ps_missile_phoenix_small"
tt.bullet.xp_gain_factor = 0.12
tt.render.sprites[1].scale = vv(0.65)
tt = RT("fx_flaming_path_start", "fx")
tt.render.sprites[1].name = "fx_flaming_path_start"
tt.render.sprites[1].anchor.y = 0.26666666666666666
tt = RT("fx_flaming_path_end", "fx_flaming_path_start")
tt.render.sprites[1].name = "fx_flaming_path_end"
tt = RT("fx_phoenix_explosion", "fx")
tt.render.sprites[1].name = "hero_phoenix_explosion"
tt.render.sprites[1].anchor.y = 0.20588235294117646
tt = RT("fx_phoenix_inmolation", "decal_tween")
tt.render.sprites[1].name = "hero_phoenix_explosion"
tt.render.sprites[1].anchor.y = 0.20588235294117646
tt.render.sprites[1].loop = false
tt.render.sprites[1].hide_after_runs = 1
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "phoenix_hero_suicide_decals_0001"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = CC("sprite")
tt.render.sprites[3].animated = false
tt.render.sprites[3].name = "phoenix_hero_suicide_decals_0002"
tt.render.sprites[3].z = Z_DECALS
tt.tween.props[1].sprite_id = 2
tt.tween.props[1].keys = {
	{
		fts(20),
		255
	},
	{
		fts(34),
		0
	}
}
tt.tween.props[2] = CC("tween_prop")
tt.tween.props[2].sprite_id = 3
tt.tween.props[2].keys = {
	{
		fts(4),
		255
	},
	{
		fts(10),
		0
	}
}
tt = RT("fx_ray_phoenix_hit", "fx")
tt.render.sprites[1].name = "fx_ray_phoenix_hit"
tt.render.sprites[1].anchor.y = 0.16666666666666666
tt = RT("hero_phoenix", "hero")

E.add_comps(E, tt, "ranged", "timed_attacks", "selfdestruct")

tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.hp_max = {
	350,
	370,
	390,
	410,
	430,
	450,
	470,
	490,
	510,
	530
}
tt.hero.level_stats.melee_damage_max = {
	1,
	2,
	4,
	4,
	5,
	6,
	7,
	8,
	9,
	10
}
tt.hero.level_stats.melee_damage_min = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10
}
tt.hero.level_stats.regen_health = {
	18,
	19,
	20,
	21,
	22,
	23,
	24,
	25,
	26,
	27
}
tt.hero.level_stats.ranged_damage_min = {
	16,
	19,
	22,
	24,
	27,
	30,
	33,
	35,
	38,
	41
}
tt.hero.level_stats.ranged_damage_max = {
	24,
	29,
	33,
	37,
	41,
	45,
	49,
	53,
	57,
	61
}
tt.hero.level_stats.egg_damage = {
	4,
	5,
	5,
	6,
	7,
	7,
	8,
	9,
	9,
	10
}
tt.hero.level_stats.egg_explosion_damage_max = {
	72,
	84,
	96,
	108,
	120,
	132,
	144,
	156,
	168,
	180
}
tt.hero.level_stats.egg_explosion_damage_min = {
	48,
	56,
	64,
	72,
	80,
	88,
	96,
	104,
	112,
	120
}
tt.hero.skills.inmolate = E.clone_c(E, "hero_skill")
tt.hero.skills.inmolate.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.inmolate.hr_icon = "0051"
tt.hero.skills.inmolate.hr_order = 1
tt.hero.skills.inmolate.damage_max = {
	115,
	235,
	350
}
tt.hero.skills.inmolate.damage_min = {
	65,
	125,
	190
}
tt.hero.skills.inmolate.xp_gain = {
	170,
	340,
	510
}
tt.hero.skills.purification = E.clone_c(E, "hero_skill")
tt.hero.skills.purification.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.purification.hr_icon = "0052"
tt.hero.skills.purification.hr_order = 2
tt.hero.skills.purification.damage_min = {
	15,
	25,
	35
}
tt.hero.skills.purification.damage_max = {
	15,
	25,
	35
}
tt.hero.skills.purification.max_targets = {
	3,
	5,
	7
}
tt.hero.skills.blazing_offspring = E.clone_c(E, "hero_skill")
tt.hero.skills.blazing_offspring.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.blazing_offspring.hr_icon = "0053"
tt.hero.skills.blazing_offspring.hr_order = 3
tt.hero.skills.blazing_offspring.damage_max = {
	55,
	70,
	80
}
tt.hero.skills.blazing_offspring.damage_min = {
	30,
	40,
	45
}
tt.hero.skills.blazing_offspring.count = {
	2,
	3,
	4
}
tt.hero.skills.blazing_offspring.xp_gain = {
	36,
	72,
	108
}
tt.hero.skills.flaming_path = E.clone_c(E, "hero_skill")
tt.hero.skills.flaming_path.damage = {
	20,
	40,
	60
}
tt.hero.skills.flaming_path.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.flaming_path.hr_icon = "0054"
tt.hero.skills.flaming_path.hr_order = 4
tt.hero.skills.flaming_path.xp_gain = {
	75,
	150,
	225
}
tt.hero.skills.ultimate = E.clone_c(E, "hero_skill")
tt.hero.skills.ultimate.damage_max = {
	[0] = 45,
	105,
	220,
	400
}
tt.hero.skills.ultimate.damage_min = {
	[0] = 25,
	55,
	120,
	200
}
tt.hero.skills.ultimate.hr_cost = {
	3,
	4,
	5
}
tt.hero.skills.ultimate.hr_icon = "0055"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.xp_gain = {
	0,
	0,
	0
}
tt.hero.skills.ultimate.controller_name = "hero_phoenix_ultimate"
tt.hero.skills.ultimate.key = "EMBER"
tt.health.dead_lifetime = 5
tt.health_bar.draw_order = -1
tt.health_bar.offset = v(0, 160)
tt.health_bar.sort_y_offset = -200
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.hero.fn_level_up = scripts2.hero_phoenix.level_up
tt.hero.tombstone_show_time = nil
tt.hero.use_custom_spawn_point = true
tt.idle_flip.cooldown = 10
tt.info.damage_icon = "fireball"
tt.info.fn = scripts2.hero_phoenix.get_info
tt.info.hero_portrait = "hero_portraits_0011"
tt.info.i18n_key = "HERO_ELVES_PHOENIX"
tt.info.portrait = ((IS_PHONE and "portraits_hero") or "info_portraits_heroes") .. "_0011"
tt.info.ultimate_icon = "0011"
tt.main_script.insert = scripts2.hero_phoenix.insert
tt.main_script.update = scripts2.hero_phoenix.update
tt.motion.max_speed = FPS*3.5
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = 0.19411764705882
tt.render.sprites[1].prefix = "hero_phoenix"
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].z = Z_FLYING_HEROES
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "phoenix_hero_0192"
tt.render.sprites[2].anchor.y = 0.19117647058823528
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].alpha = 90
tt.soldier.melee_slot_offset = v(0, 0)
tt.sound_events.change_rally_point = "ElvesHeroPhoenixTaunt"
tt.sound_events.death = "ElvesHeroPhoenixDeath"
tt.sound_events.hero_room_select = "ElvesHeroPhoenixTauntSelect"
tt.sound_events.insert = "ElvesHeroPhoenixTauntIntro"
tt.sound_events.respawn = "ElvesHeroPhoenixTauntIntro"
tt.ui.click_rect = (IS_PHONE and r(-35, 90, 70, 75)) or r(-25, 80, 50, 55)
tt.unit.hit_offset = v(0, 100)
tt.unit.hide_after_death = true
tt.unit.mod_offset = v(0, 134)
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_POISON, F_BURN)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].bullet = "ray_phoenix"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 100)
}
tt.ranged.attacks[1].cooldown = fts(17) + 1
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].shoot_time = fts(23)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].animation = "attack"
tt.ranged.attacks[1].sound_shoot = "ElvesHeroPhoenixAttack"
tt.ranged.attacks[2] = CC("bullet_attack")
tt.ranged.attacks[2].bullet = "missile_phoenix"
tt.ranged.attacks[2].bullet_start_offset = {
	v(5, 115)
}
tt.ranged.attacks[2].cooldown = 22
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].min_range = 0
tt.ranged.attacks[2].max_range = 300
tt.ranged.attacks[2].shoot_times = {}
tt.ranged.attacks[2].sync_animation = true
tt.ranged.attacks[2].animations = {
	nil,
	"birdThrow"
}
tt.ranged.attacks[2].sound = "ElvesHeroPhoenixBlazingOffspringShoot"
tt.ranged.attacks[2].loops = 1
tt.ranged.attacks[2].xp_from_skill_once = "blazing_offspring"
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].cooldown = 45
tt.timed_attacks.list[1].min_count = 3
tt.timed_attacks.list[1].range = 60
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[2] = CC("mod_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].animation = "birdThrow"
tt.timed_attacks.list[2].cooldown = 30
tt.timed_attacks.list[2].max_count = 1
tt.timed_attacks.list[2].max_range = 150
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].mod = "mod_phoenix_flaming_path"
tt.timed_attacks.list[2].hit_time = fts(4)
tt.timed_attacks.list[2].sound = "ElvesHeroPhoenixRingOfFireSpawn"
tt.timed_attacks.list[2].enemies_min_count = 2
tt.timed_attacks.list[2].enemies_range = 125
tt.timed_attacks.list[2].enemies_vis_flags = F_RANGED
tt.timed_attacks.list[2].enemies_vis_bans = bor(F_FLYING)
tt.selfdestruct.animation = "suicide"
tt.selfdestruct.damage_radius = 80
tt.selfdestruct.damage_type = DAMAGE_PHYSICAL
tt.selfdestruct.damage_max = nil
tt.selfdestruct.damage_min = nil
tt.selfdestruct.disabled = true
tt.selfdestruct.hit_time = fts(29)
tt.selfdestruct.hit_fx = "fx_phoenix_inmolation"
tt.selfdestruct.sound = "ElvesHeroPhoenixImmolation"
tt.selfdestruct.sound_args = {
	delay = fts(10)
}
tt.selfdestruct.dead_lifetime = 5
tt.selfdestruct.xp_from_skill = "inmolate"
tt = RT("hero_phoenix_ultimate", "aura")

AC(tt, "render", "tween")

tt.aura.duration = 180
tt.aura.vis_flags = F_RANGED
tt.aura.vis_bans = F_FLYING
tt.aura.damage_vis_bans = 0
tt.aura.radius = 50
tt.aura.hit_fx = "fx_phoenix_explosion"
tt.aura.hit_decal = "decal_phoenix_ultimate"
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.damage_max = nil
tt.aura.damage_min = nil
tt.can_fire_fn = scripts2.hero_phoenix_ultimate.can_fire_fn
tt.cooldown = 18
tt.main_script.update = scripts2.hero_phoenix_ultimate.update
tt.sound_events.insert = "ElvesHeroPhoenixFireEggDrop"
tt.sound_events.activate = "ElvesHeroPhoenixFireEggActivate"
tt.sound_events.explode = "ElvesHeroPhoenixFireEggExplosion"
tt.render.sprites[1].prefix = "phoenix_ultimate"
tt.render.sprites[1].name = "place"
tt.render.sprites[1].anchor.y = 0.45
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "phoenix_hero_egg_0016"
tt.render.sprites[2].animated = false
tt.render.sprites[2].alpha = 0
tt.render.sprites[2].anchor.y = 0.45
tt.activate_delay = 2
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.9,
		255
	},
	{
		1.1,
		255
	},
	{
		2,
		0
	}
}
tt.tween.props[1].sprite_id = 2
tt.tween.props[1].loop = true
tt.render.sprites[1].name = "phoenix_hero_towerBurn_towerFx"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.19166666666666668
tt.render.sprites[1].offset.y = -5
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "decal_flaming_path_fire"
tt.render.sprites[2].anchor.y = 0.19166666666666668
tt.render.sprites[2].offset.y = -5
tt.render.sprites[2].draw_order = 20
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.5,
		v(1.05, 1.05)
	},
	{
		1,
		v(1, 1)
	}
}
tt.tween.props[2] = CC("tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.3,
		255
	},
	{
		"this.modifier.duration-0.3",
		255
	},
	{
		"this.modifier.duration",
		0
	}
}
tt.tween.props[3] = table.deepclone(tt.tween.props[2])
tt.tween.props[3].sprite_id = 2
tt = RT("mod_phoenix_purification", "modifier")
tt.modifier.duration = fts(11)
tt.fx = "fx_ray_phoenix_hit"
tt.entity = "missile_phoenix_small"
tt.main_script.update = scripts2.mod_phoenix_purification.update
tt = E.register_t(E, "ps_shield_elves_denas")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "shield_elves_denas_particle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	fts(12),
	fts(12)
}
tt.particle_system.emission_rate = 60
tt.particle_system.scales_y = {
	1.5,
	0.5
}
tt.particle_system.scales_y = {
	1.5,
	0.5
}
tt.particle_system.track_rotation = true
tt.particle_system.z = Z_BULLETS
tt = E.register_t(E, "hero_voodoo_witch", "hero")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks")

image_y = 66
anchor_y = 0.25
tt.hero.level_stats.hp_max = {
	170,
	190,
	210,
	230,
	250,
	270,
	290,
	310,
	330,
	350
}
tt.hero.level_stats.regen_health = {
	21,
	23,
	26,
	28,
	31,
	33,
	36,
	39,
	41,
	44
}
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.damage_min = {
	4,
	5,
	7,
	8,
	10,
	11,
	13,
	14,
	16,
	17
}
tt.hero.level_stats.damage_max = {
	11,
	16,
	20,
	25,
	29,
	34,
	38,
	43,
	47,
	52
}
tt.hero.level_stats.ranged_damage_min = {
	4,
	5,
	7,
	8,
	10,
	11,
	13,
	14,
	16,
	17
}
tt.hero.level_stats.ranged_damage_max = {
	11,
	16,
	20,
	25,
	29,
	34,
	38,
	43,
	47,
	52
}
tt.hero.skills.laughingskulls = E.clone_c(E, "hero_skill")
tt.hero.skills.laughingskulls.extra_damage = {
	2,
	4,
	6
}
tt.hero.skills.deathskull = E.clone_c(E, "hero_skill")
tt.hero.skills.deathskull.damage = {
	18,
	36,
	54
}
tt.hero.skills.deathskull.xp_gain_factor = 20
tt.hero.skills.bonedance = E.clone_c(E, "hero_skill")
tt.hero.skills.bonedance.skull_count = {
	3,
	4,
	5
}
tt.hero.skills.deathaura = E.clone_c(E, "hero_skill")
tt.hero.skills.deathaura.slow_factor = {
	0.9,
	0.8,
	0.7
}
tt.hero.skills.voodoomagic = E.clone_c(E, "hero_skill")
tt.hero.skills.voodoomagic.damage = {
	40,
	80,
	120
}
tt.hero.skills.voodoomagic.xp_gain_factor = 140
tt.hero.skills.laughingskulls.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.laughingskulls.hr_icon = 71
tt.hero.skills.laughingskulls.hr_order = 1
tt.hero.skills.deathskull.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.deathskull.hr_icon = 72
tt.hero.skills.deathskull.hr_order = 2
tt.hero.skills.bonedance.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.bonedance.hr_icon = 73
tt.hero.skills.bonedance.hr_order = 3
tt.hero.skills.deathaura.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.deathaura.hr_icon = 75
tt.hero.skills.deathaura.hr_order = 4
tt.hero.skills.voodoomagic.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.voodoomagic.hr_icon = 74
tt.hero.skills.voodoomagic.hr_order = 5
tt.health.armor = 114514
tt.health.dead_lifetime = 15
tt.health.hp_max = 1919810
tt.health_bar.offset = v(0, 39)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts3.hero_voodoo_witch.level_up
tt.hero.tombstone_show_time = fts(90)
tt.idle_flip.cooldown = 2
tt.info.damage_icon = "magic"
tt.info.fn = scripts3.hero_voodoo_witch.get_info
tt.info.hero_portrait = "hero_portraits_0114"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0023") or "info_portraits_heroes_0114"
tt.main_script.insert = scripts3.hero_voodoo_witch.insert
tt.main_script.update = scripts3.hero_voodoo_witch.update
tt.motion.max_speed = 72
tt.regen.cooldown = 1
tt.regen.health = 1145141919810
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_voodoo_witch"
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HeroVoodooWitchTaunt"
tt.sound_events.death = "HeroVoodooWitchDeath"
tt.sound_events.respawn = "HeroVoodooWitchTauntIntro"
tt.sound_events.insert = "HeroVoodooWitchTauntIntro"
tt.sound_events.hero_room_select = "HeroVoodooWitchTauntSelect"
tt.unit.hit_offset = v(0, 13)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.6
tt.melee.attacks[1].cooldown = 1
tt.melee.range = 51.2
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].bullet = "bolt_voodoo_witch"
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 24)
}
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].animation = "magic"
tt.timed_attacks.list[1].mod_fx = "mod_voodoo_witch_magic"
tt.timed_attacks.list[1].mod_slow = "mod_voodoo_witch_magic_slow"
tt.timed_attacks.list[1].cooldown = 20
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 100
tt.timed_attacks.list[1].min_count = 5
tt.timed_attacks.list[1].count = 5
tt.timed_attacks.list[1].sound = "HeroVoodooWitchVoodooMagic"
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].damage = 114514
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = bor(F_BOSS)
tt = E.register_t(E, "voodoo_witch_skull_aura", "aura")
tt.aura.cycle_time = 0.26666666666666666
tt.aura.duration = -1
tt.aura.radius = 140
tt.aura.vis_bans = bor(F_BOSS, F_FRIEND)
tt.aura.vis_flags = F_MOD
tt.main_script.update = scripts3.voodoo_witch_skull_aura.update
tt.skull_count = 2
tt.skulls = {}
tt.rot_speed = (math.pi*2)/8
tt.rot_radius = 40
tt = E.register_t(E, "mod_voodoo_witch_skull_spawn", "modifier")
tt.modifier.duration = fts(10)
tt.main_script.update = scripts3.mod_voodoo_witch_skull_spawn.update
tt.count_group_type = COUNT_GROUP_CONCURRENT
tt.count_group_name = "voodoo_witch_skulls"
tt.skull_count = 2
tt = E.register_t(E, "voodoo_witch_skull", "decal_scripted")

E.add_comps(E, tt, "ranged", "count_group", "force_motion")

tt.count_group.name = "voodoo_witch_skulls"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.flight_period = 3
tt.flight_speed = 30
tt.force_motion.max_a = 495
tt.force_motion.max_v = 120
tt.force_motion.ramp_radius = 50
tt.main_script.update = scripts3.voodoo_witch_skull.update
tt.max_flight_height = 25
tt.max_shots = 8
tt.min_flight_height = 15
tt.ranged.attacks[1].bullet = "bolt_voodoo_witch_skull"
tt.ranged.attacks[1].cooldown = 1.1
tt.ranged.attacks[1].max_range = 120
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].shoot_time = fts(6)
tt.render.sprites[1].anchor.y = 0.4
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "voodoo_witch_skull"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sacrifice = {
	damage = nil,
	damage_type = DAMAGE_PHYSICAL,
	damage_radius = 25,
	disabled = true,
	min_range = 0,
	max_range = 150,
	max_v = tt.force_motion.max_v*4,
	max_a = tt.force_motion.max_a*2,
	a_step = 20,
	vis_flags = F_RANGED,
	vis_bans = 0,
	xp_from_skill = "deathskull",
	sound = "HeroVoodooWitchSacrificeStart",
	sound_hit = "HeroVoodooWitchSacrificeHit"
}
tt.rot_dest = v(0, 0)
tt = E.register_t(E, "fx_voodoo_witch_skull_explosion", "fx")
tt.render.sprites[1].name = "fx_voodoo_witch_skull_explosion"
tt = E.register_t(E, "ps_voodoo_witch_skull")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "voodoo_skull_particle"
tt.particle_system.loop = false
tt.particle_system.animated = true
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(12)
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_y = {
	0.85,
	0.15
}
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.emission_rate = 60
tt = E.register_t(E, "voodoo_witch_death_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 117.5
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.vis_flags = F_MOD
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.damage = 1
tt.aura.xp_gain_factor = 0.02
tt.mod_slow = "mod_voodoo_witch_aura_slow"
tt.main_script.update = scripts3.voodoo_witch_death_aura.update
tt.render.sprites[1].name = "decal_voodoo_witch_death_aura"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "voodoo_buff_top"
tt.render.sprites[2].anchor.y = 0.22727272727272727
tt = E.register_t(E, "mod_voodoo_witch_aura_slow", "mod_slow")

E.add_comps(E, tt, "render", "tween")

tt.slow.factor = 114514
tt.modifier.duration = 1.1
tt.modifier.resets_same = true
tt.modifier.use_mod_offset = false
tt.render.sprites[1].size_names = {
	"voodoo_aura_small",
	"voodoo_aura_small",
	"voodoo_aura_big"
}
tt.render.sprites[1].name = "voodoo_aura_small"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].animated = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.remove = false
tt = E.register_t(E, "bolt_voodoo_witch", "bolt")
tt.bullet.damage_max = 1919810
tt.bullet.damage_min = 114514
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.max_speed = 450
tt.bullet.min_speed = 150
tt.bullet.particles_name = "ps_bolt_voodoo_witch"
tt.bullet.xp_gain_factor = 0.6
tt.render.sprites[1].prefix = "bolt_voodoo_witch"
tt.sound_events.insert = "HeroVoodooWitchAttack"
tt = E.register_t(E, "bolt_voodoo_witch_skull", "bolt_voodoo_witch")
tt.bullet.damage_max = 4
tt.bullet.damage_min = 4
tt.bullet.particles_name = "ps_bolt_voodoo_witch_skull"
tt.bullet.xp_gain_factor = 0.4
tt.render.sprites[1].scale = v(0.75, 0.75)
tt.sound_events.insert = "HeroVoodooWitchSkullAttack"
tt = E.register_t(E, "ps_bolt_voodoo_witch")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "voodoo_proy_particle"
tt.particle_system.animated = false
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.alphas = {
	255,
	0
}
tt.particle_system.scales_y = {
	0.75,
	0.15
}
tt.particle_system.emission_rate = 60
tt = E.register_t(E, "ps_bolt_voodoo_witch_skull", "ps_bolt_voodoo_witch")
tt.particle_system.scales_y = {
	0.5,
	0.1
}
tt.particle_system.particle_lifetime = {
	fts(6),
	fts(6)
}
tt = E.register_t(E, "mod_voodoo_witch_magic", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = fts(61)
tt.main_script.insert = scripts3.mod_voodoo_witch_magic.insert
tt.main_script.update = scripts3.mod_track_target.update
tt.render.sprites[1].name = "mod_voodoo_witch_magic"
tt.render.sprites[1].loop = false
tt = E.register_t(E, "mod_voodoo_witch_magic_slow", "mod_slow")
tt.slow.factor = 0.3
tt.modifier.duration = 0.4
tt = E.register_t(E, "hero_elves_denas", "hero")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks")

tt.hero.level_stats.armor = {
	0.40,
	0.44,
	0.47,
	0.5,
	0.52,
	0.55,
	0.58,
	0.62,
	0.66,
	0.7
}
tt.hero.level_stats.hp_max = {
	320,
	340,
	360,
	385,
	420,
	445,
	480,
	505,
	525,
	550
}
tt.hero.level_stats.melee_damage_max = {
	20,
	23,
	27,
	31,
	34,
	37,
	40,
	43,
	45,
	48
}
tt.hero.level_stats.melee_damage_min = {
	14,
	16,
	18,
	20,
	23,
	25,
	27,
	30,
	32,
	35
}
tt.hero.level_stats.regen_health = {
	22,
	24,
	25,
	27,
	28,
	29,
	31,
	32,
	33,
	35
}
tt.hero.skills.celebrity = E.clone_c(E, "hero_skill")
tt.hero.skills.celebrity.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.celebrity.hr_icon = "0022"
tt.hero.skills.celebrity.hr_order = 2
tt.hero.skills.celebrity.max_targets = {
	3,
	6,
	9
}
tt.hero.skills.celebrity.stun_duration = {
	1,
	2,
	3
}
tt.hero.skills.celebrity.xp_gain = {
	50,
	150,
	300
}
tt.hero.skills.mighty = E.clone_c(E, "hero_skill")
tt.hero.skills.mighty.damage_max = {
	200,
	344,
	501
}
tt.hero.skills.mighty.damage_min = {
	130,
	166,
	415
}
tt.hero.skills.mighty.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.mighty.hr_icon = "0023"
tt.hero.skills.mighty.hr_order = 3
tt.hero.skills.mighty.xp_gain = {
	63,
	126,
	189
}
tt.hero.skills.shield_strike = E.clone_c(E, "hero_skill")
tt.hero.skills.shield_strike.damage_max = {
	36,
	52,
	70
}
tt.hero.skills.shield_strike.damage_min = {
	22,
	32,
	56
}
tt.hero.skills.shield_strike.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.shield_strike.hr_icon = "0024"
tt.hero.skills.shield_strike.hr_order = 4
tt.hero.skills.shield_strike.rebounds = {
	4,
	5,
	8
}
tt.hero.skills.shield_strike.xp_gain = {
	25,
	50,
	75
}
tt.hero.skills.sybarite = E.clone_c(E, "hero_skill")
tt.hero.skills.sybarite.heal_hp = {
	150,
	225,
	360
}
tt.hero.skills.sybarite.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.sybarite.hr_icon = "0021"
tt.hero.skills.sybarite.hr_order = 1
tt.hero.skills.ultimate = E.clone_c(E, "hero_skill")
tt.hero.skills.ultimate.controller_name = "hero_elves_denas_ultimate"
tt.hero.skills.ultimate.hr_cost = {
	4,
	4,
	4
}
tt.hero.skills.ultimate.hr_icon = "0025"
tt.hero.skills.ultimate.hr_order = 5
tt.hero.skills.ultimate.key = "DEFENDER"
tt.health.dead_lifetime = 12
tt.health_bar.offset = v(0, 46)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts2.hero_elves_denas.level_up
tt.hero.tombstone_show_time = fts(90)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = "hero_portraits_0005"
tt.info.i18n_key = "HERO_ELVES_DENAS"
tt.info.portrait = ((IS_PHONE and "portraits_hero") or "info_portraits_heroes") .. "_0005"
tt.info.ultimate_icon = "0005"
tt.main_script.insert = scripts2.hero_elves_denas.insert
tt.main_script.update = scripts2.hero_elves_denas.update
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = 0.21111111111111
tt.render.sprites[1].angles = {
	walk = {
		"walk"
	}
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_elves_denas"
tt.soldier.melee_slot_offset = v(10, 0)
tt.sound_events.change_rally_point = "ElvesHeroDenasTaunt"
tt.sound_events.death = "ElvesHeroDenasDeath"
tt.sound_events.respawn = "ElvesHeroDenasTauntIntro"
tt.sound_events.insert = "ElvesHeroDenasTauntIntro"
tt.sound_events.hero_room_select = "ElvesHeroDenasTauntSelect"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(0, 13)
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 0.95
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[3] = E.clone_c(E, "melee_attack")
tt.melee.attacks[3].animation = "specialAttack"
tt.melee.attacks[3].cooldown = 18
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].damage_type = DAMAGE_TRUE
tt.melee.attacks[3].hit_time = fts(25)
tt.melee.attacks[3].sound = "ElvesHeroDenasMighty"
tt.melee.attacks[3].sound_args = {
	delay = fts(17)
}
tt.melee.attacks[3].xp_from_skill = "mighty"
tt.melee.range = 72.5
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].bullet = "shield_elves_denas"
tt.ranged.attacks[1].bullet_start_offset = {
	v(22, 16)
}
tt.ranged.attacks[1].cooldown = 15
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].rebound_range = 125
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].animation = "shieldThrow"
tt.ranged.attacks[1].xp_from_skill = "shield_strike"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "showOff"
tt.timed_attacks.list[1].cooldown = 25
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(9)
tt.timed_attacks.list[1].mod = "mod_elves_denas_celebrity"
tt.timed_attacks.list[1].range = 100
tt.timed_attacks.list[1].sound = "ElvesHeroDenasCelebrity"
tt.timed_attacks.list[1].vis_bans = bor(F_BOSS)
tt.timed_attacks.list[1].vis_flags = bor(F_MOD, F_RANGED, F_STUN)
tt.timed_attacks.list[1].xp_from_skill = "celebrity"
tt.timed_attacks.list[2] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[2].animation = "eat"
tt.timed_attacks.list[2].cooldown = 20
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].hit_time = fts(37)
tt.timed_attacks.list[2].lost_health = 100
tt.timed_attacks.list[2].mod = "mod_elves_denas_sybarite"
tt.timed_attacks.list[2].sound = "ElvesHeroDenasSybarite"
tt.wealthy = {
	animation = "coinThrow",
	gold = 25,
	sound = "ElvesHeroDenasWealthy",
	last_wave = 1,
	hit_time = fts(9),
	fx = "fx_coin_jump"
}
tt = E.register_t(E, "hero_elves_denas_ultimate")

E.add_comps(E, tt, "pos", "main_script", "sound_events")

tt.cooldown = 60
tt.guards_count = {
	[0] = 1,
	2,
	3,
	4
}
tt.guards_template = "soldier_elves_denas_guard"
tt.main_script.update = scripts2.hero_elves_denas_ultimate.update
tt.sound_events.insert = "ElvesHeroDenasKingsguardTaunt"
tt.can_fire_fn = scripts2.hero_elves_denas_ultimate.can_fire_fn
tt = E.register_t(E, "soldier_elves_denas_guard", "soldier_militia")

E.add_comps(E, tt, "reinforcement", "tween")

image_y = 80
anchor_y = 0.25
tt.health.armor = 0.55
tt.health.hp_max = 350
tt.health_bar.offset = v(0, 40)
tt.info.fn = scripts2.soldier_reinforcement.get_info
tt.info.portrait = "portraits_sc_0059"
tt.info.random_name_count = 15
tt.info.random_name_format = "ELVES_SOLDIER_IMPERIAL_%i_NAME"
tt.main_script.insert = scripts2.soldier_reinforcement.insert
tt.main_script.update = scripts2.soldier_reinforcement.update
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].chance = 0.5
tt.melee.attacks[1].xp_gain_factor = 0
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.cooldown = 1
tt.melee.range = 72.5
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = 35
tt.reinforcement.duration = 25
tt.reinforcement.fade = nil
tt.reinforcement.fade_out = true
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "elves_denas_guard"
tt.render.sprites[1].name = "raise"
tt.sound_events.insert = nil
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.remove = false
tt.tween.disabled = true
tt.unit.level = 0
tt.vis.bans = bor(F_SKELETON, F_LYCAN)
tt = E.register_t(E, "mod_elves_denas_celebrity", "mod_shock_and_awe")
tt.modifier.duration = nil
tt = E.register_t(E, "mod_elves_denas_sybarite", "modifier")

E.add_comps(E, tt, "render")

tt.inflicted_damage_factor = 2
tt.heal_hp = nil
tt.main_script.insert = scripts2.mod_elves_denas_sybarite.insert
tt.main_script.remove = scripts2.mod_elves_denas_sybarite.remove
tt.main_script.update = scripts2.mod_track_target.update
tt.modifier.bans = {
	"mod_son_of_mactans_poison",
	"mod_drider_poison",
	"mod_dark_spitters",
	"mod_balrog"
}
tt.modifier.duration = fts(22)
tt.render.sprites[1].name = "fx_elves_denas_heal"
tt = E.register_t(E, "fx_elves_denas_flash", "fx")
tt.render.sprites[1].name = "fx_elves_denas_flash"
tt = E.register_t(E, "shield_elves_denas", "bullet")
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.particles_name = "ps_shield_elves_denas"
tt.bullet.max_speed = FPS*10
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_shield_elves_denas_hit"
tt.main_script.update = scripts2.shield_elves_denas.update
tt.render.sprites[1].name = "shield_elves_denas_loop"
tt.rebound_range = 125
tt = E.register_t(E, "fx_shield_elves_denas_hit", "fx")
tt.render.sprites[1].name = "fx_shield_elves_denas_hit"
tt.render.sprites[1].z = Z_EFFECTS - 1
tt = RT("hero_alleria", "hero")

AC(tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.14
anchor_x = 0.5
image_y = 76
image_x = 60
tt.hero.fixed_stat_attack = 3
tt.hero.fixed_stat_health = 3
tt.hero.fixed_stat_range = 6
tt.hero.fixed_stat_speed = 6
tt.hero.level_stats.armor = {
	0.1,
	0.15,
	0.15,
	0.15,
	0.2,
	0.2,
	0.2,
	0.25,
	0.25,
	0.3
}
tt.hero.level_stats.hp_max = {
	320,
	340,
	360,
	380,
	400,
	420,
	440,
	460,
	480,
	500
}
tt.hero.level_stats.melee_damage_max = {
	13,
	15,
	18,
	20,
	22,
	25,
	27,
	30,
	34,
	38
}
tt.hero.level_stats.melee_damage_min = {
	9,
	10,
	12,
	13,
	14,
	16,
	17,
	19,
	21,
	24
}
tt.hero.level_stats.ranged_damage_max = {
	13,
	15,
	18,
	20,
	22,
	25,
	27,
	30,
	34,
	38
}
tt.hero.level_stats.ranged_damage_min = {
	9,
	10,
	12,
	13,
	14,
	16,
	17,
	19,
	21,
	24
}
tt.hero.level_stats.regen_health = {
	80,
	85,
	90,
	95,
	100,
	105,
	110,
	115,
	120,
	125
}
tt.hero.skills.multishot = CC("hero_skill")
tt.hero.skills.multishot.count_base = 2
tt.hero.skills.multishot.count_inc = 3
tt.hero.skills.multishot.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.multishot.xp_gain = {
	25,
	50,
	75
}
tt.hero.skills.callofwild = CC("hero_skill")
tt.hero.skills.callofwild.damage_max_base = 20
tt.hero.skills.callofwild.damage_min_base = 10
tt.hero.skills.callofwild.damage_inc = 5
tt.hero.skills.callofwild.hp_base = 400
tt.hero.skills.callofwild.hp_inc = 200
tt.hero.skills.callofwild.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.callofwild.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 33)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_alleria.level_up
tt.hero.tombstone_show_time = fts(90)
tt.info.damage_icon = "arrow"
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0004") or "heroPortrait_portraits_0004"
tt.info.fn = scripts.hero_basic.get_info_ranged
tt.info.i18n_key = "HERO_ARCHER"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0004") or "info_portraits_hero_0001"
tt.main_script.update = scripts.hero_alleria.update
tt.motion.max_speed = FPS*3
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.14)
tt.render.sprites[1].prefix = "hero_alleria"
tt.soldier.melee_slot_offset = v(4, 0)
tt.sound_events.change_rally_point = "HeroArcherTaunt"
tt.sound_events.death = "HeroArcherDeath"
tt.sound_events.hero_room_select = "HeroArcherTauntSelect"
tt.sound_events.insert = "HeroArcherTauntIntro"
tt.sound_events.respawn = "HeroArcherTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.melee.attacks[1].cooldown = 0.6
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 2.5
tt.melee.range = 55
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].bullet = "arrow_hero_alleria"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 12)
}
tt.ranged.attacks[1].max_range = 180
tt.ranged.attacks[1].min_range = 45
tt.ranged.attacks[1].shoot_time = fts(6)
tt.ranged.attacks[1].cooldown = 0.7
tt.ranged.attacks[2] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[2].animation = "multishot"
tt.ranged.attacks[2].bullet = "arrow_multishot_hero_alleria"
tt.ranged.attacks[2].bullet_start_offset = {
	v(0, 12)
}
tt.ranged.attacks[2].cooldown = fts(29) + 3
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].max_range = 180
tt.ranged.attacks[2].min_range = 45
tt.ranged.attacks[2].node_prediction = fts(13)
tt.ranged.attacks[2].shoot_time = fts(13)
tt.ranged.attacks[2].sound = "HeroArcherShoot"
tt.ranged.attacks[2].xp_from_skill = "multishot"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animation = "callofwild"
tt.timed_attacks.list[1].cooldown = 10
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_alleria_wildcat"
tt.timed_attacks.list[1].pet = nil
tt.timed_attacks.list[1].sound = "HeroArcherSummon"
tt.timed_attacks.list[1].spawn_time = fts(17)
tt.timed_attacks.list[1].min_range = 30
tt.timed_attacks.list[1].max_range = 50
tt = RT("hero_bolin", "hero")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.24
anchor_x = 0.5
image_y = 82
image_x = 92
tt.hero.fixed_stat_attack = 5
tt.hero.fixed_stat_health = 6
tt.hero.fixed_stat_range = 5
tt.hero.fixed_stat_speed = 4
tt.hero.level_stats.armor = {
	0.45,
	0.45,
	0.5,
	0.5,
	0.5,
	0.55,
	0.55,
	0.6,
	0.6,
	0.65
}
tt.hero.level_stats.hp_max = {
	420,
	440,
	455,
	470,
	485,
	500,
	515,
	530,
	545,
	560
}
tt.hero.level_stats.melee_damage_max = {
	24,
	28,
	32,
	35,
	39,
	43,
	47,
	50,
	54,
	58
}
tt.hero.level_stats.melee_damage_min = {
	18,
	21,
	24,
	27,
	30,
	32,
	35,
	38,
	41,
	44
}
tt.hero.level_stats.ranged_damage_max = {
	24,
	28,
	32,
	35,
	39,
	43,
	47,
	50,
	54,
	58
}
tt.hero.level_stats.ranged_damage_min = {
	18,
	21,
	24,
	27,
	30,
	32,
	35,
	38,
	41,
	44
}
tt.hero.level_stats.regen_health = {
	105,
	110,
	114,
	117,
	121,
	125,
	129,
	133,
	137,
	140
}
tt.hero.skills.mines = CC("hero_skill")
tt.hero.skills.mines.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.mines.xp_gain = {
	25,
	50,
	75
}
tt.hero.skills.mines.damage_min = {
	60,
	120,
	180
}
tt.hero.skills.mines.damage_max = {
	60,
	120,
	180
}
tt.hero.skills.tar = CC("hero_skill")
tt.hero.skills.tar.duration = {
	6,
	9,
	12
}
tt.hero.skills.tar.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.tar.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 43)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_bolin.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.damage_icon = "shot"
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0003") or "heroPortrait_portraits_0003"
tt.info.fn = scripts.hero_bolin.get_info
tt.info.i18n_key = "HERO_RIFLEMAN"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0003") or "info_portraits_hero_0002"
tt.melee.range = 45
tt.main_script.update = scripts.hero_bolin.update
tt.motion.max_speed = FPS*1.9
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.24)
tt.render.sprites[1].prefix = "hero_bolin"
tt.render.sprites[1].angles.shoot = {
	"shootRightLeft",
	"shootUp",
	"shootDown"
}
tt.render.sprites[1].angles.shootAim = {
	"shootAimRightLeft",
	"shootAimUp",
	"shootAimDown"
}
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroRiflemanTaunt"
tt.sound_events.death = "HeroRiflemanDeath"
tt.sound_events.hero_room_select = "HeroRiflemanTauntSelect"
tt.sound_events.insert = "HeroRiflemanTauntIntro"
tt.sound_events.respawn = "HeroRiflemanTauntIntro"
tt.ui.click_rect = r(-15, -5, 30, 35)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].xp_gain_factor = 5
tt.timed_attacks.list[1] = CC("bullet_attack")
tt.timed_attacks.list[1].bullet = "shotgun_bolin"
tt.timed_attacks.list[1].aim_animation = "shootAim"
tt.timed_attacks.list[1].shoot_animation = "shoot"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(0, 20),
	v(0, 20),
	v(0, 20)
}
tt.timed_attacks.list[1].cooldown = 2
tt.timed_attacks.list[1].shoot_times = {
	fts(10),
	fts(12),
	fts(12)
}
tt.timed_attacks.list[1].max_shoots = 3
tt.timed_attacks.list[1].min_range = 50
tt.timed_attacks.list[1].max_range = 180
tt.timed_attacks.list[1].shoot_time = fts(2)
tt.timed_attacks.list[1].vis_bans = 0
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].xp_gain_factor = 3.1
tt.timed_attacks.list[2] = CC("bullet_attack")
tt.timed_attacks.list[2].bullet = "bomb_tar_bolin"
tt.timed_attacks.list[2].bullet_start_offset = v(0, 30)
tt.timed_attacks.list[2].cooldown = fts(27) + 18
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].min_range = 80
tt.timed_attacks.list[2].max_range = 180
tt.timed_attacks.list[2].shoot_time = fts(13)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[3] = CC("bullet_attack")
tt.timed_attacks.list[3].bullet = "bomb_mine_bolin"
tt.timed_attacks.list[3].bullet_start_offset = v(0, 12)
tt.timed_attacks.list[3].count = 9e+99
tt.timed_attacks.list[3].cooldown = fts(19) + 6
tt.timed_attacks.list[3].cooldown_mixed = fts(19) + 6
tt.timed_attacks.list[3].cooldown_flying = fts(19) + 2
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].max_range = 50
tt.timed_attacks.list[3].shoot_time = fts(3)
tt.timed_attacks.list[3].node_offset = {
	-6,
	6
}
tt = RT("hero_magnus", "hero")

AC(tt, "melee", "ranged", "timed_attacks", "teleport")

anchor_y = 0.14
anchor_x = 0.5
image_y = 76
image_x = 60
tt.hero.fixed_stat_attack = 2
tt.hero.fixed_stat_health = 2
tt.hero.fixed_stat_range = 8
tt.hero.fixed_stat_speed = 8
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.hp_max = {
	170,
	190,
	210,
	230,
	250,
	270,
	290,
	310,
	330,
	350
}
tt.hero.level_stats.melee_damage_max = {
	2,
	4,
	5,
	6,
	7,
	8,
	10,
	11,
	12,
	13
}
tt.hero.level_stats.melee_damage_min = {
	1,
	2,
	2,
	3,
	4,
	5,
	6,
	6,
	7,
	8
}
tt.hero.level_stats.ranged_damage_max = {
	27,
	32,
	35,
	38,
	40,
	43,
	46,
	49,
	52,
	56
}
tt.hero.level_stats.ranged_damage_min = {
	16,
	18,
	20,
	22,
	24,
	25,
	28,
	30,
	33,
	35
}
tt.hero.level_stats.regen_health = {
	43,
	48,
	53,
	58,
	63,
	68,
	73,
	78,
	83,
	88
}
tt.hero.skills.mirage = CC("hero_skill")
tt.hero.skills.mirage.count = {
	1,
	2,
	3
}
tt.hero.skills.mirage.health_factor = 0.3
tt.hero.skills.mirage.damage_factor = 0.2
tt.hero.skills.mirage.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.mirage.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.arcane_rain = CC("hero_skill")
tt.hero.skills.arcane_rain.count = {
	6,
	12,
	18
}
tt.hero.skills.arcane_rain.damage = {
	20,
	25,
	30
}
tt.hero.skills.arcane_rain.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.arcane_rain.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 33)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_magnus.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0005") or "heroPortrait_portraits_0005"
tt.info.fn = scripts.hero_basic.get_info_ranged
tt.info.i18n_key = "HERO_MAGE"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0005") or "info_portraits_hero_0004"
tt.main_script.update = scripts.hero_magnus.update
tt.motion.max_speed = FPS*1.2
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "hero_magnus"
tt.soldier.melee_slot_offset = v(4, 0)
tt.sound_events.death = "HeroMageDeath"
tt.sound_events.insert = "HeroMageTauntIntro"
tt.sound_events.respawn = "HeroMageTauntIntro"
tt.sound_events.change_rally_point = "HeroMageTaunt"
tt.sound_events.hero_room_select = "HeroMageTauntSelect"
tt.teleport.min_distance = 50
tt.teleport.delay = 0
tt.teleport.sound = "TeleporthSound"
tt.ui.click_rect = r(-13, -5, 26, 32)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.melee.range = 45
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].xp_gain_factor = 2.1
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].bullet = "bolt_magnus"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 23)
}
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].cooldown = fts(33)
tt.timed_attacks.list[1] = CC("spawn_attack")
tt.timed_attacks.list[1].animation = "mirage"
tt.timed_attacks.list[1].cooldown = fts(29) + 10
tt.timed_attacks.list[1].cast_time = fts(12)
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_magnus_illusion"
tt.timed_attacks.list[1].entity_rotations = {
	{
		d2r(0)
	},
	{
		d2r(0),
		d2r(180)
	},
	{
		d2r(0),
		d2r(120),
		d2r(240)
	}
}
tt.timed_attacks.list[1].sound = "HeroMageShadows"
tt.timed_attacks.list[1].spawn_time = fts(19)
tt.timed_attacks.list[1].initial_rally = v(0, 30)
tt.timed_attacks.list[1].initial_pos = v(0, 33)
tt.timed_attacks.list[1].radius = 30
tt.timed_attacks.list[1].spawn_time = fts(19)
tt.timed_attacks.list[1].spawn_time = fts(19)
tt.timed_attacks.list[1].xp_from_skill = "mirage"
tt.timed_attacks.list[2] = CC("spawn_attack")
tt.timed_attacks.list[2].animation = "arcaneRain"
tt.timed_attacks.list[2].entity = "magnus_arcane_rain_controller"
tt.timed_attacks.list[2].cooldown = fts(25) + 14
tt.timed_attacks.list[2].cast_time = fts(15)
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].max_range = 150
tt.timed_attacks.list[2].min_range = 50
tt.timed_attacks.list[2].sound = "HeroMageRainCharge"
tt.timed_attacks.list[2].vis_bans = bor(F_FRIEND, F_FLYING)
tt.timed_attacks.list[2].vis_flags = F_RANGED
tt.timed_attacks.list[2].xp_from_skill = "arcane_rain"
tt = RT("hero_ignus", "hero")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.1
anchor_x = 0.5
image_y = 72
image_x = 60
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 6
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 6
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.hp_max = {
	400,
	430,
	460,
	490,
	520,
	550,
	580,
	610,
	640,
	670
}
tt.hero.level_stats.melee_damage_max = {
	30,
	33,
	35,
	38,
	40,
	43,
	45,
	48,
	50,
	53
}
tt.hero.level_stats.melee_damage_min = {
	18,
	20,
	21,
	23,
	24,
	26,
	27,
	29,
	30,
	32
}
tt.hero.level_stats.regen_health = {
	100,
	108,
	115,
	123,
	130,
	138,
	145,
	153,
	160,
	168
}
tt.hero.skills.flaming_frenzy = CC("hero_skill")
tt.hero.skills.flaming_frenzy.damage_max = {
	30,
	50,
	70
}
tt.hero.skills.flaming_frenzy.damage_min = {
	20,
	40,
	60
}
tt.hero.skills.flaming_frenzy.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.flaming_frenzy.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.surge_of_flame = CC("hero_skill")
tt.hero.skills.surge_of_flame.damage_max = {
	30,
	40,
	50
}
tt.hero.skills.surge_of_flame.damage_min = {
	10,
	20,
	30
}
tt.hero.skills.surge_of_flame.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.surge_of_flame.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 12
tt.health_bar.offset = v(0, 41)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_ignus.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0006") or "heroPortrait_portraits_0006"
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.i18n_key = "HERO_FIRE"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0006") or "info_portraits_hero_0003"
tt.main_script.update = scripts.hero_ignus.update
tt.motion.max_speed = FPS*3
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "hero_ignus"
tt.run_particles_name = "ps_ignus_run"
tt.particles_aura = "aura_ignus_idle"
tt.soldier.melee_slot_offset = v(6, 0)
tt.sound_events.change_rally_point = "HeroRainOfFireTaunt"
tt.sound_events.death = "HeroRainOfFireDeath"
tt.sound_events.hero_room_select = "HeroRainOfFireTauntSelect"
tt.sound_events.insert = "HeroRainOfFireTauntIntro"
tt.sound_events.respawn = "HeroRainOfFireTauntIntro"
tt.unit.hit_offset = v(0, 19)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.vis.bans = bor(tt.vis.bans, F_BURN)
tt.melee.range = 55 
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[1].sound_hit = "HeroReinforcementHit"
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].animation = "flamingFrenzy"
tt.timed_attacks.list[1].cast_time = fts(8)
tt.timed_attacks.list[1].chance = 1
tt.timed_attacks.list[1].cooldown = fts(24) + 6
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].decal = "decal_ignus_flaming"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].heal_factor = 0.2
tt.timed_attacks.list[1].hit_fx = "fx_ignus_burn"
tt.timed_attacks.list[1].max_range = 90
tt.timed_attacks.list[1].sound = "HeroRainOfFireArea"
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND)
tt.timed_attacks.list[1].vis_flags = bor(F_AREA)
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].animations = {
	"surgeOfFlame",
	"surgeOfFlame_end"
}
tt.timed_attacks.list[2].aura = "aura_ignus_surge_of_flame"
tt.timed_attacks.list[2].cooldown = 4
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].nodes_margin = 8
tt.timed_attacks.list[2].min_range = 40
tt.timed_attacks.list[2].max_range = 130
tt.timed_attacks.list[2].speed_factor = 3.3333333333333335
tt.timed_attacks.list[2].sound = "HeroRainOfFireFireball1"
tt.timed_attacks.list[2].sound_end = "HeroRainOfFireFireball2"
tt.timed_attacks.list[2].vis_bans = bor(F_FRIEND)
tt.timed_attacks.list[2].vis_flags = bor(F_ENEMY, F_BLOCK)
tt = RT("hero_malik", "hero")

AC(tt, "melee")

anchor_y = 0.1
anchor_x = 0.5
image_y = 100
image_x = 96
tt.hero.fixed_stat_attack = 7
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 4
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.hp_max = {
	450,
	480,
	510,
	540,
	570,
	600,
	630,
	660,
	690,
	720
}
tt.hero.level_stats.melee_damage_max = {
	22,
	24,
	26,
	29,
	31,
	34,
	36,
	38,
	41,
	43
}
tt.hero.level_stats.melee_damage_min = {
	14,
	16,
	18,
	19,
	21,
	22,
	24,
	26,
	27,
	29
}
tt.hero.level_stats.regen_health = {
	113,
	120,
	128,
	135,
	143,
	150,
	158,
	165,
	173,
	180
}
tt.hero.skills.smash = CC("hero_skill")
tt.hero.skills.smash.damage_min = {
	25,
	50,
	75
}
tt.hero.skills.smash.damage_max = {
	45,
	75,
	100
}
tt.hero.skills.smash.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.smash.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.fissure = CC("hero_skill")
tt.hero.skills.fissure.damage_min = {
	20,
	40,
	60
}
tt.hero.skills.fissure.damage_max = {
	40,
	60,
	80
}
tt.hero.skills.fissure.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.fissure.xp_gain = {
	300,
	600,
	900
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 38)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_malik.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0001") or "heroPortrait_portraits_0001"
tt.info.i18n_key = "HERO_REINFORCEMENT"
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0001") or "info_portraits_hero_0006"
tt.main_script.update = scripts.hero_malik.update
tt.motion.max_speed = FPS*2
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.1)
tt.render.sprites[1].prefix = "hero_malik"
tt.soldier.melee_slot_offset = v(5, 0)
tt.sound_events.change_rally_point = "HeroReinforcementTaunt"
tt.sound_events.death = "HeroReinforcementDeath"
tt.sound_events.hero_room_select = "HeroReinforcementTauntSelect"
tt.sound_events.insert = "HeroReinforcementTauntIntro"
tt.sound_events.respawn = "HeroReinforcementTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.melee.range = 55
tt.melee.cooldown = 1
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[1].sound_hit = "HeroReinforcementHit"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[3] = CC("area_attack")
tt.melee.attacks[3].animation = "smash"
tt.melee.attacks[3].cooldown = fts(28) + 6
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].damage_radius = 60
tt.melee.attacks[3].damage_type = DAMAGE_TRUE
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].hit_decal = "decal_bomb_crater"
tt.melee.attacks[3].hit_fx = "decal_malik_ring"
tt.melee.attacks[3].hit_time = fts(14)
tt.melee.attacks[3].hit_offset = v(22, 0)
tt.melee.attacks[3].min_count = 1
tt.melee.attacks[3].sound = "HeroReinforcementSpecial"
tt.melee.attacks[3].xp_from_skill = "smash"
tt.melee.attacks[4] = CC("area_attack")
tt.melee.attacks[4].animation = "fissure"
tt.melee.attacks[4].cooldown = fts(37) + 14
tt.melee.attacks[4].damage_max = 0
tt.melee.attacks[4].damage_min = 0
tt.melee.attacks[4].damage_radius = 50
tt.melee.attacks[4].damage_type = DAMAGE_NONE
tt.melee.attacks[4].disabled = true
tt.melee.attacks[4].hit_aura = "aura_malik_fissure"
tt.melee.attacks[4].hit_offset = v(22, 0)
tt.melee.attacks[4].hit_time = fts(17)
tt.melee.attacks[4].sound = "HeroReinforcementJump"
tt.melee.attacks[4].xp_from_skill = "fissure"
tt = RT("hero_denas", "hero")

AC(tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.26
anchor_x = 0.5
image_y = 108
image_x = 152
tt.hero.fixed_stat_attack = 6
tt.hero.fixed_stat_health = 5
tt.hero.fixed_stat_range = 6
tt.hero.fixed_stat_speed = 3
tt.hero.level_stats.armor = {
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
tt.hero.level_stats.hp_max = {
	300,
	320,
	340,
	360,
	380,
	400,
	420,
	440,
	460,
	480
}
tt.hero.level_stats.melee_damage_max = {
	19,
	23,
	28,
	33,
	38,
	42,
	47,
	52,
	56,
	61
}
tt.hero.level_stats.melee_damage_min = {
	11,
	14,
	17,
	20,
	23,
	25,
	28,
	31,
	34,
	37
}
tt.hero.level_stats.ranged_damage_max = {
	19,
	23,
	28,
	33,
	38,
	42,
	47,
	52,
	56,
	61
}
tt.hero.level_stats.ranged_damage_min = {
	11,
	14,
	17,
	20,
	23,
	25,
	28,
	31,
	34,
	37
}
tt.hero.level_stats.regen_health = {
	75,
	80,
	85,
	90,
	95,
	100,
	105,
	110,
	115,
	120
}
tt.hero.skills.tower_buff = CC("hero_skill")
tt.hero.skills.tower_buff.duration = {
	5,
	8,
	11
}
tt.hero.skills.tower_buff.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.tower_buff.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.catapult = CC("hero_skill")
tt.hero.skills.catapult.count = {
	3,
	5,
	7
}
tt.hero.skills.catapult.damage_min = {
	10,
	20,
	30
}
tt.hero.skills.catapult.damage_max = {
	30,
	40,
	50
}
tt.hero.skills.catapult.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.catapult.xp_gain = {
	100,
	200,
	300
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_denas.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = IS_PHONE_OR_TABLET and "hero_portraits_0007" or "heroPortrait_portraits_0007"
tt.info.i18n_key = "HERO_DENAS"
tt.info.fn = scripts.hero_basic.get_info_ranged
tt.info.portrait = IS_PHONE_OR_TABLET and "portraits_hero_0008" or "info_portraits_hero_0008"
tt.main_script.update = scripts.hero_denas.update
tt.motion.max_speed = 2 * FPS
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "hero_denas"
tt.soldier.melee_slot_offset = v(22, 0)
tt.sound_events.change_rally_point = "HeroDenasTaunt"
tt.sound_events.death = "HeroDenasDeath"
tt.sound_events.hero_room_select = "HeroDenasTauntSelect"
tt.sound_events.insert = "HeroRainOfFireTauntIntro"
tt.sound_events.respawn = "HeroRainOfFireTauntIntro"
tt.ui.click_rect = r(-22, 15, 44, 32)
tt.unit.hit_offset = v(0, 31)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 30)
tt.melee.range = 45
tt.ranged.attacks[1] = CC("bullet_attack")
tt.ranged.attacks[1].animations = {
	"attack",
	"attackBarrell",
	"attackChicken",
	"attackBottle"
}
tt.ranged.attacks[1].bullet = "projectile_denas"
tt.ranged.attacks[1].bullets = {
	"projectile_denas",
	"projectile_denas_barrell",
	"projectile_denas_chicken",
	"projectile_denas_bottle"
}
tt.ranged.attacks[1].bullet_start_offset = {
	v(10, 36)
}
tt.ranged.attacks[1].cooldown = fts(19)
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 45
tt.ranged.attacks[1].node_prediction = fts(10)
tt.ranged.attacks[1].shoot_time = fts(7)
tt.timed_attacks.list[1] = table.deepclone(tt.ranged.attacks[1])
tt.timed_attacks.list[1].bullets = {
	"projectile_denas_melee",
	"projectile_denas_melee_barrell",
	"projectile_denas_melee_chicken",
	"projectile_denas_melee_bottle"
}
tt.timed_attacks.list[1].cooldown = 0.67
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[2] = CC("mod_attack")
tt.timed_attacks.list[2].animation = "buffTowers"
tt.timed_attacks.list[2].cooldown = 10 + fts(51)
tt.timed_attacks.list[2].cast_time = fts(13)
tt.timed_attacks.list[2].curse_time = fts(2)
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].max_range = 165
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].mod = "mod_denas_tower"
tt.timed_attacks.list[2].excluded_templates = {
	"tower_pixie"
}
tt.timed_attacks.list[2].aura = "denas_buff_aura"
tt.timed_attacks.list[2].sound = "HeroDenasBuff"
tt.timed_attacks.list[2].xp_from_skill = "buff_towers"
tt.timed_attacks.list[3] = CC("spawn_attack")
tt.timed_attacks.list[3].animation = "catapult"
tt.timed_attacks.list[3].entity = "denas_catapult_controller"
tt.timed_attacks.list[3].cooldown = 10 + fts(40)
tt.timed_attacks.list[3].cast_time = fts(15)
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].max_range = 165
tt.timed_attacks.list[3].min_range = 50
tt.timed_attacks.list[3].sound = "HeroDenasAttack"
tt.timed_attacks.list[3].vis_bans = bor(F_FRIEND, F_FLYING)
tt.timed_attacks.list[3].vis_flags = F_RANGED
tt.timed_attacks.list[3].xp_from_skill = "catapult"
tt = RT("hero_ingvar", "hero")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.19
anchor_x = 0.5
image_y = 116
image_x = 142
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 5
tt.hero.level_stats.armor = {
	0.1,
	0.1,
	0.15,
	0.15,
	0.2,
	0.2,
	0.25,
	0.25,
	0.25,
	0.3
}
tt.hero.level_stats.hp_max = {
	440,
	480,
	520,
	560,
	600,
	640,
	680,
	720,
	760,
	800
}
tt.hero.level_stats.melee_damage_max = {
	38,
	41,
	45,
	49,
	53,
	56,
	60,
	64,
	68,
	71
}
tt.hero.level_stats.melee_damage_min = {
	23,
	25,
	27,
	29,
	32,
	34,
	36,
	38,
	41,
	43
}
tt.hero.level_stats.regen_health = {
	110,
	120,
	130,
	140,
	150,
	160,
	170,
	180,
	190,
	200
}
tt.hero.skills.ancestors_call = CC("hero_skill")
tt.hero.skills.ancestors_call.count = {
	2,
	3,
	4
}
tt.hero.skills.ancestors_call.hp_max = {
	100,
	150,
	200
}
tt.hero.skills.ancestors_call.damage_min = {
	2,
	4,
	6
}
tt.hero.skills.ancestors_call.damage_max = {
	6,
	8,
	10
}
tt.hero.skills.ancestors_call.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.ancestors_call.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.bear = CC("hero_skill")
tt.hero.skills.bear.damage_min = {
	30,
	40,
	50
}
tt.hero.skills.bear.damage_max = {
	50,
	60,
	70
}
tt.hero.skills.bear.duration = {
	10,
	12,
	14
}
tt.hero.skills.bear.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.bear.xp_gain = {
	100,
	200,
	300
}
tt.auras.list[1] = CC("aura_attack")
tt.auras.list[1].name = "aura_ingvar_bear_regenerate"
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, ady(68))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_ingvar.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0009") or "heroPortrait_portraits_0009"
tt.info.fn = scripts.hero_ingvar.get_info
tt.info.i18n_key = "HERO_VIKING"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0010") or "info_portraits_hero_0010"
tt.main_script.update = scripts.hero_ingvar.update
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "hero_ingvar"
tt.soldier.melee_slot_offset = v(14, 0)
tt.sound_events.change_rally_point = "HeroVikingTaunt"
tt.sound_events.change_rally_point_viking = "HeroVikingTaunt"
tt.sound_events.change_rally_point_bear = "HeroVikingBearTransform"
tt.sound_events.death = "HeroVikingDeath"
tt.sound_events.hero_room_select = "HeroVikingTauntSelect"
tt.sound_events.insert = "HeroVikingTauntIntro"
tt.sound_events.respawn = "HeroVikingTauntIntro"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.unit.hit_offset = v(0, 20)
tt.melee.range = 55
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "HeroVikingAttackHit"
tt.melee.attacks[1].hit_decal = "decal_ingvar_attack"
tt.melee.attacks[1].hit_offset = v(48, -1)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].hit_offset = v(-25, 2)
tt.melee.attacks[3] = CC("melee_attack")
tt.melee.attacks[3].animations = {
	nil,
	"attack"
}
tt.melee.attacks[3].cooldown = 3
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].hit_times = {
	fts(10),
	fts(25),
	fts(41)
}
tt.melee.attacks[3].loopable = true
tt.melee.attacks[3].loops = 1
tt.melee.attacks[3].sound_hit = "HeroVikingAttackHit"
tt.melee.attacks[3].sound = "HeroVikingBearAttackStart"
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.attacks[3].xp_gain_factor = 2
tt.timed_attacks.list[1] = CC("spawn_attack")
tt.timed_attacks.list[1].animation = "ancestors"
tt.timed_attacks.list[1].cooldown = fts(40) + 10
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].entity = "soldier_ingvar_ancestor"
tt.timed_attacks.list[1].sound = "HeroVikingCall"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(5)
}
tt.timed_attacks.list[1].nodes_offset = {
	4,
	8
}
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].cooldown = 10
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].duration = nil
tt.timed_attacks.list[2].transform_health_factor = 0.8
tt.timed_attacks.list[2].immune_to = bor(DAMAGE_BASE_TYPES, DAMAGE_MODIFIER)
tt.timed_attacks.list[2].sound = "HeroVikingBearTransform"
tt = RT("hero_elora", "hero")

AC(tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.17
anchor_x = 0.5
tt.hero.fixed_stat_attack = 2
tt.hero.fixed_stat_health = 3
tt.hero.fixed_stat_range = 8
tt.hero.fixed_stat_speed = 7
tt.hero.level_stats.armor = {
	0.2,
	0.2,
	0.2,
	0.3,
	0.3,
	0.3,
	0.4,
	0.4,
	0.4,
	0.5
}
tt.hero.level_stats.hp_max = {
	270,
	290,
	310,
	330,
	350,
	370,
	390,
	410,
	430,
	450
}
tt.hero.level_stats.melee_damage_max = {
	2,
	4,
	6,
	8,
	11,
	13,
	16,
	18,
	20,
	23
}
tt.hero.level_stats.melee_damage_min = {
	1,
	2,
	4,
	6,
	7,
	9,
	10,
	12,
	14,
	15
}
tt.hero.level_stats.ranged_damage_max = {
	40,
	44,
	48,
	52,
	56,
	60,
	64,
	68,
	72,
	75
}
tt.hero.level_stats.ranged_damage_min = {
	28,
	31,
	34,
	37,
	40,
	43,
	46,
	49,
	52,
	55
}
tt.hero.level_stats.regen_health = {
	68,
	73,
	78,
	83,
	88,
	93,
	98,
	103,
	108,
	113
}
tt.hero.skills.chill = CC("hero_skill")
tt.hero.skills.chill.slow_factor = {
	0.4,
	0.3,
	0.2
}
tt.hero.skills.chill.max_range = {
	150,
	150,
	150
}
tt.hero.skills.chill.count = {
	8,
	10,
	12
}
tt.hero.skills.chill.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.chill.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.ice_storm = CC("hero_skill")
tt.hero.skills.ice_storm.count = {
	3,
	5,
	8
}
tt.hero.skills.ice_storm.damage_max = {
	60,
	60,
	60
}
tt.hero.skills.ice_storm.damage_min = {
	30,
	30,
	30
}
tt.hero.skills.ice_storm.max_range = {
	150,
	150,
	150
}
tt.hero.skills.ice_storm.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.ice_storm.xp_gain = {
	100,
	200,
	300
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 46)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_elora.level_up
tt.hero.tombstone_show_time = fts(60)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0008") or "heroPortrait_portraits_0008"
tt.info.i18n_key = "HERO_FROST_SORCERER"
tt.info.fn = scripts.hero_basic.get_info_ranged
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0009") or "info_portraits_hero_0009"
tt.main_script.update = scripts.hero_elora.update
tt.motion.max_speed = FPS*3
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.17)
tt.render.sprites[1].prefix = "hero_elora"
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "hero_elora_frostEffect"
tt.render.sprites[2].anchor = v(0.5, 0.1)
tt.render.sprites[2].hidden = true
tt.render.sprites[2].loop = true
tt.render.sprites[2].ignore_start = true
tt.run_particles_name = "ps_elora_run"
tt.soldier.melee_slot_offset = v(12, 0)
tt.sound_events.change_rally_point = "HeroFrostTaunt"
tt.sound_events.death = "HeroFrostDeath"
tt.sound_events.hero_room_select = "HeroFrostTauntSelect"
tt.sound_events.insert = "HeroFrostTauntIntro"
tt.sound_events.respawn = "HeroFrostTauntIntro"
tt.ui.click_rect = r(-15, -5, 30, 40)
tt.unit.mod_offset = v(0, 15)
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 2
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.range = 45
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].cooldown = fts(54)
tt.ranged.attacks[1].bullet = "bolt_elora_freeze"
tt.ranged.attacks[1].bullet_start_offset = {
	v(18, 36)
}
tt.ranged.attacks[1].chance = 0.2
tt.ranged.attacks[1].filter_fn = scripts.hero_elora.freeze_filter_fn
tt.ranged.attacks[1].min_range = 23.04
tt.ranged.attacks[1].max_range = 166.4
tt.ranged.attacks[1].shoot_time = fts(19)
tt.ranged.attacks[1].shared_cooldown = true
tt.ranged.attacks[1].vis_bans = bor(F_BOSS)
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.ranged.attacks[1].xp_gain_factor = 2
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].bullet = "bolt_elora_slow"
tt.ranged.attacks[2].chance = 1
tt.ranged.attacks[2].filter_fn = nil
tt.ranged.attacks[2].vis_bans = 0
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].animation = "iceStorm"
tt.timed_attacks.list[1].bullet = "elora_ice_spike"
tt.timed_attacks.list[1].cast_time = fts(24)
tt.timed_attacks.list[1].cooldown = fts(39) + 10
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].max_range = nil
tt.timed_attacks.list[1].min_range = 38.4
tt.timed_attacks.list[1].nodes_offset = 4
tt.timed_attacks.list[1].sound = "HeroFrostIceRainSummon"
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_FRIEND)
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].xp_from_skill = "ice_storm"
tt.timed_attacks.list[2] = CC("aura_attack")
tt.timed_attacks.list[2].animation = "chill"
tt.timed_attacks.list[2].bullet = "aura_chill_elora"
tt.timed_attacks.list[2].cast_time = fts(18)
tt.timed_attacks.list[2].cooldown = fts(28) + 8
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].max_range = nil
tt.timed_attacks.list[2].min_range = 19.2
tt.timed_attacks.list[2].sound = "HeroFrostGroundFreeze"
tt.timed_attacks.list[2].step = 3
tt.timed_attacks.list[2].nodes_offset = 6
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING, F_FRIEND)
tt.timed_attacks.list[2].vis_flags = F_RANGED
tt.timed_attacks.list[2].xp_from_skill = "chill"
tt = RT("hero_oni", "hero")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.14285714285714285
anchor_x = 0.5
image_y = 112
image_x = 128
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 7
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 6
tt.hero.level_stats.armor = {
	0.3,
	0.3,
	0.3,
	0.4,
	0.4,
	0.4,
	0.5,
	0.5,
	0.6,
	0.6
}
tt.hero.level_stats.hp_max = {
	425,
	450,
	475,
	500,
	525,
	550,
	575,
	600,
	625,
	650
}
tt.hero.level_stats.melee_damage_max = {
	26,
	30,
	36,
	38,
	41,
	45,
	49,
	53,
	56,
	60
}
tt.hero.level_stats.melee_damage_min = {
	18,
	20,
	24,
	26,
	28,
	30,
	33,
	36,
	38,
	40
}
tt.hero.level_stats.regen_health = {
	106,
	113,
	119,
	125,
	131,
	138,
	144,
	150,
	156,
	163
}
tt.hero.skills.death_strike = CC("hero_skill")
tt.hero.skills.death_strike.chance = {
	0.1,
	0.15,
	0.2
}
tt.hero.skills.death_strike.damage = {
	180,
	260,
	340
}
tt.hero.skills.death_strike.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.death_strike.xp_gain = {
	150,
	250,
	350
}
tt.hero.skills.torment = CC("hero_skill")
tt.hero.skills.torment.min_damage = {
	50,
	80,
	110
}
tt.hero.skills.torment.max_damage = {
	80,
	110,
	140
}
tt.hero.skills.torment.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.torment.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 18
tt.health.on_damage = scripts.hero_oni.on_damage
tt.health_bar.offset = v(0, 50)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_oni.level_up
tt.hero.tombstone_show_time = fts(150)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0011") or "heroPortrait_portraits_0011"
tt.info.i18n_key = "HERO_SAMURAI"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_hero_0013"
tt.melee.range = 55
tt.main_script.update = scripts.hero_oni.update
tt.motion.max_speed = FPS*2.7
tt.regen.cooldown = 1
tt.render.sprites[1].prefix = "hero_oni"
tt.render.sprites[1].anchor = v(0.5, 0.14285714285714285)
tt.soldier.melee_slot_offset = v(8, 0)
tt.sound_events.change_rally_point = "HeroSamuraiTaunt"
tt.sound_events.death = "HeroSamuraiDeath"
tt.sound_events.hero_room_select = "HeroSamuraiTauntSelect"
tt.sound_events.insert = "HeroSamuraiTauntIntro"
tt.sound_events.respawn = "HeroSamuraiTauntIntro"
tt.unit.hit_offset = v(0, 21)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.pop_offset = v(0, 10)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].xp_gain_factor = 2.5
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].animation = "deathStrike"
tt.melee.attacks[2].chance = 0.1
tt.melee.attacks[2].cooldown = fts(48) + 10
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].damage_min = 180
tt.melee.attacks[2].damage_max = 180
tt.melee.attacks[2].damage_type = bor(DAMAGE_NO_DODGE, DAMAGE_INSTAKILL)
tt.melee.attacks[2].hit_time = fts(28)
tt.melee.attacks[2].pop = {
	"pop_splat"
}
tt.melee.attacks[2].pop_chance = 1
tt.melee.attacks[2].sound = "HeroSamuraiDeathStrike"
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].xp_from_skill = "death_strike"
tt.melee.attacks[2].vis_flags = bor(F_INSTAKILL)
tt.melee.attacks[2].vis_bans = bor(F_BOSS)
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[2])
tt.melee.attacks[3].chance = 1
tt.melee.attacks[3].damage_type = bor(DAMAGE_NO_DODGE, DAMAGE_TRUE)
tt.melee.attacks[3].pop = {
	"pop_sok",
	"pop_pow"
}
tt.melee.attacks[3].pop_chance = 0.1
tt.melee.attacks[3].vis_flags = F_RANGED
tt.melee.attacks[3].vis_bans = 0
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "torment"
tt.timed_attacks.list[1].cooldown = fts(68) + 14
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].damage_min = 50
tt.timed_attacks.list[1].damage_max = 80
tt.timed_attacks.list[1].damage_type = bor(DAMAGE_NO_DODGE, DAMAGE_TRUE)
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].max_range = 100
tt.timed_attacks.list[1].damage_radius = 100
tt.timed_attacks.list[1].hit_time = fts(16)
tt.timed_attacks.list[1].damage_delay = 0.15
tt.timed_attacks.list[1].sound_hit = "HeroSamuraiTorment"
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1].torment_swords = {
	{
		0.01,
		20,
		8
	},
	{
		0.2,
		37.5,
		8
	},
	{
		0.3,
		55,
		8
	}
}
tt = RT("hero_hacksaw", "hero")

AC(tt, "melee", "ranged")

anchor_y = 0.13636363636363635
anchor_x = 0.5
image_y = 110
image_x = 90
tt.hero.fixed_stat_attack = 7
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 3
tt.hero.level_stats.armor = {
	0.5,
	0.5,
	0.55,
	0.55,
	0.6,
	0.6,
	0.65,
	0.65,
	0.65,
	0.7
}
tt.hero.level_stats.hp_max = {
	420,
	440,
	460,
	480,
	500,
	520,
	540,
	560,
	580,
	600
}
tt.hero.level_stats.melee_damage_max = {
	27,
	30,
	33,
	36,
	39,
	42,
	45,
	48,
	51,
	54
}
tt.hero.level_stats.melee_damage_min = {
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	20
}
tt.hero.level_stats.regen_health = {
	105,
	110,
	115,
	120,
	125,
	130,
	135,
	140,
	145,
	150
}
tt.hero.skills.timber = CC("hero_skill")
tt.hero.skills.timber.cooldown = {
	fts(35) + 35,
	fts(35) + 30,
	fts(35) + 25
}
tt.hero.skills.timber.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.timber.xp_gain = {
	750,
	1500,
	2250
}
tt.hero.skills.sawblade = CC("hero_skill")
tt.hero.skills.sawblade.bounces = {
	2,
	4,
	6
}
tt.hero.skills.sawblade.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.sawblade.xp_gain = {
	50,
	100,
	150
}
tt.health.dead_lifetime = 15
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 58)
tt.hero.fn_level_up = scripts.hero_hacksaw.level_up
tt.hero.tombstone_show_time = fts(150)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0010") or "heroPortrait_portraits_0010"
tt.info.i18n_key = "HERO_ROBOT"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0012") or "info_portraits_hero_0012"
tt.main_script.update = scripts.hero_hacksaw.update
tt.motion.max_speed = FPS*1.8
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.13636363636363635)
tt.render.sprites[1].prefix = "hero_hacksaw"
tt.soldier.melee_slot_offset = v(13, 0)
tt.sound_events.change_rally_point = "HeroRobotTaunt"
tt.sound_events.death = "BombExplosionSound"
tt.sound_events.death2 = "HeroRobotDeath"
tt.sound_events.hero_room_select = "HeroRobotTauntSelect"
tt.sound_events.insert = "HeroRobotTauntIntro"
tt.sound_events.respawn = "HeroRobotTauntIntro"
tt.unit.hit_offset = v(0, 38)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 25)
tt.unit.pop_offset = v(0, 15)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.melee.order = {
	2,
	1
}
tt.melee.range = 55
tt.melee.attacks[1].cooldown = 1.2
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 2.5
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].animation = "timber"
tt.melee.attacks[2].cooldown = nil
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(14)
tt.melee.attacks[2].pop = {
	"pop_splat"
}
tt.melee.attacks[2].pop_chance = 1
tt.melee.attacks[2].sound = "HeroRobotDrill"
tt.melee.attacks[2].sound_args = {
	delay = fts(7)
}
tt.melee.attacks[2].damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_NO_DODGE)
tt.melee.attacks[2].xp_from_skill = "timber"
tt.melee.attacks[2].vis_flags = bor(F_INSTAKILL)
tt.melee.attacks[2].vis_bans = bor(F_BOSS)
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "sawblade"
tt.ranged.attacks[1].bullet = "hacksaw_sawblade"
tt.ranged.attacks[1].bullet_start_offset = {
	v(25, 21)
}
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(16)
tt.ranged.attacks[1].sound_shoot = "HeroRobotShoot"
tt.ranged.attacks[1].cooldown = fts(32) + 8
tt.ranged.attacks[1].xp_from_skill = "sawblade"
tt = RT("hero_thor", "hero")

AC(tt, "melee", "ranged")

anchor_y = 0.25
anchor_x = 0.5
image_y = 96
image_x = 120
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 7
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 5
tt.hero.level_stats.armor = {
	0.4,
	0.4,
	0.4,
	0.5,
	0.5,
	0.5,
	0.6,
	0.6,
	0.6,
	0.7
}
tt.hero.level_stats.hp_max = {
	380,
	410,
	440,
	470,
	500,
	530,
	560,
	590,
	620,
	650
}
tt.hero.level_stats.melee_damage_max = {
	31,
	34,
	36,
	39,
	42,
	44,
	47,
	49,
	52,
	55
}
tt.hero.level_stats.melee_damage_min = {
	25,
	27,
	29,
	32,
	34,
	36,
	38,
	40,
	42,
	44
}
tt.hero.level_stats.regen_health = {
	95,
	103,
	110,
	118,
	125,
	133,
	140,
	148,
	155,
	163
}
tt.hero.skills.chainlightning = CC("hero_skill")
tt.hero.skills.chainlightning.count = {
	1,
	2,
	3
}
tt.hero.skills.chainlightning.damage_max = {
	40,
	60,
	80
}
tt.hero.skills.chainlightning.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.chainlightning.xp_gain = {
	50,
	100,
	150
}
tt.hero.skills.thunderclap = CC("hero_skill")
tt.hero.skills.thunderclap.damage_max = {
	60,
	90,
	120
}
tt.hero.skills.thunderclap.secondary_damage_max = {
	50,
	70,
	90
}
tt.hero.skills.thunderclap.max_range = {
	70,
	75,
	80
}
tt.hero.skills.thunderclap.stun_duration = {
	3,
	4,
	5
}
tt.hero.skills.thunderclap.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.thunderclap.xp_gain = {
	200,
	400,
	600
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, 53)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.magic_armor = 0.5
tt.hero.fn_level_up = scripts.hero_thor.level_up
tt.hero.tombstone_show_time = fts(150)
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.i18n_key = "HERO_THOR"
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0012") or "heroPortrait_portraits_0012"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0014") or "info_portraits_hero_0014"
tt.main_script.update = scripts.hero_thor.update
tt.motion.max_speed = FPS*2.7
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(0.5, 0.25)
tt.render.sprites[1].prefix = "hero_thor"
tt.soldier.melee_slot_offset = v(13, 0)
tt.sound_events.change_rally_point = "HeroThorTaunt"
tt.sound_events.death = "HeroThorDeath"
tt.sound_events.hero_room_select = "HeroThorTauntSelect"
tt.sound_events.insert = "HeroThorTauntIntro"
tt.sound_events.respawn = "HeroThorTauntIntro"
tt.unit.hit_offset = v(0, 22)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.melee.range = 55
tt.melee.cooldown = 1.5
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].xp_gain_factor = 3
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].animation = "chain"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[2].cooldown = fts(34) + 1.5
tt.melee.attacks[2].damage_type = DAMAGE_NO_DODGE
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(16)
tt.melee.attacks[2].shared_cooldown = true
tt.melee.attacks[2].sound = "HeroThorElectricAttack"
tt.melee.attacks[2].mod = "mod_hero_thor_chainlightning"
tt.melee.attacks[2].xp_from_skill = "chainlightning"
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "thunderclap"
tt.ranged.attacks[1].bullet = "hammer_hero_thor"
tt.ranged.attacks[1].bullet_start_offset = {
	v(25, 10)
}
tt.ranged.attacks[1].disabled = true
tt.ranged.attacks[1].cooldown = fts(28) + 12
tt.ranged.attacks[1].max_range = 250
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_time = fts(12)
tt.ranged.attacks[1].sound_shoot = "HeroThorHammer"
tt.ranged.attacks[1].xp_from_skill = "thunderclap"
tt = RT("hero_10yr", "hero")

AC(tt, "melee", "timed_attacks", "teleport")

anchor_y = 0.20161290322580644
anchor_x = 0.5
image_y = 116
image_x = 142
tt.hero.fixed_stat_attack = 8
tt.hero.fixed_stat_health = 8
tt.hero.fixed_stat_range = 0
tt.hero.fixed_stat_speed = 5
tt.hero.level_stats.armor = {
	0.2,
	0.2,
	0.2,
	0.3,
	0.3,
	0.3,
	0.4,
	0.4,
	0.5,
	0.6
}
tt.hero.level_stats.hp_max = {
	380,
	400,
	420,
	440,
	460,
	480,
	500,
	520,
	540,
	560
}
tt.hero.level_stats.regen_health_normal = {
	95,
	100,
	105,
	110,
	115,
	120,
	125,
	130,
	135,
	140
}
tt.hero.level_stats.regen_health_buffed = {
	95,
	100,
	105,
	110,
	115,
	120,
	125,
	130,
	135,
	140
}
tt.hero.level_stats.regen_health = tt.hero.level_stats.regen_health_normal
tt.hero.level_stats.melee_damage_max = {
	22,
	25,
	28,
	31,
	34,
	37,
	41,
	45,
	49,
	52
}
tt.hero.level_stats.melee_damage_min = {
	14,
	16,
	18,
	20,
	22,
	24,
	26,
	28,
	32,
	35
}
tt.hero.skills.rain = CC("hero_skill")
tt.hero.skills.rain.loops = {
	2,
	3,
	4
}
tt.hero.skills.rain.damage_min = {
	30,
	45,
	50
}
tt.hero.skills.rain.damage_max = {
	60,
	75,
	80
}
tt.hero.skills.rain.xp_level_steps = {
	nil,
	1,
	nil,
	nil,
	2,
	nil,
	nil,
	3
}
tt.hero.skills.rain.xp_gain = {
	100,
	200,
	300
}
tt.hero.skills.buffed = CC("hero_skill")
tt.hero.skills.buffed.bomb_steps = {
	3,
	4,
	6
}
tt.hero.skills.buffed.bomb_step_damage_min = {
	10,
	15,
	20
}
tt.hero.skills.buffed.bomb_step_damage_max = {
	20,
	30,
	40
}
tt.hero.skills.buffed.bomb_damage_min = {
	50,
	60,
	70
}
tt.hero.skills.buffed.bomb_damage_max = {
	70,
	80,
	90
}
tt.hero.skills.buffed.spin_damage_min = {
	18,
	23,
	27
}
tt.hero.skills.buffed.spin_damage_max = {
	36,
	45,
	54
}
tt.hero.skills.buffed.duration = {
	6,
	9,
	12
}
tt.hero.skills.buffed.xp_level_steps = {
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
}
tt.hero.skills.buffed.xp_gain = {
	100,
	150,
	200
}
tt.health.dead_lifetime = 15
tt.health_bar.offset = v(0, ady(60))
tt.health_bar.offset_buffed = v(0, ady(74))
tt.health_bar.offset_normal = tt.health_bar.offset
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_10yr.level_up
tt.hero.tombstone_show_time = fts(90)
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0013") or "heroPortrait_portraits_0013"
tt.info.fn = scripts.hero_10yr.get_info
tt.info.i18n_key = "HERO_10YR"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0015") or "info_portraits_hero_0015"
tt.main_script.update = scripts.hero_10yr.update
tt.motion.max_speed_normal = FPS*1.6
tt.motion.max_speed_buffed = FPS*2.2
tt.motion.max_speed = tt.motion.max_speed_normal
tt.particles_aura = "aura_10yr_idle"
tt.regen.cooldown = 1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "hero_10yr"
tt.soldier.melee_slot_offset = v(15, -1)
tt.sound_events.change_rally_point = "TenShiTaunt"
tt.sound_events.change_rally_point_normal = "TenShiTaunt"
tt.sound_events.change_rally_point_buffed = "TenShiTauntBuffed"
tt.sound_events.death = "TenShiDeathSfx"
tt.sound_events.death_args = {
	delay = fts(5)
}
tt.sound_events.hero_room_select = "TenShiTauntSelect"
tt.sound_events.insert = "TenShiTauntIntro"
tt.sound_events.respawn = "TenShiRespawn"
tt.teleport.min_distance = 50
tt.teleport.delay = 0
tt.teleport.sound = "TenShiTeleportSfx"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.unit.hit_offset = v(0, 20)
tt.melee.range_normal = 55
tt.melee.range_buffed = 65
tt.melee.range = tt.melee.range_normal
tt.melee.attacks[1].cooldown = 1.35
tt.melee.attacks[1].hit_time = fts(19)
tt.melee.attacks[1].sound = "TenShiAttack1"
tt.melee.attacks[1].hit_offset = v(20, 0)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].xp_gain_factor = 2.5
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[2].hit_time = fts(28)
tt.melee.attacks[2].hit_offset = v(20, 2)
tt.melee.attacks[2].sound = "TenShiAttack2"
tt.melee.attacks[3] = CC("area_attack")
tt.melee.attacks[3].animations = {
	"spin_start",
	"spin_loop",
	"spin_end"
}
tt.melee.attacks[3].cooldown = 2
tt.melee.attacks[3].loops = 2
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].damage_radius = 60
tt.melee.attacks[3].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[3].hit_times = {
	fts(2),
	fts(6)
}
tt.melee.attacks[3].sound = "TenShiBuffedSpinAttack"
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.attacks[3].xp_from_skill = "buffed"
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].animations = {
	"power_rain_start",
	"power_rain_loop",
	"power_rain_end"
}
tt.timed_attacks.list[1].cooldown = 25
tt.timed_attacks.list[1].entity = "aura_10yr_fireball"
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].sound_start = "TenShiRainOfFireStart"
tt.timed_attacks.list[1].sound_end = "TenShiRainOfFireEnd"
tt.timed_attacks.list[1].min_count = 1
tt.timed_attacks.list[1].trigger_range = 100
tt.timed_attacks.list[1].max_range = 150
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].vis_bans = bor(F_FRIEND)
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].cooldown = 10
tt.timed_attacks.list[2].min_count = 3
tt.timed_attacks.list[2].range = 100
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].duration = nil
tt.timed_attacks.list[2].transform_health_factor = 0.6
tt.timed_attacks.list[2].immune_to = bor(DAMAGE_BASE_TYPES, DAMAGE_MODIFIER)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[2].sounds_buffed = {
	"TenShiTransformToBuffed",
	"TenShiTransformToBuffedSfx"
}
tt.timed_attacks.list[2].sounds_normal = {
	"TenShiTransformToNormalSfx"
}
tt.timed_attacks.list[3] = CC("area_attack")
tt.timed_attacks.list[3].cooldown = 9
tt.timed_attacks.list[3].animation = "bomb"
tt.timed_attacks.list[3].count = 10
tt.timed_attacks.list[3].damage_max = nil
tt.timed_attacks.list[3].damage_min = nil
tt.timed_attacks.list[3].damage_radius = 40
tt.timed_attacks.list[3].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[3].hit_decal = "decal_ground_hit"
tt.timed_attacks.list[3].hit_fx = "fx_ground_hit"
tt.timed_attacks.list[3].hit_offset = v(0, 0)
tt.timed_attacks.list[3].hit_time = fts(28)
tt.timed_attacks.list[3].hit_aura = "aura_10yr_bomb"
tt.timed_attacks.list[3].min_count = 1
tt.timed_attacks.list[3].min_range = 80
tt.timed_attacks.list[3].max_range = 150
tt.timed_attacks.list[3].min_nodes = 5
tt.timed_attacks.list[3].max_nodes = 20
tt.timed_attacks.list[3].pop = {
	"pop_kapow",
	"pop_whaam"
}
tt.timed_attacks.list[3].pop_chance = 0.3
tt.timed_attacks.list[3].pop_conds = DR_KILL
tt.timed_attacks.list[3].sound_short = "TenShiBuffedBombAttack"
tt.timed_attacks.list[3].sound_long = "TenShiBuffedBombAttackLong"
tt.timed_attacks.list[3].sound = tt.timed_attacks.list[3].sound_short
tt.timed_attacks.list[3].xp_from_skill = "buffed"
tt = E.register_t(E, "aura_10yr_fireball", "aura")
tt.main_script.update = scripts.aura_10yr_fireball.update
tt.aura.entity = "fireball_10yr"
tt.aura.delay = fts(15)
tt.aura.loops = nil
tt.aura.min_range = E.get_template(E, "hero_10yr").timed_attacks.list[1].min_range
tt.aura.max_range = E.get_template(E, "hero_10yr").timed_attacks.list[1].max_range
tt.aura.vis_flags = E.get_template(E, "hero_10yr").timed_attacks.list[1].vis_flags
tt.aura.vis_bans = E.get_template(E, "hero_10yr").timed_attacks.list[1].vis_bans
tt = E.register_t(E, "fireball_10yr", "bullet")
tt.bullet.min_speed = FPS*24
tt.bullet.max_speed = FPS*24
tt.bullet.acceleration_factor = 0.05
tt.bullet.hit_fx = "fx_fireball_explosion"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_radius = 60
tt.bullet.damage_min = 30
tt.bullet.damage_max = 60
tt.bullet.damage_flags = F_AREA
tt.render.sprites[1].name = "fireball_proyectile"
tt.main_script.update = scripts.power_fireball.update
tt.scorch_earth = false
tt.sound_events.insert = "FireballRelease"
tt.sound_events.hit = "FireballHit"
tt = RT("aura_10yr_bomb", "aura")
tt.aura.fx = "decal_10yr_spike"
tt.aura.damage_radius = 40
tt.aura.last_attack_damage_radius = 60
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.vis_flags = bor(F_RANGED)
tt.aura.step_delay = fts(2)
tt.aura.step_nodes = 5
tt.aura.steps = 3
tt.main_script.update = scripts.aura_10yr_bomb.update
tt.stun = {
	vis_flags = bor(F_RANGED, F_STUN),
	vis_bans = bor(F_FLYING, F_BOSS),
	mod = "mod_10yr_stun"
}
tt.aura.damage_min = 10
tt.aura.damage_max = 20
tt.aura.stun_chance = 0.25
tt.aura.min_nodes = 0
tt.aura.max_nodes = 25
tt.aura.min_count = 1
tt = RT("mod_10yr_stun", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.modifier.duration = 3
tt = RT("decal_10yr_spike", "decal_bomb_crater")
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].name = "decal_10yr_bomb_spike"
tt.render.sprites[2].hide_after_runs = 1
tt.render.sprites[2].anchor.y = 0.24
tt = E.register_t(E, "enemy_rabbit", "enemy")
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0013") or "info_portraits_sc_0013"
tt.enemy.gold = 7
tt.health.hp_max = 100
tt.health_bar.offset = v(0, 20)
tt.main_script.insert = scripts2.enemy_basic.insert
tt.main_script.update = scripts2.enemy_passive.update
tt.motion.max_speed = FPS*0.9
tt.render.sprites[1].anchor = v(0.5, 0.21428571428571427)
tt.render.sprites[1].prefix = "rabbit"
tt.sound_events.death = "DeathEplosion"
tt.ui.click_rect = r(-10, -5, 20, 20)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 10)
tt.unit.size = UNIT_SIZE_SMALL
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_POLYMORPH)
tt = E.register_t(E, "enemy_rabbit2", "enemy_rabbit")
tt = RT("enemy_sheep_ground", "enemy")
anchor_y = 0.2
image_y = 38
tt.enemy.gold = 0
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 80
tt.health_bar.offset = v(0, ady(32))
tt.info.i18n_key = "ENEMY_SHEEP"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0013") or "info_portraits_sc_0013"
tt.info.enc_icon = nil
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_sheep.update
tt.motion.max_speed = FPS*1.5
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_sheep_ground"
tt.sound_events.insert = "Sheep"
tt.sound_events.death = "DeathEplosion"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 10)
tt.unit.mod_offset = v(0, ady(15))
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT, F_POLYMORPH, F_DRILL)
tt.vis.flags = bor(F_ENEMY)
tt.clicks_to_destroy = 8
tt = RT("enemy_sheep_fly", "enemy_sheep_ground")
anchor_y = 0.038461538461538464
image_y = 78
tt.enemy.gold = 80
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 389
tt.health_bar.offset = v(0, ady(68))
tt.motion.max_speed = FPS*2.08
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_sheep_fly"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.ui.click_rect.pos.y = 40
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, ady(56))
tt.unit.mod_offset = v(0, ady(48))
tt.unit.show_blood_pool = false
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = E.register_t(E, "enemy_bouncer", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.22
image_y = 36
tt.enemy.gold = 5
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = 40
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(38))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0006") or "info_portraits_sc_0006"
tt.info.enc_icon = 1
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.1520000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_desertthug"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(20))
tt = E.register_t(E, "enemy_tremor", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.42
image_y = 52
tt.enemy.gold = 10
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = 120
tt.health_bar.offset = v(0, ady(44))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 10
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_tremor.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 8
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.92
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_tremor"
tt.sound_events.death = "DeathEplosion"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -10, 40, 40)) or r(-15, -5, 30, 30)
tt.unit.hit_offset = v(0, 8)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(1, ady(30))
tt.vis.bans_above_surface = bor(F_SKELETON)
tt.vis.bans_below_surface = bor(F_RANGED, F_SKELETON, F_MOD, F_AREA, F_POLYMORPH)
tt.vis.bans = tt.vis.bans_below_surface
tt = E.register_t(E, "enemy_munra", "enemy")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks", "count_group")

anchor_y = 0.17
image_y = 44
tt.count_group.name = "enemy_munra"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.enemy.gold = 100
tt.enemy.melee_slot = v(19, 0)
tt.health.hp_max = 1000
tt.health_bar.offset = v(0, ady(39))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 6
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_munra.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(13)
tt.motion.max_speed = FPS*0.512
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet = "bolt_munra"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-9, ady(37))
}
tt.ranged.attacks[1].cooldown = 1.3
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 115.2
tt.ranged.attacks[1].min_range = 25.6
tt.ranged.attacks[1].shoot_time = fts(11)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_munra"
tt.sound_events.death = "DeathPuff"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animation = "summon"
tt.timed_attacks.list[1].cooldown = 8
tt.timed_attacks.list[1].entity = "munra_sarcophagus"
tt.timed_attacks.list[1].node_random_max = 40
tt.timed_attacks.list[1].node_random_min = 20
tt.timed_attacks.list[1].nodes_limit = 50
tt.timed_attacks.list[1].sound = "SandwraithCoffin"
tt.timed_attacks.list[1].spawn_time = fts(12)
tt.timed_attacks.list[1].count_group_name = "munra_sarcophagus"
tt.timed_attacks.list[1].count_group_type = COUNT_GROUP_CONCURRENT
tt.timed_attacks.list[1].count_group_max = 35
tt.timed_attacks.list[2] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[2].animation = "heal"
tt.timed_attacks.list[2].cooldown = 8
tt.timed_attacks.list[2].max_per_cast = 3
tt.timed_attacks.list[2].mod = "mod_shaman_heal"
tt.timed_attacks.list[2].range = 96
tt.timed_attacks.list[2].shoot_time = fts(13)
tt.timed_attacks.list[2].sound = "EnemyHealing"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 9)
tt.unit.marker_offset = v(0, ady(5))
tt.unit.mod_offset = v(0, ady(20))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = E.register_t(E, "bolt_munra", "bolt_enemy")

E.add_comps(E, tt, "endless")

tt.render.sprites[1].prefix = "bolt_munra"
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 40
tt.bullet.damage_min = 20
tt.bullet.max_speed = 390
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.hit_fx = "fx_bolt_munra_hit"
tt.bullet.max_track_distance = 50
tt.endless.factor_map = {
	{
		"enemy_munra.rangedDamage",
		"bullet.damage_min",
		true
	},
	{
		"enemy_munra.rangedDamage",
		"bullet.damage_max",
		true
	}
}
tt = E.register_t(E, "fx_bolt_munra_hit", "fx")
tt.render.sprites[1].name = "bolt_munra_hit"
tt = E.register_t(E, "munra_sarcophagus", "decal_scripted")

E.add_comps(E, tt, "render", "spawner")

tt.main_script.update = scripts3.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.25
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].prefix = "munra_sarcophagus"
tt.spawner.allowed_subpaths = {
	1,
	3
}
tt.spawner.animation_start = "start"
tt.spawner.animation_end = "end"
tt.spawner.count = 4
tt.spawner.cycle_time = fts(75)
tt.spawner.entity = "enemy_fallen"
tt.spawner.forced_waypoint_offset = v(-25, 1)
tt.spawner.node_offset = 5
tt.spawner.pos_offset = v(0, 1)
tt.spawner.random_subpath = false
tt = E.register_t(E, "enemy_executioner", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.19
image_y = 90
tt.enemy.gold = 130
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(29, 0)
tt.health.dead_lifetime = 3
tt.health.hp_max = 2000
tt.health_bar.offset = v(0, ady(87))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 5
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].dodge_time = fts(11)
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].instakill = true
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.attacks[1].vis_bans = F_HERO
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].instakill = nil
tt.melee.attacks[2].vis_bans = 0
tt.melee.cooldown = 1.5
tt.motion.max_speed = FPS*0.768
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_executioner"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect = r(-25, -5, 50, 65)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 25)
tt.unit.pop_offset = v(0, 20)
tt.unit.marker_offset = v(0, ady(16))
tt.unit.mod_offset = v(0, ady(39))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = E.register_t(E, "enemy_desert_archer", "enemy")

E.add_comps(E, tt, "melee", "ranged")

anchor_y = 0.2
image_y = 36
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 4
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(20))
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.health.hp_max = 180
tt.health.armor = 0
tt.health.magic_armor = 0.3
tt.health_bar.offset = v(0, ady(39))
tt.render.sprites[1].prefix = "enemy_desertarcher"
tt.render.sprites[1].anchor.y = anchor_y
tt.motion.max_speed = FPS*1.536
tt.enemy.gold = 12
tt.enemy.melee_slot = v(18, 0)
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].damage_max = 20
tt.ranged.attacks[1].bullet = "arrow_shadow_archer"
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].shoot_time = fts(5)
tt.ranged.attacks[1].cooldown = fts(12) + 1
tt.ranged.attacks[1].max_range = 147.20000000000002
tt.ranged.attacks[1].min_range = 25.6
tt.ranged.attacks[1].animation = "rangedAttack"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 12)
}
tt = E.register_t(E, "enemy_scorpion", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.16
image_y = 50
tt.enemy.gold = 28
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(38, 0)
tt.health.armor = 0.85
tt.health.hp_max = 500
tt.health_bar.offset = v(0, ady(48))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 11
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 28
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "poison"
tt.melee.attacks[2].cooldown = 10
tt.melee.attacks[2].damage_max = nil
tt.melee.attacks[2].damage_min = nil
tt.melee.attacks[2].hit_time = fts(20)
tt.melee.attacks[2].mod = "mod_poison"
tt.melee.attacks[2].vis_flags = bor(F_POISON)
tt.motion.max_speed = FPS*1.024
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_scorpion"
tt.sound_events.death = "DeathEplosion"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-25, -5, 50, 50)) or r(-20, -5, 40, 25)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(20))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_SKELETON)
tt = E.register_t(E, "enemy_immortal", "enemy")

E.add_comps(E, tt, "melee", "death_spawns")

anchor_y = 0.2
image_y = 50
tt.death_spawns.name = "enemy_fallen"
tt.death_spawns.concurrent_with_death = true
tt.enemy.gold = 24
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0.6
tt.health.hp_max = 360
tt.health_bar.offset = v(0, ady(51))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 3
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 28
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].hit_time = fts(22)
tt.motion.max_speed = FPS*1.024
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_immortal"
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = r(-20, -5, 40, 50)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(28))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt = E.register_t(E, "enemy_fallen", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.17
image_y = 40
tt.enemy.gold = 0
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.dead_lifetime = 3
tt.health.hp_max = 120
tt.health_bar.offset = v(0, ady(42))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 7
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.remove = scripts3.enemy_basic.remove
tt.main_script.update = scripts3.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 28
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].hit_time = fts(20)
tt.motion.max_speed = FPS*0.8959999999999999
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "enemy_fallen"
tt.sound_events.death = "DeathSkeleton"
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))
tt.unit.show_blood_pool = false
tt.unit.blood_color = BLOOD_GRAY
tt.vis.bans = bor(F_SKELETON, F_POLYMORPH)
tt = E.register_t(E, "enemy_desert_raider", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.21
image_y = 38
tt.enemy.gold = 16
tt.enemy.melee_slot = v(21, 0)
tt.health.armor = 0.3
tt.health.hp_max = 200
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(39))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.info.enc_icon = 2
tt.main_script.insert = scripts3.enemy_basic.insert
tt.main_script.update = scripts3.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1.2
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.28
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_desertraider"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(9))
tt.unit.mod_offset = v(0, ady(21))
tt = RT("enemy_goblin", "enemy")

AC(tt, "melee")

image_y = 32
image_x = 46
anchor_y = 0.2
anchor_x = 0.5
tt.enemy.gold = 3
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 20
tt.health_bar.offset = v(0, 25)
tt.info.i18n_key = "ENEMY_GOBLIN"
tt.info.enc_icon = 1
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0006") or "info_portraits_sc_0006"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*1.2
tt.render.sprites[1].anchor = v(0.5, anchor_y)
tt.render.sprites[1].prefix = "goblin"
tt.sound_events.death = "DeathGoblin"
tt.unit.hit_offset = v(0, 8)
tt.unit.mod_offset = v(adx(22), ady(15))
tt = RT("enemy_fat_orc", "enemy")

AC(tt, "melee")

anchor_y = 0.19
anchor_x = 0.5
image_y = 42
image_x = 58
tt.enemy.gold = 9
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0.3
tt.health.hp_max = 80
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_FAT_ORC"
tt.info.enc_icon = 2
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0007") or "info_portraits_sc_0007"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 8
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(6)
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].anchor = v(0.5, 0.19)
tt.render.sprites[1].prefix = "enemy_fat_orc"
tt.sound_events.death = "DeathOrc"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(30), ady(20))
tt = RT("enemy_wolf_small", "enemy")

AC(tt, "dodge", "melee")

anchor_y = 0.21
anchor_x = 0.5
image_y = 28
image_x = 38
tt.dodge.chance = 0.3
tt.dodge.silent = true
tt.enemy.gold = 5
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 35
tt.health_bar.offset = v(0, 25)
tt.info.i18n_key = "ENEMY_WULF"
tt.info.enc_icon = 13
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0012") or "info_portraits_sc_0012"
tt.melee.attacks[1].cooldown = fts(14) + 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "WolfAttack"
tt.motion.max_speed = FPS*2.5
tt.render.sprites[1].anchor = v(0.5, 0.21)
tt.render.sprites[1].prefix = "enemy_wolf_small"
tt.sound_events.death = "DeathPuff"
tt.sound_events.death_by_explosion = "DeathPuff"
tt.unit.can_explode = false
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 11)
tt.unit.mod_offset = v(adx(22), ady(14))
tt.vis.bans = bor(F_SKELETON)
tt = RT("enemy_wolf", "enemy")

AC(tt, "dodge", "melee")

anchor_y = 0.26
anchor_x = 0.5
image_y = 50
image_x = 60
tt.dodge.chance = 0.5
tt.dodge.silent = true
tt.enemy.gold = 12
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = 120
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, 35)
tt.info.i18n_key = "ENEMY_WORG"
tt.info.enc_icon = 14
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0020") or "info_portraits_sc_0020"
tt.melee.attacks[1].cooldown = fts(14) + 1
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "WolfAttack"
tt.motion.max_speed = FPS*2
tt.render.sprites[1].anchor = v(0.5, 0.26)
tt.render.sprites[1].prefix = "enemy_wolf"
tt.sound_events.death = "DeathPuff"
tt.sound_events.death_by_explosion = "DeathPuff"
tt.unit.can_explode = false
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 13)
tt.unit.marker_offset.y = 2
tt.unit.mod_offset = v(adx(29), ady(26))
tt.vis.bans = bor(F_SKELETON)
tt = RT("enemy_shadow_archer", "enemy")

AC(tt, "melee", "ranged")

anchor_y = 0.2
anchor_x = 0.5
image_y = 36
image_x = 54
tt.enemy.gold = 16
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 180
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, 31)
tt.info.i18n_key = "ENEMY_SHADOW_ARCHER"
tt.info.enc_icon = 11
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0025") or "info_portraits_sc_0025"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(4)
tt.motion.max_speed = FPS*1.2
tt.ranged.attacks[1].bullet = "arrow_shadow_archer"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 12.5)
}
tt.ranged.attacks[1].cooldown = fts(12) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 145
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].prefix = "enemy_shadow_archer"
tt.sound_events.death = "DeathHuman"
tt.unit.hit_offset = v(0, 15)
tt.unit.mod_offset = v(adx(26), ady(20))
tt.unit.marker_offset.y = 1
tt = RT("enemy_shaman", "enemy")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.2
anchor_x = 0.5
image_y = 60
image_x = 60
tt.enemy.gold = 10
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 100
tt.health.magic_armor = 0.85
tt.health_bar.offset = v(0, 33)
tt.info.i18n_key = "ENEMY_SHAMAN"
tt.info.enc_icon = 3
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0009") or "info_portraits_sc_0009"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_shaman.update
tt.melee.attacks[1].cooldown = fts(18) + 1
tt.melee.attacks[1].damage_max = 5
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*1
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].prefix = "enemy_shaman"
tt.sound_events.death = "DeathGoblin"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "heal"
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].cooldown = 8
tt.timed_attacks.list[1].max_count = 3
tt.timed_attacks.list[1].max_range = 95
tt.timed_attacks.list[1].mod = "mod_shaman_heal"
tt.timed_attacks.list[1].sound = "EnemyHealing"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_cursed_shaman", "enemy")

AC(tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.2
anchor_x = 0.5
image_y = 60
image_x = 60
tt.enemy.gold = 100
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 1000
tt.health.magic_armor = 0.85
tt.health_bar.offset = v(0, 33)
tt.info.i18n_key = "ENEMY_CURSED_SHAMAN"
tt.info.enc_icon = 3
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0009") or "info_portraits_sc_0009"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_shaman.update
tt.melee.attacks[1].cooldown = fts(18) + 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 25
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*0.5
tt.ranged.attacks[1].bullet = "bolt_cursed_shaman"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 23)
}
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(7)
tt.ranged.attacks[1].cooldown = fts(50)
tt.ranged.attacks[1].hold_advance = true
tt.render.sprites[1].anchor = v(0.5, 0.2)
tt.render.sprites[1].prefix = "enemy_cursed_shaman"
tt.sound_events.death = "DeathGoblin"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "heal"
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].cooldown = 4
tt.timed_attacks.list[1].max_count = 3
tt.timed_attacks.list[1].max_range = 200
tt.timed_attacks.list[1].mod = "mod_cursed_shaman_heal"
tt.timed_attacks.list[1].sound = "EnemyHealing"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_gargoyle", "enemy")
anchor_y = 0
anchor_x = 0.5
image_y = 88
image_x = 58
tt.enemy.gold = 12
tt.health.hp_max = 90
tt.health.armor = 0
tt.health_bar.offset = v(adx(29), ady(69))
tt.info.i18n_key = "ENEMY_GARGOYLE"
tt.info.enc_icon = 10
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0010") or "info_portraits_sc_0010"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*1.2
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_gargoyle"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = r(-14, 34, 28, 30)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hit_offset = v(0, 52)
tt.unit.hide_after_death = true
tt.unit.mod_offset = v(adx(31), ady(50))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = RT("enemy_ogre", "enemy")

AC(tt, "melee")

anchor_y = 0.2
anchor_x = 0.5
image_y = 80
image_x = 86
tt.enemy.gold = 50
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = 800
tt.health_bar.offset = v(0, 53)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_OGRE"
tt.info.enc_icon = 4
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0011") or "info_portraits_sc_0011"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].hit_time = fts(16)
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_ogre"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(34, 45)
tt.ui.click_rect.pos.x = -17
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(adx(42), ady(33))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("enemy_spider_tiny", "enemy")

AC(tt, "melee")

anchor_y = 0.25
anchor_x = 0.5
image_y = 24
image_x = 30
tt.enemy.gold = 1
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = 10
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, 16)
tt.info.i18n_key = "ENEMY_SPIDERTINY"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0023") or "info_portraits_sc_0023"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 5
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*2
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spider_tiny"
tt.sound_events.death = "DeathEplosionShortA"
tt.unit.blood_color = BLOOD_GREEN
tt.unit.explode_fx = "fx_spider_explode"
tt.unit.hit_offset = v(0, 8)
tt.unit.marker_offset = v(0, ady(5))
tt.unit.mod_offset = v(adx(18), ady(13))
tt.vis.bans = bor(F_POISON, F_SKELETON)
tt = RT("enemy_spider_small", "enemy")

AC(tt, "melee")

anchor_y = 0.25
anchor_x = 0.5
image_y = 28
image_x = 36
tt.enemy.gold = 6
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = 75
tt.health.magic_armor = 0.65
tt.health_bar.offset = v(0, 22)
tt.info.i18n_key = "ENEMY_SPIDERSMALL"
tt.info.enc_icon = 8
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0022") or "info_portraits_sc_0022"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*1.5
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spider_small"
tt.sound_events.death = "DeathEplosion"
tt.unit.blood_color = BLOOD_GREEN
tt.unit.explode_fx = "fx_spider_explode"
tt.unit.hit_offset = v(0, 8)
tt.unit.marker_offset = v(0, -1)
tt.unit.mod_offset = v(adx(20), ady(15))
tt.vis.bans = bor(F_POISON, F_SKELETON)
tt = RT("enemy_spider_big", "enemy")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.25
anchor_x = 0.5
image_y = 40
image_x = 56
tt.enemy.gold = 20
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = 250
tt.health.magic_armor = 0.8
tt.health_bar.offset = v(0, 32)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_SPIDER"
tt.info.enc_icon = 9
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0021") or "info_portraits_sc_0021"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_spider_big.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spider"
tt.sound_events.death = "DeathEplosion"
tt.timed_attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[1].bullet = "enemy_spider_egg"
tt.timed_attacks.list[1].max_cooldown = 10
tt.timed_attacks.list[1].max_count = 3
tt.timed_attacks.list[1].min_cooldown = 5
tt.ui.click_rect = r(-20, -5, 40, 30)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.explode_fx = "fx_spider_explode"
tt.unit.hit_offset = v(0, 8)
tt.unit.marker_offset = v(-0.4, -2.2)
tt.unit.mod_offset = v(adx(26), ady(18))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POISON, F_SKELETON)
tt = RT("enemy_brigand", "enemy")

AC(tt, "melee")

anchor_y = 0.2
anchor_x = 0.5
image_y = 38
image_x = 50
tt.enemy.gold = 15
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0.5
tt.health.hp_max = 160
tt.health_bar.offset = v(0, 31)
tt.info.i18n_key = "ENEMY_BRIGAND"
tt.info.enc_icon = 6
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0018") or "info_portraits_sc_0018"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_brigand"
tt.sound_events.death = "DeathHuman"
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(24), ady(19))
tt = RT("enemy_dark_knight", "enemy")

AC(tt, "melee")

anchor_y = 0.2
anchor_x = 0.5
image_y = 46
image_x = 64
tt.enemy.gold = 25
tt.enemy.melee_slot = v(24, 0)
tt.health.armor = 0.9
tt.health.hp_max = 300
tt.health_bar.offset = v(0, 35)
tt.info.i18n_key = "ENEMY_DARK_KNIGHT"
tt.info.enc_icon = 12
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0024") or "info_portraits_sc_0024"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(7)
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_dark_knight"
tt.sound_events.death = "DeathHuman"
tt.unit.hit_offset = v(0, 16)
tt.unit.mod_offset = v(adx(32), ady(20))
tt.unit.marker_offset.y = -2
tt = RT("enemy_marauder", "enemy")

AC(tt, "melee")

anchor_y = 0.22
anchor_x = 0.5
image_y = 56
image_x = 78
tt.enemy.gold = 40
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(24, 0)
tt.health.armor = 0.50
tt.health.hp_max = 600
tt.health_bar.offset = v(0, 48)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_MARAUDER"
tt.info.enc_icon = 7
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0019") or "info_portraits_sc_0019"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(10)
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_marauder"
tt.sound_events.death = "DeathHuman"
tt.ui.click_rect = r(-20, -5, 40, 40)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(adx(39), ady(24))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("soldier_marauder", "soldier_militia")

AC(tt, "melee")

anchor_y = 0.22
anchor_x = 0.5
image_y = 56
image_x = 78
tt.soldier.melee_slot_offest = v(24, 0)
tt.health.armor = 0.6
tt.health.hp_max = 600
tt.health_bar.offset = v(0, 48)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "ENEMY_MARAUDER"
tt.info.enc_icon = 7
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0019") or "info_portraits_sc_0019"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 24
tt.melee.attacks[1].damage_min = 16
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.range = 75
tt.motion.max_speed = 45
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_marauder"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathHuman"
tt.ui.click_rect = r(-20, -5, 40, 40)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(adx(39), ady(24))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.price = 100
tt = RT("enemy_bandit", "enemy")

AC(tt, "melee", "dodge")

anchor_y = 0.2
anchor_x = 0.5
image_y = 34
image_x = 48
tt.dodge.chance = 0.5
tt.dodge.silent = true
tt.enemy.gold = 8
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 70
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_BANDIT"
tt.info.enc_icon = 5
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0008") or "info_portraits_sc_0008"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(4)
tt.motion.max_speed = FPS*1.2
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_bandit"
tt.sound_events.death = "DeathHuman"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 2)
tt.unit.mod_offset = v(adx(24), ady(17))
tt = RT("soldier_bandit", "soldier_militia")

AC(tt, "melee", "dodge")

anchor_y = 0.2
anchor_x = 0.5
image_y = 34
image_x = 48
tt.dodge.chance = 0.5
tt.dodge.silent = true
tt.soldier.melee_slot_offest = v(18, 0)
tt.health.hp_max = 70
tt.health_bar.offset = v(0, 30)
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "ENEMY_BANDIT"
tt.info.enc_icon = 5
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0008") or "info_portraits_sc_0008"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.range = 65
tt.motion.max_speed = 65
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_bandit"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathHuman"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 2)
tt.unit.mod_offset = v(adx(24), ady(17))
tt.unit.price = 25
tt = RT("enemy_slayer", "enemy")

AC(tt, "melee")

anchor_y = 0.22
anchor_x = 0.5
image_y = 66
image_x = 74
tt.enemy.gold = 100
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(24, 0)
tt.health.armor = 0.95
tt.health.hp_max = 1200
tt.health_bar.offset = v(0, 50)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_SLAYER"
tt.info.enc_icon = 22
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0046") or "info_portraits_sc_0046"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 76
tt.melee.attacks[1].damage_min = 24
tt.melee.attacks[1].hit_time = fts(7)
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_slayer"
tt.sound_events.death = "DeathHuman"
tt.ui.click_rect.size = v(32, 42)
tt.ui.click_rect.pos.x = -16
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(adx(37), ady(25))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("enemy_rocketeer", "enemy")
anchor_y = 0
anchor_x = 0.5
image_y = 88
image_x = 80
tt.enemy.gold = 30
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 340
tt.health.on_damage = scripts.enemy_rocketeer.on_damage
tt.health_bar.offset = v(0, 78)
tt.info.i18n_key = "ENEMY_ROCKETEER"
tt.info.enc_icon = 21
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0045") or "info_portraits_sc_0045"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*1.2
tt.render.sprites[1].anchor = v(0.5, 0)
tt.render.sprites[1].prefix = "enemy_rocketeer"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "BombExplosionSound"
tt.ui.click_rect = r(-14, 40, 28, 34)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 58)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(40), ady(56))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN, F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_troll", "enemy")

AC(tt, "melee", "auras")

anchor_y = 0.22727272727272727
anchor_x = 0.5
image_y = 44
image_x = 60
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_troll_regen"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 25
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 280
tt.info.i18n_key = "ENEMY_TROLL"
tt.info.enc_icon = 17
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0029") or "info_portraits_sc_0029"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(7)
tt.motion.max_speed = FPS*0.9
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll"
tt.sound_events.death = "DeathTroll"
tt.unit.hit_offset = v(0, 13)
tt.unit.mod_offset = v(adx(28), ady(23))
tt = RT("soldier_troll", "soldier_militia")

AC(tt, "melee", "auras")

anchor_y = 0.22727272727272727
anchor_x = 0.5
image_y = 44
image_x = 60
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_troll_regen"
tt.auras.list[1].cooldown = 0
tt.soldier.melee_slot_offset = v(18, 0)
tt.health.hp_max = 280
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "ENEMY_TROLL"
tt.info.enc_icon = 17
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0029") or "info_portraits_sc_0029"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.range = 65
tt.motion.max_speed = 65
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.regen.cooldown = fts(6)
tt.regen.health = 1
tt.sound_events.death = "DeathTroll"
tt.unit.hit_offset = v(0, 13)
tt.unit.mod_offset = v(adx(28), ady(23))
tt.unit.price = 65
tt = RT("enemy_whitewolf", "enemy")

AC(tt, "melee", "dodge")

anchor_y = 0.3275862068965517
anchor_x = 0.5
image_y = 58
image_x = 64
tt.dodge.chance = 0.5
tt.dodge.silent = true
tt.enemy.gold = 35
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = 350
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, 39)
tt.info.i18n_key = "ENEMY_WHITE_WOLF"
tt.info.enc_icon = 16
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0032") or "info_portraits_sc_0032"
tt.melee.attacks[1].cooldown = fts(14) + 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "WolfAttack"
tt.motion.max_speed = FPS*2
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_whitewolf"
tt.sound_events.death = "DeathPuff"
tt.sound_events.death_by_explosion = "DeathPuff"
tt.ui.click_rect.size.x = 32
tt.ui.click_rect.pos.x = -16
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 13)
tt.unit.mod_offset = v(adx(32), ady(32))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt = RT("enemy_yeti", "enemy")

AC(tt, "melee")

anchor_y = 0.19
anchor_x = 0.5
image_y = 80
image_x = 100
tt.enemy.gold = 120
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = 2000
tt.health_bar.offset = v(0, 56)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_YETI"
tt.info.enc_icon = 20
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0033") or "info_portraits_sc_0033"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 150
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(13)
tt.melee.attacks[1].sound = "AreaAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(13)
}
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_yeti"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(50, 50)
tt.ui.click_rect.pos.x = -25
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 24)
tt.unit.mod_offset = v(adx(47), ady(35))
tt.unit.size = UNIT_SIZE_LARGE
tt = RT("enemy_forest_troll", "enemy")

AC(tt, "melee", "auras")

anchor_y = 0.21
anchor_x = 0.5
image_y = 100
image_x = 156
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_forest_troll_regen"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 200
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(35, 0)
tt.health.hp_max = 4000
tt.health_bar.offset = v(0, 76)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_FOREST_TROLL"
tt.info.enc_icon = 39
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0062") or "info_portraits_sc_0060"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 150
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound = "AreaAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(15)
}
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_forest_troll"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(58, 55)
tt.ui.click_rect.pos = v(-30, 3)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(1, 2)
tt.unit.mod_offset = v(adx(78), ady(45))
tt.unit.size = UNIT_SIZE_LARGE
tt = RT("enemy_orc_armored", "enemy")

AC(tt, "melee")

anchor_y = 0.14
anchor_x = 0.5
image_y = 48
image_x = 70
tt.enemy.gold = 30
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0.85
tt.health.hp_max = 400
tt.health_bar.offset = v(0, 36)
tt.info.i18n_key = "ENEMY_ORC_ARMORED"
tt.info.enc_icon = 36
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0060") or "info_portraits_sc_0059"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(6)
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_orc_armored"
tt.sound_events.death = "DeathOrc"
tt.ui.click_rect.size.y = 28
tt.ui.click_rect.pos.y = 3
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset.y = 2
tt.unit.mod_offset = v(adx(34), ady(21))
tt = RT("soldier_orc_armored", "soldier_militia")

AC(tt, "melee")

anchor_y = 0.14
anchor_x = 0.5
image_y = 48
image_x = 70
tt.soldier.melee_slot_offset = v(18, 0)
tt.health.armor = 0.8
tt.health.hp_max = 400
tt.health_bar.offset = v(0, 36)
tt.info.i18n_key = "ENEMY_ORC_ARMORED"
tt.info.enc_icon = 36
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0060") or "info_portraits_sc_0059"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.range = 75
tt.motion.max_speed = 55
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_orc_armored"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathOrc"
tt.ui.click_rect.size.y = 28
tt.ui.click_rect.pos.y = 3
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset.y = 2
tt.unit.mod_offset = v(adx(34), ady(21))
tt.unit.price = 100
tt = RT("enemy_orc_rider", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.14
anchor_x = 0.5
image_y = 62
image_x = 62
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "enemy_orc_armored"
tt.enemy.gold = 25
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(30, 0)
tt.health.hp_max = 400
tt.health.magic_armor = 0.8
tt.health_bar.offset = v(0, 48)
tt.info.i18n_key = "ENEMY_ORC_RIDER"
tt.info.enc_icon = 37
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0060") or "info_portraits_sc_0059"
tt.melee.attacks[1].cooldown = fts(14) + 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "WolfAttack"
tt.motion.max_speed = FPS*1.4
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_orc_rider"
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect.size = v(32, 38)
tt.ui.click_rect.pos = v(-16, 2)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 23)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(31), ady(29))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt = RT("soldier_orc_rider", "soldier_militia")

AC(tt, "melee", "auras")

anchor_y = 0.14
anchor_x = 0.5
image_y = 62
image_x = 62
tt.soldier.melee_slot_offset = v(30, 0)
tt.health.hp_max = 400
tt.health.magic_armor = 0.8
tt.health_bar.offset = v(0, 48)
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_soldier_death_spawns_2"
tt.info.i18n_key = "ENEMY_ORC_RIDER"
tt.info.enc_icon = 37
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0060") or "info_portraits_sc_0059"
tt.melee.attacks[1].cooldown = fts(14) + 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "WolfAttack"
tt.melee.range = 75
tt.motion.max_speed = 75
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_orc_rider"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect.size = v(32, 38)
tt.ui.click_rect.pos = v(-16, 2)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 23)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(31), ady(29))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt.unit.price = 165
tt = RT("enemy_troll_axe_thrower", "enemy")

AC(tt, "melee", "ranged", "auras")

anchor_y = 0.2
anchor_x = 0.5
image_y = 50
image_x = 60
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_troll_axe_thrower_regen"
tt.enemy.gold = 50
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 600
tt.health_bar.offset = v(0, 43)
tt.info.i18n_key = "ENEMY_TROLL_AXE_THROWER"
tt.info.enc_icon = 18
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0030") or "info_portraits_sc_0030"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = FPS*0.8
tt.ranged.attacks[1].bullet = "axe_troll_axe_thrower"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 15)
}
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 145
tt.ranged.attacks[1].min_range = 55
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll_axe_thrower"
tt.sound_events.death = "DeathTroll"
tt.ui.click_rect.size = v(30, 40)
tt.ui.click_rect.pos.x = -15
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(29), ady(21))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("soldier_troll_axe_thrower", "soldier_militia")

AC(tt, "melee", "ranged", "auras")

anchor_y = 0.2
anchor_x = 0.5
image_y = 50
image_x = 60
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_troll_axe_thrower_regen"
tt.soldier.melee_slot_offset = v(18, 0)
tt.health.hp_max = 600
tt.health_bar.offset = v(0, 43)
tt.info.i18n_key = "ENEMY_TROLL_AXE_THROWER"
tt.info.enc_icon = 18
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0030") or "info_portraits_sc_0030"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.range = 65
tt.motion.max_speed = 68
tt.ranged.attacks[1].bullet = "axe_troll_axe_thrower"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 15)
}
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 145
tt.ranged.attacks[1].min_range = 55
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll_axe_thrower"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	},
	ranged = {
	"shoot"
	}
}
tt.regen.cooldown = fts(6)
tt.regen.health = 2
tt.sound_events.death = "DeathTroll"
tt.ui.click_rect.size = v(30, 40)
tt.ui.click_rect.pos.x = -15
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(29), ady(21))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.price = 125
tt = RT("enemy_raider", "enemy")

AC(tt, "melee", "ranged")

anchor_y = 0.23
anchor_x = 0.5
image_y = 68
image_x = 88
tt.enemy.gold = 50
tt.enemy.lives_cost = 1
tt.enemy.melee_slot = v(23, 0)
tt.health.armor = 0.95
tt.health.hp_max = 1000
tt.health_bar.offset = v(0, 49)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_RAIDER"
tt.info.enc_icon = 46
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0070") or "info_portraits_sc_0070"
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].damage_max = 80
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].hit_time = fts(6)
tt.ranged.attacks[1].bullet = "ball_raider"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 24)
}
tt.ranged.attacks[1].cooldown = fts(15) + 1.5
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 55
tt.ranged.attacks[1].shoot_time = fts(15)
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_raider"
tt.sound_events.death = "DeathHuman"
tt.ui.click_rect.size = v(32, 44)
tt.ui.click_rect.pos.x = -16
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(43), ady(34))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("soldier_raider", "soldier_militia")

AC(tt, "melee", "ranged")

anchor_y = 0.23
anchor_x = 0.5
image_y = 68
image_x = 88
tt.soldier.melee_slot_offset = v(23, 0)
tt.health.armor = 0.95
tt.health.hp_max = 1000
tt.health_bar.offset = v(0, 49)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_RAIDER"
tt.info.enc_icon = 46
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0070") or "info_portraits_sc_0070"
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].damage_max = 80
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.range = 85
tt.ranged.attacks[1].bullet = "ball_raider"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 24)
}
tt.ranged.attacks[1].cooldown = fts(15) + 1.5
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 55
tt.ranged.attacks[1].shoot_time = fts(15)
tt.motion.max_speed = 35
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_raider"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	},
	ranged = {
		"shoot"
	}
}
tt.sound_events.death = "DeathHuman"
tt.ui.click_rect.size = v(32, 44)
tt.ui.click_rect.pos.x = -16
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(43), ady(34))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.price = 150
tt = RT("enemy_pillager", "enemy")

AC(tt, "melee")

anchor_y = 0.23
anchor_x = 0.5
image_y = 118
image_x = 154
tt.enemy.gold = 100
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(33, 0)
tt.health.hp_max = 2800
tt.health.magic_armor = 0.9
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 61)
tt.info.i18n_key = "ENEMY_PILLAGER"
tt.info.enc_icon = 47
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0071") or "info_portraits_sc_0071"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_pillager"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(44, 58)
tt.ui.click_rect.pos.x = -22
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(75), ady(47))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("soldier_pillager", "soldier_militia")

AC(tt, "melee")

anchor_y = 0.23
anchor_x = 0.5
image_y = 118
image_x = 154
tt.soldier.melee_slot_offest = v(33, 0)
tt.health.hp_max = 2800
tt.health.magic_armor = 0.9
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 61)
tt.info.i18n_key = "ENEMY_PILLAGER"
tt.info.enc_icon = 47
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0071") or "info_portraits_sc_0071"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.range = 95
tt.motion.max_speed = 70
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_pillager"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(44, 58)
tt.ui.click_rect.pos.x = -22
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(75), ady(47))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.price = 350
tt = RT("soldier_pillager2", "soldier_pillager")

AC(tt, "melee", "auras")

tt.health.hp_max = 1
tt.melee.attacks[1].damage_max = 2
tt.melee.attacks[1].damage_min = 1
tt = RT("enemy_troll_brute", "enemy")

AC(tt, "melee", "auras")

anchor_y = 0.2125
anchor_x = 0.5
image_y = 80
image_x = 104
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_troll_brute_regen"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 150
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(35, 0)
tt.health.armor = 0.6
tt.health.hp_max = 2800
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 54)
tt.info.i18n_key = "ENEMY_TROLL_BRUTE"
tt.info.enc_icon = 51
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0074") or "info_portraits_sc_0074"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 3
tt.melee.attacks[1].damage_max = 165
tt.melee.attacks[1].damage_min = 95
tt.melee.attacks[1].damage_radius = 44.800000000000004
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll_brute"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(30, 40)
tt.ui.click_rect.pos.x = -15
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("soldier_troll_brute", "soldier_militia")

AC(tt, "melee", "auras")

anchor_y = 0.2125
anchor_x = 0.5
image_y = 80
image_x = 104
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_troll_brute_regen"
tt.auras.list[1].cooldown = 0
tt.soldier.melee_slot_offset = v(35, 0)
tt.health.armor = 0.6
tt.health.hp_max = 2800
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 54)
tt.info.i18n_key = "ENEMY_TROLL_BRUTE"
tt.info.enc_icon = 51
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0074") or "info_portraits_sc_0074"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 3
tt.melee.attacks[1].damage_max = 165
tt.melee.attacks[1].damage_min = 95
tt.melee.attacks[1].damage_radius = 44.800000000000004
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.range = 85
tt.motion.max_speed = 75
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll_brute"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.regen.cooldown = fts(4)
tt.regen.health = 4
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(30, 40)
tt.ui.click_rect.pos.x = -15
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.price = 500
tt = RT("enemy_troll_chieftain", "enemy")

AC(tt, "melee", "auras", "timed_attacks")

anchor_y = 0.2
anchor_x = 0.5
image_y = 58
image_x = 78
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_troll_chieftain_regen"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 70
tt.enemy.lives_cost = 6
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 1200
tt.health_bar.offset = v(0, 46)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_TROLL_CHIEFTAIN"
tt.info.enc_icon = 19
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0031") or "info_portraits_sc_0031"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_troll_chieftain.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(16)
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "special"
tt.timed_attacks.list[1].cooldown = 6
tt.timed_attacks.list[1].cast_sound = "EnemyChieftain"
tt.timed_attacks.list[1].cast_time = fts(8)
tt.timed_attacks.list[1].loops = 3
tt.timed_attacks.list[1].max_count = 3
tt.timed_attacks.list[1].max_range = 180
tt.timed_attacks.list[1].mods = {
	"mod_troll_rage",
	"mod_troll_heal"
}
tt.timed_attacks.list[1].exclude_with_mods = {
	"mod_troll_rage"
}
tt.timed_attacks.list[1].allowed_templates = {
	"enemy_troll",
	"enemy_troll_axe_thrower",
	"enemy_troll_skater"
}
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll_chieftain"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(32, 40)
tt.ui.click_rect.pos.x = -16
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(adx(37), ady(18))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_golem_head", "enemy")

AC(tt, "melee")

anchor_y = 0.20588235294117646
anchor_x = 0.5
image_y = 34
image_x = 40
tt.enemy.gold = 10
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = 125
tt.health_bar.offset = v(0, 23)
tt.info.i18n_key = "ENEMY_GOLEM_HEAD"
tt.info.enc_icon = 15
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0028") or "info_portraits_sc_0028"
tt.melee.attacks[1].cooldown = fts(20) + 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_golem_head"
tt.sound_events.death = "DeathPuff"
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 8)
tt.unit.mod_offset = v(adx(22), ady(15))
tt.unit.show_blood_pool = false
tt = RT("enemy_goblin_zapper", "enemy")

AC(tt, "melee", "ranged", "death_spawns")

anchor_y = 0.22
anchor_x = 0.5
image_y = 58
image_x = 52
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_goblin_zapper_death"
tt.death_spawns.delay = 0.11
tt.enemy.gold = 10
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 140
tt.health_bar.offset = v(0, 34)
tt.info.i18n_key = "ENEMY_GOBLIN_ZAPPER"
tt.info.enc_icon = 38
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0061") or "info_portraits_sc_0061"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(8)
tt.motion.max_speed = FPS*1.2
tt.ranged.attacks[1].bullet = "bomb_goblin_zapper"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 12.5)
}
tt.ranged.attacks[1].cooldown = fts(12) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 60
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_goblin_zapper"
tt.sound_events.death = "BombExplosionSound"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 13)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(26), ady(22))
tt.unit.show_blood_pool = false
tt = RT("soldier_goblin_zapper", "soldier_militia")

AC(tt, "melee", "ranged", "death_spawns", "auras")

anchor_y = 0.22
anchor_x = 0.5
image_y = 58
image_x = 52
tt.soldier.melee_slot_offset = v(18, 0)
tt.health.hp_max = 140
tt.health_bar.offset = v(0, 34)
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_soldier_death_spawns2_3"
tt.info.i18n_key = "ENEMY_GOBLIN_ZAPPER"
tt.info.enc_icon = 38
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0061") or "info_portraits_sc_0061"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.range = 65
tt.motion.max_speed = 70
tt.ranged.attacks[1].bullet = "bomb_goblin_zapper2"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 12.5)
}
tt.ranged.attacks[1].cooldown = fts(12) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 60
tt.ranged.attacks[1].shoot_time = fts(7)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_goblin_zapper"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	},
	ranged = {
		"shoot"
	}
}
tt.sound_events.death = "BombExplosionSound"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 13)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(26), ady(22))
tt.unit.show_blood_pool = false
tt.unit.price = 75
tt = RT("enemy_demon", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.2
anchor_x = 0.5
image_y = 38
image_x = 44
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_demon_death"
tt.death_spawns.delay = 0.11
tt.enemy.gold = 20
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = {
	200,
	250,
	300
}
tt.health.magic_armor = 0.6
tt.health_bar.offset = v(0, 29)
tt.info.i18n_key = "ENEMY_DEMON"
tt.info.enc_icon = 23
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0048") or "info_portraits_sc_0048"
tt.main_script.insert = scripts.enemy_base_portal.insert
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(7)
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_demon"
tt.sound_events.death = "DeathPuff"
tt.unit.blood_color = BLOOD_RED
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(22), ady(19))
tt.unit.show_blood_pool = false
tt = RT("enemy_demon_mage", "enemy")

AC(tt, "melee", "death_spawns", "timed_attacks")

anchor_y = 0.15
anchor_x = 0.5
image_y = 56
image_x = 58
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_demon_mage_death"
tt.death_spawns.delay = 0.11
tt.enemy.gold = 60
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = 1000
tt.health.magic_armor = 0.6
tt.health_bar.offset = v(0, 43)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_DEMON_MAGE"
tt.info.enc_icon = 24
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0049") or "info_portraits_sc_0049"
tt.main_script.insert = scripts.enemy_base_portal.insert
tt.main_script.update = scripts.enemy_demon_mage.update
tt.melee.attacks[1].cooldown = fts(20) + 1
tt.melee.attacks[1].damage_max = 75
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_demon_mage"
tt.sound_events.death = "DeathPuff"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "special"
tt.timed_attacks.list[1].cast_time = fts(15)
tt.timed_attacks.list[1].cooldown = 6
tt.timed_attacks.list[1].max_count = 4
tt.timed_attacks.list[1].max_range = 180
tt.timed_attacks.list[1].mod = "mod_demon_shield"
tt.timed_attacks.list[1].sound = "EnemyHealing"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[1].allowed_templates = {
	"enemy_demon",
	"enemy_demon_cerberus",
	"enemy_demon_flareon",
	"enemy_demon_gulaemon",
	"enemy_demon_legion",
	"enemy_demon_wolf",
	"enemy_rotten_lesser"
}
tt.ui.click_rect.size = v(32, 40)
tt.ui.click_rect.pos.x = -16
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_demon_wolf", "enemy")

AC(tt, "melee", "death_spawns", "dodge")

anchor_y = 0.15
anchor_x = 0.5
image_y = 40
image_x = 58
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_demon_wolf_death"
tt.death_spawns.delay = 0.11
tt.dodge.chance = 0.5
tt.dodge.silent = true
tt.enemy.gold = 25
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = 350
tt.health.magic_armor = 0.6
tt.health_bar.offset = v(0, 31)
tt.info.i18n_key = "ENEMY_DEMON_WOLF"
tt.info.enc_icon = 25
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0050") or "info_portraits_sc_0050"
tt.main_script.insert = scripts.enemy_base_portal.insert
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "WolfAttack"
tt.motion.max_speed = FPS*1.5
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_demon_wolf"
tt.sound_events.death = "DeathPuff"
tt.sound_events.death_by_explosion = "DeathPuff"
tt.ui.click_rect.size.x = 32
tt.ui.click_rect.pos = v(-16, 0.5)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 13)
tt.unit.mod_offset = v(adx(30), ady(20))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt = RT("enemy_demon_imp", "enemy")
anchor_y = 0
anchor_x = 0.5
image_y = 96
image_x = 78
tt.enemy.gold = 25
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 350
tt.health_bar.offset = v(0, 72)
tt.info.i18n_key = "ENEMY_DEMON_IMP"
tt.info.enc_icon = 26
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0051") or "info_portraits_sc_0051"
tt.main_script.insert = scripts.enemy_base_portal.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_demon_imp"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = r(-14, 35, 30, 32)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 58)
tt.unit.mod_offset = v(adx(38), ady(50))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = RT("enemy_lava_elemental", "enemy")

AC(tt, "melee")

anchor_y = 0.19
anchor_x = 0.5
image_y = 84
image_x = 108
tt.enemy.gold = 100
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(25, 0)
tt.health.hp_max = 2500
tt.health.armor = 0
tt.health_bar.offset = v(0, 62)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0055") or "info_portraits_sc_0055"
tt.info.i18n_key = "ENEMY_LAVA_ELEMENTAL"
tt.info.enc_icon = 30
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 150
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.motion.max_speed = FPS*0.5
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_lava_elemental"
tt.sound_events.death = "RockElementalDeath"
tt.ui.click_rect.size = v(50, 56)
tt.ui.click_rect.pos.x = -25
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 24)
tt.unit.mod_offset = v(adx(53), ady(38))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_POISON)
tt = RT("enemy_sarelgaz_small", "enemy")

AC(tt, "melee")

anchor_y = 0.19
anchor_x = 0.5
image_y = 68
image_x = 96
tt.enemy.gold = 80
tt.enemy.melee_slot = v(35, 0)
tt.health.armor = 0.8
tt.health.hp_max = 1250
tt.health.magic_armor = 0.8
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 51)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0058") or "info_portraits_sc_0058"
tt.info.i18n_key = "ENEMY_SARELGAZ_SMALL"
tt.info.enc_icon = 31
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.attacks[1].sound = "SpiderAttack"
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].anchor = v(0.5, 0.19)
tt.render.sprites[1].prefix = "enemy_sarelgaz_small"
tt.sound_events.death = "DeathEplosion"
tt.ui.click_rect.size = v(54, 50)
tt.ui.click_rect.pos.x = -27
tt.unit.blood_color = BLOOD_GREEN
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 23)
tt.unit.mod_offset = v(adx(45), ady(35))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POISON)
tt = RT("enemy_rotten_lesser", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.21621621621621623
anchor_x = 0.5
image_y = 74
image_x = 90
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_rotten_lesser_death"
tt.enemy.gold = 20
tt.enemy.melee_slot = v(26, 0)
tt.health.hp_max = 500
tt.info.i18n_key = "ENEMY_ROTTEN_LESSER"
tt.info.enc_icon = 58
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0081") or "info_portraits_sc_0081"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*1
tt.render.sprites[1].anchor = v(0.5, 0.21621621621621623)
tt.render.sprites[1].prefix = "enemy_rotten_lesser"
tt.sound_events.death = "EnemyMushroomDeath"
tt.ui.click_rect = r(-15, -5, 30, 30)
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.show_blood_pool = false
tt = RT("enemy_swamp_thing", "enemy")

AC(tt, "melee", "ranged", "auras")

anchor_y = 0.24
anchor_x = 0.5
image_y = 87
image_x = 108
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_swamp_thing_regen"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 200
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(40, 0)
tt.health.hp_max = 3000
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 69)
tt.info.i18n_key = "ENEMY_SWAMP_THING"
tt.info.enc_icon = 44
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0068") or "info_portraits_sc_0068"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].damage_radius = 50
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.motion.max_speed = FPS*0.6
tt.ranged.attacks[1].bullet = "bomb_swamp_thing"
tt.ranged.attacks[1].bullet_start_offset = {
	v(adx(66), ady(86))
}
tt.ranged.attacks[1].cooldown = fts(32) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 165
tt.ranged.attacks[1].min_range = 110
tt.ranged.attacks[1].shoot_time = fts(13)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_swamp_thing"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect.size = v(50, 54)
tt.ui.click_rect.pos.x = -25
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 30)
tt.unit.mod_offset = v(0, 24)
tt.unit.size = UNIT_SIZE_LARGE
tt = RT("enemy_spider_rotten", "enemy")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.20967741935483872
anchor_x = 0.5
image_y = 62
image_x = 82
tt.enemy.gold = 40
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(34, 0)
tt.health.hp_max = 1000
tt.health.magic_armor = 0.6
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 47)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0065") or "info_portraits_sc_0065"
tt.info.i18n_key = "ENEMY_SPIDER_ROTTEN"
tt.info.enc_icon = 42
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_spider_big.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spider_rotten"
tt.sound_events.death = "DeathEplosion"
tt.timed_attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[1].bullet = "enemy_spider_rotten_egg"
tt.timed_attacks.list[1].max_cooldown = 10
tt.timed_attacks.list[1].max_count = 6
tt.timed_attacks.list[1].min_cooldown = 5
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.explode_fx = "fx_spider_explode"
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(40), ady(28))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_POISON)
tt = RT("enemy_spider_rotten_tiny", "enemy")

AC(tt, "melee")

anchor_y = 0.1875
anchor_x = 0.5
image_y = 32
image_x = 42
tt.enemy.gold = 0
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = 80
tt.health.magic_armor = 0.3
tt.health_bar.offset = v(0, 20)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0066") or "info_portraits_sc_0066"
tt.info.i18n_key = "ENEMY_SPIDERTINY_ROTTEN"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*1.2
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spider_rotten_tiny"
tt.sound_events.death = "DeathEplosionShortA"
tt.unit.blood_color = BLOOD_GREEN
tt.unit.explode_fx = "fx_spider_explode"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(5))
tt.unit.mod_offset = v(adx(1), ady(14))
tt.unit.mod_offset = v(adx(18), ady(13))
tt.vis.bans = bor(F_POISON, F_SKELETON)
tt = RT("enemy_rotten_tree", "enemy")

AC(tt, "melee")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.enemy.gold = 60
tt.enemy.melee_slot = v(25, 0)
tt.health.armor = 0.8
tt.health.hp_max = 1000
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_ROTTEN_TREE"
tt.info.enc_icon = 43
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0067"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(11)
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_rotten_tree"
tt.sound_events.death = "DeathSkeleton"
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt = RT("soldier_rotten_tree", "soldier_militia")

AC(tt, "melee")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.health.armor = 0.8
tt.health.hp_max = 1000
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_ROTTEN_TREE"
tt.info.enc_icon = 43
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0067"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.range = 135
tt.regen.cooldown = 1
tt.regen.health = 100
tt.motion.max_speed = FPS*1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_rotten_tree"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis_bans = bor(F_SKELETON)
tt = E.register_t(E, "soldier_bloodsucker", "soldier_militia")

E.add_comps(E, tt, "melee", "auras")

image_y = 52
anchor_y = 0.17
tt.health.dead_lifetime = 2
tt.health.hp_max = 175
tt.health.armor = 0.25
tt.health_bar.offset = v(0, 25.16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_soldier_death_spawns"
tt.auras.list[1].cooldown = 0
tt.idle_flip.chance = 0.6
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = "info_portraits_sc_0114"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.i18n_key = "BLOODSUCKER"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 109
tt.melee.attacks[1].damage_min = 51
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].mod = "mod_bloodsucker_damage_extra"
tt.melee.attacks[1].damage_type = bor(DAMAGE_TRUE, DAMAGE_NO_DODGE)
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.1
tt.melee.attacks[2].hit_time = fts(28)
tt.melee.attacks[2].damage_max = 1000
tt.melee.attacks[2].damage_min = 1000
tt.melee.attacks[2].mod = "mod_enemy_weak"
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[3].chance = 0.05
tt.melee.attacks[3].damage_max = 9e+99
tt.melee.attacks[3].damage_min = 9e+99
tt.melee.attacks[3].vis_flags = F_INSTAKILL
tt.melee.range = 85
tt.motion.max_speed = 100
tt.regen.cooldown = 1
tt.regen.health = 20
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia999"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))
tt.unit.price = 185
tt = RT("soldier_bloodsucker2", "soldier_militia")

AC(tt, "reinforcement", "melee")

image_y = 60
image_x = 72
anchor_y = 0.1
tt.health.magic_armor = 0.6
tt.health.hp_max = 75
tt.health_bar.offset = v(0, 46)
tt.health.immune_to = DAMAGE_ALL_TYPES
tt.health.dead_lifetime = fts(30)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_sc_0021"
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.i18n_key = "MONSTER"
tt.info.random_name_format = nil
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.remove = scripts.soldier_reinforcement.remove
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 200
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].mod = "mod_bloodsucker_lifesteal"
tt.melee.attacks[1].damage_type = bor(DAMAGE_TRUE, DAMAGE_NO_DODGE)
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.15
tt.melee.attacks[2].hit_time = fts(28)
tt.melee.attacks[2].damage_max = 3000
tt.melee.attacks[2].damage_min = 3000
tt.melee.attacks[2].mod = "mod_bloodsucker_lifesteal2"
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[3].chance = 0.1
tt.melee.attacks[3].damage_max = 9e+99
tt.melee.attacks[3].damage_min = 9e+99
tt.melee.attacks[3].vis_flags = F_INSTAKILL
tt.melee.range = 225
tt.motion.max_speed = 175
tt.reinforcement.duration = 10
tt.reinforcement.fade = nil
tt.regen.cooldown = 1
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].alpha = 180
tt.render.sprites[1].prefix = "soldiermilitia999"
tt.render.sprites[1].alpha = 180
tt.ui.click_rect = r(-13, 0, 26, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.unit.price = 0
tt.vis.bans = bor(F_LYCAN, F_SKELETON, F_CANNIBALIZE)
tt = E.register_t(E, "mod_bloodsucker", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].name = "mod_troll_rage"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.main_script.insert = scripts2.mod_gnoll_boss.insert
tt.main_script.remove = scripts2.mod_gnoll_boss.remove
tt.main_script.update = scripts2.mod_track_target.update
tt.modifier.duration = 5
tt.modifier.use_mod_offset = true
tt.extra_health_factor = 0.5
tt.inflicted_damage_factor = 2
tt = E.register_t(E, "soldier_Gelf", "soldier_militia")

E.add_comps(E, tt, "melee", "ranged", "nav_grid", "auras")

image_y = 52
anchor_y = 0.17
tt.health.dead_lifetime = 3
tt.health.armor = 0.15
tt.health.spiked_armor = 0.75
tt.health.hp_max = 125
tt.health_bar.offset = v(0, 25.16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "gelf_maxdamage"
tt.auras.list[1].cooldown = 0
tt.idle_flip.chance = 0.08
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = "info_portraits_sc_0117"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.i18n_key = "GELF"
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "arrow_gelf"
tt.ranged.attacks[1].bullet_start_offset = {
  v(5, 25)
}
tt.ranged.attacks[1].cooldown = 0.5
tt.ranged.attacks[1].max_range = 525
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_time = fts(8)
tt.ranged.attacks[1].vis_bans = 0
tt.ranged.attacks[1].vis_flags = bor(F_RANGED)
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].bullet = "arrow_gelf2"
tt.ranged.attacks[2].chance = 0.2
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.melee.range = 60
tt.motion.max_speed = 80
tt.regen.cooldown = 1
tt.regen.health = 15
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia777"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))
tt.unit.price = 170
tt = RT("arrow_gelf", "arrow")
tt.bullet.damage_min = 30
tt.bullet.damage_max = 60
tt.bullet.mod = {
"mod_gelf"
}
tt.bullet.g = -3/(fts(1)*fts(1))
tt.render.sprites[1].scale = v(3, 1.5)
tt.bullet.hit_distance = 60
tt = RT("arrow_gelf2", "arrow2")
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.mod = "mod_enemy_weak2"
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.bullet.pop_chance = 1
tt.bullet.g = -3/(fts(1)*fts(1))
tt.bullet.hit_distance = 9e+99
tt.bullet.damage_type = DAMAGE_TRUE
tt.render.sprites[1].scale = v(3, 1.5)
tt = RT("mod_gelf", "mod_poison")
tt.modifier.duration = 9e+99
tt.dps.damage_max = 12
tt.dps.damage_min = 10
tt.dps.damage_every = 0.5
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)
tt.modifier.vis_flags = 0
tt = RT("mod_blue", "mod_poison")
tt.modifier.duration = 1
tt.dps.damage_max = 2
tt.dps.damage_min = 2
tt.dps.damage_every = 0.1
tt.render.sprites[1].prefix = "dracolich_disease"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.5555,
	tint_color = {
		0.2,
		0.1,
		1.8,
		1.8,
	}
}
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)
tt.modifier.vis_flags = 0
tt = E.register_t(E, "Soldier_FlareBomber", "soldier_militia")

E.add_comps(E, tt, "melee", "ranged", "nav_grid", "auras")

image_y = 52
anchor_y = 0.26
tt.health.dead_lifetime = 3
tt.health.armor = 0.65
tt.health.spiked_armor = 0.5
tt.health.hp_max = 325
tt.health_bar.offset = v(0, 25.16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_soldier_death_spawns2_2"
tt.auras.list[1].cooldown = 0
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = "info_portraits_sc_0120"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.i18n_key = "FLAREBOMBER"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].count = 6
tt.melee.attacks[1].mod = "mod_FlareBomber_stun"
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 80
tt.melee.attacks[1].damage_radius = 62.5
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.melee.attacks[1].shared_cooldown = true
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "shoot"
tt.ranged.attacks[1].bullet = "bomb_FlareBomber"
tt.ranged.attacks[1].bullet_start_offset = {
  v(5, 25)
}
tt.ranged.attacks[1].cooldown = 3
tt.ranged.attacks[1].max_range = 325
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_time = fts(28)
tt.ranged.attacks[1].vis_bans = (F_FLYING)
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.melee.range = 60
tt.motion.max_speed = 55
tt.regen.cooldown = 1
tt.regen.health = 15
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia888"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))
tt.unit.price = 250
tt = RT("mod_FlareBomber", "mod_lava")
tt.dps.damage_min = 10
tt.dps.damage_max = 10
tt.dps.damage_every = 1
tt.modifier.duration = 9e+99
tt.modifier.vis_bans = 0
tt = RT("bomb_FlareBomber", "bomb")
tt.bullet.damage_max = 135
tt.bullet.damage_min = 50
tt.bullet.mod = "mod_FlareBomber"
tt.bullet.damage_radius = 99.5
tt.bullet.flight_time = fts(35)
tt.bullet.hit_fx = "fx_explosion_big"
tt.render.sprites[1].name = "Bomb_FlareBomber_0001"
tt.sound_events.hit_water = nil
tt.bullet.g = -2/(fts(1)*fts(1))
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.sound_events.insert = "FlareBomberAttack"
tt.sound_events.hit = "PotbelliedDemonHit"
tt = RT("mod_FlareBomber_stun", "mod_stun")
tt.modifier.duration = 1
tt = E.register_t(E, "Soldier_ArchImage", "soldier_militia")

E.add_comps(E, tt, "melee", "ranged", "nav_grid", "auras")

image_y = 52
anchor_y = 0.26
tt.auras.list[1] = E:clone_c("aura_attack")
tt.auras.list[1].name = "aura_spawn_soldiers2"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E.clone_c(E, "aura_attack")
tt.auras.list[2].cooldown = 0
tt.auras.list[2].name = "aura_soldier_death_spawns2_4"
tt.auras.list[3] = E.clone_c(E, "aura_attack")
tt.auras.list[3].cooldown = 0
tt.auras.list[3].name = "aura_soldier_death_spawns2_5"
tt.auras.list[4] = E.clone_c(E, "aura_attack")
tt.auras.list[4].name = "aura_soldier_levelup"
tt.auras.list[4].cooldown = 0
tt.health.dead_lifetime = 3
tt.health.magic_armor = 0.95
tt.health.armor = 0.55
tt.health.hp_max = 175
tt.health_bar.offset = v(0, 25.16)
tt.health_bar.type = HEALTH_BAR_SIZE_SMALL
tt.idle_flip.chance = 0.01
tt.idle_flip.cooldown = 1
tt.info.fn = mylua.Soldier_ArchImage.get_info
tt.info.portrait = "info_portraits_sc_0118"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.i18n_key = "ARCHIMAGE"
tt.melee.attacks[1].cooldown = 1.8
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(25)
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].bullet = "ray_ArchImage"
tt.ranged.attacks[1].bullet_start_offset = {
v(0, 75)
}
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 350
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].node_prediction = fts(11)
tt.ranged.attacks[1].shoot_time = fts(28)
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.melee.range = 55
tt.motion.max_speed = 50
tt.regen.cooldown = 1
tt.regen.health = 15
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[1].prefix = "soldiermilitia444"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.soldier.melee_slot_offset = v(5, 0)
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-10, -2, 20, 25)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(21))
tt.unit.price = 280
tt = RT("soldier_ent", "soldier_militia")

AC(tt, "melee")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.health.armor = 0.85
tt.health.hp_max = 2500
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 9e+99
tt.info.i18n_key = "ENT"
tt.info.random_name_count = 1
tt.info.random_name_format = "SOLDIER_ENT_RANDOM_%i_NAME"
tt.info.enc_icon = 43
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0067"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 9e+99
tt.melee.attacks[1].damage_max = 200
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].damage_radius = 78.5
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound_hit = "EntAttackSound"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.range = 135
tt.regen.cooldown = 1
tt.regen.health = 20
tt.motion.max_speed = 55
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "soldiermilitia666"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis_bans = bor(F_SKELETON)
tt = RT("Soldier_BioLizard", "soldier_militia")

AC(tt, "melee", "nav_path")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.health.armor = 0.5
tt.health.hp_max = 800
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 1
tt.main_script.update = mylua.walk_soldier.update
tt.nav_path.dir = -1
tt.info.i18n_key = "BIO"
tt.info.random_name_count = nil
tt.info.random_name_format = nil
tt.info.enc_icon = 43
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0121"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].count = 8
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].damage_radius = 72.5
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(20)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.range = 135
tt.regen.cooldown = 1
tt.regen.health = 20
tt.motion.max_speed = 95
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "SoldierBioLizard"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.unit.price = 80
tt.vis_bans = bor(F_SKELETON)
tt = RT("Soldier_PotbelliedDemon", "soldier_militia")

AC(tt, "melee")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.health.hp_max = 1000
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 9e+99
tt.info.i18n_key = "ENT"
tt.info.random_name_count = 1
tt.info.random_name_format = "SOLDIER_DEMON_RANDOM_%i_NAME"
tt.info.enc_icon = 43
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0116"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1.5
tt.melee.attacks[1].count = 9e+99
tt.melee.attacks[1].damage_max = 800
tt.melee.attacks[1].damage_min = 500
tt.melee.attacks[1].damage_radius = 99.5
tt.melee.attacks[1].mod = "mod_PotbelliedDemon"
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(35, 0)
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound_hit = "PotbelliedDemonHit"
tt.melee.attacks[1].sound = "PotbelliedDemonSound"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.range = 85
tt.regen.cooldown = 1
tt.regen.health = 100
tt.motion.max_speed = 85
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "soldiermilitia333"
tt.render.sprites[1].scale = v(1.2, 1.2)
tt.sound_events.death = "DemonBigDeath"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis_bans = bor(F_SKELETON)
tt.unit.price = 600
tt = RT("mod_PotbelliedDemon", "mod_lava")
tt.dps.damage_min = 10
tt.dps.damage_max = 10
tt.dps.damage_every = 0.2
tt.modifier.duration = 9e+99
tt.modifier.vis_bans = 0
tt = RT("Soldier_WarHammer", "soldier_militia")

AC(tt, "melee", "timed_actions", "auras")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.health.armor = 0.85
tt.health.hp_max = 400
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 3
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_soldier_death_spawns2"
tt.auras.list[1].cooldown = 0
tt.auras.list[2] = E.clone_c(E, "aura_attack")
tt.auras.list[2].name = "aura_warhammer_rage"
tt.auras.list[2].cooldown = 0
tt.auras.list[3] = E.clone_c(E, "aura_attack")
tt.auras.list[3].name = "aura_warhammer_rage2"
tt.auras.list[3].cooldown = 0
tt.info.i18n_key = "ENT"
tt.info.random_name_count = 1
tt.info.random_name_format = "SOLDIER_HAMMER_RANDOM_%i_NAME"
tt.info.enc_icon = 43
tt.idle_flip.chance = 0
tt.idle_flip.cooldown = 9e+99
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0115"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2.2
tt.melee.attacks[1].count = 9e+99
tt.melee.attacks[1].damage_max = 80
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].damage_radius = 72.5
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound_hit = "EntAttackSound"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].mod = "mod_WarHammer_slow"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].chance = 0.25
tt.melee.attacks[2].mod = "mod_WarHammer_stun"
tt.melee.attacks[2].damage_max = 200
tt.melee.attacks[2].damage_min = 100
tt.melee.attacks[2].damage_radius = 108.5
tt.melee.range = 85
tt.timed_actions.list[1] = CC("mod_attack")
tt.timed_actions.list[1].animation = "healing"
tt.timed_actions.list[1].cast_time = fts(17)
tt.timed_actions.list[1].cooldown = 20
tt.timed_actions.list[1].fn_can = function (t, s, a)
	return t.health.hp < a.min_health_factor*t.health.hp_max
end
tt.timed_actions.list[1].min_health_factor = 0.2
tt.timed_actions.list[1].mod = "mod_healing_WarHammer"
tt.timed_actions.list[1].sound = "HealingSound"
tt.timed_actions.list[1].level = 1
tt.regen.cooldown = 1
tt.regen.health = 40
tt.motion.max_speed = 50
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "soldiermilitia111"
tt.render.sprites[1].scale = v(1.5, 1.5)
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(15, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis_bans = bor(F_SKELETON)
tt.unit.price = 200
tt = RT("mod_WarHammer_stun", "mod_stun")
tt.modifier.duration = 3
tt = RT("mod_FlareBomber_stun_death", "mod_stun")
tt.modifier.duration = 6
tt = RT("mod_ArchImage_stun", "mod_stun")
tt.modifier.duration = 3
tt.render.sprites[1].prefix = "mod_tesla_hit"
tt = RT("mod_WarHammer_slow", "mod_slow")
tt.modifier.duration = 0.5
tt.slow.factor = 0.4
tt = E.register_t(E, "aura_warhammer_rage", "aura")
tt.main_script.update = scripts2.aura_razorboar_rage.update
tt.main_script.insert = scripts2.aura_razorboar_rage.insert
tt.main_script.remove = scripts2.aura_razorboar_rage.remove
tt.damage_hp_factor = 1
tt.aura.track_source = true
tt = RT("soldier_rotten_tree2", "soldier_militia")

AC(tt, "melee")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.health.armor = 0.8
tt.health.hp_max = 3000
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_ROTTEN_TREE"
tt.info.enc_icon = 43
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0067"
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].damage_max = 150
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.range = 185
tt.regen.cooldown = 1
tt.regen.health = 333
tt.motion.max_speed = FPS*1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_rotten_tree2"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis_bans = bor(F_SKELETON)
tt = RT("soldier_zombie", "soldier_militia")

AC(tt, "melee", "nav_path")

anchor_y = 0.18421052631578946
anchor_x = 0.5
image_y = 76
image_x = 82
tt.health.armor = 0
tt.health.hp_max = 150
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_ROTTEN_TREE"
tt.info.enc_icon = 43
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_sc_0067"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 4
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.range = 75
tt.regen.cooldown = 1
tt.regen.health = 0
tt.motion.max_speed = FPS*1
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_halloween_zombie"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.sound_events.death = "DeathSkeleton"
tt.soldier.melee_slot_offset = v(25, 0)
tt.ui.click_rect.size = v(44, 40)
tt.ui.click_rect.pos = v(-22, -1)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.unit.show_blood_pool = false
tt.vis_bans = bor(F_SKELETON)
tt = RT("enemy_giant_rat", "enemy")

AC(tt, "melee")

anchor_y = 0.275
anchor_x = 0.5
image_y = 40
image_x = 64
tt.enemy.gold = 10
tt.enemy.melee_slot = v(26, 0)
tt.health.hp_max = 100
tt.health_bar.offset = v(0, 26)
tt.info.i18n_key = "ENEMY_GIANT_RAT"
tt.info.enc_icon = 61
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0084") or "info_portraits_sc_0084"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 12
tt.melee.attacks[1].damage_min = 8
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.attacks[1].mod = "mod_poison_giant_rat"
tt.melee.attacks[1].sound_hit = "EnemyBlackburnGiantRat"
tt.melee.attacks[1].sound_hit_args = {
	chance = 0.1
}
tt.motion.max_speed = FPS*1.3950892857142858
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_giant_rat"
tt.sound_events.death = nil
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt = RT("enemy_giant_rat2", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.275
anchor_x = 0.5
image_y = 40
image_x = 64
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "soldier_sand_warrior2"
tt.enemy.gold = 0
tt.enemy.melee_slot = v(26, 0)
tt.health.hp_max = 1
tt.health_bar.offset = v(0, 26)
tt.info.i18n_key = "ENEMY_GIANT_RAT"
tt.info.enc_icon = 61
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0084") or "info_portraits_sc_0084"
tt.melee.attacks[1].cooldown = 9e+99
tt.melee.attacks[1].damage_max = 0
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].hit_time = fts(11)
tt.motion.max_speed = 2
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_giant_rat666"
tt.sound_events.death = nil
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt = E.register_t(E, "soldier_sand_warrior2", "unit")

E.add_comps(E, tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events")

anchor_y = 0.2
image_y = 36
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0012") or "info_portraits_heroes_0012"
tt.health.armor = 0
tt.health.hp_inc = 40
tt.health.hp_max = 360
tt.health_bar.offset = v(0, ady(39))
tt.info.fn = scripts3.soldier_sand_warrior.get_info
tt.info.i18n_key = "HERO_ALRIC_SANDWARRIORS"
tt.lifespan.duration = 9e+99
tt.main_script.insert = scripts3.soldier_sand_warrior.insert
tt.main_script.update = scripts3.soldier_sand_warrior.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 15
tt.melee.attacks[1].damage_min = 5
tt.melee.attacks[1].hit_time = fts(4)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.range = 72
tt.motion.max_speed = 60
tt.nav_path.dir = -1
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "soldier_sand_warrior2"
tt.soldier.melee_slot_offset.x = 5
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_LYCAN)
tt.vis.flags = F_FRIEND
tt = RT("enemy_wererat", "enemy")

AC(tt, "melee")

anchor_y = 0.17647058823529413
anchor_x = 0.5
image_y = 68
image_x = 94
tt.enemy.gold = 25
tt.enemy.melee_slot = v(26, 0)
tt.health.armor = 0.3
tt.health.hp_max = 450
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 47)
tt.info.i18n_key = "ENEMY_WERERAT"
tt.info.enc_icon = 62
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0085") or "info_portraits_sc_0085"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 35
tt.melee.attacks[1].damage_min = 25
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].mod = "mod_wererat_poison"
tt.motion.max_speed = FPS*1.6622340425531914
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_wererat"
tt.sound_events.death = nil
tt.ui.click_rect.size = v(32, 40)
tt.ui.click_rect.pos = v(-16, -1)
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 2)
tt.unit.mod_offset = v(0, 22)
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("enemy_skeleton", "enemy")

AC(tt, "melee")

anchor_y = 0.2
anchor_x = 0.5
image_y = 38
image_x = 50
tt.enemy.gold = 2
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 120
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_SKELETON"
tt.info.enc_icon = 27
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0052") or "info_portraits_sc_0052"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_skeleton"
tt.sound_events.death = "DeathSkeleton"
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(adx(25), ady(17))
tt.vis.bans = bor(F_POISON, F_POLYMORPH, F_DRILL)
tt.unit.show_blood_pool = false
tt = RT("enemy_skeleton_big", "enemy")

AC(tt, "melee")

anchor_y = 0.2
anchor_x = 0.5
image_y = 50
image_x = 58
tt.enemy.gold = 10
tt.enemy.melee_slot = v(23, 0)
tt.health.armor = 0.3
tt.health.hp_max = 400
tt.health_bar.offset = v(0, 39)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0053") or "info_portraits_sc_0053"
tt.info.i18n_key = "ENEMY_SKELETON_BIG"
tt.info.enc_icon = 28
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_skeleton_big"
tt.sound_events.death = "DeathSkeleton"
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.mod_offset = v(adx(30), ady(22))
tt.vis.bans = bor(F_POISON, F_POLYMORPH, F_DRILL)
tt.unit.show_blood_pool = false
tt = RT("enemy_zombie", "enemy")

AC(tt, "melee")

anchor_y = 0.22
anchor_x = 0.5
image_y = 48
image_x = 42
tt.enemy.gold = 10
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0.4
tt.health.hp_max = 250
tt.health_bar.offset = v(0, 35)
tt.info.i18n_key = "ENEMY_ZOMBIE"
tt.info.enc_icon = 41
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0064") or "info_portraits_sc_0064"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 15
tt.melee.attacks[1].damage_min = 5
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*0.5
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_zombie"
tt.render.sprites[1].name = "raise"
tt.sound_events.death = "DeathSkeleton"
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(adx(23), ady(20))
tt.vis.bans = bor(F_SKELETON, F_POISON, F_POLYMORPH, F_DRILL)
tt.unit.show_blood_pool = false
tt = RT("enemy_demon_flareon", "enemy")

AC(tt, "melee", "ranged", "death_spawns")

anchor_y = 0.16666666666666666
anchor_x = 0.5
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_flareon_death"
tt.enemy.gold = 20
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 250
tt.health.magic_armor = 0.8
tt.health_bar.offset.y = 34
tt.info.i18n_key = "ENEMY_DEMON_FLAREON"
tt.info.enc_icon = 54
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0076") or "info_portraits_sc_0076"
tt.main_script.insert = scripts.enemy_base_portal.insert
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*1.2
tt.ranged.attacks[1].bullet = "flare_flareon"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 25)
}
tt.ranged.attacks[1].cooldown = fts(36) + 3
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].shoot_time = fts(9)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_demon_flareon"
tt.render.sprites[1].offset.y = 1
tt.sound_events.death = "DeathPuff"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 12)
tt.unit.show_blood_pool = false
tt = RT("enemy_demon_legion", "enemy")

AC(tt, "melee", "timed_attacks", "death_spawns")

image_y = 86
image_x = 106
anchor_y = 0.1511627906976744
anchor_x = 0.5
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_demon_death"
tt.enemy.gold = 60
tt.enemy.melee_slot = v(23, 0)
tt.health.armor = 0.8
tt.health.hp_max = 666
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset.y = 42
tt.info.i18n_key = "ENEMY_DEMON_LEGION"
tt.info.enc_icon = 56
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0077") or "info_portraits_sc_0077"
tt.main_script.insert = scripts.enemy_base_portal.insert
tt.main_script.update = scripts.enemy_demon_legion.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_demon_legion"
tt.sound_events.death = "DeathPuff"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].spawn_time = fts(5)
tt.timed_attacks.list[1].clone_time = fts(31)
tt.timed_attacks.list[1].generation = 2
tt.timed_attacks.list[1].animation = "summon"
tt.timed_attacks.list[1].spawn_animation = "spawn"
tt.timed_attacks.list[1].entity = "enemy_demon_legion"
tt.timed_attacks.list[1].cooldown = 15
tt.timed_attacks.list[1].cooldown_after = 10
tt.timed_attacks.list[1].spawn_offset_nodes = {
	5,
	10
}
tt.timed_attacks.list[1].nodes_limit = 20
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 12)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_demon_gulaemon", "enemy")

AC(tt, "melee", "timed_actions", "death_spawns")

anchor_y = 0.21296296296296297
anchor_x = 0.5
image_y = 108
image_x = 108
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_gulaemon_death"
tt.enemy.gold = 80
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(28, 0)
tt.health.hp_max = 2500
tt.health.magic_armor = 0.6
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset.y = 68
tt.info.i18n_key = "ENEMY_DEMON_GULAEMON"
tt.info.enc_icon = 53
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0078") or "info_portraits_sc_0078"
tt.main_script.insert = scripts.enemy_base_portal.insert
tt.main_script.update = scripts.enemy_demon_gulaemon.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 80
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix_ground = "enemy_demon_gulaemon"
tt.render.sprites[1].prefix_air = "enemy_demon_gulaemon_fly"
tt.render.sprites[1].prefix = tt.render.sprites[1].prefix_ground
tt.render.sprites[1].angles.takeoff = {
	"initFlyRightLeft",
	"initFlyUp",
	"initFlyDown"
}
tt.render.sprites[1].angles.land = {
	"endFlyRightLeft",
	"endFlyUp",
	"endFlyDown"
}
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "Inferno_FatDemon_0178"
tt.render.sprites[2].offset = v(0.5, 30)
tt.render.sprites[2].z = Z_DECALS
tt.sound_events.death = "DeathPuff"
tt.timed_actions.list[1] = CC("mod_attack")
tt.timed_actions.list[1].cooldown = 15
tt.timed_actions.list[1].charge_time = fts(3)
tt.timed_actions.list[1].mod = "mod_gulaemon_fly"
tt.timed_actions.list[1].nodes_limit_start = 20
tt.timed_actions.list[1].off_health_bar_y = 17
tt.timed_actions.list[1].off_click_rect_y = 24
tt.timed_actions.list[1].off_mod_offset_y = 23
tt.timed_actions.list[1].off_hit_offset_y = 23
tt.timed_actions.list[1].flags_air = bor(F_FLYING)
tt.timed_actions.list[1].bans_air = bor(F_BLOCK, F_THORN)
tt.ui.click_rect = r(-20, 0, 40, 56)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("enemy_necromancer", "enemy")

AC(tt, "melee", "ranged", "timed_actions")

anchor_y = 0.2
anchor_x = 0.5
image_y = 38
image_x = 44
tt.enemy.gold = 50
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 700
tt.health_bar.offset = v(0, 30)
tt.info.i18n_key = "ENEMY_NECROMANCER"
tt.info.enc_icon = 29
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0054") or "info_portraits_sc_0054"
tt.main_script.update = scripts.enemy_necromancer.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].hit_time = fts(10)
tt.motion.max_speed = FPS*0.6
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].bullet = "bolt_necromancer"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 22)
}
tt.ranged.attacks[1].cooldown = fts(23) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 145
tt.ranged.attacks[1].min_range = 60
tt.ranged.attacks[1].damage_type = DAMAGE_TRUE
tt.ranged.attacks[1].shoot_time = fts(9)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_necromancer"
tt.sound_events.death = "DeathPuff"
tt.timed_actions.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_actions.list[1].cooldown = 8
tt.timed_actions.list[1].spawn_time = fts(12)
tt.timed_actions.list[1].spawn_delay = fts(4)
tt.timed_actions.list[1].entity_chances = {
	0.05,
	1
}
tt.timed_actions.list[1].entity_names = {
	"enemy_skeleton_big",
	"enemy_skeleton"
}
tt.timed_actions.list[1].animation = "summon"
tt.timed_actions.list[1].spawn_animation = "raise"
tt.timed_actions.list[1].max_count = 5
tt.timed_actions.list[1].count_group_name = "necromancer_skeletons"
tt.timed_actions.list[1].count_group_type = COUNT_GROUP_CONCURRENT
tt.timed_actions.list[1].count_group_max = 50
tt.timed_actions.list[1].summon_offsets = {
	{
		2,
		0,
		0
	},
	{
		3,
		0,
		0
	},
	{
		1,
		3,
		8
	},
	{
		2,
		3,
		8
	},
	{
		3,
		3,
		8
	},
	{
		1,
		-3,
		-8
	},
	{
		2,
		-3,
		-8
	},
	{
		3,
		-3,
		-8
	}
}
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 15)
tt.unit.mod_offset = v(adx(23), ady(17))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = RT("enemy_skeleton_blackburn", "enemy_skeleton")
tt = RT("enemy_zombie_blackburn", "enemy_halloween_zombie")
tt = RT("enemy_skeleton_warrior", "enemy_skeleton_big")
tt = RT("enemy_demon_cerberus", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.14285714285714285
anchor_x = 0.5
image_y = 70
image_x = 128
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "aura_demon_cerberus_death"
tt.death_spawns.delay = 0.11
tt.enemy.gold = 350
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(41, 0)
tt.health.armor = 0.8
tt.health.hp_max = 6000
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, 57)
tt.info.i18n_key = "ENEMY_DEMON_CERBERUS"
tt.info.enc_icon = 55
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0079") or "info_portraits_sc_0079"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_demon_cerberus.update
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 90
tt.melee.attacks[1].damage_min = 70
tt.melee.attacks[1].damage_radius = 57.6
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].dodge_time = fts(7)
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].hit_time = fts(11)
tt.melee.attacks[1].hit_offset = v(20, 0)
tt.motion.max_speed = FPS*1.3
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_demon_cerberus"
tt.sound_events.death = "DeathPuff"
tt.sound_events.death_by_explosion = "DeathPuff"
tt.ui.click_rect.size = v(45, 43)
tt.ui.click_rect.pos = v(-22.5, 2)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 25)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_STUN, F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt = RT("enemy_witch", "enemy")

AC(tt, "ranged")

anchor_y = 0.05319148936170213
anchor_x = 0.5
image_y = 94
image_x = 88
tt.enemy.gold = 80
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(26, 0)
tt.health.hp_max = 600
tt.health.magic_armor = 0.9
tt.health_bar.offset = v(0, 72)
tt.info.i18n_key = "ENEMY_WITCH"
tt.info.enc_icon = 66
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0090") or "info_portraits_sc_0090"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.motion.max_speed = FPS*1.4960106382978726
tt.ranged.attacks[1].bullet = "bolt_witch"
tt.ranged.attacks[1].bullet_start_offset = {
	v(13, 45)
}
tt.ranged.attacks[1].cooldown = fts(60) + fts(34)
tt.ranged.attacks[1].hold_advance = false
tt.ranged.attacks[1].max_range = 319.1489361702128
tt.ranged.attacks[1].min_range = 35.46099290780142
tt.ranged.attacks[1].shoot_time = fts(23)
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_witch"
tt.sound_events.death = "EnemyBlackburnWitchDeath"
tt.sound_events.insert = "EnemyBlackburnWitch"
tt.ui.click_rect = r(-14, 30, 30, 32)
tt.unit.can_explode = false
tt.unit.can_disintegrate = true
tt.unit.disintegrate_fx = "fx_enemy_desintegrate_air"
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 45)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 47)
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_THORN)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = RT("enemy_spectral_knight", "enemy")

AC(tt, "melee", "auras")

image_y = 94
image_x = 128
anchor_y = 0.1595744680851064
anchor_x = 0.5
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "aura_spectral_knight"
tt.enemy.gold = 40
tt.enemy.melee_slot = v(26, 0)
tt.health.armor = 1
tt.health.hp_max = 400
tt.health.immune_to = bor(DAMAGE_PHYSICAL, DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL)
tt.health_bar.offset = v(0, 61)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_SPECTRAL_KNIGHT"
tt.info.enc_icon = 64
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0088") or "info_portraits_sc_0088"
tt.main_script.insert = scripts.enemy_spectral_knight.insert
tt.main_script.update = scripts.enemy_spectral_knight.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 76
tt.melee.attacks[1].damage_min = 24
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*0.775709219858156
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_spectral_knight"
tt.sound_events.death = nil
tt.sound_events.insert = "CBSpectralKnight"
tt.sound_events.insert_args = {
	delay = 0.5
}
tt.ui.click_rect = r(-20, 0, 40, 45)
tt.unit.blood_color = BLOOD_NONE
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 21)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_THORN)
tt.vis.flags = bor(F_ENEMY)
tt = RT("enemy_spectral_knight_spawn", "enemy_spectral_knight")
tt.enemy.gold = 0
tt = RT("enemy_fallen_knight", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.1595744680851064
anchor_x = 0.5
image_y = 94
image_x = 128
tt.death_spawns.name = "enemy_spectral_knight_spawn"
tt.death_spawns.spawn_animation = "raise"
tt.death_spawns.delay = fts(11)
tt.enemy.gold = 40
tt.enemy.melee_slot = v(26, 0)
tt.health.dead_lifetime = 1
tt.health.hp_max = 1000
tt.health.magic_armor = 0.9
tt.health_bar.offset = v(0, 56)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.i18n_key = "ENEMY_FALLEN_KNIGHT"
tt.info.enc_icon = 63
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0087") or "info_portraits_sc_0087"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 76
tt.melee.attacks[1].damage_min = 24
tt.melee.attacks[1].hit_time = fts(13)
tt.motion.max_speed = FPS*0.44326241134751776
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_fallen_knight"
tt.sound_events.death = nil
tt.sound_events.death_by_explosion = nil
tt.ui.click_rect = r(-15, 0, 30, 45)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 19)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt = RT("enemy_troll_skater", "enemy")

AC(tt, "melee", "auras")

anchor_y = 0.18
anchor_x = 0.5
image_y = 50
image_x = 82
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_troll_skater_regen"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 30
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 350
tt.info.i18n_key = "ENEMY_TROLL_SKATER"
tt.info.enc_icon = 50
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0073") or "info_portraits_sc_0073"
tt.main_script.update = scripts.enemy_troll_skater.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 70
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*1.2
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll_skater"
tt.sound_events.death = "DeathTroll"
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 13)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt.skate = {
	mod = "mod_troll_skater",
	vis_bans_extra = bor(F_BLOCK),
	prefix = "enemy_troll",
	walk_angles = {
		"skateRightLeft",
		"skateUp",
		"skateDown"
	}
}
tt = RT("soldier_troll_skater", "soldier_militia")

AC(tt, "melee", "auras")

anchor_y = 0.18
anchor_x = 0.5
image_y = 50
image_x = 82
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_troll_skater_regen"
tt.auras.list[1].cooldown = 0
tt.soldier.melee_slot_offset = v(18, 0)
tt.health.hp_max = 350
tt.info.i18n_key = "ENEMY_TROLL_SKATER"
tt.info.enc_icon = 50
tt.info.fn = scripts.soldier_mercenary.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0073") or "info_portraits_sc_0073"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 70
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.range = 85
tt.motion.max_speed = 70
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_troll_skater"
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft"
	}
}
tt.regen.cooldown = fts(4)
tt.regen.health = 1
tt.sound_events.death = "DeathTroll"
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 13)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 13)
tt.unit.price = 100
tt = RT("enemy_hobgoblin", "enemy")

AC(tt, "melee", "death_spawns")

anchor_y = 0.17532467532467533
anchor_x = 0.5
image_y = 154
image_x = 224
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "fx_coin_shower"
tt.death_spawns.offset = v(0, 60)
tt.enemy.gold = 250
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.hp_max = 2000
tt.health_bar.offset = v(0, 82)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_ENDLESS_MINIBOSS_ORC"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0094") or "info_portraits_sc_0094"
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 90
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].damage_radius = 45
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_hobgoblin_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_hobgoblin_ground_hit"
tt.melee.attacks[1].hit_offset = v(72, -9)
tt.melee.attacks[1].hit_time = fts(24)
tt.melee.attacks[1].sound = "AreaAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(24)
}
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "enemy_hobgoblin"
tt.sound_events.death = "DeathJuggernaut"
tt.ui.click_rect = r(-30, 0, 60, 70)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 34)
tt.unit.mod_offset = v(0, 34)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_DISINTEGRATED, F_INSTAKILL)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt = RT("eb_juggernaut", "boss")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.08
anchor_x = 0.5
image_y = 128
image_x = 144
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 10
tt.health.hp_max = 10000
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.offset = v(0, ady(120))
tt.info.fn = scripts.eb_juggernaut.get_info
tt.info.i18n_key = "ENEMY_JUGGERNAUT"
tt.info.enc_icon = 32
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0027") or "info_portraits_sc_0027"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_juggernaut.update
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(0.5, 0.08)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_juggernaut"
tt.sound_events.death = "DeathJuggernaut"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-35, 0, 70, 80)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, ady(50))
tt.unit.mod_offset = v(adx(70), ady(50))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 250
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].damage_radius = 45
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].hit_fx = "fx_juggernaut_smoke"
tt.melee.attacks[1].sound_hit = "juggernaut_punch"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "shoot"
tt.timed_attacks.list[1].bullet = "missile_juggernaut"
tt.timed_attacks.list[1].bullet_start_offset = v(-30, 82)
tt.timed_attacks.list[1].cooldown = 11
tt.timed_attacks.list[1].launch_vector = v(12, 170)
tt.timed_attacks.list[1].max_range = 99999
tt.timed_attacks.list[1].min_range = 100
tt.timed_attacks.list[1].shoot_time = fts(24)
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[2] = table.deepclone(tt.timed_attacks.list[1])
tt.timed_attacks.list[2].bullet = "bomb_juggernaut"
tt.timed_attacks.list[2].cooldown = 4
tt = RT("eb_jt", "boss")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.19
anchor_x = 0.5
image_y = 200
image_x = 260
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "jt_spawner_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(55, 0)
tt.health.dead_lifetime = 100
tt.health.hp_max = 11000
tt.health.on_damage = scripts.eb_jt.on_damage
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.offset = v(0, ady(172))
tt.info.fn = scripts.eb_jt.get_info
tt.info.i18n_key = "ENEMY_YETI_BOSS"
tt.info.enc_icon = 33
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0047") or "info_portraits_sc_0047"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_jt.update
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(0.5, 0.08)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_jt"
tt.tap_decal = "decal_jt_tap"
tt.tap_timeout = 1.5
tt.sound_events.death = "JtDeath"
tt.sound_events.death_explode = "JtExplode"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-38, 0, 76, 95)
tt.unit.hit_offset = v(0, 60)
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(adx(130), ady(90))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 5
tt.melee.attacks[1].damage_max = 200
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].damage_radius = 45
tt.melee.attacks[1].damage_type = DAMAGE_EAT
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound = "JtEat"
tt.melee.attacks[1].sound_args = {
	delay = fts(6)
}
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].cooldown = fts(29) + 10
tt.timed_attacks.list[1].count = 4
tt.timed_attacks.list[1].exhausted_duration = 4
tt.timed_attacks.list[1].exhausted_sound = "JtRest"
tt.timed_attacks.list[1].exhausted_sound_args = {
	delay = fts(34)
}
tt.timed_attacks.list[1].hit_decal = "decal_jt_ground_hit"
tt.timed_attacks.list[1].hit_offset = v(80, -10)
tt.timed_attacks.list[1].hit_time = fts(16)
tt.timed_attacks.list[1].max_range = 192
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].mod = "mod_jt_tower"
tt.timed_attacks.list[1].sound = "JtAttack"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(6)
}
tt = RT("eb_veznan", "boss")

AC(tt, "melee", "timed_attacks", "taunts")

anchor_y = 0.17010309278350516
anchor_x = 0.5
image_y = 194
image_x = 214
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(20, 0)
tt.health.hp_max = {
	5999,
	6666,
	7999
}
tt.health.on_damage = scripts.eb_veznan.on_damage
tt.health.ignore_damage = true
tt.health_bar.hidden = true
tt.health_bar.offset = v(0, 43)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_MEDIUM
tt.info.i18n_key = "ENEMY_VEZNAN"
tt.info.enc_icon = 34
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0056") or "info_portraits_sc_0056"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_veznan.update
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_veznan"
tt.render.sprites[1].name = "idleDown"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "VeznanDeath"
tt.ui.click_rect = r(-11, -2, 22, 38)
tt.unit.hit_offset = v(0, 14)
tt.unit.mod_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_ALL)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.pos_castle = v(518, 677)
tt.souls_aura = "veznan_souls_aura"
tt.white_circle = "decal_eb_veznan_white_circle"
tt.taunts.animation = "laught"
tt.taunts.delay_min = fts(400)
tt.taunts.delay_max = fts(700)
tt.taunts.duration = 4
tt.taunts.decal_name = "decal_s12_shoutbox"
tt.taunts.offset = v(0, 0)
tt.taunts.pos = v(525, 608)
tt.taunts.sets.welcome = CC("taunt_set")
tt.taunts.sets.welcome.format = "VEZNAN_TAUNT_%04d"
tt.taunts.sets.welcome.end_idx = 5
tt.taunts.sets.welcome.delays = {
	fts(60),
	fts(140),
	fts(450),
	fts(250)
}
tt.taunts.sets.castle = CC("taunt_set")
tt.taunts.sets.castle.format = "VEZNAN_TAUNT_%04d"
tt.taunts.sets.castle.start_idx = 6
tt.taunts.sets.castle.end_idx = 25
tt.taunts.sets.damage = CC("taunt_set")
tt.taunts.sets.damage.format = "VEZNAN_TAUNT_%04d"
tt.taunts.sets.damage.start_idx = 26
tt.taunts.sets.damage.end_idx = 29
tt.taunts.sets.pre_battle = CC("taunt_set")
tt.taunts.sets.pre_battle.format = "VEZNAN_TAUNT_%04d"
tt.taunts.sets.pre_battle.start_idx = 30
tt.taunts.sets.pre_battle.end_idx = 30
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 8
tt.melee.attacks[1].damage_min = 666
tt.melee.attacks[1].damage_max = 999
tt.melee.attacks[1].damage_radius = 75
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_offset = v(-10, -2)
tt.melee.attacks[1].hit_time = fts(17)
tt.melee.attacks[1].hit_decal = "decal_veznan_strike"
tt.melee.attacks[1].sound_hit = "VeznanAttack"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].cooldown = 2.5
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_decal = nil
tt.melee.attacks[2].hit_fx = "fx_veznan_demon_fire"
tt.melee.attacks[2].hit_fx_offset = v(20, 9)
tt.melee.attacks[2].hit_fx_once = true
tt.melee.attacks[2].hit_fx_flip = true
tt.melee.attacks[2].hit_times = {
	fts(20),
	fts(24),
	fts(28),
	fts(32),
	fts(36),
	fts(38),
	fts(42),
	fts(44)
}
tt.melee.attacks[2].hit_offset = v(40, 0)
tt.melee.attacks[2].sound_hit = nil
tt.melee.attacks[2].sound = "VeznanDemonFire"
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].cooldown = 13
tt.timed_attacks.list[1].animation = "spellDown"
tt.timed_attacks.list[1].hit_time = fts(14)
tt.timed_attacks.list[1].mod = "mod_veznan_tower"
tt.timed_attacks.list[1].sound = "VeznanHoldCast"
tt.timed_attacks.list[1].attack_duration = fts(44)
tt.timed_attacks.list[1].data = {
	[9] = {
		13,
		2
	},
	[10] = {
		13,
		3
	},
	[11] = {
		14,
		4
	},
	[12] = {
		14,
		5
	},
	[13] = {
		16,
		6
	},
	[14] = {
		16,
		7
	},
	[15] = {
		18,
		8
	}
}
tt.timed_attacks.list[2] = CC("custom_attack")
tt.timed_attacks.list[2].animation = "spellDown"
tt.timed_attacks.list[2].cooldown = 15
tt.timed_attacks.list[2].hit_time = fts(14)
tt.timed_attacks.list[2].portal_name = "veznan_portal"
tt.timed_attacks.list[2].sound = "VeznanPortalSummon"
tt.timed_attacks.list[2].attack_duration = fts(44)
tt.timed_attacks.list[2].data = {
	[6] = {
		15,
		3,
		{
			1,
			0,
			0
		}
	},
	[7] = {
		10,
		2,
		{
			1,
			0,
			0
		}
	},
	[8] = {
		20,
		3,
		{
			0,
			1,
			0
		}
	},
	[9] = {
		15,
		3,
		{
			1,
			0,
			0
		}
	},
	[10] = {
		20,
		3,
		{
			1,
			1,
			0
		}
	},
	[11] = {
		15,
		3,
		{
			1,
			1,
			0
		}
	},
	[12] = {
		15,
		3,
		{
			1,
			1,
			0
		}
	},
	[13] = {
		15,
		3,
		{
			0,
			0,
			1
		}
	},
	[14] = {
		15,
		3,
		{
			1,
			1,
			1
		}
	},
	[15] = {
		15,
		3,
		{
			1,
			1,
			1
		}
	}
}
tt.battle = {
	ba_animation = "spell",
	pa_animation = "spell",
	pa_cooldown = 10,
	pa_max_count = 40
}
tt.demon = {
	health_bar_offset = v(0, 118),
	health_bar_scale = 1.8,
	melee_slot = v(50, 0),
	speed = FPS*0.6,
	sprites_prefix = "eb_veznan_demon",
	transform_sound = "VeznanToDemon",
	ui_click_rect = r(-25, -5, 50, 110),
	unit_hit_offset = v(0, 55),
	unit_mod_offset = v(0, 45),
	unit_size = UNIT_SIZE_LARGE,
	info_portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0056") or "info_portraits_sc_0093"
}
tt = RT("eb_sarelgaz", "boss")

AC(tt, "melee")

anchor_y = 0.1484375
anchor_x = 0.5
image_y = 128
image_x = 220
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(80, 0)
tt.health.dead_lifetime = 8
tt.health.hp_max = 18000
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.offset = v(0, 108)
tt.info.i18n_key = "ENEMY_SARELGAZ"
tt.info.enc_icon = 35
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0057") or "info_portraits_sc_0057"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 0.5
tt.melee.attacks[1].damage_max = 500
tt.melee.attacks[1].damage_min = 300
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].damage_type = DAMAGE_EAT
tt.melee.attacks[1].sound = "SpiderAttack"
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_sarelgaz"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "DeathEplosion"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-45, 0, 90, 80)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.can_explode = false
tt.unit.can_disintegrate = false
tt.unit.fade_time_after_death = 2
tt.unit.hit_offset = v(0, 45)
tt.unit.marker_hidden = true
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 45)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt = RT("eb_gulthak", "boss")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.11
anchor_x = 0.5
tt.enemy.gold = 0
image_y = 196
image_x = 340
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(60, 0)
tt.health.dead_lifetime = 8
tt.health.hp_max = 11000
tt.health_bar.offset = v(0, 95)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_BOSS_GOBLIN_CHIEFTAIN"
tt.info.enc_icon = 40
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0063") or "info_portraits_sc_0063"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_shaman.update
tt.melee.attacks[1].cooldown = fts(20) + 0.5
tt.melee.attacks[1].damage_max = 600
tt.melee.attacks[1].damage_min = 200
tt.melee.attacks[1].hit_time = fts(11)
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_gulthak"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles_flip_vertical = {
	walk = true
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "DeathBig"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-50, 0, 90, 60)
tt.unit.can_explode = false
tt.unit.can_disintegrate = false
tt.unit.fade_time_after_death = 2
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 27)
tt.unit.marker_hidden = true
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "heal"
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].cooldown = 8
tt.timed_attacks.list[1].max_count = 20
tt.timed_attacks.list[1].max_range = 9999
tt.timed_attacks.list[1].mod = "mod_gulthak_heal"
tt.timed_attacks.list[1].sound = "EnemyHealing"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt = RT("eb_greenmuck", "boss")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.1402439024390244
anchor_x = 0.5
image_y = 232
image_x = 244
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 8
tt.health.hp_max = 10000
tt.health_bar.offset = v(0, 135)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_greenmuck.get_info
tt.info.i18n_key = "ENEMY_ROTTEN_TREE_BOSS"
tt.info.enc_icon = 45
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0069") or "info_portraits_sc_0069"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_greenmuck.update
tt.motion.max_speed = FPS*0.3
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_greenmuck"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = nil
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-30, 0, 60, 110)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.fade_time_after_death = 2
tt.unit.hit_offset = v(0, 37)
tt.unit.marker_offset = v(0, -10)
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(0, 37)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 250
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].damage_radius = 60
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "shoot"
tt.timed_attacks.list[1].bullet = "bomb_greenmuck"
tt.timed_attacks.list[1].count = 7
tt.timed_attacks.list[1].bullet_start_offset = v(0, 120)
tt.timed_attacks.list[1].cooldown = 6
tt.timed_attacks.list[1].shoot_time = fts(13)
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = F_ENEMY
tt = RT("eb_kingpin", "enemy")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.13
anchor_x = 0.5
image_y = 204
image_x = 218
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "kingpin_damage_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(60, 0)
tt.health.dead_lifetime = 12
tt.health.hp_max = 8000
tt.health_bar.offset = v(0, 125)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_kingpin.get_info
tt.info.i18n_key = "ENEMY_BOSS_BANDIT"
tt.info.enc_icon = 48
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0072") or "info_portraits_sc_0072"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_kingpin.update
tt.motion.max_speed = FPS*0.4
tt.render.sprites[1].anchor = v(0.5, 0.13)
tt.render.sprites[1].prefix = "eb_kingpin"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "DeathJuggernaut"
tt.sound_events.insert = "MusicBossFight"
tt.stop_time = 5
tt.stop_cooldown = 5
tt.stop_wait = fts(25)
tt.ui.click_rect = r(-50, 0, 100, 75)
tt.unit.fade_time_after_death = 2
tt.unit.hit_offset = v(0, 80)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 82)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH, F_BLOCK)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = fts(20) + 1
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].damage_radius = 65
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].hit_fx = "fx_juggernaut_smoke"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "eat"
tt.timed_attacks.list[1].cast_time = fts(14)
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].max_count = 1
tt.timed_attacks.list[1].max_range = 320
tt.timed_attacks.list[1].mod = "mod_kingpin_heal_self"
tt.timed_attacks.list[1].sound = "EnemyHealing"
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt.timed_attacks.list[2] = table.deepclone(tt.timed_attacks.list[1])
tt.timed_attacks.list[2].animation = "heal"
tt.timed_attacks.list[2].max_count = 9999
tt.timed_attacks.list[2].max_range = 100
tt.timed_attacks.list[2].mod = "mod_kingpin_heal_others"
tt = RT("eb_ulgukhai", "boss")

AC(tt, "melee", "auras")

anchor_y = 0.1792452830188679
anchor_x = 0.5
image_y = 150
image_x = 240
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_ulgukhai_regen"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 12
tt.health.hp_max = 11000
tt.health_bar.offset = v(0, 90)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_ulgukhai.get_info
tt.info.i18n_key = "ENEMY_TROLL_BOSS"
tt.info.enc_icon = 52
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0075") or "info_portraits_sc_0075"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_ulgukhai.update
tt.motion.max_speed = FPS*0.3
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_ulgukhai"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "DeathBig"
tt.sound_events.insert = "MusicBossFight"
tt.unit.blood_color = BLOOD_GRAY
tt.ui.click_rect = r(-25, 5, 50, 65)
tt.unit.fade_time_after_death = 2
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 26)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.shielded_extra_vis_bans = bor(F_MOD, F_POISON)
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = 3
tt.melee.attacks[1].damage_max = 350
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].damage_radius = 57.6
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].hit_time = fts(16)
tt.melee.attacks[1].hit_offset = v(60, 0)
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt = RT("eb_moloch", "boss")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.105
anchor_x = 0.5
image_y = 282
image_x = 282
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(33, 0)
tt.health.dead_lifetime = 100
tt.health.ignore_damage = true
tt.health.magic_armor = 0
tt.health.hp_max = {
	8889,
	11111,
	13333
}
tt.health_bar.offset = v(0, 125)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.i18n_key = "ENEMY_DEMON_MOLOCH"
tt.info.enc_icon = 57
tt.info.fn = scripts.eb_moloch.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0080") or "info_portraits_sc_0080"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_moloch.update
tt.motion.max_speed = FPS*0.7
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_moloch"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "EnemyInfernoBossDeath"
tt.ui.click_rect = r(-25, 0, 50, 100)
tt.unit.hit_offset = v(0, 60)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 45)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_ALL)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.stand_up_wait_time = fts(14)
tt.stand_up_sound = "MusicBossFight"
tt.pos_sitting = v(526, 614)
tt.nav_path.pi = 2
tt.nav_path.spi = 1
tt.nav_path.ni = 1
tt.wave_active = 16
tt.active_vis_bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = fts(25) + 1.5
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 80
tt.melee.attacks[1].damage_radius = 40
tt.melee.attacks[1].count = nil
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].hit_fx = "fx_moloch_ring"
tt.melee.attacks[1].sound_hit = "EnemyInfernoStomp"
tt.timed_attacks.list[1] = CC("area_attack")
tt.timed_attacks.list[1].cooldown = 7
tt.timed_attacks.list[1].animation = "horn_attack"
tt.timed_attacks.list[1].damage_radius = 100
tt.timed_attacks.list[1].damage_type = DAMAGE_INSTAKILL
tt.timed_attacks.list[1].hit_time = fts(15)
tt.timed_attacks.list[1].min_targets = 2
tt.timed_attacks.list[1].fx_list = {
	{
		"fx_moloch_rocks",
		{
			{
				36,
				-30
			},
			{
				1,
				-10
			},
			{
				90,
				-23
			},
			{
				87,
				5
			},
			{
				49,
				-3
			},
			{
				54,
				17
			}
		}
	},
	{
		"fx_moloch_ring",
		{
			{
				45,
				0
			}
		}
	}
}
tt.timed_attacks.list[1].hit_offset = v(20, 0)
tt.timed_attacks.list[1].sound = "EnemyInfernoHorns"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(5)
}
tt = RT("eb_myconid", "boss")

AC(tt, "melee", "timed_attacks")

anchor_y = 0.16428571428571428
anchor_x = 0.5
image_y = 140
image_x = 174
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 12
tt.health.hp_max = 4500
tt.health_bar.offset = v(0, 100)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_myconid.get_info
tt.info.i18n_key = "ENEMY_ROTTEN_MYCONID"
tt.info.enc_icon = 59
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0082") or "info_portraits_sc_0082"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_myconid.update
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_myconid"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "EnemyMushroomBossDeath"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect = r(-25, 0, 50, 80)
tt.unit.fade_time_after_death = 4
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.hit_offset = v(0, 33)
tt.unit.mod_offset = v(0, 33)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.spawner_entity = "myconid_spawner"
tt.on_death_spawn_count = 12
tt.on_death_spawn_wait = fts(40)
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 350
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].hit_time = fts(9)
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animation = "spores"
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].final_wait = fts(20)
tt.timed_attacks.list[1].fx = "fx_myconid_spores"
tt.timed_attacks.list[1].fx_offset = v(0, 40)
tt.timed_attacks.list[1].min_nodes = 25
tt.timed_attacks.list[1].mod = "mod_myconid_poison"
tt.timed_attacks.list[1].radius = 110
tt.timed_attacks.list[1].sound = "EnemyMushroomGas"
tt.timed_attacks.list[1].summon_counts = {
	2,
	3,
	3,
	4,
	4,
	4,
	3,
	2
}
tt.timed_attacks.list[1].vis_bans = F_ENEMY
tt.timed_attacks.list[1].vis_flags = bor(F_MOD, F_POISON)
tt.timed_attacks.list[1].wait_times = {
	fts(15),
	fts(3),
	fts(6)
}
tt = RT("eb_blackburn", "boss")

AC(tt, "melee", "timed_attacks", "auras")

anchor_y = 0.16993464052287582
anchor_x = 0.5
image_y = 308
image_x = 314
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(40, 0)
tt.health.dead_lifetime = 100
tt.health.armor = 0.75
tt.health.hp_max = 9000
tt.health_bar.offset = v(0, 125)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_blackburn.get_info
tt.info.i18n_key = "ENEMY_BOSS_BLACKBURN"
tt.info.enc_icon = 69
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0093") or "info_portraits_sc_0092"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_blackburn.update
tt.motion.max_speed = FPS*0.5540780141843972
tt.render.sprites[1].anchor = v(anchor_x, anchor_y)
tt.render.sprites[1].prefix = "eb_blackburn"
tt.render.sprites[1].angles_stickiness = {
	walk = 10
}
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.sound_events.death = "EnemyBlackburnBossDeath"
tt.sound_events.insert = "MusicBossFight"
tt.ui.click_rect.pos.y = 9
tt.unit.hit_offset = v(adx(150), ady(115))
tt.unit.marker_offset = v(0, 11)
tt.unit.mod_offset = v(0, ady(115))
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_TELEPORT, F_THORN, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "blackburn_aura"
tt.auras.list[1].cooldown = 0
tt.melee.attacks[1] = CC("area_attack")
tt.melee.attacks[1].cooldown = fts(40) + 1.3
tt.melee.attacks[1].damage_max = 5
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].damage_radius = 63.829787234042556
tt.melee.attacks[1].dodge_time = fts(13)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "EnemyBlackburnBossSwing"
tt.melee.attacks[1].vis_bans = bor(F_STUN)
tt.timed_attacks.list[1] = CC("custom_attack")
tt.timed_attacks.list[1].after_hit_wait = fts(20)
tt.timed_attacks.list[1].animation = "smash"
tt.timed_attacks.list[1].aura_shake = "aura_screen_shake"
tt.timed_attacks.list[1].cooldown = fts(300)
tt.timed_attacks.list[1].after_cooldown = fts(150)
tt.timed_attacks.list[1].damage_max = 5
tt.timed_attacks.list[1].damage_min = 1
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].damage_radius = 106.38297872340426
tt.timed_attacks.list[1].fx = "fx_blackburn_smash"
tt.timed_attacks.list[1].fx_offset = v(26, 7)
tt.timed_attacks.list[1].hit_decal = "decal_blackburn_smash_ground"
tt.timed_attacks.list[1].hit_time = fts(24)
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 283.68794326241135
tt.timed_attacks.list[1].mod = "mod_blackburn_stun"
tt.timed_attacks.list[1].mod_towers = "mod_blackburn_tower"
tt.timed_attacks.list[1].sound = "EnemyBlackburnBossSpecialStomp"
tt.timed_attacks.list[1].sound_args = {
	delay = fts(13)
}
tt.timed_attacks.list[1].vis_flags = bor(F_MOD)
tt = E.register_t(E, "eb_elder_shaman", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.attacks.animation = "cast"
tt.attacks.delay = {
	0.6,
	0.9
}
tt.attacks.list[1] = E.clone_c(E, "aura_attack")
tt.attacks.list[1].aura = "aura_elder_shaman_healing"
tt.attacks.list[1].node_offset = {
	10,
	30
}
tt.attacks.list[1].path_margins = {
	40,
	10
}
tt.attacks.list[1].power_name = "healing"
tt.attacks.list[1].vis_bans = bor(F_FLYING, F_BOSS, F_FRIEND)
tt.attacks.list[1].vis_flags = bor(F_MOD)
tt.attacks.list[2] = E.clone_c(E, "aura_attack")
tt.attacks.list[2].aura = "aura_elder_shaman_damage"
tt.attacks.list[2].power_name = "damage"
tt.attacks.list[2].vis_bans = bor(F_FLYING, F_BOSS, F_ENEMY)
tt.attacks.list[2].vis_flags = bor(F_MOD)
tt.attacks.list[2].enemy_vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[2].enemy_vis_flags = bor(F_MOD)
tt.attacks.list[3] = E.clone_c(E, "aura_attack")
tt.attacks.list[3].aura = "aura_elder_shaman_speed"
tt.attacks.list[3].node_offset = {
	10,
	30
}
tt.attacks.list[3].path_margins = {
	25,
	40
}
tt.attacks.list[3].power_name = "speed"
tt.attacks.list[3].vis_bans = bor(F_FLYING, F_BOSS, F_FRIEND)
tt.attacks.list[3].vis_flags = bor(F_MOD)
tt.main_script.update = scripts.eb_elder_shaman.update
tt.render.sprites[1].prefix = "eb_elder_shaman"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.y = 0.09259259259259259
tt.taunt = {
	delay_min = 15,
	delay_max = 20,
	duration = 4,
	sets = {
		welcome = {},
		prebattle = {},
		battle = {},
		life_lost = {},
		totem = {}
	}
}
tt.taunt.sets.welcome.format = "ENDLESS_BOSS_ORC_TAUNT_WELCOME_%04d"
tt.taunt.sets.welcome.start_idx = 1
tt.taunt.sets.welcome.end_idx = 2
tt.taunt.sets.prebattle.format = "ENDLESS_BOSS_ORC_TAUNT_PREBATTLE_%04d"
tt.taunt.sets.prebattle.start_idx = 1
tt.taunt.sets.prebattle.end_idx = 4
tt.taunt.sets.battle.format = "ENDLESS_BOSS_ORC_TAUNT_GENERIC_%04d"
tt.taunt.sets.battle.start_idx = 1
tt.taunt.sets.battle.end_idx = 9
tt.taunt.sets.life_lost.format = "ENDLESS_BOSS_ORC_TAUNT_LIFE_LOST_%04d"
tt.taunt.sets.life_lost.start_idx = 1
tt.taunt.sets.life_lost.end_idx = 1
tt.taunt.sets.totem.format = "ENDLESS_BOSS_ORC_TAUNT_TOTEM_%04d"
tt.taunt.sets.totem.start_idx = 1
tt.taunt.sets.totem.end_idx = 1
tt.taunt.offset = v(0, -75)
tt.taunt.ts = 0
tt.taunt.next_ts = 0
tt = RT("decal_elder_shaman_shoutbox", "decal_tween")

AC(tt, "texts")

tt.render.sprites[1].name = "HalloweenBoss_tauntBox"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[2].offset = v(0, -9)
tt.texts.list[1].text = "Hello world"
tt.texts.list[1].size = v(172, 62)
tt.texts.list[1].font_name = "body_bold"
tt.texts.list[1].font_size = 20
tt.texts.list[1].color = {
	255,
	114,
	114
}
tt.texts.list[1].line_height = 0.8
tt.texts.list[1].sprite_id = 2
tt.texts.list[1].fit_height = true
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1.01, 1.01)
	},
	{
		0.4,
		v(0.99, 0.99)
	},
	{
		0.8,
		v(1.01, 1.01)
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].loop = true
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		0.25,
		255
	}
}
tt.tween.props[3].sprite_id = 1
tt.tween.props[4] = table.deepclone(tt.tween.props[3])
tt.tween.props[4].sprite_id = 2
tt.tween.remove = false
tt = E.register_t(E, "elven_arrow_1", "arrow")
tt.bullet.damage_min = 2
tt.bullet.damage_max = 5
tt.bullet.flight_time_min = fts(11)
tt.bullet.flight_time_factor = fts(5)*2
tt.bullet.pop = {
	"pop_tree_archer"
}
tt = E.register_t(E, "elven_arrow_2", "elven_arrow_1")
tt.bullet.damage_min = 4
tt.bullet.damage_max = 9
tt = E.register_t(E, "elven_arrow_3", "elven_arrow_1")
tt.bullet.damage_min = 5
tt.bullet.damage_max = 11
tt = E.register_t(E, "arrow_arcane", "elven_arrow_1")
tt.bullet.damage_max = 18
tt.bullet.damage_min = 11
tt.bullet.miss_decal = "archer_arcane_proy2_decal-f"
tt.bullet.mod = {
	"mod_arrow_arcane"
}
tt.bullet.hit_fx = "fx_arrow_arcane_hit"
tt.bullet.pop = {
	"pop_arcane"
}
tt.render.sprites[1].name = "archer_arcane_proy2_0001-f"
tt = E.register_t(E, "arrow_arcane_burst", "arrow_arcane")
tt.bullet.flight_time_min = fts(21)
tt.bullet.miss_decal = "archer_arcane_proy_decal-f"
tt.bullet.mod = {
	"mod_arrow_arcane"
}
tt.bullet.particles_name = "ps_arrow_arcane_special"
tt.bullet.payload = "aura_arcane_burst"
tt.render.sprites[1].name = "archer_arcane_proy_0001-f"
tt.sound_events.insert = "TowerArcanePreloadAndTravel"
tt = E.register_t(E, "arrow_arcane_slumber", "arrow_arcane")
tt.bullet.flight_time_min = fts(21)
tt.bullet.miss_decal = "archer_arcane_proy2_decal-f"
tt.bullet.hit_fx = "fx_arcane_slumber_explosion"
tt.bullet.mod = {
	"mod_arrow_arcane_slumber"
}
tt.bullet.particles_name = "ps_arrow_arcane_special"
tt.render.sprites[1].name = "archer_arcane_proy_0001-f"
tt.sound_events.insert = "TowerArcanePreloadAndTravel"
tt = E.register_t(E, "arrow_silver", "elven_arrow_1")
tt.bullet.flight_time_min = fts(9)
tt.bullet.flight_time_factor = fts(0.016666666666666666)
tt.bullet.miss_decal = "archer_silver_proys_0002-f"
tt.bullet.damage_max = 20
tt.bullet.damage_min = 15
tt.bullet.pop = {
	"pop_golden"
}
tt.bullet.pop_conds = DR_KILL
tt.render.sprites[1].name = "archer_silver_proys_0001-f"
tt.sound_events.insert = "TowerGoldenBowArrowShot"
tt = E.register_t(E, "arrow_silver_long", "arrow_silver")
tt.bullet.flight_time_factor = fts(0.08333333333333333)
tt.bullet.damage_max = 60
tt.bullet.damage_min = 45
tt.bullet.hit_distance = 9e+99
tt = E.register_t(E, "arrow_silver_sentence", "arrow_silver")
tt.render.sprites[1].name = "archer_silver_instaKill_bullet"
tt.bullet.g = 0
tt.bullet.hit_fx = "fx_arrow_silver_sentence_hit"
tt.bullet.flight_time_min = fts(4)
tt.bullet.flight_time_factor = fts(0.03333333333333333)
tt.bullet.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_NOT_EXPLODE)
tt.bullet.prediction_error = false
tt.bullet.pop = {
	"pop_headshot"
}
tt.bullet.pop_conds = DR_KILL
tt = E.register_t(E, "arrow_silver_sentence_long", "arrow_silver_sentence")
tt = E.register_t(E, "arrow_silver_mark", "arrow_silver")
tt.bullet.hit_fx = "fx_arrow_silver_mark_hit"
tt.bullet.mod = "mod_arrow_silver_mark"
tt.bullet.particles_name = "ps_arrow_silver_mark"
tt.bullet.miss_decal = "archer_silver_proys_0004-f"
tt.render.sprites[1].name = "archer_silver_proys_0003-f"
tt.sound_events.insert = nil
tt = E.register_t(E, "arrow_silver_mark_long", "arrow_silver_mark")
tt.bullet.flight_time_factor = fts(0.08333333333333333)
tt.bullet.damage_max = 60
tt.bullet.damage_min = 45
tt.bullet.hit_distance = 9e+99
tt = E.register_t(E, "bolt_elves", "bullet")

E.add_comps(E, tt, "force_motion")

tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_fx = "fx_bolt_elves_hit"
tt.bullet.max_speed = 300
tt.bullet.min_speed = 30
tt.bullet.pop = {
	"pop_zap"
}
tt.bullet.pop_conds = DR_KILL
tt.bullet.pop_eldritch_mage_el_empowerment = {
	"pop_crit_mages"
}
tt.initial_impulse = 15000
tt.initial_impulse_duration = 0.15
tt.initial_impulse_angle = math.pi/3
tt.force_motion.a_step = 5
tt.force_motion.max_a = 3000
tt.force_motion.max_v = 300
tt.main_script.insert = scripts2.bolt_elves.insert
tt.main_script.update = scripts2.bolt_elves.update
tt.render.sprites[1].prefix = "bolt_elves"
tt.render.sprites[1].name = "travel"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset.y = -20
tt.render.sprites[2].animated = false
tt.sound_events.insert = "TowerWizardBasicBolt"
tt = E.register_t(E, "bolt_elves_1", "bolt_elves")
tt.bullet.damage_min = 4
tt.bullet.damage_max = 6
tt.bullet.particles_name = "ps_bolt_elves_1"
tt.render.sprites[1].scale = v(0.8, 0.8)
tt = E.register_t(E, "bolt_elves_2", "bolt_elves_1")
tt.bullet.damage_min = 9
tt.bullet.damage_max = 15
tt.bullet.particles_name = "ps_bolt_elves_2"
tt.render.sprites[1].scale = v(0.9, 0.9)
tt = E.register_t(E, "bolt_elves_3", "bolt_elves_1")
tt.bullet.damage_min = 17
tt.bullet.damage_max = 28
tt.bullet.particles_name = "ps_bolt_elves_3"
tt.render.sprites[1].scale = v(1, 1)
tt = E.register_t(E, "bolt_wild_magus", "bolt")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].prefix = "bolt_wild_magus"
tt.bullet.damage_max = 19
tt.bullet.damage_min = 11
tt.bullet.damage_same_target_inc = 2
tt.bullet.damage_same_target_max = 16
tt.bullet.acceleration_factor = 0.25
tt.bullet.min_speed = 30
tt.bullet.max_speed = 2100
tt.bullet.hit_fx = "fx_wild_magus_hit"
tt.bullet.particles_name = "ps_bolt_wild_magus"
tt.sound_events.insert = "TowerWildMagusBoltcast"
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(4),
		255
	}
}
tt = E.register_t(E, "ray_wild_magus", "bullet")
tt.image_width = 144
tt.main_script.update = scripts2.ray_simple.update
tt.render.sprites[1].name = "ray_wild_magus"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.mod = "mod_eldritch"
tt.bullet.hit_fx = "fx_ray_wild_magus_hit"
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_time = fts(2)
tt.track_target = true
tt = E.register_t(E, "bolt_high_elven_weak", "bolt_elves")
tt.bullet.damage_max = 10
tt.bullet.damage_min = 10
tt.bullet.hit_fx = "fx_bolt_high_elven_weak_hit"
tt.bullet.particles_name = "ps_bolt_high_elven"
tt.bullet.pop = {
	"pop_eldritch_mage"
}
tt.bullet.pop_eldritch_mage_el_empowerment = {
	"pop_crit_high_elven"
}
tt.bullet.max_speed = 750
tt.render.sprites[1].prefix = "bolt_high_elven_weak"
tt.render.sprites[1].scale = v(0.8, 0.8)
tt = E.register_t(E, "bolt_high_elven_strong", "bolt_elves")
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 54
tt.bullet.damage_min = 31
tt.bullet.hit_fx = "fx_bolt_high_elven_strong_hit"
tt.bullet.particles_name = "ps_bolt_high_elven"
tt.bullet.pop = {
	"pop_high_elven"
}
tt.bullet.pop_eldritch_mage_el_empowerment = {
	"pop_crit_high_elven"
}
tt.bullet.max_speed = 750
tt.initial_impulse = nil
tt.render.sprites[1].prefix = "bolt_high_elven_strong"
tt.sound_events.insert = "TowerHighMageBoltCast"
tt = E.register_t(E, "ray_high_elven_sentinel", "bullet")
tt.image_width = 72
tt.main_script.update = scripts2.ray_simple.update
tt.render.sprites[1].name = "ray_high_elven_sentinel"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.mod = "mod_ray_high_elven_sentinel_hit"
tt.bullet.damage_min = 25
tt.bullet.damage_max = 25
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.hit_time = fts(4)
tt.sound_events.insert = "TowerHighMageSentinelShot"
tt = E.register_t(E, "rock_1", "bomb")
tt.bullet.flight_time = fts(28)
tt.bullet.damage_radius = 60
tt.bullet.damage_max = 12
tt.bullet.damage_min = 7
tt.bullet.hit_fx = "fx_rock_explosion"
tt.bullet.hit_decal = "decal_rock_crater"
tt.bullet.pop = {
	"pop_artillery"
}
tt.render.sprites[1].name = "artillery_thrower_proy"
tt.sound_events.insert = "TowerStoneDruidBoulderThrow"
tt.sound_events.hit = "TowerStoneDruidBoulderExplote"
tt.sound_events.hit_water = "RTWaterExplosion"
tt = E.register_t(E, "rock_2", "rock_1")
tt.bullet.damage_max = 30
tt.bullet.damage_min = 18
tt = E.register_t(E, "rock_3", "rock_1")
tt.bullet.damage_max = 50
tt.bullet.damage_min = 30
tt = E.register_t(E, "rock_druid", "rock_1")

E.add_comps(E, tt, "tween")

tt.bullet.damage_max = 55
tt.bullet.damage_min = 35
tt.bullet.damage_radius = 50
tt.bullet.hit_decal = "decal_rock_crater"
tt.bullet.hit_fx = "fx_rock_explosion"
tt.bullet.flight_time = fts(35)
tt.bullet.pop = {
	"pop_druid_henge"
}
tt.render.sprites[1].prefix = "druid_stone%i"
tt.render.sprites[1].name = "load"
tt.render.sprites[1].animated = true
tt.render.sprites[1].sort_y_offset = -72
tt.sound_events.load = "TowerDruidHengeRockSummon"
tt.sound_events.hit = "TowerStoneDruidBoulderExplote"
tt.main_script.update = scripts2.rock_druid.update
tt.main_script.insert = nil
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].name = "offset"
tt.tween.props[1].keys = {
	{
		0,
		v(0, 0)
	},
	{
		0.8,
		v(0, 2)
	},
	{
		1.6,
		v(0, 0)
	}
}
tt.tween.props[1].loop = true
tt = E.register_t(E, "ray_druid_sylvan", "bullet")
tt.image_width = 42
tt.main_script.update = scripts2.ray_simple.update
tt.render.sprites[1].name = "ray_druid_sylvan"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.hit_time = fts(5)
tt.bullet.mod = "mod_druid_sylvan_affected"
tt.bullet.track_damage = true
tt = E.register_t(E, "rock_entwood", "rock_1")
tt.bullet.damage_max = 135
tt.bullet.damage_min = 90.9
tt.bullet.damage_radius = 55
tt.bullet.pop = {
	"pop_entwood"
}
tt.render.sprites[1].name = "artillery_tree_proys_0001"
tt.sound_events.insert = "TowerEntwoodCocoThrow"
tt.sound_events.hit = "TowerEntwoodCocoExplosion"
tt = E.register_t(E, "rock_firey_nut", "rock_entwood")
tt.bullet.damage_max = 150
tt.bullet.damage_max_inc = 0
tt.bullet.damage_min = 150
tt.bullet.damage_min_inc = tt.bullet.damage_max_inc
tt.bullet.damage_radius = 75
tt.bullet.hit_payload = "aura_fiery_nut"
tt.bullet.hit_fx = "fx_fiery_nut_explosion"
tt.bullet.hit_decal = nil
tt.render.sprites[1].name = "artillery_tree_proys_0002"
tt.sound_events.hit = "TowerEntwoodFieryExplote"
tt = E.register_t(E, "time_wizard_sandstorm", "rock_entwood")
tt.bullet.flight_time = fts(1)
tt.bullet.damage_max = 0
tt.bullet.damage_max_inc = 0
tt.bullet.damage_min = 0
tt.bullet.damage_min_inc = tt.bullet.damage_max_inc
tt.bullet.damage_radius = 75
tt.bullet.hit_payload = "aura_time_wizard_sandstorm"
tt.bullet.hit_fx = "fx_fiery_nut_explosion"
tt.bullet.hit_decal = nil
tt.render.sprites[1].name = "time_wizard_sandstorm_proj"
tt.sound_events.hit = "TowerEntwoodFieryExplote"
tt = E.register_t(E, "arrow_soldier_barrack_2", "arrow")
tt.bullet.damage_max = 7
tt.bullet.damage_min = 3
tt.bullet.flight_time = fts(3)
tt.bullet.reset_to_target_pos = true
tt = E.register_t(E, "arrow_soldier_barrack_3", "arrow_soldier_barrack_2")
tt.bullet.damage_max = 12
tt.bullet.damage_min = 8
tt = RT("spear_legionnaire", "arrow")
tt.bullet.damage_min = 24
tt.bullet.damage_max = 40
tt.bullet.flight_time = fts(20)
tt.bullet.miss_decal = "decal_spear"
tt.render.sprites[1].name = "spear"
tt.sound_events.insert = "AxeSound"
tt = RT("arrow_1", "arrow")
tt.bullet.damage_min = 4
tt.bullet.damage_max = 6
tt = RT("arrow_2", "arrow")
tt.bullet.damage_min = 7
tt.bullet.damage_max = 11
tt = RT("arrow_3", "arrow")
tt.bullet.damage_min = 10
tt.bullet.damage_max = 16
tt = RT("arrow_ranger", "arrow")
tt.bullet.damage_min = 13
tt.bullet.damage_max = 19
tt = RT("arrow_druid", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 125
tt.bullet.mod = "mod_thorn2"
tt.bullet.flight_time = fts(1)
tt.bullet.hit_fx = nil
tt.render.sprites[1].name = "bombs_8111"
tt.sound_events.hit_water = nil
tt.sound_events.insert = "ThornSound"
tt.sound_events.hit = "ThornSound"
tt = RT("arrow_druid_2", "bomb")
tt.bullet.damage_max = 100
tt.bullet.damage_min = 100
tt.bullet.damage_radius = 150
tt.bullet.mod = "mod_thorn3"
tt.bullet.flight_time = fts(1)
tt.bullet.hit_fx = nil
tt.render.sprites[1].name = "bombs_8111"
tt.sound_events.hit_water = nil
tt.sound_events.insert = "ThornSound"
tt.sound_events.hit = "ThornSound"
tt = RT("arrow_ranger_mod", "arrow")
tt.bullet.damage_min = 15
tt.bullet.damage_max = 21
tt.bullet.mod = "mod_ranger_poison_2"
tt = RT("mod_ranger_poison_2", "mod_poison")
tt.modifier.duration = 3.5
tt.dps.damage_max = 2
tt.dps.damage_min = 1
tt.dps.damage_every = 0.5
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)
tt = RT("axe_barbarian", "arrow")
tt.bullet.damage_min = 24
tt.bullet.damage_max = 32
tt.bullet.damage_inc = 16
tt.bullet.flight_time = fts(23)
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = "decal_axe"
tt.bullet.reset_to_target_pos = true
tt.main_script.insert = scripts.axe_barbarian.insert
tt.render.sprites[1].name = "barbarian_axe_0001"
tt.render.sprites[1].animated = false
tt.bullet.pop = nil
tt.sound_events.insert = "AxeSound"
tt = RT("arrow_elf", "arrow")
tt.bullet.damage_min = 25
tt.bullet.damage_max = 50
tt.bullet.flight_time = fts(15)
tt = RT("arrow_shadow_archer", "arrow")
tt.bullet.damage_min = 20
tt.bullet.damage_max = 30
tt = RT("arrow_hero_alleria", "arrow")
tt.bullet.xp_gain_factor = 2.875
tt.bullet.prediction_error = false
tt = E.register_t(E, "arrow_multishot_hero_alleria", "arrow")
tt.bullet.particles_name = "ps_arrow_multishot_hero_alleria"
tt.bullet.damage_min = 10
tt.bullet.damage_max = 15
tt.bullet.damage_true = DAMAGE_TRUE
tt.bullet.prediction_error = false
tt.extra_arrows_range = 100
tt.extra_arrows = 2
tt.main_script.insert = scripts.arrow_multishot_hero_alleria.insert
tt.render.sprites[1].name = "hero_archer_arrow"
tt = E.register_t(E, "arrow_hero_alleria_fixed", "arrow_hero_alleria")
tt.bullet.damage_min = 10
tt.bullet.damage_max = 30
tt.bullet.prediction_error = nil
tt = E.register_t(E, "arrow_multishot_hero_alleria_fixed", "arrow_multishot_hero_alleria")
tt.bullet.damage_min = 10
tt.bullet.damage_max = 30
tt.bullet.prediction_error = nil
tt.extra_arrows = 3
tt = RT("axe_troll_axe_thrower", "arrow")
tt.bullet.damage_min = 40
tt.bullet.damage_max = 80
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.flight_time = fts(23)
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = "troll_axethrower_proyectiles_0002"
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "troll_axethrower_proyectiles_0001"
tt.render.sprites[1].animated = false
tt.bullet.pop = nil
tt.sound_events.insert = "AxeSound"
tt = RT("ball_raider", "arrow")
tt.bullet.damage_min = 80
tt.bullet.damage_max = 120
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.flight_time = fts(23)
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = "RaiderBall_0002"
tt.bullet.reset_to_target_pos = true
tt.render.sprites[1].name = "RaiderBall_0001"
tt.render.sprites[1].animated = false
tt.bullet.pop = nil
tt.sound_events.insert = "AxeSound"
tt = RT("flare_flareon", "arrow")
tt.bullet.damage_max = 30
tt.bullet.damage_min = 20
tt.bullet.flight_time = fts(16)
tt.bullet.hit_blood_fx = nil
tt.bullet.miss_decal = nil
tt.bullet.miss_fx = "fx_explosion_flareon_flare"
tt.bullet.mod = "mod_flareon_burn"
tt.bullet.particles_name = "ps_flare_flareon"
tt.bullet.pop = nil
tt.render.sprites[1].name = "demon_flareon_flare"
tt.render.sprites[1].animated = true
tt = RT("bolt_1", "bolt")
tt.bullet.damage_min = 9
tt.bullet.damage_max = 17
tt = RT("bolt_2", "bolt")
tt.bullet.damage_min = 23
tt.bullet.damage_max = 43
tt = RT("bolt_3", "bolt")
tt.bullet.damage_min = 40
tt.bullet.damage_max = 74
tt = RT("bolt_3_golden", "bolt")
tt.bullet.damage_min = 20
tt.bullet.damage_max = 30
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt = RT("bolt_sorcerer", "bolt")
tt.bullet.damage_max = 78
tt.bullet.damage_min = 42
tt.bullet.hit_fx = "fx_bolt_sorcerer_hit"
tt.bullet.max_speed = 600
tt.bullet.mods = {
	"mod_sorcerer_curse_dps",
	"mod_sorcerer_curse_armor"
}
tt.bullet.particles_name = "ps_bolt_sorcerer"
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "bolt_sorcerer"
tt.sound_events.insert = "BoltSorcererSound"
tt = RT("bolt_time_wizard", "bolt")
tt.bullet.damage_max = 136
tt.bullet.damage_min = 74
tt.bullet.hit_fx = "fx_bolt_sorcerer_hit"
tt.bullet.max_speed = 550
tt.bullet.mods = {
	"mod_time_wizard_bolt_slow"
}
tt.bullet.particles_name = "ps_bolt_sorcerer"
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "bolt_time_wizard"
tt.sound_events.insert = "BoltSorcererSound"
tt = RT("bolt_sorcerer_cheat", "bolt")
tt.bullet.damage_max = 99
tt.bullet.damage_min = 66
tt.bullet.hit_fx = "fx_bolt_sorcerer_hit"
tt.bullet.max_speed = 600
tt.bullet.mods = {
	"mod_sorcerer_curse_dps",
	"mod_sorcerer_curse_armor",
	"mod_sorcerer"
}
tt.bullet.particles_name = "ps_bolt_sorcerer"
tt.bullet.pop = {
	"pop_zap_sorcerer"
}
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "bolt_sorcerer"
tt.sound_events.insert = "BoltSorcererSound"
tt = RT("mod_sorcerer", "modifier")
tt.chainlightning = {
	bullet = "bolt_sorcerer_fly",
	count = 2,
	damage = 0,
	damage_type = DAMAGE_MAGICAL,
	mod = "mod_sorcerer",
	offset = v(17, -1),
	chain_delay = fts(0),
	max_range = 200,
	min_range = 20
}
tt.main_script.update = scripts.mod_hero_thor_chainlightning.update
tt = RT("bolt_sorcerer_fly", "bolt")
tt.bullet.damage_min = 10
tt.bullet.damage_max = 20
tt.bullet.damage_radius = 33
tt.bullet.flight_time = fts(33)
tt.render.sprites[1].prefix = "bolt"
tt.render.sprites[1].anchor = v(0.4875, 0.4423076923076923)
tt.bullet.min_speed = 111
tt.bullet.max_speed = 333
tt.bullet.turn_speed = 10 * math.pi / 180 * 30
tt.bullet.acceleration_factor = 0.5
tt.bullet.particles_name = "ps_missile_none"
tt.bullet.retarget_range = 99999
tt.main_script.insert = scripts.missile.insert
tt.main_script.update = scripts.missile.update
tt = RT("bolt_necromancer", "bolt_enemy")
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 40
tt.bullet.damage_min = 20
tt.bullet.hit_fx = "fx_bolt_necromancer_hit"
tt.bullet.max_speed = 450
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "bolt_necromancer"
tt.sound_events.insert = "BoltSorcererSound"
tt = RT("bolt_witch", "bolt_enemy")
tt.bullet.damage_max = 60
tt.bullet.damage_min = 40
tt.bullet.hit_fx = "fx_bolt_witch_hit"
tt.bullet.min_speed = 450
tt.bullet.max_speed = 750
tt.bullet.mod = "mod_witch_frog"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].prefix = "bolt_witch"
tt.sound_events.insert = "kr4_tower_wickedsisters_attack_v1"
tt = E.register_t(E, "hammer_hero_thor", "bolt")
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 300
tt.bullet.max_speed = 900
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.hit_blood_fx = nil
tt.bullet.hit_fx = nil
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.mod = "mod_hero_thor_thunderclap"
tt.bullet.pop = nil
tt.render.sprites[1].prefix = "hammer_hero_thor"
tt.sound_events.insert = nil
tt = RT("bolt_elora_freeze", "bolt")
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.render.sprites[1].prefix = "bolt_elora"
tt.bullet.hit_fx = "fx_bolt_elora_hit"
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.mod = "mod_elora_bolt_freeze"
tt.bullet.damage_min = 14
tt.bullet.damage_max = 41
tt.bullet.xp_gain_factor = 2
tt = RT("bolt_elora_slow", "bolt_elora_freeze")
tt.bullet.mod = "mod_elora_bolt_slow"
tt = RT("bolt_magnus", "bolt")
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.render.sprites[1].prefix = "bolt_magnus"
tt.bullet.hit_fx = "fx_bolt_magnus_hit"
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.damage_min = 9
tt.bullet.damage_max = 27
tt.bullet.max_speed = 360
tt.bullet.xp_gain_factor = 2.1
tt = RT("bolt_cursed_shaman", "bolt")
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.render.sprites[1].prefix = "bolt_magnus"
tt.bullet.hit_fx = "fx_bolt_magnus_hit"
tt.bullet.pop = nil
tt.bullet.pop_conds = nil
tt.bullet.acceleration_factor = 0.1
tt.bullet.damage_min = 60
tt.bullet.damage_max = 50
tt.bullet.max_speed = 350
tt = RT("bolt_magnus_illusion", "bolt_magnus")
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.xp_gain_factor = nil
tt = RT("projectile_denas", "arrow")

AC(tt, "sound_events")

tt.bullet.flight_time = fts(20)
tt.bullet.rotation_speed = (FPS*15*math.pi)/180
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.damage_min = 11
tt.bullet.damage_max = 19
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_decal = nil
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.track_kills = true
tt.bullet.xp_gain_factor = 2.42
tt.render.sprites[1].name = "hero_king_projectiles_0001"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "AxeSound"
tt = RT("projectile_denas_barrell", "projectile_denas")
tt.render.sprites[1].name = "hero_king_projectiles_0002"
tt = RT("projectile_denas_chicken", "projectile_denas")
tt.render.sprites[1].name = "hero_king_projectiles_0003"
tt = RT("projectile_denas_bottle", "projectile_denas")
tt.render.sprites[1].name = "hero_king_projectiles_0004"
tt = RT("projectile_denas_melee", "projectile_denas")
tt.bullet.flight_time = fts(13)
tt = RT("projectile_denas_melee_barrell", "projectile_denas_barrell")
tt.bullet.flight_time = fts(13)
tt = RT("projectile_denas_melee_chicken", "projectile_denas_chicken")
tt.bullet.flight_time = fts(13)
tt = RT("projectile_denas_melee_bottle", "projectile_denas_bottle")
tt.bullet.flight_time = fts(13)
tt = RT("bomb_musketeer", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_max_inc = 40
tt.bullet.damage_min = 0
tt.bullet.damage_min_inc = 10
tt.bullet.damage_radius = 48
tt.bullet.flight_time_min = fts(4)
tt.bullet.flight_time_max = fts(8)
tt.bullet.hit_fx = "fx_explosion_shrapnel"
tt.bullet.pop = nil
tt.render.sprites[1].name = "bombs_0007"
tt.sound_events.insert = "ShrapnelSound"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt = RT("bomb_bfg", "bomb")
tt.bullet.damage_max = 132
tt.bullet.damage_min = 66
tt.bullet.damage_radius = 85
tt.bullet.flight_time = fts(35)
tt.bullet.hit_fx = "fx_explosion_big"
tt.render.sprites[1].name = "bombs_0005"
tt.sound_events.hit_water = nil
tt = RT("bomb_bfg_cluster", "bullet")

AC(tt, "sound_events")

tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.flight_time = fts(29)
tt.bullet.fragment_count = 1
tt.bullet.fragment_name = "bomb_bfg_fragment"
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = "fx_explosion_air"
tt.bullet.rotation_speed = (FPS*20*math.pi)/180
tt.bullet.fragment_node_spread = 5
tt.bullet.fragment_pos_spread = v(6, 6)
tt.bullet.dest_pos_offset = v(0, 85)
tt.bullet.dest_prediction_time = 1
tt.main_script.insert = scripts.bomb_cluster.insert
tt.main_script.update = scripts.bomb_cluster.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "bombs_0005"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.insert = "BombShootSound"
tt = RT("bomb_bfg_fragment", "bomb")
tt.bullet.damage_max = 50
tt.bullet.damage_min = 50
tt.bullet.damage_inc = 25
tt.bullet.damage_radius = 60
tt.bullet.flight_time = fts(10)
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = nil
tt.render.sprites[1].name = "bombs_0006"
tt.sound_events.hit_water = nil
tt = RT("bomb_goblin_zapper", "bomb")
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 60
tt.bullet.damage_min = 30
tt.bullet.damage_radius = 67.5
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.flight_time = fts(25)
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = {
	"pop_kboom"
}
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.render.sprites[1].name = "zapperbomb"
tt.sound_events.insert = nil
tt.sound_events.hit = "BombExplosionSound"
tt = RT("bomb_goblin_zapper2", "bomb")
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 60
tt.bullet.damage_min = 30
tt.bullet.damage_radius = 67.5
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.flight_time = fts(25)
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = {
	"pop_kboom"
}
tt.render.sprites[1].name = "zapperbomb"
tt.sound_events.insert = nil
tt.sound_events.hit = "BombExplosionSound"
tt = RT("bomb_swamp_thing", "bomb")
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 100
tt.bullet.damage_min = 40
tt.bullet.damage_radius = 67.5
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.flight_time = fts(25)
tt.bullet.hit_fx = "fx_explosion_rotten_shot"
tt.bullet.hit_decal = nil
tt.bullet.pop = nil
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.render.sprites[1].name = "Proyectile_RottenShot"
tt.sound_events.insert = "swamp_thing_bomb_shot"
tt.sound_events.hit = "swamp_thing_bomb_explosion"
tt = RT("bomb_swamp_thing_soldier", "bomb")
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 100
tt.bullet.damage_min = 40
tt.bullet.damage_radius = 67.5
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.flight_time = fts(25)
tt.bullet.hit_fx = "fx_explosion_rotten_shot"
tt.bullet.hit_decal = nil
tt.bullet.pop = nil
tt.render.sprites[1].name = "Proyectile_RottenShot"
tt.sound_events.insert = "swamp_thing_bomb_shot"
tt.sound_events.hit = "swamp_thing_bomb_explosion"
tt = RT("bomb_juggernaut", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 1
tt.bullet.flight_time_base = fts(45)
tt.bullet.flight_time_factor = fts(0.025)
tt.bullet.pop = nil
tt.bullet.hit_payload = "juggernaut_bomb_spawner"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.bullet.hit_fx = nil
tt.render.sprites[1].name = "bossJuggernaut_bomb_"
tt.sound_events.hit = "BombExplosionSound"
tt = RT("bomb_greenmuck", "bomb")
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.damage_max = 160
tt.bullet.damage_min = 80
tt.bullet.damage_radius = 47.25
tt.bullet.flight_time_base = fts(17)
tt.bullet.flight_time_factor = fts(0.07142857142857142)
tt.bullet.hit_fx = "fx_explosion_rotten_shot"
tt.bullet.hit_decal = nil
tt.bullet.pop = nil
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.render.sprites[1].name = "Proyectile_RottenBoss"
tt.sound_events.hit = "swamp_thing_bomb_explosion"
tt = RT("bomb_tar_bolin", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 1
tt.bullet.flight_time_base = fts(34)
tt.bullet.flight_time_factor = fts(0.016666666666666666)
tt.bullet.pop = nil
tt.bullet.hit_payload = "aura_bolin_tar"
tt.main_script.insert = scripts.bomb.insert
tt.main_script.update = scripts.bomb.update
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.hide_radius = nil
tt.render.sprites[1].name = "hero_artillery_brea_shot"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "HeroRiflemanBrea"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt = RT("bomb_mine_bolin", "bomb")
tt.bullet.damage_bans = F_ALL
tt.bullet.damage_flags = 0
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 55
tt.bullet.flight_time = fts(24)
tt.bullet.pop = nil
tt.bullet.hit_payload = "decal_bolin_mine"
tt.main_script.insert = scripts.bomb.insert
tt.main_script.update = scripts.bomb.update
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.hide_radius = nil
tt.render.sprites[1].name = "hero_artillery_mine_proy"
tt.render.sprites[1].animated = false
tt.sound_events.insert = "HeroRiflemanMine"
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt = E.register_t(E, "denas_catapult_rock", "bomb")
tt.bullet.flight_time = fts(45)
tt.bullet.damage_radius = 55
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.g = (fts(1)*fts(1))/-0.8
tt.bullet.particles_name = "ps_power_fireball"
tt.render.sprites[1].name = "hero_king_catapultProjectile"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.sound_events.insert = nil
tt = RT("missile_bfg", "bullet")
tt.render.sprites[1].prefix = "missile_bfg"
tt.render.sprites[1].loop = true
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.min_speed = 300
tt.bullet.max_speed = 450
tt.bullet.turn_speed = (math.pi*10)/180*30
tt.bullet.acceleration_factor = 0.1
tt.bullet.hit_fx = "fx_explosion_air"
tt.bullet.hit_fx_air = "fx_explosion_air"
tt.bullet.damage_min = 50
tt.bullet.damage_max = 100
tt.bullet.damage_radius = 65
tt.bullet.vis_flags = F_RANGED
tt.bullet.damage_flags = F_AREA
tt.bullet.particles_name = "ps_missile"
tt.bullet.retarget_range = 1e+99
tt.main_script.insert = scripts.missile.insert
tt.main_script.update = scripts.missile.update
tt.sound_events.insert = "RocketLaunchSound"
tt.sound_events.hit = "BombExplosionSound"
tt = RT("missile_juggernaut", "bullet")
tt.bullet.acceleration_factor = 0.1
tt.bullet.damage_bans = bor(F_ENEMY, F_BOSS)
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_max = 250
tt.bullet.damage_min = 150
tt.bullet.damage_radius = 41.25
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.hit_fx = "fx_explosion_air"
tt.bullet.hit_fx_air = "fx_explosion_air"
tt.bullet.max_speed = 450
tt.bullet.min_speed = 300
tt.bullet.particles_name = "ps_missile"
tt.bullet.retarget_range = 99999
tt.bullet.rot_dir_from_long_angle = true
tt.bullet.turn_speed = (math.pi*10)/180*30
tt.bullet.vis_bans = bor(F_ENEMY)
tt.bullet.vis_flags = F_RANGED
tt.main_script.update = scripts.enemy_missile.update
tt.render.sprites[1].prefix = "missile_bfg"
tt.render.sprites[1].name = "flying"
tt.sound_events.insert = "RocketLaunchSound"
tt.sound_events.hit = "BombExplosionSound"
tt = RT("ray_arcane", "bullet")
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.mod = "mod_ray_arcane"
tt.bullet.hit_time = 0
tt.image_width = 150
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_arcane"
tt.render.sprites[1].loop = true
tt.sound_events.insert = "ArcaneRaySound"
tt.track_target = true
tt.ray_duration = fts(10)
tt = RT("ray_arcane_disintegrate", "ray_arcane")
tt.bullet.mod = "mod_ray_arcane_disintegrate"
tt.image_width = 166
tt.render.sprites[1].name = "ray_arcane_disintegrate"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "DesintegrateSound"
tt = RT("ray_sorcerer_polymorph", "bullet")
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_time = fts(3)
tt.bullet.mod = "mod_polymorph_sorcerer"
tt.image_width = 130
tt.main_script.update = scripts.ray_simple.update
tt.ray_duration = fts(10)
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "ray_sorcerer_polymorph"
tt.sound_events.insert = "PolymorphSound"
tt.track_target = true
tt = RT("ray_tesla", "bullet")
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_tesla"
tt.bounces = nil
tt.bounces_lvl = {
	[0] = 2,
	3,
	4,
	5
}
tt.bounce_range = 95
tt.bounce_vis_flags = F_RANGED
tt.bounce_vis_bans = 0
tt.bounce_damage_min = 60
tt.bounce_damage_max = 110
tt.bounce_damage_factor = 1
tt.bounce_damage_factor_min = 0.5
tt.bounce_damage_factor_inc = -0.1
tt.bounce_delay = fts(2)
tt.bounce_scale_y = 1
tt.bounce_scale_y_factor = 0.88
tt.excluded_templates = {
	"enemy_spectral_knight"
}
tt.image_width = 106
tt.seen_targets = {}
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_tesla"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt.main_script.update = scripts.ray_tesla.update
tt = RT("ray_ArchImage", "bullet")
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_tesla2"
tt.bounces = 8
tt.bounces_lvl = 8
tt.bounce_range = 128
tt.bounce_vis_flags = F_RANGED
tt.bounce_vis_bans = 0
tt.bounce_damage_min = 50
tt.bounce_damage_max = 150
tt.bounce_damage_factor = 0.75
tt.bounce_damage_factor_min = 0.75
tt.bounce_damage_factor_inc = 0
tt.bounce_delay = fts(2)
tt.bounce_scale_y = 1
tt.bounce_scale_y_factor = 0.88
tt.excluded_templates = {
	"enemy_spectral_knight"
}
tt.image_width = 106
tt.seen_targets = {}
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_tesla"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt.main_script.update = scripts.ray_tesla.update
tt = RT("ray_sunray", "bullet")
tt.bullet.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_TRUE)
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_sunray_hit"
tt.bullet.damage_max = 75
tt.bullet.damage_min = 25
tt.bullet.damage_inc = 50
tt.image_width = 82
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_sunray"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "PolymorphSound"
tt.track_target = true
tt.ray_duration = fts(9)
tt.ray_y_scales = {
	0.4,
	0.6,
	0.8,
	1
}
tt = RT("ray_sunray_mini", "bullet")
tt.bullet.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_TRUE)
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_sunray_hit"
tt.bullet.damage_max = 75
tt.bullet.damage_min = 25
tt.bullet.damage_inc = 100
tt.image_width = 82
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_sunray"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "PolymorphSound"
tt.track_target = true
tt.ray_duration = fts(9)
tt.ray_y_scales = {
	0.4,
	0.6,
	0.8,
	1
}
tt = RT("ray_sunray2", "bullet")
tt.bullet.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_TRUE)
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_sunray_hit"
tt.bullet.damage_max = 75
tt.bullet.damage_min = 25
tt.bullet.damage_inc = 50
tt.image_width = 82
tt.bullet.hit_fx = "NG_tower"
tt.main_script.update = scripts.ray_simple.update
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_sunray"
tt.render.sprites[1].loop = false
tt.sound_events.insert = "PolymorphSound"
tt.track_target = true
tt.ray_duration = fts(9)
tt.ray_y_scales = {
	0.4,
	0.6,
	0.8,
	1
}
tt = RT("ray_hero_thor", "ray_tesla")
tt.bullet.mod = "mod_ray_hero_thor"
tt.render.sprites[1].name = "ray_hero_thor"
tt.main_script.update = scripts.ray_thor.update
tt = RT("shotgun_musketeer", "shotgun")
tt.bullet.damage_max = 65
tt.bullet.damage_min = 45
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.start_fx = "fx_rifle_smoke"
tt.bullet.min_speed = FPS*20
tt.bullet.max_speed = FPS*20
tt.sound_events.insert = "ShotgunSound"
tt = RT("shotgun_musketeer_sniper", "shotgun_musketeer")
tt.bullet.particles_name = "ps_shotgun_musketeer"
tt.sound_events.insert = "SniperSound"
tt.bullet.damage_type = bor(DAMAGE_PHYSICAL, DAMAGE_FX_EXPLODE)
tt.bullet.pop = nil
tt.bullet.ignore_upgrades = true
tt = RT("shotgun_musketeer_sniper_instakill", "shotgun_musketeer_sniper")
tt.bullet.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_EXPLODE)
tt.bullet.pop = {
	"pop_headshot"
}
tt = RT("shotgun_bolin", "shotgun")
tt.bullet.damage_max = 65
tt.bullet.damage_min = 45
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.start_fx = nil
tt.bullet.min_speed = FPS*20
tt.bullet.max_speed = FPS*20
tt.bullet.xp_gain_factor = 3
tt.sound_events.insert = "ShotgunSound"
tt = E.register_t(E, "enemy_spider_egg", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "enemy_spider_egg"
tt.render.sprites[1].loop = false
tt.spawner.count = 3
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_spider_tiny"
tt.spawner.node_offset = 5
tt.spawner.pos_offset = v(0, 1)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = false
tt.spawner.animation_start = "start"
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		4,
		0
	}
}
tt.tween.remove = true
tt = E.register_t(E, "enemy_spider_rotten_egg", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "enemy_spider_rotten_egg"
tt.render.sprites[1].loop = false
tt.spawner.count = 3
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_spider_rotten_tiny"
tt.spawner.node_offset = 5
tt.spawner.pos_offset = v(0, 1)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = false
tt.spawner.animation_start = "start"
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		4,
		0
	}
}
tt.tween.remove = true
tt = RT("juggernaut_bomb_spawner", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "bomb_juggernaut_spawner"
tt.render.sprites[1].loop = false
tt.spawner.animation_concurrent = "open"
tt.spawner.count = 7
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_golem_head"
tt.spawner.keep_gold = true
tt.spawner.node_offset = 2
tt.spawner.pos_offset = v(0, 0)
tt.spawner.allowed_subpaths = {
	1,
	2,
	3
}
tt.spawner.random_subpath = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		4,
		0
	}
}
tt.tween.remove = true
tt = E.register_t(E, "myconid_spawner")

E.add_comps(E, tt, "pos", "spawner", "main_script")

tt.main_script.update = scripts.enemies_spawner.update
tt.spawner.count = 2
tt.spawner.random_cycle = {
	0,
	1
}
tt.spawner.entity = "enemy_rotten_lesser"
tt.spawner.random_node_offset_range = {
	-2,
	9
}
tt.spawner.random_subpath = true
tt.spawner.initial_spawn_animation = "raise"
tt.spawner.spawn_sound = "EnemyMushroomBorn"
tt.spawner.spawn_sound_args = {
	delay = fts(29)
}
tt.spawner.check_node_valid = true
tt.spawner.use_node_pos = true
tt = RT("elora_ice_spike", "bullet")
tt.main_script.update = scripts.elora_ice_spike.update
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 51.2
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = F_FRIEND
tt.bullet.mod = nil
tt.bullet.hit_time = 0.1
tt.bullet.duration = 2
tt.spike_1_anchor_y = 0.16
tt.render.sprites[1].prefix = "elora_ice_spike_"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = 0.2
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_frost_spikes_decal"
tt.render.sprites[2].z = Z_DECALS
tt.sound_events.delayed_insert = "HeroFrostIceRainDrop"
tt.sound_events.ice_break = "HeroFrostIceRainBreak"
tt = RT("decal_bolin_mine", "decal_scripted")
tt.check_interval = fts(3)
tt.damage_max = nil
tt.damage_min = nil
tt.damage_type = DAMAGE_EXPLOSION
tt.duration = 180
tt.hit_decal = "decal_bomb_crater"
tt.hit_fx = "fx_explosion_fragment"
tt.main_script.update = scripts.decal_bolin_mine.update
tt.radius = 55
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "decal_bolin_mine"
tt.render.sprites[1].z = Z_DECALS
tt.sound = "BombExplosionSound"
tt.vis_bans = bor(F_FRIEND, F_FLYING)
tt.vis_flags = bor(F_ENEMY)
tt = E.register_t(E, "hacksaw_sawblade", "bullet")
tt.main_script.update = scripts.hacksaw_sawblade.update
tt.bullet.particles_name = "ps_hacksaw_sawblade"
tt.bullet.acceleration_factor = 0.05
tt.bullet.min_speed = 390
tt.bullet.max_speed = 390
tt.bullet.vis_flags = F_RANGED
tt.bullet.vis_bans = 0
tt.bullet.damage_min = 45
tt.bullet.damage_max = 45
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_hacksaw_sawblade_hit"
tt.bullet.max_speed = 390
tt.bullet.damage_type = DAMAGE_TRUE
tt.bounces_max = nil
tt.bounce_range = 150
tt.render.sprites[1].prefix = "hacksaw_sawblade"
tt.sound_events.insert = "HeroAlienDiscoThrow"
tt.sound_events.bounce = "HeroAlienDiscoBounce"
tt = E.register_t(E, "aura_arcane_burst", "aura")

E.add_comps(E, tt, "render")

tt.aura.damage_inc = 80
tt.aura.damage_type = DAMAGE_MAGICAL
tt.aura.radius = 57.5
tt.main_script.update = scripts2.aura_arcane_burst.update
tt.render.sprites[1].anchor.y = 0.2916666666666667
tt.render.sprites[1].name = "arcane_burst_explosion"
tt.render.sprites[1].sort_y_offset = -7
tt.render.sprites[1].z = Z_EFFECTS
tt.sound_events.insert = "TowerArcaneExplotion"
tt = E.register_t(E, "aura_fiery_nut", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.3
tt.aura.duration = 6
tt.aura.mod = "mod_fiery_nut"
tt.aura.radius = 75
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts2.aura_apply_mod.update
tt.render.sprites[1].name = "decal_fiery_nut_scorched"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}
tt = E.register_t(E, "aura_time_wizard_sandstorm", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.3
tt.aura.duration = 5
tt.aura.mods = { "mod_sandstorm_slow", "mod_sandstormtw" }
tt.aura.radius = 80
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_MOD)
tt.main_script.insert = scripts2.aura_apply_mod.insert
tt.main_script.update = scripts.aura_slow_bolin.update
tt.main_script.update = scripts2.aura_apply_mod.update
tt.render.sprites[1].name = "decal_sandstormtw"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].scale = v(1.25, 1.25)
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		"this.aura.duration-1",
		255
	},
	{
		"this.aura.duration",
		0
	}
}
tt = E.register_t(E, "mod_blood_elves", "mod_blood")
tt.modifier.allows_duplicates = true
tt.modifier.max_of_same = 5
tt.modifier.source_damage = nil
tt.modifier.type = MOD_TYPE_BLEED
tt.chance = 0.15
tt.damage_factor = 0.1
tt.dps.damage_every = fts(4)
tt.dps.damage_inc = 0
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.fx_every = fts(12)
tt.main_script.insert = scripts2.mod_blood_elves.insert
tt = E.register_t(E, "mod_timelapse", "modifier")

E.add_comps(E, tt, "render", "tween")

tt.modifier.remove_banned = true
tt.modifier.bans = {
	"mod_faerie_dragon_l0",
	"mod_faerie_dragon_l1",
	"mod_faerie_dragon_l2",
	"mod_arivan_freeze",
	"mod_arivan_ultimate_freeze",
	"mod_crystal_arcane_freeze",
	"mod_blood_elves",
	"mod_bruce_sharp_claws",
	"mod_lynn_ultimate",
	"mod_ogre_magi_shield",
	"aura_ranger_thorn"
}
tt.modifier.type = MOD_TYPE_TIMELAPSE
tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.vis_bans = F_BOSS
tt.render.sprites[1].prefix = "mod_timelapse"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].sort_y_offset = -1
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "mage_highElven_energyBall_shadow"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].anchor.y = 0.16666666666666666
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		0
	},
	{
		fts(15),
		255
	}
}
tt.tween.props[1].sprite_id = 2
tt.main_script.queue = scripts2.mod_timelapse.queue
tt.main_script.dequeue = scripts2.mod_timelapse.dequeue
tt.main_script.update = scripts2.mod_timelapse.update
tt.main_script.insert = scripts2.mod_timelapse.insert
tt.main_script.remove = scripts2.mod_timelapse.remove
tt.damage_levels = {
	100,
	200,
	300
}
tt.damage_type = bor(DAMAGE_TRUE)
tt.modifier.duration = 5
tt = E.register_t(E, "timelapse_enemy_decal", "decal_tween")
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.13,
		0
	}
}
tt = E.register_t(E, "mod_ray_high_elven_sentinel_hit", "mod_track_target_fx")
tt.render.sprites[1].name = "fx_ray_high_elven_sentinel_hit"
tt.render.sprites[1].loop = false
tt.render.sprites[1].hide_after_runs = 1
tt.modifier.duration = fts(11)
tt = E.register_t(E, "mod_druid_sylvan", "modifier")

E.add_comps(E, tt, "render", "tween")

tt.render.sprites[1].name = "artillery_henge_curse_decal"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].animated = false
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "mod_druid_sylvan"
tt.render.sprites[2].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[2].name = "small"
tt.render.sprites[2].draw_order = 2
tt.modifier.duration = 10
tt.attack = E.clone_c(E, "bullet_attack")
tt.attack.max_range = 120
tt.attack.bullet = "ray_druid_sylvan"
tt.attack.damage_factor = {
	0.35,
	0.7,
	1
}
tt.ray_cooldown = fts(15)
tt.main_script.update = scripts2.mod_druid_sylvan.update
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.5,
		v(0.9, 0.9)
	},
	{
		1,
		v(1, 1)
	}
}
tt.tween.props[1].loop = true
tt = E.register_t(E, "mod_druid_sylvan_affected", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = fts(18)
tt.render.sprites[1].prefix = "mod_druid_sylvan_affected"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts2.mod_track_target.insert
tt.main_script.update = scripts2.mod_track_target.update
tt = E.register_t(E, "mod_fiery_nut", "modifier")

E.add_comps(E, tt, "dps", "render")

tt.dps.damage_min = 0
tt.dps.damage_max = 0
tt.dps.damage_inc = 3
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = fts(3)
tt.dps.kill = true
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dps.update
tt.modifier.duration = 2
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].draw_order = 10
tt = E.register_t(E, "mod_sandstormtw", "modifier")

E.add_comps(E, tt, "dps", "render")
tt.dps.damage_min = 10
tt.dps.damage_max = 10
tt.dps.damage_inc = 10
tt.dps.damage_type = DAMAGE_MAGICAL
tt.dps.damage_every = fts(1)
tt.dps.kill = true
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dps.update
tt.modifier.duration = 1
tt.render.sprites[1].prefix = "sandstormws"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].draw_order = 10
tt = E.register_t(E, "mod_clobber", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts2.mod_stun.insert
tt.main_script.update = scripts2.mod_stun.update
tt.main_script.remove = scripts2.mod_stun.remove
tt.render.sprites[1].prefix = "stun"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 10

tt = RT("aura_ranger_thorn", "aura")
tt.aura.mod = "mod_thorn"
tt.aura.duration = -1
tt.aura.radius = 200
tt.aura.vis_flags = bor(F_THORN, F_MOD)
tt.aura.vis_bans = bor(F_FLYING, F_BOSS)
tt.aura.cooldown = fts(34) + 8
tt.aura.max_times = 3
tt.aura.max_count = 2
tt.aura.max_count_inc = 2
tt.aura.min_count = 2
tt.aura.owner_animation = "shoot"
tt.aura.owner_sid = 5
tt.aura.hit_time = fts(17)
tt.aura.hit_sound = "ThornSound"
tt.main_script.update = scripts.aura_ranger_thorn.update
tt = RT("aura_teleport_arcane", "aura")

AC(tt, "render")

tt.aura.mod = "mod_teleport_arcane"
tt.aura.duration = fts(23)
tt.aura.apply_delay = fts(5)
tt.aura.apply_duration = fts(10)
tt.aura.max_count = 4
tt.aura.cycle_time = fts(2)
tt.aura.radius = 32.5
tt.aura.vis_flags = bor(F_RANGED, F_MOD, F_TELEPORT)
tt.aura.vis_bans = bor(F_BOSS, F_FRIEND, F_HERO, F_FREEZE)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].name = "aura_teleport_arcane"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor.y = 0.375
tt.sound_events.insert = "TeleporthSound"
tt = RT("aura_tesla_overcharge", "aura")
tt.aura.duration = fts(22)
tt.aura.mod = "mod_tesla_overcharge"
tt.aura.radius = 165
tt.aura.damage_min = 0
tt.aura.damage_max = 10
tt.aura.damage_inc = 10
tt.aura.damage_type = DAMAGE_ELECTRICAL
tt.aura.excluded_templates = {
	"enemy_spectral_knight"
}
tt.main_script.update = scripts.aura_tesla_overcharge.update
tt.particles_name = "ps_tesla_overcharge"
tt = E.register_t(E, "mod_shocking_impact", "mod_slow")
tt.modifier.duration = 0.5
tt.slow.factor = 0.5
for _, n in pairs({
	"blade",
	"forest",
	"drow"
}) do
	tt = E.register_t(E, "mod_moon_forged_blades_" .. n, "mod_damage")
	tt.damage_max = math.ceil(E.get_template(E, "soldier_" .. n).melee.attacks[1].damage_min*0.15)
	tt.damage_min = math.ceil(E.get_template(E, "soldier_" .. n).melee.attacks[1].damage_max*0.15)
	tt.damage_type = DAMAGE_MAGICAL
end
tt = E.register_t(E, "mod_arrow_arcane", "mod_damage")
tt.damage_min = 0.05
tt.damage_max = 0.1
tt.damage_type = DAMAGE_MAGICAL_ARMOR
tt = E.register_t(E, "mod_arrow_arcane_slumber", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts2.mod_arrow_arcane_slumber.insert
tt.main_script.update = scripts2.mod_stun.update
tt.main_script.remove = scripts2.mod_stun.remove
tt.sound_events.insert = "TowerArcaneWaterEnergyBlast"
tt.modifier.duration = 4
tt.render.sprites[1].prefix = "arcane_slumber_bubbles"
tt.render.sprites[1].loop = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "arcane_slumber_z"
tt.render.sprites[2].loop = true
tt = E.register_t(E, "mod_arrow_silver_mark", "modifier")

E.add_comps(E, tt, "tween", "render", "sound_events", "count_group")

tt.count_group.name = "mod_arrow_silver_mark"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.received_damage_factor = 2
tt.main_script.insert = scripts2.mod_arrow_silver_mark.insert
tt.main_script.update = scripts2.mod_arrow_silver_mark.update
tt.main_script.remove = scripts2.mod_arrow_silver_mark.remove
tt.modifier.durations = {
	4,
	7,
	10
}
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "archer_silver_mark_effect_below"
tt.render.sprites[1].sort_y_offset = 1
tt.render.sprites[1].anchor.y = 0.08823529411764706
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_silver_mark_effect_over"
tt.render.sprites[2].anchor.y = 0.08823529411764706
tt.render.sprites[2].sort_y_offset = -1
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(6),
		v(0.87, 1)
	},
	{
		fts(11),
		v(1, 1)
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[1].loop = true
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].disabled = true
tt.tween.props[3].sprite_id = 1
tt.tween.props[3].keys = {
	{
		0,
		255
	},
	{
		0.25,
		0
	}
}
tt.tween.props[4] = table.deepclone(tt.tween.props[3])
tt.tween.props[4].sprite_id = 1
tt.sound_events.insert = "TowerGoldenBowFlareHit"
tt = E.register_t(E, "mod_eldritch", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].name = "mod_eldritch"
tt.render.sprites[1].sort_y_offset = -1
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts2.mod_eldritch.update
tt.modifier.remove_banned = true
tt.modifier.bans = {
	"mod_faerie_dragon_l0",
	"mod_faerie_dragon_l1",
	"mod_faerie_dragon_l2",
	"mod_arivan_freeze",
	"mod_arivan_ultimate_freeze",
	"mod_crystal_arcane_freeze",
	"mod_crystal_unstable_teleport",
	"mod_metropolis_portal",
	"mod_teleport_mage",
	"mod_teleport_wild_magus",
	"mod_teleport_high_elven",
	"mod_teleport_faustus",
	"mod_pixie_teleport",
	"mod_teleport_scroll",
	"mod_teleport_ainyl",
	"mod_twilight_avenger_last_service",
	"mod_lynn_ultimate",
	"mod_shield_ainyl"
}
tt.modifier.vis_flags = bor(F_MOD, F_EAT)
tt.damage_levels = {
	50,
	200,
	300
}
tt.damage_radius = 95
tt.damage_flags = F_RANGED
tt.damage_bans = 0
tt.damage_type = DAMAGE_MAGICAL
tt.sound_events.loop = "TowerWildMagusDoomLoop"
tt = E.register_t(E, "eldritch_enemy_decal", "decal_tween")
tt.tween.disabled = true
tt.tween.remove = true
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {}

for i, s in ipairs({
	1.06,
	1.02,
	1.11,
	1.05,
	1.14,
	1.08,
	1.116,
	1.1,
	1.18,
	1.13,
	1.24
}) do
	tt.tween.props[1].keys[i] = {
		(i - 1)*fts(2),
		v(s, s)
	}
end

tt = E.register_t(E, "mod_ward", "modifier")

E.add_comps(E, tt, "render", "tween")

tt.main_script.insert = scripts2.mod_silence.insert
tt.main_script.remove = scripts2.mod_silence.remove
tt.main_script.update = scripts2.mod_track_target.update
tt.modifier.duration = 10
tt.modifier.use_mod_offset = false
tt.modifier.remove_banned = true
tt.modifier.bans = {
	"mod_shaman_heal",
	"mod_troll_rage",
	"mod_troll_heal",
	"mod_rocketeer_speed_buff",
	"mod_demon_shield",
	"mod_spectral_knight",
	"mod_lycanthropy"
}
tt.render.sprites[1].name = "mage_wild_silence_fx"
tt.render.sprites[1].animated = false
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "mod_ward_decal"
tt.render.sprites[2].animated = true
tt.render.sprites[2].scale = v(1, 0.4)
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "mage_wild_silence_decal_glow"
tt.render.sprites[3].animated = false
tt.render.sprites[3].z = Z_DECALS
tt.tween.remove = false
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.25,
		255
	},
	{
		tt.modifier.duration - 0.25,
		255
	},
	{
		tt.modifier.duration,
		0
	}
}
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = table.deepclone(tt.tween.props[1])
tt.tween.props[3].sprite_id = 3
tt.custom_offsets = {
	default = v(0, 40),
    enemy_shaman = v(0, 39),
	enemy_troll_chieftain = v(0, 55),
	enemy_necromancer = v(0, 41),
	enemy_demon_legion = v(0, 47),
	enemy_fallen_knight = v(0, 55),
	enemy_witch = v(0, 39)
}
tt = E.register_t(E, "mod_ArchImage_slow", "mod_slow")
tt.modifier.duration = 9e+99
tt.slow.factor = 0.7
tt = RT("mod_ArchImage_damage", "mod_lava")
tt.dps.damage_min = 1
tt.dps.damage_max = 1
tt.dps.damage_every = 0.1
tt.modifier.duration = 9e+99
tt.render.sprites[1].prefix = "mod_tesla_hit"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].loop = true
tt = RT("aura_ArcHImage_overcharge", "aura")
tt.aura.duration = fts(22)
tt.aura.mod = "mod_ArchImage_damage"
tt.aura.radius = 178
tt.aura.damage_min = 50
tt.aura.damage_max = 100
tt.aura.damage_inc = 10
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.excluded_templates = {
	"enemy_spectral_knight"
}
tt.main_script.update = scripts.aura_tesla_overcharge.update
tt.particles_name = "ps_tesla_overcharge"
tt = RT("aura_malik_fissure", "aura")
tt.aura.fx = "decal_malik_earthquake"
tt.aura.damage_radius = 80
tt.aura.damage_types = {
	DAMAGE_TRUE,
	DAMAGE_PHYSICAL
}
tt.aura.vis_flags = bor(F_RANGED)
tt.aura.spread_delay = fts(4)
tt.aura.spread_nodes = 4
tt.main_script.update = scripts.aura_malik_fissure.update
tt.stun = {
	vis_flags = bor(F_RANGED, F_STUN),
	vis_bans = bor(F_FLYING, F_BOSS),
	mod = "mod_malik_stun"
}
tt = RT("aura_chill_elora", "aura")

AC(tt, "render", "tween")

tt.aura.cycle_time = fts(10)
tt.aura.duration = 3
tt.aura.mod = "mod_elora_chill"
tt.aura.radius = 44.800000000000004
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_ENEMY)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_chill_elora.update
tt.render.sprites[1].prefix = "decal_elora_chill_"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.remove = true
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.2,
		0
	}
}
tt = RT("aura_bolin_tar", "aura")

AC(tt, "render", "tween")

tt.aura.cycle_time = fts(10)
tt.aura.duration = 4
tt.aura.mod = "mod_bolin_slow"
tt.aura.radius = 47.5
tt.aura.vis_bans = bor(F_FRIEND, F_FLYING)
tt.aura.vis_flags = bor(F_ENEMY)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_slow_bolin.update
tt.render.sprites[1].prefix = "decal_bolin_tar"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.remove = true
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.3,
		0
	}
}
tt = RT("denas_buff_aura", "aura")

AC(tt, "main_script", "render", "tween")

tt.aura.duration = 1.63
tt.entity = "denas_buffing_circle"
tt.main_script.update = scripts.denas_buff_aura.update
tt.render.sprites[1].name = "hero_king_glowShadow"
tt.render.sprites[1].anchor = v(0.5, 0.26)
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.tween.disabled = true
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.13,
		255
	},
	{
		1.63,
		255
	},
	{
		2.76,
		0
	}
}
tt.tween.remove = true
tt = RT("aura_ignus_idle", "aura")
tt.aura.duration = 0
tt.particles_name = "ps_hero_ignus_idle"
tt.emit_states = {
	"idle",
	"attack"
}
tt.main_script.update = scripts.aura_ignus_particles.update
tt.particle_offsets = {
	v(-17, 16),
	v(-12, 27),
	v(4, 37),
	v(2, 35),
	v(12, 22),
	v(14, 13)
}
tt.flip_offset = v(3, 0)
tt = RT("aura_ignus_surge_of_flame", "aura")
tt.aura.cycle_time = fts(1)
tt.aura.duration = 0
tt.aura.damage_min = nil
tt.aura.damage_max = nil
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.damage_radius = 25
tt.aura.hit_fx = "fx_ignus_burn"
tt.damage_state = "surgeOfFlame"
tt.main_script.update = scripts.aura_ignus_surge_of_flame.update
tt.particles_name = "ps_hero_ignus_smoke"
tt = RT("aura_ingvar_bear_regenerate", "aura")

AC(tt, "regen")

tt.aura.duration = 0
tt.main_script.update = scripts.aura_ingvar_bear_regenerate.update
tt.regen.cooldown = 0.5
tt.regen.health = 5
tt = RT("aura_10yr_idle", "aura")
tt.aura.duration = 0
tt.particles_name = "ps_hero_10yr_idle"
tt.emit_states = {
	"idle",
	"running"
}
tt.main_script.update = scripts.aura_10yr_particles.update
tt.particle_offsets = {
	v(-25.714285714285715, 25.714285714285715),
	v(-15.714285714285715, 37.142857142857146),
	v(0, 45.714285714285715),
	v(8.571428571428571, 42.85714285714286),
	v(14.285714285714286, 32.85714285714286),
	v(21.42857142857143, 21.42857142857143)
}
tt.flip_offset = v(3, 0)
tt = E.register_t(E, "aura_troll_regen", "aura")

AC(tt, "regen")

tt.main_script.update = scripts.aura_unit_regen.update
tt.regen.cooldown = fts(6)
tt.regen.health = 1
tt.regen.ignore_stun = true
tt.regen.ignore_freeze = false
tt = E.register_t(E, "aura_forest_troll_regen", "aura_troll_regen")

AC(tt, "regen")

tt.main_script.update = scripts.aura_unit_regen.update
tt.regen.cooldown = fts(4)
tt.regen.health = 4
tt = E.register_t(E, "aura_troll_axe_thrower_regen", "aura_troll_regen")

AC(tt, "regen")

tt.main_script.update = scripts.aura_unit_regen.update
tt.regen.cooldown = fts(6)
tt.regen.health = 2
tt = E.register_t(E, "aura_troll_brute_regen", "aura_forest_troll_regen")
tt = E.register_t(E, "aura_troll_chieftain_regen", "aura_troll_regen")
tt.regen.cooldown = fts(6)
tt.regen.health = 4
tt = E.register_t(E, "aura_ulgukhai_regen", "aura_forest_troll_regen")
tt.regen.ignore_mods = true
tt = E.register_t(E, "aura_goblin_zapper_death", "aura")
tt.aura.cycles = 1
tt.aura.damage_min = 100
tt.aura.damage_max = 100
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.radius = 60
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_RANGED)
tt.main_script.update = scripts.aura_apply_damage.update
tt = E.register_t(E, "aura_goblin_zapper_death_solider", "aura")
tt.aura.cycles = 1
tt.aura.damage_min = 100
tt.aura.damage_max = 100
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.radius = 60
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.vis_flags = bor(F_RANGED)
tt.main_script.update = scripts.aura_apply_damage.update
tt = E.register_t(E, "aura_demon_death", "aura")
tt.aura.cycles = 1
tt.aura.damage_min = 75
tt.aura.damage_max = 75
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.excluded_templates = {
	"hero_oni"
}
tt.aura.radius = 60
tt.aura.track_damage = true
tt.aura.vis_bans = bor(F_ENEMY, F_FLYING)
tt.aura.vis_flags = bor(F_RANGED)
tt.main_script.update = scripts.aura_apply_damage.update
tt = E.register_t(E, "aura_demon_death_soldier", "aura")
tt.aura.cycles = 1
tt.aura.damage_min = 500
tt.aura.damage_max = 500
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.excluded_templates = {
	"hero_oni"
}
tt.aura.radius = 108.5
tt.aura.track_damage = true
tt.aura.vis_bans = F_FRIEND
tt.aura.vis_flags = bor(F_RANGED)
tt.main_script.update = scripts.aura_apply_damage.update
tt = E.register_t(E, "aura_demon_mage_death", "aura_demon_death")
tt.aura.damage_min = 300
tt.aura.damage_max = 300
tt = E.register_t(E, "aura_demon_wolf_death", "aura_demon_death")
tt.aura.damage_min = 100
tt.aura.damage_max = 100
tt = E.register_t(E, "aura_rotten_lesser_death", "aura")
tt.aura.cycles = 1
tt.aura.radius = 60
tt.aura.mod = "mod_rotten_lesser_pestilence"
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_MOD, F_POISON)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "aura_blue", "aura")
tt.aura.cycles = 1
tt.aura.radius = 192
tt.aura.mod = "mod_blue"
tt.aura.vis_bans = bor(F_FRIEND)
tt.aura.duration = -1
tt.aura.filter_source = true
tt.aura.track_source = true
tt.aura.vis_flags = bor(F_MOD, F_POISON)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "aura_swamp_thing_regen", "aura")

AC(tt, "regen")

tt.main_script.update = scripts.aura_unit_regen.update
tt.regen.cooldown = fts(2)
tt.regen.health = 1
tt.regen.ignore_stun = false
tt.regen.ignore_freeze = false
tt = E.register_t(E, "aura_flareon_death", "aura_demon_death")
tt.aura.damage_min = 60
tt.aura.damage_max = 60
tt = E.register_t(E, "aura_gulaemon_death", "aura_demon_death")
tt.aura.damage_min = 300
tt.aura.damage_max = 300
tt = E.register_t(E, "aura_burning_floor", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.active = false
tt.aura.cycle_time = 0.3
tt.aura.mod = "mod_burning_floor_burn"
tt.aura.radius = 75
tt.aura.vis_flags = bor(F_MOD, F_BURN, F_RANGED)
tt.aura.vis_bans = bor(F_ENEMY)
tt.main_script.update = scripts.aura_burning_floor.update
tt.render.sprites[1].name = "InfernoDecal_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "InfernoDecal_0002"
tt.tween.remove = false
tt.tween.reverse = true
tt.tween.ts = -10
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		fts(0),
		0
	},
	{
		fts(30),
		255
	}
}
tt.tween.props[1].loop = false
tt.tween.props[1].sprite_id = 2
tt = E.register_t(E, "burning_floor_controller")

E.add_comps(E, tt, "main_script")

tt.main_script.update = scripts.burning_floor_controller.update
tt = E.register_t(E, "aura_demon_cerberus_death", "aura_demon_death")
tt.aura.damage_min = 666
tt.aura.damage_max = 666
tt.aura.radius = 120
tt = RT("aura_spectral_knight", "aura")

AC(tt, "render", "tween")

tt.aura.active = false
tt.aura.allowed_templates = {
	"enemy_fallen_knight"
}
tt.aura.cooldown = 0
tt.aura.delay = fts(30)
tt.aura.duration = -1
tt.aura.mod = "mod_spectral_knight"
tt.aura.radius = 106.38297872340426
tt.aura.track_source = true
tt.aura.use_mod_offset = false
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_spectral_knight.update
tt.render.sprites[1].alpha = 0
tt.render.sprites[1].anchor = v(0.5, 0.28125)
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "CB_DeathKnight_aura_0001"
tt.render.sprites[1].offset = v(0, -16)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].alpha = 0
tt.render.sprites[2].animated = true
tt.render.sprites[2].name = "spectral_knight_aura"
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(20),
		255
	}
}
tt.tween.props[1].name = "alpha"
tt.tween.props[2] = table.deepclone(tt.tween.props[1])
tt.tween.props[2].sprite_id = 2
tt.tween.remove = false
tt = E.register_t(E, "aura_troll_skater_regen", "aura_troll_regen")

AC(tt, "regen")

tt.regen.cooldown = fts(4)
tt.regen.health = 1
tt = RT("graveyard_controller")

AC(tt, "graveyard", "main_script")

tt.main_script.update = scripts.graveyard_controller.update
tt.graveyard.dead_time = 0.5
tt.graveyard.check_interval = 0.25
tt.graveyard.keep_gold = true
tt.graveyard.spawn_interval = 0.1
tt.graveyard.spawns_by_health = {
	{
		"enemy_skeleton",
		299
	},
	{
		"enemy_skeleton_big",
		9e+99
	}
}
tt.graveyard.excluded_templates = {
"enemy_skeleton",
"enemy_skeleton_big",
"enemy_spider_tiny",
"enemy_spider_big",
"enemy_spider_small",
"enemy_gargoyle",
"enemy_rocketeer",
"enemy_demon_imp"
}
tt.graveyard.vis_has = F_ENEMY
tt.graveyard.vis_flags = F_SKELETON
tt.graveyard.vis_bans = F_BOSS
tt = RT("swamp_controller", "graveyard_controller")
tt.graveyard.spawns_by_health = {
	{
		"enemy_zombie",
		549
	},
	{
		"enemy_swamp_thing",
		9e+99
	}
}
tt.graveyard.excluded_templates = {
	"soldier_alleria_wildcat",
	"soldier_magnus_illusion",
	"soldier_ingvar_ancestor",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_sand_warrior",
	"soldier_death_rider",
	"soldier_rotten_tree"
}
tt.graveyard.keep_gold = false
tt.graveyard.vis_has = F_FRIEND
tt.graveyard.vis_flags = 0
tt.graveyard.vis_bans = F_HERO
tt = RT("s15_rotten_spawner")

AC(tt, "main_script", "editor")

tt.main_script.update = scripts.s15_rotten_spawner.update
tt.entity = "enemy_rotten_tree"
tt.spawn_margin = {
	30,
	60
}
tt.spawn_timers = {
	{
		10,
		0
	},
	[11] = {
		15,
		1
	},
	[14] = {
		10,
		0
	},
	[15] = {
		15,
		2
	},
	[17] = {
		15,
		3
	},
	[20] = {
		15,
		6
	}
}
tt = RT("s11_lava_spawner")

AC(tt, "main_script")

tt.main_script.update = scripts.s11_lava_spawner.update
tt.entity = "enemy_lava_elemental"
tt.cooldown = 400
tt.cooldown_after = 120
tt.pi = 4
tt.sound = "RockElementalDeath"
tt = RT("jt_spawner_aura", "aura")
tt.main_script.update = scripts.jt_spawner_aura.update
tt.aura.track_source = true
tt.spawn_data = {
	{
		"enemy_whitewolf",
		8,
		0,
		2,
		1
	},
	{
		"enemy_whitewolf",
		8,
		fts(20),
		2,
		2
	},
	{
		"enemy_yeti",
		19,
		0,
		3,
		1
	}
}
tt = E.register_t(E, "blackburn_aura", "aura")
tt.main_script.update = scripts.blackburn_aura.update
tt.aura.cycle_time = 0.5
tt.aura.duration = -1
tt.aura.radius = 106.38297872340426
tt.aura.raise_entity = "enemy_skeleton_big"
tt.count_group_name = "blackburn_skeletons"
tt.count_group_type = COUNT_GROUP_CONCURRENT
tt.count_group_max = 15
tt = RT("veznan_souls_aura", "aura")
tt.main_script.update = scripts.veznan_souls_aura.update
tt.aura.track_source = true
tt.souls = {
	angles = {
		d2r(30),
		d2r(130)
	},
	count = 60,
	delay_frames = 10,
	entity = "veznan_soul"
}
tt = RT("kingpin_damage_aura", "aura")
tt.main_script.update = scripts.aura_apply_damage.update
tt.aura.duration = -1
tt.aura.cycle_time = fts(2)
tt.aura.damage_min = 100
tt.aura.damage_max = 100
tt.aura.damage_type = DAMAGE_PHYSICAL
tt.aura.radius = 65
tt.aura.track_source = true
tt.aura.vis_bans = bor(F_ENEMY)
tt.aura.vis_flags = bor(F_RANGED)
tt = RT("aura_elder_shaman_healing", "aura")

AC(tt, "render", "tween")

tt.aura.mod = "mod_elder_shaman_heal"
tt.aura.mod_args = nil
tt.aura.cycle_time = 0.5
tt.aura.duration = nil
tt.aura.radius = nil
tt.aura.vis_bans = bor(F_BOSS, F_FRIEND)
tt.aura.vis_flags = F_MOD
tt.render.sprites[1].alpha = 50
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "totem_groundeffect-orange_0002"
tt.render.sprites[1].scale = v(0.64, 0.64)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "totem_groundeffect-orange_0001"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].anchor = v(0.5, 0.12264150943396226)
tt.render.sprites[3].loop = false
tt.render.sprites[3].name = "start"
tt.render.sprites[3].prefix = "elder_shaman_totem_orange"
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].anchor = v(0.5, 0.12264150943396226)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].loop = true
tt.render.sprites[4].name = "elder_shaman_totem_orange_fx"
tt.main_script.update = scripts.aura_elder_shaman.update
tt.sound_events.insert = "EndlessOrcsTotemHealing"
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(0.64, 0.64)
	},
	{
		fts(15),
		v(1, 1)
	},
	{
		fts(30),
		v(1.6, 1.6)
	}
}
tt.tween.props[1].loop = true
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		50
	},
	{
		fts(10),
		255
	},
	{
		fts(20),
		255
	},
	{
		fts(30),
		0
	}
}
tt.tween.props[2].loop = true
tt = RT("aura_elder_shaman_damage", "aura_elder_shaman_healing")
tt.aura.mod = "mod_elder_shaman_damage"
tt.aura.cycle_time = 0.2
tt.aura.vis_bans = bor(F_BOSS, F_ENEMY)
tt.render.sprites[1].name = "totem_groundeffect-red_0002"
tt.render.sprites[2].name = "totem_groundeffect-red_0001"
tt.render.sprites[3].prefix = "elder_shaman_totem_red"
tt.render.sprites[4].name = "elder_shaman_totem_red_fx"
tt.sound_events.insert = "EndlessOrcsTotemDamage"
tt = RT("aura_elder_shaman_speed", "aura_elder_shaman_healing")
tt.aura.mod = "mod_elder_shaman_speed"
tt.aura.cycle_time = 0.2
tt.render.sprites[1].name = "totem_groundeffect-ligthBlue_0002"
tt.render.sprites[2].name = "totem_groundeffect-lightBlue_0001"
tt.render.sprites[3].prefix = "elder_shaman_totem_blue"
tt.render.sprites[4].name = "elder_shaman_totem_blue_fx"
tt.sound_events.insert = "EndlessOrcsTotemSpeed"
tt = RT("mod_arcane_shatter", "mod_damage")
tt.damage_min = 0.03
tt.damage_max = 0.03
tt.damage_type = bor(DAMAGE_ARMOR, DAMAGE_NO_SHIELD_HIT)
tt = RT("mod_slow_curse", "mod_slow")
tt.main_script.insert = scripts.mod_slow_curse.insert
tt.modifier.excluded_templates = {
	"enemy_demon_cerberus"
}
tt = RT("mod_ranger_poison", "mod_poison")
tt.modifier.duration = 3
tt.dps.damage_max = 0
tt.dps.damage_min = 0
tt.dps.damage_inc = 5
tt.dps.damage_every = 1
tt.dps.kill = true
tt.dps.damage_type = bor(DAMAGE_POISON, DAMAGE_NO_SHIELD_HIT)
tt = RT("mod_thorn", "modifier")

AC(tt, "render")

tt.animation_start = "thorn"
tt.animation_end = "thornFree"
tt.modifier.duration = 0
tt.modifier.duration_inc = 1
tt.modifier.type = MOD_TYPE_FREEZE
tt.modifier.vis_flags = bor(F_THORN, F_MOD)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.max_times_applied = 3
tt.damage_min = 40
tt.damage_max = 40
tt.damage_type = DAMAGE_PHYSICAL
tt.damage_every = 1
tt.render.sprites[1].prefix = "mod_thorn_small"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_prefixes = {
	"mod_thorn_small",
	"mod_thorn_big",
	"mod_thorn_big"
}
tt.render.sprites[1].size_scales = {
	vv(0.7),
	vv(0.8),
	vv(1)
}
tt.render.sprites[1].anchor.y = 0.22
tt.main_script.queue = scripts.mod_thorn.queue
tt.main_script.dequeue = scripts.mod_thorn.dequeue
tt.main_script.insert = scripts.mod_thorn.insert
tt.main_script.update = scripts.mod_thorn.update
tt.main_script.remove = scripts.mod_thorn.remove
tt = RT("mod_thorn2", "modifier")

AC(tt, "render")

tt.animation_start = "thorn"
tt.animation_end = "thornFree"
tt.modifier.duration = 4
tt.modifier.duration_inc = 1
tt.modifier.type = MOD_TYPE_FREEZE
tt.modifier.vis_flags = bor(F_THORN, F_MOD)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.max_times_applied = 3
tt.damage_min = 40
tt.damage_max = 40
tt.damage_type = DAMAGE_PHYSICAL
tt.damage_every = 1
tt.render.sprites[1].prefix = "mod_thorn_small"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_prefixes = {
	"mod_thorn_small",
	"mod_thorn_big",
	"mod_thorn_big"
}
tt.render.sprites[1].size_scales = {
	vv(0.7),
	vv(0.8),
	vv(1)
}
tt.render.sprites[1].anchor.y = 0.22
tt.main_script.queue = scripts.mod_thorn.queue
tt.main_script.dequeue = scripts.mod_thorn.dequeue
tt.main_script.insert = scripts.mod_thorn.insert
tt.main_script.update = scripts.mod_thorn.update
tt.main_script.remove = scripts.mod_thorn.remove
tt = RT("mod_thorn3", "modifier")

AC(tt, "render")

tt.animation_start = "thorn"
tt.animation_end = "thornFree"
tt.modifier.duration = 5
tt.modifier.duration_inc = 1
tt.modifier.type = MOD_TYPE_FREEZE
tt.modifier.vis_flags = bor(F_THORN, F_MOD)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.max_times_applied = 3
tt.damage_min = 50
tt.damage_max = 50
tt.damage_type = DAMAGE_PHYSICAL
tt.damage_every = 1
tt.render.sprites[1].prefix = "mod_thorn_small"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_prefixes = {
	"mod_thorn_small",
	"mod_thorn_big",
	"mod_thorn_big"
}
tt.render.sprites[1].size_scales = {
	vv(0.7),
	vv(0.8),
	vv(1)
}
tt.render.sprites[1].anchor.y = 0.22
tt.main_script.queue = scripts.mod_thorn.queue
tt.main_script.dequeue = scripts.mod_thorn.dequeue
tt.main_script.insert = scripts.mod_thorn.insert
tt.main_script.update = scripts.mod_thorn.update
tt.main_script.remove = scripts.mod_thorn.remove
tt = RT("mod_ray_arcane", "modifier")

AC(tt, "render", "dps")

tt.dps.damage_min = 87
tt.dps.damage_max = 148
tt.dps.damage_type = bor(DAMAGE_MAGICAL, DAMAGE_ONE_SHIELD_HIT)
tt.dps.damage_every = fts(2)
tt.dps.pop = {
	"pop_zap_arcane"
}
tt.dps.pop_conds = DR_KILL
tt.main_script.update = scripts.mod_ray_arcane.update
tt.modifier.duration = fts(10)
tt.modifier.allows_duplicates = true
tt.render.sprites[1].name = "mod_ray_arcane"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BULLETS
tt = RT("mod_ray_arcane_disintegrate", "modifier")

AC(tt, "render")

tt.main_script.update = scripts.mod_ray_arcane_disintegrate.update
tt.modifier.pop = {
	"pop_zap_arcane"
}
tt.modifier.pop_conds = DR_KILL
tt.modifier.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_INSTAKILL, DAMAGE_NO_SPAWNS)
tt.modifier.damage = 1
tt.modifier.duration = fts(10)
tt.render.sprites[1].name = "mod_ray_arcane"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt = RT("mod_teleport_arcane", "mod_teleport")
tt.delay_end = fts(6)
tt.delay_start = fts(1)
tt.fx_end = "fx_teleport_arcane"
tt.fx_start = "fx_teleport_arcane"
tt.max_times_applied = 3
tt.modifier.use_mod_offset = true
tt.modifier.vis_bans = bor(F_BOSS, F_FREEZE)
tt.modifier.vis_flags = bor(F_MOD, F_TELEPORT)
tt.nodes_offset_min = -26
tt.nodes_offset_max = -17
tt.nodes_offset_inc = -5
tt = RT("mod_sorcerer_curse_armor", "modifier")

AC(tt, "armor_buff")

tt.modifier.duration = 5
tt.modifier.vis_flags = F_MOD
tt.armor_buff.magic = false
tt.armor_buff.factor = -0.5
tt.armor_buff.cycle_time = 1e+99
tt.main_script.insert = scripts.mod_armor_buff.insert
tt.main_script.remove = scripts.mod_armor_buff.remove
tt.main_script.update = scripts.mod_armor_buff.update
tt = RT("mod_sorcerer_curse_dps", "modifier")

AC(tt, "render", "dps")

tt.modifier.duration = 4.9
tt.modifier.vis_flags = F_MOD
tt.dps.damage_min = 10
tt.dps.damage_max = 10
tt.dps.damage_every = 1.25
tt.dps.damage_type = DAMAGE_TRUE
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.render.sprites[1].name = "small"
tt.render.sprites[1].prefix = "mod_sorcerer_curse"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1),
	vv(1.5)
}
tt.render.sprites[1].sort_y_offset = -3
tt = RT("mod_polymorph_sorcerer", "mod_polymorph")
tt.modifier.use_mod_offset = true
tt.modifier.remove_banned = true
tt.modifier.ban_types = {
	MOD_TYPE_FAST
}
tt.polymorph.custom_entity_names.default = "enemy_sheep_ground"
tt.polymorph.custom_entity_names.enemy_demon_imp = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_gargoyle = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_rocketeer = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_witch = "enemy_sheep_fly"
tt.polymorph.hit_fx_sizes = {
	"fx_mod_polymorph_sorcerer_small",
	"fx_mod_polymorph_sorcerer_big",
	"fx_mod_polymorph_sorcerer_big"
}
tt.polymorph.pop = {
	"pop_puff"
}
tt.polymorph.transfer_gold_factor = 1
tt.polymorph.transfer_health_factor = 0.5
tt.polymorph.transfer_lives_cost_factor = 1
tt.polymorph.transfer_speed_factor = 1.5
tt = E.register_t(E, "mod_ray_tesla", "modifier")

E.add_comps(E, tt, "render", "dps")

tt.modifier.duration = fts(14)
tt.modifier.vis_flags = F_MOD
tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_type = bor(DAMAGE_ELECTRICAL, DAMAGE_ONE_SHIELD_HIT)
tt.dps.damage_every = fts(2)
tt.dps.cocos_frames = 14
tt.dps.cocos_cycles = 13
tt.dps.pop = {
	"pop_bzzt"
}
tt.dps.pop_chance = 1
tt.dps.pop_conds = DR_KILL
tt.render.sprites[1].prefix = "mod_tesla_hit"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = E.register_t(E, "mod_ray_tesla2", "modifier")

E.add_comps(E, tt, "render", "dps")

tt.modifier.duration = fts(14)
tt.modifier.vis_flags = F_MOD
tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_type = bor(DAMAGE_TRUE, DAMAGE_ONE_SHIELD_HIT)
tt.dps.damage_every = fts(2)
tt.dps.cocos_frames = 14
tt.dps.cocos_cycles = 13
tt.dps.pop = {
	"pop_bzzt"
}
tt.dps.pop_chance = 1
tt.dps.pop_conds = DR_KILL
tt.render.sprites[1].prefix = "mod_tesla_hit"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = RT("mod_tesla_overcharge", "modifier")

AC(tt, "render")

tt.modifier.duration = fts(20)
tt.modifier.vis_flags = F_MOD
tt.render.sprites[1].prefix = "mod_tesla_hit"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].loop = true
tt.main_script.insert = scripts.mod_track_target.insert
tt.main_script.update = scripts.mod_track_target.update
tt = RT("mod_healing_paladin", "modifier")

AC(tt, "hps")

tt.hps.heal_every = 1e+99
tt.hps.heal_min = 0
tt.hps.heal_max = 0
tt.hps.heal_min_inc = 40
tt.hps.heal_max_inc = 60
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(1)
tt.modifier.bans = {
	"mod_poison_giant_rat"
}
tt.modifier.remove_banned = true
tt = RT("mod_healing_WarHammer", "modifier")

AC(tt, "hps")

tt.hps.heal_every = 1e+99
tt.hps.heal_min = 600
tt.hps.heal_max = 600
tt.hps.heal_min_inc = 0
tt.hps.heal_max_inc = 0
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(1)
tt.modifier.bans = {
	"mod_poison_giant_rat"
}
tt.modifier.remove_banned = true
tt = RT("mod_ray_sunray_hit", "modifier")

AC(tt, "render")

tt.modifier.duration = fts(22)
tt.render.sprites[1].name = "fx_ray_sunray_hit"
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_track_target.insert
tt.main_script.update = scripts.mod_track_target.update
tt = RT("mod_gerald_courage", "modifier")

AC(tt, "render")

tt.courage = {
	heal_once_factor = 0.15,
	damage_min_inc = 2,
	damage_max_inc = 2,
	armor_inc = 0.05,
	magic_armor_inc = 0
}
tt.modifier.duration = 6
tt.modifier.use_mod_offset = false
tt.main_script.insert = scripts.mod_gerald_courage.insert
tt.main_script.remove = scripts.mod_gerald_courage.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "mod_gerald_courage"
tt.render.sprites[1].anchor = v(0.51, 0.17307692307692307)
tt.render.sprites[1].draw_order = 2
tt = RT("mod_malik_stun", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt = E.register_t(E, "mod_ray_hero_thor", "mod_ray_tesla")
tt.modifier.duration = fts(16)
tt.dps.damage_every = fts(2)
tt.dps.damage_min = 5
tt.dps.damage_max = 5
tt.dps.damage_type = DAMAGE_TRUE
tt = RT("mod_hero_thor_chainlightning", "modifier")
tt.chainlightning = {
	bullet = "ray_hero_thor",
	count = 2,
	damage = 40,
	offset = v(25, -1),
	damage_type = DAMAGE_TRUE,
	chain_delay = fts(2),
	max_range = 110,
	min_range = 40,
	mod = "mod_tesla_overcharge"
}
tt.main_script.update = scripts.mod_hero_thor_chainlightning.update
tt = RT("mod_hero_thor_thunderclap", "modifier")

AC(tt, "render")

tt.thunderclap = {
	damage = 100,
	offset = v(0, 10),
	damage_type = DAMAGE_TRUE,
	explosion_delay = fts(3),
	secondary_damage = 50,
	secondary_damage_type = DAMAGE_TRUE,
	radius = 70,
	stun_duration_max = 3,
	stun_duration_min = 2,
	mod_stun = "mod_hero_thor_stun",
	mod_fx = "mod_tesla_overcharge",
	fx = "fx_hero_thor_thunderclap_disipate",
	sound = "HeroThorThunder"
}
tt.main_script.update = scripts.mod_hero_thor_thunderclap.update
tt.main_script.insert = scripts.mod_track_target.insert
tt.render.sprites[1].anchor = v(0.5, 0.15)
tt.render.sprites[1].name = "mod_hero_thor_thunderclap"
tt.render.sprites[1].z = Z_EFFECTS
tt.render.sprites[1].loop = false
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "mod_hero_thor_thunderclap_explosion"
tt = RT("mod_hero_thor_stun", "mod_stun")
tt.modifier.vis_flags = bor(F_MOD, F_STUN)
tt.modifier.vis_bans = bor(F_BOSS)
tt = RT("mod_elora_chill", "mod_slow")
tt.modifier.duration = fts(11)
tt.slow.factor = 0.8
tt = RT("mod_elora_bolt_freeze", "mod_freeze")

AC(tt, "render")

tt.modifier.duration = 2
tt.render.sprites[1].prefix = "freeze_creep"
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].loop = false
tt.custom_offsets = {
	flying = v(-5, 32)
}
tt.custom_suffixes = {
	flying = "_air"
}
tt.custom_animations = {
	"start",
	"end"
}
tt = RT("mod_elora_bolt_slow", "mod_slow")
tt.modifier.duration = 2
tt.slow.factor = 0.5
tt = RT("mod_time_wizard_bolt_slow", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = 0.2
tt = RT("mod_bolin_slow", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = 0.5
tt = RT("mod_sandstorm_slow", "mod_slow")
tt.modifier.duration = 2
tt.slow.factor = 0.2
tt = RT("mod_denas_tower", "modifier")

AC(tt, "render", "tween")

tt.range_factor = 1.2
tt.cooldown_factor = 0.8
tt.main_script.insert = scripts.mod_denas_tower.insert
tt.main_script.remove = scripts.mod_denas_tower.remove
tt.main_script.update = scripts.mod_denas_tower.update
tt.modifier.duration = nil
tt.modifier.use_mod_offset = false
tt.render.sprites[1].draw_order = 11
tt.render.sprites[1].name = "mod_denas_tower"
tt.render.sprites[1].anchor = v(0.5, 0.32)
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].offset.y = 7
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.remove = false
tt = E.register_t(E, "mod_shaman_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 50
tt.hps.heal_max = 50
tt.hps.heal_every = 9e+99
tt.render.sprites[1].prefix = "healing"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(24)
tt.modifier.allows_duplicates = true
tt = E.register_t(E, "mod_cursed_shaman_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.hps.heal_min = 200
tt.hps.heal_max = 200
tt.hps.heal_every = 9e+99
tt.render.sprites[1].prefix = "healing"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(24)
tt.modifier.allows_duplicates = true
tt = E.register_t(E, "mod_rocketeer_speed_buff", "modifier")

AC(tt, "fast")

tt.main_script.insert = scripts.mod_rocketeer_speed_buff.insert
tt.main_script.remove = scripts.mod_rocketeer_speed_buff.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = 2
tt.modifier.type = MOD_TYPE_FAST
tt.sound_events.insert = "EnemyRocketeer"
tt.fast.factor = 3.6041666666666665
tt.walk_angles = {
	"walkingRightLeft_fast",
	"walkingUp_fast",
	"walkingDown_fast"
}
tt = RT("mod_troll_rage", "modifier")

AC(tt, "render")

tt.extra_armor = 0.5
tt.extra_damage_max = 30
tt.extra_damage_min = 15
tt.extra_speed = 30.72
tt.main_script.insert = scripts.mod_troll_rage.insert
tt.main_script.remove = scripts.mod_troll_rage.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = 6
tt.modifier.type = MOD_TYPE_RAGE
tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.use_mod_offset = false
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "mod_troll_rage"
tt = RT("mod_time_traveler", "modifier")

AC(tt, "render")

tt.extra_armor = 0.1
tt.extra_damage_max = 0
tt.extra_damage_min = 0
tt.extra_speed = 30.72
tt.main_script.insert = scripts.mod_troll_rage.insert
tt.main_script.remove = scripts.mod_troll_rage.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = 6
tt.modifier.type = MOD_TYPE_RAGE
tt.modifier.vis_flags = bor(F_MOD)
tt.modifier.use_mod_offset = false
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].name = "mod_troll_rage"
tt = RT("mod_troll_heal", "mod_shaman_heal")
tt = RT("mod_demon_shield", "modifier")

AC(tt, "render")

tt.modifier.bans = {
	"mod_sorcerer_curse_dps",
	"mod_sorcerer_curse_armor"
}
tt.modifier.remove_banned = true
tt.modifier.duration = 1e+99
tt.modifier.vis_flags = bor(F_MOD)
tt.shield_ignore_hits = 4
tt.main_script.insert = scripts.mod_demon_shield.insert
tt.main_script.remove = scripts.mod_demon_shield.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "fx_shield_small"
tt = RT("mod_rotten_lesser_pestilence", "mod_poison")
tt.dps.damage_every = fts(4)
tt.dps.damage_max = 2
tt.dps.damage_min = 2
tt.modifier.duration = fts(4) + 5
tt.render.sprites[1].prefix = "poison_violet"
tt = RT("mod_poison_giant_rat", "mod_poison")
tt.dps.damage_every = fts(7)
tt.dps.damage_max = 10
tt.dps.damage_min = 10
tt.modifier.duration = 2
tt.reduced_damage_factor = 0.5
tt.render.sprites[1].prefix = "poison_violet"
tt.main_script.insert = scripts.mod_giant_rat_poison.insert
tt.main_script.remove = scripts.mod_giant_rat_poison.remove
tt = RT("mod_wererat_poison", "mod_poison_giant_rat")
tt.dps.damage_max = 15
tt.dps.damage_min = 15
tt = RT("mod_flareon_burn", "mod_lava")
tt.dps.damage_min = 20
tt.dps.damage_max = 20
tt.dps.damage_inc = 0
tt.dps.damage_every = fts(11)
tt.dps.damage_type = DAMAGE_POISON
tt.modifier.duration = 3
tt.modifier.vis_flags = bor(F_MOD, F_BURN)
tt.modifier.vis_bans = bor(F_FLYING)
tt = RT("mod_gulaemon_fly", "modifier")
tt.main_script.queue = scripts.mod_gulaemon_fly.queue
tt.main_script.dequeue = scripts.mod_gulaemon_fly.dequeue
tt.main_script.insert = scripts.mod_gulaemon_fly.insert
tt.main_script.remove = scripts.mod_gulaemon_fly.remove
tt.main_script.update = scripts.mod_gulaemon_fly.update
tt.modifier.duration = 2
tt.modifier.type = MOD_TYPE_FAST
tt.speed_factor = 3.666666666666667
tt.nodes_limit = 20
tt = RT("mod_troll_skater", "modifier")
tt.main_script.queue = scripts.mod_gulaemon_fly.queue
tt.main_script.dequeue = scripts.mod_gulaemon_fly.dequeue
tt.main_script.insert = scripts.mod_gulaemon_fly.insert
tt.main_script.update = scripts.mod_gulaemon_fly.update
tt.modifier.type = MOD_TYPE_FAST
tt.speed_factor = 2.4166666666666665
tt.nodes_limit = 1
tt.modifier.duration = 1000000000
tt = RT("mod_burning_floor_burn", "mod_flareon_burn")
tt.modifier.duration = 0.5
tt = RT("mod_witch_frog", "modifier")

AC(tt, "render", "tween")

tt.animation_delay = 0.8
tt.main_script.insert = scripts.mod_witch_frog.insert
tt.main_script.update = scripts.mod_witch_frog.update
tt.modifier.damage_max = 60
tt.modifier.damage_min = 40
tt.modifier.damage_type = DAMAGE_EAT
tt.modifier.hero_damage_type = DAMAGE_MAGICAL
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "mod_witch_frog"
tt.frog_delay = fts(4)
tt.fx_delay = fts(19)
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		v(0, 0)
	},
	{
		1.5,
		v(16, 0)
	}
}
tt.tween.props[1].name = "offset"
tt.tween.remove = false
tt = RT("mod_spectral_knight", "modifier")

AC(tt, "render")

tt.damage_factor_increase = 1.2
tt.main_script.insert = scripts.mod_spectral_knight.insert
tt.main_script.remove = scripts.mod_spectral_knight.remove
tt.main_script.update = scripts.mod_track_target.update
tt.max_times_applied = 1
tt.modifier.duration = 6
tt.modifier.use_mod_offset = false
tt.modifier.vis_flags = bor(F_MOD)
tt.render.sprites[1].achor = v(0, 0)
tt.render.sprites[1].name = "mod_spectral_knight_fx"
tt.render.sprites[1].offset = v(0, 32)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "CB_DeathKnight_buffed"
tt = E.register_t(E, "mod_jt_tower", "modifier")

E.add_comps(E, tt, "render", "tween", "ui")

tt.main_script.update = scripts.mod_jt_tower.update
tt.render.sprites[1].draw_order = 10
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "start"
tt.render.sprites[1].offset.y = 36
tt.render.sprites[1].prefix = "mod_jt"
tt.render.sprites[1].z = Z_OBJECTS

if IS_CONSOLE then
	tt.render.sprites[2] = CC("sprite")
	tt.render.sprites[2].alpha = 150
	tt.render.sprites[2].alpha_focused = 255
	tt.render.sprites[2].alpha_unfocused = 150
	tt.render.sprites[2].animated = false
	tt.render.sprites[2].name = "joystick_shortcuts_hud_0007"
	tt.render.sprites[2].name_focused = "joystick_shortcuts_hud_halo_0007"
	tt.render.sprites[2].name_unfocused = "joystick_shortcuts_hud_0007"
	tt.render.sprites[2].offset.y = 20
	tt.render.sprites[2].scale = vv(1.6)
else
	tt.render.sprites[2] = CC("sprite")
	tt.render.sprites[2].name = "decal_jt_tap"
	tt.render.sprites[2].offset = v(10, 20)
	tt.render.sprites[2].random_ts = fts(7)
end

tt.render.sprites[2].draw_order = 11
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_OBJECTS
tt.required_clicks = (IS_PHONE_OR_TABLET and 5) or 3
tt.end_delay = fts(5)
tt.sound_events.click = "JtHitIce"
tt.tween.remove = false
tt.tween.props[1].disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		1,
		0
	}
}

if IS_CONSOLE then
	tt.tween.props[2] = CC("tween_prop")
	tt.tween.props[2].name = "scale"
	tt.tween.props[2].keys = {
		{
			0,
			vv(1.6)
		},
		{
			0.25,
			vv(1.9)
		},
		{
			0.5,
			vv(1.6)
		}
	}
	tt.tween.props[2].sprite_id = 2
	tt.tween.props[2].loop = true
end

tt.ui.can_select = false
tt.ui.can_click = true
tt.ui.click_rect = r(-40, 0, 80, 60)
tt.ui.click_fx = "fx_jt_tower_click"
tt.ui.z = 1
tt = E.register_t(E, "mod_gulthak_heal", "mod_shaman_heal")
tt.hps.heal_min = 200
tt.hps.heal_max = 200
tt = E.register_t(E, "mod_kingpin_heal_self", "mod_shaman_heal")
tt.hps.heal_min = 500
tt.hps.heal_max = 500
tt.render.sprites[1].anchor.y = 0.3
tt = E.register_t(E, "mod_kingpin_heal_others", "mod_shaman_heal")
tt.hps.heal_min = 50
tt.hps.heal_max = 50
tt = RT("mod_myconid_poison", "mod_poison")
tt.dps.damage_every = fts(2)
tt.dps.damage_max = 4
tt.dps.damage_min = 4
tt.modifier.duration = 5
tt.render.sprites[1].prefix = "poison_violet"
tt = RT("mod_blackburn_stun", "mod_stun")
tt.modifier.duration = 4
tt.modifier.duration_heroes = 2
tt = RT("mod_blackburn_tower", "modifier")

AC(tt, "render", "tween", "main_script")

tt.main_script.update = scripts.mod_blackburn_tower.update
tt.modifier.duration = 4
tt.render.sprites[1].draw_order = 10
tt.render.sprites[1].loop = true
tt.render.sprites[1].offset.y = 36
tt.render.sprites[1].name = "mod_blackburn_tower"
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		fts(10),
		255
	}
}
tt = E.register_t(E, "mod_veznan_tower", "modifier")

E.add_comps(E, tt, "render", "ui")

if IS_CONSOLE then
	E.add_comps(E, tt, "tween")
end

tt.click_time = 4
tt.duration = 6
tt.main_script.update = scripts.mod_veznan_tower.update
tt.render.sprites[1].draw_order = 10
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "start"
tt.render.sprites[1].offset.y = 36
tt.render.sprites[1].prefix = "mod_veznan"
tt.render.sprites[1].z = Z_OBJECTS

if IS_CONSOLE then
	tt.render.sprites[2] = CC("sprite")
	tt.render.sprites[2].alpha = 150
	tt.render.sprites[2].alpha_focused = 255
	tt.render.sprites[2].alpha_unfocused = 150
	tt.render.sprites[2].animated = false
	tt.render.sprites[2].name = "joystick_shortcuts_hud_0007"
	tt.render.sprites[2].name_focused = "joystick_shortcuts_hud_halo_0007"
	tt.render.sprites[2].name_unfocused = "joystick_shortcuts_hud_0007"
	tt.render.sprites[2].offset.y = 20
	tt.render.sprites[2].scale = vv(1.6)
else
	tt.render.sprites[2] = CC("sprite")
	tt.render.sprites[2].name = "decal_veznan_tap"
	tt.render.sprites[2].offset = v(10, 20)
	tt.render.sprites[2].random_ts = fts(7)
end

tt.render.sprites[2].draw_order = 11
tt.render.sprites[2].hidden = true
tt.render.sprites[2].z = Z_OBJECTS
tt.required_clicks = (IS_PHONE_OR_TABLET and 5) or (IS_CONSOLE and 1) or 3
tt.sound_blocked = "VeznanHoldTrap"
tt.sound_click = "VeznanHoldHit"
tt.sound_released = "VeznanHoldDissipate"

if IS_CONSOLE then
	tt.tween.remove = false
	tt.tween.props[1] = CC("tween_prop")
	tt.tween.props[1].name = "scale"
	tt.tween.props[1].keys = {
		{
			0,
			vv(1.6)
		},
		{
			0.25,
			vv(1.9)
		},
		{
			0.5,
			vv(1.6)
		}
	}
	tt.tween.props[1].sprite_id = 2
	tt.tween.props[1].loop = true
end

tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.click_rect = r(-40, 0, 80, 60)
tt.ui.z = 1
tt = RT("mod_elder_shaman_heal", "mod_shaman_heal")
tt.hps.heal_min = nil
tt.hps.heal_max = nil
tt = RT("mod_elder_shaman_damage", "mod_lava")
tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_every = fts(15)
tt.modifier.duration = 1
tt = RT("mod_elder_shaman_speed", "mod_slow")

AC(tt, "render")

tt.slow.factor = nil
tt.modifier.duration = 3
tt.render.sprites[1].name = "mod_elder_shaman_speed"

E.set_template(E, "user_power_1", E.get_template(E, "power_fireball_control"))
E.set_template(E, "user_power_2", E.get_template(E, "power_reinforcements_control"))

tt = RT("decal_sheep_big", "decal_delayed_click_play")

AC(tt, "tween")

tt.delayed_play.achievement_inc = "SHEEP_KILLER"
tt.delayed_play.click_interrupts = true
tt.delayed_play.click_tweens = true
tt.delayed_play.click_sound = "Sheep"
tt.delayed_play.clicked_animation = nil
tt.delayed_play.clicked_sound = "DeathEplosion"
tt.delayed_play.clicked_sound_alt = "BombExplosionSound"
tt.delayed_play.flip_chance = 0.5
tt.delayed_play.play_once = true
tt.delayed_play.required_clicks = 8
tt.delayed_play.required_clicks_fx = "fx_unit_explode"
tt.delayed_play.required_clicks_fx_alt = "fx_explosion_small"
tt.delayed_play.required_clicks_fx_alt_chance = 0.1
tt.delayed_play.required_clicks_hide = true
tt.main_script.insert = scripts.decal_sheep_big.insert
tt.render.sprites[1].anchor.y = 0.1
tt.render.sprites[1].prefix = "decal_sheep_big"
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.12,
		v(1.2, 1.2)
	},
	{
		0.16,
		v(1, 1)
	}
}
tt.tween.props[1].name = "scale"
tt.tween.remove = false
tt.ui.click_rect = r(-10, -5, 20, 20)
tt.ui.can_select = false
tt = RT("decal_sheep_big2", "decal_delayed_click_play")

AC(tt, "tween")

tt.delayed_play.achievement_inc = "SHEEP_KILLER"
tt.delayed_play.click_interrupts = true
tt.delayed_play.click_tweens = true
tt.delayed_play.click_sound = "Sheep"
tt.delayed_play.clicked_animation = nil
tt.delayed_play.clicked_sound = "DeathEplosion"
tt.delayed_play.clicked_sound_alt = "BombExplosionSound"
tt.delayed_play.flip_chance = 0.5
tt.delayed_play.play_once = true
tt.delayed_play.required_clicks = 8
tt.delayed_play.required_clicks_fx = "fx_unit_explode2"
tt.delayed_play.required_clicks_fx_alt = "fx_explosion_small"
tt.delayed_play.required_clicks_fx_alt_chance = 0.1
tt.delayed_play.required_clicks_hide = true
tt.main_script.insert = scripts.decal_sheep_big.insert
tt.render.sprites[1].anchor.y = 0.1
tt.render.sprites[1].prefix = "decal_sheep_big"
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		0.7,
		0.7,
		1.55,
	}
}
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.12,
		v(1.2, 1.2)
	},
	{
		0.16,
		v(1, 1)
	}
}
tt.tween.props[1].name = "scale"
tt.tween.remove = false
tt.ui.click_rect = r(-10, -5, 20, 20)
tt.ui.can_select = false
tt = RT("fx_unit_explode2", "fx_unit_explode")

E:add_comps(tt, "main_script")

tt.can_fire_fn = scripts2.hero_veznan_ultimate.can_fire_fn
tt.cooldown = 0
tt.entity = "soldier_gryphon_guard114"
tt.main_script.update = scripts2.hero_veznan_ultimate.update
tt.mod = "mod_stun"
tt.range = 100
tt.pop_y_offset = 0
tt = RT("pop_zap_sorcerer2", "pop_zap_sorcerer")

E:add_comps(tt, "main_script")

tt.can_fire_fn = scripts2.hero_veznan_ultimate.can_fire_fn
tt.cooldown = 0
tt.entity = "beastmaster_boar2"
tt.main_script.update = scripts2.hero_veznan_ultimate.update
tt.mod = "mod_stun"
tt.range = 100
tt.pop_y_offset = 0
tt = RT("pop_bzzt3", "pop_bzzt")

E:add_comps(tt, "main_script")

tt.can_fire_fn = scripts2.hero_veznan_ultimate.can_fire_fn
tt.cooldown = 0
tt.entity = "beastmaster_boar3"
tt.main_script.update = scripts2.hero_veznan_ultimate.update
tt.mod = "mod_stun"
tt.range = 100
tt.pop_y_offset = 0
tt = RT("pop_bzzt2", "pop_bzzt")

E:add_comps(tt, "main_script")

tt.can_fire_fn = scripts2.hero_veznan_ultimate.can_fire_fn
tt.cooldown = 0
tt.entity = "enemy_deviltide"
tt.main_script.update = scripts2.hero_veznan_ultimate.update
tt.mod = "mod_stun"
tt.range = 100
tt.pop_y_offset = 0
tt = RT("fish_spawns", "decal_scripted")

tt.pop_y_offset = 0
tt.main_script.update = mylua.hero_insert.update
tt.entity = "enemy_deviltide2"
tt.entity_max = 30
tt = RT("decal_sheep_small", "decal_sheep_big")
tt.render.sprites[1].prefix = "decal_sheep_small"
tt = RT("decal_mill_big", "decal_click_pause")
tt.render.sprites[1].name = "decal_mill_big"
tt.ui.can_select = false
tt.ui.click_rect = r(-10, -30, 40, 65)
tt = RT("decal_mill_small", "decal_mill_big")
tt.render.sprites[1].name = "decal_mill_small"
tt.ui.click_rect = r(-10, -25, 35, 55)
tt = RT("decal_s01_trees", "decal")
tt.render.sprites[1].name = "stage1_trees"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.234375
tt = RT("decal_boat_big", "decal_loop")
tt.render.sprites[1].name = "decal_boat_big_idle"
tt = RT("decal_boat_small", "decal_loop")
tt.render.sprites[1].name = "decal_boat_small_idle"
tt = RT("decal_fish", "decal_scripted")

AC(tt, "ui")

tt.render.sprites[1].prefix = "decal_fish"
tt.render.sprites[1].name = "jump"
tt.render.sprites[1].loop = false
tt.render.sprites[1].hidden = true
tt.main_script.update = scripts.decal_fish.update
tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.click_rect = r(-24, -17, 48, 34)
tt.achievement_id = "CATCH_A_FISH"
tt = RT("decal_water_spark", "decal_loop")
tt.render.sprites[1].name = "decal_water_spark_play"
tt = E.register_t(E, "decal_water_wave", "decal_delayed_play")
tt.render.sprites[1].name = "decal_water_wave_play"
tt.delayed_play.min_delay = 1
tt.delayed_play.max_delay = 3
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "decal_water_wave_play"
tt = RT("decal_goat", "decal_sheep_big")
tt.render.sprites[1].prefix = "decal_goat"
tt = RT("decal_tunnel_light", "decal_scripted")

AC(tt, "tween")

tt.main_script.update = scripts.decal_tunnel_light.update
tt.render.sprites[1].name = "cave_light_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].hidden = true
tt.tween.remove = false
tt.tween.props[1].name = "alpha"
tt.tween.props[1].loop = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.15,
		200
	},
	{
		0.3,
		255
	},
	{
		0.4,
		220
	},
	{
		0.7,
		255
	}
}
tt.track_names = nil
tt.track_ids = nil
tt = RT("decal_burner_big", "decal_loop")
tt.render.sprites[1].anchor = v(0.5, 0.13)
tt.render.sprites[1].name = "decal_burner_big_idle"
tt = RT("decal_burner_small", "decal_loop")
tt.render.sprites[1].anchor = v(0.5, 0.11)
tt.render.sprites[1].name = "decal_burner_small_idle"
tt = E.register_t(E, "decal_fredo", "decal_scripted")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].prefix = "decal_fredo"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor = v(0.5, 0.1)
tt.render.sprites[1].loop = false
tt.main_script.update = scripts.decal_fredo.update
tt.ui.can_click = true
tt.ui.click_rect = r(-33, 104, 30, 30)
tt = RT("decal_orc_burner", "decal_loop")
tt.render.sprites[1].name = "decal_orc_burner_idle"
tt.render.sprites[1].random_ts = fts(14)
tt = RT("decal_orc_flag", "decal_loop")
tt.render.sprites[1].anchor = v(0.5, 0.07)
tt.render.sprites[1].random_ts = fts(14)
tt.render.sprites[1].name = "decal_orc_flag_idle"
tt = RT("decal_swamp_bubble", "decal_delayed_play")
tt.render.sprites[1].name = "decal_swamp_bubble_jump"
tt.delayed_play.flip_chance = 0.5
tt.delayed_play.min_delay = fts(150)
tt.delayed_play.max_delay = fts(400)
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "decal_swamp_bubble_jump"
tt = E.register_t(E, "decal_demon_portal_big", "decal_scripted")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].name = "decal_demon_portal_big_active"
tt.main_script.update = scripts.decal_demon_portal_big.update
tt.fx_out = "fx_demon_portal_out"
tt.tween.remove = false
tt.tween.reverse = true
tt.tween.ts = -10
tt.tween.props[1].name = "alpha"
tt.tween.props[1].loop = false
tt.tween.props[1].keys = {
	{
		fts(0),
		0
	},
	{
		fts(30),
		180
	},
	{
		fts(40),
		255
	}
}
tt.out_nodes = nil
tt.shutdown_timeout = 5
tt = E.register_t(E, "decal_s17_barricade", "decal")

E.add_comps(E, tt, "editor", "main_script")

tt.boss_name = "eb_kingpin"
tt.boss_spawn_wave = 15
tt.main_script.update = scripts.decal_s17_barricade.update
tt.render.sprites[1].prefix = "decal_s17_barricade"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor.x = 0.4
tt.render.sprites[1].loop = false
tt.editor.props = {
	{
		"editor.game_mode",
		PT_NUMBER
	}
}
tt = RT("decal_bandits_flag", "decal_loop")
tt.render.sprites[1].random_ts = fts(14)
tt.render.sprites[1].name = "decal_bandits_flag_idle"
tt = E.register_t(E, "decal_scrat", "decal_scripted")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].prefix = "decal_scrat"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "decal_scrat_ice"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].anchor = v(0.5, 0.5)
tt.render.sprites[2].loop = false
tt.touch_fx = "fx_decal_scrat_touch"
tt.main_script.update = scripts.decal_scrat.update
tt.ui.can_click = true
tt.ui.click_rect = r(-45, 5, 40, 40)
tt = RT("fx_decal_scrat_touch", "fx")

AC(tt, "sound_events")

tt.render.sprites[1].name = "decal_scrat_touch_fx"
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.sound_events.insert = "JtHitIce"
tt = RT("decal_troll_flag", "decal_loop")
tt.render.sprites[1].random_ts = fts(18)
tt.render.sprites[1].name = "decal_troll_flag_idle"
tt = RT("decal_troll_burner", "decal_loop")
tt.render.sprites[1].random_ts = fts(11)
tt.render.sprites[1].name = "decal_troll_burner_idle"
tt = E.register_t(E, "decal_frozen_mushroom", "decal_click_play")
tt.render.sprites[1].prefix = "decal_frozen_mushroom"
tt.click_play.required_clicks = 1
tt.click_play.clicked_sound = "MushroomPoof"
tt.click_play.play_once = true
tt = RT("decal_lava_fall", "decal_loop")
tt.render.sprites[1].name = "decal_lava_fall_idle"
tt = RT("decal_inferno_bubble", "decal_delayed_play")
tt.render.sprites[1].name = "decal_inferno_bubble_jump"
tt.delayed_play.flip_chance = 0.5
tt.delayed_play.min_delay = fts(150)
tt.delayed_play.max_delay = fts(400)
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "decal_inferno_bubble_jump"
tt = RT("decal_lava_splash", "decal_inferno_bubble")
tt.render.sprites[1].name = "decal_lava_splash_jump"
tt.delayed_play.play_animation = "decal_lava_splash_jump"
tt = E.register_t(E, "decal_inferno_portal", "decal_demon_portal_big")
tt.render.sprites[1].name = "decal_inferno_portal_active"
tt = E.register_t(E, "decal_inferno_ground_portal", "decal_demon_portal_big")
tt.render.sprites[1].name = "decal_inferno_ground_portal_active"
tt = E.register_t(E, "decal_s21_veznan", "decal")
tt.render.sprites[1].name = "Inferno_Stg21_Veznan_0001"
tt.render.sprites[1].animated = false
tt = E.register_t(E, "decal_s21_veznan_free", "decal")
tt.render.sprites[1].name = "Inferno_Stg21_Veznan_0002"
tt.render.sprites[1].animated = false
tt = E.register_t(E, "decal_s21_hellboy", "decal")
tt.render.sprites[1].name = "decal_s21_hellboy_idle"
tt = E.register_t(E, "background_sounds_blackburn", "background_sounds")
tt.min_delay = 20
tt.max_delay = 30
tt.sounds = {}
tt = E.register_t(E, "decal_s23_splinter", "decal_click_play")
tt.render.sprites[1].prefix = "decal_s23_splinter"
tt.render.sprites[1].loop = false
tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.click_rect.pos.x = -6
tt.ui.click_rect.size.x = 25
tt = E.register_t(E, "decal_s23_splinter_pizza", "decal_s23_splinter")
tt.main_script.update = scripts.decal_s23_splinter_pizza.update
tt.render.sprites[1].prefix = "decal_s23_splinter_pizza"
tt = E.register_t(E, "decal_bat_flying", "decal_delayed_play")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].prefix = "decal_bat_flying"
tt.render.sprites[1].name = "play"
tt.render.sprites[1].z = Z_BULLETS
tt.main_script.insert = scripts.decal_bat_flying.insert
tt.delayed_play.min_delay = 5
tt.delayed_play.max_delay = 20
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_duration = 2
tt.tween.remove = false
tt.tween.props[1].name = "offset"
local bat_speed_per_node = 0.035
local bat_paths = {
	{
		v(-7.74, 618.5),
		v(-0.64, 619.52),
		v(6.27, 620.86),
		v(13.12, 622.27),
		v(19.97, 623.81),
		v(26.62, 625.54),
		v(33.41, 627.46),
		v(40, 629.57),
		v(46.59, 631.87),
		v(53.12, 634.43),
		v(59.39, 637.06),
		v(65.66, 639.87),
		v(71.74, 643.07),
		v(77.63, 646.34),
		v(83.52, 650.05),
		v(89.15, 653.89),
		v(94.66, 658.11),
		v(99.71, 662.72),
		v(104.7, 667.65),
		v(109.12, 672.9),
		v(113.22, 678.59),
		v(116.86, 684.54),
		v(119.94, 690.82),
		v(122.5, 697.41),
		v(124.42, 704.06),
		v(125.7, 710.91),
		v(126.08, 717.95),
		v(125.25, 724.8),
		v(123.2, 731.58),
		v(120.06, 737.86),
		v(116.1, 743.87),
		v(111.68, 749.7),
		v(107.2, 755.26),
		v(102.72, 760.7),
		v(98.18, 766.21),
		v(94.21, 771.9),
		v(90.56, 777.79),
		v(87.68, 784.19)
	},
	{
		v(502.46, 774.14),
		v(503.42, 767.23),
		v(504.7, 760.38),
		v(506.11, 753.54),
		v(507.84, 746.75),
		v(509.76, 739.97),
		v(511.81, 733.44),
		v(514.18, 727.1),
		v(516.99, 720.96),
		v(520.13, 715.01),
		v(523.97, 709.38),
		v(528.45, 704.38),
		v(534.21, 700.42),
		v(540.8, 698.11),
		v(547.71, 698.11),
		v(554.69, 699.01),
		v(561.47, 700.86),
		v(568, 703.36),
		v(574.27, 706.62),
		v(580.16, 710.46),
		v(585.73, 714.62),
		v(590.98, 718.78),
		v(596.29, 722.69),
		v(602.5, 725.7),
		v(609.54, 726.59),
		v(617.09, 725.82),
		v(624.38, 724.93),
		v(631.36, 724.1),
		v(638.27, 723.65),
		v(645.12, 723.65),
		v(652.03, 724.35),
		v(658.82, 725.7),
		v(665.47, 728.13),
		v(671.94, 731.33),
		v(677.7, 735.23),
		v(683.14, 739.97),
		v(688, 745.15),
		v(692.42, 750.78),
		v(696.26, 756.67),
		v(699.71, 762.88),
		v(702.85, 769.09),
		v(706.24, 776.83)
	},
	{
		v(1031.49, 454.02),
		v(1024.38, 455.17),
		v(1017.54, 456.45),
		v(1010.62, 457.79),
		v(1003.84, 459.39),
		v(997.12, 461.18),
		v(990.46, 462.98),
		v(983.74, 465.15),
		v(977.15, 467.46),
		v(970.62, 469.95),
		v(964.42, 472.64),
		v(958.21, 475.46),
		v(952.13, 478.53),
		v(946.18, 481.86),
		v(940.35, 485.5),
		v(934.72, 489.41),
		v(929.28, 493.7),
		v(924.16, 498.24),
		v(919.3, 503.1),
		v(914.69, 508.48),
		v(910.66, 514.05),
		v(907.01, 520),
		v(903.94, 526.27),
		v(901.31, 532.74),
		v(899.33, 539.52),
		v(898.05, 546.37),
		v(897.73, 553.28),
		v(898.56, 560.26),
		v(900.54, 566.98),
		v(903.55, 573.18),
		v(907.58, 579.2),
		v(912, 585.15),
		v(916.48, 590.72),
		v(920.9, 596.29),
		v(925.44, 601.6),
		v(929.41, 607.3),
		v(933.06, 613.18),
		v(936.38, 619.26),
		v(939.52, 625.6),
		v(941.95, 632.06),
		v(944, 638.72),
		v(945.6, 645.57),
		v(946.69, 652.61),
		v(947.46, 659.78),
		v(947.84, 666.75),
		v(947.9, 673.79),
		v(947.65, 680.83),
		v(947.14, 687.87),
		v(946.3, 694.85),
		v(945.22, 701.89),
		v(942.78, 708.61),
		v(939.71, 715.26),
		v(936.32, 721.47),
		v(932.86, 727.42),
		v(929.02, 733.44),
		v(925.06, 739.14),
		v(920.83, 744.77),
		v(916.54, 750.21),
		v(912, 755.58),
		v(907.26, 760.7),
		v(902.34, 765.82),
		v(897.41, 770.82),
		v(892.29, 775.42),
		v(887.17, 780.22)
	},
	{
		v(1028.54, 116.61),
		v(1022.78, 120.96),
		v(1016.9, 124.99),
		v(1010.82, 128.83),
		v(1004.74, 132.22),
		v(998.46, 135.3),
		v(992, 138.18),
		v(985.41, 140.61),
		v(978.75, 142.66),
		v(971.78, 144.19),
		v(964.86, 145.6),
		v(957.76, 146.37),
		v(950.66, 146.69),
		v(943.62, 146.56),
		v(936.77, 145.41),
		v(930.05, 142.98),
		v(924.1, 139.07),
		v(918.85, 134.27),
		v(914.37, 128.58),
		v(910.72, 122.43),
		v(907.46, 115.71),
		v(904.64, 108.99),
		v(902.14, 102.27),
		v(899.71, 95.42),
		v(897.54, 88.77),
		v(895.49, 81.98),
		v(893.38, 75.52),
		v(891.26, 68.99),
		v(889.09, 62.46),
		v(886.98, 56),
		v(884.61, 49.6),
		v(882.05, 43.14),
		v(879.1, 36.8),
		v(875.84, 30.72),
		v(872, 24.7),
		v(867.78, 19.33),
		v(862.98, 14.21),
		v(857.54, 9.79),
		v(851.46, 6.02),
		v(845.38, 2.56),
		v(839.36, -1.28),
		v(833.47, -5.25),
		v(827.78, -9.28),
		v(822.4, -13.95)
	},
	{
		v(687.1, -12.1),
		v(685.76, -5.12),
		v(684.22, 1.79),
		v(682.5, 8.64),
		v(680.7, 15.42),
		v(678.72, 22.08),
		v(676.61, 28.67),
		v(674.3, 35.26),
		v(671.81, 41.86),
		v(669.18, 48.26),
		v(666.11, 54.66),
		v(663.17, 60.8),
		v(659.78, 66.75),
		v(656.32, 72.45),
		v(652.42, 78.08),
		v(648.13, 83.33),
		v(643.33, 88.19),
		v(637.95, 92.67),
		v(631.94, 96.13),
		v(625.41, 98.5),
		v(618.43, 99.58),
		v(611.52, 99.52),
		v(604.48, 99.26),
		v(597.5, 98.69),
		v(590.53, 97.66),
		v(583.62, 96.26),
		v(576.83, 94.46),
		v(570.11, 92.35),
		v(563.46, 89.79),
		v(556.99, 86.91),
		v(550.66, 83.9),
		v(544.38, 80.64),
		v(538.43, 77.12),
		v(532.48, 73.79),
		v(526.59, 70.34),
		v(520.58, 67.07),
		v(514.24, 64.06),
		v(507.9, 61.44),
		v(501.31, 59.52),
		v(494.34, 58.43),
		v(487.36, 59.01),
		v(480.64, 61.12),
		v(474.5, 64.58),
		v(468.61, 68.8),
		v(463.3, 73.66),
		v(458.18, 78.78),
		v(453.25, 83.97),
		v(448.51, 89.09),
		v(443.9, 94.02),
		v(439.04, 98.82),
		v(433.92, 103.49),
		v(428.42, 107.71),
		v(422.53, 111.3),
		v(416.06, 113.66),
		v(409.15, 114.82),
		v(402.18, 113.98),
		v(395.39, 111.3),
		v(389.38, 107.33),
		v(383.94, 102.53),
		v(379.01, 97.34),
		v(374.4, 91.84),
		v(370.18, 86.14),
		v(366.14, 80.26),
		v(362.37, 74.24),
		v(358.66, 68.1),
		v(355.14, 62.08),
		v(351.87, 55.94),
		v(348.42, 50.05),
		v(345.09, 44.1),
		v(341.82, 38.08),
		v(338.24, 32.13),
		v(333.95, 26.24),
		v(329.28, 20.8),
		v(324.29, 15.74),
		v(319.1, 10.69),
		v(313.6, 6.08),
		v(307.97, 1.73),
		v(302.34, -2.37),
		v(296.45, -6.27),
		v(290.56, -10.11),
		v(284.54, -13.76)
	},
	{
		v(-12.86, 155.9),
		v(-5.76, 157.18),
		v(1.34, 158.66),
		v(8.19, 160.26),
		v(15.17, 161.98),
		v(22.02, 163.84),
		v(28.67, 165.89),
		v(35.2, 168.06),
		v(41.73, 170.43),
		v(48.13, 173.06),
		v(54.46, 176),
		v(60.54, 179.26),
		v(66.62, 182.91),
		v(72.26, 187.01),
		v(77.63, 191.62),
		v(82.3, 196.86),
		v(85.95, 202.69),
		v(88, 209.47),
		v(87.55, 216.58),
		v(84.93, 223.3),
		v(81.15, 229.44),
		v(76.74, 235.2),
		v(72.13, 240.77),
		v(67.46, 246.4),
		v(63.17, 251.97),
		v(59.71, 257.98),
		v(57.02, 264.45),
		v(56.06, 271.55),
		v(56.38, 278.66),
		v(57.73, 285.7),
		v(59.78, 292.8),
		v(62.14, 299.78),
		v(64.58, 306.5),
		v(66.94, 313.15),
		v(69.31, 319.68),
		v(71.42, 326.27),
		v(73.34, 332.99),
		v(74.75, 339.9),
		v(75.52, 346.82),
		v(75.39, 353.86),
		v(74.05, 360.83),
		v(71.04, 367.23),
		v(66.37, 372.61),
		v(60.03, 376.26),
		v(52.93, 378.62),
		v(46.21, 380.93),
		v(39.55, 383.42),
		v(33.22, 386.37),
		v(26.82, 389.44),
		v(20.67, 392.9),
		v(14.72, 396.61),
		v(9.09, 400.7),
		v(3.71, 405.25),
		v(-1.28, 410.24),
		v(-5.82, 415.68),
		v(-11.46, 420.54)
	}
}

for i, b in ipairs(bat_paths) do
	tt = E.register_t(E, "decal_bat_flying_" .. i, "decal_bat_flying")
	local keys = {}
	local t = 0

	for _, p in pairs(b) do
		table.insert(keys, {
			t,
			p
		})

		t = t + bat_speed_per_node
	end

	tt.tween.props[1].keys = keys
	tt.delayed_play.play_duration = t
end

tt = E.register_t(E, "decal_s24_nevermore", "decal_click_play")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.render.sprites[1].prefix = "decal_s24_nevermore"
tt.render.sprites[1].z = Z_OBJECTS
tt.leave_time = 2
tt.main_script.update = scripts.decal_s24_nevermore.update
tt.sound = "ExtraBlackburnCrow"
tt.tween.remove = false
tt.tween.reverse = true
tt.tween.ts = -10
tt.tween.props[1].name = "offset"
tt.tween.props[1].keys = {
	{
		fts(0),
		v(0, 0)
	},
	{
		fts(60),
		v(334, 44)
	}
}
tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.click_rect.pos.y = -26
tt = RT("decal_blackburn_weed", "decal_loop")
tt.render.sprites[1].random_ts = fts(34)
tt.render.sprites[1].name = "decal_blackburn_weed_idle"
tt = RT("decal_blackburn_waves", "decal_delayed_play")
tt.render.sprites[1].name = "decal_blackburn_waves_jump"
tt.delayed_play.min_delay = 0
tt.delayed_play.max_delay = 1
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "decal_blackburn_waves_jump"
tt = RT("decal_blackburn_bubble", "decal_delayed_play")
tt.render.sprites[1].name = "decal_blackburn_bubble_jump"
tt.delayed_play.min_delay = 0
tt.delayed_play.max_delay = 1
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "decal_blackburn_bubble_jump"
tt = RT("decal_blackburn_smoke", "decal_loop")
tt.render.sprites[1].random_ts = fts(21)
tt.render.sprites[1].name = "decal_blackburn_smoke_jump"
tt = E.register_t(E, "decal_s25_nessie", "decal_click_play")
tt.render.sprites[1].anchor = v(0.5, 0.43478260869565216)
tt.render.sprites[1].prefix = "decal_s25_nessie"
tt.render.sprites[1].z = Z_OBJECTS
tt.main_script.update = scripts.decal_s25_nessie.update
tt.out_pos = {
	v(555, 600),
	v(131, 530),
	v(415, 450)
}
tt.animation_duration = {
	3,
	4
}
tt.pause_duration = {
	7,
	10
}
tt.sound = "ExtraBlackburnNessie"
tt.ui.can_click = true
tt.ui.can_select = false
tt.ui.click_rect.pos = v(-22, 2)
tt.ui.click_rect.size = v(30, 20)
tt = RT("decal_s26_cage", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_s26_cage"
tt.delayed_play.min_delay = 2
tt.delayed_play.max_delay = 6
tt.delayed_play.idle_animation = "idle"
tt.delayed_play.play_animation = "play"
tt = RT("decal_s26_hangmen", "decal_s26_cage")
tt.render.sprites[1].prefix = "decal_s26_hangmen"
tt = RT("decal_endless_burner", "decal_loop")
tt.render.sprites[1].name = "decal_orc_burner_idle"
tt.render.sprites[1].random_ts = fts(14)
tt = RT("decal_s81_percussionist", "decal_scripted")
tt.render.sprites[1].prefix = "decal_s81_percussionist"
tt.render.sprites[1].anchor.y = 0.125
tt.render.sprites[1].loop = false
tt.main_script.update = scripts.decal_s81_percussionist.update
tt.play_loops = 0
tt = E.register_t(E, "aura_FlareBomber_death", "aura")
tt.aura.cycles = 1
tt.aura.radius = 128
tt.aura.mod = "mod_FlareBomber_stun_death"
tt.aura.vis_bans = F_FRIEND
tt.aura.vis_flags = bor(F_MOD, F_POISON)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "aura_ArchImage_death", "aura")
tt.aura.cycles = 1
tt.aura.radius = 178
tt.aura.mod = "mod_ArchImage_slow"
tt.aura.vis_bans = F_FRIEND
tt.aura.vis_flags = bor(F_MOD, F_POISON)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "mod_bloodsucker_lifesteal", "modifier")

E.add_comps(E, tt)

tt.heal_hp = 35
tt.damage = 0
tt.main_script.insert = scripts3.mod_elvira_lifesteal.insert
tt = E.register_t(E, "mod_bloodsucker_lifesteal2", "modifier")

E.add_comps(E, tt)

tt.heal_hp = 175
tt.damage = 0
tt.main_script.insert = scripts3.mod_elvira_lifesteal.insert
tt = RT("aura_soldier_death_spawns", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns2.update
tt.aura.duration = -1
tt.spawn_entity = "soldier_bloodsucker2"
tt.max_spawns = 1
tt = RT("aura_soldier_death_spawns_2", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns.update
tt.aura.duration = -1
tt.spawn_entity = "soldier_orc_armored"
tt.max_spawns = 1
tt = RT("aura_soldier_death_spawns_3", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns.update
tt.aura.duration = -1
tt.spawn_entity = "hero_dwarf_6"
tt.max_spawns = 1
tt = RT("aura_soldier_death_spawns_4", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns.update
tt.aura.duration = -1
tt.spawn_entity = "soldier_skeleton2"
tt.max_spawns = 10
tt = RT("hero_death_spawns", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.hero_death_spawns.update
tt.aura.duration = -1
tt.spawn_entity = "soldier_skeleton_knight2"
tt = RT("aura_soldier_death_spawns2", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns_aura.update
tt.aura.duration = -1
tt.spawn_aura = "aura_demon_death_soldier"
tt = RT("aura_soldier_death_spawns2_2", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns_aura.update
tt.aura.duration = -1
tt.spawn_aura = "aura_FlareBomber_death"
tt = RT("aura_soldier_death_spawns2_3", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns_aura.update
tt.aura.duration = -1
tt.spawn_aura = "aura_goblin_zapper_death_solider"
tt = RT("aura_soldier_death_spawns2_4", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns_aura.update
tt.aura.duration = -1
tt.spawn_aura = "aura_ArcHImage_overcharge"
tt = RT("aura_soldier_death_spawns2_5", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_death_spawns_aura.update
tt.aura.duration = -1
tt.spawn_aura = "aura_ArchImage_death"
tt = RT("gelf_maxdamage", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_bullets_max_damage.update
tt.aura.duration = -1
tt = RT("tower_ranger_full", "tower_ranger")
tt.powers.thorn.level = 3
tt.powers.poison.level = 3
tt = RT("tower_tesla_full", "tower_tesla")
tt.powers.overcharge.level = 3
tt.powers.bolt.level = 3
tt = RT("tower_sorcerer_full", "tower_sorcerer")
tt.powers.elemental.level = 3
tt.powers.polymorph.level = 3
tt = RT("tower_bfg_full", "tower_bfg")
tt.powers.cluster.level = 3
tt.powers.missile.level = 3
tt = RT("tower_musketeer_full", "tower_musketeer")
tt.powers.shrapnel.level = 3
tt.powers.sniper.level = 3
tt = RT("tower_arcane_wizard_full", "tower_arcane_wizard")
tt.powers.teleport.level = 3
tt.powers.disintegrate.level = 3
tt = RT("aura_spawn_tower", "aura")

E:add_comps(tt, "render")

tt.main_script.update = mylua.aura_spawn_object.update
tt.aura.duration = 9e+99
tt.aura.tower = true
tt.tower_spawns = {
"tower_sorcerer_full",
"tower_ranger_full",
"tower_tesla_full",
"tower_bfg_full",
"tower_musketeer_full",
"tower_arcane_wizard_full"
}
tt = RT("aura_spawn_zombie", "aura")

E:add_comps(tt, "render")

tt.main_script.update = mylua.soldier_spwan_aura.update
tt.aura.duration = -1
tt.aura.radius = 256
tt.aura.excluded_templates = {
"soldier_zombie",
"soldier_alleria_wildcat",
"soldier_magnus_illusion",
"soldier_ingvar_ancestor",
"soldier_skeleton",
"soldier_skeleton_knight",
"soldier_sand_warrior",
"soldier_death_rider",
"soldier_rotten_tree"
}
tt.aura.vis_flags = F_FRIEND
tt.aura.vis_bans = bor(F_ENEMY)
tt.raise_entity = "soldier_zombie"
tt = E.register_t(E, "mod_bloodsucker_damage_extra", "modifier")

E.add_comps(E, tt, "modifier")

tt.modifier.damage_extra_max = 275
tt.modifier.damage_extra_min = 125
tt.modifier.damage_extra = 5
tt.modifier.damage_subtractive_max = 2
tt.modifier.damage_subtractive_min = 1
tt.modifier.damage_subtractive = 5
tt.heal_hp = 35
tt.main_script.insert = mylua.mod_extra_damage.insert
tt = E.register_t(E, "mod_twoface_damage_extra", "modifier")

E.add_comps(E, tt, "modifier")

tt.modifier.damage_extra_max = 325
tt.modifier.damage_extra_min = 250
tt.modifier.damage_extra = 1
tt.main_script.insert = mylua.mod_twoface_damage_extra.insert
tt = E.register_t(E, "mod_gelf_max_damage", "modifier")
tt.main_script.insert = mylua.mod_bullets_max_damage.insert
tt = E.register_t(E, "aura_spawn_zombies", "aura")
tt.aura.cycles = 0.1
tt.aura.radius = 256
tt.aura.mod = "mod_spawn_zombies"
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = bor(F_MOD, F_POISON)
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "mod_spawn_zombies", "modifier")
tt.main_script.update = mylua.mod_spawn_zombies.update
tt.raise_entity = "soldier_zombie"
tt.modifier.duration = 9999
tt = RT("aura_warhammer_rage2", "aura")

E:add_comps(tt, "render", "attacks")

tt.main_script.update = mylua.soldier_warhammer_rage.update
tt.aura.duration = -1
tt.rage_health = 390
tt = E.register_t(E, "mod_enemy_weak", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].name = "mod_troll_rage"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.main_script.insert = mylua.mod_enemy_weak.insert
tt.main_script.remove = mylua.mod_enemy_weak.remove
tt.main_script.update = mylua.mod_enemy_weak.update
tt.modifier.duration = 3
tt.modifier.use_mod_offset = true
tt.subtractive_health_factor = 0.5
tt.inflicted_damage_factor = 0.1
tt.subtractive_magic_armor = 1
tt.subtractive_armor = 1
tt.heal_hp = 300
tt = E.register_t(E, "mod_enemy_weak2", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].name = "mod_troll_rage"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.main_script.insert = mylua.mod_enemy_weak2.insert
tt.main_script.remove = mylua.mod_enemy_weak.remove
tt.main_script.update = mylua.mod_enemy_weak.update
tt.modifier.duration = 3
tt.modifier.use_mod_offset = true
tt.subtractive_health_factor = 0.2
tt.inflicted_damage_factor = 1
tt.subtractive_magic_armor = 0
tt.subtractive_armor = 0
tt = RT("NG_tower", "fx")

AC(tt, "melee", "main_script")

tt.tower_spawns = {
"tower_holder_wasteland"
}
tt.main_script.update = mylua.enemy_deepman.update
tt = RT("aura_spawns_zombies", "aura")

E:add_comps(tt, "render")

tt.main_script.update = mylua.aura_spawns_soldiers.update
tt.aura.duration = 9e+99
tt.aura.radius = 256
tt.raise_entity = "soldier_zombie"
tt.aura.vis_bans = 0
tt.render.sprites[1].name = "fx_moloch_ring"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "fx_moloch_ring"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].scale = v(0.7, 0.7)
tt.render.sprites[3] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[3].name = "fx_moloch_ring"
tt.render.sprites[3].z = Z_DECALS
tt.render.sprites[3].scale = v(0.4, 0.4)
tt = E:register_t("mod_demon_heal", "modifier")

E:add_comps(tt, "hps", "render")

tt.hps.heal_min = 5
tt.hps.heal_max = 5
tt.hps.heal_every = fts(1)
tt.render.sprites[1].prefix = "healing"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.modifier.duration = fts(30)
tt.modifier.allows_duplicates = true
tt = E:register_t("mod_small_demon_heal", "mod_demon_heal")
tt.hps.heal_min = 3
tt.hps.heal_max = 3
tt.modifier.duration = fts(50)
tt = RT("aura_soldier_levelup", "aura")

E:add_comps(tt, "render")

tt.main_script.update = mylua.aura_demon_levelup.update
tt.aura.duration = 9e+99
tt.aura.find_range = 133
tt.aura.hp_inc = 50
tt.aura.add_mod = "mod_small_demon_heal"
tt.aura.damage_inc = 5
tt.aura.vis_bans = 0
tt.render.sprites[1].name = "fx_moloch_ring"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].shader = "p_tint"
tt.render.sprites[1].shader_args = {
	tint_factor = 0.4444,
	tint_color = {
		1.6,
		1.6,
		0.6,
		0.6,
	}
}
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "fx_moloch_ring"
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].scale = v(0.7, 0.7)
tt.render.sprites[3] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[3].name = "fx_moloch_ring"
tt.render.sprites[3].z = Z_DECALS
tt.render.sprites[3].scale = v(0.4, 0.4)
tt = RT("hero_re_farmer", "aura")
tt.aura.duration = 85
tt.main_script.update = mylua.hero_re_farmer.update
tt = RT("hero_re_farmer2", "aura")
tt.aura.duration = 30
tt.main_script.update = mylua.hero_re_farmer2.update
tt = E:register_t("mod_possess", "modifier")
tt.health_factor = 0.25
tt.main_script.insert = mylua.mod_possess.insert


return 
