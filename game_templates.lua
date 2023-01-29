local bit = require("bit")
local bor = bit.bor
local band = bit.band
local bnot = bit.bnot
local E = require("entity_db")
local i18n = require("i18n")

require("constants")

local anchor_y = 0
local image_y = 0
local tt = nil
local scripts = require("game_scripts")
local scripts1 = require("game_scripts1")
local scripts2 = require("game_scripts_2")
local mylua = require("mylua")
local ranger = require("game_scripts_tower_ranger")

require("templates")

local IS_PHONE = KR_TARGET == "phone"
local IS_PHONE_OR_TABLET = KR_TARGET == "phone" or KR_TARGET == "tablet"

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

local function RT(name, ref)
	return E:register_t(name, ref)
end

local function AC(tpl, ...)
	return E:add_comps(tpl, ...)
end

local function CC(comp_name)
	return E:clone_c(comp_name)
end

local function d2r(d)
	return (d*math.pi)/180
end

local mod_crossbow_eagle = E.register_t(E, "mod_crossbow_eagle", "modifier")

E.add_comps(E, mod_crossbow_eagle, "render", "tween")

mod_crossbow_eagle.range_factor = 1.05
mod_crossbow_eagle.range_factor_inc = 0.05
mod_crossbow_eagle.main_script.insert = scripts.mod_crossbow_eagle.insert
mod_crossbow_eagle.main_script.remove = scripts.mod_crossbow_eagle.remove
mod_crossbow_eagle.tween.remove = false
mod_crossbow_eagle.tween.props[1].name = "scale"
mod_crossbow_eagle.tween.props[1].loop = true
mod_crossbow_eagle.tween.props[1].keys = {
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
mod_crossbow_eagle.render.sprites[1].name = "CossbowHunter_towerBuff"
mod_crossbow_eagle.render.sprites[1].animated = false
mod_crossbow_eagle.render.sprites[1].anchor.y = 0.21
mod_crossbow_eagle.render.sprites[1].z = Z_TOWER_BASES + 1

for i, p in ipairs({
	v(22, 45),
	v(40, 35),
	v(58, 30),
	v(77, 35),
	v(95, 45)
}) do
	mod_crossbow_eagle.render.sprites[i + 1] = E.clone_c(E, "sprite")
	mod_crossbow_eagle.render.sprites[i + 1].prefix = "crossbow_eagle_buff"
	mod_crossbow_eagle.render.sprites[i + 1].name = "idle"
	mod_crossbow_eagle.render.sprites[i + 1].anchor.y = 0.21
	mod_crossbow_eagle.render.sprites[i + 1].offset = v(p.x - 58, p.y - 27)
	mod_crossbow_eagle.render.sprites[i + 1].ts = math.random()
end

local decal_crossbow_eagle_preview = E.register_t(E, "decal_crossbow_eagle_preview", "decal_tween")
decal_crossbow_eagle_preview.render.sprites[1].name = "CrossbowHunterDecalDotted"
decal_crossbow_eagle_preview.render.sprites[1].animated = false
decal_crossbow_eagle_preview.render.sprites[1].anchor = v(0.5, 0.32)
decal_crossbow_eagle_preview.render.sprites[1].offset.y = 0
decal_crossbow_eagle_preview.tween.remove = false
decal_crossbow_eagle_preview.tween.props[1].name = "scale"
decal_crossbow_eagle_preview.tween.props[1].loop = true
decal_crossbow_eagle_preview.tween.props[1].keys = {
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
local mod_blacksurge = E.register_t(E, "mod_blacksurge", "modifier")

E.add_comps(E, mod_blacksurge, "render")

mod_blacksurge.modifier.duration = 7
mod_blacksurge.main_script.update = scripts.mod_tower_block.update
mod_blacksurge.render.sprites[1].prefix = "blacksurge_curse"
mod_blacksurge.render.sprites[1].name = "start"
mod_blacksurge.render.sprites[1].anchor.y = 0.24
mod_blacksurge.render.sprites[1].draw_order = 10
local mod_silence_totem = E.register_t(E, "mod_silence_totem", "modifier")

E.add_comps(E, mod_silence_totem, "render")

mod_silence_totem.modifier.duration = 1
mod_silence_totem.modifier.bans = {
	"mod_shaman_armor",
	"mod_shaman_magic_armor",
	"mod_shaman_priest_heal",
	"mod_xerxes_invisibility"
}
mod_silence_totem.modifier.remove_banned = true
mod_silence_totem.main_script.insert = scripts.mod_silence.insert
mod_silence_totem.main_script.remove = scripts.mod_silence.remove
mod_silence_totem.main_script.update = scripts.mod_track_target.update
mod_silence_totem.render.sprites[1].prefix = "silence"
mod_silence_totem.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
mod_silence_totem.render.sprites[1].name = "small"
mod_silence_totem.render.sprites[1].loop = true
mod_silence_totem.render.sprites[1].draw_order = 2
local mod_weakness_totem = E.register_t(E, "mod_weakness_totem", "modifier")

E.add_comps(E, mod_weakness_totem, "render")

mod_weakness_totem.inflicted_damage_factor = 0.5
mod_weakness_totem.received_damage_factor = 1.4
mod_weakness_totem.modifier.duration = 1.5
mod_weakness_totem.modifier.resets_same = false
mod_weakness_totem.modifier.use_mod_offset = false
mod_weakness_totem.main_script.insert = scripts.mod_damage_factors.insert
mod_weakness_totem.main_script.remove = scripts.mod_damage_factors.remove
mod_weakness_totem.main_script.update = scripts.mod_track_target.update
mod_weakness_totem.render.sprites[1].prefix = "weakness"
mod_weakness_totem.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
mod_weakness_totem.render.sprites[1].name = "small"
mod_weakness_totem.render.sprites[1].loop = true
mod_weakness_totem.render.sprites[1].z = Z_DECALS
local mod_death_rider = E.register_t(E, "mod_death_rider", "modifier")

E.add_comps(E, mod_death_rider, "render")

mod_death_rider.inflicted_damage_factor = 1.5
mod_death_rider.extra_armor = 0.3
mod_death_rider.modifier.duration = 1
mod_death_rider.modifier.use_mod_offset = false
mod_death_rider.render.sprites[1].name = "NecromancerSkeletonAura"
mod_death_rider.render.sprites[1].animated = false
mod_death_rider.render.sprites[1].z = Z_DECALS
mod_death_rider.main_script.insert = scripts.mod_death_rider.insert
mod_death_rider.main_script.remove = scripts.mod_death_rider.remove
mod_death_rider.main_script.update = scripts.mod_track_target.update
local mod_bluegale_damage = E.register_t(E, "mod_bluegale_damage", "modifier")

E.add_comps(E, mod_bluegale_damage, "dps")

mod_bluegale_damage.modifier.duration = 0.9
mod_bluegale_damage.dps.damage_min = 15
mod_bluegale_damage.dps.damage_max = 15
mod_bluegale_damage.dps.damage_type = DAMAGE_TRUE
mod_bluegale_damage.dps.damage_every = 1
mod_bluegale_damage.main_script.insert = scripts.mod_dps.insert
mod_bluegale_damage.main_script.update = scripts.mod_dps.update
local mod_bluegale_heal = E.register_t(E, "mod_bluegale_heal", "modifier")

E.add_comps(E, mod_bluegale_heal, "hps")

mod_bluegale_heal.modifier.duration = 0.9
mod_bluegale_heal.hps.heal_min = 15
mod_bluegale_heal.hps.heal_max = 15
mod_bluegale_heal.hps.heal_every = 1
mod_bluegale_heal.main_script.insert = scripts.mod_hps.insert
mod_bluegale_heal.main_script.update = scripts.mod_hps.update
tt = E.register_t(E, "mod_munra_heal", "modifier")

E.add_comps(E, tt, "hps", "render", "endless")

tt.modifier.duration = fts(24)
tt.hps.heal_min = 100
tt.hps.heal_max = 100
tt.hps.heal_every = 9e+99
tt.render.sprites[1].prefix = "healing"
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].name = "small"
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt.endless.factor_map = {
	{
		"enemy_munra.healPoints",
		"hps.heal_min",
		true
	},
	{
		"enemy_munra.healPoints",
		"hps.heal_max",
		true
	}
}
tt = E.register_t(E, "mod_greenfin_net", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts.mod_stun.insert
tt.main_script.update = scripts.mod_stun.update
tt.main_script.remove = scripts.mod_stun.remove
tt.modifier.duration = 6
tt.modifier.duration_heroes = 1
tt.modifier.animation_phases = true
tt.render.sprites[1].prefix = "greenfin_net"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
tt.render.sprites[1].name = "start"
tt.render.sprites[1].size_anchors = {
	v(0.5, 1),
	v(0.5, 0.8409090909090909),
	v(0.5, 0.8409090909090909)
}
tt.render.sprites[1].anchor = v(0.5, 1)
tt.modifier.custom_offsets = {
	default = v(0, 26),
	hero_alien = v(0, 32),
	hero_alric = v(0, 31),
	hero_beastmaster = v(0, 32),
	hero_voodoo_witch = v(0, 32),
	hero_crab = v(0, 46),
	hero_giant = v(-2, 50),
	hero_minotaur = v(6, 46),
	hero_mirage = v(0, 31),
	hero_monkey_god = v(2, 37),
	hero_pirate = v(0, 30),
	hero_priest = v(0, 29),
	hero_van_helsing = v(0, 36),
	hero_wizard = v(0, 29),
	soldier_death_rider = v(0, 38),
	soldier_pirate_anchor = v(0, 34),
	soldier_frankenstein = v(0, 41)
}
local fx_bolt_archmage_hit = E.register_t(E, "fx_bolt_archmage_hit", "fx")
fx_bolt_archmage_hit.render.sprites[1].name = "bolt_archmage_hit"
tt = RT("axe_barbarian", "arrow")
tt.bullet.damage_min = 24
tt.bullet.damage_max = 32
tt.bullet.damage_inc = 10
tt.bullet.flight_time = fts(23)
tt.bullet.rotation_speed = (FPS*30*math.pi)/180
tt.bullet.miss_decal = "decal_axe"
tt.bullet.reset_to_target_pos = true
tt.main_script.insert = scripts2.axe_barbarian.insert
tt.render.sprites[1].name = "barbarian_axe_0001"
tt.render.sprites[1].animated = false
tt.bullet.pop = nil
tt.sound_events.insert = "AxeSound"
tt = RT("arrow_elf", "arrow")
tt.bullet.damage_min = 25
tt.bullet.damage_max = 50
tt.bullet.damage_inc = 5
tt.bullet.flight_time = fts(15)
local fx_bolt_necromancer_hit = E.register_t(E, "fx_bolt_necromancer_hit", "fx")
fx_bolt_necromancer_hit.render.sprites[1].name = "bolt_necromancer_hit"
local decal_dwaarp_smoke = E.register_t(E, "decal_dwaarp_smoke", "decal_timed")
decal_dwaarp_smoke.render.sprites[1].prefix = "towerdwaarp_sfx"
decal_dwaarp_smoke.render.sprites[1].name = "smoke"
decal_dwaarp_smoke.render.sprites[1].z = Z_DECALS
local decal_dwaarp_smoke_water = E.register_t(E, "decal_dwaarp_smoke_water", "decal_timed")
decal_dwaarp_smoke_water.render.sprites[1].prefix = "towerdwaarp_sfx"
decal_dwaarp_smoke_water.render.sprites[1].name = "smokewater"
decal_dwaarp_smoke_water.render.sprites[1].z = Z_DECALS
local decal_dwaarp_pulse = E.register_t(E, "decal_dwaarp_pulse", "decal_tween")
decal_dwaarp_pulse.tween.props[1].name = "scale"
decal_dwaarp_pulse.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.32,
		v(2.4, 2.4)
	}
}
decal_dwaarp_pulse.tween.props[1].sprite_id = 1
decal_dwaarp_pulse.tween.props[2] = E.clone_c(E, "tween_prop")
decal_dwaarp_pulse.tween.props[2].name = "alpha"
decal_dwaarp_pulse.tween.props[2].keys = {
	{
		0,
		255
	},
	{
		0.32,
		0
	}
}
decal_dwaarp_pulse.tween.props[2].sprite_id = 1
decal_dwaarp_pulse.render.sprites[1].animated = false
decal_dwaarp_pulse.render.sprites[1].name = "EarthquakeTower_HitDecal3"
decal_dwaarp_pulse.render.sprites[1].z = Z_DECALS
local decal_dwaarp_scorched = E.register_t(E, "decal_dwaarp_scorched", "decal_tween")
decal_dwaarp_scorched.tween.props[1].name = "alpha"
decal_dwaarp_scorched.tween.props[1].keys = {
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
decal_dwaarp_scorched.render.sprites[1].animated = false
decal_dwaarp_scorched.render.sprites[1].name = "EarthquakeTower_Lava1"
decal_dwaarp_scorched.render.sprites[1].z = Z_DECALS
local decal_dwaarp_tower_scorched = E.register_t(E, "decal_dwaarp_tower_scorched", "decal_tween")
decal_dwaarp_tower_scorched.tween.props[1].name = "alpha"
decal_dwaarp_tower_scorched.tween.props[1].keys = {
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
decal_dwaarp_tower_scorched.render.sprites[1].animated = false
decal_dwaarp_tower_scorched.render.sprites[1].name = "EarthquakeTower_Lava"
decal_dwaarp_tower_scorched.render.sprites[1].z = Z_DECALS
local decal_dwaarp_scorched_water = E.register_t(E, "decal_dwaarp_scorched_water", "decal_timed")
decal_dwaarp_scorched_water.timed.duration = 3
decal_dwaarp_scorched_water.timed.runs = nil
decal_dwaarp_scorched_water.render.sprites[1].prefix = "towerdwaarp_sfx"
decal_dwaarp_scorched_water.render.sprites[1].name = "vapor"
decal_dwaarp_scorched_water.render.sprites[1].z = Z_OBJECTS
decal_dwaarp_scorched_water.render.sprites[1].loop = true
tt = E.register_t(E, "pop_crit", "pop")
tt.render.sprites[1].name = "pop_0003"
tt = E.register_t(E, "pop_headshot", "pop")
tt.render.sprites[1].name = "pop_0007"
local arrow_1 = E.register_t(E, "arrow_1", "arrow")
arrow_1.bullet.damage_min = 4
arrow_1.bullet.damage_max = 6
local arrow_2 = E.register_t(E, "arrow_2", "arrow")
arrow_2.bullet.damage_min = 7
arrow_2.bullet.damage_max = 11
local arrow_3 = E.register_t(E, "arrow_3", "arrow")
arrow_3.bullet.damage_min = 10
arrow_3.bullet.damage_max = 16
local arrow_crossbow = E.register_t(E, "arrow_crossbow", "arrow")
arrow_crossbow.bullet.flight_time = fts(16)
arrow_crossbow.bullet.damage_min = 15
arrow_crossbow.bullet.damage_max = 23
arrow_crossbow.bullet.pop = {
	"pop_shunt_violet"
}
tt = E.register_t(E, "arrow_desert_archer", "arrow")

E.add_comps(E, tt, "endless")

tt.bullet.damage_min = 20
tt.bullet.damage_max = 30
tt.bullet.pop = nil
tt.bullet.predict_target_pos = false
tt.bullet.prediction_error = false
tt.endless.factor_map = {
	{
		"enemy_desert_archer.rangedDamage",
		"bullet.damage_min",
		true
	},
	{
		"enemy_desert_archer.rangedDamage",
		"bullet.damage_max",
		true
	}
}
tt = E.register_t(E, "arrow_hammerhold", "arrow")
tt.bullet.damage_min = 5
tt.bullet.damage_max = 10
local axe_totem = E.register_t(E, "axe_totem", "arrow")
axe_totem.render.sprites[1].name = "TotemAxe_0001"
axe_totem.render.sprites[1].animated = false
axe_totem.bullet.rotation_speed = (FPS*30*math.pi)/180
axe_totem.bullet.miss_decal = "TotemAxe_0002"
axe_totem.bullet.damage_min = 25
axe_totem.bullet.damage_max = 40
axe_totem.bullet.pop = {
	"pop_thunk"
}
axe_totem.bullet.pop_chance = 1
axe_totem.bullet.pop_conds = DR_KILL
axe_totem.sound_events.insert = "AxeSound"
local multishot_crossbow = E.register_t(E, "multishot_crossbow", "shotgun")
multishot_crossbow.bullet.damage_type = DAMAGE_PHYSICAL
multishot_crossbow.bullet.min_speed = FPS*20
multishot_crossbow.bullet.max_speed = FPS*20
multishot_crossbow.bullet.damage_min = 30
multishot_crossbow.bullet.damage_max = 40
multishot_crossbow.bullet.hide_radius = 12
multishot_crossbow.bullet.hit_blood_fx = "fx_blood_splat"
multishot_crossbow.bullet.miss_fx = "fx_smoke_bullet"
multishot_crossbow.bullet.miss_fx_water = "fx_splash_small"
multishot_crossbow.render.sprites[1].name = "proy_crossbow_special"
multishot_crossbow.render.sprites[1].animated = false
multishot_crossbow.sound_events.insert = "ArrowSound"
local bomb_mecha = E.register_t(E, "bomb_mecha", "bomb")
bomb_mecha.render.sprites[1].name = "mech_bomb"
bomb_mecha.bullet.flight_time = fts(26)
bomb_mecha.bullet.hit_fx = "fx_explosion_fragment"
bomb_mecha.bullet.damage_min = 25
bomb_mecha.bullet.damage_max = 55
bomb_mecha.bullet.damage_radius = 57.599999999999994
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
tt.main_script.update = scripts.pirate_exploding_barrel.update
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

tt.main_script.update = scripts.decal_kraken.update
tt.render.sprites[1].prefix = "kraken_water"
tt.render.sprites[1].z = Z_DECALS
tt.duration = 3
local missile_mecha = E.register_t(E, "missile_mecha", "bullet")
missile_mecha.render.sprites[1].prefix = "missile_mecha"
missile_mecha.render.sprites[1].loop = true
missile_mecha.bullet.damage_type = DAMAGE_EXPLOSION
missile_mecha.bullet.min_speed = 300
missile_mecha.bullet.max_speed = 450
missile_mecha.bullet.turn_speed = (math.pi*10)/180*30
missile_mecha.bullet.acceleration_factor = 0.1
missile_mecha.bullet.hit_fx = "fx_explosion_air"
missile_mecha.bullet.hit_fx_air = "fx_explosion_air"
missile_mecha.bullet.hit_fx_water = "fx_explosion_water"
missile_mecha.bullet.damage_min = 20
missile_mecha.bullet.damage_max = 80
missile_mecha.bullet.damage_radius = 41.25
missile_mecha.bullet.vis_flags = F_RANGED
missile_mecha.bullet.damage_flags = F_AREA
missile_mecha.bullet.particles_name = "ps_missile_mecha"
missile_mecha.bullet.retarget_range = 99999
missile_mecha.main_script.insert = scripts.missile.insert
missile_mecha.main_script.update = scripts.missile.update
missile_mecha.sound_events.insert = "RocketLaunchSound"
missile_mecha.sound_events.hit = "BombExplosionSound"
missile_mecha.sound_events.hit_water = "RTWaterExplosion"
tt = E.register_t(E, "bolt_1", "bolt")
tt.bullet.damage_min = 9
tt.bullet.damage_max = 17
tt = E.register_t(E, "bolt_2", "bolt")
tt.bullet.damage_min = 23
tt.bullet.damage_max = 43
tt = E.register_t(E, "bolt_3", "bolt")
tt.bullet.damage_min = 40
tt.bullet.damage_max = 74
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
tt = E.register_t(E, "bolt_necromancer", "bolt")
tt.render.sprites[1].prefix = "bolt_necromancer"
tt.bullet.damage_min = 20
tt.bullet.damage_max = 70
tt.bullet.hit_fx = "fx_bolt_necromancer_hit"
tt.bullet.particles_name = "ps_bolt_necromancer_trail"
tt.bullet.pop = {
	"pop_sishh"
}
tt.sound_events.insert = "NecromancerBolt"
tt = E.register_t(E, "bolt_blast", "bullet")
tt.main_script.insert = scripts.bolt_blast.insert
tt.main_script.update = scripts.bolt_blast.update
tt.render.sprites[1].prefix = "bolt_blast"
tt.render.sprites[1].name = "hit"
tt.bullet.damage_type = DAMAGE_MAGICAL
tt.bullet.damage_min = 0
tt.bullet.damage_max = 0
tt.bullet.damage_inc = 25
tt.bullet.damage_radius = 50
tt.bullet.damage_radius_inc = 0.1
tt.bullet.damage_flags = F_AREA
tt.sound_events.insert = "ArchmageCriticalExplosion"
tt = E.register_t(E, "drill", "bullet")
tt.bullet.pop = {
	"pop_splat"
}
tt.render.sprites[1].anchor = v(0.5, 0.3)
tt.render.sprites[1].prefix = "drill"
tt.render.sprites[1].name = "ground"
tt.render.sprites[1].z = Z_OBJECTS
tt.hit_time = fts(3)
tt.main_script.update = scripts.drill.update
tt.sound_events.insert = "EarthquakeDrillOut"
tt = E.register_t(E, "ray_neptune", "bullet")
tt.image_width = 358
tt.main_script.update = scripts.ray_neptune.update
tt.render.sprites[1].name = "ray_neptune"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min_levels = {
	250,
	500,
	1000
}
tt.bullet.damage_max_levels = {
	750,
	1500,
	2000
}
tt.bullet.damage_radius = 38.4
tt.bullet.damage_rect = r(-40, -2, 80, 50)
tt.bullet.hit_fx = "fx_ray_neptune_explosion"
tt.sound_events.insert = "PolymorphSound"
tt = E.register_t(E, "fx_ray_neptune_explosion", "decal_timed")
tt.render.sprites[1].name = "ray_neptune_explosion"
tt.render.sprites[1].anchor.y = 0.24444444444444444
tt.render.sprites[1].z = Z_BULLETS
tt = E.register_t(E, "ray_bluegale", "bullet")
tt.image_width = 120
tt.main_script.update = scripts.ray_enemy.update
tt.render.sprites[1].name = "ray_bluegale"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min = 25
tt.bullet.damage_max = 45
tt.bullet.max_track_distance = 50
tt.bullet.hit_time = fts(5)
tt.sound_events.insert = "SaurianSavantAttack"
local oil_mecha = E.register_t(E, "oil_mecha", "aura")

E.add_comps(E, oil_mecha, "render", "tween")

oil_mecha.aura.mod = "mod_slow_oil"
oil_mecha.aura.duration = 2
oil_mecha.aura.duration_inc = 2
oil_mecha.aura.cycle_time = 0.3
oil_mecha.aura.radius = 51.2
oil_mecha.aura.vis_bans = bor(F_FRIEND, F_FLYING)
oil_mecha.aura.vis_flags = F_MOD
oil_mecha.main_script.insert = scripts.aura_apply_mod.insert
oil_mecha.main_script.update = scripts.aura_apply_mod.update
oil_mecha.render.sprites[1].animated = false
oil_mecha.render.sprites[1].name = "Mecha_Shit"
oil_mecha.render.sprites[1].z = Z_DECALS
oil_mecha.tween.props[1].name = "alpha"
oil_mecha.tween.props[1].keys = {
	{
		"this.actual_duration-0.6",
		255
	},
	{
		"this.actual_duration",
		0
	}
}
oil_mecha.tween.props[2] = E.clone_c(E, "tween_prop")
oil_mecha.tween.props[2].name = "scale"
oil_mecha.tween.props[2].keys = {
	{
		0,
		v(0.6, 0.6)
	},
	{
		0.3,
		v(1, 1)
	}
}
oil_mecha.tween.remove = false
oil_mecha.sound_events.insert = "MechOil"
tt = E.register_t(E, "necromancer_aura", "aura")
tt.main_script.update = scripts.necromancer_aura.update
tt.aura.cycle_time = 0.5
tt.aura.duration = -1
tt.min_health_for_knight = 500
tt.count_group_name = "skeletons"
tt.count_group_type = COUNT_GROUP_CONCURRENT
tt.count_group_max = 32
tt.max_skeletons_tower = 8
local death_rider_aura = E.register_t(E, "death_rider_aura", "aura")

E.add_comps(E, death_rider_aura, "render")

death_rider_aura.aura.mod = "mod_death_rider"
death_rider_aura.aura.cycle_time = 1
death_rider_aura.aura.duration = -1
death_rider_aura.aura.radius = 140
death_rider_aura.aura.track_source = true
death_rider_aura.aura.allowed_templates = {
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"soldier_sand_warrior",
	"soldier_dracolich_golem",
	"soldier_elemental",
	"soldier_frankenstein"
}
death_rider_aura.aura.vis_bans = F_ENEMY
death_rider_aura.aura.vis_flags = F_MOD
death_rider_aura.main_script.insert = scripts.aura_apply_mod.insert
death_rider_aura.main_script.update = scripts.aura_apply_mod.update
death_rider_aura.render.sprites[1].name = "soldier_death_rider_aura"
death_rider_aura.render.sprites[1].loop = true
death_rider_aura.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "bluegale_clouds_aura", "aura")

E.add_comps(E, tt, "sound_events")

tt.main_script.insert = scripts.bluegale_clouds.insert
tt.main_script.update = scripts.bluegale_clouds.update
tt.aura.duration = 10
tt.clouds_min_radius = 35
tt.clouds_max_radius = 55
tt.clouds_count = 6
tt.sound_events.insert = "RTBluegaleStormSummon"
tt = E.register_t(E, "decal_bluegale_cloud_dark", "decal_tween")

E.add_comps(E, tt, "ui")

tt.ui.click_rect = r(-58, -31, 116, 62)
tt.ui.z = 999
tt.tween.remove = true
tt.tween.props[1].name = "alpha"
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		v(0, 3)
	},
	{
		1,
		v(0, -3)
	},
	{
		2,
		v(0, 3)
	}
}
tt.tween.props[2].name = "offset"
tt.tween.props[2].loop = true
tt.render.sprites[1].name = "Bluegale_stormCloud_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E.register_t(E, "decal_bluegale_cloud_bright", "decal_tween")
tt.tween.remove = true
tt.tween.props[1].name = "alpha"
tt.tween.props[1].loop = true
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		v(0, 3)
	},
	{
		1,
		v(0, -3)
	},
	{
		2,
		v(0, 3)
	}
}
tt.tween.props[2].name = "offset"
tt.tween.props[2].loop = true
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "hidden"
tt.render.sprites[1].name = "Bluegale_stormCloud_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E.register_t(E, "decal_bluegale_cloud_shadow", "decal_tween")
tt.tween.remove = true
tt.tween.props[1].name = "alpha"
tt.render.sprites[1].name = "atomicBomb_shadow"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_SKY
tt = E.register_t(E, "bluegale_heal_aura", "aura")
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.mod = "mod_bluegale_heal"
tt.aura.vis_bans = F_FRIEND
tt.aura.vis_flags = F_MOD
tt.aura.cycle_time = 1
tt.aura.duration = 10
tt.aura.radius = 50
tt = E.register_t(E, "bluegale_damage_aura", "aura")
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.mod = "mod_bluegale_damage"
tt.aura.vis_bans = F_ENEMY
tt.aura.vis_flags = F_MOD
tt.aura.cycle_time = 1
tt.aura.duration = 10
tt.aura.radius = 50
local totem_silence = E.register_t(E, "totem_silence", "aura")

E.add_comps(E, totem_silence, "render", "tween")

totem_silence.aura.mod = "mod_silence_totem"
totem_silence.aura.cycle_time = 0.3
totem_silence.aura.duration = 2
totem_silence.aura.duration_inc = 2
totem_silence.aura.radius = 76.8
totem_silence.aura.vis_bans = F_BOSS
totem_silence.aura.vis_flags = F_MOD
totem_silence.render.sprites[1].name = "TotemTower_GroundEffect-Violet_0002"
totem_silence.render.sprites[1].animated = false
totem_silence.render.sprites[1].scale = v(0.64, 0.64)
totem_silence.render.sprites[1].alpha = 50
totem_silence.render.sprites[1].z = Z_DECALS
totem_silence.render.sprites[2] = E.clone_c(E, "sprite")
totem_silence.render.sprites[2].name = "TotemTower_GroundEffect-Violet_0001"
totem_silence.render.sprites[2].animated = false
totem_silence.render.sprites[2].z = Z_DECALS
totem_silence.render.sprites[3] = E.clone_c(E, "sprite")
totem_silence.render.sprites[3].prefix = "totem_violet"
totem_silence.render.sprites[3].name = "start"
totem_silence.render.sprites[3].loop = false
totem_silence.render.sprites[3].anchor = v(0.5, 0.11)
totem_silence.main_script.update = scripts.aura_totem.update
totem_silence.sound_events.insert = "TotemSpirits"
totem_silence.tween.remove = false
totem_silence.tween.props[1].name = "scale"
totem_silence.tween.props[1].keys = {
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
totem_silence.tween.props[1].loop = true
totem_silence.tween.props[2] = E.clone_c(E, "tween_prop")
totem_silence.tween.props[2].keys = {
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
totem_silence.tween.props[2].loop = true
local totem_weakness = E.register_t(E, "totem_weakness", "totem_silence")
totem_weakness.aura.mod = "mod_weakness_totem"
totem_weakness.aura.duration = 0
totem_weakness.aura.duration_inc = 3
totem_weakness.aura.vis_bans = 0
totem_weakness.render.sprites[1].name = "TotemTower_GroundEffect-Red_0002"
totem_weakness.render.sprites[2].name = "TotemTower_GroundEffect-Red_0001"
totem_weakness.render.sprites[3].prefix = "totem_red"
totem_weakness.render.sprites[3].anchor = v(0.45, 0.17)
totem_weakness.sound_events.insert = "TotemWeakness"
local twister = E.register_t(E, "twister", "aura")

E.add_comps(E, twister, "nav_path", "motion", "render")

twister.main_script.insert = scripts.twister.insert
twister.main_script.update = scripts.twister.update
twister.damage_type = DAMAGE_MAGICAL
twister.pickup_range = 25.6
twister.max_times_applied = 3
twister.motion.max_speed = 46.08
twister.damage_min = 50
twister.damage_max = 50
twister.damage_inc = 50
twister.damage_type = DAMAGE_TRUE
twister.enemies_max = 4
twister.enemies_inc = 1
twister.nodes = 15
twister.nodes_inc = 5
twister.nodes_limit = 15
twister.picked_enemies = {}
twister.render.sprites[1].prefix = "twister"
twister.render.sprites[1].anchor.y = 0.14
twister.aura.vis_flags = bor(F_RANGED, F_TWISTER)
twister.aura.vis_bans = bor(F_CLIFF, F_BOSS)
tt = E.register_t(E, "kraken_aura", "aura")
tt.main_script.insert = scripts.kraken_aura.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.mod = "mod_stun_kraken"
tt.aura.cycle_time = fts(10)
tt.aura.duration = 3
tt.aura.radius = 40
tt.aura.vis_flags = bor(F_RANGED)
tt.aura.vis_bans = bor(F_BOSS, F_FLYING, F_WATER, F_CLIFF, F_FRIEND, F_HERO)
tt.max_active_targets = 2
tt.active_targets_count = 0
tt = E.register_t(E, "kraken_aura_slow", "aura")
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.mod = "mod_slow_kraken"
tt.aura.cycle_time = fts(10)
tt.aura.duration = 3
tt.aura.radius = 40
tt.aura.vis_flags = bor(F_RANGED)
tt.aura.vis_bans = bor(F_BOSS, F_FLYING, F_WATER, F_CLIFF, F_FRIEND, F_HERO)
local pestilence = E.register_t(E, "pestilence", "aura")
pestilence.aura.mod = "mod_pestilence"
pestilence.aura.duration = 3
pestilence.aura.duration_inc = 1
pestilence.aura.cycle_time = fts(10)
pestilence.aura.radius = 55
pestilence.aura.vis_bans = bor(F_FRIEND, F_FLYING)
pestilence.aura.vis_flags = bor(F_MOD, F_POISON)
pestilence.main_script.insert = scripts.pestilence.insert
pestilence.main_script.update = scripts.aura_apply_mod.update
pestilence.sound_events.insert = "NecromancerPestilence"
local ps_bolt_archmage_trail = E.register_t(E, "ps_bolt_archmage_trail")

E.add_comps(E, ps_bolt_archmage_trail, "pos", "particle_system")

ps_bolt_archmage_trail.particle_system.name = "proy_archbolt_particle"
ps_bolt_archmage_trail.particle_system.animated = false
ps_bolt_archmage_trail.particle_system.particle_lifetime = {
	0.2,
	0.2
}
ps_bolt_archmage_trail.particle_system.alphas = {
	255,
	12
}
ps_bolt_archmage_trail.particle_system.scales_y = {
	0.8,
	0.05
}
ps_bolt_archmage_trail.particle_system.emission_rate = 30
local ps_bolt_necromancer_trail = E.register_t(E, "ps_bolt_necromancer_trail")

E.add_comps(E, ps_bolt_necromancer_trail, "pos", "particle_system")

ps_bolt_necromancer_trail.particle_system.name = "proy_Necromancer_particle"
ps_bolt_necromancer_trail.particle_system.animated = false
ps_bolt_necromancer_trail.particle_system.particle_lifetime = {
	0.4,
	2
}
ps_bolt_necromancer_trail.particle_system.alphas = {
	255,
	0
}
ps_bolt_necromancer_trail.particle_system.scales_x = {
	1,
	3.5
}
ps_bolt_necromancer_trail.particle_system.scales_y = {
	1,
	3.5
}
ps_bolt_necromancer_trail.particle_system.scale_var = {
	0.45,
	0.9
}
ps_bolt_necromancer_trail.particle_system.scale_same_aspect = false
ps_bolt_necromancer_trail.particle_system.emit_spread = math.pi
ps_bolt_necromancer_trail.particle_system.emission_rate = 30
tt = E.register_t(E, "ps_missile_mecha", "ps_missile")
tt = E.register_t(E, "ps_bomb_volcano")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.alphas = {
	200,
	0
}
tt.particle_system.animated = false
tt.particle_system.emission_rate = 60
tt.particle_system.emit_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "Stage9_lavaShotParticle"
tt.particle_system.particle_lifetime = {
	0.4,
	0.6
}
tt.particle_system.scale_same_aspect = true
tt.particle_system.scale_var = {
	0.6,
	1.2
}
tt.particle_system.scales_x = {
	1,
	1.5
}
tt.particle_system.scales_y = {
	1,
	1.5
}
tt = E.register_t(E, "ps_bomb_gunboat", "ps_bomb_volcano")
tt.particle_system.name = "bomb_gunboat_particle"
tt.particle_system.animated = true
tt.particle_system.emission_rate = 120
tt.particle_system.particle_lifetime = {
	0.15,
	0.25
}
tt.particle_system.scales_x = {
	1,
	1.7
}
tt.particle_system.scales_y = {
	1,
	1.7
}
tt.particle_system.scale_var = {
	0.8,
	1.2
}
tt = E.register_t(E, "tower_holder")

E.add_comps(E, tt, "tower", "tower_holder", "pos", "render", "ui", "editor", "editor_script")

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
tt = E.register_t(E, "tower_holder_desert", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_DESERT
tt.render.sprites[1].name = "build_terrain_0004"
tt = E.register_t(E, "tower_holder_jungle", "tower_holder")
tt.tower.terrain_style = TERRAIN_STYLE_JUNGLE
tt.render.sprites[1].name = "build_terrain_0005"
tt = E.register_t(E, "tower_holder_blocked")

E.add_comps(E, tt, "tower", "tower_holder", "pos", "render", "ui", "sound_events")

tt.tower.level = 1
tt.tower.can_be_mod = false
tt.tower_holder.blocked = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "build_terrain_blocked_%04i"
tt.render.sprites[1].offset = v(0, 17)
tt.render.sprites[1].z = Z_DECALS
tt.ui.click_rect = r(-40, -12, 80, 46)
tt.sound_events.remove = "GUITowerSell"
tt = E.register_t(E, "tower_holder_blocked_jungle", "tower_holder_blocked")
tt.tower.type = "holder_blocked_jungle"
tt.tower_holder.unblock_price = 100
tt = E.register_t(E, "tower_holder_blocked_underground", "tower_holder_blocked")
tt.tower.type = "holder_blocked_underground"
tt.tower_holder.unblock_price = 200
tt = E.register_t(E, "tower_build_archer", "tower_build")
tt.build_name = "tower_archer_1"
tt.render.sprites[2].name = "tower_constructing_4_barracks"
tt.render.sprites[2].offset = v(0, 39)
tt = E.register_t(E, "tower_build_barrack", "tower_build_archer")
tt.build_name = "tower_barrack_1"
tt.render.sprites[2].name = "tower_constructing_2_archer"
tt.render.sprites[2].offset = v(0, 40)
tt = E.register_t(E, "tower_build_mage", "tower_build_archer")
tt.build_name = "tower_mage_1"
tt.render.sprites[2].name = "tower_constructing_3_mage"
tt.render.sprites[2].offset = v(0, 31)
tt = E.register_t(E, "tower_build_engineer", "tower_build_archer")
tt.build_name = "tower_engineer_1"
tt.render.sprites[2].name = "tower_constructing_1_artillery"
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
tt.attacks.range = 140
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
tt.attacks.range = 180
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
tt.tower.price = 300
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
tt.attacks.list[2].vis_flags = bor(F_RANGED)
tt.attacks.list[2].vis_bans = bor(F_BOSS)
tt.attacks.list[2].sound = "TowerHighMageTimecast"
tt.attacks.list[3] = E.clone_c(E, "custom_attack")
tt.powers.timelapse = E.clone_c(E, "power")
tt.powers.timelapse.attack_idx = 2
tt.powers.timelapse.price_base = 225
tt.powers.timelapse.price_inc = 225
tt.powers.timelapse.target_count = {
	2,
	3,
	4
}
tt.powers.timelapse.enc_icon = 18
tt.powers.sentinel = E.clone_c(E, "power")
tt.powers.sentinel.attack_idx = 3
tt.powers.sentinel.max_level = 2
tt.powers.sentinel.price_base = 300
tt.powers.sentinel.price_inc = 300
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

tt.charge_time = 4
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
tt.wait_time = 5
tt.wait_spent_time = 1
tt.particles_name = "ps_high_elven_sentinel"
tt.ranged.attacks[1].bullet = "ray_high_elven_sentinel"
tt.ranged.attacks[1].shoot_time = fts(9)
tt.ranged.attacks[1].cooldown = 0.5
tt.ranged.attacks[1].search_cooldown = 0.25
tt.ranged.attacks[1].shoot_range = 25
tt.ranged.attacks[1].launch_range = 300
tt.ranged.attacks[1].max_range = 200
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
tt.attacks.range = 150
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "rock_1"
tt.attacks.list[1].cooldown = 3
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
tt.attacks.range = 170
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
tt.attacks.range = 190
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
tt.tower.price = 375
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
tt.powers.nature.price_base = 350
tt.powers.nature.price_inc = 350
tt.powers.nature.max_level = 2
tt.powers.nature.entity = "druid_shooter_nature"
tt.powers.nature.enc_icon = 12
tt.powers.nature.name = "NATURES_FRIEND"
tt.powers.sylvan = E.clone_c(E, "power")
tt.powers.sylvan.price_base = 250
tt.powers.sylvan.price_inc = 250
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
tt.attacks.list[1].cooldown = 15
tt.attacks.list[1].range = 175
tt.attacks.list[1].excluded_templates = {
	"enemy_ogre_magi"
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
tt.attacks.list[2].cooldown = 25.5
tt.attacks.list[2].animation = "special1"
tt.attacks.list[3] = E.clone_c(E, "area_attack")
tt.attacks.list[3].animation = "special2"
tt.attacks.list[3].cooldown = 14
tt.attacks.list[3].damage_bans = F_FLYING
tt.attacks.list[3].damage_flags = F_AREA
tt.attacks.list[3].damage_radius = 225
tt.attacks.list[3].damage_type = DAMAGE_TRUE
tt.attacks.list[3].hit_time = fts(20)
tt.attacks.list[3].min_count = 2
tt.attacks.list[3].range = 195
tt.attacks.list[3].sound = "TowerEntwoodClobber"
tt.attacks.list[3].stun_chances = {
	1,
	1,
	0.75,
	0.5
}
tt.attacks.list[3].stun_mod = "mod_clobber"
tt.attacks.list[3].vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[3].vis_flags = F_RANGED
tt.powers.clobber = E.clone_c(E, "power")
tt.powers.clobber.price_base = 225
tt.powers.clobber.price_inc = 225
tt.powers.clobber.attack_idx = 3
tt.powers.clobber.stun_durations = {
	1,
	2,
	3
}
tt.powers.clobber.damage_values = {
	75,
	100,
	125
}
tt.powers.clobber.enc_icon = 14
tt.powers.fiery_nuts = E.clone_c(E, "power")
tt.powers.fiery_nuts.price_base = 330
tt.powers.fiery_nuts.price_inc = 330
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
tt.render.sprites[3].prefix = "tower_barrack_1_door"
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "ElvesBarrackTaunt"
tt.sound_events.insert = "ElvesBarrackTaunt"
tt.tower.level = 1
tt.tower.price = 100
tt.tower.type = "elven_barrack"
tt = E.register_t(E, "tower_barrack_1_s", "tower")

E.add_comps(E, tt, "barrack")

tt.barrack.rally_range = 9e+99
tt.barrack.respawn_offset = v(0, 0)
tt.barrack.soldier_type = "hero_dracolich"
tt.barrack.max_soldiers = 1
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
tt.render.sprites[3].prefix = "tower_barrack_1_door"
tt.sound_events.mute_on_level_insert = true
tt.sound_events.change_rally_point = "ElvesBarrackTaunt"
tt.sound_events.insert = "ElvesBarrackTaunt"
tt.tower.level = 1
tt.tower.price = 100
tt.tower.type = "barrack"
tt = E.register_t(E, "tower_elven_barrack_2", "tower_elven_barrack_1")
tt.info.enc_icon = 6
tt.barrack.soldier_type = "soldier_barrack_2"
tt.render.sprites[2].name = "barracks_towers_layer1_0026"
tt.render.sprites[3].prefix = "tower_barrack_2_door"
tt.tower.level = 2
tt.tower.price = 160
tt = E.register_t(E, "tower_elven_barrack_3", "tower_elven_barrack_1")
tt.info.enc_icon = 10
tt.barrack.soldier_type = "soldier_barrack_3"
tt.render.sprites[2].name = "barracks_towers_layer1_0051"
tt.render.sprites[3].prefix = "tower_barrack_3_door"
tt.tower.level = 3
tt.tower.price = 250
tt = RT("tower_drow", "tower_elven_barrack_1")

AC(tt, "powers")

tt.barrack.soldier_type = "soldier_drow"
tt.info.i18n_key = "ELVES_TOWER_SPECIAL_DROW"
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_0016"
tt.powers.life_drain = CC("power")
tt.powers.life_drain.price_base = 250
tt.powers.life_drain.price_inc = 250
tt.powers.double_dagger = CC("power")
tt.powers.double_dagger.price_base = 225
tt.powers.double_dagger.price_inc = 225
tt.powers.double_dagger.max_level = 1
tt.powers.blade_mail = CC("power")
tt.powers.blade_mail.price_base = 135
tt.powers.blade_mail.price_inc = 135
tt.render.sprites[1].name = "terrains_0003"
tt.render.sprites[2].name = "mercenaryDraw_tower_layer1_0001"
tt.render.sprites[2].offset = v(0, 29)
tt.render.sprites[3].prefix = "tower_drow_door"
tt.render.sprites[3].offset = v(0, 29)
tt.sound_events.insert = "ElvesDrowTaunt"
tt.sound_events.change_rally_point = "ElvesDrowTaunt"
tt.sound_events.mute_on_level_insert = true
tt.tower.price = 280
tt.tower.type = "drow"

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
tt.info.fn = scripts2.soldier_barrack.get_info
tt.info.portrait = "portraits_sc_0138"
tt.info.random_name_count = 25
tt.info.random_name_format = "ELVES_SOLDIER_BARRACKS_%i_NAME"
tt.main_script.insert = scripts2.soldier_barrack.insert
tt.main_script.remove = scripts2.soldier_barrack.remove
tt.main_script.update = scripts2.soldier_barrack.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 4
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(5)
tt.melee.attacks[1].pop = {
	"pop_barrack1",
	"pop_barrack2"
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
tt.revive.disabled = true
tt.revive.chance = 0.1
tt.revive.health_recover = 1
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
tt.info.portrait = "portraits_sc_0139"
tt.melee.attacks[1].damage_max = 7
tt.melee.attacks[1].damage_min = 3
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
tt.info.portrait = "portraits_sc_0140"
tt.melee.attacks[1].damage_max = 12
tt.melee.attacks[1].damage_min = 8
tt.ranged.attacks[1].bullet = "arrow_soldier_barrack_3"
tt.ranged.attacks[1].cooldown = fts(15) + 1
tt.ranged.attacks[1].max_range = 150
tt.ranged.attacks[1].min_range = 25
tt.regen.health = 15
tt.render.sprites[1].prefix = "soldier_barrack_3"
tt.unit.mod_offset = v(0, 12)

tt = E.register_t(E, "soldier_druid_bear", "soldier_militia")

E.add_comps(E, tt, "melee", "count_group")

tt.count_group.name = "soldier_druid_bear"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.health.armor = 0.2
tt.health.hp_max = 250
tt.health_bar.offsets = {
	idle = v(0, 40),
	standing = v(0, 55)
}
tt.health_bar.offset = tt.health_bar.offsets.idle
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health.dead_lifetime = 20
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = "portraits_sc_0141"
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
tt.regen.cooldown = 1
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
tt.vis.bans = bor(F_POISON)
tt = RT("soldier_drow", "soldier_barrack_1")

AC(tt, "powers", "ranged", "track_damage")

tt.health.armor = 0.6
tt.health.dead_lifetime = 15
tt.health.hp_max = 180
tt.health.spiked_armor = 0
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0004") or "info_portraits_sc_0199"
tt.info.random_name_format = "ELVES_SOLDIER_DROW_%i_NAME"
tt.info.random_name_count = 15
tt.main_script.insert = scripts2.soldier_drow.insert
tt.main_script.update = scripts2.soldier_drow.update
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 14
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].forced_cooldown = true
tt.melee.attacks[2] = CC("melee_attack")
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].animation = "healAttack"
tt.melee.attacks[2].track_damage = true
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].damage_inc = 50
tt.melee.attacks[2].cooldown = 6
tt.melee.attacks[2].hit_time = fts(12)
tt.melee.attacks[2].power_name = "life_drain"
tt.melee.forced_cooldown = tt.melee.attacks[1].cooldown
tt.melee.range = 55
tt.motion.max_speed = 75
tt.powers.life_drain = CC("power")
tt.powers.double_dagger = CC("power")
tt.powers.blade_mail = CC("power")
tt.powers.blade_mail.spiked_armor = {
	0.2,
	0.4,
	0.6
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
tt.regen.health = 5
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

local tower_mage_1 = E.register_t(E, "tower_mage_1", "tower")

E.add_comps(E, tower_mage_1, "attacks")

tower_mage_1.tower.type = "mage"
tower_mage_1.tower.level = 1
tower_mage_1.tower.price = 100
tower_mage_1.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0003"
tower_mage_1.info.enc_icon = 3
tower_mage_1.info.fn = scripts.tower_mage.get_info
tower_mage_1.main_script.insert = scripts.tower_mage.insert
tower_mage_1.main_script.update = scripts.tower_mage.update
tower_mage_1.attacks.range = 140
tower_mage_1.attacks.list[1] = E.clone_c(E, "bullet_attack")
tower_mage_1.attacks.list[1].animation = "shoot"
tower_mage_1.attacks.list[1].bullet = "bolt_1"
tower_mage_1.attacks.list[1].cooldown = 1.5
tower_mage_1.attacks.list[1].shoot_time = fts(8)
tower_mage_1.attacks.list[1].bullet_start_offset = {
	v(8, 66),
	v(-5, 62)
}
tower_mage_1.render.sprites[1].animated = false
tower_mage_1.render.sprites[1].name = "terrain_mage_%04i"
tower_mage_1.render.sprites[1].offset = v(0, 15)
tower_mage_1.render.sprites[2] = E.clone_c(E, "sprite")
tower_mage_1.render.sprites[2].prefix = "towermagelvl1"
tower_mage_1.render.sprites[2].name = "idle"
tower_mage_1.render.sprites[2].offset = v(0, 30)
tower_mage_1.render.sprites[3] = E.clone_c(E, "sprite")
tower_mage_1.render.sprites[3].prefix = "shootermage"
tower_mage_1.render.sprites[3].name = "idleDown"
tower_mage_1.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tower_mage_1.render.sprites[3].offset = v(1, 60)
tower_mage_1.render.sid_tower = 2
tower_mage_1.render.sid_shooter = 3
tower_mage_1.sound_events.insert = "MageTaunt"
local tower_mage_2 = E.register_t(E, "tower_mage_2", "tower_mage_1")
tower_mage_2.info.enc_icon = 7
tower_mage_2.tower.level = 2
tower_mage_2.tower.price = 160
tower_mage_2.attacks.range = 160
tower_mage_2.attacks.list[1].bullet = "bolt_2"
tower_mage_2.attacks.list[1].bullet_start_offset = {
	v(8, 66),
	v(-5, 64)
}
tower_mage_2.render.sprites[2].prefix = "towermagelvl2"
tower_mage_2.render.sprites[3].offset = v(1, 60)
local tower_mage_3 = E.register_t(E, "tower_mage_3", "tower_mage_1")
tower_mage_3.info.enc_icon = 11
tower_mage_3.tower.level = 3
tower_mage_3.tower.price = 240
tower_mage_3.attacks.range = 180
tower_mage_3.attacks.list[1].bullet = "bolt_3"
tower_mage_3.attacks.list[1].bullet_start_offset = {
	v(8, 70),
	v(-5, 69)
}
tower_mage_3.render.sprites[2].prefix = "towermagelvl3"
tower_mage_3.render.sprites[3].offset = v(1, 64)
local tower_archmage = E.register_t(E, "tower_archmage", "tower")

E.add_comps(E, tower_archmage, "attacks", "powers")

tower_archmage.tower.type = "archmage"
tower_archmage.tower.level = 1
tower_archmage.tower.price = 300
tower_archmage.info.fn = scripts.tower_mage.get_info
tower_archmage.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0006"
tower_archmage.info.enc_icon = 16
tower_archmage.powers.twister = E.clone_c(E, "power")
tower_archmage.powers.twister.price_base = 350
tower_archmage.powers.twister.price_inc = 250
tower_archmage.powers.twister.enc_icon = 32
tower_archmage.powers.blast = E.clone_c(E, "power")
tower_archmage.powers.blast.price_base = 200
tower_archmage.powers.blast.price_inc = 200
tower_archmage.powers.blast.name = "CRITICAL"
tower_archmage.powers.blast.enc_icon = 33
tower_archmage.main_script.insert = scripts.tower_archmage.insert
tower_archmage.main_script.remove = scripts.tower_archmage.remove
tower_archmage.main_script.update = scripts.tower_archmage.update
tower_archmage.render.sprites[1].animated = false
tower_archmage.render.sprites[1].name = "terrain_specials_%04i"
tower_archmage.render.sprites[1].offset = v(0, 9)
tower_archmage.render.sprites[2] = E.clone_c(E, "sprite")
tower_archmage.render.sprites[2].animated = false
tower_archmage.render.sprites[2].name = "ArchMageTower"
tower_archmage.render.sprites[2].offset = v(0, 31)
tower_archmage.render.sprites[3] = E.clone_c(E, "sprite")
tower_archmage.render.sprites[3].prefix = "shooterarchmage"
tower_archmage.render.sprites[3].name = "idleDown"
tower_archmage.render.sprites[3].angles = {
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
tower_archmage.render.sprites[3].offset = v(2, 61)
tower_archmage.attacks.range = 198.4
tower_archmage.attacks.list[1] = E.clone_c(E, "bullet_attack")
tower_archmage.attacks.list[1].animation = "shoot"
tower_archmage.attacks.list[1].bullet_start_offset = {
	v(13, 72),
	v(-9, 70)
}
tower_archmage.attacks.list[1].bullet = "bolt_archmage"
tower_archmage.attacks.list[1].cooldown = 1.5
tower_archmage.attacks.list[1].shoot_time = fts(19)
tower_archmage.attacks.list[1].max_stored_bullets = 3
tower_archmage.attacks.list[1].storage_offsets = {
	v(3, 81),
	v(-20, 58),
	v(24, 56)
}
tower_archmage.attacks.list[1].payload_chance = 1
tower_archmage.attacks.list[1].payload_bullet = "bolt_blast"
tower_archmage.attacks.list[2] = E.clone_c(E, "bullet_attack")
tower_archmage.attacks.list[2].vis_flags = bor(F_RANGED, F_TWISTER)
tower_archmage.attacks.list[2].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tower_archmage.attacks.list[2].animation = "twister"
tower_archmage.attacks.list[2].bullet = "twister"
tower_archmage.attacks.list[2].cooldown = 22
tower_archmage.attacks.list[2].shoot_time = fts(17)
tower_archmage.attacks.list[2].chance = 0.1
tower_archmage.attacks.list[2].chance_inc = 5
tower_archmage.attacks.list[2].nodes_limit = 30
tower_archmage.sound_events.insert = "ArchmageTauntReady"
local tower_necromancer = E.register_t(E, "tower_necromancer", "tower")

E.add_comps(E, tower_necromancer, "barrack", "attacks", "powers", "auras", "tween")

tower_necromancer.tower.type = "necromancer"
tower_necromancer.tower.level = 1
tower_necromancer.tower.price = 300
tower_necromancer.info.fn = scripts.tower_mage.get_info
tower_necromancer.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0005"
tower_necromancer.info.enc_icon = 15
tower_necromancer.powers.pestilence = E.clone_c(E, "power")
tower_necromancer.powers.pestilence.price_base = 200
tower_necromancer.powers.pestilence.price_inc = 100
tower_necromancer.powers.pestilence.enc_icon = 35
tower_necromancer.powers.rider = E.clone_c(E, "power")
tower_necromancer.powers.rider.price_base = 300
tower_necromancer.powers.rider.price_inc = 150
tower_necromancer.powers.rider.enc_icon = 34
tower_necromancer.main_script.insert = scripts.tower_necromancer.insert
tower_necromancer.main_script.update = scripts.tower_necromancer.update
tower_necromancer.main_script.remove = scripts.tower_barrack.remove
tower_necromancer.barrack.soldier_type = "soldier_death_rider"
tower_necromancer.barrack.rally_range = 179.20000000000002
tower_necromancer.attacks.range = 198.4
tower_necromancer.attacks.list[1] = E.clone_c(E, "bullet_attack")
tower_necromancer.attacks.list[1].bullet = "bolt_necromancer"
tower_necromancer.attacks.list[1].cooldown = 1
tower_necromancer.attacks.list[1].shoot_time = fts(3)
tower_necromancer.attacks.list[1].bullet_start_offset = {
	v(9, 71),
	v(-9, 71)
}
tower_necromancer.attacks.list[2] = E.clone_c(E, "bullet_attack")
tower_necromancer.attacks.list[2].bullet = "pestilence"
tower_necromancer.attacks.list[2].cooldown = 12
tower_necromancer.attacks.list[2].shoot_time = fts(6)
tower_necromancer.attacks.list[2].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tower_necromancer.attacks.list[2].vis_flags = bor(F_RANGED, F_POISON)
tower_necromancer.auras.list[1] = E.clone_c(E, "aura_attack")
tower_necromancer.auras.list[1].name = "necromancer_aura"
tower_necromancer.auras.list[1].cooldown = 0
tower_necromancer.render.sprites[1].name = "terrain_specials_%04i"
tower_necromancer.render.sprites[1].animated = false
tower_necromancer.render.sprites[1].offset = v(0, 7)
tower_necromancer.render.sprites[2] = E.clone_c(E, "sprite")
tower_necromancer.render.sprites[2].name = "NecromancerTower"
tower_necromancer.render.sprites[2].animated = false
tower_necromancer.render.sprites[2].offset = v(0, 30)
tower_necromancer.render.sprites[3] = E.clone_c(E, "sprite")
tower_necromancer.render.sprites[3].prefix = "shooternecromancer"
tower_necromancer.render.sprites[3].angles = {
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
tower_necromancer.render.sprites[3].offset = v(0, 60)
tower_necromancer.render.sprites[4] = E.clone_c(E, "sprite")
tower_necromancer.render.sprites[4].animated = false
tower_necromancer.render.sprites[4].name = "NecromancerTowerGlow"
tower_necromancer.render.sprites[4].offset = v(0, 34)
tower_necromancer.render.sprites[4].hidden = true
tower_necromancer.render.sprites[5] = E.clone_c(E, "sprite")
tower_necromancer.render.sprites[5].name = "towernecromancer_fx"
tower_necromancer.render.sprites[5].offset = v(0, 52)
tower_necromancer.render.sprites[5].hidden = true
tower_necromancer.tween.remove = false
tower_necromancer.tween.reverse = false
tower_necromancer.tween.props[1].name = "alpha"
tower_necromancer.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		1,
		255
	}
}
tower_necromancer.tween.props[1].sprite_id = 4
tower_necromancer.skeletons_count = 0
tower_necromancer.sound_events.insert = "NecromancerTauntReady"
tower_necromancer.sound_events.change_rally_point = "DeathKnightTaunt"
local tower_engineer_1 = E.register_t(E, "tower_engineer_1", "tower")

E.add_comps(E, tower_engineer_1, "attacks")

tower_engineer_1.tower.type = "engineer"
tower_engineer_1.tower.level = 1
tower_engineer_1.tower.price = 125
tower_engineer_1.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0004"
tower_engineer_1.info.enc_icon = 4
tower_engineer_1.main_script.insert = scripts.tower_engineer.insert
tower_engineer_1.main_script.update = scripts.tower_engineer.update
tower_engineer_1.attacks.range = 160
tower_engineer_1.attacks.list[1] = E.clone_c(E, "bullet_attack")
tower_engineer_1.attacks.list[1].bullet = "bomb"
tower_engineer_1.attacks.list[1].cooldown = 3
tower_engineer_1.attacks.list[1].shoot_time = fts(12)
tower_engineer_1.attacks.list[1].vis_bans = bor(F_FLYING)
tower_engineer_1.attacks.list[1].bullet_start_offset = v(0, 50)
tower_engineer_1.attacks.list[1].node_prediction = true
tower_engineer_1.render.sprites[1].animated = false
tower_engineer_1.render.sprites[1].name = "terrain_artillery_%04i"
tower_engineer_1.render.sprites[1].offset = v(0, 15)

for i = 2, 8, 1 do
	tower_engineer_1.render.sprites[i] = E.clone_c(E, "sprite")
	tower_engineer_1.render.sprites[i].prefix = "towerengineerlvl1_layer" .. i - 1
	tower_engineer_1.render.sprites[i].name = "idle"
	tower_engineer_1.render.sprites[i].offset = v(0, 41)
end

tower_engineer_1.sound_events.insert = "EngineerTaunt"
local tower_engineer_2 = E.register_t(E, "tower_engineer_2", "tower_engineer_1")
tower_engineer_2.info.enc_icon = 8
tower_engineer_2.tower.level = 2
tower_engineer_2.tower.price = 220
tower_engineer_2.attacks.list[1].bullet = "bomb_dynamite"
tower_engineer_2.attacks.list[1].cooldown = 3
tower_engineer_2.attacks.list[1].shoot_time = fts(12)
tower_engineer_2.attacks.list[1].bullet_start_offset = v(0, 53)

for i = 2, 8, 1 do
	tower_engineer_2.render.sprites[i] = E.clone_c(E, "sprite")
	tower_engineer_2.render.sprites[i].prefix = "towerengineerlvl2_layer" .. i - 1
	tower_engineer_2.render.sprites[i].name = "idle"
	tower_engineer_2.render.sprites[i].offset = v(0, 42)
end

local tower_engineer_3 = E.register_t(E, "tower_engineer_3", "tower_engineer_1")
tower_engineer_3.info.enc_icon = 12
tower_engineer_3.tower.level = 3
tower_engineer_3.tower.price = 320
tower_engineer_3.attacks.range = 179.20000000000002
tower_engineer_3.attacks.list[1].bullet = "bomb_black"
tower_engineer_3.attacks.list[1].cooldown = 3
tower_engineer_3.attacks.list[1].shoot_time = fts(12)
tower_engineer_3.attacks.list[1].bullet_start_offset = v(0, 57)

for i = 2, 8, 1 do
	tower_engineer_3.render.sprites[i] = E.clone_c(E, "sprite")
	tower_engineer_3.render.sprites[i].prefix = "towerengineerlvl3_layer" .. i - 1
	tower_engineer_3.render.sprites[i].name = "idle"
	tower_engineer_3.render.sprites[i].offset = v(0, 43)
end

local tower_dwaarp = E.register_t(E, "tower_dwaarp", "tower")

E.add_comps(E, tower_dwaarp, "attacks", "powers")

tower_dwaarp.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0011"
tower_dwaarp.info.enc_icon = 14
tower_dwaarp.tower.type = "dwaarp"
tower_dwaarp.tower.price = 400
tower_dwaarp.powers.drill = E.clone_c(E, "power")
tower_dwaarp.powers.drill.price_base = 400
tower_dwaarp.powers.drill.price_inc = 200
tower_dwaarp.powers.drill.enc_icon = 36
tower_dwaarp.powers.lava = E.clone_c(E, "power")
tower_dwaarp.powers.lava.price_base = 300
tower_dwaarp.powers.lava.price_inc = 250
tower_dwaarp.powers.lava.name = "BLAST"
tower_dwaarp.powers.lava.enc_icon = 37
tower_dwaarp.main_script.insert = scripts.tower_dwaarp.insert
tower_dwaarp.main_script.update = scripts.tower_dwaarp.update
tower_dwaarp.render.sprites[1].animated = false
tower_dwaarp.render.sprites[1].name = "terrain_specials_%04i"
tower_dwaarp.render.sprites[1].offset = v(0, 12)
tower_dwaarp.render.sprites[2] = E.clone_c(E, "sprite")
tower_dwaarp.render.sprites[2].animated = false
tower_dwaarp.render.sprites[2].name = "EarthquakeTower_Base"
tower_dwaarp.render.sprites[2].offset = v(0, 40)
tower_dwaarp.render.sprites[3] = E.clone_c(E, "sprite")
tower_dwaarp.render.sprites[3].prefix = "towerdwaarp"
tower_dwaarp.render.sprites[3].name = "idle"
tower_dwaarp.render.sprites[3].loop = false
tower_dwaarp.render.sprites[3].offset = v(0, 40)
tower_dwaarp.render.sprites[4] = E.clone_c(E, "sprite")
tower_dwaarp.render.sprites[4].prefix = "towerdwaarp"
tower_dwaarp.render.sprites[4].name = "siren"
tower_dwaarp.render.sprites[4].loop = true
tower_dwaarp.render.sprites[4].offset = v(1, 76)
tower_dwaarp.render.sprites[4].hidden = true
tower_dwaarp.render.sprites[5] = E.clone_c(E, "sprite")
tower_dwaarp.render.sprites[5].prefix = "towerdwaarp"
tower_dwaarp.render.sprites[5].name = "lights"
tower_dwaarp.render.sprites[5].loop = true
tower_dwaarp.render.sprites[5].offset = (IS_PHONE_OR_TABLET and v(0, 40)) or v(-3, 40)
tower_dwaarp.render.sprites[5].hidden = true
tower_dwaarp.attacks.range = 179.20000000000002
tower_dwaarp.attacks.list[1] = E.clone_c(E, "area_attack")
tower_dwaarp.attacks.list[1].vis_flags = F_RANGED
tower_dwaarp.attacks.list[1].vis_bans = F_FLYING
tower_dwaarp.attacks.list[1].damage_flags = F_AREA
tower_dwaarp.attacks.list[1].damage_bans = F_FLYING
tower_dwaarp.attacks.list[1].cooldown = 3
tower_dwaarp.attacks.list[1].hit_time = fts(13)
tower_dwaarp.attacks.list[1].mod = "mod_slow_dwaarp"
tower_dwaarp.attacks.list[1].damage_min = 25
tower_dwaarp.attacks.list[1].damage_max = 45
tower_dwaarp.attacks.list[1].sound = "EarthquakeAttack"
tower_dwaarp.attacks.list[2] = E.clone_c(E, "bullet_attack")
tower_dwaarp.attacks.list[2].bullet = "lava"
tower_dwaarp.attacks.list[2].cooldown = 15
tower_dwaarp.attacks.list[2].hit_time = fts(13)
tower_dwaarp.attacks.list[2].sound = "EarthquakeLavaSmash"
tower_dwaarp.attacks.list[3] = E.clone_c(E, "bullet_attack")
tower_dwaarp.attacks.list[3].vis_flags = bit.bor(F_DRILL, F_RANGED)
tower_dwaarp.attacks.list[3].vis_bans = bit.bor(F_FLYING, F_CLIFF, F_BOSS)
tower_dwaarp.attacks.list[3].bullet = "drill"
tower_dwaarp.attacks.list[3].cooldown = 29
tower_dwaarp.attacks.list[3].cooldown_inc = -3
tower_dwaarp.attacks.list[3].hit_time = fts(46)
tower_dwaarp.attacks.list[3].sound = "EarthquakeDrillIn"
tower_dwaarp.sound_events.insert = "EarthquakeTauntReady"
tt = E.register_t(E, "tower_mech", "tower")

E.add_comps(E, tt, "barrack", "powers")

tt.tower.type = "mecha"
tt.tower.level = 1
tt.tower.price = 375
tt.info.fn = scripts.tower_mech.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0012"
tt.info.enc_icon = 13
tt.powers.missile = E.clone_c(E, "power")
tt.powers.missile.price_base = 300
tt.powers.missile.price_inc = 250
tt.powers.missile.max_level = 2
tt.powers.missile.enc_icon = 38
tt.powers.oil = E.clone_c(E, "power")
tt.powers.oil.price_base = 250
tt.powers.oil.price_inc = 200
tt.powers.oil.name = "WASTE"
tt.powers.oil.enc_icon = 39
tt.main_script.insert = scripts.tower_mech.insert
tt.main_script.update = scripts.tower_mech.update
tt.main_script.remove = scripts.tower_barrack.remove
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
local tower_archer_1 = E.register_t(E, "tower_archer_1", "tower")

E.add_comps(E, tower_archer_1, "attacks")

tower_archer_1.tower.type = "archer"
tower_archer_1.tower.level = 1
tower_archer_1.tower.price = 70
tower_archer_1.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0001"
tower_archer_1.info.enc_icon = 1
tower_archer_1.render.sprites[1].animated = false
tower_archer_1.render.sprites[1].name = "terrain_archer_%04i"
tower_archer_1.render.sprites[1].offset = v(0, 12)
tower_archer_1.render.sprites[2] = E.clone_c(E, "sprite")
tower_archer_1.render.sprites[2].animated = false
tower_archer_1.render.sprites[2].name = "archer_tower_0001"
tower_archer_1.render.sprites[2].offset = v(0, 37)
tower_archer_1.render.sprites[3] = E.clone_c(E, "sprite")
tower_archer_1.render.sprites[3].prefix = "shooterarcherlvl1"
tower_archer_1.render.sprites[3].name = "idleDown"
tower_archer_1.render.sprites[3].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tower_archer_1.render.sprites[3].offset = v(-9, 51)
tower_archer_1.render.sprites[4] = E.clone_c(E, "sprite")
tower_archer_1.render.sprites[4].prefix = "shooterarcherlvl1"
tower_archer_1.render.sprites[4].name = "idleDown"
tower_archer_1.render.sprites[4].angles = {
	idle = {
		"idleUp",
		"idleDown"
	},
	shoot = {
		"shootingUp",
		"shootingDown"
	}
}
tower_archer_1.render.sprites[4].offset = v(9, 51)
tower_archer_1.main_script.insert = scripts.tower_archer.insert
tower_archer_1.main_script.update = scripts.tower_archer.update
tower_archer_1.main_script.remove = scripts.tower_archer.remove
tower_archer_1.attacks.range = 140
tower_archer_1.attacks.list[1] = E.clone_c(E, "bullet_attack")
tower_archer_1.attacks.list[1].bullet = "arrow_1"
tower_archer_1.attacks.list[1].cooldown = 0.8
tower_archer_1.attacks.list[1].shoot_time = fts(5)
tower_archer_1.attacks.list[1].bullet_start_offset = {
	v(-10, 50),
	v(10, 50)
}
tower_archer_1.sound_events.insert = "ArcherTaunt"
local tower_archer_2 = E.register_t(E, "tower_archer_2", "tower_archer_1")
tower_archer_2.info.enc_icon = 5
tower_archer_2.tower.level = 2
tower_archer_2.tower.price = 110
tower_archer_2.render.sprites[2].name = "archer_tower_0002"
tower_archer_2.render.sprites[3].prefix = "shooterarcherlvl2"
tower_archer_2.render.sprites[3].offset = v(-9, 52)
tower_archer_2.render.sprites[4].prefix = "shooterarcherlvl2"
tower_archer_2.render.sprites[4].offset = v(9, 52)
tower_archer_2.attacks.range = 160
tower_archer_2.attacks.list[1].bullet = "arrow_2"
tower_archer_2.attacks.list[1].cooldown = 0.6
local tower_archer_3 = E.register_t(E, "tower_archer_3", "tower_archer_1")
tower_archer_3.info.enc_icon = 9
tower_archer_3.tower.level = 3
tower_archer_3.tower.price = 160
tower_archer_3.render.sprites[2].name = "archer_tower_0003"
tower_archer_3.render.sprites[3].prefix = "shooterarcherlvl3"
tower_archer_3.render.sprites[3].offset = v(-9, 57)
tower_archer_3.render.sprites[4].prefix = "shooterarcherlvl3"
tower_archer_3.render.sprites[4].offset = v(9, 57)
tower_archer_3.attacks.range = 180
tower_archer_3.attacks.list[1].bullet = "arrow_3"
tower_archer_3.attacks.list[1].cooldown = 0.5
local tower_totem = E.register_t(E, "tower_totem", "tower_archer_1")

E.add_comps(E, tower_totem, "powers")

tower_totem.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0010"
tower_totem.info.enc_icon = 18
tower_totem.tower.type = "totem"
tower_totem.tower.price = 230
tower_totem.powers.weakness = E.clone_c(E, "power")
tower_totem.powers.weakness.price_base = 250
tower_totem.powers.weakness.price_inc = 200
tower_totem.powers.weakness.enc_icon = 30
tower_totem.powers.silence = E.clone_c(E, "power")
tower_totem.powers.silence.price_base = 150
tower_totem.powers.silence.price_inc = 150
tower_totem.powers.silence.name = "SPIRITS"
tower_totem.powers.silence.enc_icon = 31
tower_totem.main_script.insert = scripts.tower_totem.insert
tower_totem.main_script.update = scripts.tower_totem.update
tower_totem.attacks.range = 179.20000000000002
tower_totem.attacks.list[1].bullet = "axe_totem"
tower_totem.attacks.list[1].cooldown = 0.8
tower_totem.attacks.list[1].shoot_time = fts(8)
tower_totem.attacks.list[1].bullet_start_offset = {
	v(-12, 72),
	v(12, 72)
}
tower_totem.attacks.list[2] = E.clone_c(E, "bullet_attack")
tower_totem.attacks.list[2].bullet = "totem_weakness"
tower_totem.attacks.list[2].cooldown = 10
tower_totem.attacks.list[2].vis_bans = bor(F_CLIFF)
tower_totem.attacks.list[3] = E.clone_c(E, "bullet_attack")
tower_totem.attacks.list[3].bullet = "totem_silence"
tower_totem.attacks.list[3].cooldown = 8
tower_totem.attacks.list[3].vis_bans = bor(F_CLIFF, F_BOSS)
tower_totem.render.sprites[1].name = "terrain_specials_%04i"
tower_totem.render.sprites[1].offset = v(0, 6)
tower_totem.render.sprites[2].name = "TotemTower"
tower_totem.render.sprites[2].offset = v(0, 37)
tower_totem.render.sprites[3].prefix = "shootertotem"
tower_totem.render.sprites[3].offset = v(-10, 58)
tower_totem.render.sprites[4].prefix = "shootertotem"
tower_totem.render.sprites[4].offset = v(10, 58)
tower_totem.render.sprites[5] = E.clone_c(E, "sprite")
tower_totem.render.sprites[5].name = "totem_fire"
tower_totem.render.sprites[5].offset = v(-25, 10)
tower_totem.render.sprites[6] = E.clone_c(E, "sprite")
tower_totem.render.sprites[6].name = "totem_fire"
tower_totem.render.sprites[6].offset = v(25, 10)
tower_totem.render.sprites[7] = E.clone_c(E, "sprite")
tower_totem.render.sprites[7].name = "totem_eyes_lower"
tower_totem.render.sprites[7].offset = v(0, 17)
tower_totem.render.sprites[7].hidden = true
tower_totem.render.sprites[7].loop = false
tower_totem.render.sprites[8] = E.clone_c(E, "sprite")
tower_totem.render.sprites[8].name = "totem_eyes_upper"
tower_totem.render.sprites[8].offset = v(0, 41)
tower_totem.render.sprites[8].hidden = true
tower_totem.render.sprites[8].loop = false
tower_totem.sound_events.insert = "TotemTauntReady"
local tower_crossbow = E.register_t(E, "tower_crossbow", "tower_archer_1")

E.add_comps(E, tower_crossbow, "powers")

tower_crossbow.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0009"
tower_crossbow.info.enc_icon = 17
tower_crossbow.tower.type = "crossbow"
tower_crossbow.tower.price = 230
tower_crossbow.powers.multishot = E.clone_c(E, "power")
tower_crossbow.powers.multishot.price_base = 250
tower_crossbow.powers.multishot.price_inc = 150
tower_crossbow.powers.multishot.name = "BARRAGE"
tower_crossbow.powers.multishot.enc_icon = 28
tower_crossbow.powers.eagle = E.clone_c(E, "power")
tower_crossbow.powers.eagle.price_base = 200
tower_crossbow.powers.eagle.price_inc = 200
tower_crossbow.powers.eagle.name = "FALCONER"
tower_crossbow.powers.eagle.enc_icon = 29
tower_crossbow.main_script.insert = scripts.tower_crossbow.insert
tower_crossbow.main_script.update = scripts.tower_crossbow.update
tower_crossbow.main_script.remove = scripts.tower_crossbow.remove
tower_crossbow.attacks.range = 198.4
tower_crossbow.attacks.list[1].bullet = "arrow_crossbow"
tower_crossbow.attacks.list[1].cooldown = 0.5
tower_crossbow.attacks.list[1].shoot_time = fts(8)
tower_crossbow.attacks.list[1].bullet_start_offset = {
	v(-11, 60),
	v(11, 60)
}
tower_crossbow.attacks.list[1].critical_chance = 0.1
tower_crossbow.attacks.list[1].critical_chance_inc = 0.05
tower_crossbow.attacks.list[2] = E.clone_c(E, "bullet_attack")
tower_crossbow.attacks.list[2].bullet = "multishot_crossbow"
tower_crossbow.attacks.list[2].cooldown = 5
tower_crossbow.attacks.list[2].shoot_time = fts(1)
tower_crossbow.attacks.list[2].cycle_time = fts(3)
tower_crossbow.attacks.list[2].shots = 4
tower_crossbow.attacks.list[2].shots_inc = 2
tower_crossbow.attacks.list[2].near_range = 64
tower_crossbow.attacks.list[2].bullet_start_offset = {
	v(-11, 60),
	v(11, 60)
}
tower_crossbow.attacks.list[3] = E.clone_c(E, "mod_attack")
tower_crossbow.attacks.list[3].mod = "mod_crossbow_eagle"
tower_crossbow.attacks.list[3].cooldown = 0.5
tower_crossbow.attacks.list[3].fly_cooldown = 10
tower_crossbow.attacks.list[3].range = 128
tower_crossbow.attacks.list[3].range_inc = 32
tower_crossbow.attacks.list[3].excluded_templates = {
	"tower_barrack_1",
	"tower_barrack_2",
	"tower_barrack_3",
	"tower_assassin",
	"tower_templar"
}
tower_crossbow.render.sprites[1].name = "terrain_specials_%04i"
tower_crossbow.render.sprites[1].offset = v(0, 7)
tower_crossbow.render.sprites[2].name = "CossbowHunter_tower"
tower_crossbow.render.sprites[2].offset = v(0, 33)
tower_crossbow.render.sprites[3].prefix = "shootercrossbow"
tower_crossbow.render.sprites[3].offset = v(-9, 58)
tower_crossbow.render.sprites[3].angles.multishot_start = {
	"multishotStartUp",
	"multishotStartDown"
}
tower_crossbow.render.sprites[3].angles.multishot_loop = {
	"multishotLoopUp",
	"multishotLoopDown"
}
tower_crossbow.render.sprites[3].angles.multishot_end = {
	"multishotEndUp",
	"multishotEndDown"
}
tower_crossbow.render.sprites[4].prefix = "shootercrossbow"
tower_crossbow.render.sprites[4].offset = v(12, 58)
tower_crossbow.render.sprites[4].angles.multishot_start = {
	"multishotStartUp",
	"multishotStartDown"
}
tower_crossbow.render.sprites[4].angles.multishot_loop = {
	"multishotLoopUp",
	"multishotLoopDown"
}
tower_crossbow.render.sprites[4].angles.multishot_end = {
	"multishotEndUp",
	"multishotEndDown"
}
tower_crossbow.render.sprites[5] = E.clone_c(E, "sprite")
tower_crossbow.render.sprites[5].prefix = "crossbow_eagle"
tower_crossbow.render.sprites[5].name = "idle"
tower_crossbow.render.sprites[5].offset = v(2, 53)
tower_crossbow.render.sprites[5].hidden = true
tower_crossbow.render.sprites[5].draw_order = 6
tower_crossbow.sound_events.insert = "CrossbowTauntReady"
local tower_barrack_1 = E.register_t(E, "tower_barrack_1", "tower")

E.add_comps(E, tower_barrack_1, "barrack")

tower_barrack_1.tower.type = "barrack"
tower_barrack_1.tower.level = 1
tower_barrack_1.tower.price = 70
tower_barrack_1.info.fn = scripts.tower_barrack.get_info
tower_barrack_1.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0002"
tower_barrack_1.info.enc_icon = 2
tower_barrack_1.render.sprites[1].animated = false
tower_barrack_1.render.sprites[1].name = "terrain_barrack_%04i"
tower_barrack_1.render.sprites[1].offset = v(0, 13)
tower_barrack_1.render.sprites[2] = E.clone_c(E, "sprite")
tower_barrack_1.render.sprites[2].animated = false
tower_barrack_1.render.sprites[2].name = "tower_barracks_lvl1_layer1_0001"
tower_barrack_1.render.sprites[2].offset = v(0, 38)
tower_barrack_1.render.sprites[3] = E.clone_c(E, "sprite")
tower_barrack_1.render.sprites[3].prefix = "towerbarracklvl1_door"
tower_barrack_1.render.sprites[3].name = "close"
tower_barrack_1.render.sprites[3].loop = false
tower_barrack_1.render.sprites[3].offset = v(0, 38)
tower_barrack_1.barrack.soldier_type = "soldier_militia"
tower_barrack_1.barrack.rally_range = 145
tower_barrack_1.barrack.respawn_offset = v(0, 0)
tower_barrack_1.main_script.insert = scripts.tower_barrack.insert
tower_barrack_1.main_script.update = scripts.tower_barrack.update
tower_barrack_1.main_script.remove = scripts.tower_barrack.remove
tower_barrack_1.sound_events.insert = "BarrackTaunt"
tower_barrack_1.sound_events.change_rally_point = "BarrackTaunt"
local tower_barrack_2 = E.register_t(E, "tower_barrack_2", "tower_barrack_1")
tower_barrack_2.info.enc_icon = 6
tower_barrack_2.tower.level = 2
tower_barrack_2.tower.price = 110
tower_barrack_2.render.sprites[2].name = "tower_barracks_lvl2_layer1_0001"
tower_barrack_2.render.sprites[3].prefix = "towerbarracklvl2_door"
tower_barrack_2.barrack.soldier_type = "soldier_footmen"
local tower_barrack_3 = E.register_t(E, "tower_barrack_3", "tower_barrack_1")
tower_barrack_3.info.enc_icon = 10
tower_barrack_3.tower.level = 3
tower_barrack_3.tower.price = 160
tower_barrack_3.render.sprites[2].name = "tower_barracks_lvl3_layer1_0001"
tower_barrack_3.render.sprites[3].prefix = "towerbarracklvl3_door"
tower_barrack_3.barrack.soldier_type = "soldier_knight"
local tower_templar = E.register_t(E, "tower_templar", "tower_barrack_1")

E.add_comps(E, tower_templar, "powers")

tower_templar.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0007"
tower_templar.info.enc_icon = 19
tower_templar.tower.type = "templar"
tower_templar.tower.price = 230
tower_templar.powers.holygrail = E.clone_c(E, "power")
tower_templar.powers.holygrail.price_base = 250
tower_templar.powers.holygrail.price_inc = 150
tower_templar.powers.holygrail.name = "HOLY"
tower_templar.powers.holygrail.enc_icon = 25
tower_templar.powers.extralife = E.clone_c(E, "power")
tower_templar.powers.extralife.price_base = 150
tower_templar.powers.extralife.price_inc = 150
tower_templar.powers.extralife.name = "TOUGHNESS"
tower_templar.powers.extralife.enc_icon = 27
tower_templar.powers.blood = E.clone_c(E, "power")
tower_templar.powers.blood.price_base = 150
tower_templar.powers.blood.price_inc = 150
tower_templar.powers.blood.name = "ARTERIAL"
tower_templar.powers.blood.enc_icon = 26
tower_templar.barrack.soldier_type = "soldier_templar"
tower_templar.barrack.rally_range = 147.20000000000002
tower_templar.render.sprites[1].name = "terrain_specials_%04i"
tower_templar.render.sprites[1].offset = v(0, 8)
tower_templar.render.sprites[2].name = "tower_templars_layer1_0001"
tower_templar.render.sprites[2].offset = v(0, 34)
tower_templar.render.sprites[3].prefix = "towertemplar_door"
tower_templar.render.sprites[3].offset = v(0, 34)
tower_templar.render.sprites[4] = E.clone_c(E, "sprite")
tower_templar.render.sprites[4].prefix = "towertemplar_fire"
tower_templar.render.sprites[4].offset = v(-17, 19)
tower_templar.render.sprites[5] = E.clone_c(E, "sprite")
tower_templar.render.sprites[5].prefix = "towertemplar_fire"
tower_templar.render.sprites[5].offset = v(18, 19)
tower_templar.render.sprites[5].ts = 0.08
tower_templar.sound_events.insert = "TemplarTauntReady"
tower_templar.sound_events.change_rally_point = "TemplarTaunt"
local tower_assassin = E.register_t(E, "tower_assassin", "tower_barrack_1")

E.add_comps(E, tower_assassin, "powers")

tower_assassin.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0008"
tower_assassin.info.enc_icon = 20
tower_assassin.tower.type = "assassin"
tower_assassin.tower.price = 230
tower_assassin.powers.sneak = E.clone_c(E, "power")
tower_assassin.powers.sneak.price_base = 225
tower_assassin.powers.sneak.price_inc = 150
tower_assassin.powers.sneak.enc_icon = 24
tower_assassin.powers.pickpocket = E.clone_c(E, "power")
tower_assassin.powers.pickpocket.price_base = 100
tower_assassin.powers.pickpocket.price_inc = 100
tower_assassin.powers.pickpocket.max_level = 3
tower_assassin.powers.pickpocket.name = "PICK"
tower_assassin.powers.pickpocket.enc_icon = 22
tower_assassin.powers.counter = E.clone_c(E, "power")
tower_assassin.powers.counter.price_base = 150
tower_assassin.powers.counter.price_inc = 100
tower_assassin.powers.counter.enc_icon = 23
tower_assassin.barrack.soldier_type = "soldier_assassin"
tower_assassin.barrack.rally_range = 147.20000000000002
tower_assassin.render.sprites[1].name = "terrain_specials_%04i"
tower_assassin.render.sprites[1].offset = v(0, 8)
tower_assassin.render.sprites[2].name = "tower_assasins_layer1_0005"
tower_assassin.render.sprites[2].offset = v(0, 30)
tower_assassin.render.sprites[3].prefix = "towerassassin_door"
tower_assassin.render.sprites[3].offset = v(0, 30)
tower_assassin.sound_events.insert = "AssassinTauntReady"
tower_assassin.sound_events.change_rally_point = "AssassinTaunt"
tt = E.register_t(E, "tower_archer_hammerhold", "tower")

E.add_comps(E, tt, "attacks")

tt.tower.type = "archer_hammerhold"
tt.tower.level = 1
tt.tower.price = 0
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
tt.main_script.insert = scripts.tower_archer.insert
tt.main_script.update = scripts.tower_archer.update
tt.main_script.remove = scripts.tower_archer.remove
tt.attacks.range = 166.4
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "arrow_hammerhold"
tt.attacks.list[1].cooldown = 0.7
tt.attacks.list[1].shoot_time = fts(5)
tt.attacks.list[1].bullet_start_offset = {
	v(0, 50)
}
tt = E.register_t(E, "tower_barrack_pirates", "tower")

E.add_comps(E, tt, "barrack")

tt.tower.type = "mercenaries_pirates"
tt.tower.level = 1
tt.tower.can_be_mod = false
tt.info.fn = scripts.tower_barrack_mercenaries.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0014"
tt.main_script.update = scripts.tower_barrack_mercenaries.update
tt.main_script.remove = scripts.tower_barrack.remove
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
tt = E.register_t(E, "tower_neptune_holder")

E.add_comps(E, tt, "tower", "tower_holder", "pos", "render", "ui", "info")

tt.tower.level = 1
tt.tower.type = "holder_neptune"
tt.tower.can_be_mod = false
tt.info.fn = scripts.tower_neptune_holder.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0021"
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
tt.info.fn = scripts.tower_neptune.get_info
tt.ui.click_rect = r(-40, -10, 80, 90)
tt.powers.ray = E.clone_c(E, "power")
tt.powers.ray.level = 1
tt.powers.ray.max_level = 3
tt.powers.ray.price_inc = 500
tt.main_script.insert = scripts.tower_neptune.insert
tt.main_script.update = scripts.tower_neptune.update
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0004") or "info_portraits_soldiers_0004"
tt.info.random_name_count = 20
tt.info.random_name_format = "SOLDIER_TEMPLAR_RANDOM_%i_NAME"
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "blood"
tt.melee.attacks[2].chance = 0.1
tt.melee.attacks[2].damage_max = 100
tt.melee.attacks[2].damage_min = 100
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
tt.regen.health = 25
tt.render.sprites[1].prefix = "soldiertemplar"
tt.render.sprites[1].anchor.y = anchor_y
tt.revive.animation = "holygrail"
tt.revive.chance = 0.1
tt.revive.chance_inc = 0.1
tt.revive.health_recover = 0.1
tt.revive.health_recover_inc = 0.3
tt.revive.hit_time = fts(10)
tt.revive.power_name = "holygrail"
tt.revive.sound = "TemplarHolygrail"
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(7))
tt.unit.mod_offset = v(0, ady(23))
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
tt.melee.attacks[2].chance = 0.05
tt.melee.attacks[2].chance_inc = 0.05
tt.melee.attacks[2].cooldown = fts(24) + 0.6
tt.melee.attacks[2].damage_inc = 10
tt.melee.attacks[2].damage_max = 30
tt.melee.attacks[2].damage_min = 10
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
tt.melee.attacks[3].chance = 0.02
tt.melee.attacks[3].chance_inc = 0.01
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
tt.pickpocket.chance = 0.1
tt.pickpocket.chance_inc = 0.1
tt.pickpocket.fx = "fx_coin_jump"
tt.pickpocket.power_name = "pickpocket"
tt.pickpocket.sound = "AssassinGold"
tt.pickpocket.steal_max = 3
tt.pickpocket.steal_min = 1
tt.powers.counter = E.clone_c(E, "power")
tt.powers.pickpocket = E.clone_c(E, "power")
tt.powers.sneak = E.clone_c(E, "power")
tt.regen.health = 40
tt.render.sprites[1].prefix = "soldierassassin"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(5, 0)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(23))
tt = E.register_t(E, "soldier_skeleton", "soldier_militia")

E.add_comps(E, tt, "count_group")

anchor_y = 0.18
image_y = 38
tt.count_group.name = "skeletons"
tt.health.dead_lifetime = 3
tt.health.hp_max = 40
tt.health_bar.offset = v(0, ady(38))
tt.info.fn = scripts.soldier_mercenary.get_info
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
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0006") or "info_portraits_soldiers_0006"
tt.main_script.insert = scripts.soldier_barrack.insert
tt.main_script.update = scripts.soldier_barrack.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_inc = 5
tt.melee.attacks[1].damage_max = 10
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.range = 76.8
tt.motion.max_speed = 90
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
tt = E.register_t(E, "soldier_mecha")

E.add_comps(E, tt, "pos", "render", "motion", "nav_rally", "main_script", "vis", "idle_flip", "attacks", "powers")

tt.powers.missile = E.clone_c(E, "power")
tt.powers.oil = E.clone_c(E, "power")
tt.idle_flip.cooldown = 5
tt.idle_flip.last_dir = 1
tt.idle_flip.walk_dist = 27
tt.main_script.insert = scripts.soldier_mecha.insert
tt.main_script.remove = scripts.soldier_mecha.remove
tt.main_script.update = scripts.soldier_mecha.update
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
tt.attacks.list[2].cooldown = 6
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
tt = E.register_t(E, "re_farmer", "soldier_militia")

E.add_comps(E, tt, "reinforcement", "tween")

image_y = 44
anchor_y = 0.1590909090909091
tt.cooldown = 10
tt.health.armor = 0
tt.health.hp_max = 30
tt.health_bar.offset = v(0, ady(32))
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.info.portrait_idxs = (IS_PHONE_OR_TABLET and {
	10,
	11,
	9
}) or {
	13,
	17,
	9
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
tt = E.register_t(E, "re_farmer_well_fed", "re_farmer")
tt.unit.level = 1
tt.health.hp_max = 50
tt.health.armor = 0
tt.regen.health = 6
tt.melee.attacks[1].damage_max = 3
tt = E.register_t(E, "re_conscript", "re_farmer")
tt.info.portrait_idxs = (IS_PHONE_OR_TABLET and {
	18,
	15,
	12
}) or {
	14,
	18,
	10
}
tt.unit.level = 2
tt.health.hp_max = 70
tt.health.armor = 0.1
tt.regen.health = 9
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].damage_max = 4
tt = E.register_t(E, "re_warrior", "re_farmer")
tt.info.portrait_idxs = (IS_PHONE_OR_TABLET and {
	19,
	16,
	13
}) or {
	15,
	19,
	11
}
tt.unit.level = 3
tt.health.hp_max = 90
tt.health.armor = 0.2
tt.regen.health = 12
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].damage_max = 6
tt = E.register_t(E, "re_legionnaire", "re_farmer")
tt.info.portrait_idxs = (IS_PHONE_OR_TABLET and {
	20,
	17,
	14
}) or {
	16,
	20,
	12
}
tt.unit.level = 4
tt.health.hp_max = 110
tt.health.armor = 0.3
tt.health_bar.offset = v(0, ady(34))
tt.regen.health = 15
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].damage_max = 10
tt = E.register_t(E, "re_legionnaire_ranged", "re_legionnaire")

E.add_comps(E, tt, "ranged")

tt.unit.level = 5
tt.ranged.attacks[1].bullet = "arrow_legionnaire"
tt.ranged.attacks[1].shoot_time = fts(5)
tt.ranged.attacks[1].cooldown = fts(12) + 1
tt.ranged.attacks[1].max_range = 175
tt.ranged.attacks[1].min_range = 27
tt.ranged.attacks[1].animation = "ranged_attack"
tt.ranged.attacks[1].bullet_start_offset = {
	v(6, 10)
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
		local t = E.register_t(E, fn, base_t)
		t.render.sprites[1].prefix = fn

		if IS_PHONE_OR_TABLET then
			t.info.portrait = string.format("portraits_sc_00%02d", t.info.portrait_idxs[i])
		else
			t.info.portrait = string.format("info_portraits_soldiers_00%02d", t.info.portrait_idxs[i])
		end
	end
end

for i = 1, 3, 1 do
	E.set_template(E, "re_current_" .. i, E.get_template(E, "re_farmer_" .. i))
end

tt = E.register_t(E, "soldier_legionnaire", "soldier_militia")
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 250
tt.info.fn = scripts.soldier_mercenary.get_info
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
tt.info.fn = scripts.soldier_mercenary.get_info
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
tt.main_script.insert = scripts.spell_djinn.insert
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
tt = E.register_t(E, "soldier_pirate_captain", "soldier_militia")

E.add_comps(E, tt, "pickpocket")

anchor_y = 0.21
image_y = 36
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 250
tt.health_bar.offset = v(0, ady(37))
tt.info.fn = scripts.soldier_mercenary.get_info
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
tt.info.fn = scripts.soldier_mercenary.get_info
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
tt.info.fn = scripts.soldier_mercenary.get_info
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
tt = E.register_t(E, "soldier_amazona", "soldier_militia")

E.add_comps(E, tt, "track_kills", "auras")

anchor_y = 0.35
image_y = 70
tt.health.armor = 0
tt.health.dead_lifetime = 2
tt.health.hp_max = 300
tt.health_bar.offset = v(0, ady(56))
tt.info.fn = scripts.soldier_mercenary.get_info
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

tt.main_script.insert = scripts.mod_heal_on_kill.insert
tt.main_script.update = scripts.mod_heal_on_kill.update
tt.heal_on_kill.hp = 50
tt = E.register_t(E, "soldier_sand_warrior", "unit")

E.add_comps(E, tt, "soldier", "motion", "nav_path", "main_script", "vis", "info", "lifespan", "melee", "sound_events")

anchor_y = 0.2
image_y = 36
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0012") or "info_portraits_heroes_0012"
tt.health.armor = 0
tt.health.hp_inc = 40
tt.health.hp_max = 20
tt.health_bar.offset = v(0, ady(39))
tt.info.fn = scripts.soldier_sand_warrior.get_info
tt.info.i18n_key = "HERO_ALRIC_SANDWARRIORS"
tt.lifespan.duration = nil
tt.main_script.insert = scripts.soldier_sand_warrior.insert
tt.main_script.update = scripts.soldier_sand_warrior.update
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
tt = E.register_t(E, "soldier_mirage_illusion", "unit")

E.add_comps(E, tt, "soldier", "motion", "nav_path", "main_script", "vis", "lifespan", "melee", "sound_events")

anchor_y = 0.14
image_y = 72
tt.ui = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "soldier_mirage_illusion"
tt.render.sprites[1].alpha = 230
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.health.hp_max = 60
tt.health.armor = 0
tt.health_bar.offset = v(0, 34)
tt.health_bar.hidden = true
tt.lifespan.duration = fts(6) + 1
tt.melee.range = 64
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 90
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "MeleeSword"
tt.main_script.insert = scripts.soldier_mirage_illusion.insert
tt.main_script.update = scripts.soldier_mirage_illusion.update
tt.motion.max_speed = 90
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.death = "HeroMirageShadowDodgePuff"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.hit_offset = v(0, 12)
tt.vis.bans = bor(F_POISON, F_CANNIBALIZE, F_STUN)
tt.vis.flags = F_FRIEND
tt = E.register_t(E, "hero_steam_frigate", "stage_hero")

E.add_comps(E, tt, "ranged", "timed_attacks")

image_y = 120
anchor_y = 0.16666666666666666
tt.health.armor = 0.7
tt.health.hp_max = 420
tt.health.immune_to = DAMAGE_ALL
tt.health_bar.offset = v(0, ady(55))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.idle_flip = nil
tt.info.fn = scripts.hero_steam_frigate.get_info
tt.info.hero_portrait = "hero_portraits_0011"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0014") or "info_portraits_heroes_0021"
tt.main_script.insert = scripts.hero_steam_frigate.insert
tt.main_script.update = scripts.hero_steam_frigate.update
tt.motion.max_speed = 75
tt.nav_grid.valid_terrains = bor(TERRAIN_WATER)
tt.nav_grid.valid_terrains_dest = bor(TERRAIN_WATER)
tt.nav_rally.requires_node_nearby = false
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_steam_frigate_l1"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].prefix = "hero_steam_frigate_l2"
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].anchor.y = anchor_y
tt.render.sprites[3].loop_forced = true
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].prefix = "hero_steam_frigate_smoke"
tt.sound_events.change_rally_point = "PirateBoatTaunt"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-35, -15, 70, 70)) or r(-30, 0, 60, 38)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, ady(22))
tt.vis.bans = F_ALL
tt.vis.flags = F_NONE
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "throw_barrel"
tt.ranged.attacks[1].bullet = "steam_frigate_barrel"
tt.ranged.attacks[1].bullet_start_offset = {
	v(29, 39)
}
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].max_range = 250
tt.ranged.attacks[1].min_range = 50
tt.ranged.attacks[1].node_prediction = fts(33)
tt.ranged.attacks[1].shoot_time = fts(13)
tt.ranged.attacks[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[1].animation = "throw_mine"
tt.timed_attacks.list[1].bullet = "steam_frigate_mine"
tt.timed_attacks.list[1].bullet_start_offset = {
	v(29, 39)
}
tt.timed_attacks.list[1].cooldown = 8
tt.timed_attacks.list[1].max_mines = 20
tt.timed_attacks.list[1].max_range = 150
tt.timed_attacks.list[1].min_range = 16.5
tt.timed_attacks.list[1].shoot_time = fts(13)
tt.timed_attacks.list[1].valid_terrains = TERRAIN_WATER
tt = E.register_t(E, "steam_frigate_barrel", "bomb")
tt.bullet.flight_time = fts(20)
tt.bullet.damage_min = 80
tt.bullet.damage_max = 100
tt.bullet.damage_radius = 96
tt.bullet.hide_radius = nil
tt.render.sprites[1].name = "pirateHero_proy_0001"
tt.sound_events.insert = "AxeSound"
tt = E.register_t(E, "steam_frigate_mine", "bomb")

E.add_comps(E, tt, "lifespan")

tt.bullet.damage_bans = bor(F_FLYING)
tt.bullet.damage_max = 280
tt.bullet.damage_min = 280
tt.bullet.damage_radius = 76.80000000000001
tt.bullet.flight_time = fts(20)
tt.bullet.hide_radius = nil
tt.bullet.pop = nil
tt.bullet.vis_bans = bor(F_FLYING)
tt.lifespan.duration = 40
tt.main_script.update = scripts.steam_frigate_mine.update
tt.render.sprites[1].name = "pirateHero_proy_0002"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = 0.38
tt.render.sprites[2].hidden = true
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].prefix = "steam_frigate_mine"
tt.sound_events.insert = "AxeSound"
tt.trigger_radius = 10
tt = E.register_t(E, "hero_dwarf", "stage_hero")

E.add_comps(E, tt, "melee")

image_y = 94
anchor_y = 0.13
tt.health.armor = 0.7
tt.health.dead_lifetime = 35
tt.health.hp_max = 420
tt.health_bar.offset = v(0, ady(50))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = "hero_portraits_0010"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0013") or "info_portraits_heroes_0013"
tt.main_script.insert = scripts.hero_dwarf.insert
tt.main_script.update = scripts.hero_dwarf.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].cooldown = 8
tt.melee.attacks[2].damage_max = 120
tt.melee.attacks[2].damage_min = 60
tt.melee.attacks[2].damage_radius = 60
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].hit_decal = "fx_dwarf_area_quake"
tt.melee.attacks[2].hit_fx = "fx_dwarf_area_ring"
tt.melee.attacks[2].hit_offset = v(29, 0)
tt.melee.attacks[2].hit_time = fts(29)
tt.melee.range = 83.2
tt.motion.max_speed = FPS*2.5
tt.regen.cooldown = 1
tt.regen.health = 42
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_dwarf"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.soldier.melee_slot_offset.x = 10
tt.sound_events.change_rally_point = "DwarfHeroTaunt"
tt.sound_events.death = "DwarfHeroTauntDeath"
tt.sound_events.respawn = "DwarfHeroTauntIntro"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, ady(22))
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
tt = E.register_t(E, "hero_vampiress", "stage_hero")

E.add_comps(E, tt, "melee", "timed_attacks")

image_y = 74
anchor_y = 0.24
tt.health.armor = 0.7
tt.health.dead_lifetime = 20
tt.health.hp_max = 350
tt.health_bar.offset = v(0, 34)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.level = 10
tt.hero.tombstone_show_time = fts(90)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_basic.get_info_melee
tt.info.hero_portrait = "hero_portraits_0017"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0020") or "info_portraits_heroes_0020"
tt.main_script.insert = scripts.hero_vampiress.insert
tt.main_script.update = scripts.hero_vampiress.update
tt.motion.max_speed = FPS*1.7
tt.motion.max_speed_bat = FPS*3.7
tt.regen.cooldown = 1
tt.regen.health = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_vampiress"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].hidden = true
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HWVampiressTaunt"
tt.sound_events.death = "HWVampiressDeath"
tt.sound_events.respawn = "HWVampiressTauntIntro"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 12)
tt.fly_to = {
	min_distance = 83.2,
	animation_prefix = "hero_vampiress_bat"
}
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "vampirism"
tt.melee.attacks[2].cooldown = 15
tt.melee.attacks[2].damage_min = 150
tt.melee.attacks[2].damage_max = 150
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].mod = "mod_vampiress_lifesteal"
tt.melee.attacks[2].sound = "HWVampiressLifesteal"
tt.melee.attacks[2].hit_time = fts(9)
tt.melee.range = 83.2
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "slayer"
tt.timed_attacks.list[1].cooldown = 10
tt.timed_attacks.list[1].damage_max = 160
tt.timed_attacks.list[1].damage_min = 80
tt.timed_attacks.list[1].trigger_radius = 50
tt.timed_attacks.list[1].damage_radius = 65
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].hit_time = fts(10)
tt.timed_attacks.list[1].sound = "HWVampiressAreaAttack"
tt.timed_attacks.list[1].extra_damage_templates = {
	"enemy_elvira"
}
tt.timed_attacks.list[1].extra_damage_factor = 10
tt = E.register_t(E, "fx_vampiress_transform", "fx")
tt.render.sprites[1].name = "fx_vampiress_transform"
tt.render.sprites[1].anchor.y = 0.32432432432432434
tt = E.register_t(E, "mod_vampiress_lifesteal", "modifier")
tt.heal_hp = 150
tt.main_script.insert = scripts.mod_simple_lifesteal.insert
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
	0.4,
	0.5
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
	40,
	43,
	46,
	49
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
	30,
	32
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
	[10.0] = 3,
	[4.0] = 1,
	[7.0] = 2
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
tt.hero.fn_level_up = scripts1.hero_10yr.level_up
tt.hero.tombstone_show_time = fts(90)
tt.hero.level = 10
tt.hero.skills.buffed.level = 3
tt.hero.skills.rain.level = 3
tt.info.hero_portrait = (IS_PHONE_OR_TABLET and "hero_portraits_0013") or "heroPortrait_portraits_1113"
tt.info.fn = scripts1.hero_10yr.get_info
tt.info.i18n_key = "HERO_10YR"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0015") or "info_portraits_hero_1115"
tt.main_script.update = scripts1.hero_10yr.update
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
tt.teleport.min_distance = 100
tt.teleport.delay = 0
tt.teleport.sound = "TenShiTeleportSfx"
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 20)
tt.unit.hit_offset = v(0, 20)
tt.melee.range_normal = 55
tt.melee.range_buffed = 85
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
tt.melee.attacks[3].damage_radius = 50
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
tt.main_script.update = scripts1.aura_10yr_fireball.update
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
tt.main_script.update = scripts1.aura_10yr_bomb.update
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
tt = RT("aura_10yr_idle", "aura")
tt.aura.duration = 0
tt.particles_name = "ps_hero_10yr_idle"
tt.emit_states = {
	"idle",
	"running"
}
tt.main_script.update = scripts1.aura_10yr_particles.update
tt.particle_offsets = {
	v(-25.714285714285715, 25.714285714285715),
	v(-15.714285714285715, 37.142857142857146),
	v(0, 45.714285714285715),
	v(8.571428571428571, 42.85714285714286),
	v(14.285714285714286, 32.85714285714286),
	v(21.42857142857143, 21.42857142857143)
}
tt.flip_offset = v(3, 0)
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
tt.hero.fn_level_up = scripts.hero_alric.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_alric.get_info
tt.info.hero_portrait = "hero_portraits_0001"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0001") or "info_portraits_heroes_0001"
tt.main_script.insert = scripts.hero_alric.insert
tt.main_script.update = scripts.hero_alric.update
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
tt = E.register_t(E, "hero_mirage", "hero")

E.add_comps(E, tt, "dodge", "melee", "ranged", "timed_attacks")

anchor_y = 0.14
image_y = 72
tt.hero.level_stats.hp_max = {
	165,
	180,
	195,
	210,
	225,
	240,
	255,
	270,
	285,
	300
}
tt.hero.level_stats.regen_health = {
	21,
	23,
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38
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
	16,
	17,
	18,
	20,
	22,
	24,
	25,
	27,
	28,
	30
}
tt.hero.level_stats.melee_damage_max = {
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40
}
tt.hero.level_stats.ranged_damage_min = {
	16,
	17,
	18,
	20,
	22,
	24,
	25,
	27,
	28,
	30
}
tt.hero.level_stats.ranged_damage_max = {
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40
}
tt.hero.skills.precision = E.clone_c(E, "hero_skill")
tt.hero.skills.precision.extra_range = {
	14,
	28,
	42
}
tt.hero.skills.shadowdodge = E.clone_c(E, "hero_skill")
tt.hero.skills.shadowdodge.dodge_chance = {
	0.333,
	0.667,
	1
}
tt.hero.skills.swiftness = E.clone_c(E, "hero_skill")
tt.hero.skills.swiftness.max_speed_factor = {
	1.3,
	1.5,
	1.7
}
tt.hero.skills.shadowdance = E.clone_c(E, "hero_skill")
tt.hero.skills.shadowdance.copies = {
	2,
	4,
	6
}
tt.hero.skills.shadowdance.xp_gain_factor = 35
tt.hero.skills.lethalstrike = E.clone_c(E, "hero_skill")
tt.hero.skills.lethalstrike.instakill_chance = {
	1,
	1,
	1
}
tt.hero.skills.lethalstrike.xp_gain_factor = 75
tt.hero.skills.precision.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.precision.hr_icon = (IS_PHONE_OR_TABLET and 11) or 6
tt.hero.skills.precision.hr_order = 1
tt.hero.skills.shadowdodge.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.shadowdodge.hr_icon = (IS_PHONE_OR_TABLET and 12) or 7
tt.hero.skills.shadowdodge.hr_order = 2
tt.hero.skills.swiftness.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.swiftness.hr_icon = (IS_PHONE_OR_TABLET and 13) or 8
tt.hero.skills.swiftness.hr_order = 3
tt.hero.skills.shadowdance.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.shadowdance.hr_icon = (IS_PHONE_OR_TABLET and 14) or 9
tt.hero.skills.shadowdance.hr_order = 4
tt.hero.skills.lethalstrike.hr_cost = {
	4,
	4,
	4
}
tt.hero.skills.lethalstrike.hr_icon = (IS_PHONE_OR_TABLET and 15) or 10
tt.hero.skills.lethalstrike.hr_order = 5
tt.dodge.animation = "disappear"
tt.dodge.chance = 0
tt.health.armor = tt.hero.level_stats.armor[1]
tt.health.dead_lifetime = 15
tt.health.hp_max = tt.hero.level_stats.hp_max[1]
tt.health_bar.offset = v(0, 34)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_mirage.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.chance = 0.4
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_mirage.get_info
tt.info.hero_portrait = "hero_portraits_0002"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0002") or "info_portraits_heroes_0002"
tt.info.damage_icon = "arrow"
tt.main_script.insert = scripts.hero_mirage.insert
tt.main_script.update = scripts.hero_mirage.update
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].cooldown = 0.5
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.66
tt.melee.range = 50
tt.motion.max_speed = 72
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].bullet = "bullet_mirage"
tt.ranged.attacks[1].bullet_start_offset = {
	v(12, 12),
	v(12, 12),
	v(12, 12)
}
tt.ranged.attacks[1].cooldown = 0.6
tt.ranged.attacks[1].max_range = 140
tt.ranged.attacks[1].min_range = 25
tt.ranged.attacks[1].shoot_time = fts(4)
tt.ranged.attacks[1].vis_bans = 0
tt.regen.cooldown = 1
tt.regen.health = tt.hero.level_stats.regen_health[1]
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	ranged = {
		"shoot",
		"shoot_up",
		"shoot"
	},
	walk = {
		"running"
	}
}
tt.render.sprites[1].angles_custom = {
	ranged = {
		45,
		135,
		210,
		315
	}
}
tt.render.sprites[1].angles_flip_vertical = {
	ranged = true
}
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "hero_mirage"
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HeroMirageTaunt"
tt.sound_events.death = "HeroMirageDeath"
tt.sound_events.respawn = "HeroMirageTauntIntro"
tt.sound_events.insert = "HeroMirageTauntIntro"
tt.sound_events.hero_room_select = "HeroMirageTauntSelect"
tt.sound_events.lethal_vanish = "HeroMirageLethalStrikeCastVanish"
tt.timed_attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[1].animation = "shadows"
tt.timed_attacks.list[1].bullet = "mirage_shadow"
tt.timed_attacks.list[1].burst = nil
tt.timed_attacks.list[1].cooldown = 6
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].max_range = 140
tt.timed_attacks.list[1].min_range = 40
tt.timed_attacks.list[1].shoot_time = fts(7)
tt.timed_attacks.list[1].sound = "HeroMirageShadowDanceCast"
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[2].cooldown = 22
tt.timed_attacks.list[2].damage_max = 600
tt.timed_attacks.list[2].damage_min = 600
tt.timed_attacks.list[2].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].hit_fx = "fx_mirage_blood"
tt.timed_attacks.list[2].hit_time = fts(7)
tt.timed_attacks.list[2].instakill_chance = nil
tt.timed_attacks.list[2].range = 50
tt.timed_attacks.list[2].sound = "HeroMirageLethalStrikeCastHit"
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.timed_attacks.list[2].vis_flags = bor(F_LETHAL, F_RANGED)
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -1)
tt.unit.mod_offset = v(0, 16)
tt = E.register_t(E, "bullet_mirage", "arrow")
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.hit_fx = "fx_bullet_mirage_hit"
tt.bullet.miss_fx = "fx_bullet_mirage_hit"
tt.bullet.miss_fx_water = "fx_bullet_mirage_hit"
tt.bullet.miss_decal = nil
tt.bullet.flight_time = fts(14)
tt.bullet.xp_gain_factor = 0.66
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.hide_radius = 4
tt.bullet.pop = {
	"pop_shunt_violet"
}
tt.render.sprites[1].name = "proy_mirage_0001"
tt = E.register_t(E, "fx_bullet_mirage_hit", "fx")
tt.render.sprites[1].name = "fx_bullet_mirage_hit"
tt = E.register_t(E, "fx_mirage_smoke", "fx")
tt.render.sprites[1].name = "fx_hero_mirage_smoke"
tt.render.sprites[1].anchor.y = 0.11
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -1
tt = E.register_t(E, "fx_mirage_blood", "fx")
tt.render.sprites[1].prefix = "mirage_blood"
tt.render.sprites[1].name = "red"
tt.use_blood_color = true
tt = E.register_t(E, "mirage_shadow", "bullet")
tt.bullet.damage_inc = 10
tt.bullet.damage_max = 10
tt.bullet.damage_min = 10
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.hit_fx = "fx_mirage_blood"
tt.bullet.max_speed = 150
tt.bullet.min_speed = 120
tt.main_script.insert = scripts.mirage_shadow.insert
tt.main_script.update = scripts.mirage_shadow.update
tt.render.sprites[1].name = "running"
tt.render.sprites[1].prefix = "mirage_shadow"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor.y = 0.14
tt.sound_events.death = "HeroMirageShadowDodgePuff"
tt.sound_events.hit = "HeroMirageShadowDanceHit"
tt = E.register_t(E, "hero_giant", "hero")

E.add_comps(E, tt, "auras", "melee", "ranged", "timed_attacks")

anchor_y = 0.19117647058823528
image_y = 88
tt.hero.level_stats.hp_max = {
	250,
	300,
	350,
	400,
	450,
	500,
	550,
	600,
	650,
	700
}
tt.hero.level_stats.regen_health = {
	60,
	70,
	80,
	90,
	100,
	110,
	120,
	130,
	140,
	150
}
tt.hero.level_stats.armor = {
	0.35,
	0.38,
	0.4,
	0.42,
	0.44,
	0.46,
	0.48,
	0.5,
	0.52,
	0.55
}
tt.hero.level_stats.melee_damage_min = {
	20,
	22,
	24,
	25,
	27,
	28,
	30,
	32,
	33,
	35
}
tt.hero.level_stats.melee_damage_max = {
	26,
	28,
	30,
	33,
	35,
	37,
	40,
	42,
	45,
	48
}
tt.hero.skills.boulderthrow = E.clone_c(E, "hero_skill")
tt.hero.skills.boulderthrow.damage_min = {
	50,
	75,
	100
}
tt.hero.skills.boulderthrow.damage_max = {
	50,
	75,
	100
}
tt.hero.skills.stomp = E.clone_c(E, "hero_skill")
tt.hero.skills.stomp.damage = {
	10,
	15,
	20
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
	4
}
tt.hero.skills.bastion.max_damage = {
	20,
	30,
	40
}
tt.hero.skills.massivedamage = E.clone_c(E, "hero_skill")
tt.hero.skills.massivedamage.chance = {
	1,
	1,
	1
}
tt.hero.skills.massivedamage.extra_damage = {
	60,
	120,
	180
}
tt.hero.skills.massivedamage.health_factor = 2
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
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].disabled = true
tt.auras.list[1].name = "aura_giant_bastion"
tt.health.armor = tt.hero.level_stats.armor[1]
tt.health.dead_lifetime = 25
tt.health.hp_max = tt.hero.level_stats.hp_max[1]
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_giant.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_giant.get_info
tt.info.hero_portrait = "hero_portraits_0008"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0008") or "info_portraits_heroes_0008"
tt.main_script.insert = scripts.hero_giant.insert
tt.main_script.update = scripts.hero_giant.update
tt.motion.max_speed = 48
tt.regen.cooldown = 2
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
tt.melee.range = 65
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
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
tt.ranged.attacks[1].cooldown = 14
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 300
tt.ranged.attacks[1].min_range = 100
tt.ranged.attacks[1].shoot_time = fts(20)
tt.ranged.attacks[1].vis_bans = bor(F_FLYING)
tt.ranged.attacks[1].sound = "HeroGiantBoulder"
tt.ranged.attacks[1].node_prediction = fts(40)
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "stomp"
tt.timed_attacks.list[1].cooldown = 12
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
tt.timed_attacks.list[1].loops = nil
tt.timed_attacks.list[1].max_range = 80
tt.timed_attacks.list[1].stun_chance = 0.5
tt.timed_attacks.list[1].trigger_min_enemies = 2
tt.timed_attacks.list[1].trigger_min_hp = 10
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[1].stun_vis_flags = F_STUN
tt.timed_attacks.list[1].stun_vis_bans = bor(F_CLIFF, F_BOSS, F_FLYING)
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
tt.main_script.update = scripts.aura_giant_bastion.update
tt.render.sprites[1].name = "giant_bastion_decal"
tt.render.sprites[1].loop = true
tt.render.sprites[1].hidden = true
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].scale = v(0, 0)
tt.render.sprites[1].anchor.y = 0.19117647058823528
tt.max_distance = 100
tt.tick_time = 5
tt.damage_per_tick = nil
tt.max_damage = nil
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

tt.instakill_chance = nil
tt.instakill_min_hp = nil
tt.damage_min = nil
tt.damage_max = nil
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
tt.main_script.insert = scripts.mod_giant_massivedamage.insert
tt = E.register_t(E, "mod_giant_slow", "mod_slow")
tt.modifier.duration = 1
tt.slow.factor = 0.5
tt = E.register_t(E, "mod_giant_stun", "mod_shock_and_awe")
tt.modifier.duration = nil
tt = E.register_t(E, "giant_stomp_decal", "decal_timed")
tt.render.sprites[1].name = "giant_stomp_stones"
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "giant_boulder", "bomb")
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt.bullet.damage_radius = 100
tt.bullet.flight_time = fts(20)
tt.bullet.hit_fx = "fx_giant_boulder_explosion"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx_water = "fx_explosion_water"
tt.bullet.hit_fx_sort_y_offset = nil
tt.sound_events.hit = "HeroGiantExplosionRock"
tt.sound_events.hit_water = "RTWaterExplosion"
tt.sound_events.insert = nil
tt.render.sprites[1].name = "hero_giant_proy_0001"
tt.main_script.insert = scripts.giant_boulder.insert
tt = E.register_t(E, "fx_giant_boulder_explosion", "fx")
tt.render.sprites[1].name = "giant_boulder_explosion"
tt.render.sprites[1].z = Z_OBJECTS
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
tt.hero.fn_level_up = scripts.hero_wizard.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_wizard.get_info
tt.info.hero_portrait = "hero_portraits_0006"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0006") or "info_portraits_heroes_0006"
tt.info.damage_icon = "magic"
tt.main_script.insert = scripts.hero_wizard.insert
tt.main_script.update = scripts.hero_wizard.update
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
tt.ranged.attacks[1].max_range = 125
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
tt.main_script.insert = scripts.ray_wizard_chain.insert
tt.main_script.update = scripts.ray_wizard_chain.update
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
tt.main_script.insert = scripts.mod_ray_wizard.insert
tt.main_script.update = scripts.mod_ray_wizard.update
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
tt.main_script.update = scripts.missile.update
tt.main_script.insert = scripts.missile_wizard.insert
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
tt = E.register_t(E, "hero_beastmaster", "hero")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks", "auras")

anchor_y = 0.175
image_y = 80
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
	550
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
	46
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
	15
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
	23
}
tt.hero.skills.boarmaster = E.clone_c(E, "hero_skill")
tt.hero.skills.boarmaster.boars = {
	1,
	2,
	2
}
tt.hero.skills.boarmaster.hp_max = {
	160,
	160,
	240
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
	60
}
tt.hero.skills.falconer.max_range = {
	110,
	120,
	130
}
tt.hero.skills.falconer.damage_min = {
	3,
	9,
	18
}
tt.hero.skills.falconer.damage_max = {
	9,
	27,
	54
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
	fts(10)
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
tt.health.armor = nil
tt.health.dead_lifetime = 20
tt.health.hp_max = nil
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "timed_spawns_soldiers"
tt.health_bar.offset = v(0, 39)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_beastmaster.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_beastmaster.get_info
tt.info.hero_portrait = "hero_portraits_0003"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0003") or "info_portraits_heroes_0003"
tt.main_script.insert = scripts.hero_beastmaster.insert
tt.main_script.update = mylua.beastmaster.update
tt.motion.max_speed = 75
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_beastmaster"
tt.soldier.melee_slot_offset.x = 13
tt.sound_events.change_rally_point = "HeroBeastMasterTaunt"
tt.sound_events.death = "HeroBeastMasterDeath"
tt.sound_events.respawn = "HeroBeastMasterTauntIntro"
tt.sound_events.insert = "HeroBeastMasterTauntIntro"
tt.sound_events.hero_room_select = "HeroBeastMasterTauntSelect"
tt.unit.hit_offset = v(0, 12)
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
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(15)
tt.melee.attacks[2].animation = "lash"
tt.melee.attacks[2].cooldown = fts(27) + 8
tt.melee.attacks[2].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[2].vis_flags = bor(F_BLOCK, F_BLOOD)
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].sound = "HeroBeastMasterAttack"
tt.melee.attacks[2].mod = "mod_beastmaster_lash"
tt.melee.attacks[2].pop = nil
tt.melee.attacks[2].xp_gain_factor = 0.8
tt.melee.attacks[2].xp_from_skill = "deeplashes"
tt.falcons_max = 0
tt.falcons_name = "beastmaster_falcon"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animation = "stampede"
tt.timed_attacks.list[1].cooldown = 25
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
tt.timed_attacks.list[2].cooldown = 18
tt.timed_attacks.list[2].max = nil
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "beastmaster_boar"
tt.timed_attacks.list[2].sound = "HeroBeastMasterSummonBoar"
tt.timed_attacks.list[2].spawn_time = fts(35)
tt = E.register_t(E, "aura_beastmaster_regeneration", "aura")

E.add_comps(E, tt, "hps")

tt.hps.heal_min = nil
tt.hps.heal_max = nil
tt.hps.heal_every = nil
tt.main_script.update = scripts.aura_beastmaster_regeneration.update
tt = E.register_t(E, "mod_beastmaster_lash", "modifier")

E.add_comps(E, tt, "dps")

tt.modifier.duration = 6
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.fx = "fx_bleeding"
tt.dps.fx_with_blood_color = true
tt.dps.fx_tracks_target = true
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = E.register_t(E, "beastmaster_boar", "soldier")

E.add_comps(E, tt, "melee", "nav_grid")

anchor_y = 0.29
image_y = 60
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0010") or "info_portraits_heroes_0010"
tt.health.armor = 0
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 28)
tt.info.fn = scripts.beastmaster_boar.get_info
tt.main_script.insert = scripts.beastmaster_boar.insert
tt.main_script.update = scripts.beastmaster_boar.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 8
tt.melee.attacks[1].damage_min = 2
tt.melee.attacks[1].hit_time = fts(7)
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].sound = "HeroBeastMasterBoarAttack"
tt.melee.attacks[1].xp_gain_factor = 0.85
tt.melee.range = 85
tt.motion.max_speed = 69
tt.regen.health = 10
tt.regen.cooldown = 1
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "raise"
tt.render.sprites[1].prefix = "beastmaster_boar"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.soldier.melee_slot_offset.x = 9
tt.unit.hit_offset = v(0, 12)
tt.unit.mod_offset = v(0, 14)
tt.unit.hide_after_death = true
tt.unit.explode_fx = nil
tt.vis.bans = bor(F_SKELETON, F_CANNIBALIZE)
tt = E.register_t(E, "beastmaster_rhino", "decal_scripted")

E.add_comps(E, tt, "nav_path", "motion", "sound_events", "tween")

anchor_y = 0.45
image_y = 172
tt.attack = E.clone_c(E, "area_attack")
tt.attack.cooldown = fts(6)
tt.attack.damage = 15
tt.attack.damage_radius = 32.5
tt.attack.damage_type = DAMAGE_PHYSICAL
tt.attack.mod = "mod_beastmaster_rhino"
tt.attack.damage_bans = bor(F_FLYING, F_CLIFF, F_WATER)
tt.attack.damage_flags = F_AREA
tt.attack.mod_chance = nil
tt.duration = nil
tt.main_script.insert = scripts.beastmaster_rhino.insert
tt.main_script.update = scripts.beastmaster_rhino.update
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
tt = E.register_t(E, "mod_beastmaster_rhino", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts.mod_stun.insert
tt.main_script.update = scripts.mod_stun.update
tt.main_script.remove = scripts.mod_stun.remove
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
tt.main_script.update = scripts.beastmaster_falcon.update
tt.info.fn = scripts.beastmaster_falcon.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0011") or "info_portraits_heroes_0011"
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
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.ui.click_rect = r(-15, 65, 30, 30)
tt.owner = nil
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
	10,
	11,
	12,
	13,
	15,
	16,
	17,
	18,
	19,
	20
}
tt.hero.level_stats.armor = {
	0.11,
	0.12,
	0.13,
	0.14,
	0.15,
	0.16,
	0.17,
	0.18,
	0.19,
	0.2
}
tt.hero.level_stats.melee_damage_min = {
	8,
	10,
	11,
	13,
	14,
	16,
	17,
	18,
	19,
	21
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
	33
}
tt.hero.skills.energyglaive = E.clone_c(E, "hero_skill")
tt.hero.skills.energyglaive.damage = {
	40,
	50,
	60
}
tt.hero.skills.energyglaive.bounce_chance = {
	0.3,
	0.4,
	0.5
}
tt.hero.skills.purificationprotocol = E.clone_c(E, "hero_skill")
tt.hero.skills.purificationprotocol.duration = {
	2,
	4,
	6
}
tt.hero.skills.abduction = E.clone_c(E, "hero_skill")
tt.hero.skills.abduction.total_targets = {
	10,
	10,
	10
}
tt.hero.skills.abduction.total_hp = {
	250,
	600,
	1000
}
tt.hero.skills.vibroblades = E.clone_c(E, "hero_skill")
tt.hero.skills.vibroblades.extra_damage = {
	5,
	15,
	25
}
tt.hero.skills.vibroblades.damage_type = DAMAGE_TRUE
tt.hero.skills.finalcountdown = E.clone_c(E, "hero_skill")
tt.hero.skills.finalcountdown.damage = {
	300,
	550,
	800
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
tt.health.armor = nil
tt.health.dead_lifetime = 15
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 41)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_alien.level_up
tt.hero.tombstone_show_time = fts(66)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_alien.get_info
tt.info.hero_portrait = "hero_portraits_0007"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0007") or "info_portraits_heroes_0007"
tt.main_script.insert = scripts.hero_alien.insert
tt.main_script.update = scripts.hero_alien.update
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
tt.melee.range = 65
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
tt.ranged.attacks[1].cooldown = fts(28) + 7
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
tt.timed_attacks.list[1].range = 50
tt.timed_attacks.list[1].attack_radius = 50
tt.timed_attacks.list[1].spawn_time = fts(10)
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_CLIFF, F_WATER, F_BOSS)
tt.timed_attacks.list[1].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[1].sound = "HeroAlienAbduction"
tt.timed_attacks.list[1].invalid_templates = {
	"enemy_umbra_piece",
	"enemy_jungle_spider_tiny"
}
tt.timed_attacks.list[1].total_health = nil
tt.timed_attacks.list[1].total_targets = nil
tt.timed_attacks.list[2] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].animation = "purification"
tt.timed_attacks.list[2].cooldown = 14
tt.timed_attacks.list[2].entity = "alien_purification_drone"
tt.timed_attacks.list[2].range = 125
tt.timed_attacks.list[2].spawn_time = fts(34)
tt.timed_attacks.list[2].vis_bans = bor(F_BOSS)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].invalid_templates = {
	"enemy_umbra_piece",
	"enemy_jungle_spider_tiny"
}
tt.timed_attacks.list[2].total_health = nil
tt.timed_attacks.list[2].total_targets = nil
tt.selfdestruct.damage = nil
tt.selfdestruct.damage_radius = 150
tt.selfdestruct.damage_type = DAMAGE_TRUE
tt.selfdestruct.disabled = true
tt.selfdestruct.hit_time = fts(48)
tt.selfdestruct.sound_hit = "HeroAlienExplosion"
tt = E.register_t(E, "alien_glaive", "bullet")
tt.main_script.update = scripts.alien_glaive.update
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
tt.bounce_chance = nil
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

tt.main_script.update = scripts.alien_abduction_ship.update
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
local oy = 50
local rays = {
	{
		v(ox - 47, oy + 52),
		fts(0),
		"1"
	},
	{
		v(ox - 106, oy + 75),
		fts(5),
		"1"
	},
	{
		v(ox - 49, oy + 70),
		fts(10),
		"1"
	},
	{
		v(ox - 84, oy + 46),
		fts(10),
		"2"
	},
	{
		v(ox - 142, oy + 57),
		fts(15),
		"2"
	},
	{
		v(ox - 58, oy + 81),
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
tt.main_script.update = scripts.alien_purification_drone.update
tt.dps.damage_max = 10
tt.dps.damage_every = fts(6)
tt.dps.damage_type = DAMAGE_TRUE
tt.jump_range = 300
tt.switch_targets_every = fts(31)
tt.vis_bans = bor(F_BOSS)
tt.vis_flags = bor(F_RANGED)
tt.duration = nil
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
	15,
	18,
	20,
	21,
	22,
	24,
	25,
	27,
	28,
	30
}
tt.hero.level_stats.melee_damage_max = {
	25,
	27,
	28,
	30,
	33,
	36,
	38,
	40,
	42,
	45
}
tt.hero.level_stats.ranged_damage_min = {
	26,
	28,
	30,
	33,
	36,
	38,
	40,
	42,
	44,
	45
}
tt.hero.level_stats.ranged_damage_max = {
	40,
	42,
	44,
	46,
	48,
	50,
	52,
	54,
	56,
	59
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
	0.2,
	0.35,
	0.5
}
tt.hero.skills.holylight.xp_gain_factor = 12
tt.hero.skills.consecrate = E.clone_c(E, "hero_skill")
tt.hero.skills.consecrate.duration = {
	10,
	15,
	20
}
tt.hero.skills.consecrate.extra_damage = {
	0.3,
	0.4,
	0.5
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
	10,
	15,
	20
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
	2.2,
	2.6,
	3.4
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
tt.health.armor = nil
tt.health.dead_lifetime = 15
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 37)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_priest.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_priest.get_info
tt.info.hero_portrait = "hero_portraits_0005"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0005") or "info_portraits_heroes_0005"
tt.info.damage_icon = "magic"
tt.main_script.insert = scripts.hero_priest.insert
tt.main_script.update = scripts.hero_priest.update
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
tt.melee.range = 50
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
tt.timed_attacks.list[1].range = 150
tt.timed_attacks.list[1].shoot_time = fts(4)
tt.timed_attacks.list[1].sound = "HeroPriestHolyLight"
tt.timed_attacks.list[1].excluded_templates = {
	"soldier_mecha",
	"soldier_sand_warrior",
	"soldier_dracolich_golem"
}
tt.timed_attacks.list[2] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].animation = "consecrate"
tt.timed_attacks.list[2].cooldown = 12
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
	"tower_barrack_mercenary"
}
tt.timed_attacks.list[2].mod = "mod_priest_consecrate"
tt.timed_attacks.list[2].range = 150
tt.timed_attacks.list[2].shoot_time = fts(15)
tt.timed_attacks.list[2].sound = "HeroPriestConsecrate"
tt = E.register_t(E, "bolt_priest", "bolt")
tt.bullet.xp_gain_factor = 0.7
tt.render.sprites[1].prefix = "bolt_priest"
tt.bullet.damage_min = nil
tt.bullet.damage_max = nil
tt = E.register_t(E, "mod_priest_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.modifier.duration = fts(24)
tt.hps.heal_min = 25
tt.hps.heal_max = 25
tt.hps.heal_every = 9e+99
tt.render.sprites[1].name = "fx_priest_heal"
tt.render.sprites[1].loop = false
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
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
tt.main_script.update = scripts1.aura_ranger_thorn.update
tt = E.register_t(E, "mod_priest_armor", "modifier")

E.add_comps(E, tt, "render", "armor_buff")

tt.modifier.duration = nil
tt.modifier.use_mod_offset = false
tt.armor_buff.max_factor = 0.2
tt.armor_buff.step_factor = 0.2
tt.armor_buff.cycle_time = 1e+99
tt.main_script.insert = scripts.mod_armor_buff.insert
tt.main_script.remove = scripts.mod_armor_buff.remove
tt.main_script.update = scripts.mod_armor_buff.update
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
tt.main_script.update = scripts.mod_priest_consecrate.update
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
tt = E.register_t(E, "hero_dragon", "hero")

E.add_comps(E, tt, "ranged", "timed_attacks")

anchor_y = 0.065
image_y = 310
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
tt.hero.level_stats.regen_health = {
	21,
	22,
	23,
	24,
	25,
	26,
	27,
	28,
	29,
	30
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
	20,
	23,
	25,
	28,
	30,
	32,
	35,
	37,
	40,
	42
}
tt.hero.level_stats.ranged_damage_max = {
	35,
	38,
	40,
	42,
	43,
	45,
	47,
	50,
	53,
	57
}
tt.hero.skills.blazingbreath = E.clone_c(E, "hero_skill")
tt.hero.skills.blazingbreath.damage = {
	50,
	100,
	150,
}
tt.hero.skills.blazingbreath.xp_gain_factor = 30
tt.hero.skills.feast = E.clone_c(E, "hero_skill")
tt.hero.skills.feast.devour_chance = {
	1,
	1,
	1
}
tt.hero.skills.feast.damage = {
	500,
	750,
	1000
}
tt.hero.skills.feast.xp_gain_factor = 120
tt.hero.skills.fierymist = E.clone_c(E, "hero_skill")
tt.hero.skills.fierymist.slow_factor = {
	0.6,
	0.55,
	0.5
}
tt.hero.skills.fierymist.duration = {
	4,
	6,
	8
}
tt.hero.skills.fierymist.xp_gain_factor = 20
tt.hero.skills.wildfirebarrage = E.clone_c(E, "hero_skill")
tt.hero.skills.wildfirebarrage.explosions = {
	4,
	8,
	12
}
tt.hero.skills.wildfirebarrage.xp_gain_factor = 80
tt.hero.skills.reignoffire = E.clone_c(E, "hero_skill")
tt.hero.skills.reignoffire.dps = {
	10,
	20,
	30
}
tt.hero.use_custom_spawn_point = true
tt.hero.skills.blazingbreath.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.blazingbreath.hr_icon = 43
tt.hero.skills.blazingbreath.hr_order = 1
tt.hero.skills.feast.hr_cost = {
	3,
	2,
	2
}
tt.hero.skills.feast.hr_icon = 45
tt.hero.skills.feast.hr_order = 2
tt.hero.skills.fierymist.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.fierymist.hr_icon = 44
tt.hero.skills.fierymist.hr_order = 3
tt.hero.skills.wildfirebarrage.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.wildfirebarrage.hr_icon = 42
tt.hero.skills.wildfirebarrage.hr_order = 4
tt.hero.skills.reignoffire.hr_cost = {
	1,
	2,
	2
}
tt.hero.skills.reignoffire.hr_icon = 41
tt.hero.skills.reignoffire.hr_order = 5
tt.health.armor = nil
tt.health.dead_lifetime = 30
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 189.85)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.draw_order = -1
tt.health_bar.sort_y_offset = -200
tt.hero.fn_level_up = scripts.hero_dragon.level_up
tt.hero.tombstone_show_time = nil
tt.idle_flip.cooldown = 10
tt.info.fn = scripts.hero_dragon.get_info
tt.info.hero_portrait = "hero_portraits_0009"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0009") or "info_portraits_heroes_0009"
tt.info.damage_icon = "fireball"
tt.main_script.insert = scripts.hero_dragon.insert
tt.main_script.update = scripts.hero_dragon.update
tt.motion.max_speed = 100
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_dragon"
tt.render.sprites[1].angles.walk = {
	"idle"
}
tt.render.sprites[1].sort_y_offset = -200
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_dragon_0181"
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].offset = v(0, 0)
tt.render.sprites[2].alpha = 60
tt.sound_events.change_rally_point = "HeroDragonTaunt"
tt.sound_events.death = "HeroDragonDeath"
tt.sound_events.respawn = "HeroDragonBorn"
tt.sound_events.insert = "HeroDragonTauntIntro"
tt.sound_events.hero_room_select = "HeroDragonTauntSelect"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-35, 95, 70, 70)) or r(-30, 115, 60, 40)
tt.unit.hit_offset = v(0, 135)
tt.unit.hide_after_death = true
tt.unit.marker_offset = v(0, -0.15)
tt.unit.mod_offset = v(0, 134.85)
tt.vis.bans = bor(tt.vis.bans, F_EAT, F_NET, F_POISON)
tt.vis.flags = bor(tt.vis.flags, F_FLYING)
tt.ranged.attacks[1] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[1].bullet = "fireball_dragon"
tt.ranged.attacks[1].bullet_start_offset = {
	v(55, 105)
}
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 200
tt.ranged.attacks[1].shoot_time = fts(11)
tt.ranged.attacks[1].sync_animation = true
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].xp_gain_factor = 0.8
tt.ranged.attacks[1].animation = "range_attack"
tt.ranged.attacks[1].emit_fx = "fx_fireball_throw"
tt.ranged.attacks[1].estimated_flight_time = 1
tt.ranged.attacks[1].sound = "HeroDragonAttackThrow"
tt.ranged.attacks[2] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[2].name = "blazingbreath"
tt.ranged.attacks[2].disabled = true
tt.ranged.attacks[2].bullet = "breath_dragon"
tt.ranged.attacks[2].bullet_start_offset = {
	v(43, 95)
}
tt.ranged.attacks[2].cooldown = 12
tt.ranged.attacks[2].min_range = 50
tt.ranged.attacks[2].max_range = 200
tt.ranged.attacks[2].shoot_time = fts(13)
tt.ranged.attacks[2].sync_animation = true
tt.ranged.attacks[2].xp_from_skill = "blazingbreath"
tt.ranged.attacks[2].animation = "breath"
tt.ranged.attacks[2].sound = "HeroDragonFlame"
tt.ranged.attacks[2].emit_fx = "fx_breath_dragon_mouth_glow"
tt.ranged.attacks[2].emit_ps = "ps_breath_dragon"
tt.ranged.attacks[2].vis_bans = F_FLYING
tt.ranged.attacks[2].nodes_limit = 10
tt.ranged.attacks[3] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[3].name = "fierymist"
tt.ranged.attacks[3].disabled = true
tt.ranged.attacks[3].bullet = "fierymist_dragon"
tt.ranged.attacks[3].bullet_start_offset = {
	v(43, 95)
}
tt.ranged.attacks[3].cooldown = 24
tt.ranged.attacks[3].min_range = 40
tt.ranged.attacks[3].max_range = 200
tt.ranged.attacks[3].shoot_time = fts(13)
tt.ranged.attacks[3].sync_animation = true
tt.ranged.attacks[3].xp_from_skill = "fierymist"
tt.ranged.attacks[3].animation = "mist"
tt.ranged.attacks[3].emit_fx = "fx_breath_dragon_mouth_glow"
tt.ranged.attacks[3].emit_ps = "ps_fierymist_dragon"
tt.ranged.attacks[3].vis_bans = F_FLYING
tt.ranged.attacks[3].sound = "HeroDragonSmoke"
tt.ranged.attacks[3].nodes_limit = 10
tt.ranged.attacks[4] = E.clone_c(E, "bullet_attack")
tt.ranged.attacks[4].name = "wildfirebarrage"
tt.ranged.attacks[4].disabled = true
tt.ranged.attacks[4].bullet = "wildfirebarrage_dragon"
tt.ranged.attacks[4].bullet_start_offset = {
	v(30, ady(204))
}
tt.ranged.attacks[4].cooldown = 16
tt.ranged.attacks[4].min_range = 100
tt.ranged.attacks[4].max_range = 250
tt.ranged.attacks[4].shoot_time = fts(7.8)
tt.ranged.attacks[4].sync_animation = true
tt.ranged.attacks[4].xp_from_skill = "wildfirebarrage"
tt.ranged.attacks[4].animation = "wildfirebarrage"
tt.ranged.attacks[4].emit_fx = "fx_emit_wildfirebarrage"
tt.ranged.attacks[4].vis_bans = F_FLYING
tt.ranged.attacks[4].sound = "HeroDragonNapalm"
tt.ranged.attacks[4].nodes_limit = 10
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].cooldown = 30
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 30
tt.timed_attacks.list[1].damage = nil
tt.timed_attacks.list[1].devour_chance = nil
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = bor(F_FLYING, F_BOSS, F_WATER, F_CLIFF)
tt.timed_attacks.list[1].sound = "HeroDragonTauntSelect"
tt = E.register_t(E, "fireball_dragon", "bullet")
tt.render.sprites[1].name = "hero_dragon_attack_proy"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[1].anchor.x = 0.69
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.min_speed = 390
tt.bullet.max_speed = 390
tt.bullet.hit_fx = "fx_fireball_dragon_hit"
tt.bullet.hit_fx_air = "fx_fireball_explosion_air"
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 40
tt.bullet.particles_name = "ps_fireball_dragon"
tt.bullet.vis_flags = F_RANGED
tt.bullet.mod = nil
tt.main_script.update = scripts.fireball_dragon.update
tt.sound_events.hit = "HeroDragonAttackHit"
tt = E.register_t(E, "fx_fireball_dragon_hit", "fx")
tt.render.sprites[1].name = "fx_fireball_dragon_hit"
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].z = Z_EFFECTS
tt = E.register_t(E, "fx_fireball_explosion_air", "fx_explosion_air")
tt.render.sprites[1].scale = v(0.7, 0.7)
tt.render.sprites[1].z = Z_EFFECTS
tt = E.register_t(E, "fx_fireball_throw", "fx")
tt.render.sprites[1].name = "fx_dragon_range_attack"
tt.render.sprites[1].z = Z_BULLETS + 1
tt = E.register_t(E, "ps_fireball_dragon")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "hero_dragon_fireThrow_particle2"
tt.particle_system.animated = false
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
tt.particle_system.emission_rate = 40
tt.particle_system.emit_spread = math.pi
tt.particle_system.alphas = {
	255,
	0
}
tt = E.register_t(E, "mod_dragon_reign", "modifier")

E.add_comps(E, tt, "dps", "render")

tt.modifier.duration = 3
tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = fts(15)
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.render.sprites[1].size_names = {
	"small",
	"medium",
	"large"
}
tt.render.sprites[1].prefix = "fire"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].loop = true
tt = E.register_t(E, "breath_dragon", "bullet")
tt.render.sprites[1].name = "hero_dragon_flameBurnDecal"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].hidden = true
tt.bullet.flight_time = fts(10)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.mod = nil
tt.bullet.damage_radius = 80
tt.bullet.damage_flags = F_AREA
tt.main_script.update = scripts.breath_dragon.update
tt.duration = fts(20)
tt = E.register_t(E, "fx_breath_dragon_fire", "fx")
tt.render.sprites[1].name = "dragon_breath_fire"
tt.render.sprites[1].anchor.y = 0.3472222222222222
tt = E.register_t(E, "fx_breath_dragon_fire_decal", "fx")
tt.render.sprites[1].name = "dragon_breath_fire_decal"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor.y = 0.3424657534246575
tt = E.register_t(E, "fx_breath_dragon_mouth_glow", "decal_timed")
tt.render.sprites[1].name = "hero_dragon_flameBurnGlow_cut"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.timed.duration = fts(20)
tt = E.register_t(E, "ps_breath_dragon")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "dragon_breath_particle"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.source_lifetime = fts(20)
tt = E.register_t(E, "fx_dragon_feast", "fx")
tt.render.sprites[1].name = "fx_dragon_feast"
tt.render.sprites[1].anchor.y = 0.065
tt = E.register_t(E, "fx_dragon_feast_explode", "fx")
tt.render.sprites[1].name = "fx_dragon_feast_explode"
tt.render.sprites[1].anchor.y = 0.065
tt.render.sprites[1].size_scales = {
	vv(0.8),
	vv(1),
	vv(1.2)
}
tt = E.register_t(E, "fierymist_dragon", "bullet")
tt.render = nil
tt.bullet.flight_time = fts(10)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_max = 50
tt.bullet.damage_min = 50
tt.bullet.vis_flags = F_RANGED
tt.bullet.hit_payload = "aura_fierymist_dragon"
tt.main_script.update = scripts.fierymist_dragon.update
tt = E.register_t(E, "ps_fierymist_dragon")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.emission_rate = 30
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.loop = false
tt.particle_system.name = "dragon_fierymist_particle"
tt.particle_system.particle_lifetime = {
	fts(10),
	fts(10)
}
tt.particle_system.source_lifetime = fts(20)
tt = E.register_t(E, "aura_fierymist_dragon", "aura")
tt.aura.mod = "mod_slow_fierymist"
tt.aura.cycle_time = fts(5)
tt.aura.duration = nil
tt.aura.radius = 70
tt.aura.vis_flags = F_MOD
tt.aura.vis_bans = F_FRIEND
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "mod_slow_fierymist", "mod_slow")
tt.modifier.duration = fts(5)
tt.slow.factor = nil
tt = E.register_t(E, "fx_aura_fierymist_dragon", "decal_tween")
tt.duration = nil
tt.render.sprites[1].name = "fx_fierymist_dragon"
tt.render.sprites[1].anchor.y = 0.15
tt.render.sprites[1].z = Z_OBJECTS
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
		"this.duration-0.3",
		255
	},
	{
		"this.duration",
		0
	}
}
tt = E.register_t(E, "wildfirebarrage_dragon", "bullet")
tt.render.sprites[1].name = "dragon_wildfirebarrage_projectile"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_BULLETS
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.min_speed = 390
tt.bullet.max_speed = 390
tt.bullet.flight_time = fts(35)
tt.bullet.hit_fx = "fx_fireball_dragon_hit"
tt.bullet.damage_max = 40
tt.bullet.damage_min = 40
tt.bullet.damage_radius = 40
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.particles_name = "ps_wildbarrage_dragon"
tt.bullet.damage_flags = F_AREA
tt.bullet.mod = nil
tt.main_script.insert = scripts.wildfirebarrage_dragon.insert
tt.main_script.update = scripts.wildfirebarrage_dragon.update
tt.sound_events.hit = "HeroDragonAttackHit"
tt.explosions = nil
tt = E.register_t(E, "fx_emit_wildfirebarrage", "fx")
tt.render.sprites[1].name = "fx_dragon_wildfirebarrage"
tt.render.sprites[1].z = Z_BULLETS + 1
tt.render.sprites[1].offset = v(-28, -48)
tt = E.register_t(E, "ps_wildbarrage_dragon")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.name = "dragon_wildfirebarrage_particle"
tt.particle_system.animated = true
tt.particle_system.loop = false
tt.particle_system.particle_lifetime = {
	0.58,
	0.58
}
tt.particle_system.scale_var = {
	0.55,
	0.9
}
tt.particle_system.scales_x = {
	1,
	1.55
}
tt.particle_system.scales_y = {
	1,
	1.55
}
tt.particle_system.emission_rate = 60
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.alphas = {
	255,
	0
}
tt = E.register_t(E, "fx_wildfirebarrage_explosion_1", "fx")
tt.render.sprites[1].name = "dragon_wildfirebarrage_explosion_1"
tt.render.sprites[1].anchor.y = 0.24
tt = E.register_t(E, "fx_wildfirebarrage_explosion_2", "fx")
tt.render.sprites[1].name = "dragon_wildfirebarrage_explosion_2"
tt.render.sprites[1].anchor.y = 0.16
tt = E.register_t(E, "decal_wildfirebarrage_explosion", "decal_timed")
tt.render.sprites[1].name = "dragon_wildfirebarrage_decal"
tt.render.sprites[1].anchor.y = 0.3
tt.render.sprites[1].z = Z_DECALS
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
tt.hero.fn_level_up = scripts.hero_pirate.level_up
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
	0.3
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
	6
}
tt.hero.skills.kraken.xp_gain_factor = 70
tt.hero.skills.scattershot = E.clone_c(E, "hero_skill")
tt.hero.skills.scattershot.fragments = {
	4,
	6,
	8
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
tt.info.fn = scripts.hero_pirate.get_info
tt.info.hero_portrait = "hero_portraits_0004"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0004") or "info_portraits_heroes_0004"
tt.main_script.insert = scripts.hero_pirate.insert
tt.main_script.update = scripts.hero_pirate.update
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
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "mod_pirate_loot", "modifier")
tt.modifier.duration = fts(13)
tt.main_script.insert = scripts.mod_pirate_loot.insert
tt.main_script.update = scripts.mod_pirate_loot.update
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
tt.main_script.insert = scripts.mod_stun_kraken.insert
tt.main_script.remove = scripts.mod_stun_kraken.remove
tt.main_script.update = scripts.mod_stun_kraken.update
tt = E.register_t(E, "mod_dps_kraken", "modifier")

E.add_comps(E, tt, "dps")

tt.modifier.level = 1
tt.modifier.duration = 3
tt.dps.damage_min = 30
tt.dps.damage_max = 30
tt.dps.damage_every = fts(10)
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt = E.register_t(E, "mod_slow_kraken", "mod_slow")
tt.modifier.duration = fts(10)
tt.slow.factor = 0.5
tt = E.register_t(E, "hero_monk", "hero")

E.add_comps(E, tt, "dodge", "melee", "timed_attacks")

anchor_y = 0.18446601941747573
image_y = 206
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
tt.hero.level_stats.regen_health = {
	24,
	25,
	26,
	27,
	28,
	29,
	30,
	31,
	32,
	33
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
	17,
	19,
	21,
	23,
	25,
	27,
	29,
	31,
	33,
	35
}
tt.hero.level_stats.melee_damage_max = {
	27,
	30,
	33,
	35,
	37,
	40,
	42,
	45,
	48,
	50
}
tt.hero.skills.snakestyle = E.clone_c(E, "hero_skill")
tt.hero.skills.snakestyle.damage = {
	40,
	60,
	80
}
tt.hero.skills.snakestyle.damage_reduction_factor = {
	0.2,
	0.4,
	0.6
}
tt.hero.skills.snakestyle.xp_gain_factor = 35
tt.hero.skills.dragonstyle = E.clone_c(E, "hero_skill")
tt.hero.skills.dragonstyle.damage_max = {
	180,
	210,
	240
}
tt.hero.skills.dragonstyle.damage_min = {
	120,
	150,
	180
}
tt.hero.skills.dragonstyle.xp_gain_factor = 90
tt.hero.skills.tigerstyle = E.clone_c(E, "hero_skill")
tt.hero.skills.tigerstyle.damage = {
	100,
	200,
	300
}
tt.hero.skills.tigerstyle.xp_gain_factor = 20
tt.hero.skills.leopardstyle = E.clone_c(E, "hero_skill")
tt.hero.skills.leopardstyle.loops = {
	6,
	8,
	10
}
tt.hero.skills.leopardstyle.damage_max = {
	20,
	25,
	30
}
tt.hero.skills.leopardstyle.damage_min = {
	20,
	25,
	30
}
tt.hero.skills.leopardstyle.xp_gain_factor = 30
tt.hero.skills.cranestyle = E.clone_c(E, "hero_skill")
tt.hero.skills.cranestyle.damage = {
	20,
	40,
	60
}
tt.hero.skills.cranestyle.chance = {
	0.2,
	0.4,
	0.6
}
tt.hero.skills.cranestyle.xp_gain_factor = 15
tt.hero.skills.snakestyle.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.snakestyle.hr_icon = 51
tt.hero.skills.snakestyle.hr_order = 1
tt.hero.skills.dragonstyle.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.dragonstyle.hr_icon = 55
tt.hero.skills.dragonstyle.hr_order = 2
tt.hero.skills.tigerstyle.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.tigerstyle.hr_icon = 53
tt.hero.skills.tigerstyle.hr_order = 3
tt.hero.skills.leopardstyle.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.leopardstyle.hr_icon = 54
tt.hero.skills.leopardstyle.hr_order = 4
tt.hero.skills.cranestyle.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.cranestyle.hr_icon = 52
tt.hero.skills.cranestyle.hr_order = 5
tt.health.armor = nil
tt.health.dead_lifetime = 15
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 38)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_monk.level_up
tt.hero.tombstone_show_time = fts(66)
tt.idle_flip.cooldown = 1
tt.info.fn = scripts.hero_monk.get_info
tt.info.hero_portrait = "hero_portraits_0013"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0016") or "info_portraits_heroes_0015"
tt.main_script.insert = scripts.hero_monk.insert
tt.main_script.update = scripts.hero_monk.update
tt.motion.max_speed = 90
tt.regen.cooldown = 0.5
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_monk"
tt.soldier.melee_slot_offset.x = 5
tt.sound_events.change_rally_point = "HeroMonkTaunt"
tt.sound_events.death = "HeroMonkDeath"
tt.sound_events.respawn = "HeroMonkTauntIntro"
tt.sound_events.insert = "HeroMonkTauntIntro"
tt.sound_events.hero_room_select = "HeroMonkTauntSelect"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, -1)
tt.unit.mod_offset = v(0, 18)
tt.unit.size = UNIT_SIZE_SMALL
tt.dodge.disabled = true
tt.dodge.animation = "crane"
tt.dodge.cooldown = 1
tt.dodge.chance = 0
tt.dodge.damage_min = nil
tt.dodge.damage_max = nil
tt.dodge.damage_type = DAMAGE_PHYSICAL
tt.dodge.hit_time = fts(18)
tt.dodge.sound = "HeroMonkCounter"
tt.melee.cooldown = 1
tt.melee.range = 65
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].animation = "attack1"
tt.melee.attacks[1].hit_time = fts(18)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].xp_gain_factor = 0.6
tt.melee.attacks[1].sound = "MeleeSword"
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.33
tt.melee.attacks[2].hit_time = fts(14)
tt.melee.attacks[3] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[3].animation = "attack3"
tt.melee.attacks[3].chance = 0.5
tt.melee.attacks[3].hit_time = fts(5)
tt.melee.attacks[4] = E.clone_c(E, "melee_attack")
tt.melee.attacks[4].disabled = true
tt.melee.attacks[4].animation = "snake"
tt.melee.attacks[4].chance = 1
tt.melee.attacks[4].cooldown = 8
tt.melee.attacks[4].damage_max = nil
tt.melee.attacks[4].damage_min = nil
tt.melee.attacks[4].hit_time = fts(18)
tt.melee.attacks[4].mod = "mod_monk_damage_reduction"
tt.melee.attacks[4].sound = "HeroMonkSnakeAttack"
tt.melee.attacks[4].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.melee.attacks[4].vis_flags = F_BLOCK
tt.melee.attacks[4].xp_from_skill = "snakestyle"
tt.melee.attacks[5] = E.clone_c(E, "melee_attack")
tt.melee.attacks[5].disabled = true
tt.melee.attacks[5].animation = "tiger"
tt.melee.attacks[5].chance = 1
tt.melee.attacks[5].cooldown = 15
tt.melee.attacks[5].damage_max = nil
tt.melee.attacks[5].damage_min = nil
tt.melee.attacks[5].damage_type = DAMAGE_TRUE
tt.melee.attacks[5].hit_time = fts(11)
tt.melee.attacks[5].sound = "HeroMonkHadoken"
tt.melee.attacks[5].xp_from_skill = "tigerstyle"
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "dragon"
tt.timed_attacks.list[1].cooldown = 20
tt.timed_attacks.list[1].damage_max = nil
tt.timed_attacks.list[1].damage_min = nil
tt.timed_attacks.list[1].damage_flags = bor(F_AREA)
tt.timed_attacks.list[1].damage_radius = 150
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(26)
tt.timed_attacks.list[1].sound = "HeroMonkFiredragon"
tt.timed_attacks.list[1].xp_from_skill = "dragonstyle"
tt.timed_attacks.list[1].max_range = 75
tt.timed_attacks.list[2] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[2].cooldown = 18
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].hit_animations = {
	"leopard_hit1",
	"leopard_hit2",
	"leopard_hit3",
	"leopard_hit4"
}
tt.timed_attacks.list[2].hit_times = {
	fts(6),
	fts(6),
	fts(6),
	fts(6)
}
tt.timed_attacks.list[2].particle_pos = {
	v(20, 14),
	v(24, 22),
	v(18, 14),
	v(21, 18)
}
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING, F_BOSS, F_WATER, F_CLIFF)
tt.timed_attacks.list[2].vis_flags = bor(F_STUN, F_RANGED)
tt.timed_attacks.list[2].loops = nil
tt.timed_attacks.list[2].range = 100
tt.timed_attacks.list[2].xp_from_skill = "leopardstyle"
tt = E.register_t(E, "mod_monk_damage_reduction", "modifier")
tt.main_script.insert = scripts.mod_monk_damage_reduction.insert
tt.reduction_factor = nil
tt = E.register_t(E, "hero_crab", "hero")

E.add_comps(E, tt, "water", "melee", "ranged", "timed_attacks")

anchor_y = 0.26785714285714285
image_y = 112
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
	25
}
tt.hero.level_stats.armor = {
	0.32,
	0.34,
	0.36,
	0.38,
	0.4,
	0.42,
	0.44,
	0.46,
	0.48,
	0.5
}
tt.hero.level_stats.melee_damage_min = {
	12,
	14,
	16,
	18,
	20,
	22,
	24,
	26,
	28,
	30
}
tt.hero.level_stats.melee_damage_max = {
	25,
	27,
	29,
	31,
	33,
	35,
	37,
	40,
	42,
	45
}
tt.hero.skills.hookedclaw = E.clone_c(E, "hero_skill")
tt.hero.skills.hookedclaw.extra_damage = {
	5,
	10,
	20
}
tt.hero.skills.battlehardened = E.clone_c(E, "hero_skill")
tt.hero.skills.battlehardened.chance = {
	0.1111,
	0.2222,
	0.3333
}
tt.hero.skills.battlehardened.xp_gain_factor = 100
tt.hero.skills.pincerattack = E.clone_c(E, "hero_skill")
tt.hero.skills.pincerattack.damage_min = {
	100,
	150,
	200
}
tt.hero.skills.pincerattack.damage_max = {
	100,
	150,
	200
}
tt.hero.skills.pincerattack.xp_gain_factor = 80
tt.hero.skills.shouldercannon = E.clone_c(E, "hero_skill")
tt.hero.skills.shouldercannon.damage = {
	50,
	75,
	100
}
tt.hero.skills.shouldercannon.slow_factor = {
	0.6,
	0.5,
	0.4
}
tt.hero.skills.shouldercannon.slow_duration = {
	4,
	6,
	8
}
tt.hero.skills.shouldercannon.xp_gain_factor = 30
tt.hero.skills.burrow = E.clone_c(E, "hero_skill")
tt.hero.skills.burrow.range = {
	100,
	100,
	100
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
	2
}
tt.hero.skills.hookedclaw.hr_icon = 46
tt.hero.skills.hookedclaw.hr_order = 1
tt.hero.skills.battlehardened.hr_cost = {
	3,
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
tt.health.on_damage = scripts.hero_crab.on_damage
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_crab.level_up
tt.hero.tombstone_show_time = fts(66)
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.hero_crab.get_info
tt.info.hero_portrait = "hero_portraits_0012"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0015") or "info_portraits_heroes_0014"
tt.main_script.insert = scripts.hero_crab.insert
tt.main_script.update = scripts.hero_crab.update
tt.motion.max_speed = 57
tt.regen.cooldown = 1
tt.regen.health = nil
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
tt.unit.hit_offset = v(0, 17)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 23)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.burrow = {
	disabled = true,
	extra_speed = nil,
	damage_radius = nil,
	health_bar_offset = v(0, 30),
	hit_offset = v(0, -13),
	min_distance = 100,
	mod_offset = v(0, -7)
}
tt.invuln = {
	animation = "invuln",
	aura = nil,
	aura_name = "aura_crab_invuln",
	chance = nil,
	cooldown = 4,
	disabled = true,
	duration = 4,
	exclude_damage_types = bor(DAMAGE_INSTAKILL, DAMAGE_DISINTEGRATE, DAMAGE_DISINTEGRATE_BOSS, DAMAGE_EAT),
	sound = "HeroCrabShield",
	trigger_factor = 0.4,
	ts = 0,
	pending = nil
}
tt.melee.cooldown = 1.2
tt.melee.range = 55
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].animation = "attack"
tt.melee.attacks[1].hit_time = fts(18)
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
tt.ranged.attacks[1].cooldown = 10
tt.ranged.attacks[1].ignore_hit_offset = true
tt.ranged.attacks[1].max_range = 256
tt.ranged.attacks[1].min_range = 19.2
tt.ranged.attacks[1].shoot_time = fts(30)
tt.ranged.attacks[1].vis_bans = bor(F_FLYING)
tt.ranged.attacks[1].xp_from_skill = "shouldercannon"
tt.ranged.attacks[1].node_prediction = fts(61)
tt.timed_attacks.list[1] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[1].animation = "pincer"
tt.timed_attacks.list[1].cooldown = 7
tt.timed_attacks.list[1].damage_flags = bor(F_AREA)
tt.timed_attacks.list[1].damage_max = nil
tt.timed_attacks.list[1].damage_min = nil
tt.timed_attacks.list[1].damage_size = v(120, 85)
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].hit_time = fts(12)
tt.timed_attacks.list[1].max_range = 110
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].sound = "HeroCrabPrincer"
tt.timed_attacks.list[1].xp_from_skill = "pincerattack"
tt = E.register_t(E, "crab_water_bomb", "bomb")
tt.bullet.damage_radius = 110
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.flight_time = fts(31)
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
tt.aura.radius = 110
tt.aura.vis_bans = F_FRIEND
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
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
tt.main_script.update = scripts.aura_crab_invuln.update
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
	20,
	22,
	24,
	25,
	26,
	28,
	30,
	32,
	33,
	35
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
	16,
	18,
	20,
	21,
	22,
	24,
	25,
	27,
	28,
	30
}
tt.hero.level_stats.ranged_damage_max = {
	30,
	32,
	34,
	36,
	38,
	40,
	42,
	44,
	47,
	50
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
	6
}
tt.hero.skills.spinerain = E.clone_c(E, "hero_skill")
tt.hero.skills.spinerain.count = {
	6,
	8,
	10
}
tt.hero.skills.spinerain.damage_min = {
	20,
	25,
	30
}
tt.hero.skills.spinerain.damage_max = {
	20,
	25,
	30
}
tt.hero.skills.spinerain.xp_gain_factor = 60
tt.hero.skills.bonegolem = E.clone_c(E, "hero_skill")
tt.hero.skills.bonegolem.hp_max = {
	80,
	120,
	160
}
tt.hero.skills.bonegolem.damage_min = {
	2,
	4,
	6
}
tt.hero.skills.bonegolem.damage_max = {
	6,
	8,
	10
}
tt.hero.skills.bonegolem.duration = {
	20,
	30,
	40
}
tt.hero.skills.bonegolem.xp_gain_factor = 30
tt.hero.skills.plaguecarrier = E.clone_c(E, "hero_skill")
tt.hero.skills.plaguecarrier.xp_gain_factor = 120
tt.hero.skills.plaguecarrier.count = {
	6,
	8,
	10
}
tt.hero.skills.plaguecarrier.duration = {
	3,
	5,
	7
}
tt.hero.skills.diseasenova = E.clone_c(E, "hero_skill")
tt.hero.skills.diseasenova.xp_gain_factor = 120
tt.hero.skills.diseasenova.damage_min = {
	50,
	100,
	150
}
tt.hero.skills.diseasenova.damage_max = {
	50,
	100,
	150
}
tt.hero.skills.unstabledisease = E.clone_c(E, "hero_skill")
tt.hero.skills.unstabledisease.spread_damage = {
	20,
	35,
	50
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
tt.health.armor = nil
tt.health.dead_lifetime = 30
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 157)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.draw_order = -1
tt.health_bar.sort_y_offset = -200
tt.hero.fn_level_up = scripts.hero_dracolich.level_up
tt.hero.tombstone_show_time = nil
tt.idle_flip.cooldown = 10
tt.info.fn = scripts.hero_dracolich.get_info
tt.info.hero_portrait = "hero_portraits_0016"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0019") or "info_portraits_heroes_0017"
tt.info.damage_icon = "magic"
tt.main_script.insert = scripts.hero_dracolich.insert
tt.main_script.update = scripts.hero_dracolich.update
tt.motion.max_speed = 90
tt.nav_rally.requires_node_nearby = false
tt.nav_grid.ignore_waypoints = true
tt.nav_grid.valid_terrains = TERRAIN_ALL_MASK
tt.nav_grid.valid_terrains_dest = TERRAIN_ALL_MASK
tt.regen.cooldown = 1
tt.regen.health = nil
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
tt.ranged.attacks[1].cooldown = 1.8
tt.ranged.attacks[1].min_range = 0
tt.ranged.attacks[1].max_range = 200
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
tt.timed_attacks.list[2].cooldown = 18
tt.timed_attacks.list[2].disabled = true
tt.timed_attacks.list[2].entity = "dracolich_spine"
tt.timed_attacks.list[2].spawn_time = fts(11)
tt.timed_attacks.list[2].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[2].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[2].min_range = 0
tt.timed_attacks.list[2].max_range = 125
tt.timed_attacks.list[3] = E.clone_c(E, "area_attack")
tt.timed_attacks.list[3].animation = "nova"
tt.timed_attacks.list[3].cooldown = 25
tt.timed_attacks.list[3].disabled = true
tt.timed_attacks.list[3].damage_max = nil
tt.timed_attacks.list[3].damage_min = nil
tt.timed_attacks.list[3].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[3].hit_time = fts(20)
tt.timed_attacks.list[3].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[3].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[3].min_range = 0
tt.timed_attacks.list[3].max_range = 50
tt.timed_attacks.list[3].min_count = 1
tt.timed_attacks.list[3].sound = "HeroDracolichKamikaze"
tt.timed_attacks.list[3].respawn_delay = 1
tt.timed_attacks.list[3].respawn_sound = "HeroDracolichRespawn"
tt.timed_attacks.list[3].mod = "mod_dracolich_disease"
tt.timed_attacks.list[4] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[4].animation = "plague"
tt.timed_attacks.list[4].cooldown = 18
tt.timed_attacks.list[4].disabled = true
tt.timed_attacks.list[4].entity = "dracolich_plague_carrier"
tt.timed_attacks.list[4].spawn_offset = v(43, 81)
tt.timed_attacks.list[4].spawn_time = fts(11)
tt.timed_attacks.list[4].vis_flags = bor(F_RANGED)
tt.timed_attacks.list[4].vis_bans = bor(F_FLYING)
tt.timed_attacks.list[4].range_nodes_max = 50
tt.timed_attacks.list[4].range_nodes_min = 10
tt.timed_attacks.list[4].sound = "HeroDracolichSoulsPlague"
tt.timed_attacks.list[4].count = nil
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
tt.main_script.update = scripts.fireball_dragon.update
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
tt.dps.damage_min = nil
tt.dps.damage_max = nil
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = 1
tt.dps.kill = true
tt.spread_active = false
tt.spread_radius = 60
tt.spread_damage = nil
tt.spread_fx = "fx_dracolich_disease_explosion"
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
tt.main_script.remove = scripts.mod_dracolich_disease.remove
tt = E.register_t(E, "fx_dracolich_disease_explosion", "fx")
tt.render.sprites[1].name = "dracolich_disease_explosion"
tt = E.register_t(E, "fx_dracolich_skeleton_glow", "fx")
tt.render.sprites[1].name = "fx_dracolich_skeleton_glow"
tt = E.register_t(E, "dracolich_spine", "bullet")

E.add_comps(E, tt, "tween")

tt.main_script.update = scripts.dracolich_spine.update
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.bullet.damage_radius = 50
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_bans = F_FRIEND
tt.bullet.mod = nil
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
tt = E.register_t(E, "dracolich_plague_carrier", "aura")

E.add_comps(E, tt, "render", "nav_path", "motion", "tween")

tt.aura.duration = nil
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
tt.main_script.insert = scripts.dracolich_plague_carrier.insert
tt.main_script.update = scripts.dracolich_plague_carrier.update
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
tt = E.register_t(E, "soldier_dracolich_golem", "soldier")

E.add_comps(E, tt, "melee", "nav_grid", "reinforcement")

image_y = 48
anchor_y = 0.16666666666666666
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0021") or "info_portraits_heroes_0022"
tt.health.armor = 0
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 36)
tt.info.fn = scripts.soldier_reinforcement.get_info
tt.reinforcement.duration = nil
tt.reinforcement.fade = false
tt.main_script.insert = scripts.soldier_reinforcement.insert
tt.main_script.update = scripts.soldier_reinforcement.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = nil
tt.melee.attacks[1].damage_min = nil
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
tt.health.armor = nil
tt.health.dead_lifetime = 15
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 39)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_van_helsing.level_up
tt.hero.tombstone_show_time = fts(60)
tt.idle_flip.cooldown = 10
tt.info.fn = scripts.hero_van_helsing.get_info
tt.info.hero_portrait = "hero_portraits_0014"
tt.info.hero_portrait_alive = "hero_portraits_0014"
tt.info.hero_portrait_dead = "hero_portraits_0015"
tt.info.hero_portrait_always_on = nil
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0017") or "info_portraits_heroes_0016"
tt.info.portrait_alive = (IS_PHONE_OR_TABLET and "portraits_hero_0017") or "info_portraits_heroes_0016"
tt.info.portrait_dead = (IS_PHONE_OR_TABLET and "portraits_hero_0018") or "info_portraits_heroes_0023"
tt.main_script.insert = scripts.hero_van_helsing.insert
tt.main_script.update = scripts.hero_van_helsing.update
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
tt.melee.attacks[2].fn_can = scripts.hero_van_helsing.can_relic
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
tt.timed_attacks.list[1].loops = nil
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
tt.timed_attacks.list[2].werewolf_damage_factor = 3
tt.timed_attacks.list[2].filter_damage_factor = 3
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
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
tt.sound_events.insert = "SniperSound"
tt.bullet.xp_gain_factor = nil
tt = E.register_t(E, "mod_van_helsing_crosshair", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].name = "vanhelsing_crosshair"
tt.render.sprites[1].sort_y_offset = -2
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = fts(16)
tt = E.register_t(E, "van_helsing_grenade", "bullet")
tt.bullet.damage_radius = 80
tt.bullet.flight_time = fts(25)
tt.bullet.hide_radius = 4
tt.bullet.hit_fx = "van_helsing_grenade_explosion"
tt.bullet.mod = "mod_van_helsing_silence"
tt.bullet.rotation_speed = (FPS*20*math.pi)/180
tt.main_script.insert = scripts.bomb.insert
tt.main_script.update = scripts.van_helsing_grenade.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "Halloween_hero_vhelsing_water"
tt = E.register_t(E, "mod_van_helsing_silence", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = nil
tt.modifier.bans = {
	"mod_shaman_armor",
	"mod_shaman_magic_armor",
	"mod_shaman_priest_heal"
}
tt.modifier.remove_banned = true
tt.main_script.insert = scripts.mod_silence.insert
tt.main_script.remove = scripts.mod_silence.remove
tt.main_script.update = scripts.mod_track_target.update
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
tt.main_script.update = scripts.mod_van_helsing_relic.update
tt.armor_reduce_factor = nil
tt.remove_mods = {
	"mod_shaman_magic_armor",
	"mod_shaman_armor"
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
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt = E.register_t(E, "mod_van_helsing_beacon", "modifier")

E.add_comps(E, tt, "render")

tt.inflicted_damage_factor = nil
tt.main_script.insert = scripts.mod_van_helsing_beacon.insert
tt.main_script.remove = scripts.mod_van_helsing_beacon.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = 1
tt.modifier.use_mod_offset = false
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "Halloween_hero_vhelsing_buffeffect"
tt.render.sprites[1].z = Z_DECALS
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
tt.health.armor = nil
tt.health.dead_lifetime = 15
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 39)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_voodoo_witch.level_up
tt.hero.tombstone_show_time = fts(90)
tt.idle_flip.cooldown = 2
tt.info.damage_icon = "magic"
tt.info.fn = scripts.hero_voodoo_witch.get_info
tt.info.hero_portrait = "hero_portraits_0019"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0023") or "info_portraits_heroes_0019"
tt.main_script.insert = scripts.hero_voodoo_witch.insert
tt.main_script.update = scripts.hero_voodoo_witch.update
tt.motion.max_speed = 72
tt.regen.cooldown = 1
tt.regen.health = nil
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
tt.timed_attacks.list[1].damage = nil
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = bor(F_BOSS)
tt = E.register_t(E, "voodoo_witch_skull_aura", "aura")
tt.aura.cycle_time = 0.26666666666666666
tt.aura.duration = -1
tt.aura.radius = 140
tt.aura.vis_bans = bor(F_BOSS, F_FRIEND)
tt.aura.vis_flags = F_MOD
tt.main_script.update = scripts.voodoo_witch_skull_aura.update
tt.skull_count = 2
tt.skulls = {}
tt.rot_speed = (math.pi*2)/8
tt.rot_radius = 40
tt = E.register_t(E, "mod_voodoo_witch_skull_spawn", "modifier")
tt.modifier.duration = fts(10)
tt.main_script.update = scripts.mod_voodoo_witch_skull_spawn.update
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
tt.main_script.update = scripts.voodoo_witch_skull.update
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
tt.main_script.update = scripts.voodoo_witch_death_aura.update
tt.render.sprites[1].name = "decal_voodoo_witch_death_aura"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "voodoo_buff_top"
tt.render.sprites[2].anchor.y = 0.22727272727272727
tt = E.register_t(E, "mod_voodoo_witch_aura_slow", "mod_slow")

E.add_comps(E, tt, "render", "tween")

tt.slow.factor = nil
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
tt.bullet.damage_max = nil
tt.bullet.damage_min = nil
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
tt.main_script.insert = scripts.mod_voodoo_witch_magic.insert
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "mod_voodoo_witch_magic"
tt.render.sprites[1].loop = false
tt = E.register_t(E, "mod_voodoo_witch_magic_slow", "mod_slow")
tt.slow.factor = 0.3
tt.modifier.duration = 0.4
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
tt.hero.fn_level_up = scripts.hero_minotaur.level_up
tt.hero.tombstone_show_time = fts(90)
tt.idle_flip.cooldown = 10
tt.info.fn = scripts.hero_minotaur.get_info
tt.info.hero_portrait = "hero_portraits_0018"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0022") or "info_portraits_heroes_0018"
tt.main_script.insert = scripts.hero_minotaur.insert
tt.main_script.update = scripts.hero_minotaur.update
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
	"tower_barrack_mercenary"
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
tt.main_script.queue = scripts.mod_minotaur_daedalus.queue
tt.main_script.update = scripts.mod_minotaur_daedalus.update
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
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "fx_minotaur_dust"
tt.render.sprites[1].loop = true
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
tt.modifier.duration = 0.7
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
tt.main_script.queue = scripts1.mod_thorn.queue
tt.main_script.dequeue = scripts1.mod_thorn.dequeue
tt.main_script.insert = scripts1.mod_thorn.insert
tt.main_script.update = scripts1.mod_thorn.update
tt.main_script.remove = scripts1.mod_thorn.remove
tt = RT("arrow_ranger", "arrow")
tt.bullet.damage_min = 13
tt.bullet.damage_max = 19
tt = RT("tower_ranger", "tower_archer_1")

AC(tt, "attacks", "powers")

image_y = 90
tt.tower.type = "ranger"
tt.tower.level = 1
tt.tower.price = 230
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 13
tt.info.i18n_key = "TOWER_RANGERS"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0010") or "info_portraits_towers_0124"
tt.powers.poison = CC("power")
tt.powers.poison.price_base = 250
tt.powers.poison.price_inc = 250
tt.powers.poison.mod = "mod_ranger_poison"
tt.powers.poison.enc_icon = 8
tt.powers.thorn = CC("power")
tt.powers.thorn.price_base = 300
tt.powers.thorn.price_inc = 150
tt.powers.thorn.aura = "aura_ranger_thorn"
tt.powers.thorn.enc_icon = 9
tt.powers.thorn.name = "thorns"
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_archer_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "archer_tower_0044"
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
tt.main_script.update = ranger.tower_ranger.update
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
tt = RT("ray_tesla", "bullet")
tt.bullet.hit_time = fts(1)
tt.bullet.mod = "mod_ray_tesla"
tt.bounces = nil
tt.bounces_lvl = {
  [0] = 2,
  3,
  4
}
tt.bounce_range = 95
tt.bounce_vis_flags = F_RANGED
tt.bounce_vis_bans = 0
tt.bounce_damage_min = 60
tt.bounce_damage_max = 110
tt.bounce_damage_factor = 0.5
tt.bounce_damage_factor_min = 0.5
tt.bounce_damage_factor_inc = 0
tt.bounce_delay = fts(2)
tt.bounce_scale_y = 1
tt.bounce_scale_y_factor = 0.88
tt.excluded_templates = {
  "enemy_bloodshell",
  "enemy_phantom_warrior",
  "enemy_ghost"
}
tt.image_width = 106
tt.seen_targets = {}
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].name = "ray_tesla"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BULLETS
tt.main_script.update = scripts1.ray_tesla.update
tt = RT("aura_tesla_overcharge", "aura")
tt.aura.duration = fts(22)
tt.aura.mod = "mod_tesla_overcharge"
tt.aura.radius = 165
tt.aura.damage_min = 0
tt.aura.damage_max = 10
tt.aura.damage_inc = 10
tt.aura.damage_type = DAMAGE_ELECTRICAL
tt.aura.excluded_templates = {
  "enemy_bloodshell",
  "enemy_phantom_warrior",
  "enemy_ghost"
}
tt.main_script.update = scripts1.aura_tesla_overcharge.update
tt.particles_name = "ps_tesla_overcharge"
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
tt.main_script.insert = scripts1.mod_track_target.insert
tt.main_script.update = scripts1.mod_track_target.update
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
tt.main_script.insert = scripts1.mod_dps.insert
tt.main_script.update = scripts1.mod_dps.update
tt = RT("tower_bfg", "tower")

AC(tt, "attacks", "powers")

image_y = 120
tt.tower.type = "bfg"
tt.tower.level = 1
tt.tower.price = 400
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 16
tt.info.i18n_key = "TOWER_BFG"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0012") or "info_portraits_towers_0002"
tt.powers.missile = CC("power")
tt.powers.missile.price_base = 250
tt.powers.missile.price_inc = 100
tt.powers.missile.range_inc_factor = 0.2
tt.powers.missile.damage_inc = 40
tt.powers.missile.enc_icon = 17
tt.powers.cluster = CC("power")
tt.powers.cluster.price_base = 250
tt.powers.cluster.price_inc = 150
tt.powers.cluster.fragment_count_base = 1
tt.powers.cluster.fragment_count_inc = 2
tt.powers.cluster.enc_icon = 18
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_bfg_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_bfg"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 51)
tt.main_script.update = scripts1.tower_bfg.update
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
tt.attacks.list[2].bullet = "missile_mecha"
tt.attacks.list[2].bullet_start_offset = v(-24, 64)
tt.attacks.list[2].cooldown = 14.1
tt.attacks.list[2].cooldown_mixed = 14.1
tt.attacks.list[2].cooldown_flying = 6.5
tt.attacks.list[2].launch_vector = v(12, 110)
tt.attacks.list[2].range_base = 180
tt.attacks.list[2].range = nil
tt.attacks.list[2].shoot_time = fts(14)
tt.attacks.list[2].vis_flags = bor(F_MOD, F_RANGED)
tt.attacks.list[3] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[3].bullet = "bomb_bfg_cluster"
tt.attacks.list[3].cooldown = 17
tt.attacks.list[3].node_prediction = fts(44)
tt = RT("bomb_bfg", "bomb")
tt.bullet.damage_max = 100
tt.bullet.damage_min = 50
tt.bullet.damage_radius = 67.5
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
tt.bullet.fragment_node_spread = 7
tt.bullet.fragment_pos_spread = v(6, 6)
tt.bullet.dest_pos_offset = v(0, 85)
tt.bullet.dest_prediction_time = 1
tt.main_script.insert = scripts1.bomb_cluster.insert
tt.main_script.update = scripts1.bomb_cluster.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "bombs_0005"
tt.sound_events.hit = "BombExplosionSound"
tt.sound_events.insert = "BombShootSound"
tt = RT("bomb_bfg_fragment", "bomb")
tt.bullet.damage_max = 80
tt.bullet.damage_min = 60
tt.bullet.damage_radius = 52.5
tt.bullet.flight_time = fts(10)
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = "fx_explosion_fragment"
tt.bullet.pop = nil
tt.render.sprites[1].name = "bombs_0006"
tt.sound_events.hit_water = nil
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
tt.bullet.damage_min = 140
tt.bullet.damage_max = 180
tt.bullet.damage_radius = 41.25
tt.bullet.vis_flags = F_RANGED
tt.bullet.damage_flags = F_AREA
tt.bullet.particles_name = "ps_missile"
tt.bullet.retarget_range = 1e+99
tt.main_script.insert = scripts1.missile.insert
tt.main_script.update = scripts1.missile.update
tt.sound_events.insert = "RocketLaunchSound"
tt.sound_events.hit = "BombExplosionSound"
tt = RT("tower_bfg_full", "tower_bfg")
tt.powers.cluster.level = 3
tt.powers.missile.level = 3
tt = RT("tower_tesla", "tower")

AC(tt, "attacks", "powers")

image_y = 96
tt.tower.type = "tesla"
tt.tower.level = 1
tt.tower.price = 375
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 20
tt.info.fn = scripts1.tower_tesla.get_info
tt.info.i18n_key = "TOWER_TESLA"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0011") or "info_portraits_towers_1666"
tt.powers.bolt = CC("power")
tt.powers.bolt.price_base = 250
tt.powers.bolt.price_inc = 250
tt.powers.bolt.max_level = 2
tt.powers.bolt.jumps_base = 3
tt.powers.bolt.jumps_inc = 1
tt.powers.bolt.enc_icon = 11
tt.powers.bolt.name = "CHARGED_BOLT"
tt.powers.overcharge = CC("power")
tt.powers.overcharge.price_base = 250
tt.powers.overcharge.price_inc = 125
tt.powers.overcharge.enc_icon = 10
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "terrain_artillery_tesla_%04i"
tt.render.sprites[1].offset = v(0, 15)
tt.render.sprites[2] = CC("sprite")
tt.render.sprites[2].prefix = "tower_tesla"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].offset = v(0, 40)
tt.main_script.update = scripts1.tower_tesla.update
tt.sound_events.insert = "EngineerTeslaTaunt"
tt.attacks.min_cooldown = 2.2
tt.attacks.range = 165
tt.attacks.range_check_factor = 1.2
tt.attacks.list[1] = CC("bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "ray_tesla"
tt.attacks.list[1].bullet_start_offset = v(7, 79)
tt.attacks.list[1].cooldown = 2.2
tt.attacks.list[1].node_prediction = fts(18)
tt.attacks.list[1].range = 165
tt.attacks.list[1].shoot_time = fts(48)
tt.attacks.list[1].sound_shoot = "TeslaAttack"
tt.attacks.list[2] = CC("aura_attack")
tt.attacks.list[2].aura = "aura_tesla_overcharge"
tt.attacks.list[2].bullet_start_offset = v(0, 15)
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
tt = RT("ray_sorcerer_polymorph", "bullet")
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_time = fts(3)
tt.bullet.mod = "mod_polymorph_sorcerer"
tt.image_width = 130
tt.main_script.update = scripts1.ray_simple.update
tt.ray_duration = fts(10)
tt.render.sprites[1].anchor = v(0, 0.5)
tt.render.sprites[1].loop = false
tt.render.sprites[1].name = "ray_sorcerer_polymorph"
tt.sound_events.insert = "PolymorphSound"
tt.track_target = true
tt = RT("mod_polymorph_sorcerer", "mod_polymorph")
tt.modifier.use_mod_offset = true
tt.modifier.remove_banned = true
tt.modifier.ban_types = {
  MOD_TYPE_FAST
}
tt.polymorph.custom_entity_names.default = "enemy_sheep_ground"
tt.polymorph.custom_entity_names.enemy_razorwing = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_quetzal = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_bat = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_savage_bird_rider = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_savage_bird = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_wasp = "enemy_sheep_fly"
tt.polymorph.custom_entity_names.enemy_wasp_queen = "enemy_sheep_fly"
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
tt = RT("mod_sorcerer_curse_armor", "modifier")

AC(tt, "armor_buff")

tt.modifier.duration = 5
tt.modifier.vis_flags = F_MOD
tt.armor_buff.magic = false
tt.armor_buff.factor = -0.5
tt.armor_buff.cycle_time = 1e+99
tt.main_script.insert = scripts1.mod_armor_buff.insert
tt.main_script.remove = scripts1.mod_armor_buff.remove
tt.main_script.update = scripts1.mod_armor_buff.update
tt = RT("mod_sorcerer_curse_dps", "modifier")

AC(tt, "render", "dps")

tt.modifier.duration = 4.9
tt.modifier.vis_flags = F_MOD
tt.dps.damage_min = 10
tt.dps.damage_max = 10
tt.dps.damage_every = 1.25
tt.dps.damage_type = DAMAGE_TRUE
tt.main_script.insert = scripts1.mod_dps.insert
tt.main_script.update = scripts1.mod_dps.update
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0017") or "info_portraits_sc_0117"
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
tt.vis.flags = bor(tt.vis.flags, F_HERO)
tt.vis.bans = bor(F_LYCAN, F_STUN, F_NET)
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
tt = RT("fx_bolt_sorcerer_hit", "fx")
tt.render.sprites[1].prefix = "bolt_sorcerer"
tt.render.sprites[1].name = "hit"
tt = RT("fx_mod_polymorph_sorcerer_small", "fx")
tt.render.sprites[1].name = "fx_mod_polymorph_sorcerer_small"
tt.render.sprites[1].anchor.y = 0.5
tt = RT("fx_mod_polymorph_sorcerer_big", "fx_mod_polymorph_sorcerer_small")
tt.render.sprites[1].name = "fx_mod_polymorph_sorcerer_big"
tt = RT("enemy_sheep_ground", "enemy")

E.add_comps(E, tt, "auras")

anchor_y = 0.2
image_y = 38
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "water_death"
tt.enemy.gold = 0
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 80
tt.health_bar.offset = v(0, ady(32))
tt.info.i18n_key = "ENEMY_SHEEP"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0013") or "info_portraits_sc_0013"
tt.info.enc_icon = nil
tt.main_script.insert = scripts1.enemy_basic.insert
tt.main_script.update = scripts1.enemy_sheep.update
tt.motion.max_speed = FPS*1.5
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_sheep_ground"
tt.sound_events.insert = "Sheep"
tt.sound_events.death = "DeathEplosion"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 10)
tt.unit.mod_offset = v(0, ady(15))
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT, F_POLYMORPH)
tt.vis.flags = bor(F_ENEMY)
tt.clicks_to_destroy = 8
tt = RT("enemy_sheep_fly", "enemy_sheep_ground")

E.add_comps(E, tt, "auras")

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
tt = RT("tower_sorcerer", "tower_mage_1")

AC(tt, "attacks", "powers", "barrack")

image_y = 90
tt.tower.type = "sorcerer"
tt.tower.level = 1
tt.tower.price = 300
tt.tower.size = TOWER_SIZE_LARGE
tt.tower.menu_offset = v(0, 14)
tt.info.enc_icon = 19
tt.info.i18n_key = "TOWER_SORCERER"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0006") or "info_portraits_towers_1112"
tt.barrack.soldier_type = "soldier_elemental"
tt.barrack.rally_range = 180
tt.powers.polymorph = CC("power")
tt.powers.polymorph.price_base = 300
tt.powers.polymorph.price_inc = 150
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
tt.render.sprites[3].anchor_y = 0.35
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
tt.render.sprites[3].offset = v(1, 62)
tt.render.sprites[4] = CC("sprite")
tt.render.sprites[4].name = "fx_tower_sorcerer_polymorph"
tt.render.sprites[4].loop = false
tt.render.sprites[4].ts = -10
tt.render.sprites[4].offset = v(0, 72)
tt.render.sprites[4].hidden = true
tt.render.sprites[4].hide_after_runs = 1
tt.main_script.insert = scripts1.tower_barrack.insert
tt.main_script.update = scripts1.tower_sorcerer.update
tt.main_script.remove = scripts1.tower_barrack.remove
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
tt = E.register_t(E, "shotgun_musketeer", "shotgun")
tt.bullet.damage_max = 65
tt.bullet.damage_min = 35
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt.bullet.start_fx = "fx_rifle_smoke"
tt.bullet.min_speed = FPS*20
tt.bullet.max_speed = FPS*20
tt.sound_events.insert = "ShotgunSound"
tt = E.register_t(E, "shotgun_musketeer_sniper", "shotgun_musketeer")
tt.bullet.particles_name = "ps_shotgun_musketeer"
tt.sound_events.insert = "SniperSound"
tt.bullet.damage_type = bor(DAMAGE_PHYSICAL, DAMAGE_FX_EXPLODE)
tt.bullet.pop = nil
tt.bullet.ignore_upgrades = true
tt = E.register_t(E, "shotgun_musketeer_sniper_instakill", "shotgun_musketeer_sniper")
tt.bullet.damage_type = bor(DAMAGE_INSTAKILL, DAMAGE_FX_EXPLODE)
tt.bullet.pop = {
  "pop_headshot"
}
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
tt = RT("fx_explosion_shrapnel", "fx")
tt.render.sprites[1].anchor.y = 0.2
tt.render.sprites[1].sort_y_offset = -2
tt.render.sprites[1].prefix = "explosion"
tt.render.sprites[1].name = "shrapnel"
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
tt = E.register_t(E, "tower_musketeer", "tower_archer_1")

E.add_comps(E, tt, "attacks", "powers")

image_y = 90
tt.tower.type = "musketeer"
tt.tower.level = 1
tt.tower.price = 230
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 17
tt.info.i18n_key = "TOWER_MUSKETEERS"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0009") or "info_portraits_towers_1145"
tt.powers.sniper = E.clone_c(E, "power")
tt.powers.sniper.attack_idx = 2
tt.powers.sniper.price_base = 250
tt.powers.sniper.price_inc = 250
tt.powers.sniper.damage_factor_inc = 0.2
tt.powers.sniper.instakill_chance_inc = 0.2
tt.powers.sniper.enc_icon = 14
tt.powers.shrapnel = E.clone_c(E, "power")
tt.powers.shrapnel.attack_idx = 3
tt.powers.shrapnel.price_base = 300
tt.powers.shrapnel.price_inc = 300
tt.powers.shrapnel.enc_icon = 15
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
tt.main_script.update = ranger.tower_musketeer.update
tt.main_script.insert = scripts1.tower_archer.insert
tt.main_script.remove = scripts1.tower_archer.remove
tt.sound_events.insert = "ArcherMusketeerTaunt"
tt.attacks.range = 235
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "shoot"
tt.attacks.list[1].bullet = "shotgun_musketeer"
tt.attacks.list[1].cooldown = 1.5
tt.attacks.list[1].shoot_time = fts(6)
tt.attacks.list[1].shooters_delay = 0.1
tt.attacks.list[1].bullet_start_offset = {
  v(6, 8),
  v(4, -5)
}
tt.attacks.list[2] = E.clone_c(E, "bullet_attack")
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
tt.attacks.list[4] = E.clone_c(E, "bullet_attack")
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
tt = E.register_t(E, "pop_arcane", "pop")
tt.render.sprites[1].name = "elven_pops_0009"
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
tt = E.register_t(E, "fx_arrow_arcane_hit", "fx")
tt.render.sprites[1].name = "fx_arrow_arcane_hit"
tt = E.register_t(E, "fx_arcane_slumber_explosion", "fx")
tt.render.sprites[1].name = "arcane_slumber_explosion"
tt.render.sprites[1].anchor.y = 0.32051282051282054
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
tt = E.register_t(E, "mod_arrow_arcane", "mod_damage")
tt.damage_min = 0.03
tt.damage_max = 0.03
tt.damage_type = DAMAGE_MAGICAL_ARMOR
tt = E.register_t(E, "arrow_arcane", "arrow_1")
tt.bullet.flight_time_min = fts(11)
tt.bullet.flight_time_factor = fts(5)*2
tt.bullet.miss_decal = "archer_silver_proys_0002-f"
tt.bullet.damage_max = 18
tt.bullet.damage_min = 11
tt.bullet.hit_fx = "fx_arrow_arcane_hit"
tt.bullet.mod = {
	"mod_arrow_arcane"
}

tt.bullet.pop_conds = DR_KILL
tt.render.sprites[1].name = "archer_silver_proys_0001-f"
tt.sound_events.insert = "TowerGoldenBowArrowShot"
tt.bullet.miss_decal = "archer_silver_proys_0002-f"
tt.bullet.damage_max = 20
tt.bullet.damage_min = 15
tt.bullet.pop = {
	"pop_golden"
}
tt.bullet.pop_conds = DR_KILL
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
tt = RT("mod_arcane_shatter", "mod_damage")
tt.damage_min = 0.03
tt.damage_max = 0.03
tt.damage_type = bor(DAMAGE_ARMOR, DAMAGE_NO_SHIELD_HIT)
tt = E.register_t(E, "tower_arcane", "tower")

E.add_comps(E, tt, "attacks", "powers")

image_y = 90
tt.tower.type = "arcane"
tt.tower.level = 1
tt.tower.price = 230
tt.tower.size = TOWER_SIZE_LARGE
tt.info.enc_icon = 17
tt.info.fn = scripts2.tower_arcane.get_info
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_2478"
tt.powers.burst = E.clone_c(E, "power")
tt.powers.burst.price_base = 200
tt.powers.burst.price_inc = 200
tt.powers.burst.attack_idx = 2
tt.powers.burst.enc_icon = 2
tt.powers.slumber = E.clone_c(E, "power")
tt.powers.slumber.price_base = 180
tt.powers.slumber.price_inc = 180
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
tt = E.register_t(E, "fx_arrow_silver_mark_hit", "fx")
tt.render.sprites[1].name = "fx_arrow_silver_mark_hit"
tt.render.sprites[1].sort_y_offset = -20
tt = E.register_t(E, "fx_arrow_silver_sentence_hit", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].name = "fx_arrow_silver_sentence_hit"
tt.sound_events.insert = "TowerGoldenBowInstakill"
tt = E.register_t(E, "fx_arrow_silver_sentence_shot", "fx")
tt.render.sprites[1].name = "fx_arrow_silver_sentence_shot"
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
	0.01,
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
tt.attacks.list[3].cooldown = 12
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
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_1239"
tt.info.fn = scripts2.tower_silver.get_info
tt.powers.sentence = E.clone_c(E, "power")
tt.powers.sentence.attack_idx = 2
tt.powers.sentence.price_base = 300
tt.powers.sentence.price_inc = 300
tt.powers.sentence.chances = {
	{
		0.015,
		0.03,
		0.045
	},
	{
		0.03,
		0.06,
		0.09
	}
}
tt.powers.sentence.enc_icon = 3
tt.powers.mark = E.clone_c(E, "power")
tt.powers.mark.attack_idx = 3
tt.powers.mark.price_base = 225
tt.powers.mark.price_inc = 225
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
tt = E.register_t(E, "arrow_silver", "arrow_1")
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
tt = E.register_t(E, "mod_arrow_silver_mark", "modifier")

E.add_comps(E, tt, "tween", "render", "sound_events", "count_group")

tt.count_group.name = "mod_arrow_silver_mark"
tt.count_group.type = COUNT_GROUP_CONCURRENT
tt.received_damage_factor = 2
tt.main_script.insert = scripts2.mod_arrow_silver_mark.insert
tt.main_script.update = scripts2.mod_arrow_silver_mark.update
tt.main_script.remove = scripts2.mod_arrow_silver_mark.remove
tt.modifier.durations = {
	5,
	10,
	15
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
tt = E.register_t(E, "pop_golden", "pop")
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
tt = E.register_t(E, "mod_forest_circle", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.render.sprites[1].name = "decal_mod_forest_circle"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "forestKeeper_soldierBuff"
tt.render.sprites[2].animated = false
tt.render.sprites[2].sort_y_offset = -1
tt.render.sprites[2].anchor.y = 0.21428571428571427
tt.modifier.duration = 4
tt.modifier.use_mod_offset = false
tt.modifier.bans = {
	"mod_greenfin_net",
	"mod_dart_poison",
	"mod_dracula_lifesteal"
}
tt.modifier.remove_banned = true
tt.hps.heal_min = 0
tt.hps.heal_max = 0
tt.hps.heal_inc = 4
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
tt.render.sprites[1].name = "elven_pops_0015"
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
tt.motion.max_speed = 90
tt.powers.dual = E.clone_c(E, "power")
tt.powers.dual.on_power_upgrade = scripts2.soldier_barbarian.on_power_upgrade
tt.powers.twister = E.clone_c(E, "power")
tt.powers.throwing = E.clone_c(E, "power")
tt.regen.health = 20
tt.render.sprites[1].prefix = "soldier_barbarian"
tt.render.sprites[1].anchor.y = anchor_y
tt.soldier.melee_slot_offset = v(5, 0)
tt.melee.cooldown = fts(11) + 1
tt.melee.range = 60
tt.melee.attacks[1].damage_inc = 10
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].power_name = "dual"
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "twister"
tt.melee.attacks[2].chance = 0.01
tt.melee.attacks[2].chance_inc = 0.1
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
tt.info.fn = scripts2.soldier_mercenary.get_info
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
tt = E.register_t(E, "tower_blade", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.enc_icon = 18
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_2222"
tt.barrack.soldier_type = "soldier_blade"
tt.powers.perfect_parry = E.clone_c(E, "power")
tt.powers.perfect_parry.price_base = 175
tt.powers.perfect_parry.price_inc = 175
tt.powers.perfect_parry.enc_icon = 116
tt.powers.blade_dance = E.clone_c(E, "power")
tt.powers.blade_dance.price_base = 250
tt.powers.blade_dance.price_inc = 250
tt.powers.blade_dance.enc_icon = 115
tt.powers.swirling = E.clone_c(E, "power")
tt.powers.swirling.price_base = 200
tt.powers.swirling.price_inc = 150
tt.powers.swirling.max_level = 2
tt.powers.swirling.enc_icon = 117
tt.powers.swirling.name = "SWIRLING_EDGE"
tt.render.sprites[2].name = "barracks_towers_layer1_0076"
tt.render.sprites[3].prefix = "tower_blade_door"
tt.sound_events.change_rally_point = "ElvesBarrackBladesingerTaunt"
tt.sound_events.insert = "ElvesBarrackBladesingerTaunt"
tt.tower.price = 275
tt.tower.type = "blade"
tt = E.register_t(E, "soldier_forest", "soldier_militia")

E.add_comps(E, tt, "powers", "timed_attacks", "ranged")

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
tt = RT("decal_paladin_holystrike", "decal_timed")
tt.render.sprites[1].name = "decal_paladin_holystrike"
tt.render.sprites[1].z = Z_DECALS
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
tt = RT("tower_paladin", "tower_barrack_1")

AC(tt, "powers")

tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0007") or "info_portraits_towers_0199"
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0004") or "info_portraits_sc_0199"
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
tt.melee.attacks[3].damage_type = DAMAGE_PHYSICAL
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
tt = E.register_t(E, "tower_forest", "tower_barrack_1")

E.add_comps(E, tt, "powers")

tt.info.enc_icon = 19
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_1234"
tt.info.i18n_key = "TOWER_FOREST_KEEPERS"
tt.barrack.max_soldiers = 2
tt.barrack.soldier_type = "soldier_forest"
tt.barrack.rally_angle_offset = math.pi/3
tt.powers.circle = E.clone_c(E, "power")
tt.powers.circle.price_base = 185
tt.powers.circle.price_inc = 185
tt.powers.circle.enc_icon = 9
tt.powers.eerie = E.clone_c(E, "power")
tt.powers.eerie.price_base = 285
tt.powers.eerie.price_inc = 285
tt.powers.eerie.max_level = 2
tt.powers.eerie.enc_icon = 10
tt.powers.oak = E.clone_c(E, "power")
tt.powers.oak.price_base = 250
tt.powers.oak.price_inc = 250
tt.powers.oak.enc_icon = 11
tt.render.sprites[2].name = "barracks_towers_layer1_0101"
tt.render.sprites[3].prefix = "tower_forest_door"
tt.render.sprites[3].hidden = true
tt.sound_events.change_rally_point = "ElvesBarrackForestKeeperTaunt"
tt.sound_events.insert = "ElvesBarrackForestKeeperTaunt"
tt.tower.price = 300
tt.tower.type = "forest"
tt = E.register_t(E, "soldier_blade", "soldier_militia")

E.add_comps(E, tt, "powers", "dodge", "timed_attacks")

image_y = 42
anchor_y = 0.25
tt.dodge.animation = "dodge"
tt.dodge.chance = 0
tt.dodge.chance_inc = 0.11111
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
tt.melee.attacks[1].damage_inc = 10
tt.melee.attacks[1].cooldown_inc = -0.2
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
tt = E.register_t(E, "pop_bladesinger", "pop")
tt.render.sprites[1].name = "elven_pops_0014"

tt = RT("ray_arcane", "bullet")
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.mod = "mod_ray_arcane"
tt.bullet.hit_time = 0
tt.image_width = 150
tt.main_script.update = scripts1.ray_simple.update
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
tt = RT("mod_ray_arcane_disintegrate", "modifier")

AC(tt, "render")

tt.main_script.update = scripts1.mod_ray_arcane_disintegrate.update
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
tt = RT("mod_ray_arcane", "modifier")

AC(tt, "render", "dps")

tt.dps.damage_min = 76
tt.dps.damage_max = 140
tt.dps.damage_type = bor(DAMAGE_MAGICAL, DAMAGE_ONE_SHIELD_HIT)
tt.dps.damage_every = fts(2)
tt.dps.pop = {
	"pop_zap_arcane"
}
tt.dps.pop_conds = DR_KILL
tt.main_script.update = scripts1.mod_ray_arcane.update
tt.modifier.duration = fts(10)
tt.modifier.allows_duplicates = true
tt.render.sprites[1].name = "mod_ray_arcane"
tt.render.sprites[1].loop = true
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
tt = RT("fx_teleport_arcane", "fx")
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].prefix = "fx_teleport_arcane"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].size_names = {
	"small",
	"big",
	"big"
}
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
tt.main_script.insert = scripts1.aura_apply_mod.insert
tt.main_script.update = scripts1.aura_apply_mod.update
tt.render.sprites[1].name = "aura_teleport_arcane"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].anchor.y = 0.375
tt.sound_events.insert = "TeleporthSound"
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
tt.info.fn = scripts1.tower_arcane_wizard.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0005") or "info_portraits_towers_0119"
tt.powers.disintegrate = CC("power")
tt.powers.disintegrate.price_base = 350
tt.powers.disintegrate.price_inc = 200
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
tt.main_script.update = scripts1.tower_arcane_wizard.update
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
tt.main_script.update = scripts.mod_priest_consecrate.update
tt.modifier.duration = 5
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
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].sprite_id = 1
tt.tween.props[3].loop = true
tt.tween.props[3].name = "scale"
tt.tween.props[3].keys = {
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
tt = E.register_t(E, "hero_monkey_god", "hero")

E.add_comps(E, tt, "melee", "timed_attacks")

image_y = 148
anchor_y = 0.24
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
tt.hero.level_stats.regen_health = {
	22,
	24,
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40
}
tt.hero.level_stats.armor = {
	0.16,
	0.17,
	0.18,
	0.19,
	0.2,
	0.21,
	0.22,
	0.23,
	0.24,
	0.25
}
tt.hero.level_stats.damage_min = {
	13,
	15,
	16,
	18,
	20,
	21,
	23,
	25,
	26,
	28
}
tt.hero.level_stats.damage_max = {
	26,
	28,
	30,
	32,
	34,
	36,
	38,
	40,
	42,
	44
}
tt.hero.skills.spinningpole = E.clone_c(E, "hero_skill")
tt.hero.skills.spinningpole.xp_gain_factor = 7
tt.hero.skills.spinningpole.loops = {
	2,
	3,
	4
}
tt.hero.skills.spinningpole.damage = {
	20,
	25,
	30
}
tt.hero.skills.tetsubostorm = E.clone_c(E, "hero_skill")
tt.hero.skills.tetsubostorm.damage = {
	40,
	65,
	90
}
tt.hero.skills.tetsubostorm.xp_gain_factor = 15
tt.hero.skills.monkeypalm = E.clone_c(E, "hero_skill")
tt.hero.skills.monkeypalm.stun_duration = {
	1,
	2,
	3
}
tt.hero.skills.monkeypalm.silence_duration = {
	5,
	10,
	15
}
tt.hero.skills.monkeypalm.xp_gain_factor = 120
tt.hero.skills.angrygod = E.clone_c(E, "hero_skill")
tt.hero.skills.angrygod.received_damage_factor = {
	1.25,
	1.45,
	1.65
}
tt.hero.skills.angrygod.xp_gain_factor = 15
tt.hero.skills.divinenature = E.clone_c(E, "hero_skill")
tt.hero.skills.divinenature.hp = {
	1,
	1,
	2
}
tt.hero.skills.divinenature.cooldown = {
	fts(10),
	fts(5),
	fts(5)
}
tt.hero.skills.spinningpole.hr_cost = {
	3,
	3,
	3
}
tt.hero.skills.spinningpole.hr_icon = 76
tt.hero.skills.spinningpole.hr_order = 1
tt.hero.skills.tetsubostorm.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.tetsubostorm.hr_icon = 77
tt.hero.skills.tetsubostorm.hr_order = 2
tt.hero.skills.monkeypalm.hr_cost = {
	1,
	1,
	1
}
tt.hero.skills.monkeypalm.hr_icon = 78
tt.hero.skills.monkeypalm.hr_order = 3
tt.hero.skills.angrygod.hr_cost = {
	2,
	2,
	2
}
tt.hero.skills.angrygod.hr_icon = 79
tt.hero.skills.angrygod.hr_order = 4
tt.hero.skills.divinenature.hr_cost = {
	1,
	2,
	3
}
tt.hero.skills.divinenature.hr_icon = 80
tt.hero.skills.divinenature.hr_order = 5
tt.health.armor = nil
tt.health.dead_lifetime = 20
tt.health.hp_max = nil
tt.health_bar.offset = v(0, 47)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hero.fn_level_up = scripts.hero_monkey_god.level_up
tt.hero.tombstone_show_time = fts(30)
tt.idle_flip.cooldown = 2
tt.info.fn = scripts.hero_monkey_god.get_info
tt.info.hero_portrait = "hero_portraits_0020"
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_hero_0024") or "info_portraits_heroes_0024"
tt.main_script.insert = scripts.hero_monkey_god.insert
tt.main_script.update = scripts.hero_monkey_god.update
tt.motion.max_speed = 90
tt.nav_grid.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER, TERRAIN_SHALLOW, TERRAIN_NOWALK)
tt.regen.cooldown = 1
tt.regen.health = nil
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "hero_monkey_god"
tt.render.sprites[1].angles = {
	walk = {
		"running"
	}
}
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "hero_monkeyGod_shadow"
tt.render.sprites[2].hidden = true
tt.render.sprites[2].offset = v(0, ady(74))
tt.soldier.melee_slot_offset = v(20, 0)
tt.sound_events.change_rally_point = "HeroMonkeyGodTaunt"
tt.sound_events.death = "HeroMonkeyGodDeath"
tt.sound_events.respawn = "HeroMonkeyGodTauntIntro"
tt.sound_events.insert = "HeroMonkeyGodTauntIntro"
tt.sound_events.hero_room_select = "HeroMonkeyGodTauntSelect"
tt.sound_events.cloud_start = "HeroMonkeyGodCloudJump"
tt.sound_events.cloud_loop = "HeroMonkeyGodCloudWalkLoop"
tt.sound_events.cloud_end = "HeroMonkeyGodCloudDrop"
tt.sound_events.cloud_end_args = {
	delay = fts(14)
}
tt.unit.hit_offset = v(0, 11)
tt.unit.marker_offset = v(0, -2)
tt.unit.mod_offset = v(0, 14)
tt.cloudwalk = {
	min_distance = 300,
	extra_speed = 90,
	animations = {
		"cloud_start",
		"cloud_loop",
		"cloud_end"
	},
	hit_offset = v(0, 60),
	mod_offset = v(0, 64)
}
tt.melee.attacks[1] = E.clone_c(E, "melee_attack")
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[1].shared_cooldown = true
tt.melee.attacks[1].sound = "HeroMonkeyGodAttack1"
tt.melee.attacks[1].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[1].vis_flags = F_BLOCK
tt.melee.attacks[1].xp_gain_factor = 0.45
tt.melee.attacks[2] = table.deepclone(tt.melee.attacks[1])
tt.melee.attacks[2].animation = "attack2"
tt.melee.attacks[2].chance = 0.5
tt.melee.attacks[2].sound = "HeroMonkeyGodAttack2"
tt.melee.attacks[3] = E.clone_c(E, "area_attack")
tt.melee.attacks[3].animations = {
	"pole_start",
	"pole_loop",
	"pole_end"
}
tt.melee.attacks[3].cooldown = 15
tt.melee.attacks[3].damage_max = nil
tt.melee.attacks[3].damage_min = nil
tt.melee.attacks[3].damage_radius = 90
tt.melee.attacks[3].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[3].disabled = true
tt.melee.attacks[3].fn_can = scripts.hero_monkey_god.can_spinningpole
tt.melee.attacks[3].hit_time = fts(8)
tt.melee.attacks[3].loopable = true
tt.melee.attacks[3].loops = nil
tt.melee.attacks[3].min_count = 2
tt.melee.attacks[3].vis_bans = bor(F_FLYING, F_CLIFF)
tt.melee.attacks[3].vis_flags = F_BLOCK
tt.melee.attacks[3].xp_gain_factor = 3
tt.melee.attacks[3].xp_from_skill = "spinningpole"
tt.melee.attacks[3].sound = "HeroMonkeyGodSpinningPoleLoop"
tt.melee.attacks[3].sound_end = "HeroMonkeyGodSpinningPoleLoopEnd"
tt.melee.attacks[4] = E.clone_c(E, "melee_attack")
tt.melee.attacks[4].animations = {
	"tetsubo_start",
	"tetsubo_loop",
	"tetsubo_end"
}
tt.melee.attacks[4].cooldown = 12
tt.melee.attacks[4].damage_max = nil
tt.melee.attacks[4].damage_min = nil
tt.melee.attacks[4].disabled = true
tt.melee.attacks[4].hit_times = {
	fts(1),
	fts(4),
	fts(9)
}
tt.melee.attacks[4].loopable = true
tt.melee.attacks[4].loops = 1
tt.melee.attacks[4].vis_bans = bor(F_FLYING, F_CLIFF, F_BOSS)
tt.melee.attacks[4].vis_flags = F_BLOCK
tt.melee.attacks[4].xp_gain_factor = 5
tt.melee.attacks[4].xp_from_skill = "tetsubostorm"
tt.melee.attacks[4].sound = "HeroMonkeyGodTetsuboStorm"
tt.melee.attacks[5] = E.clone_c(E, "melee_attack")
tt.melee.attacks[5].animation = "palm"
tt.melee.attacks[5].disabled = true
tt.melee.attacks[5].damage_type = DAMAGE_NONE
tt.melee.attacks[5].mod = "mod_monkey_god_palm"
tt.melee.attacks[5].vis_bans = bor(F_BOSS, F_STUN)
tt.melee.attacks[5].vis_flags = F_BLOCK
tt.melee.attacks[5].xp_from_skill = "monkeypalm"
tt.melee.attacks[5].sound = "HeroMonkeyGodMonkeyPalm"
tt.melee.attacks[5].hit_time = fts(12)
tt.melee.attacks[5].cooldown = 14
tt.melee.range = 65
tt.melee.cooldown = 0.8
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animations = {
	"angry_start",
	"angry_loop",
	"angry_end"
}
tt.timed_attacks.list[1].cooldown = 30
tt.timed_attacks.list[1].disabled = true
tt.timed_attacks.list[1].loops = 2
tt.timed_attacks.list[1].min_count = 2
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].vis_bans = bor(F_BOSS)
tt.timed_attacks.list[1].min_range = 0
tt.timed_attacks.list[1].max_range = 9999
tt.timed_attacks.list[1].mod = "mod_monkey_god_angry"
tt.timed_attacks.list[1].sound_start = "HeroMonkeyGodAngryGodScream"
tt.timed_attacks.list[1].sound_loop = "HeroMonkeyGodAngryGodLoop"
tt = E.register_t(E, "aura_monkey_god_divinenature", "aura_beastmaster_regeneration")
tt = E.register_t(E, "mod_monkey_god_angry", "modifier")

E.add_comps(E, tt, "render")

tt.received_damage_factor = nil
tt.inflicted_damage_factor = 1
tt.modifier.duration = 8
tt.modifier.resets_same = true
tt.main_script.insert = scripts.mod_damage_factors.insert
tt.main_script.remove = scripts.mod_damage_factors.remove
tt.main_script.update = scripts.mod_track_target.update
tt.render.sprites[1].name = "fx_monkey_god_angry"
tt.render.sprites[1].loop = true
tt.render.sprites[1].size_scales = {
	vv(1),
	vv(1.2),
	vv(1.4)
}
tt.render.sprites[1].draw_order = 2
tt.render.sprites[1].anchor.y = 0.46551724137931033
tt = E.register_t(E, "mod_monkey_god_palm", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts.mod_monkey_god_palm.insert
tt.main_script.remove = scripts.mod_monkey_god_palm.remove
tt.main_script.update = scripts.mod_track_target.update
tt.stun_duration = nil
tt.stun_mod = "mod_shock_and_awe"
tt.modifier.duration = nil
tt.modifier.bans = {
	"mod_shaman_armor",
	"mod_shaman_magic_armor",
	"mod_shaman_priest_heal",
	"mod_silence_totem"
}
tt.modifier.remove_banned = true
tt.modifier.use_mod_offset = false
tt.render.sprites[1].name = "fx_monkey_god_palm"
tt.render.sprites[1].loop = true
tt.render.sprites[1].draw_order = 2
tt.custom_offsets = {
	default = v(0, 18),
	enemy_munra = v(0, 18),
	enemy_shaman_priest = v(0, 16),
	enemy_shaman_magic = v(0, 18),
	enemy_shaman_shield = v(0, 16),
	enemy_shaman_necro = v(0, 18),
	enemy_nightscale = v(0, 22),
	enemy_darter = v(0, 16),
	enemy_savant = v(0, 18),
	enemy_bluegale = v(0, 22),
	enemy_blacksurge = v(0, 18),
	enemy_phantom_warrior = v(0, 18)
}
tt = E.register_t(E, "ps_monkey_god_trail")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.alphas = {
	150,
	0
}
tt.particle_system.emission_rate = 20
tt.particle_system.emit_area_spread = v(15, 10)
tt.particle_system.emit_rotation_spread = math.pi
tt.particle_system.names = {
	"hero_monkeyGod_cloudParticle_0001",
	"hero_monkeyGod_cloudParticle_0003"
}
tt.particle_system.particle_lifetime = {
	0.5,
	0.75
}
tt.particle_system.scale_var = {
	0.9,
	1.1
}
tt.particle_system.scales_x = {
	1,
	0.2
}
tt.particle_system.scales_y = {
	1,
	0.2
}
tt.particle_system.sort_y_offset = -45
tt.particle_system.spin = {
	-math.pi/2,
	math.pi/2
}
tt = E.register_t(E, "enemy_bouncer", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.22
image_y = 36
tt.enemy.gold = 5
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = {
	40,
	50,
	60
}
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(38))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0027") or "info_portraits_enemies_0001"
tt.info.enc_icon = 1
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0028") or "info_portraits_enemies_0002"
tt.info.enc_icon = 2
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
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
tt = E.register_t(E, "enemy_desert_wolf_small", "enemy")

E.add_comps(E, tt, "melee", "dodge")

anchor_y = 0.21
image_y = 28
tt.dodge.chance = 0.3
tt.dodge.silent = true
tt.enemy.gold = 5
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = {
	25,
	30,
	35
}
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(32))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0033") or "info_portraits_enemies_0008"
tt.info.enc_icon = 8
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 3
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(14)
tt.melee.attacks[1].sound_hit = "WolfAttack"
tt.motion.max_speed = FPS*3.2
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_wulf"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 11)
tt.unit.marker_offset = v(0, ady(5))
tt.unit.mod_offset = v(0, ady(14))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt.sound_events.death = "DeathPuff"
tt.sound_events.death_by_explosion = "DeathPuff"
tt = E.register_t(E, "enemy_desert_wolf", "enemy")

E.add_comps(E, tt, "melee", "dodge")

anchor_y = 0.28
image_y = 52
tt.dodge.chance = 0.5
tt.dodge.silent = true
tt.enemy.gold = 10
tt.enemy.melee_slot = v(27, 0)
tt.health.hp_max = 120
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, ady(45))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0034") or "info_portraits_enemies_0009"
tt.info.enc_icon = 9
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = fts(14) + 1
tt.melee.attacks[1].damage_max = 18
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].hit_time = fts(8)
tt.melee.attacks[1].sound_hit = "WolfAttack"
tt.motion.max_speed = FPS*2.56
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_desertwolf"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 10)
tt.unit.marker_offset = v(0, ady(16))
tt.unit.mod_offset = v(0, ady(28))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_SKELETON)
tt.sound_events.death = "DeathPuff"
tt.sound_events.death_by_explosion = "DeathPuff"
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0029") or "info_portraits_enemies_0003"
tt.info.enc_icon = 3
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0032") or "info_portraits_enemies_0007"
tt.info.enc_icon = 7
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.remove = scripts.enemy_basic.remove
tt.main_script.update = scripts.enemy_mixed.update
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
tt = E.register_t(E, "enemy_desert_archer", "enemy")

E.add_comps(E, tt, "melee", "ranged")

anchor_y = 0.2
image_y = 36
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0030") or "info_portraits_enemies_0004"
tt.info.enc_icon = 4
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, ady(8))
tt.unit.mod_offset = v(0, ady(20))
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
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
tt.ranged.attacks[1].bullet = "arrow_desert_archer"
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0036") or "info_portraits_enemies_0011"
tt.info.enc_icon = 11
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
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
tt = E.register_t(E, "enemy_tremor", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.42
image_y = 52
tt.enemy.gold = 10
tt.enemy.melee_slot = v(24, 0)
tt.health.hp_max = 120
tt.health_bar.offset = v(0, ady(44))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0035") or "info_portraits_enemies_0010"
tt.info.enc_icon = 10
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_tremor.update
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
tt = E.register_t(E, "enemy_wasp", "enemy")
anchor_y = 0
image_y = 66
tt.enemy.gold = 8
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 80
tt.health_bar.offset = v(0, ady(67))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0037") or "info_portraits_enemies_0012"
tt.info.enc_icon = 12
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*1.6640000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_wasp"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.new_node = "WaspTaunt"
tt.sound_events.new_node_args = {
	gain = {
		0.3,
		0.6
	}
}
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, 25, 40, 50)) or r(-10, 34, 20, 20)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 52)
tt.unit.mod_offset = v(0, ady(47))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = E.register_t(E, "enemy_wasp_queen", "enemy")

E.add_comps(E, tt, "death_spawns")

anchor_y = 0
image_y = 94
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.name = "enemy_wasp"
tt.death_spawns.quantity = 5
tt.death_spawns.spread_nodes = 3
tt.enemy.gold = 40
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 400
tt.health_bar.offset = v(0, ady(85))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0038") or "info_portraits_enemies_0013"
tt.info.enc_icon = 13
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*1.28
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_wasp_queen"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.new_node = "WaspTaunt"
tt.sound_events.new_node_args = {
	gain = {
		0.3,
		0.6
	}
}
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-25, 30, 50, 60)) or r(-15, 38, 30, 40)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 58)
tt.unit.mod_offset = v(0, ady(60))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0031") or "info_portraits_enemies_0005"
tt.info.enc_icon = 5
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
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
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0032") or "info_portraits_enemies_0006"
tt.info.enc_icon = 6
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_munra.update
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
tt.timed_attacks.list[2].mod = "mod_munra_heal"
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

tt.main_script.update = scripts.enemies_spawner.update
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
tt = E.register_t(E, "enemy_efreeti_small", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.11
image_y = 64
tt.enemy.gold = 20
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(24, 0)
tt.health.armor = 0
tt.health.hp_max = 250
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(62))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0039") or "info_portraits_enemies_0014"
tt.info.enc_icon = 15
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.28
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "enemy_efreeti_small"
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, ady(6))
tt.unit.mod_offset = v(0, ady(24))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.sound_events.death = "DeathPuff"
tt = E.register_t(E, "enemy_cannibal", "enemy")

E.add_comps(E, tt, "melee", "water")

anchor_y = 0.21428571428571427
image_y = 42
tt.cannibalize = {
	extra_hp = 50,
	hps = FPS*3,
	max_hp = 600
}
tt.enemy.gold = 15
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = 250
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(44))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0044") or "info_portraits_enemies_0019"
tt.info.enc_icon = 18
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_cannibal.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.1520000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_cannibal"
tt.sound_events.cannibalize = "CanibalEating"
tt.sound_events.water_splash = "SpecialMermaid"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(23))
tt.water.hit_offset = v(0, 5)
tt.water.mod_offset = v(0, 5)
tt.water.health_bar_hidden = true
tt = E.register_t(E, "enemy_hunter", "enemy")

E.add_comps(E, tt, "melee", "ranged", "water")

anchor_y = 0.25
image_y = 44
tt.enemy.gold = 15
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = 150
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(46))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0045") or "info_portraits_enemies_0020"
tt.info.enc_icon = 19
tt.main_script.insert = scripts.enemy_hunter.insert
tt.main_script.update = scripts.enemy_mixed_water.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.6640000000000001
tt.ranged.attacks[1].bullet = "dart"
tt.ranged.attacks[1].bullet_start_offset = {
	v(5, 25)
}
tt.ranged.attacks[1].cooldown = fts(22)
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 147.20000000000002
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_time = fts(11)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_hunter"
tt.sound_events.water_splash = "SpecialMermaid"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(11))
tt.unit.mod_offset = v(0, ady(24))
tt.water.hit_offset = v(0, 5)
tt.water.mod_offset = v(0, 5)
tt.water.health_bar_hidden = true
tt = E.register_t(E, "dart", "arrow")
tt.bullet.miss_decal = "DartDecal"
tt.bullet.flight_time = fts(17)
tt.bullet.mod = "mod_dart_poison"
tt.bullet.damage_max = 20
tt.bullet.damage_min = 10
tt.bullet.predict_target_pos = false
tt.bullet.prediction_error = false
tt.render.sprites[1].name = "Dart"
tt.render.sprites[1].animated = false
tt.pop = nil
tt = E.register_t(E, "mod_dart_poison", "mod_poison")
tt.modifier.duration = 4
tt.dps.damage_min = 3
tt.dps.damage_max = 3
tt = E.register_t(E, "enemy_shaman_priest", "enemy")

E.add_comps(E, tt, "melee", "auras")

anchor_y = 0.18
image_y = 62
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "shaman_priest_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 50
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0
tt.health.hp_max = 600
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(50))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0046") or "info_portraits_enemies_0021"
tt.info.enc_icon = 20
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 26
tt.melee.attacks[1].damage_min = 14
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.1520000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_shaman_priest"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(11))
tt.unit.mod_offset = v(0, ady(26))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = E.register_t(E, "shaman_priest_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = "mod_shaman_priest_heal"
tt.aura.cycle_time = 4
tt.aura.duration = -1
tt.aura.radius = 128
tt.aura.requires_magic = true
tt.aura.track_source = true
tt.aura.targets_per_cycle = 10
tt.aura.vis_bans = bor(F_FRIEND, F_HERO, F_BOSS)
tt.aura.vis_flags = F_MOD
tt.aura.hide_source_fx = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].name = "shaman_priest_healing"
tt.render.sprites[1].loop = true
tt = E.register_t(E, "mod_shaman_priest_heal", "modifier")

E.add_comps(E, tt, "hps", "render")

tt.modifier.duration = fts(24)
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
tt = E.register_t(E, "enemy_shaman_magic", "enemy")

E.add_comps(E, tt, "melee", "auras")

anchor_y = 0.18
image_y = 62
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].cooldown = 0
tt.auras.list[1].name = "shaman_magic_aura"
tt.enemy.gold = 50
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0
tt.health.hp_max = 600
tt.health.magic_armor = 0.9
tt.health_bar.offset = v(0, ady(50))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0048") or "info_portraits_enemies_0023"
tt.info.enc_icon = 22
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 26
tt.melee.attacks[1].damage_min = 14
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.1520000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_shaman_magic"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(11))
tt.unit.mod_offset = v(0, ady(26))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = E.register_t(E, "shaman_magic_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.allowed_templates = {
	"enemy_hunter",
	"enemy_cannibal"
}
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.mod = "mod_shaman_magic_armor"
tt.aura.radius = 115.2
tt.aura.requires_magic = true
tt.aura.targets_per_cycle = 10
tt.aura.track_source = true
tt.aura.vis_bans = bor(F_FRIEND, F_HERO, F_BOSS)
tt.aura.vis_flags = F_MOD
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "shaman_magic_aura"
tt = E.register_t(E, "mod_shaman_magic_armor", "modifier")

E.add_comps(E, tt, "render", "armor_buff")

tt.armor_buff.cycle_time = 1
tt.armor_buff.magic = true
tt.armor_buff.max_factor = 0.8
tt.armor_buff.step_factor = 0.03
tt.main_script.insert = scripts.mod_armor_buff.insert
tt.main_script.remove = scripts.mod_armor_buff.remove
tt.main_script.update = scripts.mod_armor_buff.update
tt.modifier.duration = 1.5
tt.render.sprites[1].name = "shaman_magic_mod"
tt = E.register_t(E, "enemy_shaman_shield", "enemy")

E.add_comps(E, tt, "melee", "auras")

anchor_y = 0.16
image_y = 62
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "shaman_shield_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 50
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0.8
tt.health.hp_max = 600
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(47))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0047") or "info_portraits_enemies_0022"
tt.info.enc_icon = 21
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 26
tt.melee.attacks[1].damage_min = 14
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.1520000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_shaman_shield"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(26))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = E.register_t(E, "shaman_shield_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.mod = "mod_shaman_armor"
tt.aura.cycle_time = 1
tt.aura.duration = -1
tt.aura.radius = 115.2
tt.aura.track_source = true
tt.aura.targets_per_cycle = 10
tt.aura.vis_bans = bor(F_FRIEND, F_HERO, F_BOSS)
tt.aura.vis_flags = F_MOD
tt.aura.allowed_templates = {
	"enemy_hunter",
	"enemy_cannibal"
}
tt.aura.requires_magic = true
tt.main_script.insert = scripts.aura_apply_mod.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.render.sprites[1].name = "shaman_shield_aura"
tt.render.sprites[1].loop = true
tt = E.register_t(E, "mod_shaman_armor", "modifier")

E.add_comps(E, tt, "render", "armor_buff")

tt.modifier.duration = 1.5
tt.modifier.use_mod_offset = false
tt.armor_buff.magic = false
tt.armor_buff.max_factor = 0.8
tt.armor_buff.step_factor = 0.03
tt.armor_buff.cycle_time = 1
tt.render.sprites[1].name = "buff_armor"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor.y = 0.15625
tt.main_script.insert = scripts.mod_armor_buff.insert
tt.main_script.remove = scripts.mod_armor_buff.remove
tt.main_script.update = scripts.mod_armor_buff.update
tt = E.register_t(E, "enemy_shaman_necro", "enemy")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.22
image_y = 58
tt.enemy.gold = 50
tt.enemy.melee_slot = v(21, 0)
tt.health.armor = 0
tt.health.hp_max = 800
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(51))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0049") or "info_portraits_enemies_0024"
tt.info.enc_icon = 23
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_shaman_necro.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 30
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.1520000000000001
tt.ranged.attacks[1].bullet = "bolt_shaman_necro"
tt.ranged.attacks[1].bullet_start_offset = {
	v(-8, 32)
}
tt.ranged.attacks[1].cooldown = fts(28) + 1
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 147.20000000000002
tt.ranged.attacks[1].min_range = 25.6
tt.ranged.attacks[1].shoot_time = fts(11)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_shaman_necro"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].allowed_templates = {
	"enemy_cannibal",
	"enemy_hunter",
	"enemy_shaman_shield",
	"enemy_shaman_magic",
	"enemy_shaman_priest"
}
tt.timed_attacks.list[1].animation = "necromancer"
tt.timed_attacks.list[1].cast_time = fts(16)
tt.timed_attacks.list[1].cooldown = 1
tt.timed_attacks.list[1].max_range = 179.20000000000002
tt.timed_attacks.list[1].sound = "CanibalNecromancer"
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(12))
tt.unit.mod_offset = v(0, ady(26))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = E.register_t(E, "bolt_shaman_necro", "bolt_enemy")
tt.render.sprites[1].prefix = "bolt_shaman_necro"
tt.render.sprites[1].anchor = v(0.625, 0.5)
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 50
tt.bullet.damage_min = 30
tt.bullet.max_speed = 450
tt.bullet.max_track_distance = 50
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.hit_fx = "fx_bolt_shaman_necro_hit"
tt = E.register_t(E, "fx_bolt_shaman_necro_hit", "fx")
tt.render.sprites[1].name = "bolt_shaman_necro_hit"
tt = E.register_t(E, "enemy_cannibal_zombie", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.2
image_y = 48
tt.enemy.gold = 0
tt.enemy.melee_slot = v(17, 0)
tt.health.armor = 0
tt.health.hp_max = 500
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(42))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0056") or "info_portraits_enemies_0028"
tt.info.enc_icon = 24
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound = "CanibalZombie"
tt.motion.max_speed = FPS*0.768
tt.render.sprites[1].prefix = "enemy_cannibal_zombie"
tt.render.sprites[1].anchor.y = anchor_y
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(21))
tt.sound_events.insert = "CanibalZombie"
tt = E.register_t(E, "enemy_jungle_spider_tiny", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.17
image_y = 32
tt.enemy.gold = 0
tt.enemy.melee_slot = v(20, 0)
tt.health.armor = 0
tt.health.hp_max = {
	15,
	20,
	25
}
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, ady(24))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0043") or "info_portraits_enemies_0018"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 5
tt.melee.attacks[1].damage_min = 1
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*3.84
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_jungle_spider_tiny"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-10, -5, 20, 20)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hit_offset = v(0, 10)
tt.unit.marker_offset = v(0, ady(5))
tt.unit.mod_offset = v(0, ady(17))
tt.unit.explode_fx = "fx_spider_explode"
tt.sound_events.death = "DeathEplosion"
tt.sound_events.death_args = {
	gain = 0.2
}
tt.vis.bans = bor(F_SKELETON, F_POISON)
tt = E.register_t(E, "enemy_jungle_spider_small", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.17
image_y = 34
tt.enemy.gold = 8
tt.enemy.melee_slot = v(22, 0)
tt.health.armor = 0
tt.health.hp_max = 100
tt.health.magic_armor = 0.65
tt.health_bar.offset = v(0, ady(35))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0041") or "info_portraits_enemies_0016"
tt.info.enc_icon = 16
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*1.92
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_jungle_spider_small"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-20, -5, 40, 40)) or r(-15, -5, 30, 30)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(5))
tt.unit.mod_offset = v(0, ady(17))
tt.unit.explode_fx = "fx_spider_explode"
tt.sound_events.death = "DeathEplosion"
tt.sound_events.death_args = {
	gain = 0.3
}
tt.vis.bans = bor(F_SKELETON, F_POISON)
tt = E.register_t(E, "enemy_jungle_spider_big", "enemy")

E.add_comps(E, tt, "melee", "timed_attacks")

anchor_y = 0.19
image_y = 50
tt.enemy.gold = 40
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(24, 0)
tt.health.armor = 0
tt.health.hp_max = 500
tt.health.magic_armor = 0.8
tt.health_bar.offset = v(0, ady(49))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0042") or "info_portraits_enemies_0017"
tt.info.enc_icon = 17
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_spider_big.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound_hit = "SpiderAttack"
tt.motion.max_speed = FPS*1.92
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_jungle_spider_big"
tt.sound_events.death = "DeathEplosion"
tt.timed_attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[1].bullet = "jungle_spider_egg"
tt.timed_attacks.list[1].max_cooldown = 6
tt.timed_attacks.list[1].max_count = 3
tt.timed_attacks.list[1].min_cooldown = 2
tt.unit.blood_color = BLOOD_GREEN
tt.unit.explode_fx = "fx_spider_explode"
tt.unit.hit_offset = v(0, 12)
tt.unit.marker_offset = v(0, ady(6))
tt.unit.mod_offset = v(0, ady(17))
tt.vis.bans = bor(F_SKELETON, F_POISON)
tt = E.register_t(E, "jungle_spider_egg", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.22
tt.render.sprites[1].prefix = "jungle_spider_egg"
tt.render.sprites[1].loop = false
tt.spawner.count = 3
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_jungle_spider_tiny"
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
tt = E.register_t(E, "enemy_gorilla", "enemy")

E.add_comps(E, tt, "melee", "timed_attacks")

anchor_y = 0.12
image_y = 108
tt.enemy.gold = 160
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(29, 0)
tt.health.armor = 0
tt.health.hp_max = 2800
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(93))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0050") or "info_portraits_enemies_0025"
tt.info.enc_icon = 25
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1] = E.clone_c(E, "area_attack")
tt.melee.attacks[1].cooldown = 2.5
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 80
tt.melee.attacks[1].damage_min = 40
tt.melee.attacks[1].damage_radius = 51.2
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(30, 0)
tt.melee.attacks[1].hit_time = fts(15)
tt.melee.attacks[1].sound_hit = "AreaAttack"
tt.motion.max_speed = FPS*1.024
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_gorilla"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect = r(-25, -10, 50, 70)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 24)
tt.unit.marker_offset = v(0, ady(13))
tt.unit.mod_offset = v(0, ady(36))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_EAT)
tt = E.register_t(E, "alien_egg", "decal_scripted")

E.add_comps(E, tt, "spawner", "sound_events")

tt.main_script.update = scripts.alien_egg.update
tt.render.sprites[1].prefix = "alien_egg"
tt.sound_events.destroy = "SpecialAlienEggOpen"
tt.sound_events.open = "SpecialAlienEggOpen"
tt.spawner.count = 3
tt.spawner.cycle_time = 0.25
tt.spawner.entity = "enemy_alien_breeder"
tt.spawner.random_subpath = true
tt.spawner.eternal = true
tt.spawner.ni = 1
tt = E.register_t(E, "enemy_alien_breeder", "enemy")

E.add_comps(E, tt, "track_kills", "tween")

anchor_y = 0.23
image_y = 40
tt.enemy.gold = 5
tt.enemy.melee_slot = v(17, 0)
tt.health.armor = 0
tt.health.hp_max = 140
tt.health.magic_armor = 0.6
tt.health_bar.offset = v(0, ady(30))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0053") or "info_portraits_enemies_0053"
tt.info.enc_icon = 27
tt.info.fn = scripts.enemy_alien_breeder.get_info
tt.main_script.insert = scripts.enemy_alien_breeder.insert
tt.main_script.update = scripts.enemy_alien_breeder.update
tt.motion.max_speed = FPS*2.944
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_alien_breeder"
tt.sound_events.death = "DeathEplosion"
tt.spawn_bans = {
	"soldier_sand_warrior",
	"soldier_death_rider",
	"soldier_skeleton_knight",
	"soldier_skeleton",
	"soldier_frankenstein",
	"soldier_dracolich_golem",
	"soldier_elemental"
}
tt.tween.props[1].name = "offset"
tt.tween.disabled = true
tt.tween.remove = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 10)
tt.unit.marker_offset = v(0, ady(9))
tt.unit.mod_offset = v(0, ady(19))
tt.vis.bans = bor(F_SKELETON)
tt.facehug_offsets = {
	soldier_default = v(2, -2),
	soldier_templar = v(2, 0),
	soldier_assassin = v(2, 0),
	soldier_death_rider = v(3, 16),
	soldier_frankenstein = v(0, 41),
	hero_default = v(0, 4),
	hero_alien = v(0, 10),
	hero_beastmaster = v(0, 8),
	hero_giant = v(0, 20),
	hero_pirate = v(0, 6),
	hero_priest = v(0, 7),
	hero_wizard = v(0, 6),
	hero_voodoo_witch = v(3, 4),
	hero_crab = v(6, 7),
	hero_minotaur = v(11, 14),
	hero_monk = v(0, 2),
	hero_monkey_god = v(10, 5),
	hero_vampiress = v(0, 20),
	hero_van_helsing = v(1, 5)
}
tt = E.register_t(E, "enemy_alien_reaper", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.13
image_y = 50
tt.enemy.gold = 10
tt.enemy.melee_slot = v(29, 0)
tt.health.armor = 0
tt.health.hp_max = 500
tt.health.magic_armor = 0.6
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.health_bar.offset = v(0, ady(50))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0054") or "info_portraits_enemies_0054"
tt.info.enc_icon = 28
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 60
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(9)
tt.motion.max_speed = FPS*1.28
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_alien_reaper"
tt.ui.click_rect = (IS_PHONE_OR_TABLET and r(-25, -10, 50, 50)) or r(-15, -5, 30, 40)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 24)
tt.unit.marker_offset = v(0, ady(6))
tt.unit.mod_offset = v(0, ady(18))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.sound_events.death = "DeathEplosion"
tt.vis.bans = bor(F_SKELETON)
tt = E.register_t(E, "enemy_savage_bird", "enemy")
anchor_y = 0
image_y = 112
tt.enemy.gold = 15
tt.health.armor = 0
tt.health.hp_max = 150
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(84))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0052") or "info_portraits_enemies_0057"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*2.56
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_savage_bird"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = r(-20, 42, 40, 45)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 58)
tt.unit.marker_offset = v(0, ady(1))
tt.unit.mod_offset = v(0, ady(60))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = E.register_t(E, "enemy_savage_bird_rider", "enemy")

E.add_comps(E, tt, "ranged", "death_spawns")

anchor_y = 0
image_y = 112
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0051") or "info_portraits_enemies_0026"
tt.info.enc_icon = 26
tt.death_spawns.name = "enemy_savage_bird"
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.fx = "savage_bird_rider_drop_dead"
tt.death_spawns.fx_flip_to_source = true
tt.enemy.gold = 25
tt.health.armor = 0
tt.health.hp_max = 250
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(90))
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.motion.max_speed = FPS*1.28
tt.ranged.attacks[1].bullet = "savage_bird_spear"
tt.ranged.attacks[1].bullet_start_offset = {
	v(4, 75)
}
tt.ranged.attacks[1].cooldown = fts(41)
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 166.4
tt.ranged.attacks[1].min_range = 32
tt.ranged.attacks[1].shoot_time = fts(5)
tt.ranged.attacks[1].sync_animation = true
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_savage_bird_rider"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = nil
tt.ui.click_rect = r(-20, 42, 40, 45)
tt.unit.death_animation = nil
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 62)
tt.unit.marker_offset = v(0, ady(1))
tt.unit.mod_offset = v(0, ady(60))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = E.register_t(E, "savage_bird_rider_drop_dead", "decal")

E.add_comps(E, tt, "enemy", "health", "vis", "unit", "heading", "nav_path", "motion", "sound_events")

tt.health.hp = 0
tt.health.dead_lifetime = 2
tt.render.sprites[1].name = "savage_bird_rider_drop_dead"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor.y = 0
tt.enemy.necromancer_offset = v(-25, 14)
tt.sound_events.insert = "DeathHuman"
tt = E.register_t(E, "savage_bird_spear", "arrow")
tt.bullet.miss_decal = "decal_spear"
tt.bullet.flight_time = fts(18)
tt.bullet.damage_max = 80
tt.bullet.damage_min = 40
tt.bullet.predict_target_pos = false
tt.bullet.prediction_error = false
tt.render.sprites[1].name = "spear"
tt.render.sprites[1].animated = false
tt = E.register_t(E, "enemy_broodguard", "enemy")

E.add_comps(E, tt, "melee", "cliff", "auras")

anchor_y = 0.19
image_y = 42
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "aura_damage_sprint"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 20
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = 300
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(44))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0057") or "info_portraits_enemies_0029"
tt.info.enc_icon = 29
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed_cliff.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 22
tt.melee.attacks[1].damage_min = 8
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.28
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_broodguard"
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, ady(9))
tt.unit.mod_offset = v(0, ady(20))
tt.damage_sprint_factor = 0.78125
tt = E.register_t(E, "aura_damage_sprint", "aura")
tt.aura.duration = -1
tt.aura.track_source = true
tt.main_script.update = scripts.aura_damage_sprint.update
tt.main_script.insert = scripts.aura_damage_sprint.insert
tt.main_script.remove = scripts.aura_damage_sprint.remove
tt = E.register_t(E, "enemy_blazefang", "enemy")

E.add_comps(E, tt, "melee", "ranged", "death_spawns")

anchor_y = 0.2
image_y = 58
tt.death_spawns.name = "blazefang_explosion"
tt.death_spawns.quantity = 1
tt.death_spawns.concurrent_with_death = true
tt.enemy.gold = 40
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(25, 0)
tt.health.armor = 0
tt.health.hp_max = 600
tt.health.magic_armor = 0.7
tt.health_bar.offset = v(0, ady(60))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0060") or "info_portraits_enemies_0032"
tt.info.enc_icon = 30
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 22
tt.melee.attacks[1].damage_min = 18
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.024
tt.ranged.cooldown = fts(32) + 1
tt.ranged.attacks[1].bullet = "bolt_blazefang"
tt.ranged.attacks[1].bullet_start_offset = {
	v(25, 10),
	v(12, 22),
	v(6, 4)
}
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 147.20000000000002
tt.ranged.attacks[1].min_range = 25.6
tt.ranged.attacks[1].shoot_time = fts(24)
tt.ranged.attacks[1].animation = "ranged"
tt.ranged.attacks[1].shared_cooldown = true
tt.ranged.attacks[2] = table.deepclone(tt.ranged.attacks[1])
tt.ranged.attacks[2].bullet = "bolt_blazefang_instakill"
tt.ranged.attacks[2].chance = 0.2
tt.ranged.attacks[2].vis_flags = bor(F_DISINTEGRATED, F_RANGED)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_blazefang"
tt.render.sprites[1].angles.ranged = {
	"ranged_side",
	"ranged_up",
	"ranged_down"
}
tt.render.sprites[1].angles_flip_vertical = {
	ranged = true
}
tt.render.sprites[1].angles_custom = {
	ranged = {
		35,
		145,
		210,
		335
	}
}
tt.sound_events.death = "SaurianBlazefangDeath"
tt.ui.click_rect = r(-25, -10, 50, 55)
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, ady(10))
tt.unit.mod_offset = v(0, ady(30))
tt = E.register_t(E, "blazefang_explosion", "bullet")
tt.render = nil
tt.sound_events = nil
tt.main_script.update = scripts.blazefang_explosion.update
tt.bullet.damage_min = 100
tt.bullet.damage_max = 100
tt.bullet.damage_radius = 76.8
tt = E.register_t(E, "bolt_blazefang", "bolt_enemy")
tt.render.sprites[1].prefix = "bolt_blazefang"
tt.render.sprites[1].anchor = v(0.53, 0.58)
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 100
tt.bullet.damage_min = 60
tt.bullet.max_speed = 1200
tt.bullet.acceleration_factor = 0.3
tt.bullet.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_TRUE)
tt.bullet.hit_fx = "fx_bolt_blazefang_hit"
tt.bullet.max_track_distance = 50
tt.sound_events.insert = "SaurianBlazefangAttack"
tt = E.register_t(E, "bolt_blazefang_instakill", "bolt_blazefang")
tt.bullet.damage_type = bor(DAMAGE_DISINTEGRATE, DAMAGE_INSTAKILL)
tt = E.register_t(E, "fx_bolt_blazefang_hit", "fx")
tt.render.sprites[1].name = "bolt_blazefang_hit"
tt = E.register_t(E, "enemy_brute", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.16
image_y = 88
tt.enemy.gold = 200
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(29, 0)
tt.health.armor = 0
tt.health.hp_max = 4400
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(75))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0063") or "info_portraits_enemies_0035"
tt.info.enc_icon = 32
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 60
tt.melee.attacks[1].damage_type = DAMAGE_TRUE
tt.melee.attacks[1].dodge_time = fts(6)
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].sound_hit = "SaurianBruteAttack"
tt.melee.attacks[2] = E.clone_c(E, "area_attack")
tt.melee.attacks[2].animation = "area_attack"
tt.melee.attacks[2].cooldown = 13.333333333333334
tt.melee.attacks[2].damage_max = 120
tt.melee.attacks[2].damage_min = 80
tt.melee.attacks[2].damage_radius = 38.4
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].hit_offset = v(30, 0)
tt.melee.attacks[2].hit_times = {
	fts(10),
	fts(20),
	fts(30)
}
tt.melee.attacks[2].sound_hit = "SaurianBruteAttack"
tt.motion.max_speed = FPS*0.768
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_brute"
tt.sound_events.death = "DeathBig"
tt.ui.click_rect = r(-25, -10, 50, 65)
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, ady(15))
tt.unit.mod_offset = v(0, ady(30))
tt.unit.size = UNIT_SIZE_MEDIUM
tt = E.register_t(E, "enemy_myrmidon", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.21
image_y = 62
tt.enemy.gold = 50
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(25, 0)
tt.health.armor = 0.6
tt.health.hp_max = 800
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(63))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0062") or "info_portraits_enemies_0034"
tt.info.enc_icon = 33
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 34
tt.melee.attacks[1].damage_min = 16
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "bite_attack"
tt.melee.attacks[2].cooldown = 12
tt.melee.attacks[2].damage_max = 150
tt.melee.attacks[2].damage_min = 75
tt.melee.attacks[2].mod = "mod_myrmidon_lifesteal"
tt.melee.attacks[2].sound_hit = "SaurianMyrmidonBite"
tt.melee.attacks[2].hit_time = fts(5)
tt.motion.max_speed = FPS*1.024
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_myrmidon"
tt.ui.click_rect = r(-25, -10, 50, 50)
tt.unit.can_explode = false
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, ady(12))
tt.unit.mod_offset = v(0, ady(30))
tt = E.register_t(E, "mod_myrmidon_lifesteal", "modifier")
tt.heal_hp = 125
tt.main_script.insert = scripts.mod_simple_lifesteal.insert
tt = E.register_t(E, "enemy_nightscale", "enemy")

E.add_comps(E, tt, "melee", "cliff")

anchor_y = 0.26
image_y = 48
tt.enemy.gold = 25
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = 350
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, ady(48))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0059") or "info_portraits_enemies_0031"
tt.info.enc_icon = 34
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_nightscale.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 42
tt.melee.attacks[1].damage_min = 28
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.536
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_nightscale"
tt.sound_events.hide = "SaurianNightscaleInvisible"
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(12))
tt.unit.mod_offset = v(0, ady(22))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt.hidden = {
	trigger_health_factor = 0.6,
	duration = 8,
	max_times = 1,
	nodeslimit = 25,
	ts = 0
}
tt = E.register_t(E, "enemy_darter", "enemy")

E.add_comps(E, tt, "melee", "cliff")

anchor_y = 0.19
image_y = 36
tt.enemy.gold = 20
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = 250
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(39))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0058") or "info_portraits_enemies_0030"
tt.info.enc_icon = 31
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_darter.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 22
tt.melee.attacks[1].damage_min = 18
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.92
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_darter"
tt.sound_events.blink = "SaurianDarterTeleporth"
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.hit_offset = v(0, 8)
tt.unit.marker_offset = v(0, ady(7))
tt.unit.mod_offset = v(0, ady(16))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt.blink = {
	cooldown = 4,
	nodeslimit = 45,
	nodeslimit_conn = 15,
	nodes_offset_min = 15,
	nodes_offset_max = 25,
	travel_time = fts(11),
	fx = "fx_darter_blink",
	ts = 0
}
tt = E.register_t(E, "fx_darter_blink", "fx")
tt.render.sprites[1].name = "darter_blink"
tt.render.sprites[1].anchor.y = 0.22
tt = E.register_t(E, "enemy_savant", "enemy")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks")

anchor_y = 0.26
image_y = 42
tt.enemy.gold = 100
tt.enemy.melee_slot = v(22, 0)
tt.health.armor = 0
tt.health.hp_max = 1000
tt.health.magic_armor = 0.5
tt.health_bar.offset = v(0, ady(45))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0061") or "info_portraits_enemies_0033"
tt.info.enc_icon = 37
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_savant.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 66
tt.melee.attacks[1].damage_min = 34
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*0.768
tt.ranged.attacks[1].bullet = "savant_ray"
tt.ranged.attacks[1].shoot_time = fts(18)
tt.ranged.attacks[1].cooldown = 1.5
tt.ranged.attacks[1].max_range = 147.20000000000002
tt.ranged.attacks[1].min_range = 44.800000000000004
tt.ranged.attacks[1].bullet_start_offset = {
	v(28, ady(28))
}
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_savant"
tt.timed_attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.timed_attacks.list[1].animations = {
	"portal_start",
	"portal_loop",
	"portal_end"
}
tt.timed_attacks.list[1].min_cooldown = 5
tt.timed_attacks.list[1].max_cooldown = 10
tt.timed_attacks.list[1].entity = "savant_portal"
tt.timed_attacks.list[1].nodes_limit = 20
tt.timed_attacks.list[1].node_offset = 12
tt.timed_attacks.list[1].count_group_name = "savant_portals"
tt.timed_attacks.list[1].count_group_type = COUNT_GROUP_CONCURRENT
tt.timed_attacks.list[1].count_group_max = 25
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(9))
tt.unit.mod_offset = v(0, ady(22))
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt = E.register_t(E, "savant_portal", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "sound_events")

tt.main_script.update = scripts.savant_portal.update
tt.render.sprites[1].anchor.y = 0.5
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].prefix = "savant_portal"
tt.render.sprites[1].z = Z_DECALS
tt.portal = {
	entities = {
		{
			0.1,
			"enemy_darter"
		},
		{
			0.3,
			"enemy_nightscale"
		},
		{
			1,
			"enemy_broodguard"
		}
	},
	node_var = {
		-5,
		5
	},
	cycle_time = 1,
	duration = 6,
	max_count = 20,
	spawn_fx = "fx_darter_blink",
	pi = nil,
	spi = nil,
	ni = nil,
	finished = false
}
tt.sound_events.insert = "SaurianSavantOpenPortal"
tt.sound_events.spawn = "SaurianSavantTeleporth"
tt.sound_events.loop = "SaurianSavantPortalLoop"
tt = E.register_t(E, "savant_ray", "bullet")
tt.image_width = 115
tt.main_script.update = scripts.ray_enemy.update
tt.render.sprites[1].name = "savant_ray"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min = 90
tt.bullet.damage_max = 160
tt.bullet.hit_time = fts(3)
tt.bullet.max_track_distance = 50
tt.sound_events.insert = "SaurianSavantAttack"
tt = E.register_t(E, "enemy_sniper", "enemy")

E.add_comps(E, tt, "melee", "ranged")

image_y = 42
anchor_y = 0.16666666666666666
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0095") or "info_portraits_enemies_0041"
tt.info.enc_icon = 59
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 14)
tt.main_script.insert = scripts.enemy_sniper.insert
tt.main_script.update = scripts.enemy_sniper.update
tt.health.hp_max = 500
tt.health.armor = 0
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 37)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.render.sprites[1].prefix = "enemy_sniper"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles.ranged_start = {
	"ranged_start_side",
	"ranged_start_up",
	"ranged_start_down"
}
tt.render.sprites[1].angles.ranged_loop = {
	"ranged_loop_side",
	"ranged_loop_up",
	"ranged_loop_down"
}
tt.render.sprites[1].angles.ranged_end = {
	"ranged_end_side",
	"ranged_end_up",
	"ranged_end_down"
}
tt.render.sprites[1].angles_flip_vertical = {
	ranged_end = true,
	ranged_loop = true,
	ranged_start = true
}
tt.render.sprites[1].angles_custom = {
	ranged = {
		35,
		145,
		210,
		335
	}
}
tt.motion.max_speed = FPS*1.92
tt.enemy.gold = 40
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(25, 0)
tt.melee.attacks[1].hit_time = fts(10)
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_min = 12
tt.melee.attacks[1].damage_max = 22
tt.ranged.attacks[1].bullet = "bolt_sniper"
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].shoot_time = fts(5)
tt.ranged.attacks[1].cooldown = 2
tt.ranged.attacks[1].max_range = 450
tt.ranged.attacks[1].min_range = 51
tt.ranged.attacks[1].range_var = 100
tt.ranged.attacks[1].animations = {
	"ranged_start",
	"ranged_loop",
	"ranged_end"
}
tt.ranged.attacks[1].bullet_start_offset = {
	v(14, ady(21)),
	v(10, ady(34)),
	v(8, ady(10))
}
tt = E.register_t(E, "bolt_sniper", "bolt_enemy")
tt.render.sprites[1].prefix = "bolt_sniper"
tt.bullet.align_with_trajectory = true
tt.bullet.damage_max = 100
tt.bullet.damage_min = 100
tt.bullet.max_speed = FPS*30
tt.bullet.damage_type = bor(DAMAGE_TRUE)
tt.bullet.max_track_distance = 50
tt.sound_events.insert = "SaurianSniperBullet"
tt = E.register_t(E, "enemy_razorwing", "enemy")

E.add_comps(E, tt, "cliff")

anchor_y = 0
image_y = 88
tt.cliff.hide_sprite_ids = {
	2
}
tt.enemy.gold = 10
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 100
tt.health_bar.offset = v(0, ady(79))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0064") or "info_portraits_enemies_0036"
tt.info.enc_icon = 36
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*1.6640000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_razorwing"
tt.render.sprites[1].angles_flip_vertical = {
	walk = true
}
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = r(-20, 44, 40, 50)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 64)
tt.unit.marker_offset = v(0, ady(1))
tt.unit.mod_offset = v(0, ady(56))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt.custom_offsets = {
	tower_high_elven = v(0, 50),
	tower_wild_magus = v(0, 50),
	tower_entwood = v(0, 40),
	tower_druid = v(0, 55)
}
tt = E.register_t(E, "pop_wild_mage", "pop")
tt.render.sprites[1].name = "elven_pops_0006"
tt = E.register_t(E, "pop_crit_wild_magus", "pop")
tt.render.sprites[1].name = "elven_pops_0024"
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
tt = E.register_t(E, "fx_wild_magus_hit", "fx")
tt.render.sprites[1].name = "bolt_wild_magus_hit"
tt = E.register_t(E, "fx_ray_wild_magus_hit", "fx")
tt.render.sprites[1].name = "fx_ray_wild_magus_hit"
tt = E.register_t(E, "fx_eldritch_explosion", "fx")

E.add_comps(E, tt, "sound_events")

tt.render.sprites[1].name = "fx_eldritch_explosion"
tt.render.sprites[1].sort_y_offset = -5
tt.sound_events.insert = "TowerWildMagusDoomExplote"
tt = E.register_t(E, "tower_wild_magus", "tower")

E.add_comps(E, tt, "attacks", "powers", "tween")

tt.info.enc_icon = 16
tt.info.i18n_key = "TOWER_MAGE_WILD_MAGUS"
tt.info.portrait = ((IS_PHONE and "portraits_towers") or "info_portraits_towers") .. "_2468"
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
tt.powers.eldritch.price_base = 325
tt.powers.eldritch.price_inc = 185
tt.powers.eldritch.cooldowns = {
	28,
	24,
	20
}
tt.powers.eldritch.enc_icon = 16
tt.powers.ward = E.clone_c(E, "power")
tt.powers.ward.attack_idx = 3
tt.powers.ward.price_base = 225
tt.powers.ward.price_inc = 225
tt.powers.ward.target_count = {
	1,
	3,
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
tt.alter_reality_mod = "mod_teleport_wild_magus"
tt = E.register_t(E, "bolt_wild_magus", "bolt")

E.add_comps(E, tt, "tween")

tt.alter_reality_chance = 0.01
tt.alter_reality_mod = "mod_teleport_wild_magus"
tt.render.sprites[1].prefix = "bolt_wild_magus"
tt.bullet.damage_max = 16
tt.bullet.damage_min = 8
tt.bullet.damage_same_target_inc = 0.5
tt.bullet.damage_same_target_max = 24
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
tt.render.sprites[1].size_scales = {
	vv(0.83),
	vv(1.2),
	vv(1.3)
}
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
	80,
	180,
	260
}
tt.damage_radius = 87.5
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
	"mod_shaman_armor",
	"mod_shaman_magic_armor",
	"mod_shaman_priest_heal",
	"mod_xerxes_invisibility"
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
	enemy_arachnomancer = v(0, 41),
	enemy_bloodsydian_warlock = v(0, 73),
	enemy_ettin = v(0, 60),
	enemy_gnoll_blighter = v(0, 39),
	enemy_gnoll_bloodsydian = v(0, 39),
	enemy_gnoll_reaver = v(0, 39),
	enemy_hyena = v(0, 20),
	enemy_ogre_magi = v(0, 78),
	enemy_razorboar = v(0, 53),
	enemy_satyr_cutthroat = v(0, 39),
	enemy_satyr_hoplite = v(0, 55),
	enemy_shroom_breeder = v(0, 67),
	enemy_spider_arachnomancer = v(0, 39),
	enemy_sword_spider = v(0, 39),
	enemy_twilight_avenger = v(0, 47),
	enemy_twilight_elf_harasser = v(0, 39),
	enemy_twilight_evoker = v(0, 47),
	enemy_twilight_golem = v(0, 80),
	enemy_twilight_heretic = v(0, 45),
	enemy_twilight_scourger = v(0, 40),
	enemy_zealot = v(0, 39),
	eb_drow_queen = v(0, 40),
	eb_spider = v(0, 87),
	enemy_blood_servant = v(0, 35),
	enemy_grim_devourers = v(0, 39),
	enemy_mounted_avenger = v(0, 63),
	enemy_shadow_champion = v(0, 55),
	enemy_shadows_spawns = v(0, 34)
}
tt = E.register_t(E, "enemy_quetzal", "enemy")

E.add_comps(E, tt, "timed_attacks")

anchor_y = 0
image_y = 114
tt.enemy.gold = 100
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(18, 0)
tt.health.hp_max = 500
tt.health_bar.offset = v(0, ady(97))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0065") or "info_portraits_enemies_0037"
tt.info.enc_icon = 35
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_quetzal.update
tt.motion.max_speed = FPS*2.56
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_quetzal"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "DeathPuff"
tt.timed_attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.timed_attacks.list[1].bullet = "quetzal_egg"
tt.timed_attacks.list[1].max_cooldown = 1.5
tt.timed_attacks.list[1].min_cooldown = 1.5
tt.timed_attacks.list[1].max_count = 8
tt.ui.click_rect = r(-20, 42, 40, 50)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 68)
tt.unit.marker_offset = v(0, ady(1))
tt.unit.mod_offset = v(0, ady(70))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = E.register_t(E, "quetzal_egg", "decal_scripted")

E.add_comps(E, tt, "render", "spawner", "tween")

tt.main_script.update = scripts.enemies_spawner.update
tt.render.sprites[1].anchor.y = 0.18
tt.render.sprites[1].prefix = "quetzal_egg"
tt.render.sprites[1].loop = false
tt.spawner.count = 1
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_razorwing"
tt.spawner.allowed_subpaths = nil
tt.spawner.animation_start = "start"
tt.spawner.initial_spawn_animation = "raise"
tt.spawner.keep_gold = true
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
tt = E.register_t(E, "enemy_redspine", "enemy")

E.add_comps(E, tt, "melee", "ranged", "water")

anchor_y = 0.22
image_y = 64
tt.enemy.gold = 40
tt.enemy.melee_slot = v(32, 0)
tt.enemy.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER)
tt.health.armor = 0
tt.health.hp_max = 1700
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 49)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0073") or "info_portraits_enemies_0046"
tt.info.enc_icon = 46
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed_water.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 35
tt.melee.attacks[1].damage_min = 25
tt.melee.attacks[1].hit_time = fts(20)
tt.motion.max_speed = 38.4
tt.ranged.attacks[1].animation = "rangedAttack"
tt.ranged.attacks[1].bullet = "harpoon_redspine"
tt.ranged.attacks[1].bullet_start_offset = {
	v(0, 40)
}
tt.ranged.attacks[1].cooldown = 3
tt.ranged.attacks[1].max_range = 125
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_time = fts(8)
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_redspine"
tt.sound_events.death_water = "RTWaterDead"
tt.sound_events.water_splash = "SpecialMermaid"
tt.ui.click_rect = r(-20, -5, 40, 60)
tt.unit.hit_offset = v(0, 17)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 18)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.water.health_bar_offset = v(0, tt.health_bar.offset.y - 20)
tt.water.hit_offset = v(0, 5)
tt.water.mod_offset = v(0, 12)
tt.water.speed_factor = 1.5
tt = E.register_t(E, "harpoon_redspine", "arrow")
tt.render.sprites[1].name = "Redspine_spear"
tt.render.sprites[1].animated = false
tt.bullet.damage_min = 100
tt.bullet.damage_max = 130
tt.bullet.flight_time = fts(10)
tt.bullet.miss_decal = "Redspine_spear_decal"
tt.bullet.pop = nil
tt = E.register_t(E, "enemy_bluegale", "enemy")

E.add_comps(E, tt, "melee", "ranged", "timed_attacks", "water")

anchor_y = 0.20689655172413793
image_y = 116
tt.enemy.gold = 60
tt.enemy.lives_cost = 3
tt.enemy.melee_slot = v(30, 0)
tt.enemy.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER)
tt.health.armor = 0
tt.health.hp_max = 2400
tt.health.immune_to = DAMAGE_MAGICAL
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 57)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0074") or "info_portraits_enemies_0045"
tt.info.enc_icon = 43
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_bluegale.update
tt.motion.max_speed = 30.72
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_bluegale"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].prefix = "bluegale_lightning"
tt.sound_events.death_water = "RTWaterDead"
tt.sound_events.water_splash = "SpecialMermaid"
tt.ui.click_rect = r(-25, -10, 50, 60)
tt.unit.hit_offset = v(0, 20)
tt.unit.mod_offset = v(0, 20)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt.water.health_bar_offset = v(0, tt.health_bar.offset.y - 30)
tt.water.hit_offset = v(0, 5)
tt.water.mod_offset = v(0, 12)
tt.water.speed_factor = 1.625
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 60
tt.melee.attacks[1].hit_time = fts(30)
tt.ranged.attacks[1].animation = "rangedAttack"
tt.ranged.attacks[1].bullet = "ray_bluegale"
tt.ranged.attacks[1].bullet_start_offset = {
	v(27, 70)
}
tt.ranged.attacks[1].cooldown = 0
tt.ranged.attacks[1].hold_advance = true
tt.ranged.attacks[1].max_range = 125
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].shoot_time = fts(18)
tt.timed_attacks.list[1] = E.clone_c(E, "aura_attack")
tt.timed_attacks.list[1].animation = "castStorm"
tt.timed_attacks.list[1].bullet = "bluegale_clouds_aura"
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].node_random_max = 30
tt.timed_attacks.list[1].node_random_min = 15
tt.timed_attacks.list[1].nodes_limit = 40
tt.timed_attacks.list[1].shoot_time = fts(14)
tt = E.register_t(E, "enemy_bloodshell", "enemy")

E.add_comps(E, tt, "melee", "water")

anchor_y = 0.26
image_y = 72
tt.enemy.gold = 75
tt.enemy.lives_cost = 5
tt.enemy.melee_slot = v(34, 0)
tt.enemy.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER)
tt.health.armor = 0.95
tt.health.hp_max = 3200
tt.health.immune_to = bor(DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL)
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(76))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0076") or "info_portraits_enemies_0048"
tt.info.enc_icon = 42
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed_water.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 120
tt.melee.attacks[1].damage_min = 100
tt.melee.attacks[1].hit_time = fts(16)
tt.motion.max_speed = 26.879999999999995
tt.render.sprites[1].anchor.y = 0.26
tt.render.sprites[1].prefix = "enemy_bloodshell"
tt.sound_events.death_water = "RTWaterDead"
tt.sound_events.water_splash = "SpecialMermaid"
tt.ui.click_rect = r(-30, -10, 60, 60)
tt.unit.hit_offset = v(0, 30)
tt.unit.marker_offset = v(0, ady(19))
tt.unit.mod_offset = v(0, ady(47))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = F_DRILL
tt.water.health_bar_offset = v(0, tt.health_bar.offset.y - 28)
tt.water.hit_offset = v(0, 7)
tt.water.mod_offset = v(0, ady(33))
tt.water.speed_factor = 1.43
tt.water.vis_bans = bor(F_BLOCK, F_SKELETON, F_DRILL)
tt = E.register_t(E, "enemy_greenfin", "enemy")

E.add_comps(E, tt, "melee", "water")

anchor_y = 0.185
image_y = 54
tt.enemy.gold = 20
tt.enemy.melee_slot = v(26, 0)
tt.enemy.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER)
tt.health.armor = 0
tt.health.hp_max = 450
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(47))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0071") or "info_portraits_enemies_0043"
tt.info.enc_icon = 44
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed_water.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 14
tt.melee.attacks[1].damage_min = 6
tt.melee.attacks[1].hit_time = fts(9)
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].animation = "netAttack"
tt.melee.attacks[2].cooldown = 8
tt.melee.attacks[2].hit_time = fts(9)
tt.melee.attacks[2].mod = "mod_greenfin_net"
tt.melee.attacks[2].vis_flags = bor(F_STUN, F_NET)
tt.motion.max_speed = 57.599999999999994
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_greenfin"
tt.sound_events.death_water = "RTWaterDead"
tt.sound_events.water_splash = "SpecialMermaid"
tt.unit.hit_offset = v(0, 20)
tt.unit.marker_offset = v(0, ady(9))
tt.unit.mod_offset = v(2, ady(23))
tt.water.health_bar_offset = v(0, tt.health_bar.offset.y - 15)
tt.water.hit_offset = v(0, 5)
tt.water.mod_offset = v(2, ady(20))
tt.water.speed_factor = 1.2
tt = E.register_t(E, "enemy_deviltide", "enemy_greenfin")
tt.enemy.gold = 20
tt.health.armor = 0.5
tt.health.hp_max = 500
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0072") or "info_portraits_enemies_0044"
tt.info.enc_icon = 47
tt.melee.attacks[1].damage_max = 20
tt.melee.attacks[1].damage_min = 10
tt.motion.max_speed = 49.92
tt.render.sprites[1].prefix = "enemy_deviltide"
tt.sound_events.water_splash = "SpecialMermaid"
tt.water.speed_factor = 1.15
tt = E.register_t(E, "enemy_deviltide_shark", "enemy")
anchor_y = 0.19230769230769232
image_y = 104
tt.enemy.gold = 20
tt.enemy.valid_terrains = TERRAIN_WATER
tt.health.armor = 0.5
tt.health.hp_max = 500
tt.health_bar.offset = v(0, 39)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts.enemy_deviltide_shark.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0072") or "info_portraits_enemies_0058"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_deviltide_shark.update
tt.motion.max_speed = 84.48
tt.payload = "enemy_deviltide"
tt.payload_time = fts(24)
tt.render.sprites[1].anchor = v(0.44660194174757284, 0.19230769230769232)
tt.render.sprites[1].prefix = "enemy_deviltide_shark"
tt.sound_events.death_water = "RTWaterDead"
tt.sound_events.deploy = "RTWaterExplosion"
tt.ui.click_rect = r(-30, -10, 60, 40)
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 15)
tt.unit.mod_offset = v(0, 15)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_BLOCK, F_SKELETON)
tt.vis.flags = bor(tt.vis.flags, F_WATER)
tt = E.register_t(E, "enemy_blacksurge", "enemy")

E.add_comps(E, tt, "melee", "timed_attacks", "water", "regen")

anchor_y = 0.31
image_y = 74
tt.enemy.gold = 50
tt.enemy.melee_slot = v(35, 0)
tt.enemy.valid_terrains = bor(TERRAIN_LAND, TERRAIN_WATER)
tt.health.armor = 0.7
tt.health.hp_max = 1200
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(72))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.hidden = {
	cooldown = 20,
	duration = 12,
	nodeslimit = 20,
	trigger_health_factor = 0.3,
	vis_bans = bor(F_BLOCK, F_STUN, F_BLOOD, F_TWISTER, F_LETHAL),
	sprite_suffix = "_hidden",
	ts = 0
}
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0075") or "info_portraits_enemies_0047"
tt.info.enc_icon = 45
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_blacksurge.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(28)
tt.motion.max_speed = 19.2
tt.regen.cooldown = 0.1
tt.regen.duration = 3
tt.regen.health = 20
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_blacksurge"
tt.sound_events.death_water = "RTWaterDead"
tt.sound_events.water_splash = "SpecialMermaid"
tt.timed_attacks.list[1] = E.clone_c(E, "mod_attack")
tt.timed_attacks.list[1].animation = "curse"
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].max_count = 2
tt.timed_attacks.list[1].mod = "mod_blacksurge"
tt.timed_attacks.list[1].range = 200
tt.timed_attacks.list[1].shoot_time = fts(26)
tt.timed_attacks.list[1].sound = "RTBlacksurgeHoldTower"
tt.ui.click_rect = r(-30, -10, 60, 55)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, ady(23))
tt.unit.mod_offset = v(0, ady(42))
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt.water.health_bar_offset = v(0, tt.health_bar.offset.y - 8)
tt.water.hit_offset = v(0, 15)
tt.water.mod_offset = v(0, ady(37))
tt.water.speed_factor = 2
tt = E.register_t(E, "enemy_bat", "enemy")

E.add_comps(E, tt, "moon", "auras")

anchor_y = 0
image_y = 108
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "moon_enemy_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 10
tt.enemy.melee_slot = v(0, 0)
tt.health.hp_max = 75
tt.health_bar.offset = v(0, ady(90))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0088") or "info_portraits_enemies_0052"
tt.info.enc_icon = 49
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.moon.speed_factor = 1.5
tt.motion.max_speed = FPS*2.56
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_bat"
tt.render.sprites[1].angles_flip_vertical = {
	walk = true
}
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.sound_events.death = "DeathPuff"
tt.ui.click_rect = r(-20, 40, 40, 50)
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 68)
tt.unit.marker_offset = v(0, ady(0))
tt.unit.mod_offset = v(0, ady(68))
tt.unit.show_blood_pool = false
tt.vis.bans = bor(F_BLOCK, F_SKELETON, F_EAT)
tt.vis.flags = bor(F_ENEMY, F_FLYING)
tt = E.register_t(E, "enemy_ghost", "enemy")

E.add_comps(E, tt, "auras")

anchor_y = 0.08333333333333333
image_y = 48
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "ghost_sound_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 10
tt.enemy.melee_slot = v(24, 0)
tt.health.armor = 0
tt.health.hp_max = 100
tt.health.immune_to = bor(DAMAGE_PHYSICAL, DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL)
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 37)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0080") or "info_portraits_enemies_0063"
tt.info.enc_icon = 52
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_passive.update
tt.motion.max_speed = FPS*1.1520000000000001
tt.render.sprites[1].prefix = "enemy_ghost"
tt.render.sprites[1].anchor.y = anchor_y
tt.unit.blood_color = BLOOD_NONE
tt.unit.show_blood_pool = false
tt.unit.can_explode = false
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 19)
tt.unit.marker_offset = v(0, ady(0))
tt.unit.mod_offset = v(0, 19)
tt.sound_events.death = nil
tt.sound_events.insert = "HWGhosts"
tt.vis.bans = bor(F_SKELETON, F_BLOOD, F_DRILL, F_POISON, F_STUN, F_BLOCK)
tt = E.register_t(E, "ghost_sound_aura", "aura")
tt.loop_delay = fts(70)
tt.sound_name = "HWGhosts"
tt.main_script.update = scripts.loop_sound_aura.update
tt = E.register_t(E, "enemy_ghoul", "enemy")

E.add_comps(E, tt, "melee", "moon", "auras")

anchor_y = 0.07894736842105263
image_y = 60
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "moon_enemy_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 20
tt.enemy.melee_slot = v(20, 0)
tt.cannibalize = {
	extra_hp = 50,
	hps = FPS*3,
	max_hp = 600
}
tt.health.armor = 0.2
tt.health.hp_max = 400
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 33)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0082") or "info_portraits_enemies_0049"
tt.info.enc_icon = 56
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_cannibal.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 25
tt.melee.attacks[1].damage_min = 15
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[1].sound = "HWZombieAmbient"
tt.melee.attacks[1].pop = {
	"pop_sok",
	"pop_kapow"
}
tt.moon.damage_factor = 1.5
tt.motion.max_speed = FPS*2.3040000000000003
tt.render.sprites[1].prefix = "enemy_ghoul"
tt.render.sprites[1].anchor.y = anchor_y
tt.unit.hit_offset = v(0, 15)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 15)
tt.sound_events.insert = "HWZombieAmbient"
tt.sound_events.cannibalize = "CanibalEating"
tt = E.register_t(E, "enemy_phantom_warrior", "enemy")

E.add_comps(E, tt, "melee", "auras")

image_y = 88
anchor_y = 0.25
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "phantom_warrior_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 90
tt.enemy.melee_slot = v(27, 0)
tt.health.armor = 0
tt.health.hp_max = 1000
tt.health.immune_to = bor(DAMAGE_PHYSICAL, DAMAGE_EXPLOSION, DAMAGE_ELECTRICAL)
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 56)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0083") or "info_portraits_enemies_0062"
tt.info.enc_icon = 51
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 90
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*0.8959999999999999
tt.render.sprites[1].prefix = "enemy_phantom_warrior"
tt.render.sprites[1].anchor.y = anchor_y
tt.sound_events.death = nil
tt.ui.click_rect = r(-20, -5, 40, 55)
tt.unit.blood_color = BLOOD_NONE
tt.unit.show_blood_pool = false
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 21)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 21)
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.flags = bor(tt.vis.flags, F_SPELLCASTER)
tt.vis.bans = bor(F_SKELETON, F_BLOOD, F_DRILL, F_POISON)
tt = E.register_t(E, "phantom_warrior_aura", "aura")
tt.aura.banned_templates = {
	"soldier_mecha",
	"soldier_death_rider",
	"soldier_skeleton",
	"soldier_skeleton_knight",
	"hero_dracolich",
	"soldier_dracolich_golem",
	"soldier_elemental"
}
tt.aura.cycle_time = fts(3)
tt.aura.duration = -1
tt.aura.radius = 128
tt.aura.vis_bans = bor(F_ENEMY, F_BOSS)
tt.aura.vis_flags = F_MOD
tt.aura.damage_min = 3
tt.aura.damage_max = 3
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.hero_damage_factor = 0.3333333333333333
tt.main_script.update = scripts.phantom_warrior_aura.update
tt = E.register_t(E, "enemy_elvira", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.1
image_y = 50
tt.enemy.gold = 15
tt.enemy.melee_slot = v(18, 0)
tt.health.armor = 0
tt.health.hp_max = 1000
tt.health.magic_armor = 0.9
tt.health_bar.offset = v(0, 43)
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0091") or "info_portraits_enemies_0066"
tt.info.enc_icon = 58
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 40
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].hit_time = fts(12)
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].cooldown = 8
tt.melee.attacks[2].damage_max = 0
tt.melee.attacks[2].damage_min = 0
tt.melee.attacks[2].hit_time = fts(3)
tt.melee.attacks[2].mod = "mod_elvira_lifesteal"
tt.melee.attacks[2].animation = "lifesteal"
tt.melee.attacks[2].health_trigger_factor = 0.7
tt.melee.attacks[2].fn_can = scripts.enemy_elvira.can_lifesteal
tt.motion.max_speed = FPS*1.1520000000000001
tt.render.sprites[1].prefix = "enemy_elvira"
tt.render.sprites[1].anchor.y = anchor_y
tt.sound_events.death = nil
tt.ui.click_rect = r(-20, -5, 40, 50)
tt.unit.blood_color = BLOOD_RED
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 16)
tt.unit.hide_after_death = true
tt = E.register_t(E, "elvira_bat", "decal_scripted")

E.add_comps(E, tt, "nav_path", "motion", "spawner")

anchor_y = 0.1
image_y = 50
tt.main_script.update = scripts.elvira_bat.update
tt.motion.max_speed = FPS*1.92
tt.render.sprites[1].prefix = "elvira_bat"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].name = "decal_flying_shadow"
tt.render.sprites[2].offset = v(0, 0)
tt.payload = "enemy_elvira"
tt = E.register_t(E, "mod_elvira_lifesteal", "modifier")

E.add_comps(E, tt, "moon")

tt.heal_hp = 300
tt.damage = 150
tt.main_script.insert = scripts.mod_elvira_lifesteal.insert
tt.moon.heal_hp_factor = 2
tt.moon.damage_factor = 1.5
tt = E.register_t(E, "enemy_headless_horseman", "enemy")

E.add_comps(E, tt, "melee", "ranged", "lifespan", "idle_flip", "auras")

image_y = 104
anchor_y = 0.26
tt.auras.list[1] = E.clone_c(E, "aura_attack")
tt.auras.list[1].name = "headless_horseman_spawner_aura"
tt.auras.list[1].cooldown = 0
tt.enemy.gold = 200
tt.enemy.lives_cost = 0
tt.enemy.melee_slot = v(36, 0)
tt.health.armor = 0
tt.health.hp_max = 500
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, 65)
tt.idle_flip.cooldown = 3
tt.idle_flip.last_dir = -1
tt.idle_flip.walk_dist = 30
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0089") or "info_portraits_enemies_0064"
tt.lifespan.duration = 15
tt.lifespan.animation_in = "rise"
tt.lifespan.animation_out = "death"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_headless_horseman.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 90
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*4.48
tt.ranged.attacks[1].bullet = "headless_horseman_pumpkin"
tt.ranged.attacks[1].bullet_start_offset = {
	v(20, 65)
}
tt.ranged.attacks[1].cooldown = 4
tt.ranged.attacks[1].min_range = 40
tt.ranged.attacks[1].max_range = 190
tt.ranged.attacks[1].shoot_time = fts(28)
tt.render.sprites[1].prefix = "enemy_headless_horseman"
tt.render.sprites[1].anchor.y = anchor_y
tt.sound_events.insert = {
	"HWHeadlessHorsemanLaugh",
	"HWHeadlessHorsemanEntry"
}
tt.sound_events.death = nil
tt.ui.click_rect = r(-20, -5, 40, 60)
tt.unit.blood_color = BLOOD_NONE
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 35)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 35)
tt.unit.hide_after_death = true
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt.vis.bans = bor(F_SKELETON, F_BLOOD)
tt = E.register_t(E, "headless_horseman_pumpkin", "bomb")
tt.bullet.damage_min = 50
tt.bullet.damage_max = 70
tt.bullet.damage_radius = 40
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.flight_time = fts(20)
tt.render.sprites[1].name = "HalloweenRider_bomb"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.sound_events.insert = nil
tt = E.register_t(E, "headless_horseman_spawner_aura", "aura")

E.add_comps(E, tt, "spawner")

tt.main_script.update = scripts.headless_horseman_spawner_aura.update
tt.spawner.cycle_time = 10
tt = E.register_t(E, "eb_efreeti", "boss")

E.add_comps(E, tt, "attacks", "tween")

anchor_y = 0.1
image_y = 198
tt.attacks.cooldown = 7
tt.attacks.list[1] = E.clone_c(E, "custom_attack")
tt.attacks.list[1].animation = "attack"
tt.attacks.list[1].chance = 0.2
tt.attacks.list[1].hit_time = fts(13)
tt.attacks.list[1].max_count = 3
tt.attacks.list[1].max_range = 320
tt.attacks.list[1].min_range = 76.8
tt.attacks.list[2] = E.clone_c(E, "custom_attack")
tt.attacks.list[2].animation = "attack"
tt.attacks.list[2].hit_time = fts(13)
tt.attacks.list[2].max_count = 10
tt.attacks.list[2].max_range = 96
tt.attacks.list[2].min_range = 0
tt.attacks.list[3] = E.clone_c(E, "mod_attack")
tt.attacks.list[3].animation = "attack_sand"
tt.attacks.list[3].chance = 0.3
tt.attacks.list[3].max_count = 3
tt.attacks.list[3].max_range = 192
tt.attacks.list[3].mod = "mod_efreeti"
tt.attacks.list[3].shoot_time = fts(19)
tt.attacks.list[4] = E.clone_c(E, "spawn_attack")
tt.attacks.list[4].animation = "attack"
tt.attacks.list[4].coords = {
	v(816, 430),
	v(415, 490),
	v(270, 340),
	v(690, 290)
}
tt.attacks.list[4].entity = "enemy_efreeti_small"
tt.attacks.list[4].health_threshold = 3000
tt.attacks.list[4].max_count = 2
tt.attacks.list[4].spawn_time = fts(13)
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(50, 0)
tt.health.dead_lifetime = fts(200)
tt.health.hp_max = {
	7000,
	8000,
	8000
}
tt.health_bar.offset = v(0, ady(195))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_efreeti.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0040") or "info_portraits_enemies_0015"
tt.info.enc_icon = 14
tt.main_script.insert = scripts.eb_efreeti.insert
tt.main_script.update = scripts.eb_efreeti.update
tt.motion.max_speed = FPS*0.44799999999999995
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].loop_forced = true
tt.render.sprites[1].prefix = "eb_efreeti_legs"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[2].prefix = "eb_efreeti"
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].anchor.y = anchor_y
tt.render.sprites[3].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[3].loop_forced = true
tt.render.sprites[3].prefix = "eb_efreeti_belt"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		1.5,
		255
	}
}
tt.tween.props[1].sprite_id = 1
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		1.5,
		255
	}
}
tt.tween.props[2].sprite_id = 2
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		0
	},
	{
		1.5,
		255
	}
}
tt.tween.props[3].sprite_id = 3
tt.tween.remove = false
tt.ui.click_rect = r(-40, -5, 80, 160)
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 103)
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(0, ady(104))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = F_ALL
tt.vis.bans_in_battlefield = bor(F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.sound_events.insert = "MusicBossFight"
tt.sound_events.laugh = "BossEfreetiLaugh"
tt.sound_events.death = "BossEfreetiDeath"
tt.sound_events.desintegrate = "BossEfreetiSnap"
tt.sound_events.polymorph = "BossEfreetiSnap"
tt.sound_events.spawn = "BossEfreetiSnap"
tt.sound_events.sand = "BossEfreetiClap"
tt = E.register_t(E, "mod_efreeti", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.update = scripts.mod_tower_block.update
tt.modifier.duration = 10
tt.modifier.hide_tower = true
tt.render.sprites[1].anchor.y = 0.17
tt.render.sprites[1].draw_order = 10
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].name = "start"
tt.render.sprites[1].prefix = "efreeti_sandblock_tower"
tt.sound_events.finish = "BossEfreetiTowerReleased"
tt = E.register_t(E, "eb_gorilla", "boss")

E.add_comps(E, tt, "melee", "attacks", "idle_flip")

anchor_y = 0.21
image_y = 172
tt.jump_down_advance_nodes = 10
tt.nodes_limit = 30
tt.on_tower_time = 9
tt.tower_pos_left = nil
tt.tower_pos_right = nil
tt.attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.attacks.list[1].animation = "call"
tt.attacks.list[1].cooldown = 8
tt.attacks.list[1].entity = "gorilla_small_liana"
tt.attacks.list[1].max_count = 8
tt.attacks.list[1].sound = "BossMonkeyChestPounding"
tt.attacks.list[1].spawn_node_ranges = {
	{
		{
			62,
			113
		},
		{
			130,
			150
		}
	},
	{
		{
			60,
			105
		},
		{
			120,
			140
		}
	}
}
tt.attacks.list[2] = E.clone_c(E, "custom_attack")
tt.attacks.list[2].cooldown = 10
tt.attacks.list[2].points = 500
tt.attacks.list[2].sound = "EnemyHealing"
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].animation = "throw_barrel"
tt.attacks.list[3].bullet = "gorilla_boss_barrel"
tt.attacks.list[3].bullet_start_offset = {
	v(60, 70)
}
tt.attacks.list[3].cooldown = 2
tt.attacks.list[3].max_range = 448
tt.attacks.list[3].min_range = 50
tt.attacks.list[3].shoot_time = fts(9)
tt.attacks.list[3].vis_bans = bor(F_FLYING, F_ENEMY)
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(50, 0)
tt.health.dead_lifetime = fts(300)
tt.health.hp_max = {
	8000,
	12000,
	12000
}
tt.health_bar.offset = v(0, ady(160))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.idle_flip.chance = 1
tt.idle_flip.cooldown = 5
tt.info.fn = scripts.eb_gorilla.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0068") or "info_portraits_enemies_0039"
tt.info.enc_icon = 38
tt.main_script.insert = scripts.eb_gorilla.insert
tt.main_script.update = scripts.eb_gorilla.update
tt.melee.attacks[1] = E.clone_c(E, "area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 500
tt.melee.attacks[1].damage_min = 200
tt.melee.attacks[1].damage_radius = 44.800000000000004
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_decal = "decal_ground_hit"
tt.melee.attacks[1].hit_fx = "fx_ground_hit"
tt.melee.attacks[1].hit_offset = v(50, 0)
tt.melee.attacks[1].hit_time = fts(17)
tt.melee.attacks[1].sound = "BossMonkeySmashGround"
tt.motion.max_speed = FPS*0.64
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_gorilla"
tt.sound_events.death = "BossMonkeyDeath"
tt.sound_events.insert = "MusicBossFight"
tt.sound_events.jump_to_tower = "BossMonkeyJumpToTotem"
tt.sound_events.drop_from_sky = "BossMonkeyFallSpawn"
tt.unit.hit_offset = v(0, 45)
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(0, ady(73))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_SKELETON, F_BLOOD)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt = E.register_t(E, "fx_gorilla_boss_heal", "fx")
tt.render.sprites[1].name = "fx_gorilla_boss_heal"
tt.render.sprites[1].anchor.y = 0.21
tt = E.register_t(E, "fx_gorilla_boss_jump_smoke", "fx")
tt.render.sprites[1].name = "fx_gorilla_boss_jump_smoke"
tt.render.sprites[1].anchor.y = 0.12
tt = E.register_t(E, "gorilla_boss_barrel", "bomb")
tt.bullet.flight_time_base = fts(30)
tt.bullet.flight_time_factor = fts(0.025)
tt.bullet.warp_time = 2
tt.bullet.damage_min = 100
tt.bullet.damage_max = 150
tt.bullet.damage_radius = 51.2
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_decay_random = true
tt.bullet.pop = nil
tt.render.sprites[1].name = "CanibalBoos_Proy"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt = E.register_t(E, "enemy_gorilla_small", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.21
image_y = 68
tt.enemy.gold = 50
tt.enemy.lives_cost = 2
tt.enemy.melee_slot = v(26, 0)
tt.health.armor = 0
tt.health.hp_max = 1200
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(64))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0067") or "info_portraits_enemies_0038"
tt.info.enc_icon = 39
tt.main_script.insert = scripts.enemy_gorilla_small.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 100
tt.melee.attacks[1].damage_min = 50
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.28
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "enemy_gorilla_small"
tt.render.sprites[1].angles_flip_vertical = {
	walk = true
}
tt.unit.hit_offset = v(0, 14)
tt.unit.marker_offset = v(0, ady(13))
tt.unit.mod_offset = v(0, ady(28))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.sound_events.death = "DeathBig"
tt = E.register_t(E, "gorilla_small_liana", "decal_scripted")

E.add_comps(E, tt, "sound_events")

tt.main_script.update = scripts.gorilla_small_liana.update
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].name = "gorilla_small_liana"
tt.spawn_name = "gorilla_small_falling"
tt.spawn_offset = {
	v(-130, 38),
	v(130, 38)
}
tt.spawn_time = fts(8)
tt.spawn_dest = nil
tt.sound_events.insert = "BossMonkeyMonkeysScreams"
tt = E.register_t(E, "gorilla_small_falling", "bomb")
tt.render.sprites[1].name = "CanibalBoos_Offspring_0030"
tt.bullet.flight_time = fts(27)
tt.bullet.vis_bans = F_ALL
tt.bullet.hit_fx = "enemy_gorilla_small"
tt.bullet.hit_decal = nil
tt.bullet.pop = nil
tt.bullet.hide_radius = nil
tt.bullet.rotation_speed = nil
tt.sound_events.insert = nil
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt = E.register_t(E, "eb_umbra", "boss")

E.add_comps(E, tt, "melee", "attacks")

anchor_y = 0.18
image_y = 176
tt.attacks.list[1] = E.clone_c(E, "spawn_attack")
tt.attacks.list[1].animation = "open_portals"
tt.attacks.list[1].cooldowns = {
	at_home = {
		3,
		3,
		1,
		1,
		0,
		0,
		0,
		2,
		2,
		2
	},
	on_battlefield = {
		0,
		0,
		0,
		0,
		3,
		3,
		3,
		3,
		3,
		3
	}
}
tt.attacks.list[1].cooldown = nil
tt.attacks.list[1].entity = "umbra_portal"
tt.attacks.list[1].nodes_left = {
	{
		np(1, 1, 53),
		np(2, 1, 53)
	},
	{
		np(1, 1, 85),
		np(2, 1, 85)
	}
}
tt.attacks.list[1].nodes_right = {
	{
		np(3, 1, 26),
		np(4, 1, 24)
	},
	{
		np(3, 1, 68),
		np(4, 1, 69)
	}
}
tt.attacks.list[1].count_min = 3
tt.attacks.list[1].add_per_missing_piece = 0.4
tt.attacks.list[2] = E.clone_c(E, "custom_attack")
tt.attacks.list[2].cooldowns = {
	at_home = {
		7,
		7,
		7,
		7,
		8,
		8,
		8,
		8,
		8,
		8
	},
	on_battlefield = {
		6,
		6,
		6,
		6,
		8,
		8,
		8,
		8,
		8,
		8
	}
}
tt.attacks.list[2].cooldown = nil
tt.attacks.list[2].max_side_jumps = 3
tt.attacks.list[2].nodes_battlefield = {
	np(5, 1, 48),
	np(2, 1, 69),
	np(3, 1, 51)
}
tt.attacks.list[3] = E.clone_c(E, "bullet_attack")
tt.attacks.list[3].animation = "eyes"
tt.attacks.list[3].bullet = "ray_umbra"
tt.attacks.list[3].bullet_start_offset = {
	v(-9, ady(109)),
	v(9, ady(109))
}
tt.attacks.list[3].cooldown = 2.5
tt.attacks.list[3].max_range = 192
tt.attacks.list[3].shoot_time = fts(17)
tt.attacks.list[3].vis_bans = bor(F_FLYING, F_ENEMY)
tt.attacks.list[3].sound = "FrontiersFinalBossRay"
tt.attacks.list[4] = table.deepclone(tt.attacks.list[3])
tt.attacks.list[4].inner_towers = {
	"3",
	"4",
	"5",
	"8",
	"11",
	"13"
}
tt.attacks.list[4].lower_towers = {
	"7",
	"9",
	"15",
	"16"
}
tt.attacks.list[4].cooldowns = {
	at_home = {
		2,
		2,
		0,
		0,
		1,
		1,
		1,
		0,
		0,
		0
	},
	on_battlefield = {
		1,
		2,
		2,
		2,
		0,
		0,
		0,
		0,
		0,
		0
	}
}
tt.attacks.list[4].bullet = "ray_umbra_tower"
tt.attacks.list[4].sound = "FrontiersFinalBossRayTower"
tt.attacks.list[5] = E.clone_c(E, "spawn_attack")
tt.attacks.list[5].entity = "enemy_umbra_piece_flying"
tt.attacks.list[5].payload_entity = "enemy_umbra_piece"
tt.attacks.list[5].start_offset_x = {
	-20,
	20
}
tt.attacks.list[5].start_offset_y = {
	60,
	80
}
tt.attacks.list[5].dest_pi = {
	5,
	6,
	7,
	8,
	9
}
tt.attacks.list[5].initial_ni = 20
tt.attacks.list[5].limit_ni = 50
tt.attacks.list[5].cooldown = 30
tt.attacks.list[5].callback_pieces = {
	7,
	4,
	2
}
tt.attacks.list[5].min_pieces_to_respawn = 3
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(25, 0)
tt.health.dead_lifetime = fts(1000)
tt.health.hp_max = {
	7000,
	9000,
	9999
}
tt.health_bar.offset = v(0, ady(166))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.health_bar.hidden = true
tt.info.fn = scripts.eb_umbra.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0070") or "info_portraits_enemies_0040"
tt.info.enc_icon = 40
tt.main_script.insert = scripts.eb_umbra.insert
tt.main_script.update = scripts.eb_umbra.update
tt.motion.max_speed = FPS*0.64
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "eb_umbra"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "eb_umbra"
tt.render.sprites[2].name = "eyes"
tt.render.sprites[2].hidden = true
tt.render.sprites[2].anchor.y = anchor_y
tt.taunt = {
	cooldown = 4,
	format = "FINAL_BOSS_TAUNT_%04d",
	start_idx = 3,
	end_idx = 25,
	left_pos = v(331, 677),
	right_pos = v(696, 677),
	duration = 4,
	ts = 0
}
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 55)
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(0, ady(80))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans_at_home = bor(F_RANGED, F_SKELETON, F_MOD, F_BLOCK, F_LETHAL, F_FREEZE)
tt.vis.bans_in_battlefield = bor(F_SKELETON, F_BLOOD, F_POISON, F_LETHAL, F_FREEZE)
tt.vis.bans_in_pieces = F_ALL
tt.vis.bans = tt.vis.bans_at_home
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt = E.register_t(E, "decal_umbra_shoutbox", "decal_tween")

E.add_comps(E, tt, "texts", "timed")

tt.render.sprites[1].name = "finalBoss_tauntBox"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[2].offset = v(20, 2)
tt.texts.list[1].text = "Hello world"
tt.texts.list[1].size = v(176, 70)
tt.texts.list[1].font_name = "body_bold"
tt.texts.list[1].font_sizes = {
	24,
	23,
	18
}
tt.texts.list[1].color = {
	94,
	217,
	229
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
tt.tween.remove = false
tt = E.register_t(E, "ray_umbra", "bullet")
tt.image_width = 190
tt.main_script.update = scripts.ray_enemy.update
tt.render.sprites[1].name = "ray_umbra"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min = 100
tt.bullet.damage_max = 150
tt.bullet.damage_radius = 64
tt.bullet.max_track_distance = 50
tt.bullet.vis_bans = bor(F_ENEMY, F_FLYING)
tt.bullet.hit_time = fts(7)
tt.bullet.hit_fx = "fx_ray_umbra_explosion"
tt = E.register_t(E, "ray_umbra_tower", "ray_umbra")
tt.bullet.damage_radius = 0
tt.bullet.damage_type = DAMAGE_NONE
tt.bullet.hit_fx = nil
tt.bullet.mod = "mod_umbra"
tt = E.register_t(E, "fx_ray_umbra_explosion", "fx")
tt.render.sprites[1].name = "ray_umbra_explosion"
tt = E.register_t(E, "fx_ray_umbra_explosion_smoke", "fx")
tt.render.sprites[1].name = "ray_umbra_explosion_smoke"
tt = E.register_t(E, "fx_umbra_death_blast", "fx")
tt.render.sprites[1].prefix = "umbra_death_blast"
tt.render.sprites[1].name = "short"
tt.render.sprites[1].anchor.y = 0.18
tt = E.register_t(E, "mod_umbra", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.update = scripts.mod_tower_remove.update
tt.modifier.hide_time = fts(22)
tt.render.sprites[1].anchor.y = 0.19
tt.render.sprites[1].z = Z_OBJECTS + 1
tt.render.sprites[1].name = "umbra_tower_remove"
tt = E.register_t(E, "umbra_portal", "decal_scripted")

E.add_comps(E, tt, "render", "spawner")

tt.main_script.update = scripts.umbra_portal.update
tt.render.sprites[1].prefix = "umbra_portal"
tt.render.sprites[1].z = Z_DECALS
tt.spawner.count = 0
tt.spawner.cycle_time = fts(6)
tt.spawner.entity = "enemy_umbra_minion"
tt.spawner.animation_start = "start"
tt.spawner.animation_loop = "loop"
tt.spawner.animation_end = "end"
tt.spawner.ni_var = 3
tt.spawner.spawn_fx = "fx_umbra_minion_spawn"
tt = E.register_t(E, "fx_umbra_minion_spawn", "fx")
tt.render.sprites[1].name = "umbra_minion_spawn"
tt.render.sprites[1].anchor.y = 0.19
tt = E.register_t(E, "enemy_umbra_minion", "enemy")

E.add_comps(E, tt, "melee")

anchor_y = 0.19
image_y = 66
tt.enemy.gold = 5
tt.enemy.melee_slot = v(26, 0)
tt.health.armor = 0
tt.health.hp_max = 450
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(62))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0069") or "info_portraits_enemies_0055"
tt.info.enc_icon = 41
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 170
tt.melee.attacks[1].damage_min = 120
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.024
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "enemy_umbra_minion"
tt.sound_events.death = "DeathPuff"
tt.unit.can_explode = false
tt.unit.blood_color = BLOOD_GRAY
tt.unit.hit_offset = v(0, 16)
tt.unit.marker_offset = v(0, ady(13))
tt.unit.mod_offset = v(0, ady(30))
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_SKELETON)
tt = E.register_t(E, "enemy_umbra_piece", "enemy")

E.add_comps(E, tt, "melee", "timed")

anchor_y = 0.21
image_y = 70
tt.enemy.gold = 90
tt.enemy.melee_slot = v(30, 0)
tt.health.armor = 0
tt.health.hp_max = 1000
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(59))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0069") or "info_portraits_enemies_0056"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_umbra_piece.update
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 50
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.28
tt.motion.max_speed_called = FPS*6.656000000000001
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "enemy_umbra_piece"
tt.sound_events.death = "DeathPuff"
tt.sound_events.raise = "FrontiersFinalBossPiecesRespawn"
tt.timed.disabled = true
tt.ui.click_rect = r(-20, -5, 40, 50)
tt.unit.blood_color = BLOOD_GRAY
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 24)
tt.unit.marker_offset = v(0, ady(14))
tt.unit.mod_offset = v(0, ady(33))
tt.unit.show_blood_pool = false
tt.unit.hide_after_death = true
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = F_ALL
tt.vis.bans_walking = bor(F_SKELETON, F_BLOOD, F_EAT, F_POISON, F_TWISTER, F_POLYMORPH, F_TELEPORT)
tt.piece_respawn_delay = fts(35) + 3
tt.piece_respawn_delay_repeating = fts(35)
tt = E.register_t(E, "enemy_umbra_piece_flying", "bomb")
tt.render.sprites[1].name = "enemy_umbra_piece_flying"
tt.render.sprites[1].animated = true
tt.render.sprites[1].loop = false
tt.bullet.flight_time = fts(20)
tt.bullet.vis_bans = F_ALL
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = nil
tt.bullet.pop = nil
tt.bullet.rotation_speed = nil
tt.bullet.hide_radius = nil
tt.bullet.align_with_trajectory = true
tt.sound_events.insert = nil
tt.sound_events.hit = nil
tt.sound_events.hit_water = nil
tt = E.register_t(E, "fx_umbra_white_circle", "decal_tween")
tt.render.sprites[1].name = "white_explosion"
tt.render.sprites[1].animated = false
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_GUI - 2
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(0.3, 0.3)
	},
	{
		0.6,
		v(20, 20)
	}
}
tt = E.register_t(E, "umbra_crystals", "decal_scripted")
tt.render.sprites[1].prefix = "umbra_crystals"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS - 1
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "umbra_crystals_crack1"
tt.render.sprites[2].hidden = true
tt.render.sprites[2].loop = false
tt.render.sprites[3] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[3].name = "umbra_crystals_crack2"
tt.render.sprites[4] = table.deepclone(tt.render.sprites[2])
tt.render.sprites[4].name = "umbra_crystals_crack3"
tt.main_script.update = scripts.decal_umbra_crystals.update
tt = E.register_t(E, "umbra_crystals_broken", "decal")
tt.render.sprites[1].name = "finalBoss_spawn_0108"
tt.render.sprites[1].animated = false
tt = E.register_t(E, "umbra_crystals_piece", "decal_tween")
tt.render.sprites[1].name = "umbra_crystals_piece"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_OBJECTS
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(21),
		255
	},
	{
		fts(21) + 1,
		0
	}
}
tt = E.register_t(E, "umbra_guy", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.main_script.update = scripts.umbra_guy.update
tt.render.sprites[1].prefix = "umbra_guy"
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "ray_umbra_guy"
tt.attacks.list[1].cooldown = 40
tt.attacks.list[1].vis_bans = bor(F_FLYING, F_ENEMY)
tt.attacks.list[1].shoot_time = fts(19)
tt.attacks.list[1].max_range = 300.16
tt.attacks.list[1].bullet_start_offset = v(-17, 41)
tt.taunt = {
	cooldown = 20,
	format = "FINAL_BOSS_GUY_TAUNT_%04d",
	normal_idx = {
		3,
		25
	},
	attack_idx = {
		30,
		34
	},
	lost_life_idx = {
		26,
		29
	},
	normal_pos = v(579, 655),
	death_pos = v(656, 610),
	duration = 4,
	attack_duration = 1.25,
	shoutbox = "decal_umbra_guy_shoutbox",
	ts = 0
}
tt = E.register_t(E, "umbra_guy_force_field", "decal_tween")
tt.render.sprites[1].name = "finalBoss_guy_forceShield_0013"
tt.render.sprites[1].animated = false
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		0.25,
		v(0.92, 0.92)
	},
	{
		0.5,
		v(1, 1)
	}
}
tt.tween.props[1].loop = true
tt = E.register_t(E, "ray_umbra_guy", "bullet")
tt.image_width = 238
tt.main_script.update = scripts.ray_enemy.update
tt.render.sprites[1].name = "ray_umbra_guy"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor = v(0, 0.5)
tt.bullet.damage_type = DAMAGE_TRUE
tt.bullet.damage_min = 200
tt.bullet.damage_max = 400
tt.bullet.damage_radius = 60.160000000000004
tt.bullet.max_track_distance = 50
tt.bullet.vis_bans = bor(F_ENEMY, F_FLYING)
tt.bullet.hit_time = fts(7)
tt.bullet.hit_fx = "fx_ray_umbra_guy_explosion"
tt.sound_events.insert = "TeslaAttack"
tt = E.register_t(E, "fx_ray_umbra_guy_explosion", "fx")
tt.render.sprites[1].name = "ray_umbra_guy_explosion"
tt = E.register_t(E, "decal_umbra_guy_shoutbox", "decal_tween")

E.add_comps(E, tt, "texts", "timed")

tt.render.sprites[1].name = "finalBoss_GuyTauntBox"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[2].offset = v(7, 15)
tt.texts.list[1].text = "Hello world"
tt.texts.list[1].size = v(168, 60)
tt.texts.list[1].font_name = "body_bold"
tt.texts.list[1].font_size = 20
tt.texts.list[1].color = {
	255,
	145,
	114
}
tt.texts.list[1].line_heights = {
	0.8,
	0.8
}
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
tt.tween.remove = false

E.set_template(E, "user_power_1", E.get_template(E, "power_fireball_control"))
E.set_template(E, "user_power_2", E.get_template(E, "power_reinforcements_control"))

tt = E.register_t(E, "decal_stage01_boss", "decal")
tt.render.sprites[1].name = "decal_stage01_boss"
tt.render.sprites[1].anchor.y = 0
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -20
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "Stage1_BossShadow"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[2].anchor.y = 0
tt = E.register_t(E, "decal_stage01_shoutbox", "decal")

E.add_comps(E, tt, "texts")

tt.render.sprites[1].name = "decal_stage01_shoutbox"
tt.render.sprites[1].z = Z_BULLETS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_BULLETS
tt.render.sprites[2].offset = v(6, i18n.cjk(i18n, 0, 0, -3, 0) + 12)
tt.texts.list[1].text = "Hello world"
tt.texts.list[1].size = v(160, 48)
tt.texts.list[1].font_name = "body_bold"
tt.texts.list[1].font_size = 18
tt.texts.list[1].color = {
	255,
	142,
	117
}
tt.texts.list[1].line_height = i18n.cjk(i18n, 0.9, nil, 1, nil)
tt.texts.list[1].sprite_id = 2
tt.texts.list[1].fit_height = true
tt = E.register_t(E, "decal_stage01_tower_block", "decal")
tt.render.sprites[1].prefix = "decal_stage01_tower_block"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].offset.y = 40
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].draw_order = 100
tt = E.register_t(E, "decal_snake", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_snake"
tt.render.sprites[1].name = "play"
tt.delayed_play.min_delay = 15
tt.delayed_play.max_delay = 30
tt.delayed_play.idle_animation = nil
tt = E.register_t(E, "decal_chicken", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_chicken"
tt.delayed_play.min_delay = 2
tt.delayed_play.max_delay = 6
tt.delayed_play.flip_chance = 0.3
tt = E.register_t(E, "decal_stargate", "decal_delayed_click_play")
tt.render.sprites[1].prefix = "decal_stargate"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "Stage1.5_StargateOver"
tt.render.sprites[2].animated = false
tt.delayed_play.play_animation = nil
tt.delayed_play.clicked_sound = "SpecialStargate"
tt.delayed_play.required_clicks = 1
tt.ui.click_rect = r(-40, -45, 80, 90)
tt = E.register_t(E, "decal_frog", "decal_scripted")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].prefix = "decal_frog"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.main_script.update = scripts.decal_frog.update
tt.ui.can_click = true
tt.ui.click_rect = r(0, -10, 80, 35)
tt = E.register_t(E, "decal_bantha", "decal_scripted")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].prefix = "decal_bantha"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.main_script.update = scripts.decal_bantha.update
tt.ui.can_click = true
tt.ui.click_rect = r(-30, -20, 60, 40)
tt = E.register_t(E, "decal_tusken", "decal_scripted")

E.add_comps(E, tt, "bullet_attack")

tt.render.sprites[1].prefix = "decal_tusken"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.main_script.update = scripts.decal_tusken.update
tt.bullet_attack.max_range = 350
tt.bullet_attack.bullet = "bullet_tusken"
tt.bullet_attack.shoot_time = fts(2)
tt.bullet_attack.cooldown_min = 10
tt.bullet_attack.cooldown_max = 20
tt.bullet_attack.bullet_start_offset = v(3, 7)
tt = E.register_t(E, "bullet_tusken", "shotgun")
tt.bullet.damage_min = 100
tt.bullet.damage_max = 200
tt.bullet.min_speed = FPS*40
tt.bullet.max_speed = FPS*40
tt.bullet.hit_blood_fx = "fx_blood_splat"
tt.bullet.miss_fx = "fx_smoke_bullet"
tt = E.register_t(E, "sand_worm", "decal_scripted")

E.add_comps(E, tt, "area_attack")

tt.render.sprites[1].prefix = "sand_worm"
tt.render.sprites[1].name = "attack"
tt.render.sprites[1].anchor.y = 0.24
tt.render.sprites[1].draw_order = 2
tt.main_script.update = scripts.sand_worm.update
tt.area_attack.animation = "attack"
tt.area_attack.cooldown = 90
tt.area_attack.max_range = 64
tt.area_attack.max_count = 30
tt.area_attack.hit_time = 6
tt.area_attack.damage_type = DAMAGE_EAT
tt.area_attack.vis_flags = bor(F_EAT)
tt.area_attack.vis_bans = bor(F_FLYING)
tt = E.register_t(E, "fx_sand_worm_incoming", "decal_tween")
tt.render.sprites[1].anchor.y = 0.44
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "sand_worm_incoming"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.6,
		255
	}
}
tt.tween.remove = false
tt = E.register_t(E, "fx_sand_worm_out", "decal_tween")
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[1].name = "sandworm_decal_out"
tt.tween.props[1].keys = {
	{
		1,
		255
	},
	{
		3.5,
		0
	}
}
tt = E.register_t(E, "decal_ship_door", "decal")
tt.render.sprites[1].prefix = "decal_ship_door"
tt.render.sprites[1].name = "closed"
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = E.register_t(E, "decal_tucan", "decal_delayed_click_play")
tt.render.sprites[1].prefix = "decal_tucan"
tt.ui.click_rect = r(-20, -50, 40, 50)
tt.delayed_play.min_delay = 10
tt.delayed_play.max_delay = 60
tt.delayed_play.clicked_animation = "jump"
tt.delayed_play.play_animation = "jump"
tt.delayed_play.required_clicks = 2
tt = E.register_t(E, "decal_flying_parrot", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_parrot_1"
tt.render.sprites[1].name = "play"
tt.delayed_play.min_delay = 10
tt.delayed_play.max_delay = 30
tt.delayed_play.idle_animation = nil
tt = E.register_t(E, "decal_mermaid", "decal_scripted")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].prefix = "decal_mermaid"
tt.render.sprites[1].name = "enter"
tt.render.sprites[1].loop = false
tt.main_script.update = scripts.decal_mermaid.update
tt.ui.can_click = true
tt.ui.click_rect = r(0, -20, 40, 40)
tt = E.register_t(E, "decal_palm_tree", "decal_timed")
tt.timed.disabled = true
tt.render.sprites[1].prefix = "decal_palm_tree"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].sort_y_offset = -40
tt = E.register_t(E, "decal_palm_land", "decal_tween")
tt.pos = v(REF_W/2, REF_H/2)
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		0.4,
		0
	}
}
tt.tween.remove = true
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_BACKGROUND_COVERS
tt = E.register_t(E, "decal_lumberjack", "decal")
tt.render.sprites[1].prefix = "lumberjack"
tt.render.sprites[1].anchor.y = 0.19
tt.render.sprites[1].flip_x = true
tt.render.sprites[1].z = Z_OBJECTS
tt = E.register_t(E, "pirate_cannons", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.main_script.update = scripts.pirate_cannons.update
tt.render.sprites[1].prefix = "pirate_cannon_left"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "pirate_cannon_right"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].z = Z_OBJECTS_COVERS + 1
tt.render.sprites[2].offset = v(169, -65)
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].min_range = 100
tt.attacks.list[1].max_range = 600
tt.attacks.list[1].min_cooldown = 40
tt.attacks.list[1].max_cooldown = 60
tt.attacks.list[1].shoot_time = fts(29)
tt.attacks.list[1].max_error = 20
tt.attacks.list[1].min_error = 5
tt = E.register_t(E, "decal_pirate_cannon_target", "decal_tween")
tt.render.sprites[1].name = "Stage4_ShipCrosshair"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_DECALS
tt.tween.remove = true
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1.86, 1.86)
	},
	{
		fts(20),
		v(1.05, 1.05)
	},
	{
		fts(23),
		v(0.95, 0.95)
	},
	{
		fts(26),
		v(1.05, 1.05)
	},
	{
		fts(28),
		v(1, 1)
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		fts(20),
		255
	},
	{
		fts(74),
		255
	},
	{
		fts(78),
		0
	}
}
tt = E.register_t(E, "bomb_pirate_cannon", "bullet")
tt.render = nil
tt.main_script.update = scripts.bomb_pirate_cannon.update
tt.bullet.damage_min = 50
tt.bullet.damage_max = 100
tt.bullet.damage_radius = 67.2
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.hit_fx = "fx_explosion_small"
tt.bullet.hit_decal = "decal_bomb_crater"
tt.sound_events.hit = "BombExplosionSound"
tt = E.register_t(E, "tower_pirate_camp", "tower")

E.add_comps(E, tt, "user_selection", "attacks", "tween")

tt.tower.level = 1
tt.tower.type = "pirate_camp"
tt.tower.can_be_mod = false
tt.tower.can_hover = true
tt.tower.menu_offset = v(6, 20)
tt.tower.terrain_style = nil
tt.info.fn = scripts.tower_pirate_camp.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0016"
tt.main_script.update = scripts.tower_pirate_camp.update
tt.user_selection.can_select_point_fn = scripts.tower_pirate_camp.can_select_point
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].bullet = "bomb_pirate_camp"
tt.attacks.list[1].price = 25
tt.attacks.list[1].shots = 1
tt.attacks.list[1].max_error = 40
tt.attacks.list[1].min_error = 0
tt.attacks.list[2] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[2].price = 45
tt.attacks.list[2].shots = 2
tt.attacks.list[3] = table.deepclone(tt.attacks.list[1])
tt.attacks.list[3].price = 60
tt.attacks.list[3].shots = 3
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].name = "tower_pirate_camp_"
tt.render.sprites[1].animated = false
tt.render.sprites[1].offset = v(0, 26)
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "tower_pirate_camp_smoke"
tt.render.sprites[2].offset = v(5, 38)
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "tower_pirate_camp_sign_0001"
tt.render.sprites[3].animated = false
tt.render.sprites[3].offset = v(-2, 85)
tt.render.sprites[3].hidden = true
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "tower_pirate_camp_sign2_0001"
tt.render.sprites[4].animated = false
tt.render.sprites[4].offset = v(-2, 85)
tt.render.sprites[4].hidden = true
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].prefix = "tower_pirate_camp_cannon_1"
tt.render.sprites[5].pos = v(124, 597)
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].prefix = "tower_pirate_camp_cannon_2"
tt.render.sprites[6].pos = v(155, 610)
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].prefix = "tower_pirate_camp_cannon_3"
tt.render.sprites[7].pos = v(182, 626)
tt.render.sprites[8] = E.clone_c(E, "sprite")
tt.render.sprites[8].prefix = "decal_drinking_pirate"
tt.render.sprites[8].loop = false
tt.render.sprites[8].offset = v(29, 53)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].sprite_id = 3
tt.tween.props[1].keys = {
	{
		0,
		v(0.75, 0.75)
	},
	{
		fts(4),
		v(1.08, 1.08)
	},
	{
		fts(7),
		v(0.95, 0.95)
	},
	{
		fts(9),
		v(1, 1)
	},
	{
		fts(40),
		v(1, 1)
	},
	{
		fts(42),
		v(1.08, 1.08)
	},
	{
		fts(46),
		v(0.75, 0.75)
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].sprite_id = 3
tt.tween.props[2].keys = {
	{
		0,
		128
	},
	{
		fts(4),
		255
	},
	{
		fts(42),
		255
	},
	{
		fts(46),
		0
	}
}
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].keys = {
	{
		0,
		v(0.75, 0.75)
	},
	{
		fts(4),
		v(1.08, 1.08)
	},
	{
		fts(7),
		v(0.95, 0.95)
	},
	{
		fts(9),
		v(1, 1)
	},
	{
		fts(70),
		v(1, 1)
	},
	{
		fts(72),
		v(1.08, 1.08)
	},
	{
		fts(76),
		v(0.75, 0.75)
	}
}
tt.tween.props[3].sprite_id = 4
tt.tween.props[4] = E.clone_c(E, "tween_prop")
tt.tween.props[4].keys = {
	{
		0,
		128
	},
	{
		fts(4),
		255
	},
	{
		fts(72),
		255
	},
	{
		fts(76),
		0
	}
}
tt.tween.props[4].sprite_id = 4
tt = E.register_t(E, "fx_tower_pirate_camp_cannon_smoke", "fx")
tt.render.sprites[1].name = "tower_pirate_camp_cannon_smoke"
tt = E.register_t(E, "decal_tower_pirate_camp_target", "decal_tween")

E.add_comps(E, tt, "timed")

tt.render.sprites[1].name = "special_pirate_cannons_crosshair_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].anchor = v(0.5, 0.5)
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "special_pirate_cannons_crosshair_0002"
tt.render.sprites[2].animated = false
tt.render.sprites[2].anchor = v(0.5, 0.5)
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "special_pirate_cannons_crosshair_0002"
tt.render.sprites[3].animated = false
tt.render.sprites[3].anchor = v(0.5, 0.5)
tt.render.sprites[3].z = Z_DECALS
tt.timed.duration = fts(39)
tt.tween.remove = false
tt.tween.props[1].name = "scale"
tt.tween.props[1].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(5),
		v(1.05, 1.05)
	},
	{
		fts(10),
		v(1, 1)
	}
}
tt.tween.props[1].loop = true
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "alpha"
tt.tween.props[2].keys = {
	{
		0,
		191
	},
	{
		fts(5),
		170
	},
	{
		fts(10),
		191
	}
}
tt.tween.props[2].loop = true
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "scale"
tt.tween.props[3].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(20),
		v(1.6, 1.6)
	}
}
tt.tween.props[3].loop = true
tt.tween.props[3].sprite_id = 2
tt.tween.props[4] = E.clone_c(E, "tween_prop")
tt.tween.props[4].name = "alpha"
tt.tween.props[4].keys = {
	{
		0,
		255
	},
	{
		fts(20),
		0
	}
}
tt.tween.props[4].loop = true
tt.tween.props[4].sprite_id = 2
tt.tween.props[5] = E.clone_c(E, "tween_prop")
tt.tween.props[5].name = "scale"
tt.tween.props[5].keys = {
	{
		0,
		v(1, 1)
	},
	{
		fts(20),
		v(1.6, 1.6)
	}
}
tt.tween.props[5].loop = true
tt.tween.props[5].sprite_id = 3
tt.tween.props[5].time_offset = fts(10)
tt.tween.props[6] = E.clone_c(E, "tween_prop")
tt.tween.props[6].name = "alpha"
tt.tween.props[6].keys = {
	{
		0,
		255
	},
	{
		fts(20),
		0
	}
}
tt.tween.props[6].loop = true
tt.tween.props[6].sprite_id = 3
tt.tween.props[6].time_offset = fts(10)
tt = E.register_t(E, "bomb_pirate_camp", "bomb_pirate_cannon")
tt.bullet.damage_min = 60
tt.bullet.damage_max = 120
tt.bullet.damage_radius = 48
tt.bullet.damage_bans = bor(F_FRIEND)
tt.bullet.damage_type = DAMAGE_EXPLOSION
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.hit_fx = "fx_explosion_fragment"
tt = E.register_t(E, "decal_vulture", "decal_delayed_click_play")
tt.render.sprites[1].prefix = "decal_vulture"
tt.ui.click_rect = r(-20, -50, 40, 50)
tt.delayed_play.min_delay = 4
tt.delayed_play.max_delay = 10
tt.delayed_play.clicked_animation = "jump"
tt.delayed_play.play_animation = "scratch"
tt.delayed_play.required_clicks = 2
tt = E.register_t(E, "decal_camel", "decal_scripted")

E.add_comps(E, tt, "ui", "tween")

tt.render.sprites[1].prefix = "decal_camel"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.render.sprites[1].anchor.y = 0.1
tt.main_script.update = scripts.decal_camel.update
tt.ui.can_click = true
tt.ui.click_rect = r(-25, -5, 50, 40)
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].name = "scale"
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
tt = E.register_t(E, "decal_efreeti_tent", "decal")
tt.render.sprites[1].name = "boss_corps_efreeti"
tt.render.sprites[1].animated = false
tt = E.register_t(E, "decal_efreeti_door", "decal_scripted")
tt.main_script.update = scripts.decal_efreeti_door.update
tt.smoke_positions = {
	v(521, 674),
	v(618, 642)
}
tt.stone_positions = {
	{
		v(599, 664),
		1,
		false
	},
	{
		v(688, 592),
		0.8,
		false
	},
	{
		v(479, 647),
		0.8,
		false
	},
	{
		v(519, 682),
		1,
		true
	},
	{
		v(625, 608),
		0.8,
		true
	},
	{
		v(416, 663),
		0.8,
		true
	}
}
tt.render.sprites[1].prefix = "efreeti_door_floor"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "efreeti_door"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].loop = false
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "Stage06_0003"
tt.render.sprites[3].animated = false
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "efreeti_statue"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].offset = v(-139, -66)
tt.render.sprites[4].anchor.y = 0.08
tt.render.sprites[5] = E.clone_c(E, "sprite")
tt.render.sprites[5].prefix = "efreeti_statue"
tt.render.sprites[5].name = "idle"
tt.render.sprites[5].offset = v(72, -120)
tt.render.sprites[5].anchor.y = 0.08
tt.render.sprites[6] = E.clone_c(E, "sprite")
tt.render.sprites[6].name = "efreeti_door_eyes"
tt.render.sprites[6].offset = v(-51, -55)
tt.render.sprites[6].hidden = true
tt.render.sprites[6].loop = false
tt.render.sprites[7] = E.clone_c(E, "sprite")
tt.render.sprites[7].name = "efreeti_door_eyes_effect"
tt.render.sprites[7].offset = v(-51, -55)
tt.render.sprites[7].hidden = true
tt.render.sprites[7].loop = false
tt = E.register_t(E, "decal_efreeti_door_broken", "decal")
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].name = "efreeti_statue_left"
tt.render.sprites[1].offset = v(-139, -66)
tt.render.sprites[1].anchor.y = 0.08
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "efreeti_statue_right"
tt.render.sprites[2].offset = v(72, -120)
tt.render.sprites[2].anchor.y = 0.08
tt = E.register_t(E, "decal_monkey_run", "decal_delayed_play")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].prefix = "decal_monkey_run"
tt.render.sprites[1].name = "play"
tt.delayed_play.min_delay = 15
tt.delayed_play.max_delay = 60
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_duration = 3
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt = E.register_t(E, "decal_bird_blue", "decal_delayed_play")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].prefix = "decal_bird_blue"
tt.render.sprites[1].name = "play"
tt.delayed_play.min_delay = 15
tt.delayed_play.max_delay = 60
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_duration = 5.3
tt.tween.remove = false
tt.tween.props[1].name = "offset"
tt = E.register_t(E, "decal_bird_multicolor", "decal_bird_blue")
tt.render.sprites[1].prefix = "decal_bird_multicolor"
tt = E.register_t(E, "decal_predator", "decal_click_play")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].prefix = "decal_predator"
tt.render.sprites[1].alpha = 120
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		140
	},
	{
		0.1,
		255
	},
	{
		7,
		255
	},
	{
		7.1,
		0
	}
}
tt.tween.remove = false
tt.tween.disabled = true
tt.click_play.play_once = true
tt.ui.click_rect = r(-30, -22, 60, 50)
tt = E.register_t(E, "decal_monkey_banana", "decal_scripted")

E.add_comps(E, tt, "bullet_attack")

tt.main_script.update = scripts.decal_monkey_banana.update
tt.render.sprites[1].prefix = "decal_monkey_banana"
tt.render.sprites[1].loop = false
tt.bullet_attack.bullet = "bullet_banana"
tt.bullet_attack.cooldown_min = fts(100)
tt.bullet_attack.cooldown_max = fts(300)
tt.bullet_attack.max_range = 210
tt.bullet_attack.shoot_time = fts(32)
tt.bullet_attack.bullet_start_offset = v(0, 16)
tt.bullet_attack.vis_bans = bor(F_FRIEND, F_HERO)
tt = E.register_t(E, "bullet_banana", "bomb")
tt.bullet.damage_max = 0
tt.bullet.damage_min = 0
tt.bullet.damage_radius = 0
tt.bullet.vis_bans = F_ALL
tt.bullet.hit_fx = nil
tt.bullet.hit_decal = "decal_banana_peel"
tt.bullet.pop = nil
tt.render.sprites[1].name = "Stage6_MonkeyBanana_0001"
tt.sound_events.insert = "AxeSound"
tt = E.register_t(E, "decal_banana_peel", "decal_timed")
tt.render.sprites[1].name = "Stage6_MonkeyBanana_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_DECALS
tt.timed.duration = 2.1
tt = E.register_t(E, "decal_lumberjack_shaman", "decal")
tt.render.sprites[1].prefix = "lumberjack_shaman"
tt.render.sprites[1].anchor.y = 0.18
tt = E.register_t(E, "decal_water_wave", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_water_wave"
tt.render.sprites[1].name = "play"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_DECALS
tt.delayed_play.min_delay = 1
tt.delayed_play.max_delay = 3
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "play"
tt = E.register_t(E, "decal_crocodile", "decal_delayed_sequence")
tt.render.sprites[1].prefix = "decal_crocodile"
tt.render.sprites[1].name = "show"
tt.render.sprites[1].z = Z_DECALS + 1
tt.render.sprites[1].hidden = true
tt.delayed_sequence.animations = {
	"show",
	"idle",
	"hide"
}
tt.delayed_sequence.min_delay = 3
tt.delayed_sequence.max_delay = 5
tt = E.register_t(E, "decal_piranha", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_piranha"
tt.render.sprites[1].name = "jump"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_DECALS + 1
tt.delayed_play.min_delay = 5
tt.delayed_play.max_delay = 10
tt.delayed_play.flip_chance = 0.5
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "jump"
tt = E.register_t(E, "decal_water_bottle", "decal_scripted")

E.add_comps(E, tt, "nav_path", "motion", "ui")

tt.main_script.update = scripts.decal_water_bottle.update
tt.render.sprites[1].prefix = "decal_water_bottle"
tt.render.sprites[1].z = Z_DECALS - 2
tt.motion.max_speed = FPS*1.6
tt.delay = 3
tt.ui.click_rect = r(-15, -15, 30, 30)
tt = E.register_t(E, "decal_bouncing_bridge", "decal_scripted")
tt.main_script.update = scripts.decal_bouncing_bridge.update
tt.render.sprites[1].prefix = "decal_bouncing_bridge"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].z = Z_DECALS - 1
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "Stage6_Bridge_Front_Pillars"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_OBJECTS
tt.render.sprites[2].sort_y = 495
tt.bridge_width = 160
tt = E.register_t(E, "carnivorous_plant", "decal_scripted")

E.add_comps(E, tt, "area_attack")

tt.main_script.update = scripts.carnivorous_plant.update
tt.render.sprites[1].prefix = "carnivorous_plant"
tt.render.sprites[1].name = "inactive"
tt.render.sprites[1].anchor.y = 0.41
tt.activates_on_wave = 1
tt.attack_pos = nil
tt.area_attack.cooldown = 40
tt.area_attack.damage_radius = 55
tt.area_attack.hit_time = fts(10)
tt.area_attack.vis_flags = F_EAT
tt.area_attack.damage_type = DAMAGE_EAT
tt = E.register_t(E, "enemy_cannibal_volcano", "enemy")

E.add_comps(E, tt, "melee", "tween")

anchor_y = 0.15
image_y = 100
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0044") or "info_portraits_enemies_0027"
tt.enemy.gold = 0
tt.enemy.lives_cost = 0
tt.enemy.melee_slot = v(24, 0)
tt.health.armor = 0
tt.health.hp_max = 400
tt.health.magic_armor = 0
tt.health_bar.offset = v(0, ady(70))
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_cannibal_volcano.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 6
tt.melee.attacks[1].damage_min = 3
tt.melee.attacks[1].hit_time = fts(12)
tt.motion.max_speed = FPS*1.28
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_cannibal_volcano"
tt.sound_events.scream = "SpecialVolcanoVirginScream"
tt.sound_events.throw = "SpecialVolcanoThrowSplash"
tt.tween.props[1].keys = {
	{
		0,
		v(0.65, 0.65)
	},
	{
		0.2,
		v(1, 1)
	}
}
tt.tween.props[1].name = "scale"
tt.tween.remove = false
tt.tween.run_once = true
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 18)
tt.unit.marker_offset = v(0, ady(16))
tt.unit.mod_offset = v(0, ady(36))
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt.vis.bans = bor(F_SKELETON, F_ZOMBIE)
tt = E.register_t(E, "decal_volcano_virgin", "decal_scripted")

E.add_comps(E, tt, "motion")

tt.render.sprites[1].prefix = "volcano_virgin"
tt.render.sprites[1].name = "heart"
tt.render.sprites[1].anchor.y = 0.15
tt.motion.max_speed = FPS*1
tt.main_script.update = scripts.decal_volcano_virgin.update
tt = E.register_t(E, "bomb_volcano", "bullet")
tt.bullet.damage_max = 160
tt.bullet.damage_min = 100
tt.bullet.damage_radius = 50
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx = "fx_fireball_explosion"
tt.bullet.particles_name = "ps_bomb_volcano"
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.rotation_speed = (FPS*20*math.pi)/180
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.flight_time_base = fts(35)
tt.bullet.flight_time_factor = fts(0.06666666666666667)
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "Stage9_lavaShot"
tt.sound_events.insert = "SpecialVolcanoLavaShoot"
tt.sound_events.hit = "SpecialVolcanoLavaShootHit"
tt.sound_events.remove = "BombExplosionSound"
tt = E.register_t(E, "decal_volcano_bubble", "decal_delayed_play")
tt.render.sprites[1].prefix = "volcano_lava"
tt.render.sprites[1].name = "bubble"
tt.delayed_play.min_delay = 5
tt.delayed_play.max_delay = 5
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "bubble"
tt = E.register_t(E, "decal_volcano_smoke", "decal_delayed_play")
tt.render.sprites[1].prefix = "volcano_lava"
tt.render.sprites[1].name = "smoke"
tt.delayed_play.min_delay = 3
tt.delayed_play.max_delay = 3
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "smoke"
tt = E.register_t(E, "decal_monkey_corps_1", "decal_tween")
tt.render.sprites[1].name = "decal_monkey_corps_1"
tt.tween.remove = false
tt.tween.props[1].loop = true
tt.tween.props[1].name = "flip_x"
tt.tween.props[1].keys = {
	{
		0,
		false
	},
	{
		3,
		true
	},
	{
		6,
		false
	}
}
tt = E.register_t(E, "decal_monkey_corps_2", "decal")
tt.render.sprites[1].name = "decal_monkey_corps_2"
tt = E.register_t(E, "decal_monkey_corps_3", "decal_delayed_sequence")
tt.render.sprites[1].prefix = "decal_monkey_corps_3"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = false
tt.render.sprites[1].hidden = nil
tt.delayed_sequence.animations = {
	"jump",
	"jump",
	"jump",
	"idle"
}
tt.delayed_sequence.min_delay = 0
tt.delayed_sequence.max_delay = 1
tt = E.register_t(E, "indiana_puzzle_button_a", "decal")

E.add_comps(E, tt, "ui")

tt.render.sprites[1].name = "idle"
tt.render.sprites[1].prefix = "indiana_puzzle_button_a"
tt.render.sprites[1].z = Z_DECALS + 6
tt.ui.can_click = false
tt.ui.click_rect = r(-22, -22, 44, 44)
tt.puzzle_value = 1
tt = E.register_t(E, "indiana_puzzle_button_b", "indiana_puzzle_button_a")
tt.render.sprites[1].prefix = "indiana_puzzle_button_b"
tt.puzzle_value = 2
tt = E.register_t(E, "indiana_puzzle_button_c", "indiana_puzzle_button_a")
tt.render.sprites[1].prefix = "indiana_puzzle_button_c"
tt.puzzle_value = 3
tt = E.register_t(E, "decal_indiana", "decal_tween")
tt.render.sprites[1].prefix = "decal_indiana"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_DECALS + 4
tt.tween.disabled = true
tt.tween.props[1].name = "alpha"
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
tt = E.register_t(E, "decal_indiana_question_marks", "decal_timed")
tt.render.sprites[1].name = "decal_indiana_question_marks"
tt.timed.runs = 5
tt = E.register_t(E, "decal_indiana_boulder", "decal_scripted")

E.add_comps(E, tt, "motion")

tt.render.sprites[1].name = "decal_indiana_boulder"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS + 4
tt.motion.max_speed = FPS*3.9
tt.main_script.update = scripts.decal_indiana_boulder.update
tt = E.register_t(E, "decal_bat_flying", "decal_delayed_play")

E.add_comps(E, tt, "tween")

tt.render.sprites[1].prefix = "decal_bat_flying"
tt.render.sprites[1].name = "play"
tt.render.sprites[1].z = Z_BULLETS
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

tt = E.register_t(E, "decal_cave_eyes", "decal_tween")
tt.render.sprites[1].name = "Cave_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "Cave_0002"
tt.render.sprites[2].animated = false
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "Cave_0003"
tt.render.sprites[3].animated = false
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "Cave_0004"
tt.render.sprites[4].animated = false
tt.tween.remove = false
tt.tween.props[1].name = "hidden"
tt.tween.props[1].keys = {
	{
		0,
		true
	},
	{
		10,
		false
	},
	{
		20,
		true
	}
}
tt.tween.props[1].loop = true
tt.tween.props[1].sprite_id = 2
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "hidden"
tt.tween.props[2].keys = {
	{
		0,
		true
	},
	{
		11,
		false
	},
	{
		22,
		true
	}
}
tt.tween.props[2].loop = true
tt.tween.props[2].sprite_id = 3
tt.tween.props[3] = E.clone_c(E, "tween_prop")
tt.tween.props[3].name = "hidden"
tt.tween.props[3].keys = {
	{
		0,
		true
	},
	{
		12,
		false
	},
	{
		24,
		true
	}
}
tt.tween.props[3].loop = true
tt.tween.props[3].sprite_id = 4
tt = E.register_t(E, "decal_tunnel_light", "decal_scripted")

E.add_comps(E, tt, "tween")

tt.main_script.update = scripts.decal_tunnel_light.update
tt.render.sprites[1].name = "Stage12_0006"
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
tt = E.register_t(E, "decal_black_dragon", "decal_scripted")

E.add_comps(E, tt, "motion", "attacks", "tween", "ui", "sound_events")

tt.main_script.update = scripts.decal_black_dragon.update
tt.motion.max_speed = FPS*12
tt.attacks.list[1] = E.clone_c(E, "mod_attack")
tt.attacks.list[1].mod = "mod_black_dragon"
tt.attacks.list[1].cooldown = 0.2
tt.attacks.list[1].range = 30
tt.render.sprites[1].prefix = "decal_black_dragon"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].anchor.y = 0
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "decal_black_dragon"
tt.render.sprites[2].name = "zzz"
tt.render.sprites[2].hidden = true
tt.render.sprites[2].loope = false
tt.render.sprites[2].anchor.y = 0
tt.render.sprites[2].z = Z_OBJECTS + 1
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "Stage12_Dragon_Shadow"
tt.render.sprites[3].animated = false
tt.render.sprites[3].hidden = true
tt.render.sprites[3].z = Z_OBJECTS
tt.render.sprites[3].draw_order = -1
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].name = "black_dragon_flame_hit"
tt.render.sprites[4].hidden = true
tt.render.sprites[4].offset = v(105, 10)
tt.sound_events.wakeup = "SpecialBlackDragonTaunt"
tt.sound_events.fire = "SpecialBlackDragonFire"
tt.tween.remove = false
tt.tween.disabled = true
tt.tween.props[1].keys = {
	{
		0,
		255
	},
	{
		fts(8),
		0
	}
}
tt.tween.props[1].sprite_id = 2
tt.ui.can_click = true
tt.ui.click_rect = r(-50, 30, 110, 90)
tt.wakeup_cooldown_min = 5
tt.wakeup_cooldown_max = 16
tt.sleep_pos = v(610, 579)
tt.speed_fly = FPS*12
tt.speed_takeoff = 5*FPS
tt = E.register_t(E, "fx_black_dragon_flame_hit", "decal_tween")
tt.render.sprites[1].loop = true
tt.render.sprites[1].name = "black_dragon_flame_hit"
tt.tween.props[1].name = "alpha"
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
tt = E.register_t(E, "ps_black_dragon_flame")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.animated = true
tt.particle_system.emission_rate = 20
tt.particle_system.emit_direction = -math.pi/5
tt.particle_system.emit_area_spread = v(4, 4)
tt.particle_system.emit_spread = math.pi/24
tt.particle_system.emit_rotation = 0
tt.particle_system.emit_speed = {
	FPS*24,
	22*FPS
}
tt.particle_system.loop = false
tt.particle_system.name = "black_dragon_flame"
tt.particle_system.particle_lifetime = {
	fts(6),
	fts(6)
}
tt.particle_system.scale_same_aspect = true
tt = E.register_t(E, "ps_black_dragon_fire")

E.add_comps(E, tt, "pos", "particle_system")

tt.particle_system.alphas = {
	255,
	255,
	0
}
tt.particle_system.animated = true
tt.particle_system.emission_rate = 15
tt.particle_system.emit_area_spread = v(4, 15)
tt.particle_system.emit_rotation = 0
tt.particle_system.loop = false
tt.particle_system.name = "black_dragon_fire"
tt.particle_system.particle_lifetime = {
	fts(20),
	fts(25)
}
tt.particle_system.scale_same_aspect = true
tt.particle_system.anchor = v(0.5, 0.25)
tt = E.register_t(E, "mod_black_dragon", "modifier")

E.add_comps(E, tt, "render")

tt.modifier.duration = 7
tt.main_script.update = scripts.mod_tower_block.update
tt.render.sprites[1].prefix = "black_dragon_tower_fire"
tt.render.sprites[1].name = "start"
tt.render.sprites[1].anchor.y = 0.19
tt.render.sprites[1].sort_y_offset = -1
tt = E.register_t(E, "button_steal_dragon_gold")

E.add_comps(E, tt, "pos", "main_script", "ui")

tt.main_script.update = scripts.button_steal_dragon_gold.update
tt.ui.can_click = true
tt.ui.click_rect = r(0, 0, 88, 67)
tt.gold_to_steal = 100
tt.fx = "fx_coin_jump"
tt = RT("tower_elf_holder")

AC(tt, "tower", "tower_holder", "pos", "render", "ui", "info", "editor", "editor_script")

tt.tower.type = "holder_elf"
tt.tower.level = 1
tt.tower.can_be_mod = false
tt.info.i18n_key = "SPECIAL_ELF"
tt.info.fn = scripts2.tower_elf_holder.get_info
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
tt.editor_script.insert = scripts2.editor_tower.insert
tt.editor_script.remove = scripts2.editor_tower.remove
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
tt.info.fn = scripts2.tower_elf_holder.get_info
tt.main_script.insert = scripts2.tower_barrack.insert
tt.main_script.remove = scripts2.tower_barrack.remove
tt.main_script.update = scripts2.tower_barrack_mercenaries.update
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
tt.tower.price = 175
tt.tower.terrain_style = nil
tt.tower.type = "elf"
tt.ui.click_rect = r(-40, -10, 80, 90)
tt = RT("tower_elf_kr1", "tower_barrack_1")

AC(tt, "powers")

tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_towers_0008") or "info_portraits_towers_0012"
tt.info.enc_icon = 18
tt.info.i18n_key = "TOWER_ELF_KR1"
tt.barrack.max_soldiers = 4
tt.tower.type = "elf_kr1"
tt.tower.price = 450
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
tt.attacks.list[2].cooldown = 10
tt.attacks.list[2].disabled = true
tt.attacks.list[2].power_name = "barrel"
tt.attacks.list[2].shoot_time = fts(22)
tt.attacks.list[2].vis_bans = F_FLYING
tt.attacks.list[2].node_prediction = fts(22) + fts(26)
tt.attacks.range = 217.6
tt.info.fn = scripts.tower_archer_dwarf.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0017"
tt.main_script.update = scripts.tower_archer_dwarf.update
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
tt.bullet.damage_min = 41
tt.bullet.damage_max = 76
tt.bullet.damage_inc = 34.35
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
tt.bullet.damage_min_inc = 60
tt.bullet.damage_radius = 65
tt.bullet.damage_radius_inc = 5
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
tt.powers.armor.price_base = 250
tt.powers.armor.price_inc = 100
tt.powers.beer = E.clone_c(E, "power")
tt.powers.beer.price_base = 200
tt.powers.beer.price_inc = 100
tt.powers.hammer = E.clone_c(E, "power")
tt.powers.hammer.price_base = 150
tt.powers.hammer.price_inc = 125
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
tt.tower.price = 200
tt.tower.type = "barrack_dwarf"
tt = E.register_t(E, "soldier_dwarf", "soldier_militia")
image_y = 42
anchor_y = 0.21428571428571427

E.add_comps(E, tt, "powers")

tt.beer = {
	animation = "beer",
	cooldown = 10,
	hp_trigger_factor = 0.7,
	mod = "mod_dwarf_beer",
	ts = 0
}
tt.health.armor = 0.2
tt.health.armor_inc = 0.25
tt.health.armor_power_name = "armor"
tt.health.dead_lifetime = 15
tt.health.hp_max = 220
tt.health_bar.offset = v(0, ady(41))
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0066") or "info_portraits_soldiers_0028"
tt.info.random_name_count = 10
tt.info.random_name_format = "SOLDIER_DWARF_RANDOM_%i_NAME"
tt.main_script.update = scripts.soldier_dwarf.update
tt.melee.attacks[1].damage_inc = 5
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
tt.modifier.duration = 4
tt.modifier.duration_inc = 2
tt.modifier.use_mod_offset = false
tt.render.sprites[1].name = "dwarf_beer_aura"
tt.render.sprites[1].loop = true
tt.render.sprites[1].z = Z_DECALS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "dwarf_beer_bubbles"
tt.render.sprites[2].loop = true
tt.render.sprites[2].offset.y = 10
tt.render.sprites[2].z = Z_EFFECTS
tt.main_script.insert = scripts.mod_hps.insert
tt.main_script.update = scripts.mod_hps.update
tt = E.register_t(E, "background_sounds_jungle", "background_sounds")
tt.min_delay = 20
tt.max_delay = 25
tt.sounds = {
	"JungleAmbienceSound"
}
tt = E.register_t(E, "background_sounds_underground", "background_sounds")
tt.min_delay = 15
tt.max_delay = 20
tt.sounds = {
	"UndergroundAmbienceSound"
}
tt = E.register_t(E, "decal_jumping_fish", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_fish"
tt.render.sprites[1].name = "jump"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].z = Z_DECALS + 1
tt.delayed_play.min_delay = 5
tt.delayed_play.max_delay = 10
tt.delayed_play.flip_chance = 0.5
tt.delayed_play.idle_animation = nil
tt.delayed_play.play_animation = "jump"
tt = E.register_t(E, "decal_water_wave_16", "decal_water_wave")
tt.render.sprites[1].prefix = "decal_water_wave_16"
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
tt.info.fn = scripts.tower_pirate_watchtower.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0020"
tt.main_script.update = scripts.tower_pirate_watchtower.update
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
tt.bullet.damage_min = 47
tt.bullet.damage_max = 70
tt.bullet.damage_inc = 40
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
tt.main_script.update = scripts.pirate_watchtower_parrot.update
tt.custom_attack = E.clone_c(E, "custom_attack")
tt.custom_attack.min_range = 20
tt.custom_attack.max_range = 40
tt.custom_attack.bullet = "pirate_watchtower_bomb"
tt.custom_attack.cooldown = 2
tt.custom_attack.damage_type = DAMAGE_PHYSICAL
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
tt.bullet.damage_max = 44
tt.bullet.damage_min = 44
tt.bullet.hide_radius = nil
tt.render.sprites[1].name = "pirateTower_bomb"
tt.sound_events.insert = nil
tt = E.register_t(E, "enemy_gunboat", "enemy")

E.add_comps(E, tt, "attacks")

anchor_y = 0.20666666666666667
image_y = 150
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animations = {
	"fire_start",
	"fire_loop",
	"fire_end"
}
tt.attacks.list[1].bullet = "bomb_gunboat"
tt.attacks.list[1].bullet_start_offset = v(21, 73)
tt.attacks.list[1].cooldown = 1
tt.attacks.list[1].max_range = 5000
tt.attacks.list[1].min_range = 0
tt.attacks.list[1].shoot_time = fts(1)
tt.attacks.list[1].vis_bans = bor(F_ENEMY, F_BOSS, F_MINIBOSS, F_FLYING)
tt.attacks.list[1].vis_flags = F_RANGED
tt.enemy.gold = 150
tt.enemy.lives_cost = 0
tt.health.armor = 0.2
tt.health.dead_lifetime = 3
tt.health.hp_max = 1000
tt.health_bar.offset = v(7, 85)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM_LARGE
tt.info.fn = scripts.enemy_gunboat.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0078") or "info_portraits_enemies_0059"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_gunboat.update
tt.motion.max_speed = FPS*1.024
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "enemy_gunboat_l1"
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].prefix = "enemy_gunboat_l2"
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].anchor.y = anchor_y
tt.render.sprites[3].prefix = "enemy_gunboat_l3"
tt.ui.click_rect = r(-40, 0, 80, 60)
tt.unit.blood_color = BLOOD_NONE
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, 25)
tt.unit.marker_offset = v(0, 0)
tt.unit.mod_offset = v(0, 28)
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_STUN, F_BLOCK, F_DRILL, F_POISON, F_TWISTER, F_SKELETON, F_EAT)
tt.sound_events.death_water = "RTGunboatDeath"
tt = E.register_t(E, "bomb_gunboat", "bullet")
tt.bullet.damage_max = 120
tt.bullet.damage_min = 80
tt.bullet.damage_radius = 51.2
tt.bullet.damage_type = DAMAGE_PHYSICAL
tt.bullet.hit_decal = "decal_bomb_crater"
tt.bullet.hit_fx = "fx_fireball_explosion"
tt.bullet.particles_name = "ps_bomb_gunboat"
tt.bullet.pop = {
	"pop_kboom"
}
tt.bullet.align_with_trajectory = true
tt.bullet.damage_bans = F_ENEMY
tt.bullet.damage_flags = F_AREA
tt.bullet.flight_time_base = fts(50)
tt.bullet.flight_time_factor = fts(0.04)
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt.render.sprites[1].animated = false
tt.render.sprites[1].name = "waterCannon_proy"
tt.sound_events.insert = "SpecialVolcanoLavaShoot"
tt.sound_events.hit = "BombExplosionSound"
local decal_whale = E.register_t(E, "decal_whale", "decal_scripted")

E.add_comps(E, decal_whale, "nav_path")

decal_whale.path_origin_offset = v(36, 36)
decal_whale.main_script.insert = scripts.decal_whale.insert
decal_whale.main_script.update = scripts.decal_whale.update

for i = 1, 3, 1 do
	decal_whale.render.sprites[i] = E.clone_c(E, "sprite")
	decal_whale.render.sprites[i].prefix = "decal_whale_l" .. i
	decal_whale.render.sprites[i].name = "show"
	decal_whale.render.sprites[i].hidden = true
end

decal_whale.render.sprites[4] = E.clone_c(E, "sprite")
decal_whale.render.sprites[4].name = "Cachalote_layer1_0090"
decal_whale.render.sprites[4].animated = false
decal_whale.render.sprites[4].hidden = true
decal_whale.render.sprites[4].sort_y_offset = decal_whale.path_origin_offset.y*-1 - 2
decal_whale.render.sprites[5] = E.clone_c(E, "sprite")
decal_whale.render.sprites[5].prefix = "decal_whale_eye"
decal_whale.render.sprites[5].name = "idle"
decal_whale.render.sprites[5].hidden = true
decal_whale.render.sprites[5].sort_y_offset = decal_whale.path_origin_offset.y*-1 - 3
local fx_whale_incoming = E.register_t(E, "fx_whale_incoming", "decal_tween")
fx_whale_incoming.tween.remove = true
fx_whale_incoming.tween.props[1].name = "alpha"
fx_whale_incoming.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		2,
		255
	},
	{
		4,
		255
	}
}
fx_whale_incoming.render.sprites[1].name = "fx_whale_incoming"
fx_whale_incoming.render.sprites[1].z = Z_DECALS + 2
fx_whale_incoming.render.sprites[1].loop = true
tt = E.register_t(E, "decal_water_barricade", "decal")
tt.render.sprites[1].prefix = "decal_water_barricade"
tt.render.sprites[1].name = "idle"
tt = E.register_t(E, "leviathan_head", "decal")
tt.render.sprites[1].prefix = "leviathan_head"
tt.render.sprites[1].name = "show"
tt.render.sprites[1].anchor.y = 0.4830508474576271
tt = E.register_t(E, "leviathan_tentacle", "decal_scripted")
tt.render.sprites[1].prefix = "leviathan_tentacle"
tt.render.sprites[1].name = "show"
tt.render.sprites[1].anchor.y = 0.23076923076923078
tt.main_script.update = scripts.leviathan_tentacle.update
tt.tower_bans = {
	"tower_mech"
}
tt.range = 50
tt.search_off_x = 90
tt.duration = 8
tt.interrupt = nil
tt.flip = nil
tt = E.register_t(E, "fx_leviathan_incoming", "decal_tween")
tt.tween.remove = true
tt.tween.props[1].name = "alpha"
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		1,
		255
	},
	{
		3,
		255
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].name = "scale"
tt.tween.props[2].keys = {
	{
		0,
		v(0.35, 0.35)
	},
	{
		3,
		v(1, 1)
	}
}
tt.render.sprites[1].name = "fx_leviathan_bubbles"
tt.render.sprites[1].z = Z_DECALS + 2
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor.y = 0.15254237288135594
tt = E.register_t(E, "eb_leviathan", "boss")

E.add_comps(E, tt, "attacks")

anchor_y = 0.15254237288135594
image_y = 118
tt.attacks.list[1] = E.clone_c(E, "custom_attack")
tt.attacks.list[1].cooldown = 12
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(50, 0)
tt.health.dead_lifetime = fts(200)
tt.health.hp_max = {
	12000,
	15000,
	18000
}
tt.health_bar.offset = v(0, ady(120))
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_leviathan.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0077") or "info_portraits_enemies_0060"
tt.info.enc_icon = 48
tt.main_script.insert = scripts.eb_leviathan.insert
tt.main_script.update = scripts.eb_leviathan.update
tt.motion.max_speed = 0.384*FPS
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].prefix = "eb_leviathan_water"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].loop_forced = true
tt.render.sprites[1].hidden = true
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].prefix = "eb_leviathan"
tt.render.sprites[2].name = "spawn"
tt.ui.click_rect = r(-50, 0, 100, 80)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.hide_after_death = true
tt.unit.hit_offset = v(0, ady(47))
tt.unit.marker_hidden = true
tt.unit.mod_offset = v(0, ady(65))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.unit.hit_rect = r(-58, 0, 116, 78)
tt.vis.bans = F_ALL
tt.vis.bans_in_battlefield = bor(F_STUN, F_BLOOD, F_DRILL, F_LETHAL, F_SKELETON, F_POLYMORPH, F_TELEPORT, F_BLOCK)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.sound_events.spawn = "RTBossSpawn"
tt.sound_events.death = "RTBossDeath"
tt = E.register_t(E, "points_spawner")

E.add_comps(E, tt, "main_script")

tt.main_script.update = scripts.points_spawner.update
tt.manual_wave = nil
tt.interrupt = false
tt = E.register_t(E, "moon_controller", "decal_scripted")

E.add_comps(E, tt, "tween")

tt.pos.x = REF_W/2
tt.pos.y = REF_H + 1
tt.main_script.update = scripts.moon_controller.update
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].name = "moon_base_0004"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_SCREEN_FIXED + 2
tt.render.sprites[1].anchor.y = 1
tt.render.sprites[1].scale = (IS_PHONE_OR_TABLET and v(1.45, 1.45)) or nil
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "moon_base_0001"
tt.render.sprites[2].hidden = false
tt.render.sprites[3] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[3].name = "moon_base_0002"
tt.render.sprites[3].hidden = false
tt.render.sprites[3].z = Z_SCREEN_FIXED + 5
tt.render.sprites[4] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[4].name = "moon_base_0003"
tt.render.sprites[4].z = Z_SCREEN_FIXED + 5
tt.tween.remove = false
tt.tween.reverse = true
tt.tween.ts = -1
tt.tween.props[1].sprite_id = 1
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
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].sprite_id = 4
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.5,
		255
	}
}
tt = E.register_t(E, "decal_moon_dark", "decal_tween")
tt.pos.x = REF_W/2
tt.pos.y = REF_H + 1 + 77*((IS_PHONE_OR_TABLET and 1.45) or 1)
tt.render.sprites[1].name = "moon_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_SCREEN_FIXED + 3
tt.render.sprites[1].anchor.x = 3.6666666666666665
tt.render.sprites[1].scale = (IS_PHONE_OR_TABLET and v(1.45, 1.45)) or nil
tt.tween.props[1].name = "r"
tt.tween.disabled = true
tt.tween.remove = false
tt = E.register_t(E, "decal_moon_light", "decal_tween")
tt.pos.x = REF_W/2
tt.pos.y = REF_H + 1 + 77*((IS_PHONE_OR_TABLET and 1.45) or 1)
tt.render.sprites[1].name = "moon_0002"
tt.render.sprites[1].animated = false
tt.render.sprites[1].loop = false
tt.render.sprites[1].z = Z_SCREEN_FIXED + 4
tt.render.sprites[1].r = math.pi/2
tt.render.sprites[1].anchor.x = 3.6666666666666665
tt.render.sprites[1].scale = (IS_PHONE_OR_TABLET and v(1.45, 1.45)) or nil
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].name = "moon_0003"
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
		0.5,
		255
	}
}
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.25,
		0
	},
	{
		0.5,
		255
	}
}
tt.tween.props[2].sprite_id = 2
tt.tween.remove = false
tt.tween.reverse = true
tt.tween.ts = -1
tt = E.register_t(E, "decal_moon_overlay", "decal_tween")
tt.pos.x = REF_W/2
tt.pos.y = REF_H/2
tt.render.sprites[1].name = "moon_overlay"
tt.render.sprites[1].animated = false
tt.render.sprites[1].scale = v((REF_H*MAX_SCREEN_ASPECT*1.5)/64, (REF_H*1.5)/64)
tt.render.sprites[1].z = Z_SCREEN_FIXED + 1
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.5,
		44
	}
}
tt.tween.remove = false
tt.tween.reverse = true
tt.tween.ts = -1
tt = E.register_t(E, "moon_enemy_aura", "aura")
tt.main_script.update = scripts.moon_enemy_aura.update
tt = E.register_t(E, "tower_frankenstein", "tower")

E.add_comps(E, tt, "barrack", "attacks", "powers")

tt.tower.type = "frankenstein"
tt.tower.level = 1
tt.tower.price = 292
tt.info.fn = scripts.tower_frankenstein.get_info
tt.info.portrait = ((IS_PHONE_OR_TABLET and "portraits_towers_") or "info_portraits_towers_") .. "0022"
tt.powers.lightning = E.clone_c(E, "power")
tt.powers.lightning.price_base = 187
tt.powers.lightning.price_inc = 122
tt.powers.frankie = E.clone_c(E, "power")
tt.powers.frankie.price_base = 150
tt.powers.frankie.price_inc = 150
tt.main_script.insert = scripts.tower_frankenstein.insert
tt.main_script.update = scripts.tower_frankenstein.update
tt.main_script.remove = scripts.tower_barrack.remove
tt.barrack.soldier_type = "soldier_frankenstein"
tt.barrack.rally_range = 179.20000000000002
tt.attacks.range = 200
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
tt.bounce_range = 90
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
tt.main_script.insert = scripts.ray_frankenstein.insert
tt.main_script.update = scripts.ray_frankenstein.update
tt = E.register_t(E, "mod_ray_frankenstein", "modifier")

E.add_comps(E, tt, "render", "dps")

tt.modifier.duration = fts(18)
tt.dps.damage_min = 40
tt.dps.damage_max = 60
tt.dps.damage_inc = 10
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
tt.main_script.insert = scripts.mod_dps.insert
tt.main_script.update = scripts.mod_dps.update
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
tt.health.hp_max = 500
tt.health_bar.offset = v(0, 48)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts.soldier_barrack.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0093") or "info_portraits_soldiers_0030"
tt.main_script.insert = scripts.soldier_barrack.insert
tt.main_script.update = scripts.soldier_barrack.update
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
tt.melee.attacks[2].damage_radius = 120
tt.melee.attacks[2].damage_type = DAMAGE_TRUE
tt.melee.attacks[2].disabled = true
tt.melee.attacks[2].hit_time = fts(24)
tt.melee.attacks[2].hit_fx = "fx_frankenstein_pound"
tt.melee.range = 77
tt.motion.max_speed = 45
tt.regen.cooldown = 1
tt.regen.health = 25
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

tt.main_script.insert = scripts.fx_frankenstein_pound.insert
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
tt = E.register_t(E, "decal_moon_activated", "decal_scripted")

E.add_comps(E, tt, "tween")

tt.main_script.update = scripts.decal_moon_activated.update
tt.render.sprites[1].animated = false
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].animated = false
tt.tween.remove = false
tt.tween.reverse = true
tt.tween.ts = -1
tt.tween.props[1].sprite_id = 2
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
tt = E.register_t(E, "decal_taunting_dracula", "decal_scripted")
tt.main_script.update = scripts.decal_taunting_dracula.update
tt.render.sprites[1].prefix = "decal_taunting_dracula"
tt.render.sprites[1].name = "show"
tt.render.sprites[1].anchor.y = 0.1375
tt.render.sprites[1].sort_y = 557
tt.taunt = {
	cooldown = {
		50,
		70
	},
	min_cooldown = 10,
	format_welcome = "DRACULA_TAUNT_WELCOME_%04d",
	format_moon = "DRACULA_TAUNT_MOON_%04d",
	format_generic = "DRACULA_TAUNT_GENERIC_%04d",
	idx_welcome = {
		1,
		2
	},
	idx_moon = {
		1,
		4
	},
	idx_generic = {
		1,
		12
	},
	duration = 4,
	shoutbox = "decal_dracula_shoutbox",
	dracula_positions = {
		v(328, 615),
		v(708, 615)
	},
	taunt_positions = {
		v(327, 558),
		v(707, 558)
	},
	ts = 0,
	showing = nil
}
tt = E.register_t(E, "decal_dracula_shoutbox", "decal_tween")

E.add_comps(E, tt, "texts", "timed")

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
tt.texts.list[1].line_height = i18n.cjk(i18n, 0.8, nil, 1.1, 0.7)
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
tt.tween.remove = false
tt = E.register_t(E, "eb_dracula", "boss")

E.add_comps(E, tt, "melee")

image_y = 80
anchor_y = 0.1375
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(15, 0)
tt.health.dead_lifetime = fts(10000)
tt.health.hp_max = 8475
tt.health_bar.offset = v(0, 60)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.fn = scripts.eb_dracula.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0090") or "info_portraits_enemies_0067"
tt.info.enc_icon = 57
tt.main_script.insert = scripts.eb_dracula.insert
tt.main_script.update = scripts.eb_dracula.update
tt.melee.attacks[1].cooldown = 1
tt.melee.attacks[1].damage_max = 200
tt.melee.attacks[1].damage_min = 150
tt.melee.attacks[1].hit_time = fts(19)
tt.melee.attacks[2] = E.clone_c(E, "melee_attack")
tt.melee.attacks[2].mod = "mod_dracula_lifesteal"
tt.melee.attacks[2].cooldown = 5
tt.melee.attacks[2].animation = "lifesteal"
tt.melee.attacks[2].hit_time = fts(6)
tt.melee.attacks[2].fn_can = scripts.eb_dracula.can_lifesteal
tt.motion.max_speed = FPS*0.512
tt.motion.max_speed_bat = FPS*2.56
tt.motion.max_speed_default = FPS*0.512
tt.motion.max_speed_angry = FPS*0.8959999999999999
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].angles = {
	walk = {
		"walkingRightLeft",
		"walkingUp",
		"walkingDown"
	}
}
tt.render.sprites[1].prefix = "eb_dracula"
tt.ui.click_rect = r(-20, -5, 40, 65)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 33)
tt.unit.mod_offset = v(0, ady(33))
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.sound_events.insert = "MusicBossFight"
tt.sound_events.death = "HWBossVampireDeath"
tt = E.register_t(E, "mod_dracula_lifesteal", "modifier")
tt.modifier.duration = fts(50)
tt.cycle_time = fts(2)
tt.heal_hp = 25
tt.damage = 150
tt.main_script.update = scripts.mod_dracula_lifesteal.update
tt.sound_events.insert = "HWBossVampireLifesteal"
tt = E.register_t(E, "dracula_damage_aura", "aura")

E.add_comps(E, tt, "render")

tt.aura.cycle_time = fts(2)
tt.aura.duration = -1
tt.aura.radius = 128
tt.aura.dist_factor_min_radius = 38.4
tt.aura.vis_bans = bor(F_ENEMY, F_BOSS)
tt.aura.vis_flags = F_MOD
tt.aura.dps_min = FPS*3
tt.aura.dps_max = 18*FPS
tt.aura.damage_type = DAMAGE_TRUE
tt.aura.hero_damage_factor = 0.5555555555555556
tt.main_script.update = scripts.dracula_damage_aura.update
tt.render.sprites[1].name = "dracula_damage_aura"
tt.render.sprites[1].loop = true
tt.render.sprites[1].anchor = v(0.5289855072463768, 0.48484848484848486)
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "decal_moria_gate", "decal_scripted")

E.add_comps(E, tt, "tween", "ui")

tt.render.sprites[1].name = "moria_0001"
tt.render.sprites[1].animated = false
tt.render.sprites[1].alpha = 100
tt.render.sprites[1].anchor.y = 0
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "moria_0002"
tt.render.sprites[2].animated = false
tt.render.sprites[2].alpha = 0
tt.render.sprites[2].anchor.y = 0
tt.tween.disabled = true
tt.tween.remove = false
tt.tween.props[1].sprite_id = 2
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.6,
		255
	},
	{
		0.9,
		150
	}
}
tt.main_script.update = scripts.click_run_tween.update
tt.ui.click_rect = r(-25, 0, 50, 80)
tt = E.register_t(E, "decal_stage22_reptile", "decal_scripted")

E.add_comps(E, tt, "ui", "motion")

tt.render.sprites[1].prefix = "decal_stage22_reptile"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].anchor = v(0.6935483870967742, 0.05555555555555555)
tt.ui.click_rect = r(-15, -5, 30, 40)
tt.main_script.update = scripts.decal_stage22_reptile.update
tt.climb_distance = 140
tt.motion.max_speed = FPS*2
tt = E.register_t(E, "eb_saurian_king", "boss")

E.add_comps(E, tt, "melee", "timed_attacks")

image_y = 150
anchor_y = 0.16666666666666666
tt.enemy.gold = 0
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(25, 0)
tt.health.armor = 0.5
tt.health.dead_lifetime = fts(200)
tt.health.hp_max = 11000
tt.health_bar.offset = v(0, 103)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.fn = scripts.eb_saurian_king.get_info
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0096") or "info_portraits_enemies_0042"
tt.info.enc_icon = 60
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.eb_saurian_king.update
tt.motion.max_speed = 1.7919999999999998*FPS
tt.render.sprites[1] = E.clone_c(E, "sprite")
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
tt.render.sprites[1].prefix = "eb_saurian_king"
tt.ui.click_rect = r(-35, 0, 70, 80)
tt.unit.blood_color = BLOOD_VIOLET
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 45)
tt.unit.mod_offset = v(0, 45)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_SKELETON)
tt.vis.flags = bor(F_ENEMY, F_BOSS)
tt.sound_events.insert = "MusicBossFight"
tt.sound_events.death = "SaurianKingBossDeath"
tt.melee.attacks[1] = E.clone_c(E, "area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].damage_max = 0
tt.melee.attacks[1].damage_min = 0
tt.melee.attacks[1].damage_radius = 25
tt.melee.attacks[1].hit_time = fts(6)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].mod = "mod_saurian_king_tongue"
tt.melee.attacks[1].sound = "SaurianKingBossTongue"
tt.timed_attacks.list[1] = E.clone_c(E, "custom_attack")
tt.timed_attacks.list[1].animations = {
	"hammer_start",
	"hammer_loop"
}
tt.timed_attacks.list[1].cooldown = 5
tt.timed_attacks.list[1].damage_radius = 500
tt.timed_attacks.list[1].damage_type = DAMAGE_TRUE
tt.timed_attacks.list[1].hit_times = {
	fts(11),
	fts(18)
}
tt.timed_attacks.list[1].max_damage_radius = 50
tt.timed_attacks.list[1].max_damages = {
	10,
	15,
	25,
	40,
	65,
	100,
	145,
	200
}
tt.timed_attacks.list[1].min_damages = {
	5,
	7,
	12,
	20,
	30,
	50,
	70,
	100
}
tt.timed_attacks.list[1].sound = "SaurianKingBossHammer"
tt.timed_attacks.list[1].vis_flags = F_RANGED
tt.timed_attacks.list[1].fx_offsets = {
	v(48, -11),
	v(62, 1)
}
tt = E.register_t(E, "decal_saurian_king_hammer", "fx")
tt.render.sprites[1].name = "decal_saurian_king_hammer"
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "mod_saurian_king_tongue", "modifier")
tt.main_script.insert = scripts.mod_saurian_king_tongue.insert
tt.modifier.damage_radius = 25
tt.modifier.damage_max = 150
tt.modifier.damage_min = 100
tt.modifier.vis_flags = F_MOD
tt.modifier.vis_bans = bor(F_ENEMY, F_FLYING)
tt = E.register_t(E, "decal_stage81_stargate", "decal_scripted")
tt.render.sprites[1].name = "endless_stargate"
tt.render.sprites[1].animated = false
tt.render.sprites[1].sort_y_offset = -44
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "decal_stage81_stargate"
tt.render.sprites[2].name = "start"
tt.render.sprites[2].hidden = true
tt.render.sprites[2].offset = v(-7, -10)
tt.render.sprites[2].sort_y_offset = tt.render.sprites[1].sort_y_offset
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "decal_stage81_stargate_lights"
tt.render.sprites[3].hidden = true
tt.render.sprites[3].loop = false
tt.render.sprites[3].offset = v(-7, -10)
tt.render.sprites[3].sort_y_offset = tt.render.sprites[1].sort_y_offset
tt.main_script.update = scripts.decal_stage81_stargate.update
tt.fx_out = "fx_stargate_out"
tt.out_nodes = {
	[6.0] = 3,
	[7.0] = 3
}
tt.shutdown_timeout = 5
tt = E.register_t(E, "fx_stargate_out", "fx_darter_blink")
tt.render.sprites[1].anchor.y = 0.5
tt = E.register_t(E, "decal_stage81_miner1", "decal")
tt.render.sprites[1].name = "decal_stage81_miner1"
tt = E.register_t(E, "decal_stage81_miner2", "decal_delayed_play")
tt.render.sprites[1].prefix = "decal_stage81_miner2"
tt.render.sprites[1].name = "idle"
tt.render.sprites[1].loop = true
tt.delayed_play.min_delay = 3
tt.delayed_play.max_delay = 6
tt.delayed_play.loop_idle = true
tt = E.register_t(E, "decal_stage81_miner3", "decal")
tt.render.sprites[1].name = "decal_stage81_miner3"
tt = E.register_t(E, "decal_stage81_burner", "decal")
tt.render.sprites[1].name = "burnerBase"
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "decal_stage81_burner_fire"
tt.render.sprites[2].offset = v(3, 20)
tt.render.sprites[2].z = Z_OBJECTS
tt = E.register_t(E, "enemy_anoobis", "enemy")

E.add_comps(E, tt, "melee", "death_spawns")

image_y = 178
anchor_y = 31/image_y
tt.death_spawns.name = "fx_coin_shower"
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.offset = v(0, 35)
tt.enemy.gold = 250
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(28, 0)
tt.health.armor = 0
tt.health.dead_lifetime = fts(50)
tt.health.hp_max = 2500
tt.health_bar.offset = v(0, 100)
tt.health_bar.type = HEALTH_BAR_SIZE_LARGE
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0097") or "info_portraits_endless_0001"
tt.info.i18n_key = "ENEMY_ENDLESS_MINIBOSS_DESERT"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.motion.max_speed = FPS*0.6
tt.render.sprites[1].prefix = "enemy_anoobis"
tt.render.sprites[1].anchor.y = anchor_y
tt.ui.click_rect = r(-35, 0, 70, 80)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 47)
tt.unit.mod_offset = v(0, 47)
tt.unit.show_blood_pool = false
tt.unit.size = UNIT_SIZE_LARGE
tt.vis.bans = bor(F_SKELETON, F_POLYMORPH, F_TELEPORT)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt.sound_events.death = "DeathJuggernaut"
tt.sound_events.death_args = {
	delay = 0.5
}
tt.melee.attacks[1] = E.clone_c(E, "area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 70
tt.melee.attacks[1].damage_min = 30
tt.melee.attacks[1].damage_radius = 45
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_time = fts(17)
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt = E.register_t(E, "eb_xerxes", "decal_scripted")

E.add_comps(E, tt, "attacks")

tt.attacks.animations = {
	"cast1",
	"cast2"
}
tt.attacks.list[1] = E.clone_c(E, "aura_attack")
tt.attacks.list[1].aura = "xerxes_teleport_aura"
tt.attacks.list[1].node_offset = {
	10,
	20
}
tt.attacks.list[1].vis_bans = bor(F_FLYING, F_BOSS, F_STUN)
tt.attacks.list[1].vis_flags = bor(F_TELEPORT)
tt.attacks.list[1].path_margins = {
	20,
	55
}
tt.attacks.list[2] = E.clone_c(E, "spawn_attack")
tt.attacks.list[2].entity = "xerxes_obelisk"
tt.attacks.list[2].count_group_name = "munra_sarcophagus"
tt.attacks.list[2].count_group_type = COUNT_GROUP_CONCURRENT
tt.attacks.list[2].count_group_max = 35
tt.attacks.list[2].path_margins = {
	20,
	50
}
tt.attacks.list[3] = E.clone_c(E, "mod_attack")
tt.attacks.list[3].fx = "fx_xerxes_invisibility"
tt.attacks.list[3].mod = "mod_xerxes_invisibility"
tt.attacks.list[3].vis_bans = bor(F_FLYING, F_BOSS)
tt.attacks.list[3].vis_flags = F_RANGED
tt.attacks.list[3].excluded_templates = {
	"enemy_tremor"
}
tt.attacks.list[3].sound = "EndlessDesertPowerInvisibility"
tt.attacks.list[3].path_margins = {
	20,
	45
}
tt.main_script.update = scripts.eb_xerxes.update
tt.render.sprites[1].prefix = "eb_xerxes"
tt.render.sprites[1].name = "idle"
tt.taunt = {
	delay_min = 15,
	delay_max = 20,
	duration = 4,
	sets = {
		welcome = {},
		prebattle = {},
		battle = {}
	}
}
tt.taunt.sets.welcome.format = "ENDLESS_BOSS_DESERT_TAUNT_WELCOME_%04d"
tt.taunt.sets.welcome.start_idx = 1
tt.taunt.sets.welcome.end_idx = 2
tt.taunt.sets.prebattle.format = "ENDLESS_BOSS_DESERT_TAUNT_PREBATTLE_%04d"
tt.taunt.sets.prebattle.start_idx = 1
tt.taunt.sets.prebattle.end_idx = 4
tt.taunt.sets.battle.format = "ENDLESS_BOSS_DESERT_TAUNT_GENERIC_%04d"
tt.taunt.sets.battle.start_idx = 1
tt.taunt.sets.battle.end_idx = 11
tt.taunt.offset = v(0, -75)
tt.taunt.ts = 0
tt.taunt.next_ts = 0
tt = E.register_t(E, "decal_xerxes_shoutbox", "decal_tween")

E.add_comps(E, tt, "texts")

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
tt = E.register_t(E, "xerxes_teleport_aura", "aura")

E.add_comps(E, tt, "render", "sound_events")

tt.aura.duration = nil
tt.aura.radius = nil
tt.aura.vis_bans = bor(F_FLYING, F_BOSS, F_STUN)
tt.aura.vis_flags = bor(F_TELEPORT)
tt.aura.mod = "mod_xerxes_teleport"
tt.main_script.update = scripts.xerxes_teleport_aura.update
tt.render.sprites[1].prefix = "xerxes_teleport"
tt.render.sprites[1].alpha = 200
tt.render.sprites[1].z = Z_DECALS
tt.sound_events.insert = "EndlessDesertPowerTeleport"
tt = E.register_t(E, "mod_xerxes_teleport", "mod_teleport")
tt.nodes_offset = nil
tt.delay_start = fts(1)
tt.hold_time = 0.1
tt.delay_end = fts(11)
tt.fx_start = "fx_xerxes_teleport_start"
tt.fx_end = "fx_xerxes_teleport_end"
tt.modifier.use_mod_offset = false
tt = E.register_t(E, "fx_xerxes_teleport_start", "fx")
tt.render.sprites[1].prefix = "fx_xerxes_teleport_start"
tt.render.sprites[1].size_names = {
	"small",
	"small",
	"large"
}
tt.render.sprites[1].name = "small"
tt.render.sprites[1].anchor.y = 0.22727272727272727
tt = E.register_t(E, "fx_xerxes_teleport_end", "fx")
tt.render.sprites[1].name = "fx_xerxes_teleport_end"
tt.render.sprites[1].anchor.y = 0.16666666666666666
tt = E.register_t(E, "xerxes_obelisk", "decal_scripted")

E.add_comps(E, tt, "render", "tween", "spawner", "sound_events")

tt.main_script.update = scripts.xerxes_obelisk.update
tt.render.sprites[1].prefix = "xerxes_obelisk"
tt.render.sprites[1].anchor.y = 0.17105263157894737
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].name = "cementery_decal"
tt.render.sprites[2].animated = false
tt.render.sprites[2].z = Z_DECALS
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].name = "fx_xerxes_obelisk"
tt.render.sprites[3].offset.y = 30
tt.tween.props[1].keys = {
	{
		0,
		0
	},
	{
		0.25,
		255
	}
}
tt.tween.props[1].sprite_id = 2
tt.tween.props[2] = E.clone_c(E, "tween_prop")
tt.tween.props[2].keys = {
	{
		0,
		0
	},
	{
		0.25,
		255
	}
}
tt.tween.props[2].sprite_id = 3
tt.tween.remove = false
tt.sound_events.insert = "EndlessDesertPowerObelysk"
tt.spawner.entity = "enemy_fallen"
tt = E.register_t(E, "fx_xerxes_invisibility", "fx")
tt.render.sprites[1].name = "xerxes_invisibility_cloud"
tt.render.sprites[1].loop = false
tt.render.sprites[1].offset = v(-10, 0)
tt.render.sprites[2] = table.deepclone(tt.render.sprites[1])
tt.render.sprites[2].flip_x = true
tt.render.sprites[2].offset.x = 10
tt = E.register_t(E, "mod_xerxes_invisibility", "modifier")

E.add_comps(E, tt, "render")

tt.main_script.insert = scripts.mod_xerxes_invisibility.insert
tt.main_script.remove = scripts.mod_xerxes_invisibility.remove
tt.main_script.update = scripts.mod_track_target.update
tt.modifier.duration = nil
tt.modifier.vis_bans = bor(F_FLYING, F_BOSS)
tt.modifier.vis_flags = F_RANGED
tt.render.sprites[1].size_names = {
	"small",
	"small",
	"large"
}
tt.render.sprites[1].prefix = "mod_xerxes_invisibility"
tt.render.sprites[1].name = "small"
tt.render.sprites[1].draw_order = 2
tt = E.register_t(E, "decal_stage82_flame", "decal")
tt.render.sprites[1] = E.clone_c(E, "sprite")
tt.render.sprites[1].name = "decal_stage82_burner_fire"
tt.render.sprites[1].z = Z_OBJECTS
tt.render.sprites[1].random_ts = 0.3333333333333333
tt = E.register_t(E, "enemy_reaper_lord", "enemy")

E.add_comps(E, tt, "melee", "death_spawns")

image_y = 92
anchor_y = 16/image_y
tt.death_spawns.name = "fx_coin_shower"
tt.death_spawns.concurrent_with_death = true
tt.death_spawns.offset = v(0, 35)
tt.enemy.gold = 250
tt.enemy.lives_cost = 20
tt.enemy.melee_slot = v(48, 0)
tt.health.armor = 0
tt.health.dead_lifetime = fts(50)
tt.health.hp_max = 2500
tt.health_bar.offset = v(0, 59)
tt.health_bar.type = HEALTH_BAR_SIZE_MEDIUM
tt.info.portrait = (IS_PHONE_OR_TABLET and "portraits_sc_0098") or "info_portraits_endless_0002"
tt.main_script.insert = scripts.enemy_basic.insert
tt.main_script.update = scripts.enemy_mixed.update
tt.motion.max_speed = FPS*0.8
tt.render.sprites[1].prefix = "enemy_reaper_lord"
tt.render.sprites[1].anchor.y = anchor_y
tt.ui.click_rect = r(-35, 0, 70, 80)
tt.unit.can_explode = false
tt.unit.hit_offset = v(0, 16)
tt.unit.mod_offset = v(0, 20)
tt.unit.blood_color = BLOOD_GREEN
tt.unit.size = UNIT_SIZE_MEDIUM
tt.vis.bans = bor(F_SKELETON, F_POLYMORPH, F_TELEPORT)
tt.vis.flags = bor(F_ENEMY, F_BOSS, F_MINIBOSS)
tt.sound_events.death = "FrontiersEndlessToeeMiniBossDeath"
tt.melee.attacks[1] = E.clone_c(E, "area_attack")
tt.melee.attacks[1].cooldown = 2
tt.melee.attacks[1].count = 10
tt.melee.attacks[1].damage_max = 45
tt.melee.attacks[1].damage_min = 20
tt.melee.attacks[1].damage_radius = 45
tt.melee.attacks[1].damage_type = DAMAGE_PHYSICAL
tt.melee.attacks[1].hit_times = {
	fts(7),
	fts(16)
}
tt.melee.attacks[1].hit_offset = tt.enemy.melee_slot
tt.melee.attacks[1].sound = "FrontiersEndlessToeeMiniBossAttack"
tt.melee.attacks[1].sound_args = {
	delay = fts(5)
}
tt.melee.attacks[1].pop = {
	"pop_sok",
	"pop_pow"
}
tt.melee.attacks[1].pop_chance = 0.1
tt = E.register_t(E, "eb_alien", "decal_scripted")

E.add_comps(E, tt, "attacks")

anchor_y = 0.24742268041237114
tt.attacks.list[1] = E.clone_c(E, "bullet_attack")
tt.attacks.list[1].animation = "spit"
tt.attacks.list[1].sound = "FrontiersEndlessToeeBossAcidSpit"
tt.attacks.list[1].bullet = "alien_spit"
tt.attacks.list[1].hit_time = fts(9)
tt.attacks.list[1].bullet_start_offset = v(-68, 44)
tt.attacks.list[1].vis_bans = F_FLYING
tt.attacks.list[2] = E.clone_c(E, "mod_attack")
tt.attacks.list[2].animation = "screech"
tt.attacks.list[2].mod = "mod_alien_screech"
tt.attacks.list[2].sound = "FrontiersEndlessToeeBossScreech"
tt.attacks.list[3] = E.clone_c(E, "spawn_attack")
tt.attacks.list[3].entity = "enemy_alien_reaper"
tt.attacks.list[3].sound = "FrontiersEndlessToeeBossSpawnEgg"
tt.attacks.list[3].pis = {
	2,
	3
}
tt.attacks.list[3].animation = "lay_egg"
tt.attacks.list[4] = E.clone_c(E, "spawn_attack")
tt.attacks.list[4].entity = "alien_breeder_spawner"
tt.attacks.list[4].spawn_sources = {
	{
		pi = 10,
		points = {
			v(442, 472),
			v(418, 468),
			v(468, 474)
		}
	},
	{
		pi = 11,
		points = {
			v(573, 302),
			v(551, 309),
			v(601, 312)
		}
	},
	{
		pi = 12,
		points = {
			v(355, 120),
			v(336, 131),
			v(378, 140)
		}
	}
}
tt.main_script.update = scripts.eb_alien.update
tt.render.sprites[1].name = "theBroodmother_shadow"
tt.render.sprites[1].anchor.y = anchor_y
tt.render.sprites[1].animated = false
tt.render.sprites[1].z = Z_OBJECTS_COVERS
tt.render.sprites[2] = E.clone_c(E, "sprite")
tt.render.sprites[2].prefix = "eb_alien_l1"
tt.render.sprites[2].name = "idle"
tt.render.sprites[2].anchor.y = anchor_y
tt.render.sprites[2].z = Z_OBJECTS_COVERS
tt.render.sprites[2].group = 1
tt.render.sprites[3] = E.clone_c(E, "sprite")
tt.render.sprites[3].prefix = "eb_alien_l2"
tt.render.sprites[3].name = "idle"
tt.render.sprites[3].anchor.y = anchor_y
tt.render.sprites[3].z = Z_OBJECTS_COVERS
tt.render.sprites[3].group = 1
tt.render.sprites[4] = E.clone_c(E, "sprite")
tt.render.sprites[4].prefix = "eb_alien_l3"
tt.render.sprites[4].name = "idle"
tt.render.sprites[4].anchor.y = anchor_y
tt.render.sprites[4].z = Z_OBJECTS_COVERS
tt.render.sprites[4].group = 1
tt = E.register_t(E, "alien_spit", "bullet")
tt.bullet.flight_time_base = fts(10)
tt.bullet.flight_time_factor = fts(0.04)
tt.bullet.align_with_trajectory = true
tt.bullet.hide_radius = 3
tt.bullet.hit_fx = "fx_alien_spit_hit"
tt.bullet.hit_decal = "alien_spit_aura"
tt.render.sprites[1].name = "alien_spit_flying"
tt.render.sprites[1].anchor.x = 0.8108108108108109
tt.sound_events.hit = "FrontiersEndlessToeeBossAcidGround"
tt.main_script.insert = scripts.enemy_bomb.insert
tt.main_script.update = scripts.enemy_bomb.update
tt = E.register_t(E, "alien_spit_aura", "aura")

E.add_comps(E, tt, "render", "tween")

tt.render.sprites[1].name = "alien_spit_aura"
tt.render.sprites[1].z = Z_DECALS
tt.main_script.insert = scripts.alien_spit_aura.insert
tt.main_script.update = scripts.aura_apply_mod.update
tt.aura.mod = "mod_alien_spit"
tt.aura.vis_bans = bor(F_ENEMY, F_FLYING)
tt.aura.vis_flags = bor(F_MOD, F_POISON)
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
		v(0.4, 0.4)
	},
	{
		fts(16),
		v(1, 1)
	}
}
tt = E.register_t(E, "alien_spit_aura_bubbles")

E.add_comps(E, tt, "pos", "main_script")

tt.main_script.update = scripts.alien_spit_aura_bubbles.update
tt.random_offsets = {
	v(-14, -5),
	v(-14, 10),
	v(17, -5),
	v(17, 10)
}
tt.fx = "fx_alien_spit_bubble"
tt = E.register_t(E, "mod_alien_spit", "mod_poison")
tt.dps.kill = false
tt.main_script.insert = scripts.mod_alien_spit.insert
tt = E.register_t(E, "fx_alien_spit_bubble", "fx")
tt.render.sprites[1].name = "fx_alien_spit_bubble"
tt.render.sprites[1].sort_y_offset = -20
tt.render.sprites[1].z = Z_DECALS
tt = E.register_t(E, "fx_alien_spit_hit", "fx")
tt.render.sprites[1].name = "fx_alien_spit_hit"
tt.render.sprites[1].anchor.y = 0.37037037037037035
tt = E.register_t(E, "alien_breeder_spawner", "decal_scripted")

E.add_comps(E, tt, "spawner")

tt.main_script.update = scripts.alien_breeder_spawner.update
tt.render.sprites[1].prefix = "fx_alien_breeder_spawner"
tt.render.sprites[1].name = "spawn"
tt.render.sprites[1].hidden = true
tt.render.sprites[1].loop = false
tt.render.sprites[1].hide_after_runs = 1
tt.spawner.count = 3
tt.spawner.entity = "enemy_alien_breeder"
tt.spawner.pi = nil
tt.spawner.spi = 1
tt.spawner.ni = 3
tt = E.register_t(E, "mod_alien_screech", "modifier")

E.add_comps(E, tt, "render")

tt.render.sprites[1].name = "mod_alien_screech"
tt.render.sprites[1].random_ts = 0.5
tt.render.sprites[1].anchor.y = -0.25
tt.damage_factor = nil
tt.speed_factor = nil
tt.main_script.update = scripts.mod_track_target.update
tt.main_script.insert = scripts.mod_alien_screech.insert
tt.main_script.remove = scripts.mod_alien_screech.remove
tt = RT("mod_slow_curse", "mod_slow")
tt.main_script.insert = scripts1.mod_slow_curse.insert
tt.modifier.excluded_templates = {
	"enemy_bluegale"
}
tt = E.register_t(E, "water_death", "aura")
tt.main_script.update = mylua.death_in_water.update
tt = RT("timed_spawns_soldiers", "aura")
tt.main_script.update = mylua.remove_and_spawn_hero.update

tt = E.register_t(E, "pop_mage", "pop")
tt.render.sprites[1].name = "elven_pops_0001"
tt = E.register_t(E, "pop_archer", "pop")
tt.render.sprites[1].name = "elven_pops_0002"
tt = E.register_t(E, "pop_barrack1", "pop")
tt.render.sprites[1].name = "elven_pops_0003"
tt = E.register_t(E, "pop_barrack2", "pop")
tt.render.sprites[1].name = "elven_pops_0004"
tt = E.register_t(E, "pop_artillery", "pop")
tt.render.sprites[1].name = "elven_pops_0005"
tt = E.register_t(E, "pop_high_elven", "pop")
tt.render.sprites[1].name = "elven_pops_0007"
tt = E.register_t(E, "pop_death", "pop")
tt.render.sprites[1].name = "elven_pops_0011"
tt = E.register_t(E, "pop_druid_henge", "pop")
tt.render.sprites[1].name = "elven_pops_0016"
tt = E.register_t(E, "pop_entwood", "pop")
tt.render.sprites[1].name = "elven_pops_0017"
tt = E.register_t(E, "pop_crit_mages", "pop")
tt.render.sprites[1].name = "elven_pops_0023"
tt = E.register_t(E, "pop_crit_high_elven", "pop")
tt.render.sprites[1].name = "elven_pops_0025"

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
tt = E.register_t(E, "fx_arrow_soldier_re_hit", "fx")
tt.render.sprites[1].name = "fx_arrow_soldier_re_hit"
tt = E.register_t(E, "fx_dagger_drow_hit", "fx")
tt.render.sprites[1].name = "fx_dagger_drow_hit"

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

tt = E.register_t(E, "elven_arrow_1", "arrow")
tt.bullet.damage_min = 2
tt.bullet.damage_max = 5
tt.bullet.flight_time_min = fts(11)
tt.bullet.flight_time_factor = fts(5)*2
tt.bullet.pop = {
	"pop_archer"
}
tt = E.register_t(E, "elven_arrow_2", "elven_arrow_1")
tt.bullet.damage_min = 4
tt.bullet.damage_max = 9
tt = E.register_t(E, "elven_arrow_3", "elven_arrow_1")
tt.bullet.damage_min = 5
tt.bullet.damage_max = 11

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
tt.bullet.pop_mage_el_empowerment = {
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
tt.alter_reality_chance = 0.1
tt.alter_reality_mod = "mod_teleport_mage"
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

tt = E.register_t(E, "bolt_high_elven_weak", "bolt_elves")
tt.bullet.damage_max = 10
tt.bullet.damage_min = 5
tt.bullet.hit_fx = "fx_bolt_high_elven_weak_hit"
tt.bullet.particles_name = "ps_bolt_high_elven"
tt.bullet.pop = {
	"pop_mage"
}
tt.bullet.pop_mage_el_empowerment = {
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
tt.bullet.pop_mage_el_empowerment = {
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
tt.bullet.damage_min = 16
tt.bullet.damage_max = 32
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

tt.bullet.damage_max = 50
tt.bullet.damage_min = 30
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
tt.bullet.damage_max = 106
tt.bullet.damage_min = 62
tt.bullet.damage_radius = 55
tt.bullet.pop = {
	"pop_entwood"
}
tt.render.sprites[1].name = "artillery_tree_proys_0001"
tt.sound_events.insert = "TowerEntwoodCocoThrow"
tt.sound_events.hit = "TowerEntwoodCocoExplosion"
tt = E.register_t(E, "rock_firey_nut", "rock_entwood")
tt.bullet.damage_max = 0
tt.bullet.damage_max_inc = 135
tt.bullet.damage_min = 0
tt.bullet.damage_min_inc = tt.bullet.damage_max_inc
tt.bullet.damage_radius = 65
tt.bullet.hit_payload = "aura_fiery_nut"
tt.bullet.hit_fx = "fx_fiery_nut_explosion"
tt.bullet.hit_decal = nil
tt.render.sprites[1].name = "artillery_tree_proys_0002"
tt.sound_events.hit = "TowerEntwoodFieryExplote"
tt = E.register_t(E, "arrow_soldier_barrack_2", "arrow")
tt.bullet.damage_max = 7
tt.bullet.damage_min = 3
tt.bullet.flight_time = fts(15)
tt.bullet.reset_to_target_pos = true
tt = E.register_t(E, "arrow_soldier_barrack_3", "arrow_soldier_barrack_2")
tt.bullet.damage_max = 12
tt.bullet.damage_min = 8
tt = E.register_t(E, "arrow_soldier_re_2", "arrow")
tt.bullet.damage_max = 10
tt.bullet.damage_min = 6
tt.bullet.reset_to_target_pos = true
tt.bullet.flight_time = fts(13)
tt.bullet.hide_radius = 2
tt.bullet.hit_fx = "fx_arrow_soldier_re_hit"
tt.bullet.miss_decal = "reinforce_proy_0010"
tt.bullet.rotation_speed = (FPS*40*math.pi)/180
tt.render.sprites[1].name = "reinforce_proy_0001"
tt = E.register_t(E, "arrow_soldier_re_3", "arrow_soldier_re_2")
tt.bullet.damage_max = 20
tt.bullet.damage_min = 10
tt = E.register_t(E, "arrow_soldier_re_4", "arrow_soldier_re_2")
tt.bullet.damage_max = 20
tt.bullet.damage_min = 10
tt = E.register_t(E, "arrow_soldier_re_5", "arrow_soldier_re_2")
tt.bullet.damage_max = 30
tt.bullet.damage_min = 20
tt = RT("dagger_drow", "bullet")
tt.bullet.damage_max = 14
tt.bullet.damage_min = 10
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
tt = E.register_t(E, "aura_fiery_nut", "aura")

E.add_comps(E, tt, "render", "tween")

tt.aura.cycle_time = 0.3
tt.aura.duration = 5
tt.aura.mod = "mod_fiery_nut"
tt.aura.radius = 65
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
	"mod_ogre_magi_shield"
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
	135,
	150
}
tt.damage_type = bor(DAMAGE_MAGICAL, DAMAGE_NO_KILL)
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
tt.modifier.duration = 5
tt.attack = E.clone_c(E, "bullet_attack")
tt.attack.max_range = 100
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
tt.dps.damage_inc = 1
tt.dps.damage_type = DAMAGE_TRUE
tt.dps.damage_every = fts(3)
tt.dps.kill = true
tt.main_script.insert = scripts2.mod_dps.insert
tt.main_script.update = scripts2.mod_dps.update
tt.modifier.duration = 6
tt.render.sprites[1].prefix = "fire"
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

tt = RT("mod_life_drain_drow", "modifier")

AC(tt, "render")

tt.heal_factor = 1
tt.heal_remove_modifiers = {
	"mod_drider_poison",
	"mod_son_of_mactans_poison"
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
return 
