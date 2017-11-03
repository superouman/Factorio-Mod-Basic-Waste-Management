--recycling-recipe.lua

data:extend{
	{
		type = "recipe",
    name = "waste-recycling",
    category = "crafting",
    enabled = true,
    energy_required = 10,
    ingredients =
    {
      {type = "item", name = "solid-waste", amount = 10}
    },
    results =
    {
      {type = "item", name = "iron-ore", amount = 1},
      {type = "item", name = "copper-ore", amount = 1},
    },
    icon = "__BasicWasteManagement__/graphics/icons/solid-waste.png",
    subgroup = "intermediate-product",
    order = "a[waste-recycling]"
	}
}
