
---@class ChemResearchModule : module
local M = {}

--#region Constants
local RESEARCH_GUI_NAME = "chem-research-gui"
--#endregion

--#region GUI Functions
local function create_research_gui(player)
  local gui = player.gui.center

  -- Check if the GUI already exists
  if gui[RESEARCH_GUI_NAME] then
    return
  end

  -- Create the GUI frame
  local frame = gui.add{
    type = "frame",
    name = RESEARCH_GUI_NAME,
    caption = "Chemical Research",
    direction = "vertical"
  }

  -- Add your GUI elements here
  -- For example, you can add labels, buttons, textboxes, etc.

  -- Example: Add a label
  frame.add{
    type = "label",
    caption = "Welcome to Chemical Research!"
  }
end

--#endregion

--#region Event Handlers
local function on_key_pressed(event)
  local player = game.get_player(event.player_index)
  if event.input_name == "chem-research-key" then
    create_research_gui(player)
  end
end
--#endregion

M.events = {
  [defines.events.on_key_pressed] = on_key_pressed
}

return M
