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
local storage = require("storage")
local GSC = require("game_scripts")
local GSC2 = require("game_scripts_3")
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

scripts.tower_rang22er = {
	update = function (this, store)
		local shooter_sids = {
			3,
			4
		}
		local shooter_idx = 2
		local druid_sid = 5
		local druid_2_sid = 6
		local a = this.attacks
		local aa = this.attacks.list[1]
		local pow_p = this.powers.poison
		local pow_t = this.powers.thorn
		local aa_cod = aa.cooldown
		aa.ts = store.tick_ts

		local function shot_animation(attack, shooter_idx, enemy)
			local ssid = shooter_sids[shooter_idx]
			local soffset = this.render.sprites[ssid].offset
			local s = this.render.sprites[ssid]
			local an, af = U.animation_name_facing_point(this, attack.animation, enemy.pos, ssid, soffset)

			U.animation_start(this, an, af, store.tick_ts, 1, ssid)

			return U.animation_name_facing_point(this, "idle", enemy.pos, ssid, soffset)
		end

		local function shot_bullet(attack, shooter_idx, enemy, level)
			local ssid = shooter_sids[shooter_idx]
			local shooting_up = tpos(this).y < enemy.pos.y
			local shooting_right = tpos(this).x < enemy.pos.x
			local soffset = this.render.sprites[ssid].offset
			local boffset = attack.bullet_start_offset[shooting_up and 1 or 2]
			local b = E:create_entity(attack.bullet)
			b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
			b.pos.y = this.pos.y + soffset.y + boffset.y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			b.bullet.target_id = enemy.id
			b.bullet.level = level
			b.bullet.damage_factor = this.tower.damage_factor
			b.bullet.mod = pow_p.level > 0 and pow_p.mod
			local u = UP:get_upgrade("archer_precision")

			if u and math.random() < u.chance then
				b.bullet.damage_min = b.bullet.damage_min * u.damage_factor
				b.bullet.damage_max = b.bullet.damage_max * u.damage_factor
				b.bullet.damage_type = DAMAGE_TRUE
				b.bullet.pop = {
					"pop_crit"
				}
				b.bullet.pop_conds = DR_DAMAGE
			end

			queue_insert(store, b)
		end
		local function shot_bullet_extra(attack, shooter_idx, enemy2, level)
			local ssid = shooter_sids[shooter_idx]
			local shooting_up = tpos(this).y < enemy2.pos.y
			local shooting_right = tpos(this).x < enemy2.pos.x
			local soffset = this.render.sprites[ssid].offset
			local boffset = attack.bullet_start_offset[shooting_up and 1 or 2]
			local b = E:create_entity(attack.bullet)
			local enemy, enemies = U.find_foremost_enemy(store.entities, enemy2.pos, 0, aa.extra_range, false, aa.vis_flags, aa.vis_bans)
			if not enemy then
				goto out
			end
			local random = table.filter(enemies, function (_, e)
					return not nil
			end)
						if pow_p.level > 0 then
							local random = table.filter(enemies, function (_, e)
								return not U.flag_has(e.vis.bans, F_POISON) and not U.has_modifiers(store, e, pow_p.mod)
							end)
							else
							--nothing
						end
			if #random > 0 then
				enemy = random[math.random(1, #random)]
			end
			b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
			b.pos.y = this.pos.y + soffset.y + boffset.y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			b.bullet.target_id = enemy.id
			b.bullet.level = level
			b.bullet.damage_factor = this.tower.damage_factor
			b.bullet.mod = pow_p.level > 0 and pow_p.mod
			local u = UP:get_upgrade("archer_precision")

			if u and math.random() < u.chance then
				b.bullet.damage_min = b.bullet.damage_min * u.damage_factor
				b.bullet.damage_max = b.bullet.damage_max * u.damage_factor
				b.bullet.damage_type = DAMAGE_TRUE
				b.bullet.pop = {
					"pop_crit"
				}
				b.bullet.pop_conds = DR_DAMAGE
			end

			queue_insert(store, b)
::out::
		end

		while true do
			if this.tower.blocked then
				coroutine.yield()
			else
				for k, pow in pairs(this.powers) do
						if pow_t.level >= 1 and this.render.sprites[druid_sid].hidden then
							this.render.sprites[druid_sid].hidden = false
							local ta = E:create_entity(pow_t.auras[1])
							ta.aura.source_id = this.id
							ta.pos = tpos(this)

							queue_insert(store, ta)
						end
						if pow_t.level >= 2 and this.render.sprites[druid_2_sid].hidden then
							this.render.sprites[druid_2_sid].hidden = false
							local ta = E:create_entity(pow_t.auras[2])
							ta.aura.source_id = this.id
							ta.pos = tpos(this)

							queue_insert(store, ta)
						end
					if pow.changed then
						pow.changed = nil

						if pow == pow_t and this.render.sprites[druid_sid].hidden then
							this.render.sprites[druid_sid].hidden = false
							local ta = E:create_entity(pow_t.auras[1])
							ta.aura.source_id = this.id
							ta.pos = tpos(this)

							queue_insert(store, ta)
						end
						if pow_t.level >= 2 and pow == pow_t and this.render.sprites[druid_2_sid].hidden then
							this.render.sprites[druid_2_sid].hidden = false
							local ta = E:create_entity(pow_t.auras[2])
							ta.aura.source_id = this.id
							ta.pos = tpos(this)

							queue_insert(store, ta)
						end
					end
				end

				if aa.cooldown < store.tick_ts - aa.ts then
					local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

					if enemy then
						if pow_p.level > 0 then
							local poisonable = table.filter(enemies, function (_, e)
								return not U.flag_has(e.vis.bans, F_POISON) and not U.has_modifiers(store, e, pow_p.mod)
							end)

							if #poisonable > 0 then
								enemy = poisonable[1]
							end
						end
							local GXY = table.filter(enemies, function (_, e)
								return not nil
							end)
		if #GXY > 2 then
			for i = 1, #this.render.sprites do 
				this.render.sprites[i].fps = FPS
				this.render.sprites[i].fps = FPS * #GXY / 2
			end
			aa.cooldown = aa_cod / #GXY * 2
		else
			for i = 1, #this.render.sprites do 
				this.render.sprites[i].fps = FPS
			end
			aa.cooldown = aa_cod
		end
						aa.ts = store.tick_ts
						shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)
						local idle_an, idle_af = shot_animation(aa, shooter_idx, enemy)
					if #GXY > 2 then
						U.y_wait(store, aa.shoot_time / #GXY * 2)
						else
						U.y_wait(store, aa.shoot_time)
					end
						if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
								if not enemy then
									goto normal
								end
							shot_bullet(aa, shooter_idx, enemy, pow_p.level)
						end
						if (aa.arrows_chance == 1 or math.random() < aa.arrows_chance) then
						for i = 1, aa.extra_arrows do
							if not enemy then
								goto normal
							end
						if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
							shot_bullet_extra(aa, shooter_idx, enemy, pow_p.level)
						end
					end
				else
					goto normal
			end
::normal::
						U.y_animation_wait(this, shooter_sids[shooter_idx])
						U.animation_start(this, idle_an, idle_af, store.tick_ts, false, shooter_sids[shooter_idx])
					end
				end

				if this.tower.long_idle_cooldown < store.tick_ts - aa.ts then
					for _, sid in pairs(shooter_sids) do
						local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, sid)

						U.animation_start(this, an, af, store.tick_ts, -1, sid)
					end
				end

				coroutine.yield()
			end
		end
	end
}
scripts.tower_muskete222er = {
	update = function (this, store)
		local shooter_sids = {
			3,
			4
		}
		local shooter_idx = 2
		local a = this.attacks
		local aa = this.attacks.list[1]
		local asn = this.attacks.list[2]
		local asi = this.attacks.list[3]
		local ash = this.attacks.list[4]
		local pow_sn = this.powers.sniper
		local pow_sh = this.powers.shrapnel
		local once = true
		aa.ts = store.tick_ts

		local function shot_animation(attack, shooter_idx, enemy, animation)
			local ssid = shooter_sids[shooter_idx]
			local soffset = this.render.sprites[ssid].offset
			local s = this.render.sprites[ssid]
			local an, af, ai = U.animation_name_facing_point(this, animation or attack.animation, enemy.pos, ssid, soffset)

			U.animation_start(this, an, af, store.tick_ts, 1, ssid)

			return an, af, ai
		end

		local function shot_bullet(attack, shooter_idx, ani_idx, enemy, level)
			local ssid = shooter_sids[shooter_idx]
			local shooting_right = tpos(this).x < enemy.pos.x
			local soffset = this.render.sprites[ssid].offset
			local boffset = attack.bullet_start_offset[ani_idx]
			local b = E:create_entity(attack.bullet)
			b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
			b.pos.y = this.pos.y + soffset.y + boffset.y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			b.bullet.target_id = enemy.id
			b.bullet.level = level
			b.bullet.damage_factor = this.tower.damage_factor

			if attack == asn then
				local extra_damage = pow_sn.damage_factor_inc * pow_sn.level * enemy.health.hp_max
				b.bullet.damage_max = b.bullet.damage_max + extra_damage
				b.bullet.damage_min = b.bullet.damage_min + extra_damage
			end

			queue_insert(store, b)

			return b
		end
		if once then
			local aura = E:create_entity("aura_many_shooters")
			aura.aura.source_id = this.id
			queue_insert(store, aura)
			once = false
		end

		while true do
			if this.tower.blocked then
				coroutine.yield()
			else
				for k, pow in pairs(this.powers) do
					if pow.changed then
						pow.changed = nil

						if pow.level == 1 then
							for _, ax in pairs(a.list) do
								if ax.power_name and this.powers[ax.power_name] == pow then
									ax.ts = store.tick_ts
								end
							end
						end

						if pow == pow_sn then
							asi.chance = pow_sn.instakill_chance_inc * pow_sn.level
						end
					end
				end

				if pow_sn.level > 0 then
					for _, ax in pairs({
						asi,
						asn
					}) do
						if (ax.chance == 1 or math.random() < ax.chance) and ax.cooldown < store.tick_ts - ax.ts then
							local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, ax.range, false, ax.vis_flags, ax.vis_bans)

							if not enemy then
								break
							end

							for _, axx in pairs({
								aa,
								asi,
								asn
							}) do
								axx.ts = store.tick_ts
							end

							shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)
							local seeker_idx = km.zmod(shooter_idx + 1, #shooter_sids)
							local an, af, ai = shot_animation(ax, shooter_idx, enemy)

							shot_animation(ax, seeker_idx, enemy, ax.animation_seeker)
							U.y_wait(store, ax.shoot_time)

							if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= ax.range then
								shot_bullet(ax, shooter_idx, ai, enemy, pow_sn.level)
							end

							U.y_animation_wait(this, shooter_sids[shooter_idx])
						end
					end
				end

				if pow_sh.level > 0 and ash.cooldown < store.tick_ts - ash.ts then
					local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, ash.range, false, ash.vis_flags, ash.vis_bans)

					if enemy then
						ash.ts = store.tick_ts
						aa.ts = store.tick_ts
						shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)
						local fuse_idx = km.zmod(shooter_idx + 1, #shooter_sids)
						local ssid = shooter_sids[shooter_idx]
						local fsid = shooter_sids[fuse_idx]
						local an, af, ai = shot_animation(ash, shooter_idx, enemy)

						shot_animation(ash, fuse_idx, enemy, ash.animation_seeker)

						this.render.sprites[fsid].flip_x = fuse_idx < shooter_idx
						this.render.sprites[ssid].draw_order = 5

						U.y_wait(store, ash.shoot_time)

						local shooting_right = tpos(this).x < enemy.pos.x
						local soffset = this.render.sprites[ssid].offset
						local boffset = ash.bullet_start_offset[ai]
						local dest_pos = P:predict_enemy_pos(enemy, ash.node_prediction)
						local src_pos = V.v(this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1), this.pos.y + soffset.y + boffset.y)
						local fx = SU.insert_sprite(store, ash.shoot_fx, src_pos)
						fx.render.sprites[1].r = V.angleTo(dest_pos.x - src_pos.x, dest_pos.y - src_pos.y)

						for i = 1, ash.loops do
							local b = E:create_entity(ash.bullet)
							b.bullet.flight_time = U.frandom(b.bullet.flight_time_min, b.bullet.flight_time_max)
							b.pos = V.vclone(src_pos)
							b.bullet.from = V.vclone(src_pos)
							b.bullet.to = U.point_on_ellipse(V.v(dest_pos.x + enemy.unit.hit_offset.x, dest_pos.y + enemy.unit.hit_offset.y), U.frandom(ash.min_spread, ash.max_spread), (i - 1) * 2 * math.pi / ash.loops)
							b.bullet.level = pow_sh.level

							queue_insert(store, b)
						end

						U.y_animation_wait(this, shooter_sids[shooter_idx])

						this.render.sprites[ssid].draw_order = nil
					end
				end

				if aa.cooldown < store.tick_ts - aa.ts then
					local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)

					if enemy then
						aa.ts = store.tick_ts
						shooter_idx = km.zmod(shooter_idx + 1, #shooter_sids)
						local an, af, ai = shot_animation(aa, shooter_idx, enemy)

						U.y_wait(store, aa.shoot_time)

						if V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
							shot_bullet(aa, shooter_idx, ai, enemy, 0)
						end

						U.y_animation_wait(this, shooter_sids[shooter_idx])
					end
				end

				if this.tower.long_idle_cooldown < store.tick_ts - aa.ts then
					for _, sid in pairs(shooter_sids) do
						local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, sid)

						U.animation_start(this, an, af, store.tick_ts, -1, sid)
					end
				end

				coroutine.yield()
			end
		end
	end
}
scripts.tower_arcane_wizard = {
	get_info = function (this)
		local m = E:get_template("mod_ray_arcane")
		local o = scripts.tower_common.get_info(this)
		o.type = STATS_TYPE_TOWER_MAGE
		o.damage_min = m.dps.damage_min
		o.damage_max = m.dps.damage_max
		o.damage_type = m.dps.damage_type

		return o
	end,
	update = function (this, store)
		local tower_sid = 2
		local shooter_sid = 3
		local teleport_sid = 4
		local druid_sid = 5
		local druid2_sid = 6
		local a = this.attacks
		local ar = this.attacks.list[1]
		local ad = this.attacks.list[2]
		local at = this.attacks.list[3]
		local pow_d = this.powers.disintegrate
		local pow_t = this.powers.teleport
		local last_ts = store.tick_ts
		ar.ts = store.tick_ts
		local aura = E:get_template(at.aura)
		local max_times_applied = E:get_template(aura.aura.mod).max_times_applied
		local aa, pow = nil
		local attacks = {
			ad,
			at,
			ar
		}
		local pows = {
			pow_d,
			pow_t
		}

		local function find_target(aa)
			local target, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, aa.node_prediction, aa.vis_flags, aa.vis_bans, function (e)
				if aa == at then
					return aa.min_nodes <= e.nav_path.ni and (not e.enemy.counts.mod_teleport or e.enemy.counts.mod_teleport < max_times_applied)
				else
					return true
				end
			end)

			return target, pred_pos
		end

		while true do
			if this.tower.blocked then
				coroutine.yield()
			else
				for k, pow in pairs(this.powers) do
					if pow.changed then
						pow.changed = nil

						if pow == pow_d then
							if pow.level == 1 then
								ad.ts = store.tick_ts
							end

							ad.cooldown = pow.cooldown_base + pow.cooldown_inc * pow.level
						end

						if pow == pow_t and pow.level == 1 then
							at.ts = store.tick_ts
						end
					end
				end

				for i, aa in pairs(attacks) do
					pow = pows[i]

					if (not pow or pow.level > 0) and aa.cooldown < store.tick_ts - aa.ts and a.min_cooldown < store.tick_ts - last_ts then
						local enemy, pred_pos = find_target(aa)

						if enemy then
							last_ts = store.tick_ts
							local soffset = this.render.sprites[shooter_sid].offset
							local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

							U.animation_start(this, an, af, store.tick_ts, false, shooter_sid)
							U.animation_start(this, aa.animation, nil, store.tick_ts, false, tower_sid)

							if aa == at then
								this.render.sprites[teleport_sid].ts = last_ts
							end

							U.y_wait(store, aa.shoot_time)

							enemy, pred_pos = find_target(aa)

							if enemy then
								aa.ts = last_ts
								local b = nil

								if aa == at then
							for i = 1, 5 do
									local b = E:create_entity(aa.aura)
									b.pos = V.v(pred_pos.x + math.random(-30, 30), pred_pos.y + math.random(-30, 30))
									b.aura.target_id = enemy.id
									b.aura.source_id = this.id
									b.aura.max_count = pow_t.max_count_base + pow_t.max_count_inc * pow_t.level
									b.aura.level = pow_t.level
									queue_insert(store, b)
								end
								if math.random() < 0.15 then
								for i = 1, 1 do
								local t = E:create_entity("tower_arcane_wizard2")
				t.pos.y = pred_pos.y
				t.pos.x = pred_pos.x
				t.tower.terrain_style = math.random(1, 3)
				t.ui.nav_mesh_id = math.random(1, 3)
				t.tower.default_rally_pos.y = pred_pos.y + math.random(-100, 100)
				t.tower.default_rally_pos.x = pred_pos.x + math.random(-100, 100)
				t.tower.can_be_sold = false
				t.tower.can_be_mod = false

				queue_insert(store, t)
				end
			end
		end
								if aa == ad then
									local b = E:create_entity(aa.bullet)
									b.pos.y = this.pos.y + aa.bullet_start_offset.y
									b.pos.x = this.pos.x + aa.bullet_start_offset.x
									b.bullet.from = V.vclone(b.pos)
									b.bullet.to = V.vclone(enemy.pos)
									b.bullet.target_id = enemy.id
									b.bullet.source_id = this.id
									queue_insert(store, b)
								for i = 1, 1 do
								local bs = E:create_entity(aa.center_entity)
									local cet = E:get_template(aa.center_entity)
									local damage = E:get_template(cet.entity)
									damage.damage_max = pow_d.level * 15
									damage.damage_min = pow_d.level * 10
									bs.render.sprites[1].ts = store.tick_ts
									bs.pos.y = pred_pos.y + math.random(-30, 30)
									bs.pos.x = pred_pos.x + math.random(-30, 30)
									bs.duration = (pow_d.duartion_base + pow_d.duartion_base * pow_d.level) * 1
									bs.count = (pow_d.count_base + pow_d.count_inc * pow_d.level) * 1
									queue_insert(store, bs)
									for i = 1, 2 do
								local bs = E:create_entity(aa.center_entity)
									local cet = E:get_template(aa.center_entity)
									local damage = E:get_template(cet.entity)
									damage.damage_max = pow_d.level * 10
									damage.damage_min = pow_d.level * 5
									bs.render.sprites[1].ts = store.tick_ts
									bs.pos.y = pred_pos.y + math.random(-30, 30)
									bs.pos.x = pred_pos.x + math.random(-30, 30)
									bs.duration = (pow_d.duartion_base + pow_d.duartion_base * pow_d.level) * 1
									bs.count = (pow_d.count_base + pow_d.count_inc * pow_d.level) * 1
									queue_insert(store, bs)
								end
							end
					  end
								if aa == ar then
								local b = E:create_entity(aa.bullet)
									b.pos.y = this.pos.y + aa.bullet_start_offset.y
									b.pos.x = this.pos.x + aa.bullet_start_offset.x
									b.bullet.from = V.vclone(b.pos)
									b.bullet.to = V.vclone(enemy.pos)
									b.bullet.target_id = enemy.id
									b.bullet.source_id = this.id
									queue_insert(store, b)
			end

								U.y_animation_wait(this, tower_sid)
							end
						end
					end
				end

				if this.tower.long_idle_cooldown < store.tick_ts - ar.ts then
					local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

					U.animation_start(this, an, af, store.tick_ts, true, shooter_sid)
				end

				coroutine.yield()
			end
		end
	end
}
scripts.tower_sorc2erer = {
	update = function (this, store)
		local tower_sid = 2
		local shooter_sid = 3
		local polymorph_sid = 4
		local a = this.attacks
		local ab = this.attacks.list[1]
		local ap = this.attacks.list[2]
		local ab_mod = E:get_template(ab.bullet).mod
		local pow_p = this.powers.polymorph
		local pow_e = this.powers.elemental
		local count = 0
		local ba = this.barrack
		local last_ts = store.tick_ts
		local last_soldier_pos = nil
		ab.ts = store.tick_ts
		local aa, pow = nil
		local attacks = {
			ap,
			ab
		}
		local pows = {
			pow_p
		}

		while true do
			if this.tower.blocked then
				coroutine.yield()
			else
				if pow_p.level > 0 and pow_p.changed then
					pow_p.changed = nil

					if pow_p.level == 1 then
						ap.ts = store.tick_ts
					end

					ap.cooldown = pow_p.cooldown_base + pow_p.cooldown_inc * pow_p.level
				end

				if pow_e.level > 0 then
					if pow_e.changed then
						pow_e.changed = nil
						local s = ba.soldiers[1]

						if s and store.entities[s.id] then
							if s.health.dead then
							U.sprites_hide(s)
							queue_remove(store, s)
							s.health.death_ts = 0
							end
							s.unit.level = pow_e.level
							s.health.armor = s.health.armor + s.health.armor_inc
							s.health.hp_max = s.health.hp_max + s.health.hp_inc
							s.health.hp = s.health.hp_max
							s.motion.max_speed = s.motion.max_speed + s.speed_inc
							local ma = s.melee.attacks[1]
							ma.damage_min = ma.damage_min + ma.damage_inc
							ma.damage_max = ma.damage_max + ma.damage_inc
							local ma2 = s.melee.attacks[2]
							ma2.damage_min = ma2.damage_min + ma2.damage_inc
							ma2.damage_max = ma2.damage_max + ma2.damage_inc
							ma2.chance = ma2.chance + ma2.chance_inc
						end
					end

					local s = ba.soldiers[1]

					if s and s.health.dead then
						last_soldier_pos = s.pos
					end

					if not s or s.health.dead and s.health.dead_lifetime < store.tick_ts - s.health.death_ts then
						local ns = E:create_entity(ba.soldier_type)
						ns.soldier.tower_id = this.id
						ns.pos = last_soldier_pos or V.v(ba.rally_pos.x, ba.rally_pos.y)
						ns.nav_rally.pos = V.vclone(ba.rally_pos)
						ns.nav_rally.center = V.vclone(ba.rally_pos)
						ns.nav_rally.new = true
						ns.unit.level = pow_e.level
						ns.health.armor = ns.health.armor + ns.health.armor_inc * ns.unit.level
						ns.health.hp_max = ns.health.hp_max + ns.health.hp_inc * ns.unit.level
						ns.motion.max_speed = ns.motion.max_speed + ns.speed_inc * ns.unit.level
						local ma = ns.melee.attacks[1]
						ma.damage_min = ma.damage_min + ma.damage_inc * ns.unit.level
						ma.damage_max = ma.damage_max + ma.damage_inc * ns.unit.level
						local ma2 = ns.melee.attacks[2]
						ma2.damage_min = ma2.damage_min + ma2.damage_inc * ns.unit.level
						ma2.damage_max = ma2.damage_max + ma2.damage_inc * ns.unit.level
						ma2.chance = ma2.chance + ma2.chance_inc * ns.unit.level

						queue_insert(store, ns)

						ba.soldiers[1] = ns
						s = ns
					end

					if ba.rally_new then
						ba.rally_new = false

						signal.emit("rally-point-changed", this)

						if s then
							s.nav_rally.pos = V.vclone(ba.rally_pos)
							s.nav_rally.center = V.vclone(ba.rally_pos)
							s.nav_rally.new = true

							if not s.health.dead then
								S:queue(this.sound_events.change_rally_point)
							end
						end
					end
				end
				for i, aa in pairs(attacks) do
					pow = pows[i]

					if (not pow or pow.level > 0) and aa.cooldown < store.tick_ts - aa.ts and a.min_cooldown < store.tick_ts - last_ts then
						local enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)
					if not enemy or not enemies then
						enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)
						elseif enemy then
							if aa == ab then
			local random = table.filter(enemies, function (_, e)
					return not U.has_modifiers(store, e, ab_mod)
			end)
			if not random or #random == 0 then
				enemies = enemies
				goto next1
			elseif #random > 0 then
				enemies = random or enemies
				else
				enemies = enemies
			end
