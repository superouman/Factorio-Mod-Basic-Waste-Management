--recipes.lua

-- Divide the waste output by 4
local probabilityCount = 0.25

-- Add solid waste to all items except nuclear stuff
-- Iterating directly on data.raw.recipe to add Solid Waste to existing recipes
for i, recipeData in pairs(data.raw.recipe)
		do
				-- Ignore recipes that deal with nuclear processing
				if recipeData.name ~= "uranium-processing" and recipeData.name ~= "kovarex-enrichment-process" and recipeData.name ~= "nuclear-fuel-reprocessing" and recipeData.name ~= "uranium-fuel-cell"
				then
						if recipeData.result_count == nil then
									recipeData.result_count = 1
						end

						-- If the recipes have normal and expensive versions
						if recipeData.ingredients == nil then
									recipeData.normal.results = {
										{type = "item", name = recipeData.normal.result, amount = recipeData.result_count},
										{type = "item", name = "solid-waste", amount = #recipeData.normal.ingredients, probability = probabilityCount}
									}
									recipeData.normal.main_product = recipeData.name

									recipeData.expensive.results = {
										{type = "item", name = recipeData.expensive.result, amount = recipeData.result_count},
										{type = "item", name = "solid-waste", amount = #recipeData.expensive.ingredients, probability = probabilityCount}
									}
									recipeData.expensive.main_product = recipeData.name
						else
									-- If the recipe doesn't have a results key, create one. Otherwise, add to the existing one
									if recipeData.results == nil then
												recipeData.results = {
													{type = "item", name = recipeData.result, amount = recipeData.result_count},
													{type = "item", name = "solid-waste", amount = #recipeData.ingredients, probability = probabilityCount}
												}
												recipeData.main_product = recipeData.name
									else
												table.insert(recipeData.results, {type = "item", name = "solid-waste", amount = #recipeData.ingredients, probability = probabilityCount})
												-- Add the main product to non fluid products
												if recipeData.subgroup ~= "fluid-recipes" then
															recipeData.main_product = recipeData.name
												end
									end
						end
			end
	end

-- Add icons to these two existing recipes
data.raw.recipe["lubricant"].icon = "__base__/graphics/icons/fluid/lubricant.png"
data.raw.recipe["sulfuric-acid"].icon = "__base__/graphics/icons/fluid/sulfuric-acid.png"
