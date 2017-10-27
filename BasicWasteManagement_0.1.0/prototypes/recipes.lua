--recipes.lua

local itemName = {"iron-plate", "iron-stick", "iron-axe", "stone-furnace", "boiler",
		"offshore-pump", "copper-cable", "small-electric-pole", "firearm-magazine", "radar",
		"small-lamp", "pistol", "pipe-to-ground", "assembling-machine-1", "repair-pack",
		"wood", "transport-belt"}
local recipeList = {}

for i, recipeName in pairs(itemName)
	do
		local recipeData = data.raw.recipe[recipeName]
		local resultAmount = recipeData.result_count
		local difficulty_ingredients = recipeData.normal

		if resultAmount == nil then
			resultAmount = 1
		end

		table.insert(recipeList, {
			type = "recipe",
			name = recipeName,
			ingredients = recipeData.ingredients,
			results = {
				{type = "item", name = recipeData.result, amount = resultAmount},
				{type = "item", name = "solid-waste", amount = #recipeData.ingredients},
			},
			main_product = recipeName
			}
		)
	end

data:extend(
	recipeList
)


		-- if difficulty_ingredients == nil then
		-- 	difficulty_ingredients = recipeData.ingredients
		-- else
		-- 	difficulty_ingredients = recipeData.normal.ingredients
		-- end

--data.raw.recipe["iron-plate"].products[#data.raw.recipe["iron-plate"].products + 1] = {"solid-waste", 1}


-- {type = "recipe",
-- name = "wood",
-- ingredients = data.raw.recipe["wood"].ingredients,
-- results = {
-- 		{type = "item", name = data.raw.recipe["wood"].result, amount = data.raw.recipe["wood"].result_count},
-- 		-- {type="item", name="wood", amount=2},
-- 		{type = "item", name = "solid-waste", amount = 1},
-- },
-- main_product= "wood"
-- },
-- {type = "recipe",
-- name = "iron-stick",
-- ingredients = data.raw.recipe["iron-stick"].ingredients,
-- results = {
-- 		{type = "item", name = data.raw.recipe["iron-stick"].result, amount = data.raw.recipe["iron-stick"].result_count},
-- 		-- {type="item", name="wood", amount=2},
-- 		{type = "item", name = "solid-waste", amount = 1},
-- },
-- main_product= "iron-stick"
-- }
