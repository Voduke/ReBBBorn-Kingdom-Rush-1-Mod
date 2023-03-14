local V = require("klua.vector")
local v = V.v
local r = V.r
local deco_fn = require("map_decos_functions")
local i18n = require("i18n")

local function CJK(default, zh, ja, kr)
	return i18n.cjk(i18n, default, zh, ja, kr)
end

local function fc(r, g, b, a)
	return {
		r/255,
		g/255,
		b/255,
		a/255
	}
end

local p11 = 0
local p12 = CJK(0.48, 0.5, 0.5, 0.5)
local p21 = CJK(0.3, 0.35, 0.35, 0.35)
local p22 = CJK(0.5, 0.55, 0.55, 0.55)
local rs = GGLabel.static.ref_h/REF_H

return {
	hero_names_config = {
		default = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 183, 95, 255),
					c3 = fc(255, 98, 0, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(88, 19, 0, 255)
				},
				{
					thickness = rs*1.5,
					glow_color = fc(88, 19, 0, 255)
				},
				{}
			}
		},
		hero_gerald = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(182, 232, 255, 255),
					c3 = fc(65, 178, 229, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(0, 69, 100, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(0, 69, 100, 255)
				},
				{}
			}
		},
		hero_alleria = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(238, 255, 93, 255),
					c3 = fc(145, 215, 0, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(37, 93, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(37, 93, 0, 255)
				},
				{}
			}
		},
		hero_malik = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 246, 126, 255),
					c3 = fc(255, 168, 0, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(135, 74, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(135, 74, 0, 255)
				},
				{}
			}
		},
		hero_bolin = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 194, 79, 255),
					c3 = fc(255, 113, 25, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(98, 37, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(98, 37, 0, 255)
				},
				{}
			}
		},
		hero_magnus = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 222, 254, 255),
					c3 = fc(200, 86, 255, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(69, 0, 112, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(69, 0, 112, 255)
				},
				{}
			}
		},
		hero_ignus = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 242, 63, 255),
					c3 = fc(255, 126, 0, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(105, 40, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(105, 40, 0, 255)
				},
				{}
			}
		},
		hero_denas = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 252, 219, 255),
					c3 = fc(255, 224, 0, 255)
				},
				{
					thickness = rs*2,
					outline_color = fc(107, 65, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(107, 65, 0, 255)
				},
				{}
			}
		},
		hero_elora = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 255, 255, 255),
					c3 = fc(150, 237, 245, 255)
				},
				{
					thickness = rs*1.5,
					outline_color = fc(17, 108, 119, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(17, 108, 119, 255)
				},
				{}
			}
		},
		hero_ingvar = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 211, 159, 255),
					c3 = fc(255, 111, 0, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(102, 33, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(102, 33, 0, 255)
				},
				{}
			}
		},
		hero_hacksaw = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(205, 255, 70, 255),
					c3 = fc(85, 156, 11, 255)
				},
				{
					thickness = rs*1.5,
					outline_color = fc(45, 88, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(45, 88, 0, 255)
				},
				{}
			}
		},
		hero_oni = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 167, 98, 255),
					c3 = fc(224, 44, 0, 255)
				},
				{
					thickness = rs*1.5,
					outline_color = fc(114, 18, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(114, 18, 0, 255)
				},
				{}
			}
		},
		hero_thor = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(222, 248, 255, 255),
					c3 = fc(34, 185, 210, 255)
				},
				{
					thickness = rs*2,
					outline_color = fc(0, 69, 93, 255)
				},
				{
					thickness = rs*1.5,
					glow_color = fc(0, 69, 93, 255)
				},
				{
					shadow_width = rs*0.5,
					shadow_height = rs*2,
					shadow_color = fc(0, 0, 0, 255)
				}
			}
		},
		hero_10yr = {
			shader_args = {
				{
					margin = rs*0,
					p1 = p11,
					p2 = p12,
					c1 = fc(0, 0, 0, 255),
					c2 = fc(255, 242, 63, 255),
					c3 = fc(255, 126, 0, 255)
				},
				{
					thickness = rs*2.5,
					outline_color = fc(105, 40, 0, 255)
				},
				{
					thickness = rs*1,
					glow_color = fc(105, 40, 0, 255)
				},
				{}
			}
		}
	},
	hero_data = {
		{
			portrait = 1,
			thumb = 1,
			name = "hero_gerald",
			available_level = 4,
			starting_level = 1,
			icon = 1,
			stats = {
				8,
				5,
				0,
				4
			}
		},
		{
			portrait = 3,
			thumb = 3,
			name = "hero_alleria",
			available_level = 6,
			starting_level = 1,
			icon = 3,
			stats = {
				4,
				4,
				6,
				7
			}
		},
		{
			portrait = 2,
			thumb = 2,
			name = "hero_malik",
			available_level = 8,
			starting_level = 1,
			icon = 2,
			stats = {
				8,
				6,
				0,
				3
			}
		},
		{
			portrait = 4,
			thumb = 4,
			name = "hero_bolin",
			available_level = 8,
			starting_level = 1,
			icon = 4,
			stats = {
				6,
				3,
				5,
				3
			}
		},
		{
			portrait = 5,
			thumb = 5,
			name = "hero_magnus",
			available_level = 9,
			starting_level = 1,
			icon = 5,
			stats = {
				2,
				2,
				7,
				8
			}
		},
		{
			portrait = 6,
			thumb = 6,
			name = "hero_ignus",
			available_level = 11,
			starting_level = 1,
			icon = 6,
			stats = {
				7,
				7,
				0,
				7
			}
		},
		{
			portrait = 7,
			thumb = 7,
			name = "hero_denas",
			available_level = 12,
			starting_level = 1,
			icon = 7,
			stats = {
				5,
				5,
				8,
				3
			}
		},
		{
			portrait = 8,
			thumb = 11,
			name = "hero_elora",
			available_level = 12,
			starting_level = 1,
			icon = 8,
			stats = {
				4,
				2,
				7,
				7
			}
		},
		{
			portrait = 9,
			thumb = 12,
			name = "hero_ingvar",
			available_level = 12,
			starting_level = 1,
			icon = 9,
			stats = {
				8,
				6,
				0,
				5
			}
		},
		{
			portrait = 11,
			thumb = 13,
			name = "hero_hacksaw",
			available_level = 12,
			starting_level = 1,
			icon = 11,
			stats = {
				8,
				5,
				2,
				2
			}
		},
		{
			portrait = 10,
			thumb = 14,
			name = "hero_oni",
			available_level = 12,
			starting_level = 1,
			icon = 12,
			stats = {
				7,
				8,
				0,
				6
			}
		},
		{
			portrait = 12,
			thumb = 15,
			name = "hero_thor",
			available_level = 12,
			starting_level = 1,
			icon = 13,
			stats = {
				7,
				6,
				3,
				6
			}
		},
		{
			portrait = 14,
			thumb = 16,
			name = "hero_10yr",
			available_level = 12,
			starting_level = 1,
			icon = 14,
			stats = {
				8,
				8,
				5,
				5
			}
		}
	},
	level_data = {
		{
			upgrades = {
				heroe = false,
				level = 1
			},
			iron = {
				"archers",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 2
			},
			iron = {
				"barracks"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 2
			},
			iron = {
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 2
			},
			iron = {
				"mages",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 3
			},
			iron = {
				"barracks"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 3
			},
			iron = {
				"archers",
				"mages",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 3
			},
			iron = {
				"barracks",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 4
			},
			iron = {
				"archers",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = false,
				level = 4
			},
			iron = {
				"archers",
				"barracks",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 4
			},
			iron = {
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"artillery",
				"archers"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"artillery",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"barracks"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"mages",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"barracks",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"barracks",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"barracks"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"artillery"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"artillery",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"artillery",
				"mages"
			}
		},
		{
			upgrades = {
				heroe = true,
				level = 5
			},
			iron = {
				"archers",
				"artillery",
				"mages"
			}
		}
	},
	tower_data = {
		{
			name = "tower_archer_1"
		},
		{
			name = "tower_barrack_1"
		},
		{
			name = "tower_mage_1"
		},
		{
			name = "tower_engineer_1"
		},
		{
			name = "tower_archer_2"
		},
		{
			name = "tower_barrack_2"
		},
		{
			name = "tower_mage_2"
		},
		{
			name = "tower_engineer_2"
		},
		{
			name = "tower_archer_3"
		},
		{
			name = "tower_barrack_3"
		},
		{
			name = "tower_mage_3"
		},
		{
			name = "tower_engineer_3"
		},
		{
			name = "tower_ranger"
		},
		{
			name = "tower_paladin"
		},
		{
			name = "tower_arcane_wizard"
		},
		{
			name = "tower_bfg"
		},
		{
			name = "tower_musketeer"
		},
		{
			name = "tower_barbarian"
		},
		{
			name = "tower_sorcerer"
		},
		{
			name = "tower_tesla"
		}
	},
	map_animations = {
		{
			sail_time = 15,
			id = "ma_big_boat",
			wait_in = 12.5,
			loop = true,
			wait_out = 15,
			layer = 2,
			pos = v(216, 900),
			fns = {
				prepare = deco_fn.ma_big_boat.prepare
			},
			pos_in = v(216, 900),
			pos_out = v(-80, 1000),
			animations = {
				in_sail = {
					to = 301,
					prefix = "bigBoat",
					from = 245
				},
				in_idle = {
					to = 167,
					prefix = "bigBoat",
					from = 85
				},
				out_sail = {
					to = 244,
					prefix = "bigBoat",
					from = 189
				},
				out_idle = {
					to = 84,
					prefix = "bigBoat",
					from = 1
				}
			}
		},
		{
			loop = true,
			id = "ma_boats",
			layer = 2,
			pos = v(423, 955),
			animation = {
				to = 110,
				prefix = "boats",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_fire",
			layer = 3,
			pos = v(1735, 673),
			animation = {
				to = 24,
				prefix = "darkTower_fire",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_glow",
			layer = 3,
			pos = v(1735, 673),
			animation = {
				to = 96,
				prefix = "darkTower_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_fog",
			layer = 3,
			pos = v(1735, 705),
			scale = v(1.8, 1.8),
			animation = {
				to = 118,
				prefix = "darktower_fog",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_left_glow",
			layer = 1,
			pos = v(1625, 794),
			animation = {
				to = 96,
				prefix = "darkTower_river_left_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_left_lava",
			layer = 1,
			pos = v(1627, 794),
			animation = {
				to = 52,
				prefix = "darkTower_river_left_lava",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_right_glow",
			layer = 1,
			pos = v(1818, 794),
			animation = {
				to = 96,
				prefix = "darkTower_river_right_glow",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_darkTower_river_right_lava",
			layer = 1,
			pos = v(1819, 796),
			animation = {
				to = 52,
				prefix = "darkTower_river_right_lava",
				from = 1
			}
		},
		{
			id = "ma_eagle",
			layer = 2,
			pos = v(958, 85),
			wait = {
				2,
				3
			},
			animation = {
				to = 203,
				prefix = "eagle_1",
				from = 1
			}
		},
		{
			id = "ma_fisher man",
			layer = 2,
			pos = v(456, 898),
			wait = {
				1,
				5
			},
			animation = {
				to = 172,
				prefix = "fisherMan",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_flags",
			layer = 2,
			pos = v(771, 558),
			animation = {
				to = 15,
				prefix = "flags",
				from = 1
			}
		},
		{
			id = "ma_ghost",
			layer = 2,
			pos = v(1485, 455),
			wait = {
				3,
				12
			},
			animation = {
				to = 188,
				prefix = "ghost",
				from = 1
			}
		},
		{
			id = "ma_north_lights",
			layer = 2,
			pos = v(1423, 272),
			wait = {
				8,
				15
			},
			scale = v(0.8, 0.8),
			animation = {
				to = 25,
				prefix = "ma_north_lights",
				from = 1
			}
		},
		{
			id = "ma_hacker",
			layer = 2,
			pos = v(378, 431),
			wait = {
				1,
				3
			},
			animation = {
				to = 255,
				prefix = "hacker",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_light tower",
			layer = 2,
			pos = v(655, 948),
			animation = {
				to = 119,
				prefix = "lighTower",
				from = 1
			}
		},
		{
			id = "ma_mobiDick",
			layer = 2,
			pos = v(1099, 55),
			wait = {
				2,
				10
			},
			animation = {
				to = 224,
				prefix = "mobiDick",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_molinos1",
			layer = 2,
			pos = v(111, 781),
			animation = {
				to = 24,
				prefix = "molino",
				from = 1
			}
		},
		{
			id = "ma_molinos2",
			template = "ma_molinos1",
			pos = v(145, 765)
		},
		{
			id = "ma_molinos3",
			template = "ma_molinos1",
			pos = v(694, 805)
		},
		{
			id = "ma_molinos4",
			template = "ma_molinos1",
			pos = v(721, 834)
		},
		{
			id = "ma_molinos5",
			template = "ma_molinos1",
			pos = v(747, 799)
		},
		{
			id = "ma_rottenBubbles1",
			layer = 2,
			pos = v(1757, 309),
			wait = {
				3,
				12
			},
			animation = {
				to = 47,
				prefix = "rottenBubble",
				from = 1
			}
		},
		{
			id = "ma_rottenBubbles2",
			template = "ma_rottenBubbles1",
			pos = v(1780, 313)
		},
		{
			id = "ma_rottenBubbles3",
			template = "ma_rottenBubbles1",
			pos = v(1796, 283)
		},
		{
			id = "ma_rottenBubbles4",
			template = "ma_rottenBubbles1",
			pos = v(1798, 300)
		},
		{
			id = "ma_rottenBubbles5",
			template = "ma_rottenBubbles1",
			pos = v(1821, 304)
		},
		{
			loop = true,
			id = "ma_rottenFog01",
			layer = 2,
			pos = v(1828, 208),
			animation = {
				to = 110,
				prefix = "rottenFogClip",
				from = 1
			}
		},
		{
			id = "ma_rottenFog02",
			template = "ma_rottenFog01",
			pos = v(1880, 173)
		},
		{
			id = "ma_rottenFog03",
			template = "ma_rottenFog01",
			pos = v(1807, 212),
			scale = v(1.5, 1.5)
		},
		{
			id = "ma_rottenFog04",
			template = "ma_rottenFog01",
			pos = v(1695, 212),
			scale = v(1.7, 1.7)
		},
		{
			id = "ma_rottenFog05",
			template = "ma_rottenFog01",
			pos = v(1743, 158),
			scale = v(1.5, 1.5)
		},
		{
			id = "ma_rottenFog06",
			template = "ma_rottenFog01",
			pos = v(1699, 248),
			scale = v(1, 1)
		},
		{
			id = "ma_rottenFog07",
			template = "ma_rottenFog01",
			pos = v(1637, 189),
			scale = v(1.3, 1.3)
		},
		{
			id = "ma_rottenFog08",
			template = "ma_rottenFog01",
			pos = v(1581, 260),
			scale = v(1.5, 1.5)
		},
		{
			id = "ma_rottenFog09",
			template = "ma_rottenFog01",
			pos = v(1600, 332),
			scale = v(1.1, 1.1)
		},
		{
			id = "ma_rottenFog10",
			template = "ma_rottenFog01",
			pos = v(1642, 288),
			scale = v(1.3, 1.3)
		},
		{
			id = "ma_rottenFog11",
			template = "ma_rottenFog01",
			pos = v(1700, 331),
			scale = v(1.4, 1.4)
		},
		{
			id = "ma_rottenFog12",
			template = "ma_rottenFog01",
			pos = v(1794, 384),
			scale = v(1.6, 1.6)
		},
		{
			id = "ma_rottenFog13",
			template = "ma_rottenFog01",
			pos = v(1862, 333),
			scale = v(1.7, 1.7)
		},
		{
			id = "ma_sheep1",
			layer = 2,
			pos = v(240, 758),
			wait = {
				1,
				8
			},
			animation = {
				to = 18,
				prefix = "sheep",
				from = 1
			}
		},
		{
			id = "ma_sheep2",
			template = "ma_sheep1",
			pos = v(250, 775),
			scale = v(-1, 1)
		},
		{
			id = "ma_sheep3",
			template = "ma_sheep1",
			pos = v(362, 807)
		},
		{
			id = "ma_sheep4",
			template = "ma_sheep1",
			pos = v(664, 797),
			scale = v(-1, 1)
		},
		{
			id = "ma_sheep5",
			template = "ma_sheep1",
			pos = v(757, 835)
		},
		{
			id = "ma_sheepSmall1",
			layer = 2,
			pos = v(380, 817),
			wait = {
				1,
				8
			},
			animation = {
				to = 18,
				prefix = "sheepSmall",
				from = 1
			}
		},
		{
			id = "ma_sheepSmall2",
			template = "ma_sheepSmall1",
			pos = v(776, 845)
		},
		{
			id = "ma_sheepSmall3",
			template = "ma_sheepSmall1",
			pos = v(227, 774),
			scale = v(-1, 1)
		},
		{
			loop = true,
			id = "ma_smoke1",
			layer = 2,
			pos = v(436, 742),
			animation = {
				to = 30,
				prefix = "smoke",
				from = 1
			}
		},
		{
			id = "ma_smoke2",
			template = "ma_smoke1",
			pos = v(534, 183)
		},
		{
			loop = true,
			id = "ma_snow01",
			layer = 2,
			pos = v(1098, 136),
			animation = {
				to = 35,
				prefix = "snowClip",
				from = 1
			}
		},
		{
			id = "ma_snow02",
			template = "ma_snow01",
			pos = v(1216, 155)
		},
		{
			id = "ma_snow03",
			template = "ma_snow01",
			pos = v(1190, 281)
		},
		{
			id = "ma_snow04",
			template = "ma_snow01",
			pos = v(1221, 362)
		},
		{
			id = "ma_snow05",
			template = "ma_snow01",
			pos = v(1295, 226)
		},
		{
			id = "ma_spider1",
			layer = 2,
			pos = v(431, 123),
			wait = {
				3,
				6
			},
			animation = {
				to = 87,
				prefix = "spider_1",
				from = 1
			}
		},
		{
			id = "ma_spider2",
			layer = 2,
			pos = v(431, 123),
			wait = {
				3,
				6
			},
			animation = {
				to = 79,
				prefix = "spider_2",
				from = 1
			}
		},
		{
			id = "ma_spider3",
			layer = 2,
			pos = v(431, 123),
			wait = {
				3,
				6
			},
			animation = {
				to = 85,
				prefix = "spider_3",
				from = 1
			}
		},
		{
			id = "ma_treant",
			layer = 2,
			pos = v(1869, 255),
			anchor = v(60, 40),
			fns = {
				prepare = deco_fn.ani_seq.prepare
			},
			animations = {
				default = {
					to = 1,
					prefix = "treant",
					from = 1
				},
				left = {
					to = 123,
					prefix = "treant",
					from = 1
				},
				right = {
					to = 246,
					prefix = "treant",
					from = 124
				}
			},
			sequence = {
				{
					"default",
					3,
					6
				},
				{
					"left",
					3,
					6
				},
				{
					"right",
					3,
					6
				}
			}
		},
		{
			id = "ma_twister",
			layer = 2,
			pos = v(1409, 914),
			wait = {
				5,
				15
			},
			animation = {
				to = 119,
				prefix = "twister",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_volcanoSmokes",
			layer = 2,
			pos = v(1448, 601),
			animation = {
				to = 52,
				prefix = "volcanoSmokes",
				from = 1
			}
		},
		{
			id = "ma_volcanoes1",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_1",
				from = 1
			}
		},
		{
			id = "ma_volcanoes2",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_2",
				from = 1
			}
		},
		{
			id = "ma_volcanoes3",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_3",
				from = 1
			}
		},
		{
			id = "ma_volcanoes4",
			layer = 2,
			pos = v(1448, 604),
			wait = {
				3,
				12
			},
			animation = {
				to = 62,
				prefix = "volcanos_4",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterFall_1",
			layer = 2,
			pos = v(454, 290),
			animation = {
				to = 18,
				prefix = "waterFall_1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterFall_2",
			layer = 2,
			pos = v(58, 304),
			animation = {
				to = 32,
				prefix = "waterFall_2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterFall_3",
			layer = 2,
			pos = v(1040, 835),
			animation = {
				to = 27,
				prefix = "waterFall_3",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waterWheel",
			layer = 2,
			pos = v(734, 891),
			animation = {
				to = 64,
				prefix = "waterWheel",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves1",
			layer = 1,
			pos = v(216, 930),
			animation = {
				to = 116,
				prefix = "waves1",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves2",
			layer = 1,
			pos = v(563, 929),
			animation = {
				to = 116,
				prefix = "waves2",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves3",
			layer = 1,
			pos = v(897, 1047),
			animation = {
				to = 116,
				prefix = "waves3",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves4",
			layer = 1,
			pos = v(713, 60),
			animation = {
				to = 116,
				prefix = "waves4",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_waves5",
			layer = 1,
			pos = v(1183, 70),
			animation = {
				to = 116,
				prefix = "waves5",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_wavesBeach",
			layer = 1,
			pos = v(822, 967),
			animation = {
				to = 126,
				prefix = "wavesBeach",
				from = 1
			}
		},
		{
			loop = true,
			id = "ma_spark_01",
			layer = 1,
			pos = v(169, 938),
			animation = {
				to = 33,
				prefix = "waterSparks",
				from = 1
			}
		},
		{
			id = "ma_spark_02",
			template = "ma_spark_01",
			pos = v(77, 972)
		},
		{
			id = "ma_spark_03",
			template = "ma_spark_01",
			pos = v(239, 1019)
		},
		{
			id = "ma_spark_04",
			template = "ma_spark_01",
			pos = v(368, 1015)
		},
		{
			id = "ma_spark_05",
			template = "ma_spark_01",
			pos = v(345, 1074)
		},
		{
			id = "ma_spark_06",
			template = "ma_spark_01",
			pos = v(515, 906)
		},
		{
			id = "ma_spark_07",
			template = "ma_spark_01",
			pos = v(594, 932)
		},
		{
			id = "ma_spark_08",
			template = "ma_spark_01",
			pos = v(536, 954)
		},
		{
			id = "ma_spark_09",
			template = "ma_spark_01",
			pos = v(475, 994)
		},
		{
			id = "ma_spark_10",
			template = "ma_spark_01",
			pos = v(431, 1049)
		},
		{
			id = "ma_spark_11",
			template = "ma_spark_01",
			pos = v(579, 994)
		},
		{
			id = "ma_spark_12",
			template = "ma_spark_01",
			pos = v(536, 1033)
		},
		{
			id = "ma_spark_13",
			template = "ma_spark_01",
			pos = v(644, 1040)
		},
		{
			id = "ma_spark_14",
			template = "ma_spark_01",
			pos = v(734, 1033)
		},
		{
			id = "ma_spark_15",
			template = "ma_spark_01",
			pos = v(786, 1071)
		},
		{
			id = "ma_spark_16",
			template = "ma_spark_01",
			pos = v(766, 1116)
		},
		{
			id = "ma_spark_17",
			template = "ma_spark_01",
			pos = v(857, 762)
		},
		{
			id = "ma_spark_18",
			template = "ma_spark_01",
			pos = v(489, 1082)
		},
		{
			id = "ma_spark_19",
			template = "ma_spark_01",
			pos = v(594, 1076)
		},
		{
			id = "ma_spark_20",
			template = "ma_spark_01",
			pos = v(697, 1085)
		},
		{
			id = "ma_spark_21",
			template = "ma_spark_01",
			pos = v(631, 1119)
		},
		{
			id = "ma_spark_22",
			template = "ma_spark_01",
			pos = v(550, 1116)
		},
		{
			id = "ma_spark_23",
			template = "ma_spark_01",
			pos = v(421, 1108)
		},
		{
			id = "ma_spark_24",
			template = "ma_spark_01",
			pos = v(271, 1119)
		},
		{
			id = "ma_spark_25",
			template = "ma_spark_01",
			pos = v(197, 1074)
		},
		{
			id = "ma_spark_26",
			template = "ma_spark_01",
			pos = v(156, 1116)
		},
		{
			id = "ma_spark_27",
			template = "ma_spark_01",
			pos = v(41, 1100)
		},
		{
			id = "ma_spark_28",
			template = "ma_spark_01",
			pos = v(731, -35)
		},
		{
			id = "ma_spark_29",
			template = "ma_spark_01",
			pos = v(825, -18)
		},
		{
			id = "ma_spark_30",
			template = "ma_spark_01",
			pos = v(788, 35)
		},
		{
			id = "ma_spark_31",
			template = "ma_spark_01",
			pos = v(1042, -35)
		},
		{
			id = "ma_spark_32",
			template = "ma_spark_01",
			pos = v(1078, 31)
		},
		{
			id = "ma_spark_33",
			template = "ma_spark_01",
			pos = v(1155, 25)
		},
		{
			id = "ma_spark_34",
			template = "ma_spark_01",
			pos = v(1221, -39)
		},
		{
			id = "ma_spark_35",
			template = "ma_spark_01",
			pos = v(1130, -28)
		},
		{
			random_start = true,
			alpha = 0.9,
			loop = true,
			id = "ma_cloud_1",
			layer = 3,
			scale = v(0.8, 0.8),
			move = {
				time = 60,
				from = v(-250, 1000),
				to = v(2250, 1020)
			},
			wait = {
				1,
				60
			},
			animation = {
				to = 1,
				prefix = "ma_cloud",
				from = 1
			}
		},
		{
			id = "ma_cloud_2",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, 1040),
				to = v(2100, 1040)
			}
		},
		{
			id = "ma_cloud_3",
			template = "ma_cloud_1",
			alpha = 0.4,
			scale = v(0.7, 0.7),
			move = {
				time = 80,
				from = v(-200, 1090),
				to = v(2100, 1090)
			}
		},
		{
			id = "ma_cloud_4",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(-0.4, 0.4),
			move = {
				time = 83,
				from = v(-200, 1050),
				to = v(2100, 1050)
			}
		},
		{
			id = "ma_cloud_5",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.4, 0.4),
			move = {
				time = 90,
				from = v(-200, 1070),
				to = v(2100, 1070)
			}
		},
		{
			id = "ma_cloud_6",
			template = "ma_cloud_1",
			alpha = 0.7,
			scale = v(-0.5, 0.5),
			move = {
				time = 60,
				from = v(-200, 990),
				to = v(2100, 1020)
			}
		},
		{
			id = "ma_cloud_7",
			template = "ma_cloud_1",
			alpha = 0.5,
			scale = v(-0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, 1030),
				to = v(2100, 1030)
			}
		},
		{
			id = "ma_cloud_8",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.7, 0.7),
			move = {
				time = 65,
				from = v(-200, 1040),
				to = v(2100, 1040)
			}
		},
		{
			id = "ma_cloud_t1",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.7, 0.7),
			move = {
				time = 60,
				from = v(-200, 0),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t2",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.6, 0.6),
			move = {
				time = 70,
				from = v(-200, -20),
				to = v(2100, -20)
			}
		},
		{
			id = "ma_cloud_t3",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.8, 0.8),
			move = {
				time = 80,
				from = v(-200, 10),
				to = v(2100, 10)
			}
		},
		{
			id = "ma_cloud_t4",
			template = "ma_cloud_1",
			alpha = 0.6,
			scale = v(0.9, 0.9),
			move = {
				time = 90,
				from = v(-200, -5),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t5",
			template = "ma_cloud_1",
			alpha = 0.5,
			scale = v(0.7, 0.7),
			move = {
				time = 70,
				from = v(-200, 0),
				to = v(2100, 0)
			}
		},
		{
			id = "ma_cloud_t6",
			template = "ma_cloud_1",
			alpha = 0.9,
			scale = v(0.8, 0.8),
			move = {
				time = 80,
				from = v(-200, 10),
				to = v(2100, 10)
			}
		}
	},
	map_decos = {
		{
			id = "md_muelle",
			image = "muelle",
			layer = 2,
			pos = v(297, 965)
		},
		{
			id = "md_compass",
			image = "compass",
			layer = 1,
			pos = v(75, 1000)
		},
		{
			id = "md_darkTower",
			image = "darkTower",
			layer = 2,
			pos = v(1735, 673)
		},
		{
			id = "md_cover_swamp",
			image = "map_overFlags_0001",
			layer = 3,
			pos = v(1803, 305)
		},
		{
			id = "md_cover_woods",
			image = "map_overFlags_0002",
			layer = 3,
			pos = v(647, 365)
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_01",
			image = "map_path_1_0010",
			trigger_level = 2,
			pos = v(322, 821),
			animations = {
				to = 10,
				prefix = "map_path_1",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_02",
			image = "map_path_2_0010",
			trigger_level = 3,
			pos = v(415, 783),
			animations = {
				to = 10,
				prefix = "map_path_2",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_03",
			image = "map_path_3_0025",
			trigger_level = 4,
			pos = v(559, 772),
			animations = {
				to = 25,
				prefix = "map_path_3",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_04",
			image = "map_path_4_0030",
			trigger_level = 5,
			pos = v(488, 650),
			animations = {
				to = 30,
				prefix = "map_path_4",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_05",
			image = "map_path_5_0059",
			trigger_level = 6,
			pos = v(426, 394),
			animations = {
				to = 59,
				prefix = "map_path_5",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_06",
			image = "map_path_6_0050",
			trigger_level = 7,
			pos = v(568, 209),
			animations = {
				to = 50,
				prefix = "map_path_6",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_07",
			image = "map_path_7_0034",
			trigger_level = 8,
			pos = v(815, 194),
			animations = {
				to = 34,
				prefix = "map_path_7",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_08",
			image = "map_path_8_0116",
			trigger_level = 9,
			pos = v(953, 185),
			animations = {
				to = 116,
				prefix = "map_path_8",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_09",
			image = "map_path_9_0090",
			trigger_level = 10,
			pos = v(1289, 357),
			animations = {
				to = 90,
				prefix = "map_path_9",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_10",
			image = "map_path_10_0025",
			trigger_level = 11,
			pos = v(1612, 528),
			animations = {
				to = 25,
				prefix = "map_path_10",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_11",
			image = "map_path_11_0071",
			trigger_level = 12,
			pos = v(1747, 668),
			animations = {
				to = 71,
				prefix = "map_path_11",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_23",
			image = "map_path_23_0026",
			trigger_level = 24,
			pos = v(1378, 238),
			animations = {
				to = 26,
				prefix = "map_path_23",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_24",
			image = "map_path_24_0021",
			trigger_level = 25,
			pos = v(1380, 164),
			animations = {
				to = 21,
				prefix = "map_path_24",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		},
		{
			layer = 1,
			hidden = true,
			id = "md_path_25",
			image = "map_path_25_0016",
			trigger_level = 26,
			pos = v(1448, 138),
			animations = {
				to = 16,
				prefix = "map_path_25",
				from = 1
			},
			fns = {
				unlock = deco_fn.path_open.unlock
			}
		}
	}
}
