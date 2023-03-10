local log = require("klua.log"):new("upgrades")
local km = require("klua.macros")
local E = require("entity_db")
local bit = require("bit")

require("constants")

local function T(name)
	return E:get_template(name)
end

local function DP(desktop, phone)
	return ((KR_TARGET == "phone" or KR_TARGET == "tablet") and phone) or desktop
end

local epsilon = 1e-09
local upgrades = {
	max_level = nil,
	levels = {}
}
upgrades.levels.archers = 0
upgrades.levels.barracks = 0
upgrades.levels.mages = 0
upgrades.levels.engineers = 0
upgrades.levels.rain = 0
upgrades.levels.reinforcements = 0
upgrades.display_order = {
	"archers",
	"barracks",
	"mages",
	"engineers",
	"rain",
	"reinforcements"
}
upgrades.list = {
	archer_salvage = {
		refund_factor = 0.9,
		class = "archers",
		price = 1,
		level = 1,
		icon = DP(13, 6)
	},
	archer_eagle_eye = {
		range_factor = 1.1,
		class = "archers",
		price = 1,
		level = 2,
		icon = DP(14, 7)
	},
	archer_piercing = {
		class = "archers",
		reduce_armor_factor = 0.1,
		price = 2,
		level = 3,
		icon = DP(15, 8)
	},
	archer_far_shots = {
		range_factor = 1.1,
		class = "archers",
		price = 2,
		level = 4,
		icon = DP(16, 9)
	},
	archer_precision = {
		damage_factor = 2,
		class = "archers",
		chance = 0.1,
		price = 3,
		level = 5,
		icon = DP(17, 10)
	},
	barrack_survival = {
		health_factor = 1.1,
		class = "barracks",
		price = 1,
		level = 1,
		icon = DP(8, 1)
	},
	barrack_better_armor = {
		class = "barracks",
		armor_increase = 0.1,
		price = 1,
		level = 2,
		icon = DP(9, 2)
	},
	barrack_improved_deployment = {
		cooldown_factor = 0.8,
		rally_range_factor = 1.2,
		class = "barracks",
		price = 2,
		level = 3,
		icon = DP(10, 3)
	},
	barrack_survival_2 = {
		health_factor = 1.0909,
		class = "barracks",
		price = 2,
		level = 4,
		icon = DP(11, 4)
	},
	barrack_barbed_armor = {
		spiked_armor_factor = 0.1,
		class = "barracks",
		price = 3,
		level = 5,
		icon = DP(12, 5)
	},
	mage_spell_reach = {
		range_factor = 1.1,
		class = "mages",
		price = 1,
		level = 1,
		icon = DP(18, 11)
	},
	mage_arcane_shatter = {
		mod = "mod_arcane_shatter",
		class = "mages",
		price = 1,
		level = 2,
		icon = DP(19, 12)
	},
	mage_hermetic_study = {
		class = "mages",
		cost_factor = 0.9,
		price = 2,
		level = 3,
		icon = DP(20, 13)
	},
	mage_empowered_magic = {
		damage_factor = 1.15,
		class = "mages",
		price = 2,
		level = 4,
		icon = DP(21, 14)
	},
	mage_slow_curse = {
		mod = "mod_slow_curse",
		class = "mages",
		price = 3,
		level = 5,
		icon = DP(22, 15)
	},
	engineer_concentrated_fire = {
		damage_factor = 1.1,
		range_factor = 1.1,
		class = "engineers",
		price = 1,
		level = 1,
		icon = DP(23, 16)
	},
	engineer_range_finder = {
		range_factor = 1.1,
		class = "engineers",
		price = 1,
		level = 2,
		chance = 0.1,
		icon = DP(24, 17)
	},
	engineer_field_logistics = {
		class = "engineers",
		cost_factor = 0.9,
		price = 2,
		level = 3,
		icon = DP(25, 18),
		damage_factor = 1.1
	},
	engineer_industrialization = {
		class = "engineers",
		cost_factor = 0.75,
		price = 3,
		level = 4,
		icon = DP(26, 19),
		cooldown_factor = 0.9,
		chance = 0.2
	},
	engineer_efficiency = {
		price = 3,
		class = "engineers",
		level = 5,
		icon = DP(27, 20)
	},
	rain_blazing_skies = {
		fireball_count_increase = 2,
		class = "rain",
		damage_increase = 20,
		price = 2,
		level = 1,
		icon = DP(3, 26)
	},
	rain_scorched_earth = {
		price = 2,
		class = "rain",
		level = 2,
		icon = DP(4, 27)
	},
	rain_bigger_and_meaner = {
		range_factor = 1.25,
		cooldown_reduction = 10,
		class = "rain",
		damage_increase = 40,
		price = 3,
		level = 3,
		icon = DP(5, 28)
	},
	rain_blazing_earth = {
		cooldown_reduction = 10,
		class = "rain",
		price = 3,
		level = 4,
		icon = DP(6, 29)
	},
	rain_cataclysm = {
		class = "rain",
		damage_increase = 60,
		price = 3,
		level = 5,
		icon = DP(7, 30)
	},
	reinforcement_level_1 = {
		class = "reinforcements",
		template_name = "re_farmer_well_fed",
		price = 2,
		level = 1,
		icon = DP(28, 21)
	},
	reinforcement_level_2 = {
		class = "reinforcements",
		template_name = "re_conscript",
		price = 3,
		level = 2,
		icon = DP(29, 22)
	},
	reinforcement_level_3 = {
		class = "reinforcements",
		template_name = "re_warrior",
		price = 3,
		level = 3,
		icon = DP(30, 23)
	},
	reinforcement_level_4 = {
		class = "reinforcements",
		template_name = "re_legionnaire",
		price = 3,
		level = 4,
		icon = DP(1, 24)
	},
	reinforcement_level_5 = {
		class = "reinforcements",
		template_name = "re_legionnaire_ranged",
		price = 4,
		level = 5,
		icon = DP(2, 25)
	},
	archer_improved_aim = {
		range_factor = 1.1,
		refund_factor = 0.9,
		class = "archers",
		icon = 1,
		price = 1,
		level = 1
	},
	archer_lumbermill = {
		cost_reduction = 10,
		range_factor = 1.1,
		class = "archers",
		icon = 2,
		price = 1,
		level = 2
	},
	archer_focused_aim = {
		damage_factor = 1.05,
		reduce_armor_factor = 0.1,
		class = "archers",
		icon = 3,
		price = 1,
		level = 3
	},
	archer_master_marksmanship = {
		range_factor = 1.1,
		damage_factor = 1.1,
		class = "archers",
		icon = 4,
		price = 1,
		level = 4
	},
	archer_twin_shot = {
		class = "archers",
		damage_factor = 2,
		chance = 0.1,
		icon = 5,
		price = 1,
		level = 5
	},
	barrack_defensive_techniques = {
		class = "barracks",
		armor_increase = 0.1,
		icon = 6,
		price = 1,
		level = 1
	},
	barrack_boot_camp = {
		class = "barracks",
		icon = 7,
		price = 1,
		level = 2,
		health_factor = 1.1 - epsilon
	},
	barrack_esprit_des_corps = {
		rally_range_factor = 1.2,
		regen_factor = 1.2,
		class = "barracks",
		icon = 8,
		price = 1,
		level = 3
	},
	barrack_veteran_squad = {
		respawn_reduction = 2,
		class = "barracks",
		armor_increase = 0.1,
		icon = 9,
		price = 1,
		level = 4
	},
	barrack_courage = {
		regen_cooldown = 1,
		regen_factor = 0.01,
		class = "barracks",
		icon = 10,
		price = 1,
		level = 5
	},
	mage_rune_of_power = {
		range_factor = 1.1,
		class = "mages",
		icon = 11,
		price = 1,
		level = 1
	},
	mage_spell_of_penetration = {
		class = "mages",
		chance = 0.1,
		icon = 12,
		price = 1,
		level = 2
	},
	mage_eldrich_power = {
		damage_factor = 1.1,
		class = "mages",
		icon = 13,
		price = 1,
		level = 3
	},
	mage_wizard_academy = {
		class = "mages",
		cost_factor = 0.9,
		icon = 14,
		damage_factor = 1.15,
		price = 1,
		level = 4
	},
	mage_brilliance = {
		class = "mages",
		icon = 15,
		price = 1,
		level = 5,
		damage_factors = {
			1,
			1.05,
			1.1,
			1.14,
			1.18,
			1.21,
			1.24,
			1.27,
			1.3
		}
	},
	engineer_smoothbore = {
		range_factor = 1.1,
		damage_factor = 1.1,
		class = "engineers",
		icon = 16,
		price = 1,
		level = 1
	},
	engineer_alchemical_powder = {
		class = "engineers",
		range_factor = 1.1,
		chance = 0.1,
		icon = 17,
		price = 1,
		level = 2
	},
	engineer_improved_ordnance = {
		damage_factor = 1.1,
		class = "engineers",
		cost_factor = 0.9,
		icon = 18,
		price = 1,
		level = 3
	},
	engineer_gnomish_tinkering = {
		cooldown_factor = 0.9,
		class = "engineers",
		cost_factor = 0.75,
		icon = 19,
		price = 1,
		level = 4
	},
	engineer_shock_and_awe = {
		class = "engineers",
		chance = 0.2,
		icon = 20,
		price = 1,
		level = 5
	},
	archer_el_master_shooter = {
		damage_factor = 1.05,
		class = "archers",
		icon = 20,
		price = 1,
		level = 1
	},
		archer_el_treesinged_bow = {
		range_factor = 1.1,
		class = "archers",
		icon = 2,
		price = 1,
		level = 2
	},
	archer_el_obsidian_heads = {
		price = 1,
		icon = 3,
		class = "archers",
		level = 3
	},
	archer_el_elven_training = {
		burst_damage_factor = 1.1,
		sentence_chance_factor = 1.1,
		class = "archers",
		mark_damage_factor = 1.1,
		slumber_duration_factor = 1.1,
		icon = 4,
		price = 1,
		level = 4
	},
	archer_el_bloodletting_shoot = {
		price = 1,
		icon = 5,
		class = "archers",
		level = 5
	}
}
upgrades.set_levels = function (self, levels)
	for k, v in pairs(levels) do
		self.levels[k] = v
	end

	return 
