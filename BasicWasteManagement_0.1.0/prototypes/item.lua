local solidWaste = {
    type = "item",
    name = "solid-waste",
    icon = "__BasicWasteManagement__/graphics/icons/solid-waste.png",
    fuel_value = "5kJ",
    fuel_category = "chemical",
    flags = {"goes-to-main-inventory"},
    subgroup = "raw-material",
    order = "a[solid-waste]",
    stack_size = 20
}

data:extend{solidWaste}
