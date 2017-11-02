--recipes.lua

--Make two tables with the names of all recipe names
--We have to separate the recipes from fluid.recipe.lua into another table because the structure of the recipes is inconsistant
--Maybe there is a way to iterate on all items directly from data.raw to not recreate tables but i'm not aware of it
local itemName = {
	--ammo.lua
	"piercing-rounds-magazine", "uranium-rounds-magazine", "rocket", "explosive-rocket", "atomic-bomb",
	"shotgun-shell", "piercing-shotgun-shell", "railgun-dart", "cannon-shell", "explosive-cannon-shell",
	"uranium-cannon-shell", "explosive-uranium-cannon-shell", "flamethrower-ammo",
	--capsule.lua
	"poison-capsule", "slowdown-capsule", "grenade", "cluster-grenade", "defender-capsule",
	"distractor-capsule", "destroyer-capsule", "discharge-defense-remote",
	--furnace
	"steel-plate", "iron-plate", "copper-plate", "stone-brick",
	--demo-recipe.lua
	"wood", "wooden-chest", "iron-stick", "iron-axe", "stone-furnace", "boiler",
	"offshore-pump", "copper-cable", "small-electric-pole", "firearm-magazine", "radar",
	"small-lamp", "pistol", "pipe-to-ground", "assembling-machine-1", "repair-pack",
	"pipe", "steam-engine", "iron-gear-wheel", "electronic-circuit", "transport-belt",
	"electric-mining-drill", "burner-mining-drill", "pistol", "submachine-gun", "burner-inserter",
	--turrets
	"gun-turret", "laser-turret", "flamethrower-turret",
	--equipement.lua
	"night-vision-equipment", "energy-shield-equipment", "battery-equipment", "solar-panel-equipment",
	"fusion-reactor-equipment", "personal-laser-defense-equipment",
	"discharge-defense-equipment", "exoskeleton-equipment", "personal-roboport-equipment",
	--fluid-recipe.lua
	--
	--inserter.lua
	"long-handed-inserter", "fast-inserter", "filter-inserter", "stack-inserter", "stack-filter-inserter",
	--module.lua
	"speed-module", "speed-module-2", "speed-module-3", "productivity-module", "productivity-module-2", "productivity-module-3",
	"effectivity-module", "effectivity-module-2", "effectivity-module-3",
	--recipe.lua
	"player-port", "fast-transport-belt", "express-transport-belt", "solar-panel", "assembling-machine-2", "assembling-machine-3",
	"car", "tank", "rail", "locomotive", "cargo-wagon", "fluid-wagon", "train-stop", "rail-signal", "rail-chain-signal",
	"heavy-armor", "modular-armor", "power-armor", "iron-chest", "steel-chest", "stone-wall", "gate", "land-mine", "rocket-launcher",
	"shotgun", "combat-shotgun", "railgun", "science-pack-1", "science-pack-2", "science-pack-3", "military-science-pack",
	"production-science-pack", "high-tech-science-pack", "lab", "red-wire", "green-wire", "underground-belt", "fast-underground-belt",
	"express-underground-belt", "loader", "fast-loader", "express-loader", "splitter", "fast-splitter", "express-splitter",
	"advanced-circuit", "processing-unit", "logistic-robot", "construction-robot", "logistic-chest-passive-provider",
	"logistic-chest-active-provider", "logistic-chest-storage", "logistic-chest-requester", "rocket-silo",
	"roboport", "steel-axe", "big-electric-pole", "substation", "medium-electric-pole", "accumulator",
	"steel-furnace", "electric-furnace", "beacon", "pumpjack", "oil-refinery", "engine-unit", "electric-engine-unit",
	"flying-robot-frame", "explosives", "battery", "storage-tank", "pump", "chemical-plant", "small-plane",
	"arithmetic-combinator", "decider-combinator", "constant-combinator", "power-switch", "programmable-speaker",
	"low-density-structure", "rocket-control-unit", "rocket-part", "satellite", "concrete", "hazard-concrete",
	"landfill", "nuclear-reactor", "centrifuge", "heat-exchanger", "heat-pipe", "steam-turbine"
}
local itemNameFluids = {"basic-oil-processing", "advanced-oil-processing", "coal-liquefaction", "heavy-oil-cracking", "light-oil-cracking", "sulfuric-acid", "plastic-bar", "solid-fuel-from-light-oil", "solid-fuel-from-heavy-oil", "solid-fuel-from-petroleum-gas", "sulfur", "lubricant"}

--Add solid waste to all items except fluids and items dealing with nuclear stuff
--We create a results key because of the inconsistencies of the recipe structure
for i, recipeName in pairs(itemName)
	do
		local recipeData = data.raw.recipe[recipeName]

		if recipeData.result_count == nil then
			recipeData.result_count = 1
		end
		if recipeData.ingredients == nil then
			recipeData.normal.results = {
				{type = "item", name = recipeData.normal.result, amount = recipeData.result_count},
				{type = "item", name = "solid-waste", amount = #recipeData.normal.ingredients}
			}
			recipeData.normal.main_product = recipeName

			recipeData.expensive.results = {
				{type = "item", name = recipeData.expensive.result, amount = recipeData.result_count},
				{type = "item", name = "solid-waste", amount = #recipeData.expensive.ingredients}
			}
			recipeData.expensive.main_product = recipeName
		else
			recipeData.results = {
				{type = "item", name = recipeData.result, amount = recipeData.result_count},
				{type = "item", name = "solid-waste", amount = #recipeData.ingredients}
			}
			recipeData.main_product = recipeName
		end
	end

-- Add solid waste to the existing results keys
for i, recipeName in pairs (itemNameFluids) do
	table.insert(data.raw.recipe[recipeName].results, {type = "item", name = "solid-waste", amount = #data.raw.recipe[recipeName].ingredients})
	if data.raw.recipe[recipeName].subgroup ~= "fluid-recipes" then
			data.raw.recipe[recipeName].main_product = recipeName
	end
end


-- For whatever reason, these two recipes with one fluid as a result don't have icons and we have to add them here
data.raw.recipe["lubricant"].icon = "__BasicWasteManagement__/graphics/icons/lubricant.png"
data.raw.recipe["sulfuric-acid"].icon = "__BasicWasteManagement__/graphics/icons/sulfuric-acid.png"
