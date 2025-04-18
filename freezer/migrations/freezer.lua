for _,surface in pairs(game.surfaces) do
    for _,entity in pairs(surface.find_entities_filtered({name="cargo-wagon-freezer"})) do
        storage.spoilage_freezer_wagons[entity.unit_number] = entity
    end
    for _,entity in pairs(surface.find_entities_filtered({name="spoilables-freezer-interface"})) do
        entity.destroy()
    end
    for _,entity in pairs(surface.find_entities_filtered({
        name= {
            "spoilables-freezer",
            "spoilables-freezer-active-provider",
            "spoilables-freezer-provider",
            "spoilables-freezer-storage",
            "spoilables-freezer-buffer",
            "spoilables-freezer-requester",
        }})) do
            local power = surface.create_entity{
                name = "spoilables-freezer-interface",
                position = entity.position,
                force = entity.force,
                raise_built = false,
                create_build_effect_smoke = false,
                quality = entity.quality
            }
            power.destructible = false
            local planet = surface.planet
            local temp = 0.0
            if planet then
                temp = planet.prototype.surface_properties.temperature or 291.15
            end
            power.power_usage = math.max(temp - 273.15, 0) / 18 * 1000000 / 60
            storage.spoilage_freezers[entity.unit_number] = {entity = entity, power = power}
    end
end