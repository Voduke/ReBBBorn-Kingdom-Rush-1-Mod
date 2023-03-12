local log = require("klua.log"):new("game_scripts")

require("klua.table")

local km = require("klua.macros")
local signal = require("hump.signal")
local AC = require("achievements")
local E = require("entity_db")
local GR = require("grid_db")
local GS = require("game_settings")
local P = require("path_db")
local S = require("sound_db")
local SU = require("script_utils")
local U = require("utils")
local LU = require("level_utils")
local UP = require("upgrades")
local V = require("klua.vector")
local W = require("wave_db")
local bit = require("bit")
local band = bit.band
local bor = bit.bor
local bnot = bit.bnot

require("i18n")

local scripts = require("scripts")

local function queue_insert(store, e)
	simulation:queue_insert_entity(e)
end

local function queue_remove(store, e)
	simulation:queue_remove_entity(e)
end

local function simply_unit_animation_wait(entity, idx, times, can_dead, can_stun, can_rally, func)
	idx = idx or 1
	entity = entity or this

	while not U.animation_finished(entity, idx, times) do
		if can_dead and entity.health and entity.health.dead then
		break
		end
		if can_stun and entity.unit and entity.unit.is_stunned then
		break
		end
		if can_rally and entity.nav_rally and entity.nav_rally.new then
		break
		end
		if func and func(store) then
		break
		end
		coroutine.yield()
	end
end

local function source_modifiers(store, entity, exclude_mod)
	local mods = table.filter(store.entities, function (k, v)
		return v.modifier and v.modifier.target_id == entity.id and v ~= exclude_mod
	end)

	for _, m in pairs(mods) do
		m.pos = entity.pos
	end
end

local function source_auras(store, entity, exclude_aura)
	local auras = table.filter(store.entities, function (k, v)
		return v.aura and v.aura.source_id == entity.id and v ~= exclude_mod
	end)

	for _, a in pairs(auras) do
		a.pos = entity.pos
	end
end

local function simply_unit_wait(store, this, time, can_dead, can_stun, can_rally, func)
	return U.y_wait(store, time, function (store, time)
		if can_dead and this.health and this.health.dead then
		return true
		end
		if can_stun and this.unit and this.unit.is_stunned then
		return true
		end
		if can_rally and this.nav_rally and this.nav_rally.new then
		return true
		end
		if func and func(store, time) then
		return true
		end
	end)
end

local function queue_damage(store, damage)
	table.insert(store.damage_queue, damage)
end

local function fts(v)
	return v / FPS
end

local function v(v1, v2)
	return {
		x = v1,
		y = v2
	}
end

local IS_PHONE = KR_TARGET == "phone"
local IS_CONSOLE = KR_TARGET == "console"

local function tpos(e)
	return e.tower and e.tower.range_offset and V.v(e.pos.x + e.tower.range_offset.x, e.pos.y + e.tower.range_offset.y) or e.pos
end

