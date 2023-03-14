local log = require("klua.log"):new("game")
local km = require("klua.macros")
local signal = require("hump.signal")
local V = require("hump.vector-light")
local U = require("utils")
local RU = require("render_utils")
local I = require("klove.image_db")
local E = require("entity_db")
local F = require("klove.font_db")
local P = require("path_db")
local S = require("sound_db")
local SU = require("screen_utils")
local GR = require("grid_db")
local GS = require("game_settings")
local UP = require("upgrades")
local AC = require("achievements")
local PS = require("platform_services")
local simulation = require("simulation")
local game_gui = require("game_gui")
local G = love.graphics
local bit = require("bit")

require("constants")

game = {
	required_textures = {
		"go_decals",
		"go_enemies_common",
		"go_towers",
		"go_enemies_torment",
		"go_enemies_wastelands",
		"go_enemies_ice",
		"go_hero_gerald",
		"go_hero_alleria",
		"go_hero_bolin",
		"go_hero_magnus",
		"go_hero_ignus",
		"go_hero_malik",
		"go_hero_denas",
		"go_hero_ingvar",
		"go_hero_elora",
		"go_hero_oni",
		"go_hero_hacksaw",
		"go_hero_thor",
		"go_hero_10yr",
		"go_hero_dracolich",			  
		"go_stage08",
		"go_stage21",
		"go_hero_wilbur",		   
		"go_enemies_rising_tides",
		"go_enemies_hulking_rage",					
		"go_stage141_bg",
		"go_enemies_bandits",
		"go_hero_rag",
		"go_hero_monk",
		"go_hero_beastmaster",
		"go_hero_lynn",
		"go_hero_dragon",
		"go_hero_arivan",
		"go_hero_mirage",
		"go_hero_faustus",
		"go_hero_elves_archer",
		"go_hero_regson",
		"go_hero_crab",
		"go_hero_baby_malik",
		"go_hero_xin",
		"go_stage131",
		"go_hero_bravebark",
		"go_hero_alric",
		"go_hero_pirate",
		"go_hero_catha",
		"go_hero_voodoo_witch",
		"go_hero_priest",
		"go_hero_elves_denas",
		"go_hero_veznan",
		"go_hero_van_helsing",
		"go_hero_minotaur",
		"go_hero_durax",
		"go_hero_giant",
		"go_hero_alien",
		"go_enemies_faerie_grove",
		"go_hero_bolverk",
		"go_hero_vampiress",
		"go_enemies_bloodlust"
	},
	ref_h = REF_H,
	ref_w = REF_W,
	ref_res = TEXTURE_SIZE_ALIAS.ipad,
	required_sounds = (KR_GAME == "kr3" and {
		"common",
		"ElvesTowerTaunts",
		"ElvesCommonSounds"
	}) or {
		"common"
	},
	simulation_systems = {
		"level",
		"wave_spawn",
		"mod_lifecycle",
		"main_script",
		"timed",
		"tween",
		"health",
		"count_groups",
		"hero_xp_tracking",
		"pops",
		"goal_line",
		"tower_upgrade",
		"game_upgrades",
		"texts",
		"particle_system",
		"render",
		"sound_events",
		"seen_tracker"
	},
	init = function (self, screen_w, screen_h, done_callback)
		self.screen_w = screen_w
		self.screen_h = screen_h
		self.done_callback = done_callback
		local aspect = screen_w/screen_h

		if aspect < MIN_SCREEN_ASPECT then
			self.game_scale = screen_w/MIN_SCREEN_ASPECT/self.ref_h
		else
			self.game_scale = screen_h/self.ref_h
		end

		self.game_ref_origin = V.v((screen_w - self.ref_w*self.game_scale)/2, (screen_h - self.ref_h*self.game_scale)/2)
		local panext = self.store.level.pan_extension
		local visible_h = REF_H
		local visible_w = math.ceil((self.screen_w*self.ref_h)/self.screen_h)
		visible_w = km.clamp((REF_H*4)/3, (REF_H*16)/9, visible_w)
		local v_left = (self.ref_w - visible_w)/2
		local v_right = self.ref_w + (visible_w - self.ref_w)/2
		local v_top = ((panext and panext.top) or 0) + visible_h
		local v_bottom = (panext and panext.bottom) or 0
		self.store.visible_coords = {
			top = v_top,
			left = v_left,
			bottom = v_bottom,
			right = v_right
		}

		if KR_TARGET == "phone" or KR_TARGET == "tablet" then
			self.camera = {
				x = screen_w/2,
				y = screen_h/2,
				damped_x = nil,
				damped_y = nil,
				ww = visible_w*self.game_scale,
				wh = visible_h*self.game_scale,
				wl = v_left*self.game_scale,
				wr = v_right*self.game_scale,
				wt = (visible_h - v_top)*self.game_scale,
				wb = (visible_h - v_bottom)*self.game_scale,
				zoom = 1,
				min_zoom = (1.7777777777777777 < aspect and math.min(screen_w, MAX_SCREEN_ASPECT*screen_h)/(visible_w*self.game_scale)) or 1,
				max_zoom = (KR_TARGET == "tablet" and 1.5) or 2,
				clamp = function (self)
					self.zoom = km.clamp(self.min_zoom, self.max_zoom, self.zoom)
					self.x = km.clamp(self.wl + (self.ww*self.min_zoom)/(self.zoom*2), self.wr - (self.ww*self.min_zoom)/(self.zoom*2), self.x)
					self.y = km.clamp(self.wt + self.wh/(self.zoom*2), self.wb - self.wh/(self.zoom*2), self.y)

					return 
				end,
				tween = function (this, timer, time, x, y, zoom, ease)
					this.damped_x = nil
					this.damped_y = nil
					zoom = zoom or this.zoom
					x = x or this.x
					y = y or this.y

					this.cancel_tween(this, timer)

					this.tweener = timer.tween(timer, time, this, {
						x = x,
						y = y,
						zoom = zoom
					}, ease, function ()
						this.tweener = nil

						return 
					end)

					return 
				end,
				cancel_tween = function (this, timer)
					if this.tweener then
						timer.cancel(timer, this.tweener)

						this.tweener = nil
					end

					return 
				end
			}
		end

		RU.init()

		self.store.ephemeral = {}

		simulation:init(self.store, self.simulation_systems)

		self.simulation = simulation

		game_gui:init(screen_w, screen_h, self)

		self.game_gui = game_gui

		if not self.store.level.show_comic_idx or self.store.level_mode ~= GAME_MODE_CAMPAIGN then
			S:queue(string.format("MusicBattlePrep_%02d", self.store.level_idx))
		end

		self.init_debug(self)
		signal.emit("game-start", self.store)

		return 
	end
}