end
upgrades.has_upgrade = function (self, name)
	local u = self.list[name]

	return u and u.level <= self.levels[u.class] and (not self.max_level or u.level <= self.max_level)
end
upgrades.get_upgrade = function (self, name)
	local u = self.list[name]

	if not u or self.levels[u.class] < u.level or not self.max_level or self.max_level < u.level then
		return nil
	else
		return u
	end

	return 
end
upgrades.get_total_stars = function (self)
	local total = 0

	for k, v in pairs(self.list) do
		total = total + v.price
	end

	return total
end
upgrades.patch_templates = function (self, max_level)
	if max_level then
		self.max_level = max_level
	end

	u = self:get_upgrade("barrack_defensive_techniques")

	if u then
		for _, n in pairs({
			"soldier_templar",
			"soldier_assassin"
		}) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
		end
	end

	u = self:get_upgrade("barrack_boot_camp")

	if u then
		for _, n in pairs({
			"soldier_templar",
			"soldier_assassin"
		}) do
			T(n).health.hp_max = math.ceil(T(n).health.hp_max * u.health_factor)
		end
	end

	u = self:get_upgrade("barrack_esprit_des_corps")

	if u then
		for _, n in pairs({
			"soldier_templar",
			"soldier_assassin"
		}) do
			T(n).regen.health = math.ceil(T(n).regen.health * u.regen_factor)
		end

		for _, n in pairs({
			"tower_templar",
			"tower_assassin"
		}) do
			T(n).barrack.rally_range = math.ceil(T(n).barrack.rally_range * u.rally_range_factor)
		end
	end

	u = self:get_upgrade("barrack_veteran_squad")

	if u then
		for _, n in pairs({
			"soldier_templar",
			"soldier_assassin"
		}) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
			T(n).health.dead_lifetime = T(n).health.dead_lifetime - u.respawn_reduction
		end
	end

	u = self:get_upgrade("mage_rune_of_power")

	if u then
		for _, n in pairs({
			"tower_archmage",
			"tower_necromancer"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("mage_eldrich_power")

	if u then
		for _, n in pairs({
			"bolt_archmage",
			"bolt_necromancer"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end

	u = self:get_upgrade("mage_wizard_academy")

	if u then
		for _, p in pairs({
			T("tower_archmage").powers.twister,
			T("tower_archmage").powers.blast,
			T("tower_necromancer").powers.pestilence,
			T("tower_necromancer").powers.rider
		}) do
			p.price_base = math.floor(p.price_base * u.cost_factor)
			p.price_inc = math.floor(p.price_inc * u.cost_factor)
		end
	end

	u = self:get_upgrade("engineer_smoothbore")

	if u then
		for _, n in pairs({
			"tower_dwaarp"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end

		T("soldier_mecha").attacks.list[1].max_range = T("soldier_mecha").attacks.list[1].max_range * u.range_factor
		T("soldier_mecha").attacks.list[2].max_range = T("soldier_mecha").attacks.list[2].max_range * u.range_factor
	end

	u = self:get_upgrade("engineer_alchemical_powder")

	if u then
		for _, n in pairs({
			"bomb_mecha"
		}) do
			T(n).up_alchemical_powder_chance = u.chance
		end
	end

	u = self:get_upgrade("engineer_improved_ordnance")

	if u then
		for _, n in pairs({
			"bomb_mecha"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end

		T("tower_dwaarp").attacks.list[1].damage_min = T("tower_dwaarp").attacks.list[1].damage_min * u.damage_factor
		T("tower_dwaarp").attacks.list[1].damage_max = T("tower_dwaarp").attacks.list[1].damage_max * u.damage_factor
	end

	u = self:get_upgrade("engineer_gnomish_tinkering")

	if u then
		for _, a in pairs({
			T("tower_dwaarp").attacks.list[2],
			T("tower_dwaarp").attacks.list[3],
			T("soldier_mecha").attacks.list[2],
			T("soldier_mecha").attacks.list[3]
		}) do
			a.cooldown = a.cooldown * u.cooldown_factor
		end
	end

	u = self:get_upgrade("engineer_shock_and_awe")

	if u then
		for _, n in pairs({
			"bomb_mecha",
			"pirate_watchtower_bomb"
		}) do
			T(n).up_shock_and_awe_chance = u.chance
		end
	end

	local u = nil
	u = self.get_upgrade(self, "archer_salvage")

	if u then
		for _, n in pairs({
		"tower_archer_1",
		"tower_archer_2",
		"tower_archer_3",
		"tower_ranger",
		"tower_musketeer"
		}) do
			T(n).tower.refund_factor = u.refund_factor
		end
	end

	u = self.get_upgrade(self, "archer_eagle_eye")

	if u then
		for _, n in pairs({
		"tower_archer_1",
		"tower_archer_2",
		"tower_archer_3",
		"tower_ranger",
		"tower_musketeer"
		}) do
			T(n).attacks.range = T(n).attacks.range*u.range_factor
		end

		T("aura_ranger_thorn").aura.radius = T("aura_ranger_thorn").aura.radius*u.range_factor
		T("tower_musketeer").attacks.list[2].range = T("tower_musketeer").attacks.list[2].range*u.range_factor
		T("tower_musketeer").attacks.list[3].range = T("tower_musketeer").attacks.list[3].range*u.range_factor
		T("tower_musketeer").attacks.list[4].range = T("tower_musketeer").attacks.list[4].range*u.range_factor
		
	end

	u = self.get_upgrade(self, "archer_piercing")

	if u then
		for _, n in pairs({
			"arrow_1",
			"arrow_2",
			"arrow_3",
			"arrow_ranger",
			"shotgun_musketeer",
			"shotgun_musketeer_sniper",
		}) do
			T(n).bullet.reduce_armor = u.reduce_armor_factor
		end
	end

	u = self.get_upgrade(self, "archer_far_shots")

	if u then
		for _, n in pairs({
		"tower_archer_1",
		"tower_archer_2",
		"tower_archer_3",
		"tower_ranger",
		"tower_musketeer"
		}) do
			T(n).attacks.range = T(n).attacks.range*u.range_factor
		end

		T("aura_ranger_thorn").aura.radius = T("aura_ranger_thorn").aura.radius*u.range_factor
		T("tower_musketeer").attacks.list[2].range = T("tower_musketeer").attacks.list[2].range*u.range_factor
		T("tower_musketeer").attacks.list[3].range = T("tower_musketeer").attacks.list[3].range*u.range_factor
		T("tower_musketeer").attacks.list[4].range = T("tower_musketeer").attacks.list[4].range*u.range_factor
	end

	u = self:get_upgrade("archer_improved_aim")

	if u then
		for _, n in pairs({
			"tower_totem",
			"tower_crossbow"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("archer_lumbermill")

	if u then
		for _, n in pairs({
		}) do
			T(n).tower.price = T(n).tower.price - u.cost_reduction
		end
	end

	u = self:get_upgrade("archer_focused_aim")

	if u then
		for _, n in pairs({
			"arrow_crossbow",
			"axe_totem"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end

	u = self:get_upgrade("archer_master_marksmanship")

	if u then
		for _, n in pairs({
			"tower_totem",
			"tower_crossbow"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end

		for _, n in pairs({
			"arrow_crossbow",
			"axe_totem"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min * u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max * u.damage_factor)
		end
	end
	
	u = self:get_upgrade("archer_el_master_shooter")

	if u then
		for _, n in pairs({
			"tower_arcane",
			"tower_silver"
		}) do
			T(n).tower.damage_factor = T(n).tower.damage_factor * u.damage_factor
		end
	end
	
		u = self:get_upgrade("archer_el_treesinged_bow")

	if u then
		for _, n in pairs({
			"tower_arcane",
			"tower_silver"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range * u.range_factor)
		end
	end

	u = self:get_upgrade("archer_el_elven_training")

	if u then
		T("aura_arcane_burst").aura.damage_inc = T("aura_arcane_burst").aura.damage_inc * u.burst_damage_factor
		T("mod_arrow_arcane_slumber").modifier.duration = T("mod_arrow_arcane_slumber").modifier.duration * u.slumber_duration_factor

		for _, chance_group in pairs(T("tower_silver").powers.sentence.chances) do
			for _, chance in pairs(chance_group) do
				chance = chance * u.sentence_chance_factor
			end
		end

		T("mod_arrow_silver_mark").received_damage_factor = T("mod_arrow_silver_mark").received_damage_factor * u.mark_damage_factor
	end

	u = self:get_upgrade("archer_el_bloodletting_shoot")

	if u then
		for _, n in pairs({
			"arrow_arcane",
			"arrow_arcane_burst",
			"arrow_arcane_slumber",
			"arrow_silver",
			"arrow_silver_long",
			"arrow_silver_mark",
			"arrow_silver_mark_long"
		}) do
			local b = T(n).bullet

			if type(b.mod) == "table" then
				table.insert(b.mod, "mod_blood_elves")
			elseif b.mod ~= nil then
				b.mod = {
					b.mod,
					"mod_blood_elves"
				}
			else
				b.mod = "mod_blood_elves"
			end
		end
	end

	u = self.get_upgrade(self, "barrack_survival")
	
	if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_barrack_1",
			"soldier_barrack_2",
			"soldier_barrack_3",
			"soldier_barbarian",
			"soldier_elf_kr1",
			"soldier_paladin"
		}) do
			T(n).health.hp_max = km.round(T(n).health.hp_max*u.health_factor)
		end
	end

	u = self.get_upgrade(self, "barrack_better_armor")
	
		if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_barrack_1",
			"soldier_barrack_2",
			"soldier_barrack_3",
			"soldier_barbarian",
			"soldier_elf_kr1",
			"soldier_paladin"
		}) do
			T(n).health.armor = T(n).health.armor + u.armor_increase
		end
	end

	u = self.get_upgrade(self, "barrack_improved_deployment")
	
	if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_barrack_1",
			"soldier_barrack_2",
			"soldier_barrack_3",
			"soldier_barbarian",
			"soldier_elf_kr1",
			"soldier_paladin"
		}) do
			T(n).health.dead_lifetime = math.floor(T(n).health.dead_lifetime*u.cooldown_factor)
		end

		for _, n in pairs({
			"tower_barrack_1",
			"tower_barrack_2",
			"tower_barrack_3",
			"tower_elven_barrack_1",
			"tower_elven_barrack_2",
			"tower_elven_barrack_3",
			"tower_elf_kr1",
			"tower_barbarian",
			"tower_paladin"
		}) do
			T(n).barrack.rally_range = T(n).barrack.rally_range*u.rally_range_factor
		end
	end
	
	u = self.get_upgrade(self, "barrack_survival_2")

	if u then
		for _, n in pairs({
			"soldier_militia",
			"soldier_footmen",
			"soldier_knight",
			"soldier_barrack_1",
			"soldier_barrack_2",
			"soldier_barrack_3",
			"soldier_barbarian",
			"soldier_elf_kr1",
			"soldier_paladin"
		}) do
			T(n).health.hp_max = km.round(T(n).health.hp_max*u.health_factor)
		end
	end

	u = self.get_upgrade(self, "barrack_barbed_armor")

		if u then
		for _, n in pairs({
			"soldier_elemental",
			"soldier_elf",
			"soldier_sasquash",
			"soldier_s6_imperial_guard",
			"soldier_magnus_illusion",
			"soldier_ingvar_ancestor",
			"soldier_alleria_wildcat",
			"hero_alleria",
			"hero_gerald",
			"hero_bolin",
			"hero_magnus",
			"hero_ignus",
			"hero_malik",
			"hero_denas",
			"hero_ingvar",
			"hero_elora",
			"hero_oni",
			"hero_hacksaw",
			"hero_thor",
			"soldier_ingvar_ancestor2",
			"soldier_ingvar_ancestor3",
			"soldier_elf_kr1"
		}) do
			T(n).health.spiked_armor = u.spiked_armor_factor
		end
		
		for _, n in pairs({
			"re_farmer",
			"re_farmer_well_fed",
			"re_conscript",
			"re_warrior",
			"re_legionnaire",
			"re_legionnaire_ranged"
		}) do
			for i = 1, 3, 1 do
				T(n .. "_" .. i).health.spiked_armor = u.spiked_armor_factor
			end
		end
	end

	u = self.get_upgrade(self, "mage_spell_reach")

	if u then
		for _, n in pairs({
			"tower_mage_1",
			"tower_mage_2",
			"tower_mage_3",
			"tower_sorcerer",
			"tower_arcane_wizard"
		}) do
			T(n).attacks.range = T(n).attacks.range*u.range_factor
		end
	end

	u = self.get_upgrade(self, "mage_arcane_shatter")

	if u then
		for _, n in pairs({
			"bolt_1",
			"bolt_2",
			"bolt_3",
			"bolt_sorcerer",
			"ray_arcane",
			"bolt_elora_freeze",
			"bolt_elora_slow",
			"bolt_magnus",
			"bolt_magnus_illusion"
		}) do
			local mods = {
				u.mod
			}
			local b = T(n).bullet

			if b.mod then
				table.insert(mods, b.mod)
			end

			if b.mods then
				table.append(mods, b.mods)
			end

			b.mod = nil
			b.mods = mods
		end
	end

	u = self.get_upgrade(self, "mage_hermetic_study")
	
	if u then
		for _, n in pairs({
			"tower_mage_1",
			"tower_mage_2",
			"tower_mage_3",
			"tower_sorcerer",
			"tower_arcane_wizard"
		}) do
			T(n).tower.price = math.ceil(T(n).tower.price*u.cost_factor)
		end
	end

	u = self.get_upgrade(self, "mage_empowered_magic")

	if u then
		for _, n in pairs({
			"bolt_1",
			"bolt_2",
			"bolt_3",
			"bolt_sorcerer"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min*u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max*u.damage_factor)
		end

		T("mod_ray_arcane").dps.damage_min = math.ceil(T("mod_ray_arcane").dps.damage_min*u.damage_factor)
		T("mod_ray_arcane").dps.damage_max = math.ceil(T("mod_ray_arcane").dps.damage_max*u.damage_factor)
	end

	u = self.get_upgrade(self, "mage_slow_curse")

	if u then
		for _, n in pairs({
			"bolt_1",
			"bolt_2",
			"bolt_3",
			"bolt_sorcerer",
			"ray_arcane",
			"bolt_magnus",
			"bolt_elora_freeze",
			"bolt_elora_slow",
			"bolt_magnus_illusion"
		}) do
			local mods = {
				u.mod
			}
			local b = T(n).bullet

			if b.mod then
				table.insert(mods, b.mod)
			end

			if b.mods then
				table.append(mods, b.mods)
			end

			b.mod = nil
			b.mods = mods
		end
	end

	u = self.get_upgrade(self, "engineer_concentrated_fire")

	if u then
		for _, n in pairs({
			"bomb",
			"bomb_dynamite",
			"bomb_black"
		}) do
			T(n).bullet.damage_min = math.ceil(T(n).bullet.damage_min*u.damage_factor)
			T(n).bullet.damage_max = math.ceil(T(n).bullet.damage_max*u.damage_factor)
		end

		T("bomb_bfg").bullet.damage_min = math.floor(T("bomb_bfg").bullet.damage_min*u.damage_factor)
		T("bomb_bfg").bullet.damage_max = math.floor(T("bomb_bfg").bullet.damage_max*u.damage_factor)
		T("ray_tesla").bounce_damage_min = math.floor(T("ray_tesla").bounce_damage_min*u.damage_factor)
		T("ray_tesla").bounce_damage_max = math.floor(T("ray_tesla").bounce_damage_max*u.damage_factor)
end

	u = self.get_upgrade(self, "engineer_range_finder")

	if u then
		for _, n in pairs({
			"tower_engineer_1",
		    "tower_engineer_2",
		    "tower_engineer_3",
		    "tower_bfg",
		    "tower_tesla"
		}) do
			T(n).attacks.range = math.ceil(T(n).attacks.range*u.range_factor)
		end

		T("tower_bfg").attacks.list[1].range = math.ceil(T("tower_bfg").attacks.list[1].range*u.range_factor)
		T("tower_bfg").attacks.list[2].range_base = math.ceil(T("tower_bfg").attacks.list[2].range_base*u.range_factor)
		T("tower_tesla").attacks.list[1].range = math.ceil(T("tower_tesla").attacks.list[1].range*u.range_factor)
	end
	

	u = self.get_upgrade(self, "engineer_field_logistics")

	if u then
		for _, n in pairs({
			"tower_engineer_1",
		    "tower_engineer_2",
		    "tower_engineer_3",
		    "tower_bfg",
		    "tower_tesla"
		}) do
			T(n).tower.price = math.floor(T(n).tower.price*u.cost_factor)
		end
	end

	u = self.get_upgrade(self, "engineer_industrialization")

	if u then
		for _, n in pairs({
			"tower_bfg",
			"tower_tesla",
		}) do
			for pk, pv in pairs(T(n).powers) do
				pv.price_base = math.floor(pv.price_base*u.cost_factor)
				pv.price_inc = math.floor(pv.price_inc*u.cost_factor)
			end
		end
	end
	if u then
		for _, a in pairs({
		}) do
			a.cooldown = a.cooldown*u.cooldown_factor
		end
	end

	T("power_fireball_control").user_power.level = self.levels.rain
	u = self.get_upgrade(self, "rain_blazing_skies")

	if u then
		T("power_fireball_control").fireball_count = T("power_fireball_control").fireball_count + u.fireball_count_increase
		T("power_fireball").bullet.damage_min = T("power_fireball").bullet.damage_min + u.damage_increase
		T("power_fireball").bullet.damage_max = T("power_fireball").bullet.damage_max + u.damage_increase
	end

	u = self.get_upgrade(self, "rain_scorched_earth")

	if u then
		T("power_fireball").scorch_earth = true
	end

	u = self.get_upgrade(self, "rain_bigger_and_meaner")

	if u then
		T("power_fireball_control").cooldown = T("power_fireball_control").cooldown - u.cooldown_reduction
		T("power_fireball").bullet.damage_radius = T("power_fireball").bullet.damage_radius*u.range_factor
		T("power_fireball").bullet.damage_min = T("power_fireball").bullet.damage_min + u.damage_increase
		T("power_fireball").bullet.damage_max = T("power_fireball").bullet.damage_max + u.damage_increase
	end

	u = self.get_upgrade(self, "rain_blazing_earth")

	if u then
		T("power_fireball_control").cooldown = T("power_fireball_control").cooldown - u.cooldown_reduction
		T("power_scorched_earth").aura.damage_min = 20
		T("power_scorched_earth").aura.damage_max = 30
		T("power_scorched_earth").aura.duration = 10
		T("power_scorched_water").aura.damage_min = 20
		T("power_scorched_water").aura.damage_max = 30
		T("power_scorched_water").aura.duration = 10
	end

	u = self.get_upgrade(self, "rain_cataclysm")

	if u then
		T("power_fireball_control").cataclysm_count = 5
		T("power_fireball").bullet.damage_min = T("power_fireball").bullet.damage_min + u.damage_increase
		T("power_fireball").bullet.damage_max = T("power_fireball").bullet.damage_max + u.damage_increase
	end

	if 0 < self.levels.reinforcements then
		local rl = math.min(self.levels.reinforcements, self.max_level)
		u = self.get_upgrade(self, "reinforcement_level_" .. rl)

		if u then
			for i = 1, 3, 1 do
				E:set_template("re_current_" .. i, T(u.template_name .. "_" .. i))
			end
		end
	end

	return 
end

return upgrades
