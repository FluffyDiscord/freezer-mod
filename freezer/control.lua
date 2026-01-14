script.on_init(function()
    storage.spoilage_freezers = {}
    storage.spoilage_freezer_wagons = {}
end)

script.on_configuration_changed(function()
    storage.spoilage_freezers = storage.spoilage_freezers or {}
    storage.spoilage_freezer_wagons = storage.spoilage_freezer_wagons or {}
end)

local all_freezers = {
    "spoilables-freezer",
    "spoilables-freezer-active-provider",
    "spoilables-freezer-provider",
    "spoilables-freezer-storage",
    "spoilables-freezer-buffer",
    "spoilables-freezer-requester",
}

local freezer_set = {}
for _,l in ipairs(all_freezers) do
    freezer_set[l] = true
end

local event_filter = {
    {filter="name", name="spoilables-freezer"},
    {filter="name", name="spoilables-freezer-active-provider"},
    {filter="name", name="spoilables-freezer-provider"},
    {filter="name", name="spoilables-freezer-storage"},
    {filter="name", name="spoilables-freezer-buffer"},
    {filter="name", name="spoilables-freezer-requester"},
    {filter="name", name="cargo-wagon-freezer"},
}

local function on_built(event)
    local entity = event.entity
    if freezer_set[entity.name] then
        local surf = entity.surface
        local power = surf.create_entity{
            name = "spoilables-freezer-interface",
            position = entity.position,
            force = entity.force,
            raise_built = false,
            create_build_effect_smoke = false,
            quality = entity.quality
        }
        power.destructible = false
        local planet = surf.planet
        local temp = 0.0
        if planet then
            temp = planet.prototype.surface_properties.temperature or 291.15
        end
        power.power_usage = math.max(temp - 273.15, 0) / 18 * 1000000 / 60
        storage.spoilage_freezers[entity.unit_number] = {entity = entity, power = power}
    elseif entity.name == "cargo-wagon-freezer" then
        storage.spoilage_freezer_wagons[entity.unit_number] = entity
    end
end

local function on_entity_removed(event)
    local entity = event.entity
    if freezer_set[entity.name] then
        local data = storage.spoilage_freezers[entity.unit_number]
        if data then
            data.power.destroy()
        end
        storage.spoilage_freezers[entity.unit_number] = nil
    elseif entity.name == "cargo-wagon-freezer" then
        storage.spoilage_freezer_wagons[entity.unit_number] = nil
        for index, equipment in ipairs(entity.grid.equipment) do
            local item = equipment.prototype.take_result
            if not item == nil then
                local item_stack = {name=item.name, count=1, quality=equipment.quality}
                entity.surface.spill_item_stack{position=entity.position, stack=item_stack, enable_looted=true, force=entity.force, allow_belts=false}
            end
        end
    end
end

script.on_event(defines.events.on_built_entity, on_built, event_filter)

script.on_event(defines.events.on_robot_built_entity, on_built, event_filter)

script.on_event(defines.events.on_space_platform_built_entity, on_built, event_filter)

script.on_event(defines.events.on_player_mined_entity, on_entity_removed, event_filter)

script.on_event(defines.events.on_robot_mined_entity, on_entity_removed, event_filter)

script.on_event(defines.events.on_entity_died, on_entity_removed, event_filter)

script.on_event(defines.events.on_space_platform_pre_mined, on_entity_removed, event_filter)

local function freeze_stack(stack)
    if stack and stack.valid_for_read and stack.spoil_percent ~= 0 then
        local time_left = stack.spoil_tick - game.tick
        stack.spoil_tick = game.tick + math.min(stack.prototype.get_spoil_ticks(stack.quality), time_left + 300)
    end
end

local function freeze_container_items(container, type)
    if not container or not container.valid then return end
    local inventory = container.get_inventory(type)
    if not inventory then return end
    for i = 1, #inventory, 1 do
        local stack = inventory[i]
        freeze_stack(stack)
    end
end

local function is_subzero(entity)
    local planet = entity.surface.planet
    if planet then
        return planet.prototype.surface_properties.temperature or 1 <= 0
    end
    return true
end

script.on_nth_tick(300, function(event)
    for unit_nr, data in pairs(storage.spoilage_freezers) do
        local entity = data.entity
        local power = data.power
        if not entity or not entity.valid then
            storage.spoilage_freezers[unit_nr] = nil
            goto continue
        end
        if power.energy > 5000000 or is_subzero(entity) then -- 5MJ
            freeze_container_items(entity, defines.inventory.chest)
        end
        ::continue::
    end
    for unit_nr, entity in pairs(storage.spoilage_freezer_wagons) do
        if not entity or not entity.valid then
            storage.spoilage_freezer_wagons[unit_nr] = nil
            goto continue2
        end
        for _, equipment in pairs(entity.grid.equipment) do
            if equipment.name == "cargo-wagon-freezer-equipment" then
                if equipment.energy > 5000000 or is_subzero(entity) then -- 5MJ
                    freeze_container_items(entity, defines.inventory.cargo_wagon)
                end
                goto continue2
            end
        end
        ::continue2::
    end
end)

-- Handle GUI opening
script.on_event(defines.events.on_gui_opened, function(event)
    local player = game.players[event.player_index]
    local entity = event.entity
    if entity then
        if entity.name == "spoilables-freezer-interface" then
            player.opened = nil  -- Prevent GUI from opening
        end
    end
end)