if DEBUG then
	game.reload_gui = function (self)
		self.game_gui:destroy()

		local i18n = require("i18n")

		main:set_locale(i18n.current_locale)

		package.loaded.game_gui = nil
		self.game_gui = require("game_gui")

		self.game_gui:init(self.screen_w, self.screen_h, self)

		if self.store.main_hero then
			self.game_gui:add_hero(self.store.main_hero)
		end

		return 
	end
end

game.restart = function (self)
	self.store.restarted = true
	self.store.restart_count = (self.store.restart_count or 0) + 1
	self.store.ephemeral = {}

	self.simulation:init(self.store, self.simulation_systems)
	self.game_gui:init(self.screen_w, self.screen_h, self)
	S:stop_all()
	S:queue(string.format("MusicBattlePrep_%02d", self.store.level_idx))

	if PS then
		PS.paused = true
	end

	self.init_debug(self)
	signal.emit("game-start", self.store)

	return 
end
game.destroy = function (self)
	self.game_gui:destroy()

	self.game_gui = nil

	RU.destroy()

	return 
end
game.update_debug = function (self, dt)
	if self.DBG_AUTO_SEND then
		for k, ts in pairs(self.auto_send_list) do
			if self.auto_send_interval < game.store.tick_ts - ts then
				self.auto_send_list[k] = game.store.tick_ts
				local e = E:create_entity(k)
				e.nav_path.pi = self.dbg_active_pi
				e.nav_path.spi = (self.dbg_use_random_subpath and math.random(1, 3)) or 1
				e.nav_path.ni = P:get_start_node(self.dbg_active_pi)

				self.simulation:queue_insert_entity(e)
			end
		end
	end

	return 
end
game.init_debug = function (self)
	if not DEBUG then
		return 
	end

	DEBUG_KEYS_ON = true
	self.I = I
	self.DBG_DRAW_CLICKABLE = false
	self.DBG_DRAW_PATHS = nil
	self.DBG_DRAW_GRID = false
	self.DBG_DRAW_CENTERS = false
	self.DBG_ENEMY_PAGES = false
	self.DBG_DRAW_RALLY_RANGES = false
	self.DBG_DRAW_UNIT_RANGE = false
	self.DBG_DRAW_BULLET_TRAILS = false
	self.DBG_FPS_COUNTER = false
	self.PERF_TIME_GRAPH = false
	self.DBG_TIME_MULT = 1
	self.DBG_AUTO_SEND = false
	self.auto_send_list = {}
	self.auto_send_interval = 5
	self.dbg_use_random_subpath = true
	package.loaded["data.game_debug_data"] = nil
	local data = require("data.game_debug_data")
	self.current_enemy_page = (data.default_page_for_level and data.default_page_for_level[self.store.level_idx]) or data.default_page_for_terrain[self.store.level_terrain_type] or 1
	self.enemy_pages = data.enemy_pages
	self.enemy_keys = {
		"q",
		"w",
		"e",
		"r",
		"t",
		"y",
		"u",
		"i",
		"o",
		"p"
	}
	self.dbg_active_pi = 1

	if localuser_game_init then
		localuser_game_init()
	end

	if custom_script and custom_script.game_init then
		custom_script:game_init()
	end

	return 
end
game.update = function (self, dt)
	if DEBUG then
		self.update_debug(self, dt)
	end

	if self.DBG_TIME_MULT then
		for i = 1, self.DBG_TIME_MULT, 1 do
			self.simulation:update(dt)
		end
	else
		self.simulation:update(dt)
	end

	self.game_gui:update(dt)

	return 
end
game.keypressed = function (self, key, isrepeat)
	if DEBUG then
		if key == "/" then
			DEBUG_KEYS_ON = not DEBUG_KEYS_ON
		end

		if DEBUG_KEYS_ON and self.debug_keypressed(self, key, isrepeat) then
			return true
		end
	end

	return self.game_gui:keypressed(key, isrepeat)
end
game.keyreleased = function (self, key, isrepeat)
	self.game_gui:keyreleased(key, isrepeat)

	return 
end
game.mousepressed = function (self, x, y, button, istouch)
	self.game_gui:mousepressed(x, y, button, istouch)

	return 
end
game.mousereleased = function (self, x, y, button, istouch)
	self.game_gui:mousereleased(x, y, button, istouch)

	return 
