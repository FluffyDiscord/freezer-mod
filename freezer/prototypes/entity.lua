
-- Remnants
data:extend({
  {
    type = "assembling-machine",
    name = "freezer",
    icon = "__freezer__/graphics/icons/freezer.png",
    icon_size = 256,
    source_inventory_size = 1,
    result_inventory_size = 1,
    minable = {mining_time = 0.5, result = "freezer"},
    flags = {"placeable-player", "player-creation"},
    max_health = 200,
    dying_explosion = "medium-explosion",
    corpse = "medium-remnants",
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    graphics_set = {
      animation = {
          filename = "__freezer__/graphics/entity/freezer/freezer.png",
          width = 256,
          height = 256,
          scale = 0.42, --0.375
      },
    },
    module_slots = 4,
    allowed_effects = {"consumption", "speed", "pollution", "quality"},
    --fixed_recipe = "freeze-water",
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
    close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
    crafting_categories = {"freezer-category", "freezer-cryogenics-category"},
    crafting_speed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      drain = "50kW",
      emissions_per_minute = {pollution=1},
    },
    energy_usage = "0.45MW",
    fluid_boxes = {
      {
          production_type = "input",
          pipe_picture = assembler2pipepictures(),
          pipe_covers = pipecoverspictures(),
          base_area = 10,
          base_level = -1,
          pipe_connections = {{ flow_direction="input", position = {0, -1}, direction = 0 }},
          secondary_draw_orders = { north = -1 },
          volume = 100
      }
    },
    working_sound = {
      audible_distance_modifier = 0.6,
      fade_in_ticks = 4,
      fade_out_ticks = 20,
      sound = { filename = "__base__/sound/electric-furnace.ogg", volume = 0.3 },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
    }
  },
  {
    type = "electric-energy-interface",
    name = "spoilables-freezer-interface",
    icon = "__freezer__/graphics/icons/spoilables-freezer.png",
    icon_size = 256,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        buffer_capacity = "10MJ",
        input_flow_limit = "3MW",
        output_flow_limit = "0W",
        emissions_per_minute = {pollution=2},
    },
    create_ghost_on_death = false,
    hidden = true,
    energy_usage = "1MW",
    collision_mask = {
        layers = {},
    },
    quality_indicator_scale = 0.0,
  },
})

local all_freezers = {
    "spoilables-freezer",
    "spoilables-freezer-active-provider",
    "spoilables-freezer-provider",
    "spoilables-freezer-storage",
    "spoilables-freezer-buffer",
    "spoilables-freezer-requester",
}

local container = util.table.deepcopy(data.raw["container"]["steel-chest"])
container.name = "spoilables-freezer"
container.icon = "__freezer__/graphics/icons/spoilables-freezer.png"
container.icon_size = 256
container.flags = {"placeable-player", "player-creation"}
container.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
container.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
container.minable = {mining_time = 0.5, result = "spoilables-freezer"}
container.max_health = 200
container.corpse = "medium-remnants"
container.dying_explosion = "medium-explosion"
container.additional_pastable_entities = all_freezers
container.picture = {
      filename = "__freezer__/graphics/entity/spoilables-freezer/spoilables-freezer.png",
      width = 256,
      height = 256,
      scale = 0.375,
    }
container.surface_conditions = nil
container.inventory_size = 19
data:extend({container})

local function make_chest(name, base, color)
    local freezer = util.table.deepcopy(data.raw["logistic-container"][base])
    freezer.name = name
    freezer.icons = {{
        icon = "__freezer__/graphics/icons/spoilables-freezer.png",
        icon_size = 256,
        tint = color
                  }}
    freezer.icon = nil
    freezer.icon_size = nil
    freezer.animation = nil
    freezer.flags = {"placeable-player", "player-creation"}
    freezer.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
    freezer.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
    freezer.minable = {mining_time = 0.5, result = name}
    freezer.max_health = 200
    freezer.corpse = "medium-remnants"
    freezer.dying_explosion = "medium-explosion"
    freezer.additional_pastable_entities = all_freezers
    freezer.picture = {
        filename = "__freezer__/graphics/entity/spoilables-freezer/spoilables-freezer.png",
        width = 256,
        height = 256,
        scale = 0.375,
        tint = color
    }
    freezer.surface_conditions = nil
    freezer.inventory_size = 19
    data:extend({freezer})
end

make_chest("spoilables-freezer-active-provider", "active-provider-chest", {1,0.25,1})
make_chest("spoilables-freezer-provider", "passive-provider-chest", {1,0.25,0.25})
make_chest("spoilables-freezer-storage", "storage-chest", {1,1,0.25})
make_chest("spoilables-freezer-buffer", "buffer-chest", {0.25,1,0.25})
make_chest("spoilables-freezer-requester", "requester-chest", {0.25,0.25,1})

if settings.startup["temp-limit"].value then
  local temp_limit = 323.15
  data.raw["assembling-machine"]["freezer"].surface_conditions = {
    {
        property = "temperature",
        max = temp_limit,
    }
  }
  data.raw["container"]["spoilables-freezer"].surface_conditions = {
    {
        property = "temperature",
        max = temp_limit,
    }
  }
  data.raw["logistic-container"]["spoilables-freezer-provider"].surface_conditions = {
    {
        property = "temperature",
        max = temp_limit,
    }
  }
end