::next1::
							end
							last_ts = store.tick_ts
							aa.ts = last_ts
							local soffset = this.render.sprites[shooter_sid].offset
							local an, af, ai = U.animation_name_facing_point(this, aa.animation, enemy.pos, shooter_sid, soffset)

							U.animation_start(this, an, nil, store.tick_ts, false, shooter_sid)
							U.animation_start(this, aa.animation, nil, store.tick_ts, false, tower_sid)

							if aa == ap then
			local random = table.filter(enemies, function (_, e)
					return e.health.hp_max > 2000
			end)
			if not random or #random == 0 then
				enemies = enemies
				goto next2
			elseif #random > 0 then
				enemies = random or enemies
				else
				enemies = enemies
			end
::next2::
								local s_poly = this.render.sprites[polymorph_sid]
								s_poly.hidden = false
								s_poly.ts = last_ts
							end

					U.y_wait(store, aa.shoot_time)
						for _, e in pairs(enemies) do
					if enemy or enemies then
					goto running
					elseif count <= 0 then
					enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)
					goto outt
					elseif count >= 1 then
					count = 0
					enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)
					goto out
					end
				::running::
							if aa == ap and not store.entities[enemy.id] or enemy.health.dead then
								enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)
								if enemy then
									if enemy.health.dead then
									--nothing
									end
								end
							elseif V.dist(tpos(this).x, tpos(this).y, enemy.pos.x, enemy.pos.y) <= a.range then
								local b = nil
								local boffset = aa.bullet_start_offset[ai]
								b = E:create_entity(aa.bullet)
								b.pos.y = this.pos.y + boffset.y
								b.pos.x = this.pos.x + boffset.x
								b.bullet.from = V.vclone(b.pos)
								b.bullet.to = V.vclone(e.pos)
								b.bullet.target_id = e.id
								b.bullet.source_id = this.id
								if #enemies < aa.count and #enemies > 0 then
								b.bullet.damage_max = b.bullet.damage_max * (aa.count / #enemies)
								b.bullet.damage_min = b.bullet.damage_min * (aa.count / #enemies)
							end
								local so = E:create_entity(aa.entity)
								so.pos = V.vclone(e.pos)
								so.nav_rally.pos = V.vclone(e.pos)
								so.nav_rally.center = V.vclone(e.pos)
								so.soldier.tower_id = this.id

								queue_insert(store, b)
							if (chance == 1 or math.random() < aa.entity_chance) then
								queue_insert(store, so)
							end
							count = count + 1
				if count >= aa.count then
					enemy, enemies = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, false, aa.vis_flags, aa.vis_bans)
					count = 0
					goto out
					end
				end
			end
::out::	
			U.y_animation_wait(this, tower_sid)
				goto outt
			else
			goto outt
		end
	end
end
::outt::
				if this.tower.long_idle_cooldown < store.tick_ts - ab.ts then
					local an, af = U.animation_name_facing_point(this, "idle", this.tower.long_idle_pos, shooter_sid)

					U.animation_start(this, an, af, store.tick_ts, true, shooter_sid)
				end
				coroutine.yield()
			end
		end
::ends::
	end
}
scripts.tower_bfg2 = {
	update = function (this, store, script)
		local tower_sid = 2
		local a = this.attacks
		local ab = this.attacks.list[1]
		local am = this.attacks.list[2]
		local ac = this.attacks.list[3]
		local pow_m = this.powers.missile
		local pow_c = this.powers.cluster
		local last_ts = store.tick_ts
		ab.ts = store.tick_ts
		local aa, pow = nil
		local attacks = {
			am,
			ac,
			ab
		}
		local pows = {
			pow_m,
			pow_c
		}

		while true do
			if this.tower.blocked then
				coroutine.yield()
			else
				for k, pow in pairs(this.powers) do
					if pow.changed then
						pow.changed = nil

						if pow == pow_m then
							am.range = am.range_base * (1 + pow_m.range_inc_factor * pow_m.level)

							if pow.level == 1 then
								am.ts = store.tick_ts
							end
						elseif pow == pow_c and pow.level == 1 then
							ac.ts = store.tick_ts
						end
					end
				end

				for i, aa in pairs(attacks) do
					pow = pows[i]

					if (not pow or pow.level > 0) and aa.cooldown < store.tick_ts - aa.ts and (pow == pow_m or a.min_cooldown < store.tick_ts - last_ts) then
						local trigger, enemies, trigger_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)

						if aa == ac or aa == ab then
							if trigger then
								am.cooldown = am.cooldown_mixed
							else
								am.cooldown = am.cooldown_flying
							end
						end

						if not trigger then
						trigger, enemies, trigger_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
						else

							aa.ts = store.tick_ts

							if pow ~= pow_m then
								last_ts = aa.ts
							end
							U.animation_start(this, aa.animation, nil, store.tick_ts, false, tower_sid)
							U.y_wait(store, aa.shoot_time)
							local enemy, __, pred_pos = U.find_foremost_enemy(store.entities, tpos(this), 0, aa.range, aa.node_prediction, aa.vis_flags, aa.vis_bans)
							local dest = enemy and pred_pos or trigger_pos

							if V.dist(tpos(this).x, tpos(this).y, dest.x, dest.y) <= aa.range then
								local b_name = aa.bullets[U.random_table_idx(aa.bullet_chances)]
								local b = E:create_entity(b_name)
								b.pos.y = this.pos.y + aa.bullet_start_offset.y
								b.pos.x = this.pos.x + aa.bullet_start_offset.x
								b.bullet.damage_factor = this.tower.damage_factor
								b.bullet.from = V.vclone(b.pos)
							b.bullet.to = dest
							
								if aa == am then
								b.bullet.to = V.v(b.pos.x + am.launch_vector.x, b.pos.y + am.launch_vector.y)
								for i = 1, max_count do
								U.y_wait(store, am.shoot_time / count)
								local p_name = am.bullets[U.random_table_idx(am.bullets_chances)]
								local p = E:create_entity(p_name)
								p.pos.y = this.pos.y + am.bullet_start_offset.y
								p.pos.x = this.pos.x + am.bullet_start_offset.x
								p.bullet.from = V.vclone(p.pos)
								p.bullet.damage_factor = this.tower.damage_factor
								p.bullet.to = V.v(p.pos.x + am.launch_vector.x, p.pos.y + am.launch_vector.y)
								p.bullet.damage_max = p.bullet.damage_max * this.tower.damage_factor + pow_m.damage_inc * pow_m.level
								p.bullet.damage_min = p.bullet.damage_min * this.tower.damage_factor + pow_m.damage_inc * pow_m.level
								p.bullet.target_id = enemy and enemy.id or trigger.id
								p.bullet.source_id = this.id

								if aa == am then
							b.bullet.to = V.v(b.pos.x + am.launch_vector.x, b.pos.y + am.launch_vector.y)
									b.bullet.damage_max = b.bullet.damage_max * this.tower.damage_factor + pow_m.damage_inc * pow_m.level
									b.bullet.damage_min = b.bullet.damage_min * this.tower.damage_factor + pow_m.damage_inc * pow_m.level
								if b.bullet.damage_inc then
									b.bullet.damage_max = b.bullet.damage_max * this.tower.damage_factor + b.bullet.damage_inc * pow_m.level
									b.bullet.damage_min = b.bullet.damage_min * this.tower.damage_factor + b.bullet.damage_inc * pow_m.level
								queue_remove(store, b)
								queue_insert(store, p)
								end
							end
					end
									AC:inc_check("ROCKETEER")
								else
									if aa == ac then
										b.bullet.fragment_count = pow_c.fragment_count_base + pow_c.fragment_count_inc * pow_c.level
										b.bullet.to = dest
									end
								end
								b.bullet.target_id = enemy and enemy.id or trigger.id
								b.bullet.source_id = this.id
								queue_insert(store, b)
							end
						
								U.y_animation_wait(this, tower_sid)
								goto ends
						end
					end
