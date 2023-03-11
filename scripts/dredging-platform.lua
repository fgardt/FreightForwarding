function dredger_created(dredger)
  local surface = dredger.surface
  local position = dredger.position
  dredger.destroy()
  local seamount = surface.find_entity("ff-seamount", position)
  seamount.destroy()
  local created = surface.create_entity{
    name = "ff-dredger",
    position = position,
    force = "player",
    create_build_effect_smoke = false,
  }
  created.destructible = false

  local pole = surface.create_entity{
    name = "ff-dredger-pole",
    position = position,
    force = "player",
    create_build_effect_smoke = false,
  }
  pole.destructible = false

  local radar = surface.create_entity{
    name = "ff-dredger-radar",
    position = position,
    force = "player",
    create_build_effect_smoke = false,
  }
  radar.destructible = false

  local x = position.x
  local y = position.y
  local tiles = {}
  for i = -9, 8 do
    for j = -9, 8 do
      table.insert(tiles, {name = "ff-dredging-platform", position = {x + i, y + j}})
    end
  end
  surface.set_tiles(tiles, true, false)
end