data:extend({
    {
        type = "recipe",
        name = "freezer",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "1",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "iron-plate",
                amount = 20
            },
            {
                type = "item",
                name = "electronic-circuit",
                amount = 5
            },
            {
                type = "item",
                name = "pump",
                amount = 1
            },
            {
                type = "item",
                name = "pipe",
                amount = 4
            }
        },
        results = {
            {
                type = "item",
                name = "freezer",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "freeze-water",
        category = "freezer-cryogenics-category",
        order = "1",
        subgroup = "ice-subgroup",
        enabled = false,
        energy_required = 30,
        ingredients = {
            {
                type = "fluid",
                name = "water",
                amount = 400
            }
        },
        results = {
            {
                type = "item",
                name = "ice",
                amount = 10
            }
        }
    },
    {
        type = "recipe",
        name = "spoilables-freezer",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "2",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "iron-plate",
                amount = 20
            },
            {
                type = "item",
                name = "electronic-circuit",
                amount = 5
            },
            {
                type = "item",
                name = "pump",
                amount = 1
            },
            {
                type = "item",
                name = "pipe",
                amount = 4
            }
        },
        results = {
            {
                type = "item",
                name = "spoilables-freezer",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "spoilables-freezer-active-provider",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "2",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "spoilables-freezer",
                amount = 1
            },
            {
                type = "item",
                name = "active-provider-chest",
                amount = 1
            }
        },
        results = {
            {
                type = "item",
                name = "spoilables-freezer-active-provider",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "spoilables-freezer-provider",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "2",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "spoilables-freezer",
                amount = 1
            },
            {
                type = "item",
                name = "passive-provider-chest",
                amount = 1
            }
        },
        results = {
            {
                type = "item",
                name = "spoilables-freezer-provider",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "spoilables-freezer-storage",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "2",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "spoilables-freezer",
                amount = 1
            },
            {
                type = "item",
                name = "storage-chest",
                amount = 1
            }
        },
        results = {
            {
                type = "item",
                name = "spoilables-freezer-storage",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "spoilables-freezer-buffer",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "2",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "spoilables-freezer",
                amount = 1
            },
            {
                type = "item",
                name = "buffer-chest",
                amount = 1
            }
        },
        results = {
            {
                type = "item",
                name = "spoilables-freezer-buffer",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "spoilables-freezer-requester",
        category = "crafting",
        enabled = false,
        energy_required = 5,
        order = "2",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "item",
                name = "spoilables-freezer",
                amount = 1
            },
            {
                type = "item",
                name = "requester-chest",
                amount = 1
            }
        },
        results = {
            {
                type = "item",
                name = "spoilables-freezer-requester",
                amount = 1
            }
        }
    },
    {
        type = "recipe",
        name = "cargo-wagon-freezer",
        category = "crafting-with-fluid",
        enabled = false,
        energy_required = 5,
        order = "3",
        subgroup = "freezing-machines-subgroup",
        ingredients = {
            {
                type = "fluid",
                name = "fluoroketone-cold",
                amount = 50
            },
            {
                type = "item",
                name = "cargo-wagon",
                amount = 1
            },
            {
                type = "item",
                name = "pump",
                amount = 2
            },
            {
                type = "item",
                name = "iron-plate",
                amount = 20
            }
        },
        results = {
            {
                type = "item",
                name = "cargo-wagon-freezer",
                amount = 1
            }
        }
    },
})