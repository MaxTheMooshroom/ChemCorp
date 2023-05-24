
---@class VanillaReworksModule : module
local M = {}

--#region Global data
--local players_data
--#endregion

--#region Constants
--local ABS = math.abs
--#endregion

--#region Functions of events
-- Add your event functions here
--#endregion

--#region Pre-game stage

local function link_data()
	--players_data = global.players
end

local function update_global_data()
	--global.players = global.players or {}
	--

	link_data()

	--for player_index, player in pairs(game.players) do
	--	-- delete UIs
	--end
end

--#endregion

--#region Resource Generation

local function modify_resource_generation()
	-- Change the name of the default "stone" resource to "Carbonate Rock"
	if data.raw.resource["stone"] then
		data.raw.resource["stone"].name = "carbonate-rock"
		data.raw.resource["stone"].minable.result = "carbonate-rock"
	end

	-- Add a new resource generation identical to the base "stone" called "Silicate Rock"
	data:extend(
		{
			{
				type = "resource",
				name = "silicate-rock",
				icon = "__your-mod-name__/graphics/icons/silicate-rock.png",
				icon_size = 32,
				flags = {"placeable-neutral"},
				category = "basic-solid",
				order = "a-b",
				tree_removal_probability = 0.7,
				tree_removal_max_distance = 32 * 32,
				minable =
				{
					hardness = 0.9,
					mining_particle = "stone-particle",
					mining_time = 2,
					result = "silicate-rock"
				},
				collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
				selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
				walking_sound =
				{
					{
						filename = "__base__/sound/walking/stone-01.ogg",
						volume = 0.8
					},
					{
						filename = "__base__/sound/walking/stone-02.ogg",
						volume = 0.8
					},
					{
						filename = "__base__/sound/walking/stone-03.ogg",
						volume = 0.8
					},
					{
						filename = "__base__/sound/walking/stone-04.ogg",
						volume = 0.8
					}
				},
				vehicle_impact_sound =  { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
				map_color = {r=0.65, g=0.55, b=0.45},
				autoplace =
				{
					control = "stone",
					sharpness = 1,
					richness_multiplier = 1500,
					richness_base = 500,
					size_control_multiplier = 0.03,
					peaks =
					{
						{
							influence = 0.2,
							starting_area_weight_optimal = 0,
							starting_area_weight_range = 0,
							starting_area_weight_max_range = 2,
						},
						{
							influence = 0.65,
							starting_area_weight_optimal = 1,
							starting_area_weight_range = 0,
							starting_area_weight_max_range = 2,
						},
						{
							influence = -0.1,
							max_influence = 0,
							starting_area_weight_optimal = 0,
							starting_area_weight_range = 0,
							starting_area_weight_max_range = 2,
						},
						{
							influence = -0.2,
							max_influence = 0,
							starting_area_weight_optimal = 0,
							starting_area_weight_range = 0,
							starting_area_weight_max_range = 2,
						}
					},
				},
				stage_counts = {15000, 8000, 4000, 2000, 1000, 500, 200, 100},
				stages =
				{
					sheet =
					{
						filename = "__base__/graphics/entity/stone/stone.png",
						priority = "extra-high",
						width = 38,
						height = 36,
						frame_count = 8,
						variation_count = 8
					}
				},
				stages_effect =
				{
					sheet =
					{
						filename = "__base__/graphics/entity/stone/stone.png",
						priority = "extra-high",
						width = 38,
						height = 36,
						frame_count = 8,
						variation_count = 8
					}
				},
				effect_animation_period = 5,
				effect_animation_period_deviation = 1,
				effect_darkness_multiplier = 3.6,
				min_effect_alpha = 0.2,
				max_effect_alpha = 0.6,
				map_grid = false
			}
		}
	)
end

--#endregion

M.on_init = function()
	modify_resource_generation()
	update_global_data()
end

M.on_configuration_changed = function()
	modify_resource_generation()
	update_global_data()
end

M.on_load = link_data
M.update_global_data_on_disabling = update_global_data

M.events = {
	--[defines.events.on_game_created_from_scenario] = on_game_created_from_scenario,
	--[defines.events.on_gui_click] = on_gui_click,
	--[defines.events.on_player_created] = on_player_created,
	--[defines.events.on_player_joined_game] = on_player_joined_game,
	--[defines.events.on_player_left_game] = on_player_left_game,
	--[defines.events.on_player_removed] = delete_player_data,
	--[defines.events.on_player_changed_surface] = clear_player_data,
	--[defines.events.on_player_respawned] = clear_player_data,
}

M.commands = {}

return M