end
game.wheelmoved = function (self, dx, dy)
	if self.game_gui.wheelmoved then
		self.game_gui:wheelmoved(dx, dy)
	end

	return 
end
game.touchpressed = function (self, id, x, y, dx, dy, pressure)
	if game_gui.touchpressed then
		self.game_gui:touchpressed(id, x, y, dx, dy, pressure)
	end

	return 
end
game.touchreleased = function (self, id, x, y, dx, dy, pressure)
	if self.game_gui.touchreleased then
		self.game_gui:touchreleased(id, x, y, dx, dy, pressure)
	end

	return 
end
game.touchmoved = function (self, id, x, y, dx, dy, pressure)
	if self.game_gui.touchmoved then
		self.game_gui:touchmoved(id, x, y, dx, dy, pressure)
	end

	return 
end
game.gamepadaxis = function (self, joystick, axis, value)
	if self.game_gui.gamepadaxis then
		self.game_gui:gamepadaxis(joystick, axis, value)
	end

	return 
end
game.gamepadpressed = function (self, joystick, button)
	if self.game_gui.gamepadpressed then
		self.game_gui:gamepadpressed(joystick, button)
	end

	return 
end
game.gamepadreleased = function (self, joystick, button)
	if self.game_gui.gamepadreleased then
		self.game_gui:gamepadreleased(joystick, button)
	end

	return 
end
game.joystickpressed = function (self, joystick, button)
	if self.game_gui.joystickpressed then
		self.game_gui:joystickpressed(joystick, button)
	end

	return 
end
game.joystickreleased = function (self, joystick, button)
	if self.game_gui.joystickreleased then
		self.game_gui:joystickreleased(joystick, button)
	end

	return 
end
game.joystickadded = function (self, joystick)
	if self.game_gui.joystickadded then
		self.game_gui:joystickadded(joystick)
	end

	return 
end
game.joystickremoved = function (self, joystick)
	if self.game_gui.joystickremoved then
		self.game_gui:joystickremoved(joystick)
	end

	return 
end
game.focus = function (self, focus)
	if self.game_gui.focus then
		self.game_gui:focus(focus)
	end

	return 
end
game.get_ism_state = function (self)
	if self.game_gui and self.game_gui.get_ism_state then
		return self.game_gui:get_ism_state()
	end

	return 
end
game.draw = function (self)
	self.draw_game(self)

	return 
end
game.draw_enemy_pages = function (self)
	local function print_sh(str, x, y, color)
		color = (color and color) or {
			255,
			255,
			255
		}

		G.setColor(0, 0, 0)
		G.print(str, x + 1, y + 1)
		G.setColor(unpack(color))
		G.print(str, x, y)
		G.setColor(255, 255, 255)

		return 
	end

	local sw, sh, scale, origin = SU.clamp_window_aspect(self.screen_w, self.screen_h, self.screen_w, self.screen_h)

	G.setColor(0, 0, 0, 100)
	G.rectangle("fill", origin.x + 5, self.screen_h/2 - 5, 270, self.screen_h/3)

	local names = self.enemy_pages[self.current_enemy_page]
	local x = math.floor(origin.x + 10)
	local y = self.screen_h/2

	G.setFont(F:f("DroidSansMono", 13))

	for i, n in ipairs(names) do
		local key = self.enemy_keys[i]

		print_sh(string.format("%s: %s", key, n), x, y, (self.auto_send_list[n] and {
			255,
			100,
			100
		}) or {
			255,
			255,
			255
		})

		y = y + 12
	end

	G.setColor(255, 255, 255)

	y = y + 12

	print_sh("[: prev page", x, y)

	y = y + 12

	print_sh("]: next page", x, y)

	y = y + 12

	if self.DBG_AUTO_SEND then
		print_sh("=: auto send (ON)", x, y)
	else
		print_sh("=: auto send (OFF)", x, y)
	end

	y = y + 12

	print_sh(string.format(";: use random subpath: %s", self.dbg_use_random_subpath), x, y)

	y = y + 12

	print_sh(string.format(":: remove existing mods: %s", self.DBG_REMOVE_EXISTING_MODS), x, y)

	y = y + 12

	print_sh(string.format("+/-: auto send time (%s sec)", self.auto_send_interval), x, y)

	if self.store.game_outcome then
		y = y + 12

		print_sh("Lives checking OFF (store.game_outcome set)", x, y)
	end

	y = y + 12

	print_sh(string.format("z/Z: time warp (%sx)", self.DBG_TIME_MULT), x, y)

	y = y + 12

	print_sh(string.format("f9/f10: enemy speed factor (%sx)", GS.difficulty_enemy_speed_factor[self.store.level_difficulty]), x, y)

	y = y + 12

	print_sh(string.format("DEBUG KEYS ARE %s", (DEBUG_KEYS_ON and "ON") or "OFF"), x, y)

	y = y + 12

	print_sh(string.format("Frame: %if", self.store.tick_ts*FPS), x, y)

	if self.store._lap_start then
		y = y + 12
		local sta = self.store._lap_start
		local sto = self.store._lap_stop or 0

		print_sh(string.format(",/.: Chrono: %i->%i=%if (%.2fs)", sta*FPS, sto*FPS, (sto - sta)*FPS, sto - sta), x, y)
	end

	return 
end

