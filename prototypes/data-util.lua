local data_util = {}

function data_util.set_stack_size(item, stack_size)
  local item = data.raw.item[item] or data.raw.tool[item] or data.raw.ammo[item]
  if not item then return end
  item.stack_size = stack_size or 50
end

function data_util.add_prerequisite(tech_name, prerequisite)
  local technology = data.raw.technology[tech_name]
  if not technology then
    return
  end
  for _, name in pairs(technology.prerequisites) do
    if name == prerequisite then
      return
    end
  end
  table.insert(technology.prerequisites, prerequisite)
end

function data_util.remove_prerequisite(tech_name, prerequisite)
  local technology = data.raw.technology[tech_name]
  for i, name in pairs(technology.prerequisites) do
    if name == prerequisite then
      table.remove(technology.prerequisites, i)
    end
  end
end

function data_util.add_research_ingredient(tech_name, ingredient)
  local technology = data.raw.technology[tech_name]
  for _, name in pairs(technology.unit.ingredients) do
    if name[1] == ingredient then
      return
    end
  end
  table.insert(technology.unit.ingredients, {ingredient, 1})
end

function data_util.remove_research_ingredient(tech_name, ingredient)
  local technology = data.raw.technology[tech_name]
  for i, name in pairs(technology.unit.ingredients) do
    if name[1] == ingredient then
      table.remove(technology.unit.ingredients, i)
    end
  end
end

function data_util.contains_research_ingredient(tech_name, ingredient)
  local technology = data.raw.technology[tech_name]
  for _, name in pairs(technology.unit.ingredients) do
    if name[1] == ingredient then
      return true
    end
  end
  return false
end

function data_util.is_descendant_of(tech_name, ancestor)
  --if tech_name == ancestor then return true end
  --log(ancestor .. "  -->  "..tech_name)
  local technology = data.raw.technology[tech_name]
  if not technology then return false end
  if technology.prerequisites == nil then
    return false
  end
  for _, name in pairs(technology.prerequisites) do
    if name == ancestor then
      return true
    end
    if data_util.is_descendant_of(name, ancestor) then
      return true
    end
  end
  return false
end

function data_util.allow_productivity(recipe_name)
  for _, module in pairs(data.raw.module) do
    if module.category == "productivity" and module.limitation then
      table.insert(module.limitation, recipe_name)
    end
  end
end

function data_util.debug_technology(tech_name)
  local tech = data.raw.technology[tech_name]
  if not tech then log("Unable to find "..tech_name) return end
  log(serpent.block({
    A_name    = tech.name,
    B_prereq  = tech.prerequisites,
    C_effects = tech.effects
  }))
end

function data_util.set_item_subgroup_order(subgroup_name, order)
  local item_subgroup = data.raw["item-subgroup"][subgroup_name]
  if not item_subgroup then return end
  item_subgroup.order = order
end

return data_util