::ends::
				end

				U.animation_start(this, "idle", nil, store.tick_ts)
				coroutine.yield()
			end
		end
	end
}
scripts.tower_tesl22a = {
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
			if this.tower.blocked then
				coroutine.yield()
			else
				for k, pow in pairs(this.powers) do
						if pow_c.level >= 1 and not crazy then
						crazy = true
						a.min_cooldown = pow_c.cooldown_base + pow_c.cooldown_inc * pow_c.level
						a.loops = pow_c.loops_list
						a.range = pow_c.range_base + pow_c.range_inc * pow_c.level
						ar.range = pow_c.range_base + pow_c.range_inc * pow_c.level
						ar.cooldown = pow_c.cooldown_base + pow_c.cooldown_inc * pow_c.level
						ar.true_chance = pow_c.chance_base + pow_c.chance_inc * pow_c.level
						end
					if pow.changed then
						pow.changed = nil

						if pow == pow_b then
							-- Nothing
						elseif pow == pow_o then
							-- Nothing
						elseif pow == pow_c then
						crazy = true
						a.min_cooldown = pow_c.cooldown_base + pow_c.cooldown_inc * pow_c.level
						a.loops = pow_c.loops_list
						a.range = pow_c.range_base + pow_c.range_inc * pow_c.level
						ar.range = pow_c.range_base + pow_c.range_inc * pow_c.level
						ar.cooldown = pow_c.cooldown_base + pow_c.cooldown_inc * pow_c.level
						ar.true_chance = pow_c.chance_base + pow_c.chance_inc * pow_c.level
						end
					end
				end

				if ar.cooldown < store.tick_ts - ar.ts then
					local enemy = U.find_foremost_enemy(store.entities, tpos(this), 0, a.range, ar.node_prediction, ar.vis_flags, ar.vis_bans)

					if enemy then
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
scripts.tower_elf_holder = {
	get_info = function ()
		local tpl = E:get_template("tower_elf")
		local o = scripts.tower_barrack.get_info(tpl)
		o.respawn = nil

		return o
	end
}
scripts.tower_sasquash_holder = {
	get_info = function ()
		local tpl = E:get_template("tower_sasquash")
		local o = scripts.tower_barrack.get_info(tpl)
		o.respawn = nil

		return o
	end,
	update = function (this, store)
		while true do
			local items = LU.list_entities(store.entities, "fx_fireball_explosion")

			if #items > 0 then
				for _, e in pairs(items) do
					if U.is_inside_ellipse(tpos(this), e.pos, this.unfreeze_radius) then
						this.tower.upgrade_to = this.unfreeze_upgrade_to

						SU.insert_sprite(store, this.unfreeze_fx, this.pos)
						queue_remove(store, this)

						return
					end
				end
			end

			coroutine.yield()
		end
	end
}
scripts.tower_sunray = {
	get_info = function (this)
		local pow = this.powers.ray

		if pow.level == 0 then
			return {
				type = STATS_TYPE_TEXT,
				desc = _((this.info.i18n_key or string.upper(this.template_name)) .. "_DESCRIPTION")
			}
		else
			local a = this.attacks.list[1]
			local b = E:get_template(a.bullet).bullet
			local p = this.powers.ray
			local max = b.damage_max + b.damage_inc * math.max(1, p.level)
			local min = b.damage_min + b.damage_inc * math.max(1, p.level)
			local d_type = b.damage_type

			return {
				type = STATS_TYPE_TOWER,
				damage_min = min,
				damage_max = max,
				damage_type = d_type,
				range = a.range,
				cooldown = a.cooldown
			}
		end
	end,
	can_select_point = function (this, x, y, store)
		return U.find_entity_at_pos(store.entities, x, y, function (e)
			return e.enemy and not e.health.dead and not U.flag_has(e.vis.bans, F_RANGED)
		end)
	end,
	update = function (this, store)
		local pow = this.powers.ray
		local a = this.attacks.list[1]
		local charging = false
		local sid_shooters = {
			7,
			8,
			9,
			10
		}
		local group_tower = "tower"

		while true do
			if pow.level ~= 0 then
				if pow.changed then
					pow.changed = nil
					a.cooldown = a.cooldown_base + a.cooldown_inc * pow.level
					a.ts = store.tick_ts - a.cooldown

					for i = 1, pow.level do
						this.render.sprites[sid_shooters[i]].hidden = false
					end

					charging = true
				end

				if store.tick_ts - a.ts < a.cooldown and not charging then
					this.user_selection.allowed = false
					charging = true

					U.animation_start_group(this, "charging", nil, store.tick_ts, true, group_tower)

					for i = 1, pow.level do
						this.render.sprites[sid_shooters[i]].name = "charge"
					end
				end

				if a.cooldown < store.tick_ts - a.ts then
					if charging then
						charging = false

						for i = 1, pow.level do
							this.render.sprites[sid_shooters[i]].name = "idle"
						end

						U.y_animation_play_group(this, "ready_start", nil, store.tick_ts, 1, group_tower)
						U.animation_start_group(this, "ready_idle", nil, store.tick_ts, true, group_tower)

						this.user_selection.allowed = true
					end

					if this.user_selection.new_pos then
						local pos = this.user_selection.new_pos
						local target = U.find_entity_at_pos(store.entities, pos.x, pos.y, function (e)
							return e.enemy
						end)
						this.user_selection.new_pos = nil
						a.ts = store.tick_ts

						U.animation_start_group(this, "shoot", nil, store.tick_ts, false, group_tower)
						U.y_wait(store, a.shoot_time)

						if target then
							local b = E:create_entity(a.bullet)
							b.pos.y = this.pos.y + a.bullet_start_offset.y
							b.pos.x = this.pos.x + a.bullet_start_offset.x
							b.bullet.from = V.vclone(b.pos)
							b.bullet.to = V.vclone(target.pos)
							b.bullet.target_id = target.id
							b.bullet.level = pow.level
							b.render.sprites[1].scale = V.v(1, b.ray_y_scales[pow.level])

							queue_insert(store, b)
						end

						U.y_animation_wait_group(this, group_tower)
						AC:inc_check("SUN_BURNER")
					end
				end
			end

			coroutine.yield()
		end
	end
}
scripts.soldier_barbarian = {
	on_power_upgrade = function (this, power_name, power)
		if not this._on_power_upgrade_called then
			this._on_power_upgrade_called = true
			this.ranged.attacks[1].animation = this.ranged.attacks[1].animation .. "2"
			this.melee.attacks[1].animations ={
			nil,
			this.melee.attacks[1].animation .. "2",
			nil
			}
			this.melee.attacks[1].loops = 1
			this.melee.attacks[1].hit_times = {
			fts(5),
			fts(12)
			}
			this.melee.attacks[2].animations ={
			nil,
			this.melee.attacks[2].animation .. "2",
			nil
			}
			this.melee.attacks[2].loops = 2
			this.render.sprites[1].angles.walk[1] = this.render.sprites[1].angles.walk[1] .. "2"
			this.idle_flip.last_animation = this.idle_flip.last_animation .. "2"
			this.soldier.melee_slot_offset = V.v(7, 0)
		end
	end
}
scripts.soldier_XYWXZ = {
	get_info = function (this)

		local m = E:get_template(this.melee.attacks[1].mod)
		local min = m.modifier.damage_min
		local max = m.modifier.damage_max

		return {
			type = STATS_TYPE_SOLDIER,
			hp = this.health.hp,
			hp_max = this.health.hp_max,
			damage_min = min,
			damage_max = max,
			armor = this.health.armor
		}
	end
}
scripts.soldier_sasquash = {
	insert = function (this, store)
		if not scripts.soldier_barrack.insert(this, store) then
			return false
		end

		AC:got("HENDERSON")

		return true
	end
}
scripts.enemy_deepman = {
	update = function (this, store, script)
		local burrowed = true
		local spawn = this.tower_spawns
		local him = this.health.hp_max
		local random = true

		while true do
			if this.health.dead then
			him = 0
		random = true
			end
			if random then

			local spawns = 	spawn[math.random(1, #spawn)]
			local t = E:create_entity(spawns)
				t.pos.y = this.pos.y
				t.pos.x = this.pos.x
				t.tower.terrain_style = math.random(1, 3)
				t.ui.nav_mesh_id = math.random(1, 3)
				t.tower.default_rally_pos.y = this.pos.y + math.random(-100, 100)
				t.tower.default_rally_pos.x = this.pos.x + math.random(-100, 100)
				t.tower.can_be_sold = false
				t.tower.can_be_mod = false

				queue_insert(store, t)
			queue_remove(store, this)
				return
			end

			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, -1)
				coroutine.yield()
			else
				
				U.cleanup_blockers(store, this)

				if not burrowed and not U.get_blocker(store, this) then

					while not U.animation_finished(this) do
						coroutine.yield()
					end

					burrowed = true
				end


				if blocker and burrowed then

					U.animation_start(this, an, af, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end

					burrowed = false
					end

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false)

				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.hero_insert = {
	update = function (this, store, script)
	local function count_can()
	local count = 0
	for _, h in pairs(store.entities) do
	if h.template_name == this.entity then
	count = count + 1
	else
	--nothing
	end
end
if this.entity_max then
	if count > this.entity_max then
	return false
	else
	return true
	end
	else
	return true
	end
end
	local sbd = count_can()

			if sbd then
			if this.entity then
			LU.insert_hero(store, this.entity, V.vclone(this.pos))
				end
				queue_remove(store, this)
				return
			end
	end
}
scripts.enemy_can_attack = {
	update = function (this, store, script)

		while true do
					if this.health.dead then
				SU.y_enemy_death(store, this)

				return
			end

			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, -1)
				coroutine.yield()
			else
				
				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
					this.vis.bans = this.vis.bans_below_surface

					SU.remove_modifiers(store, this)
					U.animation_start(this, "down", nil, store.tick_ts, 1)
					this.health_bar_offset = this.health_bar_offset_down
					this.health_bar_scale = this.health_bar_scale_down
					
					while not U.animation_finished(this) do
						coroutine.yield()
					end

				end

				local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false)


				if U.get_blocker(store, this) then
					local an, af = U.animation_name_facing_point(this, "raise", blocker.pos)

					U.animation_start(this, an, af, store.tick_ts, 1)

					while not U.animation_finished(this) do
						coroutine.yield()
					end

					this.vis.bans = this.vis.bans_above_surface
					this.health_bar_offset = this.health_bar_offset_nom
					this.health_bar_scale = this.health_bar_scale_nom
					end
				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

				local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false)

				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_ever_one = {
	update = function (this, store, script)
	local sp = this.render.sprites[1]
local function click ()

			if this.ui.clicked then
			this.enemy.lives_cost = 1
			sp.fps = FPS
			SU.remove_modifiers(store, this)
				this.ui.clicked = nil
				else
			goto out
		end
::out::
end
		while true do
						if this.health.dead then
				SU.y_enemy_death(store, this)

				return
			end

			if this.unit.is_stunned then
			click()
				coroutine.yield()
			else
				
				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end


				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

				local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, click)

				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
					click()
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							click()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_bandit_king = {
	update = function (this, store, script)
	local h = this.health
	local action = true
	local sleep = true
	local once = true
	local prev_immune = this.health.immune_to
	local wave_active = math.random(this.wave_active_min, this.wave_active_max)
	local as = this.timed_attacks.list[1]
	local vis_bans = this.vis.bans

	as.ts = store.tick_ts
	
		while true do
	::ad::
	if sleep and once then
	local an, ann = U.animation_name_facing_point(this, "idle", V.v(this.pos.x + math.random(-44, 44), this.pos.y))
	U.animation_start(this, an, ann, store.tick_ts, 1)
	once = false
	end
		if not sleep then
	if this.werewolf then
		h.hp_max = h.hp_max
		h.hp = 0
	end
	this.health.ignore_damage = nil
	this.health_bar.hidden = nil
	this.vis.bans = vis_bans
	end
	if action then
	this.health.immune_to = prev_immune
	this.health.ignore_damage = nil
	this.health_bar.hidden = nil
	this.vis.bans = vis_bans
	this.pending_removal = false
	end
			while sleep do
		if store.waves_finished and as.cooldown < store.tick_ts - as.ts then
				U.animation_start(this, as.animation, nil, store.tick_ts, 1)
				U.y_animation_wait(this, 1)
				action = true
				sleep = false
				goto ad
			end
			if wave_active <= 0 or as.cooldown <= 0 then
			this.vis.bans = vis_bans
			action = true
			sleep = false
			goto ad
			end
				if store.wave_group_number < wave_active then
				action = false
				U.animation_start(this, "fall", nil, store.tick_ts, true)
				coroutine.yield()
				this.vis.bans = F_ALL
				this.pending_removal = true
				this.health_bar.hidden = true
				this.health.ignore_damage = true
				else
				U.animation_start(this, as.animation, nil, store.tick_ts, 1)
				U.y_animation_wait(this, 1)
				action = true
				sleep = false
				goto ad
			end
		end
		if this.health.dead then
		U.sprites_hide(this)
		this.ui.can_click = false
		local e = E:create_entity("enemy_lycan_werewolf")
	if this.werewolf then
		e.health.hp_max = h.hp_max * 2
		e.health.hp = h.hp_max * 2
		else
		e.health.hp_max = h.hp_max
		e.health.hp = h.hp_max
	end
		e.enemy.lives_cost = this.enemy.lives_cost
		e.enemy.gold = 0
		e.dodge.chance = 0.6
		e.render.sprites[1].name = "raise"
		e.melee.attacks[1].cooldown = 0.7
		e.nav_path.pi = this.nav_path.pi
		e.nav_path.spi = this.nav_path.spi
		e.nav_path.ni = this.nav_path.ni
		e.vis.flags = bor(F_ENEMY, F_BOSS)
	store.lives = store.lives + this.lives_gain
					queue_insert(store, e)
				queue_remove(store, this)

				return
			end
			if this.unit.is_stunned then
				SU.remove_modifiers(store, this)
				U.animation_start(this, "death", nil, store.tick_ts, 1)
				U.y_animation_wait(this, 1)
				U.animation_start(this, "respawn", nil, store.tick_ts, 1)
				U.y_animation_wait(this, 1)
				coroutine.yield()
			end
		if action then

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, click)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_bandit_king_2 = {
	update = function (this, store, script)
	this.enemy.gold_end = this.enemy.gold
	this.enemy.gold = 0
	local hm = this.health.hp_max
	local h = this.health
	local li = this.lives
	local ad = this.death_spawns
	local melee = this.melee.attacks
	local melee2 = this.melee
	local eat = false
	local dead_times = 0
	local click_times = 0

local function click ()
		if this.ui.clicked then
		this.ui.clicked = nil
		if click_times >= 10 then
			goto out
		end
		this.enemy.gold_end = this.enemy.gold_end -5
		store.player_gold = store.player_gold +5
		local fx = nil
		fx = E:create_entity("fx_coin_jump")
		fx.pos = this.pos
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		click_times = click_times +1
		goto out
		else
		goto out
	end
::out::
end
	
		while true do
	::liout::
					if li > 0 then
					live = true
					else
					live = false
				end
		if this.health.hp <= 0 then
	if live then
	if band(h.last_damage_types, bor(DAMAGE_EAT)) ~= 0 then
	li = 0
this.ui.can_select = true
	eat = true
	goto liout
	end
	if band(h.last_damage_types, bor(DAMAGE_INSTAKILL)) ~= 0 then
	li = 0
this.ui.can_select = true
	goto liout
	end
this.ui.can_select = true
	this.health_bar.hidden = false
	this.ui.can_click = false
	this.motion.max_speed = this.motion.max_speed + this.motion.max_speed / 10
	dead_times = dead_times + 1
	this.dodge.chance = dead_times / 5
	melee[1].cooldown = melee[1].cooldown - dead_times * melee2.cooldown_inc_factor
	if melee[1].cooldown <= melee2.min_cooldown then
	melee[1].cooldown = melee2.min_cooldown
	end
	if this.melee.copy_first then
	for i = 1,#melee do
	melee[i].cooldown = melee[1].cooldown
	end
	end
	li = li - 1
	U.animation_start(this, "death", nil, store.tick_ts, 1)
	U.y_animation_wait(this, 1)
	U.animation_start(this, "respawn", nil, store.tick_ts, 1)
	U.y_animation_wait(this, 1)
	this.enemy.gems = 0
	h.dead = false
	this.ui.can_click = true
	h.hp = h.hp_max
	goto liout
				elseif not live then
	if eat then
		store.player_gold = store.player_gold + this.enemy.gold_end
		store.lives = store.lives + this.lives_gain
		U.sprites_hide(this)
		queue_remove(store, this)
		return
	end
		store.player_gold = store.player_gold + this.enemy.gold_end
		store.lives = store.lives + this.lives_gain
		for _, t in pairs(this.dead_fx_list) do
		fx = E:create_entity(t)
		fxg = E:get_template("fx_coin_shower")
		fxg.coin_count = 3
		fx.pos = this.pos
		fx.render.sprites[1].ts = store.tick_ts
		this.ui.can_click = false
		U.sprites_hide(this)
		queue_insert(store, fx)
		queue_remove(store, this)
		end
	end
		return
	end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else

				

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, click)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							click()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.light_door = {
	update = function (this, store, script)
	local action = false
	local sleep = true
	local sp = this.render.sprites[1]
	local jx = 0
	local tp = this.start_ps
	local tlp = this.loop_ps
	local tep = this.end_ps
	local owner = nil
	if this.owner_id then
	owner = store.entities[this.owner_id]
	end
	local wave_active = math.random(this.wave_active_min, this.wave_active_max)

	if sleep then
			while sleep do
			if wave_active <= 0 then 
			action = true
			sleep = false
			goto ad
			end
				if store.wave_group_number < wave_active then
				action = false
				sp.scale = v(0, 0)
				coroutine.yield()
				else
				action = true
				sleep = false
				goto ad
			end
		end
	end
::ad::

	if action then
	while jx < tp do
	sp.fps = FPS * 2
	sp.scale = v(7 * jx / tp, 9 * jx / tp)
	U.animation_start(this, "idle", nil, store.tick_ts, 1)
	U.y_wait(store, fts(1))
	jx = jx +1
	if jx >= tp then
	goto run1
	end
end
::run1::
	while jx >= tp and jx < tlp do
	for i = 1, this.ps_loops do
	U.animation_start(this, "idle", nil, store.tick_ts, 3)
	U.y_wait(store, fts(3))
	U.animation_start(this, "idle", nil, store.tick_ts, 3)
	U.y_wait(store, fts(3))
	U.animation_start(this, "idle", nil, store.tick_ts, 4)
	U.y_wait(store, fts(4))
	end
	if this.in_fx_list and this.in_enemies then
		local t2 = this.in_enemies[U.random_table_idx(this.in_enemy_chances)]
		local d = E:create_entity(t2)
		d.nav_path.pi = this.nav_path.pi
		d.nav_path.spi = math.random(1, 3)
		d.nav_path.ni = this.nav_path.ni + math.random(-6, 8)
		d.pos = P:node_pos(d.nav_path)
		queue_insert(store, d)
		for _, t in pairs(this.in_fx_list) do
		local fx = E:create_entity(t)
		fx.pos = V.v(d.pos.x + d.unit.hit_offset.x, d.pos.y + d.unit.hit_offset.y)
		fx.render.sprites[1].ts = store.tick_ts
		if d.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[d.unit.size]
		end
		queue_insert(store, fx)
		end
	end
	jx = jx +1
if jx >= tlp then
jx = 0
goto run2
end
end
::run2::
while jx < tep do
sp.scale = v(7 - 7 / tep * jx , 9 - 9 / tep * jx)
	U.animation_start(this, "idle", nil, store.tick_ts, 1)
	U.y_wait(store, fts(1))

	jx = jx+1
	
	if jx >= tep then
	goto die
	end
	end
end
::die::
	U.sprites_hide(this)
	queue_remove(store, this)
	return
	end
}
scripts.HMZ_soldier_spawner = {
	update = function (this, store, script)
	local sp = this.spawner
	local s = this.render.sprites[1]
	local jx = 0
	local owner = nil
		if this.tween then
		this.tween.ts = store.tick_ts
		this.tween.remove = true
		this.tween.disabled = false
	end
	if sp.owner_id then
	owner = store.entities[sp.owner_id]
	end
		if sp.entity then
		if this.do_animation then
		U.animation_start(this, this.do_animation, nil, store.tick_ts, 1)
	end
		while jx < (sp.count or 1) do
::out::
			if jx >= (sp.count) then
			goto outt
			end
				local nodes = P:nearest_nodes(this.pos.x, this.pos.y)
				if #nodes > 0 then
				goto run
				else
				goto out
				end
::run::
		local pi, spi, ni = unpack(nodes[1])
		sp.pi = pi
		sp.ni = ni + math.random(sp.spawn_offset[1], sp.spawn_offset[2])
		if P:is_node_valid(sp.pi, sp.ni) then
		--nothing
		else
		goto out
		end
		sp.spi = math.random(1, 3)
		local spos = P:node_pos(sp.pi, sp.spi, sp.ni)
		local so = E:create_entity(sp.entity)
		so.pos = V.vclone(this.pos)
		so.nav_rally.pos = spos
		so.nav_rally.center = spos
		so.nav_rally.new = true
		if sp.entity_animation then
		sp.render.sprites[1].name = sp.entity_animation
		end

		queue_insert(store, so)
		U.y_wait(store, sp.spawn_delay or fts(0.0000001))
		jx = jx + 1
		end
	end
::outt::
			U.y_animation_wait(this, 1)
	if this.tween then
	local paak, pook = unpack(this.tween.props[1].keys)
	U.y_wait(store, pook[1] - (sp.count or 1) * (sp.spawn_delay or 0))
		this.tween.ts = 0
		this.tween.remove = true
		this.tween.disabled = true
	end
		U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.eb_sarelgaz = {
	update = function (this, store, script)
	local h = this.health
	local angry = true
	local alangry = false
	local as = this.timed_attacks.list[1]
	as.ts = store.tick_ts
	local last_ts = store.tick_ts

local function ready_to_attack ()
::loop::
	if alangry then

	SU.remove_modifiers(store, this)
		local targets = U.find_soldiers_in_range(store.entities, this.pos, 0, as.no_immune_range, as.vis_flags, as.vis_bans)

		if targets then
			for _, t in pairs(targets) do
			t.health.immune_to = 0
			end
		end
		if not U.get_blocker(store, this) and as.aura_cooldown < store.tick_ts - as.ts then
		last_ts = store.tick_ts
		as.ts = last_ts
	for _, a in pairs(as.auras) do
		local ta = E:create_entity(a)
		ta.aura.source_id = this.id
		ta.pos = this.pos

		queue_insert(store, ta)
		
		end
	for _, d in pairs(as.decals) do
		local decal = E:create_entity(d)
		decal.pos.x = this.pos.x + math.random(as.decal_offset_x[1], as.decal_offset_x[2])
		decal.pos.y = this.pos.y + math.random(as.decal_offset_y[1], as.decal_offset_y[2])
		decal.render.sprites[1].ts = store.tick_ts

		queue_insert(store, decal)
		end
	end
end


	if angry and h.hp <= h.hp_max * as.hp_factor and not alangry then
			SU.remove_modifiers(store, this)
				alangry = true
		h.dead = false
		h.hp = h.hp_max * as.hp_factor
		this.health_bar.hidden = false
	this.ui.can_click = true
	for i = 1, as.loops do
	if as.sound then
	S:queue(as.sound)
	end
	if as.animation then
	U.animation_start(this, as.animation, nil, store.tick_ts, 1)
	U.y_animation_wait(this, 1)
	end
	end
	if as.music_start then
		S:queue(as.music_start)
	end
		this.motion.max_speed = this.motion.max_speed * as.fps_factor
		for i = 1, #this.melee.attacks do
		this.melee.attacks[i].hit_time = this.melee.attacks[i].hit_time / as.fps_factor
		this.melee.attacks[i].cooldown = this.melee.attacks[i].cooldown / as.fps_factor
	end
		for i = 1, #this.render.sprites do
		this.render.sprites[i].fps = this.render.sprites[i].fps * as.fps_factor
		end
		goto loop
	end
end
		while true do
			::loop::
			if this.health.hp <= 0 then
	if angry and h.hp <= h.hp_max * as.hp_factor and not alangry then
			SU.remove_modifiers(store, this)
				alangry = true
		h.dead = false
this.ui.can_select = true
		h.hp = h.hp_max * as.hp_factor
		this.health_bar.hidden = false
	this.ui.can_click = true
	for i = 1, as.loops do
	S:queue(as.sound)
	U.animation_start(this, as.animation, nil, store.tick_ts, 1)
	U.y_animation_wait(this, 1)
	end
		S:queue(as.music_start)
		this.motion.max_speed = this.motion.max_speed * as.fps_factor
		for i = 1, #this.melee.attacks do
		this.melee.attacks[i].hit_time = this.melee.attacks[i].hit_time / as.fps_factor
		this.melee.attacks[i].cooldown = this.melee.attacks[i].cooldown / as.fps_factor
	end
		for i = 1, #this.render.sprites do
		this.render.sprites[i].fps = this.render.sprites[i].fps * as.fps_factor
		end
		goto loop
	end
				SU.y_enemy_death(store, this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else
				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then

						coroutine.yield()
				end
		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)

				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_troll_brute = {
	update = function (this, store, script)
	local h = this.health
	local angry = true
	local alangry = false
	local as = this.timed_attacks.list[1]

local function ready_to_attack ()
	if angry and h.hp <= h.hp_max * as.hp_factor and not alangry and not h.dead then
				alangry = true
		if as.sound then
		S:queue(as.sound)
		end
		h.hp = h.hp_max * as.hp_factor
		this.motion.max_speed = this.motion.max_speed * as.fps_factor
		for i = 1, #this.melee.attacks do
		this.melee.attacks[i].hit_time = this.melee.attacks[i].hit_time / as.fps_factor
		this.melee.attacks[i].cooldown = this.melee.attacks[i].cooldown / as.fps_factor
	end
		for i = 1, #this.render.sprites do
		this.render.sprites[i].fps = FPS
		this.render.sprites[i].fps = this.render.sprites[i].fps * as.fps_factor
		end
		goto out
		else
		goto out
	end
	::out::
end
		while true do
			if this.health.dead then
				SU.y_enemy_death(store, this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else
				

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)

				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_demon_mage = {
	update = function (this, store, script)
	local h = this.health
	local a = this.timed_attacks
	local as = this.timed_attacks.list[1]
	local ad = this.timed_attacks.list[2]
	local ar = this.timed_attacks.list[3]
	local atp = this.timed_attacks.list[4]
	local once = true
	ad.ts = store.tick_ts
	as.ts = store.tick_ts
	ar.ts = store.tick_ts
	atp.ts = store.tick_ts
	local cg = store.count_groups[ad.count_group_type]
	local ad_max = 0
	local hp_max_inc = 0
	local attacks = {
			as,
			ad,
			ar
		}
local function ad_count()
	if cg[ad.count_group_name] then
	goto net
	else
	return true
	end
::net::
		if ad.count_group_max > cg[ad.count_group_name] then
		return true
		else
		return false
		end
end
local function ready_to_attack()
::loop::
	if atp.cooldown < store.tick_ts - atp.ts then
	local soldiers = U.find_soldiers_in_range(store.entities, this.pos, 0, atp.range, atp.vis_flags, atp.vis_bans)
	if soldiers then
	for _, s in pairs(soldiers) do
	U.unblock_target(store, s)
	end
	else
	--nothing
end
		local fx = E:create_entity(atp.fx_in)
		fx.pos = V.v(this.pos.x + this.unit.hit_offset.x, this.pos.y + this.unit.hit_offset.y)
		if this.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[this.unit.size]
		end
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		this.ui.can_click = false
		this.ui.z = -1
	if (chance == 1 or math.random() < 0.0333) then
		local e = E:create_entity("light_door")
		e.nav_path.pi = this.nav_path.pi
		e.nav_path.spi = math.random(1, 3)
		e.nav_path.ni = this.nav_path.ni
		e.pos = P:node_pos(e.nav_path)
		e.wave_active_min = 1
		e.wave_active_max = 1
		e.start_ps = 20
		e.loop_ps = e.start_ps + 10
		e.ps_loops = 2
		e.end_ps = 10
		e.in_enemies = {
		"enemy_demon_imp",
		"enemy_demon_wolf",
		"enemy_demon"
		}
		e.in_enemy_chances = {
		0.1,
		0.1,
		1
		}
		e.render.sprites[1].ts = store.tick_ts
		queue_insert(store, e)
		end
		this.nav_path.pi = this.nav_path.pi
		this.nav_path.spi = math.random(1, 3)
		this.nav_path.ni = this.nav_path.ni + math.random(atp.node_offset_min, atp.node_offset_max)
		local nav_p = P:node_pos(this.nav_path)
		this.pos = V.vclone(nav_p)
		U.set_destination(this, this.pos)
		this.ui.can_click = true
		this.ui.z = 1
	local auras = table.filter(store.entities, function (k, v)
		return v.aura and v.aura.track_source and v.aura.source_id == this.id
	end)
	for _, a in pairs(auras) do
	a.pos = this.pos
	end
	local modifiers = table.filter(store.entities, function (k, v)
		return v.modifier and v.modifier.target_id == this.id
	end)
	for _, m in pairs(modifiers) do
	m.pos = this.pos
	end
		local fx2 = E:create_entity(atp.fx_out)
		fx2.pos = V.v(this.pos.x + this.unit.hit_offset.x, this.pos.y + this.unit.hit_offset.y)
		if this.unit.size and fx2.render.sprites[1].size_names then
		fx2.render.sprites[1].name = fx2.render.sprites[1].size_names[this.unit.size]
		end
		fx2.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx2)
				coroutine.yield()
			atp.ts = store.tick_ts
			goto loop
		else
		goto tpnext
	end
::tpnext::
			for i, aa in pairs(attacks) do
local ad_can = ad_count()
if once then
once = false
end
		if aa.cooldown < store.tick_ts - aa.ts then

		if aa == as then
		U.animation_start(this, aa.animation, nil, store.tick_ts, 1)
		if aa.sound then
			S:queue(aa.sound)
		end
		U.y_wait(store, aa.cast_time or aa.hit_time or aa.spawn_time or aa.shoot_time)
		aa.ts = store.tick_ts
	if store.level_difficulty == DIFFICULTY_EASY then
		hp_max_inc = aa.hp_max[1]
	elseif store.level_difficulty == DIFFICULTY_NORMAL then
		hp_max_inc = aa.hp_max[2]
	elseif store.level_difficulty == DIFFICULTY_HARD then
		hp_max_inc = aa.hp_max[3]
	else
		hp_max_inc = aa.hp_max[4]
	end
	if h.hp_max <= hp_max_inc then
		h.hp_max = h.hp_max * aa.hp_inc_factor
	if h.hp_max < hp_max_inc then
		h.hp = h.hp * aa.hp_inc_factor
		end
	end
	if h.hp_max > hp_max_inc then
		h.hp_max = hp_max_inc
		aa.cooldown = aa.cooldown_after
	end
		local ta = E:create_entity(aa.aura)
		ta.aura.source_id = this.id
		ta.pos = this.pos

		queue_insert(store, ta)
			U.y_animation_wait(this, 1)
				coroutine.yield()
			goto out
		end
		if aa == ad and ad_can then
		U.animation_start(this, aa.animation, nil, store.tick_ts, 1)
		if aa.sound then
			S:queue(aa.sound)
		end
		U.y_wait(store, aa.cast_time or aa.hit_time or aa.spawn_time or aa.shoot_time)
	if aa == ad then
		aa.cooldown = aa.cooldown_after
	end
		aa.ts = store.tick_ts
	if ad_max >= aa.max then
	ad_max = 3
	aa.count = aa.count_end
	end
	local spawn_min = math.random(aa.spawn_node_offset_min[1], aa.spawn_node_offset_min[2])
	local spawn_max = math.random(aa.spawn_node_offset_max[1], aa.spawn_node_offset_max[2])
		for i = 1, aa.count do
		 if ad_count() then
		 --nothing
		 else
		 goto intout
		 end
		local e_name = aa.entities[U.random_table_idx(aa.entity_chances)]
		local e = E:create_entity(e_name)
	if aa.keep_gold then
		e.enemy.gold = e.enemy.gold
		else
		e.enemy.gold = 0
		end
		e.nav_path.pi = this.nav_path.pi
		e.nav_path.spi = math.random(1, 3)
		e.nav_path.ni = this.nav_path.ni + math.random(spawn_min, spawn_max)
		e.pos = P:node_pos(e.nav_path)
		E:add_comps(e, "count_group")

		e.count_group.name = aa.count_group_name
		e.count_group.type = aa.count_group_type
		local fx = E:create_entity(aa.fx)
		fx.pos = V.v(e.pos.x + e.unit.hit_offset.x, e.pos.y + e.unit.hit_offset.y)
		fx.render.sprites[1].ts = store.tick_ts
		if e.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[e.unit.size]
		end
		queue_insert(store, e)
		queue_insert(store, fx)
		if aa.bullet then
		local b = E:create_entity(aa.bullet)
		b.pos.x = e.pos.x
		b.pos.y = e.pos.y + 100
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(e.pos.x + e.unit.hit_offset.x, e.pos.y + e.unit.hit_offset.y)
		b.bullet.target_id = e.id
		
		queue_insert(store, b)

		end

		end
::intout::
				U.y_animation_wait(this, 1)
				coroutine.yield()
		ad_max = ad_max + 1
		goto out
	end
	if aa == ar then
	local sc = 0
		local soldier_d = U.find_nearest_soldier(store.entities, this.pos, 0, aa.max_range + aa.extra_range, aa.vis_flags, aa.vis_bans)
		local soldier = U.find_soldiers_in_range(store.entities, this.pos, aa.min_range, aa.max_range, aa.vis_flags, aa.vis_bans)
			if not soldier then
			goto out
			else
			local an, ann = U.animation_name_facing_point(this, aa.animation, soldier_d.pos)
			U.animation_start(this, an, ann, store.tick_ts, 1)
		if aa.sound then
			S:queue(aa.sound)
		end
		U.y_wait(store, aa.cast_time or aa.hit_time or aa.spawn_time or aa.shoot_time)
		aa.ts = store.tick_ts
		for _, s in pairs(soldier) do
	local fp = this.render.sprites[1].flip_x
	local fpp = 1
	if fp then
	fpp = -1
	else
	fpp = 1
	end
		local b = E:create_entity(aa.bullet)
		b.pos.x = this.pos.x + aa.bullet_start_offset[1].x * fpp
		b.pos.y = this.pos.y + aa.bullet_start_offset[1].y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(s.pos.x + s.unit.hit_offset.x, s.pos.y + s.unit.hit_offset.y)
		b.bullet.target_id = s.id
		
		queue_insert(store, b)
		sc = sc +1
		if sc >= aa.max_count or not soldier then
		sc = 0
		goto outd
		end
	end
::outd::
					U.y_animation_wait(this, 1)
				coroutine.yield()
			goto out
				end
			goto out
			end
		end
	end
::out::
end
		while true do
				if this.health.dead then
	if (chance == 1 or math.random() < 0.3) then
		local e = E:create_entity("light_door")
		e.nav_path.pi = this.nav_path.pi
		e.nav_path.spi = math.random(1, 3)
		e.nav_path.ni = this.nav_path.ni
		e.pos = P:node_pos(e.nav_path)
		e.wave_active_min = 1
		e.wave_active_max = 1
		e.start_ps = 20
		e.loop_ps = e.start_ps + 10
		e.ps_loops = 2
		e.end_ps = 10
		e.in_enemies = {
		"enemy_demon_imp",
		"enemy_demon_wolf",
		"enemy_demon"
		}
		e.in_enemy_chances = {
		0.1,
		0.1,
		1
		}
		e.render.sprites[1].ts = store.tick_ts
		queue_insert(store, e)
		end
				SU.y_enemy_death(store, this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_swamp_thing_different = {
	update = function (this, store, script)
	local h = this.health
	local a = this.timed_attacks
	local ad = this.timed_attacks.list[1]
	local ash = this.timed_attacks.list[2]
	ad.ts = store.tick_ts
	ash.ts = store.tick_ts
	local attacks = {
			ad,
			ash
		}

local function ready_to_attack()
::loop::
			for i, aa in pairs(attacks) do

		if aa.cooldown < store.tick_ts - aa.ts then

		if aa == ad then
	local af = this.render.sprites[1].flip_x
	local soldiers = U.find_soldiers_in_range(store.entities, V.v(this.pos.x + aa.hit_offset.x, this.pos.y + aa.hit_offset.y), 0, aa.damage_radius, aa.vis_flags, aa.vis_bans)
	if af then
	soldiers = U.find_soldiers_in_range(store.entities, V.v(this.pos.x + aa.hit_offset.x * -1, this.pos.y + aa.hit_offset.y), 0, aa.damage_radius, aa.vis_flags, aa.vis_bans)
	else
	soldiers = U.find_soldiers_in_range(store.entities, V.v(this.pos.x + aa.hit_offset.x * 1, this.pos.y + aa.hit_offset.y), 0, aa.damage_radius, aa.vis_flags, aa.vis_bans)
	end
		U.animation_start(this, aa.animation, nil, store.tick_ts, 1)
		U.y_wait(store, aa.cast_time or aa.hit_time or aa.spawn_time or aa.shoot_time)
		aa.ts = store.tick_ts
				if aa.sound_hit then
			S:queue(aa.sound_hit)
		end
	if soldiers then
	local count = 0
	for _, s in pairs(soldiers) do
		local m = E:create_entity(aa.mod)
		m.modifier.target_id = s.id
		m.modifier.source_id = this.id

		queue_insert(store, m)
		local d = E:create_entity("damage")
		d.damage_type = aa.damage_type
		d.source_id = this.id
		d.target_id = s.id
		d.value = math.random(aa.damage_min, aa.damage_max)

		queue_damage(store, d)
	if aa.count then
		count = count + 1
		if count >= aa.count or not soldiers then
		count = 0
		goto damageout
		end
	end
end
	else
	goto damageout
end
::damageout::
	if aa.hit_fx then
	for _, fx in pairs(aa.hit_fx) do
		local fx = E:create_entity(fx)
		fx.pos = V.vclone(this.pos)
		fx.pos.y = this.pos.y + aa.hit_offset.y
		if af then
		fx.pos.x = this.pos.x + aa.hit_offset.x * -1
		else
		fx.pos.x = this.pos.x + aa.hit_offset.x * 1
		end
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
	end
	if aa.hit_decal then
	for _, decal in pairs(aa.hit_decal) do
		local decal = E:create_entity(decal)
		decal.pos = V.vclone(this.pos)
		decal.pos.y = this.pos.y + aa.hit_offset.y
		if af then
		decal.pos.x = this.pos.x + aa.hit_offset.x * -1
		else
		decal.pos.x = this.pos.x + aa.hit_offset.x * 1
		end
		decal.render.sprites[1].ts = store.tick_ts
		queue_insert(store, decal)
		end
	end
		for i = 1, aa.max_count do
		if aa.entity then
		local e = E:create_entity(aa.entity)
	if aa.keep_gold then
		e.enemy.gold = e.enemy.gold
		else
		e.enemy.gold = 0
		end
		e.nav_path.pi = this.nav_path.pi
		e.nav_path.spi = math.random(1, 3)
		e.nav_path.ni = this.nav_path.ni + math.random(aa.spawn_nodes_offset[1], aa.spawn_nodes_offset[1])
		e.pos = P:node_pos(e.nav_path)
		e.render.sprites[1].name = "raise"
			queue_insert(store, e)
		end
	end
				U.y_animation_wait(this, 1)
				coroutine.yield()
		goto out
	end
		if aa == ash then
	local af = this.render.sprites[1].flip_x
	local soldiers = U.find_soldiers_in_range(store.entities, this.pos, aa.min_range, aa.max_range, aa.vis_flags, aa.vis_bans)
	local soldiern = U.find_nearest_soldier(store.entities, this.pos, aa.min_range, aa.max_range, aa.vis_flags, aa.vis_bans)
	if not soldiers then
	goto out
	end
	local soldierable = table.filter(soldiers, function (_, e)
	return not U.flag_has(e.vis.bans, F_RANGED)
end)
		if #soldierable > 0 then
			soldier = soldierable[1]
		end
	if soldiern then
			local an, ann = U.animation_name_facing_point(this, aa.animation, soldiern.pos)
			U.animation_start(this, an, ann, store.tick_ts, 1)
		U.y_wait(store, aa.cast_time or aa.hit_time or aa.spawn_time or aa.shoot_time)
		aa.ts = store.tick_ts
				if aa.sound then
			S:queue(aa.sound)
		end
	for i = 1, aa.bullet_count do
	local b = E:create_entity(aa.bullet)
		b.pos = V.vclone(this.pos)
		if af then
		b.pos.x = this.pos.x + aa.bullet_start_offset[1].x * -1
		else
		b.pos.x = this.pos.x + aa.bullet_start_offset[1].x * 1
		end
		b.pos.y = this.pos.y + aa.bullet_start_offset[1].y
		b.bullet.flight_time = U.frandom(b.bullet.flight_time_min, b.bullet.flight_time_max)
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(soldiern.pos.x + math.random(b.bullet.random_pos[1].x, b.bullet.random_pos[2].x), soldiern.pos.y + math.random(b.bullet.random_pos[1].y, b.bullet.random_pos[2].y))
		queue_insert(store, b)
		end
	else
	goto bulletout
end
::bulletout::
	if aa.shoot_fx then
	for _, fx in pairs(aa.shoot_fx) do
		local fx = E:create_entity(fx)
		fx.pos = V.vclone(this.pos)
		fx.pos.y = this.pos.y + aa.bullet_start_offset[1].y
		if af then
		fx.pos.x = this.pos.x + aa.bullet_start_offset[1].x * -1
		else
		fx.pos.x = this.pos.x + aa.bullet_start_offset[1].x * 1
		end
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
	end
				U.y_animation_wait(this, 1)
			U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
		goto out
	end
		end
	end
::out::
end
		while true do
				if this.health.dead then

				SU.y_enemy_death(store, this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
							ready_to_attack()
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_shadow_archer_jr = {
	update = function (this, store, script)
	local h = this.health
	local a = this.timed_attacks
	local ra = this.ranged.attacks[1]
	local dp = this.timed_attacks.list[1]
	ra.ts = store.tick_ts
	dp.ts = store.tick_ts

local function ready_to_attack()
				if (dp.cooldown < store.tick_ts - dp.ts) and (h.hp < h.hp_max * dp.hp_factor) and not h.dead then
			local dp_fx_ts = store.tick_ts
			while dp.duration > store.tick_ts - dp_fx_ts do
				h.ignore_damage = true
		U.animation_start(this, dp.animation, nil, store.tick_ts, 1)
			if dp.duration < store.tick_ts - dp_fx_ts then
			goto fxout
		end
			if dp.fx then
		local fx = E:create_entity(dp.fx)
		fx.pos = V.vclone(this.pos)
		fx.pos.x = this.pos.x + math.random(dp.fx_random_pos[1].x, dp.fx_random_pos[1].y)
		fx.pos.y = this.pos.y + math.random(dp.fx_random_pos[2].x, dp.fx_random_pos[2].y)
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
			U.y_wait(store, dp.fx_delay)
	end
		::fxout::
	if dp.mod then
		local mod = E:create_entity(dp.mod)
		mod.modifier.target_id = this.id
		mod.modifier.source_id = this.id

		queue_insert(store, mod)
	end
	if dp.heal then
		h.hp = h.hp + dp.heal
	end
		if h.hp > h.hp_max then
		h.hp = h.hp_max
		end
			h.ignore_damage = nil
		dp.ts = store.tick_ts
		goto out
	end
		if ra.cooldown < store.tick_ts - ra.ts then
	local af = 1
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	local soldiern = U.find_nearest_soldier(store.entities, this.pos, ra.min_range, ra.max_range, ra.vis_flags, ra.vis_bans)
	if not soldiern or U.get_blocker(store, this) then
	soldiern = U.find_nearest_soldier(store.entities, this.pos, ra.min_range, ra.max_range, ra.vis_flags, ra.vis_bans)
	goto out
	else
					if ra.sound then
			S:queue(ra.sound, ra.sound_args)
		end
			for i = 1, #this.render.sprites do
			if not this.render.sprites[i].fps then
				this.render.sprites[i].fps = FPS
			end
				this.render.sprites[i].fps = this.render.sprites[i].fps * (ra.fps_factor or 1)
			end
		if ra.animations[1] then
		local an, ann = U.animation_name_facing_point(this, ra.animations[1], soldiern.pos)
			U.animation_start(this, an, ann, store.tick_ts, 1)
		U.y_animation_wait(this, 1)
	end
		if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	for i = 1, ra.loops do
if not soldiern then
goto loopo
end
if ra.sound_loop then
S:queue(ra.sound_loop, ra.sound_loop_args)
end
	if ra.animations[1] then
		U.animation_start(this, ra.animations[2], nil, store.tick_ts, 1)
	else
	local an, ann = U.animation_name_facing_point(this, ra.animations[2], soldiern.pos)
		U.animation_start(this, an, ann, store.tick_ts, 1)
	end
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	local wait = SU.y_enemy_wait(store, this, ra.shoot_time / (ra.fps_factor or 1))
	if wait then
	coroutine.yield()
	elseif h.dead then
	return h.dead
	end
	local b = E:create_entity(ra.bullet)
		b.pos = V.vclone(this.pos)
		b.pos.x = this.pos.x + ra.bullet_start_offset[1].x * af
		b.pos.y = this.pos.y + ra.bullet_start_offset[1].y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(soldiern.pos.x + soldiern.unit.hit_offset.x, soldiern.pos.y + soldiern.unit.hit_offset.y)
		b.bullet.target_id = soldiern.id
		queue_insert(store, b)
	end
::loopo::
if ra.sound_end then
S:queue(ra.sound_end, ra.sound_end_args)
end
		if ra.animations[3] then
			U.animation_start(this, ra.animations[3], nil, store.tick_ts, 1)
		U.y_animation_wait(this, 1)
	end
			for i = 1, #this.render.sprites do
				this.render.sprites[i].fps = this.render.sprites[i].fps / (ra.fps_factor or 1)
			end
		ra.ts = store.tick_ts
			U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
		goto out
	end
end
::out::
end
		while true do
				if this.health.dead then

				SU.y_enemy_death(store, this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
							ready_to_attack()
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.enemy_pillager = {
	update = function (this, store, script)
	local h = this.health
	local a = this.timed_attacks
	local ra = nil
	if (math.random() < 0.5) then
	ra = this.timed_attacks.list[1]
	ra.ts = store.tick_ts
	goto next
	else
	ra = this.timed_attacks.list[2]
	ra.ts = store.tick_ts
	goto next
	end
::next::
	local sra = this.timed_attacks.list[3]
	sra.ts = store.tick_ts

local function ready_to_attack()

		if ra.cooldown < store.tick_ts - ra.ts then
	local af = 1
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	local towern = U.find_all_towers_in_range(store.entities, this.pos, 0, ra.range, ra, true, true)
	if not towern then
	towern = U.find_all_towers_in_range(store.entities, this.pos, 0, ra.range, ra, true, true)
	goto out
	else
	if ra.sound then
		S:queue(ra.sound or "CBSpectralKnight", ra.sound_args)
	end

		local an, ann = U.animation_name_facing_point(this, ra.animation, towern.pos)
			U.animation_start(this, an, ann, store.tick_ts, 1)

	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end

	local wait = SU.y_enemy_wait(store, this, ra.cast_time or ra.shoot_time)
	if wait then
	coroutine.yield()
	elseif h.dead then
	return h.dead
	end
	if ra.shoot_fx then
	for _, fx in pairs(ra.shoot_fx) do
		local fx = E:create_entity(fx)
		fx.pos = V.vclone(this.pos)
		fx.pos.y = this.pos.y + ra.bullet_start_offset[1].y
		fx.pos.x = this.pos.x + ra.bullet_start_offset[1].x * af
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
	end
	if ra.bullet then
	local b = E:create_entity(ra.bullet)
		b.pos = V.vclone(this.pos)
		b.pos.x = this.pos.x + ra.bullet_start_offset[1].x * af
		b.pos.y = this.pos.y + ra.bullet_start_offset[1].y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(towern.pos.x + towern.render.sprites[2 or 1].offset.x, towern.pos.y + towern.render.sprites[2 or 1].offset.y)
		b.bullet.target_id = towern.id
		queue_insert(store, b)
		elseif ra.mod then
		local mod = E:create_entity(ra.mod)
		mod.modifier.target_id = towern.id
		mod.modifier.source_id = this.id

		queue_insert(store, mod)
	end
	local wait2 = SU.y_enemy_wait(store, this, (ra.cast_time or ra.shoot_time) / 3)
	if wait2 then
	coroutine.yield()
	elseif h.dead then
	return h.dead
	end
		ra.ts = store.tick_ts
			U.animation_start(this, "idle", nil, store.tick_ts, 1)
			coroutine.yield()
		goto out
	end
end
		if sra.cooldown < store.tick_ts - sra.ts then
	local af = 1
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	local soldiern = U.find_nearest_soldier(store.entities, this.pos, sra.min_range, sra.max_range, sra.vis_flags, sra.vis_bans)
	if not soldiern then
	local soldiern = U.find_nearest_soldier(store.entities, this.pos, sra.min_range, sra.max_range, sra.vis_flags, sra.vis_bans)
	goto out
	else
	if sra.sound then
		S:queue(sra.sound or "CBSpectralKnight", sra.sound_args)
	end
		local an, ann = U.animation_name_facing_point(this, sra.animation, soldiern.pos)
			U.animation_start(this, an, ann, store.tick_ts, 1)

	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end

	local wait = SU.y_enemy_wait(store, this, sra.cast_time or sra.shoot_time)
	if wait then
	coroutine.yield()
	elseif h.dead then
	return h.dead
	end
	if sra.shoot_fx then
	for _, fx in pairs(sra.shoot_fx) do
		local fx = E:create_entity(fx)
		fx.pos = V.vclone(this.pos)
		fx.pos.y = this.pos.y + sra.bullet_start_offset[1].y
		fx.pos.x = this.pos.x + sra.bullet_start_offset[1].x * af
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
	end
	if sra.bullet then
	local b = E:create_entity(sra.bullet)
		b.pos = V.vclone(this.pos)
		b.pos.x = this.pos.x + sra.bullet_start_offset[1].x * af
		b.pos.y = this.pos.y + sra.bullet_start_offset[1].y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(soldiern.pos.x, soldiern.pos.y)
		b.bullet.target_id = soldiern.id
		queue_insert(store, b)
	end
		sra.ts = store.tick_ts
	local wait2 = SU.y_enemy_wait(store, this, (ra.cast_time or ra.shoot_time) / 3)
	if wait2 then
	coroutine.yield()
	elseif h.dead then
	return h.dead
	end
			U.animation_start(this, "idle", nil, store.tick_ts, 1)
			coroutine.yield()
		goto out
	end
end
::out::
end
		while true do
				if this.health.dead then

				SU.y_enemy_death(store, this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
							ready_to_attack()
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.eb_jt_same = {
	update = function (this, store, script)
	local h = this.health
	local a = this.timed_attacks
	local once = true
	local ad = this.timed_attacks.list[1]
	ad.ts = store.tick_ts
	local attacks = {
			ad
		}

local function ready_to_attack()
::loop::
if h.dead then
return h.dead
end
for _, ve in pairs(store.entities) do
if ve.template_name == "eb_veznan" then
ve.health.hp = ve.health.hp_max
end
end
if once then
	for _, vez in pairs(store.entities) do
	if vez.template_name == "eb_veznan" then
	for i = 1, 1 do
		local au = E:create_entity("aura_veznan_stand")
		au.aura.source_id = vez.id
		au.attacks.list[1].cooldown = math.random(5, 10)

		queue_insert(store, au)
	once = false
end
	end
end
end
			for i, aa in pairs(attacks) do

		if aa.cooldown < store.tick_ts - aa.ts then

		if aa == ad then
for i = 1, math.random(aa.loops[1], aa.loops[2 or 1]) do
	local af = this.render.sprites[1].flip_x
	local aff = 1
	if af then
	aff = -1
	else
	aff = 1
	end
	local soldiers = U.find_soldiers_in_range(store.entities, V.v(this.pos.x + aa.hit_offset.x * aff, this.pos.y + aa.hit_offset.y), 0, aa.damage_radius, aa.vis_flags, aa.vis_bans)
	local all_soldiers = U.find_soldiers_in_range(store.entities, V.v(this.pos.x + aa.hit_offset.x * aff, this.pos.y + aa.hit_offset.y), 0, 99999, aa.vis_flags, aa.vis_bans)
	local towers = U.find_all_towers_in_range(store.entities, V.v(this.pos.x + aa.hit_offset.x * aff, this.pos.y + aa.hit_offset.y), 0, aa.damage_radius, aa, true)
		U.animation_start(this, aa.animation, nil, store.tick_ts, 1)
	if aa.sound then
	S:queue(aa.sound, aa.sound_args)
	end

	local CD = SU.y_enemy_wait(store, this, aa.cast_time or aa.hit_time or aa.spawn_time or aa.shoot_time)
if CD then
--no
elseif h.dead then
goto loop
else
goto nex
end
::nex::
	if soldiers and not h.dead then
	local count = 0
	for _, s in pairs(soldiers) do
if aa.mod then
		local m = E:create_entity(aa.mod)
		m.modifier.target_id = s.id
		m.modifier.source_id = this.id

		queue_insert(store, m)
	end
	if aa.damage_max and aa.damage_min then
		local d = E:create_entity("damage")
		d.damage_type = aa.damage_type
		d.source_id = this.id
		d.target_id = s.id
		d.value = math.random(aa.damage_min, aa.damage_max)

		queue_damage(store, d)
	end
	if aa.count then
		count = count + 1
		if count >= aa.count or not soldiers then
		count = 0
		goto damageout1
		end
	end
end
elseif h.dead then
goto loop
	else
	goto damageout1
end
::damageout1::
if towers then
	for _, t in pairs(towers) do

		local m = E:create_entity(aa.mod_tower)
		m.modifier.target_id = t.id
		m.modifier.source_id = this.id

		queue_insert(store, m)
		end
	else
	goto towerout
end
::towerout::
	if all_soldiers then
	for _, s in pairs(all_soldiers) do
	if aa.mod_all then
		local m = E:create_entity(aa.mod_all)
		m.modifier.target_id = s.id
		m.modifier.source_id = this.id

		queue_insert(store, m)
	end
	if aa.damage_max_all and aa.damage_min_all then
		local d = E:create_entity("damage")
		d.damage_type = aa.damage_type_all
		d.source_id = this.id
		d.target_id = s.id
		d.value = math.random(aa.damage_min_all, aa.damage_max_all)

		queue_damage(store, d)
	end
end
	else
	goto damageout2
end
::damageout2::
	if aa.hit_fx then
	for _, fx in pairs(aa.hit_fx) do
		local fx = E:create_entity(fx)
		fx.pos = V.vclone(this.pos)
		fx.pos.y = this.pos.y + aa.hit_offset.y
		if af then
		fx.pos.x = this.pos.x + aa.hit_offset.x * -1
		else
		fx.pos.x = this.pos.x + aa.hit_offset.x * 1
		end
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
	end
	if aa.hit_aura then
		local aura = E:create_entity(aa.hit_aura)
		aura.pos = V.vclone(this.pos)
		aura.pos.y = this.pos.y + aa.hit_offset.y
		aura.aura.source_id = this.id
		if af then
		aura.pos.x = this.pos.x + aa.hit_offset.x * -1
		else
		aura.pos.x = this.pos.x + aa.hit_offset.x * 1
		end
		queue_insert(store, aura)
	end
	if aa.hit_decal then
	for _, decal in pairs(aa.hit_decal) do
		local decal = E:create_entity(decal)
		decal.pos = V.vclone(this.pos)
		decal.pos.y = this.pos.y + aa.hit_offset.y
		if af then
		decal.pos.x = this.pos.x + aa.hit_offset.x * -1
		else
		decal.pos.x = this.pos.x + aa.hit_offset.x * 1
		end
		decal.render.sprites[1].ts = store.tick_ts
		queue_insert(store, decal)
		end
	end
				U.y_animation_wait(this, 1)
			end
			if aa.breath_time then
		U.animation_start(this, "breath", nil, store.tick_ts, -1)
		if aa.breath_sound then
			S:queue(aa.breath_sound, aa.breath_sound_args)
			end
	local breath = SU.y_enemy_wait(store, this, math.random(aa.breath_time[1], aa.breath_time[2 or 1]))
	if breath then
	coroutine.yield()
	elseif h.dead then
	goto out
	else
	aa.ts = store.tick_ts
	goto out
	end

	end
				end
			end
		end
::out::
	end
		while true do
				if this.health.dead then

				SU.y_enemy_death(store, this)
				U.y_animation_wait(this, 1)
				S:queue(this.sound_events.death_explode)
		U.y_animation_play(this, "death_end", nil, store.tick_ts)
		LU.kill_all_enemies(store, true)


				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
							ready_to_attack()
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.eb_moloch_f = {
	update = function (this, store, script)
	local h = this.health
	local once = true
	local ad = this.timed_attacks.list[1]
	ad.ts = store.tick_ts

if U.flag_has(this.vis.flags, F_BOSS) then
this.unit.can_explode = false
this.unit.can_disintegrate = false
end

local function ready_to_attack()

if once then
	for _, vez in pairs(store.entities) do
	if vez.template_name == "eb_veznan" then
	for i = 1, 1 do
		local au = E:create_entity("aura_veznan_stand")
		au.aura.source_id = vez.id
		au.attacks.list[1].cooldown = math.random(5, 10)

		queue_insert(store, au)
	once = false
end
	end
end
end
		if ad.cooldown < store.tick_ts - ad.ts then
	local dest = V.vclone(this.pos)
		local af = 1
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	dest.x = dest.x + ad.hit_offset.x * af
	dest.y = dest.y + ad.hit_offset.y
		local soldier_d = U.find_nearest_soldier(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
		local soldier = U.find_soldiers_in_range(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
		if soldier and #soldier >= (ad.min_count or 0) then
		S:queue(ad.sound, ad.sound_args)
		local an, ann = U.animation_name_facing_point(this, ad.animation, soldier_d.pos)
		U.animation_start(this, an, ann, store.tick_ts, 1)
		if this.render.sprites[1].flip_x then
		af = -1
		else
		af = 1
		end
	dest.x = dest.x + ad.hit_offset.x * af
	dest.y = dest.y + ad.hit_offset.y
	soldier_d = U.find_nearest_soldier(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
	soldier = U.find_soldiers_in_range(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
		local at = SU.y_enemy_wait(store, this, ad.hit_time)
	if at then
	--nothing
	elseif h.dead then
	return h.dead
	end
local damage_max = ad.damage_max or 0
local damage_min = ad.damage_min or 0
local damage_type = ad.damage_type or bor(DAMAGE_NONE)
if soldier then
	for _, s in pairs(soldier) do
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
			
			local anw = SU.y_enemy_animation_wait(this)
	if anw then
	--nothing
	elseif h.dead then
	return h.dead
	end
		goto out
		else
		goto out
		end
	end
::out::
end
		while true do
				if this.health.dead then
		S:queue(this.sound_events.death)
		U.y_animation_play(this, "death", nil, store.tick_ts)
		signal.emit("boss-killed", this)

				return
			end
			if this.unit.is_stunned then
				U.animation_start(this, "idle", nil, store.tick_ts, 1)
				coroutine.yield()
				else

				U.cleanup_blockers(store, this)

				if not U.get_blocker(store, this) then
			

						coroutine.yield()

				end

		local cont, blocker, ranged = SU.y_enemy_walk_until_blocked(store, this, false, ready_to_attack)


				if not cont then
					-- Nothing
				elseif blocker then

						coroutine.yield()

					if SU.y_wait_for_blocker(store, this, blocker) then
							ready_to_attack()
						while SU.can_melee_blocker(store, this, blocker) do
							if not SU.y_enemy_melee_attacks(store, this, blocker) then
								break
							end
							ready_to_attack()

							coroutine.yield()
						end

						coroutine.yield()
					end
				end
			end
		end
	end
}
scripts.fx_in = {
	update = function (this, store, script)
	if this.in_fx_list then
		for _, t in pairs(this.in_fx_list) do
		fx = E:create_entity(t)
		fx.pos = this.pos
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
	end
	if this.in_aura_list then
		for _, a in pairs(this.in_aura_list) do
		aura = E:create_entity(a)
		aura.pos = this.pos
		queue_insert(store, aura)
		end
	end
end
}
scripts.mod_golden = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local e = E:create_entity(target.template_name)
	if target then
	--no
	else
	goto dead
	end
	if not target.health.dead and target.health then
	goto run
	else
	goto dead
	end
::run::
if target.golden then
goto dead
end

	if not target.golden then
	this.pos = target.pos
		if e.hero then
		goto dead
		end
		if e.enemy then
	if m.keep_gold then
		e.enemy.gold = target.enemy.gold * m.gold_factor
		else
		e.enemy.gold = 0
		end
		e.enemy.gems = target.enemy.gems
		e.enemy.lives_cost = target.enemy.lives_cost * m.lives_cost_factor
		end
		if this.target_death_sound_change then
		e.sound_events.death = this.target_death_sound_change
		end
	if m.armor then
		e.health.armor = m.armor
	end
	if m.magic_armor then
		e.health.magic_armor = m.magic_armor
	end
		e.health.hp_max = target.health.hp_max * m.hp_factor
		e.health.hp = e.health.hp_max
		if e.nav_path then
		e.nav_path.pi = target.nav_path.pi
		e.nav_path.spi = target.nav_path.spi
		e.nav_path.ni = target.nav_path.ni
		e.pos = P:node_pos(e.nav_path)
		end
		if e.nav_rally and not e.hero then
		e.pos = V.vclone(target.pos)
		e.nav_rally.pos = V.vclone(target.pos)
		e.nav_rally.center = V.vclone(target.pos)
		end
		e.golden = true
	if e.melee.attacks then
		for i = 1, #e.melee.attacks do
	if m.fps_factor then
		e.melee.attacks[i].hit_time = e.melee.attacks[i].hit_time / m.fps_factor
		e.melee.attacks[i].cooldown = e.melee.attacks[i].cooldown / m.fps_factor
		end
	if m.damage_factor then
		e.melee.attacks[i].damage_max = e.melee.attacks[i].damage_max * m.damage_factor
		e.melee.attacks[i].damage_min = e.melee.attacks[i].damage_min * m.damage_factor
		end
	end
end
	if e.render.sprites then
		for i = 1, #e.render.sprites do
		e.render.sprites[i].shader = "p_tint"
		e.render.sprites[i].shader_args = {
			tint_factor = 0.4444,
			tint_color = {
				1.6,
				1.6,
				0.6,
				0.6,
			}
		}
		if m.set_animation then
		e.render.sprites[i].name = m.set_animation
		end
if m.fps_factor then
	if not e.render.sprites[i].fps then
		e.render.sprites[i].fps = FPS
	end
	if e.render.sprites[i].fps then
		e.render.sprites[i].fps = e.render.sprites[i].fps * m.fps_factor
	end
end
		e.render.sprites[i].flip_x = target.render.sprites[1].flip_x
		end
	end
	if not e.hero then
		queue_insert(store, e)
		end
		if m.fx_in then
		local fx = E:create_entity(m.fx_in)
		fx.pos.y = target.pos.y
		fx.pos.x = target.pos.x
		fx.render.sprites[1].ts = store.tick_ts
		if target.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[target.unit.size]
		end
		queue_insert(store, fx)
	end
	if target.enemy then
	target.enemy.gems = 0
	target.enemy.gold = 0
	target.enemy.lives_cost = 0
	U.sprites_hide(store.entities[m.target_id])
	queue_remove(store, store.entities[m.target_id])

	end
		goto dead
end
::dead::
			U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.mod_kill_target = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	if target then
	goto run
	else
	goto die
	end
::run::
	this.pos = target.pos
	U.y_wait(store, m.life_time, function (store, time)
	if store.entities[m.target_id] then
	--nothing
	else
	return true
	end
	if store.entities[m.target_id].health.dead then
		return true
	end
end)
if (not target) or target.health.dead then
goto die
end
	if store.entities[m.target_id] then
	--nothing
	else
	goto die
	end
	target.health.hp = 0
::die::
			U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.mod_remove_target = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	if target then
	goto run
	else
	goto die
	end
::run::
	U.y_wait(store, m.life_time, function (store, time)
	if store.entities[m.target_id] then
	--nothing
	else
	return true
	end
end)
	if store.entities[m.target_id] then
	--nothing
	else
	goto die
	end
			U.sprites_hide(this)
		queue_remove(store, this)
::die::
			U.sprites_hide(store.entities[m.target_id])
		queue_remove(store, store.entities[m.target_id])
	return
end
}
scripts.mod_flag_damage = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local owner = store.entities[m.source_id]
	local once = true

	if target then
	goto run
	else
	goto die
	end
::run::
	this.pos = target.pos
	while target do
	if target then
	--nothing
	else
	goto die
	end
	if once then
	--nothing
	else
	goto die
	end
		U.y_wait(store, m.hit_time or 0, function (store, time)
	if store.entities[m.target_id] then
	--nothing
	else
	return true
	end
	if store.entities[m.target_id].health.dead then
		return true
	end
end)
	if store.entities[m.target_id] then
	--nothing
	else
	goto die
	end
if target.health.dead then
goto die
end
		local d = E:create_entity("damage")
		d.source_id = owner.id
		d.target_id = target.id
		d.damage_type = m.damage_type or DAMAGE_NONE
		d.value = math.random(m.damage_min or 0, m.damage_max or 0)
	if U.flag_has(target.vis.flags, (m.special_flags)) then
		d.damage_type = m.damage_type_special or DAMAGE_NONE
		d.value = math.random(m.damage_min_special or 0, m.damage_max_special or 0)
		end

		queue_damage(store, d)
		if m.hit_fx then
		local fx = E:create_entity(m.fx)
		fx.pos = V.vclone(r.pos)
		fx.pos.x = target.pos.x + target.unit.hit_offset.x
		fx.pos.y = target.pos.y + target.unit.hit_offset.y
		fx.render.sprites[1].ts = store.tick_ts
		if target.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[(target.unit.size) or #fx.render.sprites[1].size_names]
		end
		queue_insert(store, fx)
		end
		once = false
		U.y_wait(store, fts(0.000001))
	end
::die::
			U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.mod_do_animation = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]

	if target then
	goto run
	else
	goto die
	end
::run::
	this.pos = target.pos

		if m.animation then
		U.animation_start(store.entities[this.modifier.target_id], m.animation, nil, store.tick_ts, 1)
			while not U.animation_finished(store.entities[this.modifier.target_id]) do
	if store.entities[m.target_id] then
	--nothing
	else
	goto out
	end
if U.has_modifier_types(store, store.entities[this.modifier.target_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	goto out
	end
		if target.health.dead then
		goto out
		end
			U.y_wait(store, fts(0.0001))
		end
	end
::out::
		U.animation_start(store.entities[this.modifier.target_id], "idle", nil, store.tick_ts, 1)
		if target.soldier and (not target.soldier.target_id) then
		target.nav_rally.new = true
		end
	::die::
		queue_remove(store, this)
	return
end
}
scripts.mod_add_mod = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	
	if target then
	goto run
	else
	goto die
	end
::run::
	this.pos = target.pos
			if m.mods then
	for _, mod in pairs(m.mods) do
		local mo = E:create_entity(mod)
		mo.modifier.target_id = target.id
	if m.source_id then
		mo.modifier.source_id = m.source_id
		end

		queue_insert(store, mo)
		
		end

	end
::die::
		queue_remove(store, this)
	return
end
}
scripts.mod_add_aura = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	
	if target then
	goto run
	else
	goto die
	end
::run::
	this.pos = target.pos
			if m.auras then
	for _, aura in pairs(m.auras) do
		local a = E:create_entity(aura)
		a.aura.target_id = target.id
		a.aura.source_id = target.id

		queue_insert(store, a)
		
		end

	end
::die::
		queue_remove(store, this)
	return
end
}
scripts.enemy_bandit_chance = {
	update = function (this, store)
	if this.enemy then
	if (math.random() < 0.1) then
	
		local e = E:create_entity("enemy_bandit_king")
		e.enemy.gems = this.enemy.gems
		e.enemy.gold = this.enemy.gold * 2
		e.health.hp_max = this.health.hp_max * 3
		e.nav_path.pi = this.nav_path.pi
		e.nav_path.spi = this.nav_path.spi
		e.nav_path.ni = this.nav_path.ni
		e.lives_gain = 0
		e.pos = V.vclone(this.pos)
		queue_insert(store, e)
		U.sprites_hide(this)
		queue_remove(store, this)
		return
	elseif (math.random() < 0) then
	
		local e = E:create_entity("enemy_bandit_king_2")
		e.enemy.gems = this.enemy.gems
		e.enemy.gold = this.enemy.gold * 2
		e.health.hp_max = this.health.hp_max * 1.333
		e.nav_path.pi = this.nav_path.pi
		e.nav_path.spi = this.nav_path.spi
		e.nav_path.ni = this.nav_path.ni
		e.pos = V.vclone(this.pos)
		e.lives_gain = 0
		queue_insert(store, e)
		U.sprites_hide(this)
		queue_remove(store, this)
		return
	end
end
		return scripts.enemy_mixed.update(this, store)
end
}
scripts.gerald_wd = {
	update = function (this, store)
	if AC:have("GOC") then
				local aura = E:create_entity("aura_WD_JS")
				aura.aura.source_id = this.id
				queue_insert(store, aura)
		return GSC.hero_gerald.update(this, store)
			else
		return GSC.hero_gerald.update(this, store)
	end
end
}
scripts.soldier_golem = {
	update = function (this, store)
		if true then
			local ju = 0
			for _, e in pairs(store.entities) do
			if e.template_name == "soldier_juggernaut" then
			ju = ju + 1
			end
		end
			this.one_entity_max = this.one_entity_max * ju
	end
	local function count_can()
	local count = 0
	for _, e in pairs(store.entities) do
	if e.template_name == this.template_name then
	count = count + 1
	else
	--nothing
	end
end
if this.one_entity_max then
	if count < this.one_entity_max then
	return false
	else
	return true
	end
	else
	return true
	end
end
	if count_can() then
		this.health_bar.hidden = true
		this.health.hp = 0
		return scripts.soldier_barrack.update(this, store)
	else
	local mod = E:create_entity("unit_life_time")
	mod.modifier.target_id = this.id
	mod.modifier.life_time = 20

	queue_insert(store, mod)
		return scripts.soldier_barrack.update(this, store)
	end
end
}
scripts.a_dwarf = {
	update = function (this, store)
	local function no_hero_can()
	if store.level.locked_hero then
	return false
	end
	return store.selected_hero
end
	if this.hero_insert and no_hero_can() then
	local hero = LU.insert_hero(store, this.template_name, this.nav_rally.pos)
	hero.hero_insert = false
		U.sprites_hide(this)
		queue_remove(store, this)
		return
	end
	if this.cheat_game_2 then
storage:load_slot().gems = storage:load_slot().gems + 666666
signal.emit("show-gems-reward", this, 666666)
		U.sprites_hide(this)
		queue_remove(store, this)
		return
	end
	if this.cheat_game_3 then
		store.lives = 9999
		U.sprites_hide(this)
		queue_remove(store, this)
		return
	end
	if this.cheat_game then
	LU.kill_all_enemies(store, true)
	game.store.force_next_wave = true
		U.sprites_hide(this)
		queue_remove(store, this)
		return
	end
::twice::
	if this.auras then
	local aura = {}
	for i = 1,#this.auras.list do
::again::
				aura[i] = E:create_entity(this.auras.list[i].name)
				aura[i].aura.source_id = this.id
				aura[i].pos = this.pos
				if aura[i] then
				queue_insert(store, aura[i])
				else
				goto again
				end
			end
		return GSC2.hero_dwarf.update(this, store, script)
			else
		return GSC2.hero_dwarf.update(this, store, script)
	end
end
}
scripts.bullet_saw = {
	update = function (this, store)
	local mod = nil
	::loop::
if true then
	 mod = E:create_entity("unit_life_time_2")
	mod.modifier.target_id = this.id
	mod.modifier.life_time = 20

	queue_insert(store, mod)
end
if mod then
--nothing
else
goto loop
end
	if this.auras then
	local aura = {}
	for i = 1,#this.auras.list do
::again::
				aura[i] = E:create_entity(this.auras.list[i].name)
				aura[i].aura.source_id = this.id
				aura[i].pos = this.pos
				if aura[i] then
				queue_insert(store, aura[i])
				else
				goto again
				end
			end
		return GSC.hacksaw_sawblade.update(this, store)
			else
		return GSC.hacksaw_sawblade.update(this, store)
	end
end
}
scripts.enemy_random_fps = {
	update = function (this, store)
	local FFPS = math.random(1, 1.5)
	if (math.random() < 0.6) then
	this.health.hp_max = math.random(this.health.hp_max, this.health.hp_max * 2)
	this.health.hp = this.health.hp_max
		if this.render.sprites then
		for i = 1, #this.render.sprites do
	if not this.render.sprites[i].fps then
		this.render.sprites[i].fps = FPS
	end
	if this.render.sprites[i].fps then
		this.render.sprites[i].fps = this.render.sprites[i].fps * FFPS
	end
		end
end
this.motion.max_speed = this.motion.max_speed * FFPS
	if this.melee then
		for i = 1, #this.melee.attacks do
		this.melee.attacks[i].hit_time = this.melee.attacks[i].hit_time / FFPS
		this.melee.attacks[i].cooldown = this.melee.attacks[i].cooldown / FFPS
	end
end
	if this.ranged then
		for i = 1, #this.ranged.attacks do
		this.ranged.attacks[i].shoot_time = this.ranged.attacks[i].shoot_time / FFPS
		this.ranged.attacks[i].cooldown = this.ranged.attacks[i].cooldown / FFPS
	end
end
		return scripts.enemy_mixed.update(this, store)
	end
		return scripts.enemy_mixed.update(this, store)
end
}
scripts.enemy_random_fps_weak = {
	update = function (this, store)
	local FFPS = math.random(1, 2)
	if (math.random() < 0.5) then
	this.health.hp_max = math.random(this.health.hp_max, this.health.hp_max * 2)
	this.health.hp = this.health.hp_max
		if this.render.sprites then
		for i = 1, #this.render.sprites do
	if not this.render.sprites[i].fps then
		this.render.sprites[i].fps = FPS
	end
	if this.render.sprites[i].fps then
		this.render.sprites[i].fps = this.render.sprites[i].fps * FFPS
	end
		end
end
this.motion.max_speed = this.motion.max_speed * FFPS
	if this.melee then
		for i = 1, #this.melee.attacks do
		this.melee.attacks[i].hit_time = this.melee.attacks[i].hit_time / FFPS
		this.melee.attacks[i].cooldown = this.melee.attacks[i].cooldown / FFPS
	end
end
	if this.ranged then
		for i = 1, #this.ranged.attacks do
		this.ranged.attacks[i].shoot_time = this.ranged.attacks[i].shoot_time / FFPS
		this.ranged.attacks[i].cooldown = this.ranged.attacks[i].cooldown / FFPS
	end
end
		return scripts.enemy_passive.update(this, store)
	end
		return scripts.enemy_passive.update(this, store)
end
}
scripts.mod_click_bullet = {
	update = function (this, store)
	local m = this.modifier
	local loops = m.loops or 1
	local target = store.entities[m.target_id]
	m.ts = store.tick_ts

	if (m.duration < 0) or (not m.duration) then
	m.duration = -1
	m.ts = 9e+99
	end
	if (m.click_delay < 0) or (not m.click_delay) then
	m.click_delay = 0
	end
while target do
::again::
if target then
this.pos = target.pos
else
goto out
end
if m.duration < store.tick_ts - m.ts then
goto out
end
			if target.ui.clicked then
		if m.click_sound then
		S:queue(m.click_sound, m.click_sound_args)
		end
	for i = 1, loops do
		if m.bullet then
		local mod = E:get_template("mod_hero_thor_thunderclap_d")
		mod.thunderclap.damage = 70
		mod.thunderclap.secondary_damage = 80
		mod.thunderclap.stun_duration_max = 3
		mod.thunderclap.max_range = 70
		local b = E:create_entity(m.bullet)
		b.pos.x = target.pos.x + math.random(-666, 666)
		b.pos.y = target.pos.y + math.random(-666, 666)
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
	if loops > 1 and (m.min_spread and m.max_spread) then
		b.bullet.to = U.point_on_ellipse(V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y), U.frandom(m.min_spread or 1, m.max_spread or 1), (i - 1) * 2 * math.pi / loops)
	end
	if m.XD then
	b.bullet.to = V.vclone(target.pos)
	end
		b.bullet.target_id = target.id
		
		queue_insert(store, b)
		if m.XD then
		local aura = E:create_entity("aura_ZDSD")
		aura.aura.source_id = b.id
		queue_insert(store, aura)
		end
	end
end
	U.y_wait(store, m.click_delay)
		target.ui.clicked = nil
		goto outt
	end
::outt::
		U.y_wait(store, fts(0.001))
		goto again
	end
::out::
		queue_remove(store, this)
	return
end
}
scripts.mod_FD = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	local count = 0
	local CB = 1
	m.ts = store.tick_ts

	if (m.duration < 0) or (not m.duration) then
	m.duration = -1
	m.ts = 9e+99
	end
while target do
if m.duration < store.tick_ts - m.ts then
goto die
end
if store.entities[m.target_id] then
--nothing
else
goto die
end
	if target.render.sprites then
		for i = 1, #target.render.sprites do
		target.render.sprites[i].offset.y = target.render.sprites[i].offset.y + count
		if m.fx then
		local fx = E:create_entity(m.fx)
		fx.pos = V.vclone(target.pos)
		fx.pos.x = target.pos.x + target.render.sprites[i].offset.x + m.offset.x
		fx.pos.y = target.pos.y + target.render.sprites[i].offset.y + m.offset.y
		fx.render.sprites[1].ts = store.tick_ts
		queue_insert(store, fx)
		end
		
		end
		count = count + CB
	end
	if count >= m.max then
	CB = - m.speed
	elseif count <= -m.max then
	CB = m.speed
	end
	U.y_wait(store, fts(10))
end
::die::
		queue_remove(store, this)
	return
end
}
scripts.mod_EX = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	m.ts = store.tick_ts
	local FFPS, MOVE, MELEE = nil

	if target.soldier then
	MELEE = target.melee.range
	end
	if target.motion then
	MOVE = target.motion.max_speed
	end
	if m.duration < 0 then
	m.ts = 9e+99
	end
	if not target.render.sprites[1].fps then
			target.render.sprites[1].fps = FPS
			FFPS = FPS
			else
			FFPS = target.render.sprites[1].fps
		end
	if U.flag_has(target.vis.bans, (m.vis_flags)) then
	goto die
	end
	if U.flag_has(target.vis.flags, (m.vis_bans)) then
	goto die
	end
while target do
	if target then
	--nothing
	else
	goto die
	end
if m.duration < store.tick_ts - m.ts then
	goto out
end
U.y_wait(store, (m.ex_delay) or fts(0.001))
	this.pos = target.pos
		target.render.sprites[1].r = math.random(-60, 60) * math.pi / 360
		target.render.sprites[1].fps = 0
		target.motion.max_speed = 0
		target.melee.range = 0
		if m.fx then
		local fx = nil
		fx = E:create_entity(m.fx)
		fx.pos = V.vclone(r.pos)
		fx.pos.x = target.pos.x + target.unit.hit_offset.x
		fx.pos.y = target.pos.y + target.unit.hit_offset.y
		fx.render.sprites[1].ts = store.tick_ts
		if target.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[(target.unit.size) or #fx.render.sprites[1].size_names]
		end
		queue_insert(store, fx)
		end
		while U.animation_finished(store.entities[m.target_id], 1) and not target.health.dead do
		if target.health.hp <= 0 then
		target.render.sprites[1].r = 0
		target.render.sprites[1].fps = FFPS or FPS
		target.motion.max_speed = MOVE
		target.melee.range = MELEE
		goto out
		end
		U.y_wait(store, fts(0.001))
	end
		U.y_wait(store, (m.ex_duration) or fts(0.001))
		target.render.sprites[1].r = 0
		target.render.sprites[1].fps = FFPS or FPS
		target.motion.max_speed = MOVE
		target.melee.range = MELEE
				
		U.y_wait(store, fts(0.001))
	end
::out::
		target.render.sprites[1].r = 0
		target.render.sprites[1].fps = FFPS or FPS
		target.motion.max_speed = MOVE
		target.melee.range = MELEE
::die::
queue_remove(store, this)
	return
end
}
scripts.aura_WD_JS = {
	update = function (this, store)
	local a = this.aura
	local aa = this.attacks.list[1]
	local s = store.entities[this.aura.source_id]
	local vis_bans = s.vis.bans
	local hits = 0
	local hit_count = 0
	local max_hits = aa.max_hits or 1
	local fx_ts = store.tick_ts
	local move = nil
	a.ts = store.tick_ts

	if (aa.cooldown_max and aa.cooldown_min) then
	aa.cooldown = math.random(aa.cooldown_min, aa.cooldown_max)
	else
	aa.cooldown = aa.cooldown or 0
	end
	aa.ts = store.tick_ts

	if s.template_name == "hero_gerald" then
	s.motion.max_speed = 6 * FPS
	s.info.i18n_key = "HERO_DSBLKB"
	end
	if s.motion then
	move = s.motion.max_speed
	end
	if a.duration < 0 then
	a.ts = 9e+99
	end
::nodie::
while s do
if store.entities[this.aura.source_id] then
this.pos = s.pos
else
goto die
end
	U.sprites_hide(this)
if a.duration < store.tick_ts - a.ts then
	goto out
	end
	if hit_count > 0 and hit_count < 101 then
	aa.max_hits = max_hits + (hit_count / 10)
	else
	hit_count = 100
	end
	if (not s.soldier.target_id) and a.fx_delay < store.tick_ts - fx_ts then
	fx_ts = store.tick_ts
		local fx = E:create_entity("decal_paladin_holystrike")
		fx.pos = V.vclone(s.pos)
		fx.render.sprites[1].ts = store.tick_ts
		fx.render.sprites[1].scale = v(0.4, 0.4)
		queue_insert(store, fx)
	end
	local enemy, enemies = U.find_foremost_enemy(store.entities, this.pos, 0, aa.range, false, aa.vis_flags, aa.vis_bans)
			if not enemy then
				enemy, enemies = U.find_foremost_enemy(store.entities, this.pos, 0, aa.range, false, aa.vis_flags, aa.vis_bans)
				goto loop
				elseif aa.cooldown < store.tick_ts - aa.ts then
			while enemy do
		if store.entities[this.aura.source_id] then
		--nothing
		else
		goto die
		end
			local af = 1
			local offset_x = 0
			local offset_y = 0
			if (aa.max_hits or 999) <= hits then
	if (aa.cooldown_max and aa.cooldown_min) then
	aa.cooldown = math.random(aa.cooldown_min, aa.cooldown_max)
	else
	aa.cooldown = aa.cooldown or 0
	end
	if aa.heal_hp and not s.health.dead then
	s.health.hp = s.health.hp + aa.heal_hp
	if s.health.hp >= s.health.hp_max then
	s.health.hp = s.health.hp_max
	end
end
			aa.ts = store.tick_ts
			hit_count = hit_count + hits
			hits = 0
			goto loop
			end
			if #enemies == 0 then
	if (aa.cooldown_max and aa.cooldown_min) then
	aa.cooldown = math.random(aa.cooldown_min, aa.cooldown_max)
	else
	aa.cooldown = aa.cooldown or 0
	end
			aa.ts = store.tick_ts
			hit_count = hit_count + hits
			hits = 0
			goto loop
			end
				enemy = enemies[math.random(1, #enemies)]
				s.health.ignore_damage = true
				s.vis.bans = F_ALL
				s.ui.can_click = false
				s.unit.is_stunned = true
			if aa.bar_hide then
				s.health_bar.hidden = true
			end
			if aa.keep_move then
				s.motion.max_speed = move
			else
				s.motion.max_speed = 0
			end
				U.sprites_hide(store.entities[this.aura.source_id])
			if enemy.render.sprites[1].flip_x then
			af = -1
			else
			af = 1
			end
		if not enemy.unit.is_stunned then
			enemy.unit.is_stunned = true
		end
			SU.hide_modifiers(store, store.entities[this.aura.source_id])
			this.pos = V.vclone(enemy.pos)
		if s.soldier.melee_slot_offset then
		offset_x = offset_x + s.soldier.melee_slot_offset.x
		offset_y = offset_y + s.soldier.melee_slot_offset.y
		end
		if enemy.enemy.melee_slot then
		offset_x = offset_x + enemy.enemy.melee_slot.x
		offset_y = offset_y + enemy.enemy.melee_slot.y
		end
		if U.flag_has(enemy.vis.flags, F_FLYING) then
		offset_x = offset_x + enemy.unit.hit_offset.x
		offset_y = offset_y + enemy.unit.hit_offset.y
		end
		this.pos.x = this.pos.x + offset_x * af
		this.pos.y = this.pos.y + offset_y
				U.sprites_show(this)
			for i = 1, #this.render.sprites do
			if not this.render.sprites[i].fps then
				this.render.sprites[i].fps = FPS
			end
				this.render.sprites[i].fps = this.render.sprites[i].fps * (aa.fps_factor or 1)
			end
			local an, ann = U.animation_name_facing_point(this, aa.animation, enemy.pos)
				U.animation_start(this, an, ann, store.tick_ts, 1)
			if this.render.sprites[1].flip_x then
			af = -1
			else
			af = 1
			end
local damage_max = nil
local damage_min = nil
if enemy.melee then
for i = 1, #enemy.melee.attacks do
damage_max = enemy.melee.attacks[math.random(1, i)].damage_max * (aa.low_damage_factor or 1)
damage_min = enemy.melee.attacks[math.random(1, i)].damage_min * (aa.low_damage_factor or 1)
end
else
damage_max = enemy.health.hp_max * (aa.damage_hp_factor_max or 1)
damage_min = enemy.health.hp_max * (aa.damage_hp_factor_min or 1)
end
local damage_type = aa.damage_type or bor(DAMAGE_NONE)
		local d = E:create_entity("damage")
		d.damage_type = damage_type
		d.source_id = s.id
		d.target_id = enemy.id
		d.value = math.random(damage_min, damage_max)

		queue_damage(store, d)
		if aa.mod then
		local mod = E:create_entity(aa.mod)
		mod.modifier.target_id = enemy.id
		mod.modifier.source_id = this.id

		queue_insert(store, mod)
		end
			if aa.sound then
				S:queue(aa.sound)
			end
		if aa.wait_time then
			U.y_wait(store, aa.wait_time / (aa.fps_factor or 1))
		end
		hits = hits + 1
			for i = 1, #this.render.sprites do
				this.render.sprites[i].fps = this.render.sprites[i].fps / (aa.fps_factor or 1)
			end
		if not U.has_modifier_types(store, enemy, MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
		enemy.unit.is_stunned = false
	end
				enemy, enemies = U.find_foremost_enemy(store.entities, s.pos, 0, aa.range, false, aa.vis_flags, aa.vis_bans)
				s.health.ignore_damage = nil
			end
			else
			hits = 0
			goto loop
		end
::loop::
this.pos = s.pos
				SU.show_modifiers(store, store.entities[this.aura.source_id])
				s.vis.bans = vis_bans
				s.health_bar.hidden = false
				s.motion.max_speed = move
				s.ui.can_click = true
				s.unit.is_stunned = false
	U.sprites_show(store.entities[this.aura.source_id])
			U.y_wait(store, fts(0.0001))
		end
::out::
		if store.entities[this.aura.source_id] then
		goto nodie
		else
		goto die
	end
::die::
U.sprites_hide(this)
queue_remove(store, this)
	return
end
}
scripts.aura_ZDSD = {
	update = function (this, store)
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	local XD = true
	a.ts = store.tick_ts

	if a.duration < 0 then
	a.ts = 9e+99
	end

while s do
			if store.entities[this.aura.source_id] then
			--nothing
			else
			goto die
			end
XD = true
if a.duration < store.tick_ts - a.ts then
	goto die
	end
	if store.entities[this.aura.source_id] then
	this.pos = s.pos
	else
	goto die
	end
	local enemy, enemies = U.find_foremost_enemy(store.entities, this.pos, 0, a.range, false, a.vis_flags, a.vis_bans)
				if not enemy then
				enemy, enemies = U.find_foremost_enemy(store.entities, this.pos, 0, a.range, false, a.vis_flags, a.vis_bans)
				goto out
				else
			XD = true
			if not enemies then
			this.pos = s.pos
			goto out
			end
			while enemy do
			if not enemies then
			this.pos = s.pos
			goto out
			end
			if XD then
				enemy = enemies[math.random(1, #enemies)]
			end
			if store.entities[this.aura.source_id] then
			--nothing
			else
			goto die
			end
	if XD then
	s.pos = V.vclone(this.pos)
	s.bullet.from = V.vclone(s.pos)
	s.bullet.to = V.vclone(enemy.pos)
	s.bullet.target_id = enemy.id
	end
	XD = false
			if enemy.health.dead or (not enemy) then
				XD = true
				goto out
			end
			U.y_wait(store, fts(0.001))
		end
	end
	::out::
	U.y_wait(store, fts(0.0001))
end
::die::
		U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.aura_as_moloch = {
	update = function (this, store)
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	local ad = this.timed_attacks.list[1]
	local move = s.motion.max_speed
	local blo = 0
	local cso = nil
	
	if s.soldier.melee_slot_offset then
	cso = s.soldier.melee_slot_offset.x
	end
	ad.ts = store.tick_ts
	a.ts = store.tick_ts

	if s.soldier then
	blo = s.melee.range
	end

if U.flag_has(s.vis.flags, F_BOSS or F_HERO) then
s.unit.can_explode = false
s.unit.can_disintegrate = false
end
	if a.duration < 0 then
	a.ts = 9e+99
	end
this.pos = s.pos
while s do
::again::
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if cso then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
	if owner_blocker.enemy and (owner_blocker.enemy.melee_slot.x or 0) > (cso * 0.5) then
	s.soldier.melee_slot_offset.x = cso * 0.5
	else
	s.soldier.melee_slot_offset.x = cso
		end
	end
end
if not U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	s.unit.is_stunned = false
	s.melee.range = blo
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
	else
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
end
if a.duration < store.tick_ts - a.ts then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	goto die
	end
if not s.health.dead then
--nothing
else
local death_show = true
while s.health.dead do
		if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
	s.health_bar.hidden = true
	U.sprites_hide(this)
if not s.health.dead then
s.health_bar.hidden = false
break
end
	if s.unit.hide_during_death or s.unit.hide_after_death then
	death_show = false
	end
	if death_show then
	U.sprites_show(store.entities[this.aura.source_id])
	else
	U.sprites_hide(store.entities[this.aura.source_id])
	end
	if s.hero and s.hero.tombstone_show_time and death_show then
	local death_ts = store.tick_ts
		while store.tick_ts - death_ts < s.hero.tombstone_show_time do
		if store.tick_ts - death_ts >= s.hero.tombstone_show_time then
		break
		end
		U.y_wait(store, fts(0.00001))
			coroutine.yield()
			end
			death_show = false
		end
		U.y_wait(store, fts(0.00001))
	end
end
	s.motion.max_speed = move
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
this.pos = s.pos
this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
		if (ad.cooldown < store.tick_ts - ad.ts) and (not s.unit.is_stunned) and U.animation_finished(store.entities[a.source_id]) then
	local dest = V.vclone(this.pos)
	local af = 1
	this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	dest.x = dest.x + ad.hit_offset.x * af
	dest.y = dest.y + ad.hit_offset.y
		local soldier_d = U.find_nearest_enemy(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
		local soldier = U.find_enemies_in_range(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
		if soldier and #soldier >= (ad.min_count or 0) and s.motion.arrived then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
		if SU.can_melee_blocker(store, owner_blocker, store.entities[this.aura.source_id]) and SU.y_enemy_melee_attacks(store, owner_blocker, store.entities[this.aura.source_id]) then
			s.unit.is_stunned = true
		end
	end
	U.sprites_hide(store.entities[this.aura.source_id])
	U.sprites_show(this)

	s.motion.max_speed = 0
	if ad.bar_hide then
	s.health_bar.hidden = true
	end
		S:queue(ad.sound, ad.sound_args)
		local an, ann = U.animation_name_facing_point(this, ad.animation, soldier_d.pos)
		U.animation_start(this, an, ann, store.tick_ts, 1)
		if this.render.sprites[1].flip_x then
		af = -1
		else
		af = 1
		end
	dest.x = dest.x + ad.hit_offset.x * af
	dest.y = dest.y + ad.hit_offset.y
	soldier_d = U.find_nearest_enemy(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
	soldier = U.find_enemies_in_range(store.entities, dest, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)

	U.y_wait(store, ad.hit_time, function (store, time)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	return true
	end
	if U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	return true
	end
	if store.entities[this.aura.source_id].health.dead then
		return true
	end
end)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if s.health.dead then
goto again
elseif U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
goto again
end
local damage_max = ad.damage_max or 0
local damage_min = ad.damage_min or 0
local damage_type = ad.damage_type or bor(DAMAGE_NONE)
if soldier then
	for _, e in pairs(soldier) do
		local d = E:create_entity("damage")
		d.damage_type = damage_type
		d.source_id = s.id
		d.target_id = e.id
		d.value = math.random(damage_min, damage_max)

		queue_damage(store, d)
					if ad.mods then
	for _, mods in pairs(ad.mods) do
		local mod = E:create_entity(mods)
		mod.modifier.target_id = e.id
		mod.modifier.source_id = s.id

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
			while not U.animation_finished(this) and s do
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
U.sprites_hide(this)
		U.sprites_show(store.entities[this.aura.source_id])
	goto again
	end
				if s.health.dead then
				goto again
				end
				U.y_wait(store, fts(0.0001))
			end
			goto again
		end
	end
	U.y_wait(store, fts(0.0001))
end
::die::
U.sprites_hide(this)
if s then
		U.sprites_show(store.entities[this.aura.source_id])
	end
		queue_remove(store, this)
	return
end
}
scripts.aura_as_XYWXZ = {
	update = function (this, store)
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	local ad = this.timed_attacks.list[1]
	local move = s.motion.max_speed
	local blo = 0
	local cso = nil
	
	if s.soldier.melee_slot_offset then
	cso = s.soldier.melee_slot_offset.x
	end

	ad.ts = store.tick_ts
	a.ts = store.tick_ts

	if s.soldier then
	blo = s.melee.range
	end

if U.flag_has(s.vis.flags, F_BOSS or F_HERO) then
s.unit.can_explode = false
s.unit.can_disintegrate = false
end
	if a.duration < 0 then
	a.ts = 9e+99
	end
this.pos = s.pos
while s do
::again::
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if cso then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
	if owner_blocker.enemy and (owner_blocker.enemy.melee_slot.x or 0) > (cso * 0.5) then
	s.soldier.melee_slot_offset.x = cso * 0.5
	else
	s.soldier.melee_slot_offset.x = cso
		end
	end
end
if not U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	s.unit.is_stunned = false
	s.melee.range = blo
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
	else
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
end
if a.duration < store.tick_ts - a.ts then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	goto die
	end
if not s.health.dead then
--nothing
else
local death_show = true
while s.health.dead do
		if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
	s.health_bar.hidden = true
	U.sprites_hide(this)
if not s.health.dead then
s.health_bar.hidden = false
break
end
	if s.unit.hide_during_death or s.unit.hide_after_death then
	death_show = false
	end
	if death_show then
	U.sprites_show(store.entities[this.aura.source_id])
	else
	U.sprites_hide(store.entities[this.aura.source_id])
	end
	if s.hero and s.hero.tombstone_show_time and death_show then
	local death_ts = store.tick_ts
		while store.tick_ts - death_ts < s.hero.tombstone_show_time do
		if store.tick_ts - death_ts >= s.hero.tombstone_show_time then
		break
		end
		U.y_wait(store, fts(0.00001))
			coroutine.yield()
			end
			death_show = false
		end
		U.y_wait(store, fts(0.00001))
	end
end
	s.motion.max_speed = move
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
this.pos = s.pos
this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
		if (ad.cooldown < store.tick_ts - ad.ts) and (not s.unit.is_stunned) and U.animation_finished(store.entities[a.source_id]) then
	this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	local af = 1
	local count = 0
		if s.motion.arrived then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
		if SU.can_melee_blocker(store, owner_blocker, store.entities[this.aura.source_id]) and SU.y_enemy_melee_attacks(store, owner_blocker, store.entities[this.aura.source_id]) then
			s.unit.is_stunned = true
			s.melee.range = 0
		end
	end
	U.sprites_hide(store.entities[this.aura.source_id])
	U.sprites_show(this)

	s.motion.max_speed = 0
	if ad.bar_hide then
	s.health_bar.hidden = true
	end
	this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
		U.y_animation_play(this, ad.animations[1], nil, store.tick_ts)
while s do
	U.animation_start(this, ad.animations[2], nil, store.tick_ts, 1)
	while s do
	count = count + 1
	if count > #ad.max_damages then
	goto real
	end
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	local enemies = U.find_enemies_in_range(store.entities, this.pos, 0, ad.damage_radius, ad.vis_flags, ad.vis_bans)
	if ad.sound then
	S:queue(ad.sound, ad.sound_args)
	end
	U.y_wait(store, ad.hit_times[km.zmod(count, #ad.hit_times)], function (store, time)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	return true
	end
	if U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	return true
	end
	if store.entities[this.aura.source_id].health.dead then
		return true
	end
end)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if s.health.dead then
goto again
elseif U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
goto again
end
if ad.sound_hit then
S:queue(ad.sound_hit)
end
if enemies then
	for _, e in pairs(enemies) do
		local dmin = ad.min_damages[count]
		local dmax = ad.max_damages[count]
		local dist_factor = U.dist_factor_inside_ellipse(e.pos, this.pos, ad.damage_radius, ad.max_damage_radius)
		local d = E:create_entity("damage")
		d.damage_type = ad.damage_type or DAMAGE_NONE
		d.source_id = s.id
		d.target_id = e.id
		d.value = math.ceil(dmax - (dmax - dmin) * dist_factor)

		queue_damage(store, d)
	end
end
if ad.hit_fx then
		local xo = ad.fx_offsets[km.zmod(count, #ad.hit_times)]
		local fx = E:create_entity(ad.hit_fx)
		fx.render.sprites[1].ts = store.tick_ts
		fx.pos.x = this.pos.x + xo.x * af
		fx.pos.y = this.pos.y + xo.y

		queue_insert(store, fx)
	end
	if s then
			local a = E:create_entity("aura_screen_shake")
			a.aura.amplitude = count / #ad.max_damages

			queue_insert(store, a)
	end
	if km.zmod(count, #ad.hit_times) == #ad.hit_times then
	goto next
		end
	end
::next::
				while not U.animation_finished(this) and s do
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
U.sprites_hide(this)
		U.sprites_show(store.entities[this.aura.source_id])
	goto again
	end
		if s.health.dead then
		goto again
		end
		U.y_wait(store, fts(0.0001))
		end
	end
::real::
			ad.ts = store.tick_ts
			goto again
		end
	end
	U.y_wait(store, fts(0.0001))
end
::die::
U.sprites_hide(this)
if s then
		U.sprites_show(store.entities[this.aura.source_id])
	end
		queue_remove(store, this)
	return
end
}
scripts.aura_as_greenmuck = {
	update = function (this, store)
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	local ad = this.timed_attacks.list[1]
	local move = s.motion.max_speed
	local blo = 0
	local cso = nil
	
	if s.soldier.melee_slot_offset then
	cso = s.soldier.melee_slot_offset.x
	end
	
	ad.ts = store.tick_ts
	a.ts = store.tick_ts

	if s.soldier then
	blo = s.melee.range
	end
if U.flag_has(s.vis.flags, F_BOSS or F_HERO) then
s.unit.can_explode = false
s.unit.can_disintegrate = false
end
	if a.duration < 0 then
	a.ts = 9e+99
	end
this.pos = s.pos
while true do
::again::
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if not U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	s.unit.is_stunned = false
	s.melee.range = blo
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
	else
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
end
if a.duration < store.tick_ts - a.ts then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	goto die
	end
if not s.health.dead then
--nothing
else
local death_show = true
while s.health.dead do
		if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if cso then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
	if owner_blocker.enemy and (owner_blocker.enemy.melee_slot.x or 0) > (cso * 0.5) then
	s.soldier.melee_slot_offset.x = cso * 0.5
	else
	s.soldier.melee_slot_offset.x = cso
		end
	end
end
	s.health_bar.hidden = true
	U.sprites_hide(this)
if not s.health.dead then
s.health_bar.hidden = false
break
end
	if s.unit.hide_during_death or s.unit.hide_after_death then
	death_show = false
	end
	if death_show then
	U.sprites_show(store.entities[this.aura.source_id])
	else
	U.sprites_hide(store.entities[this.aura.source_id])
	end
	if s.hero and s.hero.tombstone_show_time and death_show then
	local death_ts = store.tick_ts
		while store.tick_ts - death_ts < s.hero.tombstone_show_time do
		if store.tick_ts - death_ts >= s.hero.tombstone_show_time then
		break
		end
		U.y_wait(store, fts(0.00001))
			coroutine.yield()
			end
			death_show = false
		end
		U.y_wait(store, fts(0.00001))
	end
end
	s.motion.max_speed = move
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
this.pos = s.pos
this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
		if (ad.cooldown < store.tick_ts - ad.ts) and (not s.unit.is_stunned) and U.animation_finished(store.entities[a.source_id]) then
	local af = 1
	this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
		local targets = U.find_targets_in_range(store.entities, this.pos, 0, 99999, ad.vis_flags, ad.vis_bans)
		if not targets then
		targets = U.find_targets_in_range(store.entities, this.pos, 0, 99999, ad.vis_flags, ad.vis_bans)
		elseif s.motion.arrived then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
		if SU.can_melee_blocker(store, owner_blocker, store.entities[this.aura.source_id]) and SU.y_enemy_melee_attacks(store, owner_blocker, store.entities[this.aura.source_id]) then
			s.unit.is_stunned = true
		end
	end
	local count = 0
	U.sprites_hide(store.entities[this.aura.source_id])
	U.sprites_show(this)
	s.motion.max_speed = 0
	if ad.bar_hide then
	s.health_bar.hidden = true
	end
		S:queue(ad.sound, ad.sound_args)
		U.animation_start(this, ad.animation, nil, store.tick_ts, 1)
		if this.render.sprites[1].flip_x then
		af = -1
		else
		af = 1
		end
		
	U.y_wait(store, ad.shoot_time, function (store, time)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	return true
	end
	if U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	return true
	end
	if store.entities[this.aura.source_id].health.dead then
		return true
	end
end)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if s.health.dead then
goto again
elseif U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
goto again
end
		local random_targets = table.random_order(targets)
if random_targets and ad.bullet then
		for i, t in ipairs(random_targets) do
		if count >= (ad.count or 1) then
		goto next
		end
		if (not targets) or (not random_targets) then
		goto next
		end
		local TP = P:predict_enemy_pos(t, ad.node_prediction)
		local b = E:create_entity(ad.bullet)
		b.pos = V.vclone(this.pos)
		b.pos.x = this.pos.x + ad.bullet_start_offset.x * af
		b.pos.y = this.pos.y + ad.bullet_start_offset.y
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = TP
		queue_insert(store, b)
		count = count + 1
	end
end
	::next::
		ad.ts = store.tick_ts
			while not U.animation_finished(this) do
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
U.sprites_hide(this)
	goto again
	end
				if s.health.dead then
				goto again
				end
				U.y_wait(store, fts(0.0001))
			end
	goto again
		end
	end
	U.y_wait(store, fts(0.0001))
end
::die::
U.sprites_hide(this)
if s then
		U.sprites_show(store.entities[this.aura.source_id])
	end
		queue_remove(store, this)
	return
end
}
scripts.aura_as_HMZ = {
	update = function (this, store)
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	local ab = this.timed_attacks.list[1]
	local am = this.timed_attacks.list[2]
	local move = s.motion.max_speed
	local TS = false
	local death_sound, death_args = nil
	local blo = 0
	local cso = nil
	
	if s.soldier.melee_slot_offset then
	cso = s.soldier.melee_slot_offset.x
	end
	
	a.ts = store.tick_ts
	ab.ts = store.tick_ts
	am.ts = store.tick_ts
	
	
	if s.soldier then
	blo = s.melee.range
	end
	if s.sound_events.death then
	death_sound = s.sound_events.death
	s.sound_events.death = nil
	end
	if s.sound_events.death_args then
	death_args = s.sound_events.death_args
	s.sound_events.death_args = nil
	end

if U.flag_has(s.vis.flags, F_BOSS or F_HERO) then
s.unit.can_explode = false
s.unit.can_disintegrate = false
end
	if a.duration < 0 then
	a.ts = 9e+99
	end
this.pos = s.pos
while true do
::again::
	if TS then
	U.sprites_hide(store.entities[this.aura.source_id])
	U.sprites_show(this)
	end
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if cso then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
	if owner_blocker.enemy and (owner_blocker.enemy.melee_slot.x or 0) > (cso * 0.5) then
	s.soldier.melee_slot_offset.x = cso * 0.5
	else
	s.soldier.melee_slot_offset.x = cso
		end
	end
end
if not U.has_modifier_types(store, store.entities[this.aura.source_id], MOD_TYPE_STUN, MOD_TYPE_FREEZE) then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	s.unit.is_stunned = false
	s.melee.range = blo
	if not TS then
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
	end
	else
	if not TS then
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
	end
end
if a.duration < store.tick_ts - a.ts then
	s.motion.max_speed = move
	s.health_bar.hidden = false
	goto die
	end
if not s.health.dead then
--nothing
else
if TS then
if death_sound then
	S:queue(death_sound, death_args)
end
	U.y_animation_play(this, "death", nil, store.tick_ts)
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
	TS = false
	else
	if death_sound then
	S:queue(death_sound, death_args)
	end
end
local death_show = true
while s.health.dead do
		if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
	s.health_bar.hidden = true
	U.sprites_hide(this)
if not s.health.dead then
s.health_bar.hidden = false
break
end
	if s.unit.hide_during_death or s.unit.hide_after_death then
	death_show = false
	end
	if death_show then
	U.sprites_show(store.entities[this.aura.source_id])
	else
	U.sprites_hide(store.entities[this.aura.source_id])
	end
	if s.hero and s.hero.tombstone_show_time and death_show then
	local death_ts = store.tick_ts
		while store.tick_ts - death_ts < s.hero.tombstone_show_time do
		if store.tick_ts - death_ts >= s.hero.tombstone_show_time then
		break
		end
		U.y_wait(store, fts(0.00001))
			coroutine.yield()
			end
			death_show = false
		end
		U.y_wait(store, fts(0.00001))
	end
end
	s.motion.max_speed = move
	U.sprites_show(store.entities[this.aura.source_id])
	U.sprites_hide(this)
this.pos = s.pos
this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
			for _, ad in pairs(this.timed_attacks.list) do
		if (ad.cooldown < store.tick_ts - ad.ts) and (not s.unit.is_stunned) and U.animation_finished(store.entities[a.source_id]) then
	local af = 1
	this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
		if s.motion.arrived then
	if s.soldier.target_id then
	local blocked_id = s.soldier.target_id
	local owner_blocker = store.entities[blocked_id]
		if SU.can_melee_blocker(store, owner_blocker, store.entities[this.aura.source_id]) and SU.y_enemy_melee_attacks(store, owner_blocker, store.entities[this.aura.source_id]) then
			s.unit.is_stunned = true
		end
	end
	U.sprites_hide(store.entities[this.aura.source_id])
	U.sprites_show(this)
	s.motion.max_speed = 0
	if ad.bar_hide then
	s.health_bar.hidden = true
	end
		S:queue(ad.sound, ad.sound_args)
		U.animation_start(this, ad.animation, nil, store.tick_ts, 1)
		if this.render.sprites[1].flip_x then
		af = -1
		else
		af = 1
		end
		
	U.y_wait(store, ad.shoot_time, function (store, time)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	return true
	end
	if store.entities[this.aura.source_id].health.hp <= 0 then
		return true
	end
end)
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
if s.health.hp <= 0 then
TS = true
end
		local targets = U.find_enemies_in_range(store.entities, this.pos, ad.min_range, ad.max_range, ad.vis_flags, ad.vis_bans)
			if not targets then 
			targets = U.find_enemies_in_range(store.entities, this.pos, ad.min_range, ad.max_range, ad.vis_flags, ad.vis_bans)
			goto tarout
			end
::tarout::
			if ad.bullet then
		local b = E:create_entity(ad.bullet)
		b.pos = V.vclone(this.pos)
		b.pos.x = this.pos.x + ad.bullet_start_offset.x * af
		b.pos.y = this.pos.y + ad.bullet_start_offset.y
		b.bullet.from = V.vclone(b.pos)
	if ad == ab then
		b.bullet.to = V.v(b.pos.x + ad.launch_vector.x, b.pos.y + ad.launch_vector.y)
		if targets then
		b.bullet.target_id = targets[math.random(1, #targets)]
		else
		goto about
	end
end
::about::
if ad == am then
	local TP = P:get_random_position(20, TERRAIN_LAND, NF_RANGE, 30)
		b.bullet.to = TP
		if b.bullet.hit_payload then
		b.bullet.hit_payload = E:create_entity(b.bullet.hit_payload)
		b.bullet.hit_payload.spawner.owner_id = s.id
		end
	end
	if b.bullet.to then
	--nothing
	else
	goto tarout
	end
	queue_insert(store, b)
end
	ad.ts = store.tick_ts
			while not U.animation_finished(this) do
	if store.entities[this.aura.source_id] then
	--nothing
	else
	goto die
	end
					if s.health.hp <= 0 then
					TS = true
					end
					U.y_wait(store, fts(0.0001))
				end
				if s.health.hp <= 0 then
				TS = true
				end
				goto again
			end
		end
	end
	U.y_wait(store, fts(0.0001))
end
::die::
U.sprites_hide(this)
if s then
		U.sprites_show(store.entities[this.aura.source_id])
	end
		queue_remove(store, this)
	return
end
}
scripts.aura_veznan_stand = {
	update = function (this, store)
	local aa = this.attacks.list[1]
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	aa.ts = store.tick_ts
	this.aura.ts = store.tick_ts


	this.pos = s.pos
if this.render.sprites then
	U.sprites_hide(this)
end
	if a.duration then
	--nothing
	else
	goto die
	end
	if a.duration < 0 then
	this.aura.ts = 99999
	end
	while s do
	if s.render.sprites[1].prefix == "eb_veznan_demon" then
	goto out
	end
	if s then
	this.pos = s.pos
	else
	goto die
	end
	local af = 1
	local soldiern = U.find_nearest_soldier(store.entities, this.pos, 0, aa.range, aa.vis_flags, aa.vis_bans)
	local real = nil
	this.render.sprites[1].flip_x = s.render.sprites[1].flip_x
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	if soldiern then
	real = U.find_soldiers_in_range(store.entities, soldiern.pos, 0, aa.radius, aa.vis_flags, aa.vis_bans)
	end
	if real and (aa.cooldown < store.tick_ts - aa.ts) then
	soldiern = U.find_nearest_soldier(store.entities, this.pos, 0, aa.range, aa.vis_flags, aa.vis_bans)
	if not real then
	real = U.find_soldiers_in_range(store.entities, soldiern.pos, 0, aa.radius, aa.vis_flags, aa.vis_bans)
	else
	local appear = aa.appear_pos[math.random(1, #aa.appear_pos)]
	this.pos = V.vclone(s.pos)
	this.pos.x = this.pos.x + appear.x * af
	this.pos.y = this.pos.y + appear.y
		U.sprites_show(this)
	U.y_animation_play(this, "teleport_in", nil, store.tick_ts)
	if aa.sound then
	S:queue(aa.sound, aa.sound_args)
	end
	if aa.animations[1] then
	local an, ann = U.animation_name_facing_point(this, aa.animations[1], soldiern.pos)
	U.animation_start(this, an, ann, store.tick_ts, 1)
	U.y_animation_wait(this, 1)
	end
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	if aa.animations[1] then
		U.animation_start(this, aa.animations[2], nil, store.tick_ts, 1)
	else
	local an, ann = U.animation_name_facing_point(this, aa.animations[2], soldiern.pos)
		U.animation_start(this, an, ann, store.tick_ts, 1)
	end
		U.y_wait(store, aa.cast_time)
	if this.render.sprites[1].flip_x then
	af = -1
	else
	af = 1
	end
	if soldiern.health.dead then
	goto soulout
	end
if real then
local count = 0
	for _, r in pairs(real) do
	if r.health.dead then
	goto soulout
	end
	if count >= (aa.max_count or 99999) then
	goto soulout
	end
	local afr = 1
	local fx = nil
	local ball = nil
	if r.render.sprites[1].flip_x then
	afr = -1
	else
	afr = 1
	end
if r then
		U.sprites_hide(store.entities[r.id])
		fx = E:create_entity(aa.hit_fx)
		fx.pos = V.vclone(r.pos)
		fx.pos.x = r.pos.x + r.unit.hit_offset.x
		fx.pos.y = r.pos.y + r.unit.hit_offset.y
		fx.render.sprites[1].ts = store.tick_ts
		if r.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[r.unit.size]
		end
		queue_insert(store, fx)
		ball = E:create_entity(aa.ball)
		ball.pos = V.vclone(r.pos)
		ball.pos.x = r.pos.x + r.unit.hit_offset.x + ball.offset.x * afr
		ball.pos.y = r.pos.y + r.unit.hit_offset.y + ball.offset.y
		ball.bullet.from = V.vclone(ball.pos)
		ball.bullet.to = V.v(this.pos.x + aa.balls_dest_offset.x * af, this.pos.y + aa.balls_dest_offset.y)
		ball.render.sprites[1].hidden = false
		queue_insert(store, ball)
		fx = E:create_entity(ball.spawn_fx)
		fx.pos = V.vclone(ball.pos)
		fx.render.sprites[1].ts = store.tick_ts
		if r.unit.size and fx.render.sprites[1].size_names then
		fx.render.sprites[1].name = fx.render.sprites[1].size_names[r.unit.size]
		end
		queue_insert(store, fx)
		local d = E:create_entity("damage")
		d.damage_type = DAMAGE_EAT
		d.source_id = s.id
		d.target_id = r.id
		d.value = 0
		queue_damage(store, d)
		r.health.ignore_damage = nil
		r.health.hp = 0
		r.health_bar.hidden = true
		r.unit.hide_during_death = true
		count = count + 1
	end
end
	else
	goto soulout
end
	::soulout::
	aa.ts = store.tick_ts
	if s.render.sprites[1].prefix == "eb_veznan_demon" then
	goto out
	end
	U.animation_start(this, aa.animations[3], nil, store.tick_ts, 1)
	U.y_animation_wait(this, 1)
	U.y_animation_play(this, "teleport_out", nil, store.tick_ts)
	U.sprites_hide(this)
	if s.render.sprites[1].prefix == "eb_veznan_demon" then
	goto die
	end
	this.pos = s.pos
	end
	else
	goto noto
end
::noto::
	if (a.duration < store.tick_ts - this.aura.ts) or s.health.dead then
	goto out
	end
	U.y_wait(store, (a.delay or 0) + fts(0.01))
end
::out::
		U.sprites_show(this)
	U.y_animation_play(this, "death", nil, store.tick_ts)
::die::
		U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.aura_many_shooters = {
	update = function (this, store)
	local aa = this.attacks.list[1]
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	local idle_cooldown = 3
	local an_ts = store.tick_ts
	local shooter = {}
	local aa_cod = aa.cooldown
	aa.ts = store.tick_ts
	a.ts = store.tick_ts
		local function shot_animation(attack, shooter_idx, enemy, animation)
			local ssid = shooter_idx
			local soffset = this.render.sprites[ssid].offset
			local s = this.render.sprites[ssid]
			local an, af, ai = U.animation_name_facing_point(this, animation or attack.animation, enemy.pos, ssid, soffset)

			U.animation_start(this, an, af, store.tick_ts, 1, ssid)

			return an, af, ai
		end

		local function shot_bullet(attack, shooter_idx, ani_idx, enemy)
			local ssid = shooter_idx
			local shooting_right = this.pos.x < enemy.pos.x
			local soffset = this.render.sprites[ssid].offset
			local boffset = attack.bullet_start_offset[ani_idx]
			local b = E:create_entity(attack.bullet)
			b.pos.x = this.pos.x + soffset.x + boffset.x * (shooting_right and 1 or -1)
			b.pos.y = this.pos.y + soffset.y + boffset.y
			b.bullet.from = V.vclone(b.pos)
			b.bullet.to = V.v(enemy.pos.x + enemy.unit.hit_offset.x, enemy.pos.y + enemy.unit.hit_offset.y)
			b.bullet.target_id = enemy.id

			queue_insert(store, b)

			return b
		end
	if s then
	--nothing
	else
	goto die
	end
	if a.duration < 0 or not a.duration then
	a.duration = 9e+99
	end
	if a.soul then
		local mod = E:create_entity("mod_FD")
		mod.modifier.target_id = this.id

		queue_insert(store, mod)
	end
	if this.render.sprites then
	for i = 1, #this.render.sprites do
	shooter[i] = this.render.sprites[i]
	shooter[i].group = group_shooter
	end
end
	while true do
	if a.duration < store.tick_ts - a.ts then
	goto die
	end
	if store.entities[this.aura.source_id] then
	this.pos = s.pos
	else
	goto die
	end
			if aa.cooldown < store.tick_ts - aa.ts then
			local enemy, enemies = U.find_foremost_enemy(store.entities, this.pos, aa.min_range, aa.max_range, false, aa.vis_flags, aa.vis_bans)
			local count = 1
			local fear = false
			if not enemy then
			enemy, enemies = U.find_foremost_enemy(store.entities, this.pos, aa.min_range, aa.max_range, false, aa.vis_flags, aa.vis_bans)
			else
		local enemy_real = enemies[km.zmod(count, #enemies)]
		local shooter_idx = km.zmod(count, #shooter)
		local an, af, ai = shot_animation(aa, shooter_idx, enemy_real)
					if aa.attack_fear then
			local near_enemy = U.find_enemies_in_range(store.entities, this.pos, 0, aa.max_range * 0.75, aa.vis_flags, aa.vis_bans)
			if not near_enemy then
			near_enemy = U.find_enemies_in_range(store.entities, this.pos, 0, aa.max_range * 0.75, aa.vis_flags, aa.vis_bans)
			else
				if #near_enemy > #shooter * 2 then
			fear = true
			aa.cooldown = aa_cod / 2
			for i = 1, #this.render.sprites do
			this.render.sprites[i].fps = FPS * 2
			end
		end
		if #near_enemy > #shooter then
		aa.cooldown = aa_cod
			for i = 1, #this.render.sprites do 
				this.render.sprites[i].fps = FPS
				fear = false
				enemies = near_enemy
				end
			end
		end
	end
			while true do
			if fear then
			enemy_real = enemies[math.random(1, #enemies)]
			else
			enemy_real = enemies[km.zmod(count, #enemies)]
			end
			shooter_idx = km.zmod(count, #shooter)
			if store.entities[this.aura.source_id] then
			--nothing
			else
			goto die
			end
		if not enemy_real then
			goto outt
		end
		if not enemies then
			goto outt
		end
			if count > #shooter then
			goto next
			end
			shot_animation(aa, shooter_idx, enemy_real, aa.animation)
			count = count + 1
			end
::next::
		count = 1
		if fear then
		U.y_wait(store, aa.shoot_time / 2)
		else
		U.y_wait(store, aa.shoot_time)
		end
			while true do
			if fear then
			enemy_real = enemies[math.random(1, #enemies)]
			else
			enemy_real = enemies[km.zmod(count, #enemies)]
			end
			shooter_idx = km.zmod(count, #shooter)
			if count > #shooter then
			goto out
			end
		if not enemy_real then
			goto out
		end
		if not enemies then
			goto out
		end
				if store.entities[this.aura.source_id] then
				this.pos = s.pos
				else
				goto die
				end
				if V.dist(this.pos.x, this.pos.y, enemy_real.pos.x, enemy_real.pos.y) <= aa.max_range and V.dist(this.pos.x, this.pos.y, enemy_real.pos.x, enemy_real.pos.y) >= aa.min_range then
					shot_bullet(aa, shooter_idx, ai, enemy_real)
				end
			count = count + 1
			end
::out::
		aa.ts = store.tick_ts
		enemy, enemies = U.find_foremost_enemy(store.entities, this.pos, aa.min_range, aa.max_range, false, aa.vis_flags, aa.vis_bans)
		U.y_animation_wait_group(this, group_shooter)
::outt::
	end
end
		if idle_cooldown < store.tick_ts - an_ts then
		local aff, ann = U.animation_name_facing_point(this, "idle", V.v(this.pos.x + math.random(-44, 44), this.pos.y))
		U.animation_start_group(this, aff, ann, store.tick_ts, true, group_shooter)
		an_ts = store.tick_ts
	end
	U.y_wait(store, fts(0.00001))
end
::die::
		U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.mod_bullet_chance = {
	update = function (this, store)
	local m = this.modifier
	local target = store.entities[m.target_id]
	m.ts = store.tick_ts
	local loop = true

	if target then
	--nothing
	else
	goto die
	end

	this.pos = target.pos
		if (m.bullet_chance == 1 or math.random() < m.bullet_chance) then
			if m.bullet then
		local mod = E:get_template("mod_hero_thor_thunderclap_d")
		mod.thunderclap.damage = 75
		mod.thunderclap.secondary_damage = 85
		mod.thunderclap.stun_duration_max = 3
		mod.thunderclap.max_range = 70
		local b = E:create_entity(m.bullet)
		b.pos.x = target.pos.x + math.random(-666, 666)
		b.pos.y = target.pos.y + math.random(-666, 666)
		b.bullet.from = V.vclone(b.pos)
		b.bullet.to = V.v(target.pos.x + target.unit.hit_offset.x, target.pos.y + target.unit.hit_offset.y)
		b.bullet.target_id = target.id
		
		queue_insert(store, b)
		if m.XD then
		local aura = E:create_entity("aura_ZDSD")
		aura.aura.source_id = b.id
		queue_insert(store, aura)
		end

		end
	end
::die::
		queue_remove(store, this)
	return
end
}
scripts.aura_spawn_pet = {
	update = function (this, store)
	local a = this.aura
	local s = store.entities[this.aura.source_id]
	local last_pos = V.vclone(s.nav_rally.pos)
	local pets = {}
	local pet_last_pos = {}

	local function valid_node_check(pos, node)
	local nodes = P:nearest_nodes(pos.x, pos.y, nil, nil, true)
::loop::
	if #nodes > 0 then
	goto run
	else
	nodes = P:nearest_nodes(pos.x, pos.y, nil, nil, true)
	goto loop
	end
::run::
	pi, spi, ni = unpack(nodes[1])
	ni = ni + node
		return P:is_node_valid(pi, ni)
	end

	a.ts = store.tick_ts

	if a.duration < 0 then
	a.ts = 9e+99
	end
	if true then
::again::
		local count = 1
		local names = 0
		local loops = 1
		if a.pet_names then
		loops = #a.pet_names
		count = #a.pet_names
		elseif a.pet_name and a.pet_count then
		loops = a.pet_count
		count = a.pet_count
		end
		for i = 1, loops do
		::find::
		if a.pet_names and names >= #a.pet_names then
		goto next
		end
		if true then
		local p = nil
		if a.pet_name then
		p = E:create_entity(a.pet_name)
		elseif a.pet_names then
		p = E:create_entity(a.pet_names[i])
		end
		p.pos = V.vclone(s.pos)
		p.nav_rally.pos = V.vclone(s.nav_rally.pos)
		p.health.living = true
::nig::
		local nodes = P:nearest_nodes(p.nav_rally.pos.x, p.nav_rally.pos.y, nil, nil, true)
		if #nodes > 0 then
		--nothing
		else
		goto nig
		end
		local pi, spi, ni = unpack(nodes[1])
		spi = km.zmod(spi+ i, 3)
		if a.node_list then
			if valid_node_check(s.nav_rally.pos, a.node_list[km.zmod(i, #a.node_list)]) then
			--nothing
			else
			goto finish
			end
		ni = ni + a.node_list[km.zmod(i, #a.node_list)]
		end
		if P:is_node_valid(pi, ni) then
		p.pos = P:node_pos(pi, spi, ni)
		p.nav_rally.pos = P:node_pos(pi, spi, ni)
		else
		goto nig
		end
::finish::
		if a.one_king then
		p.nav_rally.center = V.vclone(s.nav_rally.center)
		else
		p.nav_rally.center = V.vclone(p.nav_rally.pos)
		end
	E:add_comps(p, "nav_grid")
		p.owner = s
		pets[i] = p
		pet_last_pos[i] = V.vclone(p.nav_rally.pos)
		
			if p then
			queue_insert(store, p)
			elseif not (a.pet_name or a.pet_names) then
			--nothing
			else
			goto again
			end
		end
	end
end
::next::

while store.entities[this.aura.source_id] do

				if pets then
					for i = 1, #pets do
					local count = 1
					local p = pets[i]
				if a.pet_max_level then
					if p.hero then
						if p.hero.level < 10 then
						p.hero.xp_queued = 600
						end
					end
				end
					if a.pet_names then
					count = #a.pet_names
					elseif a.pet_name and a.pet_count then
					count = a.pet_count
					end
					if p and p.health.dead then
					p.health.living = false
					end
					if not pet_last_pos[i] then
						pet_last_pos[i] = p.pos
					end

					if not p or (p.health.dead and p.health.dead_lifetime < store.tick_ts - p.health.death_ts) then
						if not (p.hero and not p.health.living) then
						local ps = E:create_entity(p.template_name)
						ps.owner = s
						ps.pos = pet_last_pos[i]
						ps.nav_rally.pos = pet_last_pos[i]
						ps.nav_rally.new = true
						ps.health.living = true
						E:add_comps(ps, "nav_grid")
						pets[i] = ps
						ps.nav_rally.center = ps.nav_rally.pos or s.nav_rally.center

						queue_insert(store, ps)
						ps.nav_grid.waypoints = GR:find_waypoints(ps.pos, nil, ps.nav_rally.pos, bor(ps.nav_grid.valid_terrains, TERRAIN_LAND))
						end
					end
				end
			end
if a.duration < store.tick_ts - a.ts then
	goto die
	end
	if s.health.dead then
	goto die
	end
	if store.entities[this.aura.source_id] then
	this.pos = s.pos
	else
	goto die
	end

if s.nav_rally.pos.x ~= last_pos.x or s.nav_rally.pos.y ~= last_pos.y then
		for i = 1, #pets do
		if pets[i] then
::again2::
		local count = 1
		local p = pets[i]
		if a.pet_names then
		count = #a.pet_names
		elseif a.pet_name and a.pet_count then
		count = a.pet_count
		end
		p.nav_rally.pos = V.vclone(s.nav_rally.pos)
::nig2::
		local nodes = P:nearest_nodes(p.nav_rally.pos.x, p.nav_rally.pos.y, nil, nil, true)
		if #nodes > 0 then
		--nothing
		else
		goto nig2
		end
		local pi, spi, ni = unpack(nodes[1])
		spi = km.zmod(spi +i, 3)
		if a.node_list then
			for _, nodes in pairs(a.node_list) do
			if valid_node_check(s.nav_rally.pos, nodes) then
			--nothing
			else
			p.nav_rally.pos = p.pos
			goto out
			end
		end
		ni = ni + a.node_list[km.zmod(i, #a.node_list)]
		end
		if P:is_node_valid(pi, ni) then
		p.nav_rally.pos = P:node_pos(pi, spi, ni) or p.nav_rally.pos
		else
		goto nig2
		end
		if a.one_king then
		p.nav_rally.center = V.vclone(s.nav_rally.center)
		else
		p.nav_rally.center = V.vclone(p.nav_rally.pos)
		end
		p.nav_rally.new = true
		pet_last_pos[i] = V.vclone(p.nav_rally.pos)
		p.nav_grid.waypoints = GR:find_waypoints(p.pos, nil, p.nav_rally.pos, bor(p.nav_grid.valid_terrains, TERRAIN_LAND))
		queue_insert(store, aura)
			if p and (not p.health.dead) and p.sound_events.change_rally_point then
				S:queue(p.sound_events.change_rally_point)
			end
		end
	end
::out::
		last_pos = V.vclone(s.nav_rally.pos)
	end
	coroutine.yield()
end
::die::
				if pets then
					for i=1, #pets do
					local p = pets[i]
					SU.remove_modifiers(store, store.entities[p.id])
					SU.remove_auras(store, store.entities[p.id])
					U.sprites_hide(store.entities[p.id])
					queue_remove(store, store.entities[p.id])
				end
			end
		U.sprites_hide(this)
		queue_remove(store, this)
	return
end
}
scripts.crab = {
  update = function (this, store)
  local function no_hero_can()
  if store.level.locked_hero then
  return false
  end
  return store.selected_hero
end
if this.hero_insert and no_hero_can() then
  local hero = LU.insert_hero(store, this.template_name, this.nav_rally.pos)
  hero.hero_insert = false
    U.sprites_hide(this)
    queue_remove(store, this)
    return
  elseif this.hero_insert then
    local so = E:create_entity(this.template_name)
    so.pos = this.nav_rally.pos
    so.hero_insert = false
    so.nav_rally.pos = this.nav_rally.pos
    so.nav_rally.center = so.nav_rally.pos
    queue_insert(store, so)
    U.sprites_hide(this)
    queue_remove(store, this)
    return
  end
::twice::
  if this.auras then
  local aura = {}
  for i = 1,#this.auras.list do
::again::
        aura[i] = E:create_entity(this.auras.list[i].name)
        aura[i].aura.source_id = this.id
        aura[i].pos = this.pos
        if aura[i] then
        queue_insert(store, aura[i])
        else
        goto again
        end
      end
    return GSC2.hero_crab.update(this, store)
      else
    return GSC2.hero_crab.update(this, store)
  end
end
}
scripts.Soldier_ArchImage = {
get_info = function (this)
		local min, max, d_type = nil
		local b = E:get_template(this.ranged.attacks[1].bullet)
		local m = E:get_template(b.bullet.mod)
		d_type = m.dps.damage_type
		local bounce_factor = UP:get_upgrade("engineer_efficiency") and 1 or b.bounce_damage_factor
		max = b.bounce_damage_max
		min = b.bounce_damage_min
		max = math.ceil(max * bounce_factor)
		min = math.ceil(min * bounce_factor)

		return {
			type = STATS_TYPE_SOLDIER,
			hp = this.health.hp,
			hp_max = this.health.hp_max,
			damage_min = min,
			damage_max = max,
			armor = this.health.armor,
			respawn = this.health.dead_lifetime
		}
	end,
}
return scripts