if DEBUG then
	game.debug_keypressed = function (self, key, isrepeat)
		local shift = love.keyboard.isDown("rshift") or love.keyboard.isDown("lshift")
		local ctrl = love.keyboard.isDown("lctrl") or love.keyboard.isDown("lctrl")

		local function remove_all_modifiers()
			log.error("remove_all_modifiers")

			for _, e in pairs(self.store.entities) do
				if e.modifier then
					self.simulation:queue_remove_entity(e)
				end
			end

			return 
		end

		local function apply_modifier(name, e)
			if e then
				local m = E:create_entity(name)
				m.modifier.target_id = e.id
				m.pos = V.vclone(e.pos)

				self.simulation:queue_insert_entity(m)
			else
				for _, e in pairs(self.store.entities) do
					if e.enemy then
						local m = E:create_entity(name)
						m.modifier.target_id = e.id
						m.pos = V.vclone(e.pos)

						self.simulation:queue_insert_entity(m)
					end
				end
			end

			return 
		end

		if self.DBG_ENEMY_PAGES and table.contains(self.enemy_keys, key) and table.keyforobject(self.enemy_keys, key) <= #self.enemy_pages[self.current_enemy_page] then
			local idx = table.keyforobject(self.enemy_keys, key)
			local template_name = self.enemy_pages[self.current_enemy_page][idx]
			local e = E:create_entity(template_name)

			if e and e.enemy then
				e.enemy.wave_group_idx = km.clamp(1, 99999, game.store.wave_group_number)
				e.nav_path.pi = self.dbg_active_pi
				e.nav_path.spi = (self.dbg_use_random_subpath and math.random(1, 3)) or 1
				e.nav_path.ni = P:get_start_node(self.dbg_active_pi)

				if self.DBG_AUTO_SEND then
					if self.auto_send_list[e.template_name] then
						self.auto_send_list[e.template_name] = nil
					else
						self.auto_send_list[e.template_name] = 0
					end
				end

				if not self.DBG_AUTO_SEND then
					self.simulation:queue_insert_entity(e)
				end
			elseif e and e.modifier and not isrepeat then
				if self.DBG_REMOVE_EXISTING_MODS then
					remove_all_modifiers()
				end

				apply_modifier(self.enemy_pages[self.current_enemy_page][idx], self.game_gui.selected_entity)
			end
		elseif key == "-" then
			self.auto_send_interval = km.clamp(1, 1000, self.auto_send_interval - 1)
		elseif key == "=" then
			if shift then
				self.auto_send_interval = km.clamp(1, 1000, self.auto_send_interval + 1)
			else
				self.DBG_AUTO_SEND = not self.DBG_AUTO_SEND
				self.auto_send_list = {}
			end
		elseif key == "`" then
			self.DBG_ENEMY_PAGES = not self.DBG_ENEMY_PAGES
		elseif key == "[" then
			self.current_enemy_page = km.clamp(1, #self.enemy_pages, self.current_enemy_page - 1)
		elseif key == "]" then
			self.current_enemy_page = km.clamp(1, #self.enemy_pages, self.current_enemy_page + 1)
		elseif key == "a" then
			self.store.paused = not self.store.paused
		elseif key == "s" then
			self.store.step = true
		elseif key == "d" then
			if self.game_gui and self.game_gui.selected_entity then
				local e = self.game_gui.selected_entity

				if ctrl and shift and e.health then
					local damage = E:create_entity("damage")
					damage.value = e.health.hp
					damage.target_id = e.id
					damage.damage_type = bit.bor(DAMAGE_EAT)

					table.insert(self.store.damage_queue, damage)
				elseif shift and e.health then
					local damage = E:create_entity("damage")
					damage.value = math.floor(e.health.hp*0.9 - 1)
					damage.target_id = e.id

					table.insert(self.store.damage_queue, damage)
				elseif ctrl and e.health then
					e.health.hp = e.health.hp_max
				elseif e.health then
					local damage = E:create_entity("damage")
					damage.value = e.health.hp
					damage.target_id = e.id
					damage.damage_type = DAMAGE_TRUE

					table.insert(self.store.damage_queue, damage)
				end
			end
		elseif key ~= "f" or false then
			if key == "g" then
				self.DBG_DRAW_GRID = not self.DBG_DRAW_GRID
				self.grid_canvas = nil
			elseif key == "h" then
				self.path_canvas = nil

				if not self.DBG_DRAW_PATHS then
					self.DBG_DRAW_PATHS = 1
				elseif self.DBG_DRAW_PATHS == 1 then
					self.DBG_DRAW_PATHS = 2
				else
					self.DBG_DRAW_PATHS = nil
				end
			elseif key == "j" then
				self.dbg_active_pi = km.zmod(self.dbg_active_pi + 1, #P.paths)
				self.path_canvas = nil
			elseif key == "l" then
				if ctrl then
					local outcome = {
						lives_left = 10,
						victory = true,
						stars = (game.store.level_mode == 1 and 3) or 1,
						level_idx = game.store.level_idx,
						level_mode = game.store.level_mode,
						level_difficulty = game.store.level_difficulty
					}
					game.store.game_outcome = outcome

					signal.emit("game-victory", game.store)
					signal.emit("game-victory-after", game.store)

					return true
				elseif shift then
					if 1 < self.store.lives then
						self.store.lives = km.clamp(1, 20, self.store.lives - 100)
					else
						self.store.lives = 0
					end
				else
					self.store.lives = self.store.lives + 100
				end

				if 200 < self.store.lives then
					self.store.lives = 1000
					self.store.game_outcome = {}
				elseif self.store.lives <= 20 then
					self.store.game_outcome = nil
				end
			elseif key == ";" then
				if shift then
					self.DBG_REMOVE_EXISTING_MODS = not self.DBG_REMOVE_EXISTING_MODS
				else
					self.dbg_use_random_subpath = not self.dbg_use_random_subpath
				end
			elseif key == "z" then
				if shift then
					self.DBG_TIME_MULT = km.clamp(1, 64, self.DBG_TIME_MULT/2)
				else
					self.DBG_TIME_MULT = km.clamp(1, 64, self.DBG_TIME_MULT*2)
				end
			elseif key == "x" then
				local heroes = table.filter(self.store.entities, function (_, e)
					return e.hero and not e.hero.stage_hero
				end)

				if heroes and 0 < #heroes then
					heroes[1].hero.xp_queued = 500
				end
			elseif key == "c" then
				if shift then
					self.DBG_DRAW_BULLET_TRAILS = not self.DBG_DRAW_BULLET_TRAILS
				else
					self.DBG_DRAW_CENTERS = not self.DBG_DRAW_CENTERS
					self.DBG_DRAW_CLICKABLE = not self.DBG_DRAW_CLICKABLE
				end
			elseif key == "v" then
				if shift then
					local storage = require("storage")
					local slot = storage.load_slot(storage)

					if self.game_gui.window:get_child_by_id("bag_contents_view") then
						for _, v in pairs(self.game_gui.window:get_child_by_id("bag_contents_view").children) do
							v.enable(v)

							v.ci(v, "bag_item_qty").text = 9999
							slot.bag[v.item] = 9999
						end
					end

					storage.save_slot(storage, slot)
				else
					signal.emit("debug-ready-user-powers")
					signal.emit("debug-ready-plants-crystals")
				end
			elseif key == "b" then
				self.DBG_DRAW_TOWER_RANGE = not self.DBG_DRAW_TOWER_RANGE
				self.DBG_DRAW_UNIT_RANGE = not self.DBG_DRAW_UNIT_RANGE
				self.DBG_DRAW_RALLY_RANGES = not self.DBG_DRAW_RALLY_RANGES
				self.DBG_DRAW_SPECIAL_RANGES = not self.DBG_DRAW_SPECIAL_RANGES
			elseif key == "m" then
				if love.keyboard.isDown("rshift") or love.keyboard.isDown("lshift") then
					self.store.player_gold = self.store.player_gold - 1000
				else
					self.store.player_gold = self.store.player_gold + 1000
				end
			elseif key == "n" then
				if love.keyboard.isDown("rshift") or love.keyboard.isDown("lshift") then
					self.DBG_DRAW_NAV_MESH = not self.DBG_DRAW_NAV_MESH
				else
					self.store.force_next_wave = true
				end
			elseif key == "," then
				self.store._lap_start = self.store.tick_ts
				self.store._lap_stop = nil
			elseif key == "." then
				self.store._lap_stop = self.store.tick_ts
			elseif key == "f8" then
				if self.game_gui.manual_gui_hide then
					signal.emit("show-gui")
				else
					signal.emit("hide-gui")
				end
			elseif key == "f9" then
				GS.difficulty_enemy_speed_factor[self.store.level_difficulty] = GS.difficulty_enemy_speed_factor[self.store.level_difficulty] - 0.01

				log.debug(" decrement speed factor")
			elseif key == "f10" then
				GS.difficulty_enemy_speed_factor[self.store.level_difficulty] = GS.difficulty_enemy_speed_factor[self.store.level_difficulty] + 0.01

				log.debug(" increment speed factor")
			else
				return false
			end
		end

		return true
	end
end

game.draw_game = function (self)
	local frame_draw_params = RU.frame_draw_params
	local draw_frames_range = RU.draw_frames_range
	local gs = self.game_scale
	local rox, roy = nil

	if self.camera then
		local c = self.camera

		c.clamp(c)

		local dox = c.x*c.zoom - self.screen_w/2
		local doy = c.y*c.zoom - self.screen_h/2
		roy = -doy
		rox = -dox
		gs = gs*c.zoom
	else
		roy = self.game_ref_origin.y
		rox = self.game_ref_origin.x
	end

	if self.store.world_offset then
		roy = roy + self.store.world_offset.y
		rox = rox + self.store.world_offset.x
	end

	if self.DBG_DRAW_PATHS and not self.path_canvas then
		local node_size = 2
		local point_size = 3

		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		self.path_canvas = G.newCanvas()

		G.setCanvas(self.path_canvas)

		if self.DBG_DRAW_PATHS == 2 then
			for pi, p in ipairs(P.paths) do
				if pi == self.dbg_active_pi then
					local pw = P:path_width(pi)

					for ni, o in pairs(p[1]) do
						if P:is_node_valid(pi, ni) then
							G.setColor(0, 0, 255, 150)
							G.circle("fill", o.x, REF_H - o.y, pw, 16)
						end
					end
				end
			end
		end

		for pi, p in ipairs(P.paths) do
			for _, sp in pairs(p) do
				for ni, o in ipairs(sp) do
					if not P:is_node_valid(pi, ni) then
						G.setColor(255, 255, 0, 255)
						G.rectangle("fill", o.x - node_size, REF_H - o.y - node_size, node_size*2, node_size*2)
					else
						G.setColor(255, 255, 255, 255)
						G.circle("fill", o.x, REF_H - o.y, node_size, 6)
					end
				end
			end
		end

		for pi, p in ipairs(P.paths) do
			if pi == self.dbg_active_pi then
				local start_node = P:get_start_node(pi)
				local end_node = P:get_end_node(pi)
				local v_start_node = P:get_visible_start_node(pi)
				local v_end_node = P:get_visible_end_node(pi)
				local dp_node = P:get_defend_point_node(pi)

				log.debug("-- path color lines ------------------------------------------")

				for sp_i, sp in pairs(p) do
					for ni, o in ipairs(sp) do
						if sp_i == 3 and ni == dp_node then
							local p1 = p[1][ni]

							G.setColor(0, 0, 0, 255)
							G.setLineWidth(5)
							G.circle("fill", p1.x, REF_H - p1.y, 20, 5)
							log.debug("pi:%s ni:%s : %s (black)", pi, ni, "defend point")
						end

						if sp_i == 3 and (ni == start_node or ni == end_node) then
							local p2 = p[2][ni]
							local p3 = p[3][ni]

							G.setColor(255, 255, 255, 255)
							G.setLineWidth(5)
							G.line(p2.x, REF_H - p2.y, p3.x, REF_H - p3.y)
							log.debug("pi:%s ni:%s : %s (white)", pi, ni, (ni == start_node and "start") or "end")
						end

						if sp_i == 3 and (ni == v_start_node + 0 or ni == v_end_node - 0) then
							local p2 = p[2][ni]
							local p3 = p[3][ni]

							G.setColor(255, 0, 0, 255)
							G.setLineWidth(3)
							G.line(p2.x, REF_H - p2.y, p3.x, REF_H - p3.y)
							log.debug("pi:%s ni:%s : %s (red)", pi, ni, (ni == v_start_node and "visible start") or "visible end")
						end

						if sp_i == 3 and (ni == v_start_node + 10 or ni == v_end_node - 10) then
							local p2 = p[2][ni]
							local p3 = p[3][ni]

							G.setColor(0, 0, 255, 255)
							G.setLineWidth(3)
							G.line(p2.x, REF_H - p2.y, p3.x, REF_H - p3.y)
							log.debug("pi:%s ni:%s : vis - 10 (blue)", pi, ni)
						end

						if sp_i == 3 and (ni == v_start_node + 20 or ni == v_end_node - 20) then
							local p2 = p[2][ni]
							local p3 = p[3][ni]

							G.setColor(0, 0, 0)
							G.setColor(0, 255, 0, 255)
							G.setLineWidth(3)
							G.line(p2.x, REF_H - p2.y, p3.x, REF_H - p3.y)
							log.debug("pi:%s ni:%s : vis - 20 (green)", pi, ni)
						end

						G.setLineWidth(1)
						G.setColor(255, 0, 255, 255)
						G.rectangle("line", o.x - point_size, REF_H - o.y - point_size, point_size*2, point_size*2)
					end
				end
			end
		end

		if self.store.level and self.store.level.points_spawner and self.store.level.points_spawner.spawner_points then
			G.setColor(0, 0, 255, 255)
			G.setLineWidth(3)

			for _, p in pairs(self.store.level.points_spawner.spawner_points) do
				G.circle("fill", p.from.x, REF_H - p.from.y, 10, 8)
				G.line(p.from.x, REF_H - p.from.y, p.to.x, REF_H - p.to.y)
			end
		end

		if self.store.level then
			G.setColor(0, 0, 255, 255)

			for _, e in pairs(self.store.entities) do
				if e.graveyard and e.graveyard.spawn_pos then
					for _, p in pairs(e.graveyard.spawn_pos) do
						G.circle("fill", p.x, REF_H - p.y, 5, 4)
					end
				end
			end
		end

		G.setLineWidth(1)
		G.setColor(255, 255, 255, 255)
		G.setCanvas()
		G.pop()
	end

	if self.DBG_DRAW_GRID and not self.grid_canvas then
		G.push()
		G.translate(rox, REF_H*gs + roy)
		G.scale(gs, -gs)
		G.translate(GR.ox, GR.oy)

		self.grid_canvas = G.newCanvas()

		G.setCanvas(self.grid_canvas)

		for i = 1, #GR.grid, 1 do
			for j = 1, #GR.grid[i], 1 do
				local t = GR.grid[i][j]

				G.setColor(GR.grid_colors[t] or {
					100,
					100,
					100
				})
				G.rectangle("fill", (i - 1)*GR.cell_size, (j - 1)*GR.cell_size, GR.cell_size, GR.cell_size)
			end
		end

		if GR.waypoints_cache and GR.waypoints_cache.path_c then
			G.setColor(GR.grid_colors.path)

			for _, n in pairs(GR.waypoints_cache.path_c) do
				G.rectangle("fill", (n.x - 0.5)*GR.cell_size, (n.y - 0.5)*GR.cell_size, GR.cell_size/2, GR.cell_size/2)
			end
		end

		if DEBUG_POINTS then
			G.setColor(GR.grid_colors.path)

			for _, n in pairs(DEBUG_POINTS) do
				G.rectangle("fill", (n.x - 0.5)*GR.cell_size, (n.y - 0.5)*GR.cell_size, GR.cell_size/2, GR.cell_size/2)
			end
		end

		G.setCanvas()
		G.setColor(255, 255, 255, 255)
		G.pop()
	end

	local last_idx = nil

	G.push()
	G.translate(rox, roy)
	G.scale(gs, gs)

	last_idx = draw_frames_range(self.store.render_frames, 1, Z_GUI_DECALS - 1)

	G.pop()

	if self.DBG_DRAW_GRID then
		G.setColor(255, 255, 255, 100)
		G.draw(self.grid_canvas)
		G.setColor(255, 255, 255, 255)
	end

	if self.DBG_DRAW_RALLY_RANGES then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		for _, e in pairs(self.store.entities) do
			if e.barrack then
				local b = e.barrack
				local s = E:get_template(b.soldier_type)

				G.setColor(100, 100, 255, 100)

				if s.melee then
					local range = s.melee.range

					G.ellipse("fill", b.rally_pos.x, REF_H - b.rally_pos.y, range, range*ASPECT)
				end
			end
		end

		G.setColor(255, 255, 255, 255)
		G.pop()
	end

	if self.DBG_DRAW_SPECIAL_RANGES then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		for _, e in pairs(self.store.entities) do
			if e.custom_attack and e.custom_attack.range then
				G.setColor(100, 100, 255, 100)
				G.ellipse("fill", e.pos.x, REF_H - e.pos.y, e.custom_attack.range, e.custom_attack.range*ASPECT)
			end
		end

		for _, e in pairs(self.store.entities) do
			if e.aura and e.aura.damage_radius then
				G.setColor(100, 100, 255, 100)
				G.ellipse("fill", e.pos.x, REF_H - e.pos.y, e.aura.damage_radius, e.aura.damage_radius*ASPECT)
			end
		end

		G.setColor(255, 255, 255, 255)
		G.pop()
	end

	if self.DBG_DRAW_TOWER_RANGE then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		local e = game.game_gui.selected_entity or self.dbg_last_selected_entity

		if e then
			self.dbg_last_selected_entity = e
			local range = e.attacks and e.attacks.range

			if range then
				range = range*(e.attacks.prediction_range_factor or 1)
				local pos = e.pos

				if e.tower and e.tower.range_offset then
					pos = V.v(pos.x + e.tower.range_offset.x, pos.y + e.tower.range_offset.y)
				end

				G.setColor(100, 100, 255, 100)
				G.setLineWidth(3)
				G.ellipse("line", pos.x, REF_H - pos.y, range, range*ASPECT)

				if e.attacks and e.attacks.range_check_factor then
					local f = e.attacks.range_check_factor

					G.setColor(100, 100, 255, 60)
					G.setLineWidth(3)
					G.ellipse("line", pos.x, REF_H - pos.y, f*range, f*range*ASPECT)
				end
			end
		end

		G.setColor(255, 255, 255, 255)
		G.pop()
	end

	if self.DBG_DRAW_UNIT_RANGE then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		local e = game.game_gui.selected_entity or self.dbg_last_selected_entity

		if e then
			self.dbg_last_selected_entity = e
			local range, min_range = nil

			if e.ranged then
				range = e.ranged.attacks[1].max_range
				min_range = e.ranged.attacks[1].min_range
			elseif e.melee and e.melee.range then
				range = e.melee.range
			elseif e.attacks and e.attacks.list[1] and e.attacks.list[1].max_range then
				range = e.attacks.list[1].max_range
				min_range = e.attacks.list[1].min_range
			end

			if range then
				G.setColor(100, 100, 255, 100)
				G.setLineWidth(3)
				G.ellipse("line", e.pos.x, REF_H - e.pos.y, range, range*ASPECT)
			end

			if min_range then
				G.setColor(50, 50, 255, 100)
				G.setLineWidth(2)
				G.ellipse("line", e.pos.x, REF_H - e.pos.y, min_range, min_range*ASPECT)
			end
		end

		G.setColor(255, 255, 255, 255)
		G.pop()
	end

	if self.DBG_DRAW_AURA_RANGE then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		for _, e in pairs(self.store.entities) do
			if e.aura and e.aura.radius then
				G.setColor(100, 100, 255, 100)
				G.setLineWidth(3)
				G.ellipse("line", e.pos.x, REF_H - e.pos.y, e.aura.radius, e.aura.radius*ASPECT)
			end
		end

		G.setColor(255, 255, 255, 255)
		G.pop()
	end

	G.push()
	G.translate(rox, roy)
	G.scale(gs, gs)

	last_idx = draw_frames_range(self.store.render_frames, last_idx + 1, Z_SCREEN_FIXED - 1)

	G.pop()

	if self.DBG_DRAW_PATHS then
		G.setColor(255, 255, 255, 100)
		G.draw(self.path_canvas)
		G.setColor(255, 255, 255, 255)
	end

	G.push()
	G.translate(self.game_ref_origin.x, self.game_ref_origin.y)
	G.scale(self.game_scale, self.game_scale)

	last_idx = draw_frames_range(self.store.render_frames, last_idx + 1, Z_GUI - 1)

	G.pop()
	self.game_gui.window:draw_child(self.game_gui.layer_gui)

	if self.DBG_DRAW_CENTERS then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		for _, e in pairs(self.store.entities) do
			if e.pos and e.bullet then
				G.setLineWidth(1)
				G.setColor(200, 200, 0, 200)
				G.line(e.pos.x - 1, REF_H - e.pos.y - 1, e.pos.x + 1, REF_H - e.pos.y + 1)
				G.line(e.pos.x - 1, REF_H - e.pos.y + 1, e.pos.x + 1, REF_H - e.pos.y - 1)
			elseif e.pos and not e.bullet and not e.decal then
				G.setColor(0, 0, 200, 200)
				G.rectangle("fill", e.pos.x - 1, REF_H - e.pos.y - 4, 2, 8)
				G.rectangle("fill", e.pos.x - 4, REF_H - e.pos.y - 1, 8, 2)
			end
		end

		G.pop()
		G.setColor(255, 255, 255, 255)
	end

	if self.DBG_DRAW_CLICKABLE then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)

		for _, e in pairs(self.store.entities) do
			if e.ui then
				G.setColor(255, 255, 0, 70)

				local rect = e.ui.click_rect

				G.rectangle("fill", e.pos.x + rect.pos.x, REF_H - (e.pos.y + rect.pos.y), rect.size.x, -rect.size.y)
			end
		end

		G.pop()
		G.setColor(255, 255, 255, 255)
	end

	if self.DBG_DRAW_NAV_MESH then
		G.push()
		G.translate(rox, roy)
		G.scale(gs, gs)
		G.setFont(F:f("DroidSansMono", 18))

		local towers = {}

		for _, e in pairs(self.store.entities) do
			if e.ui and e.ui.nav_mesh_id then
				towers[tonumber(e.ui.nav_mesh_id)] = e

				G.setColor(0, 0, 0, 255)
				G.print(e.ui.nav_mesh_id, e.pos.x + 5, REF_H - e.pos.y - 8)
				G.setColor(202, 202, 0, 255)
				G.print(e.ui.nav_mesh_id, (e.pos.x + 5) - 2, REF_H - e.pos.y - 8 - 2)
			end
		end

		G.setColor(0, 100, 255, 255)
		G.setLineWidth(2)
		G.translate(0, -10)

		local ox = 40
		local oy = 15
		local ax = 40
		local ay = 15

		for h_id, row in pairs(self.store.level.nav_mesh) do
			local e = towers[h_id]

			if e or false then
				local oe = towers[row[1]]

				if oe then
					G.line(e.pos.x + ox, REF_H - e.pos.y, oe.pos.x - ax, REF_H - oe.pos.y)
				end

				oe = towers[row[2]]

				if oe then
					G.line(e.pos.x, REF_H - e.pos.y - oy, oe.pos.x, REF_H - oe.pos.y + ay)
				end

				oe = towers[row[3]]

				if oe then
					G.line(e.pos.x - ox, REF_H - e.pos.y, oe.pos.x + ax, REF_H - oe.pos.y)
				end

				oe = towers[row[4]]

				if oe then
					G.line(e.pos.x, REF_H - e.pos.y + oy, oe.pos.x, REF_H - oe.pos.y - ay)
				end
			end
		end

		local s2 = 10
		local s3 = 15

		G.setColor(0, 0, 200, 255)

		for h_id, row in pairs(self.store.level.nav_mesh) do
			local e = towers[h_id]

			if e or false then
				for i = 1, 4, 1 do
					local oe = towers[row[i]]

					if oe then
						local tx, ty, ta, a, r = nil

						if i == 1 then
							ty = REF_H - e.pos.y
							tx = e.pos.x + ox
							a, r = V.toPolar(oe.pos.x - ax - (e.pos.x + ox), REF_H - oe.pos.y - REF_H - e.pos.y)
						elseif i == 2 then
							ty = REF_H - e.pos.y - oy
							tx = e.pos.x
							a, r = V.toPolar(oe.pos.x - e.pos.x, (REF_H - oe.pos.y + ay) - REF_H - e.pos.y - oy)
						elseif i == 3 then
							a, r = V.toPolar((oe.pos.x + ax) - e.pos.x - ox, REF_H - oe.pos.y - REF_H - e.pos.y)
							ty = REF_H - e.pos.y
							tx = e.pos.x - ox
						else
							a, r = V.toPolar(oe.pos.x - e.pos.x, REF_H - oe.pos.y - ay - (REF_H - e.pos.y + oy))
							ty = REF_H - e.pos.y + oy
							tx = e.pos.x
						end

						if a then
							G.push()
							G.translate(tx, ty)
							G.rotate(a)
							G.translate(s3, 0)
							G.polygon("fill", s2, 0, 0, s2, 0, -s2)
							G.pop()
						end
					end
				end
			end
		end

		G.pop()
		G.setColor(255, 255, 255, 255)
	end

	if self.DBG_DRAW_BULLET_TRAILS then
		G.push()
		G.scale(gs, gs)
		G.translate(rox, roy)

		if not self.dbg_bullet_canvas then
			self.dbg_bullet_canvas = G.newCanvas()
		end

		G.setCanvas(self.dbg_bullet_canvas)

		for _, e in pairs(self.store.entities) do
			if e.bullet and e.bullet.from and e.bullet.to and (not self.DBG_DRAW_BULLET_TRAILS_SOURCE or e.bullet.source_id == self.DBG_DRAW_BULLET_TRAILS_SOURCE) then
				G.setColor(0, 0, 255, 255)
				G.circle("fill", e.bullet.from.x, REF_H - e.bullet.from.y, 4, 3)
				G.circle("fill", e.bullet.to.x, REF_H - e.bullet.to.y, 4, 5)
				G.setColor(0, 255, 100, 255)
				G.circle("fill", e.pos.x, REF_H - e.pos.y, 1, 6)
			end
		end

		G.setCanvas()
		G.scale(gs, gs)
		G.pop()
		G.setColor(255, 255, 255, 200)
		G.draw(self.dbg_bullet_canvas)
		G.setColor(255, 255, 255, 255)
	elseif self.dbg_bullet_canvas then
		self.dbg_bullet_canvas = nil
	end

	if self.DBG_ENEMY_PAGES then
		game:draw_enemy_pages()
	end

	return 
end

return game