scripts.tower_tesla = {
	get_info = function (this)
		local min, max, d_type = nil
		local b = E:get_template(this.attacks.list[1].bullet)
		local m = E:get_template(b.bullet.mod)
		d_type = m.dps.damage_type
		local bounce_factor = UP:get_upgrade("engineer_efficiency") and 1 or b.bounce_damage_factor
		max = b.bounce_damage_max
		min = b.bounce_damage_min
		max = math.ceil(max * bounce_factor * this.tower.damage_factor)
		min = math.ceil(min * bounce_factor * this.tower.damage_factor)

		return {
			type = STATS_TYPE_TOWER,
			damage_min = min,
			damage_max = max,
			damage_type = d_type,
			range = this.attacks.range,
			cooldown = this.attacks.list[1].cooldown
		}
	end,
	update = function (this, store, script)
		local tower_sid = 2
		local a = this.attacks
		local ar = this.attacks.list[1]
		local ao = this.attacks.list[2]
		local pow_b = this.powers.bolt
		local pow_o = this.powers.overcharge
		local pow_c = this.powers.crazy
		local crazy = false
		local last_ts = store.tick_ts
		ar.ts = store.tick_ts
		local aa, pow = nil

		while true do
::again::
			if this.tower.blocked then
				coroutine.yield()
			else
				for k, pow in pairs(this.powers) do
						if pow_c.level >= 1 and not crazy then
						crazy = true
						a.min_cooldown = a.min_cooldown + pow_c.cooldown_inc * pow_c.level
						a.loops = pow_c.loops_list
						a.range = a.range + pow_c.range_inc * pow_c.level
						ar.range = ar.range + pow_c.range_inc * pow_c.level
						ar.cooldown = ar.cooldown + pow_c.cooldown_inc * pow_c.level
						ar.true_chance = ar.true_chance + pow_c.chance_inc * pow_c.level
						end
					if pow.changed then
						pow.changed = nil

						if pow == pow_b then
							-- Nothing
						elseif pow == pow_o then
							-- Nothing
						elseif pow == pow_c then
						crazy = true
						a.min_cooldown = a.min_cooldown + pow_c.cooldown_inc * pow_c.level
						a.loops = pow_c.loops_list
						a.range = a.range + pow_c.range_inc * pow_c.level
						ar.range = ar.range + pow_c.range_inc * pow_c.level
						ar.cooldown = ar.cooldown + pow_c.cooldown_inc * pow_c.level
						ar.true_chance = ar.true_chance + pow_c.chance_inc * pow_c.level
						end
					end
				end

				if ar.cooldown < store.tick_ts - ar.ts then
					local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, ar.node_prediction, ar.vis_flags, ar.vis_bans)

					if enemy then
						local PEP = P:predict_enemy_pos(enemy, ar.node_prediction)
						if U.is_inside_ellipse(tpos(this), PEP, a.range) then
						--nothing
						else
						if not U.is_inside_ellipse(tpos(this), enemy.pos, a.range) then
						goto again
						end
					end
						ar.ts = store.tick_ts
						U.animation_start(this, ar.animation, nil, store.tick_ts, false, tower_sid)
					local loops = a.loops[U.random_table_idx(a.loop_chances)]
					for i = 1, math.random(loops, loops) do
						U.y_wait(store, ar.shoot_time / loops)
						if enemy.health.dead or not store.entities[enemy.id] or not U.is_inside_ellipse(tpos(this), enemy.pos, a.range * a.range_check_factor) then
							enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, ar.vis_flags, ar.vis_bans)
						end

						if enemy then
							S:queue(ar.sound_shoot)

							local b = E:create_entity(ar.bullet)
							local bm = E:get_template(b.bullet.mod)
							b.pos.y = this.pos.y + ar.bullet_start_offset.y
							b.pos.x = this.pos.x + ar.bullet_start_offset.x
							b.bullet.damage_factor = this.tower.damage_factor
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
							b.bullet.target_id = enemy.id
							b.bullet.source_id = this.id
							b.bullet.level = pow_b.level
							if (ar.true_chance == 1 or math.random() < ar.true_chance) then
							bm.dps.damage_type = bor(DAMAGE_TRUE, DAMAGE_NO_SHIELD_HIT)
							else
							bm.dps.damage_type = bor(DAMAGE_ELECTRICAL, DAMAGE_ONE_SHIELD_HIT)
						end

							queue_insert(store, b)
							else
						if pow_o.level > 0 then
							local b = E:create_entity(ao.aura)
							b.pos.y = this.pos.y + ao.bullet_start_offset.y
							b.pos.x = this.pos.x + ao.bullet_start_offset.x
							b.aura.source_id = this.id
							b.aura.level = pow_o.level
							if crazy then
							b.aura.true_chance = b.aura.true_chance + pow_c.chance_inc * pow_c.level
							b.aura.radius = a.range
							end
							if (b.aura.true_chance == 1 or math.random() < b.aura.true_chance) then
							b.aura.damage_type = DAMAGE_TRUE
							else
							b.aura.damage_type = DAMAGE_ELECTRICAL
						end

							queue_insert(store, b)
						end
						goto out
					end
						if pow_o.level > 0 then
							local b = E:create_entity(ao.aura)
							b.pos.y = this.pos.y + ao.bullet_start_offset.y
							b.pos.x = this.pos.x + ao.bullet_start_offset.x
							b.aura.source_id = this.id
							b.aura.level = pow_o.level
							if crazy then
							b.aura.true_chance = b.aura.true_chance + pow_c.chance_inc * pow_c.level
							b.aura.radius = a.range
							end
							if (b.aura.true_chance == 1 or math.random() < b.aura.true_chance) then
							b.aura.damage_type = DAMAGE_TRUE
							else
							b.aura.damage_type = DAMAGE_ELECTRICAL
						end
							queue_insert(store, b)
						end
					end
		::out::
						U.y_animation_wait(this, tower_sid)
					end
				end

				U.animation_start(this, "idle", nil, store.tick_ts)
				coroutine.yield()
			end
		end
	end
}
scripts.hero_moloch = {
	update = function (this, store, script)
		local h = this.health
		local he = this.hero
		local ad = this.timed_attacks.list[1]
		local brk, sta = nil
		local idle_cooldown = this.idle_flip.cooldown or 3
		local idle_chance = this.idle_flip.chance or 0.5
		local idle_ts = store.tick_ts

		ad.ts = store.tick_ts
	local function no_hero_can()
	if store.level.locked_hero then
	return false
	end
	return store.selected_hero
end
local function ready_to_attack()

		if ad.cooldown < store.tick_ts - ad.ts and not this.unit.is_stunned then
	local dest = V.vclone(this.pos)
		local af = 1
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	dest.x = dest.x + ad.hit_offset.x * af
	dest.y = dest.y + ad.hit_offset.y
		local enemy_d = U.find_nearest_enemy(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
		local enemy = U.find_enemies_in_range(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
		if enemy and #enemy >= (ad.min_count or 0) then
	if ad.sound then
		S:queue(ad.sound, ad.sound_args)
	end
		local an, ann = U.animation_name_facing_point(this, ad.animation, enemy_d.pos)
		U.animation_start(this, an, ann, store.tick_ts, 1)
		if this.render.sprites[1].flip_x then
		af = -1
		else
		af = 1
		end
	dest.x = dest.x + ad.hit_offset.x * af
	dest.y = dest.y + ad.hit_offset.y
	enemy_d = U.find_nearest_enemy(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
	enemy = U.find_enemies_in_range(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
	simply_unit_wait(store, this, ad.hit_time, true, true, true)

	if this.unit.is_stunned or h.dead or this.nav_rally.new then
	return true
	end
	enemy_d = U.find_nearest_enemy(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
	enemy = U.find_enemies_in_range(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
local damage_max = ad.damage_max or 0
local damage_min = ad.damage_min or 0
local damage_type = ad.damage_type or bor(DAMAGE_NONE)
if enemy then
	for _, s in pairs(enemy) do
		local d = E:create_entity("damage")
		d.damage_type = damage_type
		d.source_id = this.id
		d.target_id = s.id
		d.value = math.random(damage_min, damage_max)

		queue_damage(store, d)
					if ad.mods then
	for _, mods in pairs(ad.mods) do
		local mod = E:create_entity(mods)
		mod.modifier.target_id = s.id
		mod.modifier.source_id = this.id

		queue_insert(store, mod)
		
	end
end
	end
else
goto next
end
::next::
	if ad.fx_list then
		for _, f in pairs(ad.fx_list) do
		local fx_name, positions = unpack(f)
			for _, p in pairs(positions) do
		local xo, yo = unpack(p)
		local fx = E:create_entity(fx_name)
		fx.render.sprites[1].ts = store.tick_ts
		fx.pos.x = this.pos.x + xo * af
		fx.pos.y = this.pos.y + yo

		queue_insert(store, fx)
		end
	end
end
		ad.ts = store.tick_ts
			
			simply_unit_animation_wait(this, 1, 1, true, true, true)
			if this.unit.is_stunned or h.dead or this.nav_rally.new then
			return true
			end
		end
	end
::out::
end
if U.flag_has(this.vis.flags, F_BOSS or F_HERO) then
this.unit.can_explode = false
this.unit.can_disintegrate = false
end
		this.health_bar.hidden = false
		this.melee.order = U.attack_order(this.melee.attacks)

		U.y_animation_play(this, "levelup", nil, store.tick_ts, 1)
		while true do
::loop::
			if h.dead then
				SU.y_hero_death_and_respawn(store, this)
			end
		if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, -1)
				SU.soldier_idle(store, this)
				coroutine.yield()
			else
::rally::
		if this.nav_rally.new then
			SU.y_hero_new_rally(store, this)
		else
		--nothing
		end
::net::
		if this.nav_rally.new then
		goto rally
		end
		if h.dead or this.unit.is_stunned then
		goto loop
		end
		if h.dead or this.unit.is_stunned or this.nav_rally.new then
		goto loop
		end
ready_to_attack()
		if this.nav_rally.new then
		goto rally
		end
		if h.dead or this.unit.is_stunned then
		goto loop
		end
		if this.melee then
				brk, sta = SU.y_soldier_melee_block_and_attacks(store, this)

		if sta == A_IN_COOLDOWN and U.animation_finished(this) then
		U.animation_start(this, "idle", nil, store.tick_ts, true)
		end
		if sta ~= A_NO_TARGET then
		coroutine.yield()
		goto net
		else
		coroutine.yield()
		goto out
		end
	end
::out::
				if SU.soldier_go_back_step(store, this) then
				coroutine.yield()
				SU.soldier_go_back_step(store, this)
				goto net
				else
				SU.soldier_idle(store, this)
				SU.soldier_regen(store, this)
		if idle_cooldown < store.tick_ts - idle_ts then
			if math.random() < idle_chance then
				this.render.sprites[1].flip_x = not this.render.sprites[1].flip_x
			end
				idle_ts = store.tick_ts
		end
				coroutine.yield()
				end
			end
		end
	end
}

return scripts
