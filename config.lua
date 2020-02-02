Config                      = {}

Config.UseBlips             = true
Config.Color                = 1
Config.BlipID               = 402

Config.UseInterior          = false
Config.DoorLocations        = {Inside = {x = -139.24, y = -588.52, z = 166.0, toX = -144.44, toY = -577.46, toZ = 32.42, toH = 154.66},
                                Outside = {x = -144.44, y = -577.46, z = 31.42, toX = -139.24, toY = -588.52, toZ = 167.0, toH = 136.75}}

Config.CraftingLocation     = {x = 727.74, y = -1067.11, z = 27.31}
Config.InteriorCraftingLoc  = {x = -154.66, y = -587.99, z = 166.0}

Config.RequiresBlueprint    = true
Config.UseNUI               = true

Config.Blueprints           = { { name = "wrench", label = "Phone Blueprint", itemToCraft = "phone", manufactureTime = 5000},
                                { name = "phone", label = "Noss Blueprint", itemToCraft = "nitrocannister", manufactureTime = 5000},
                                { name = "plastic", label = "SMG Blueprint", itemToCraft = "weapon_microsmg", manufactureTime = 5000},
                                { name = "iron", label = "SMG Ammo Blueprint", itemToCraft = "smgammo", manufactureTime = 5000},
                                { name = "water", label = "Bread Blueprint", itemToCraft = "bread", manufactureTime = 5000}}

Config.Recipes              = { {name = "phone", label = "Phone", type = "ITEM", ingredients = {
                                                                        { name = "electronic", amount = 5},
                                                                        { name = "plastic", amount = 2}}, manufactureTime = 5000},

                                {name = "nitrocannister", label = "Nitro Cannister", type = "ITEM", ingredients = {
                                                                        { name = "phone", amount = 5},
                                                                        { name = "plastic", amount = 2},
                                                                        { name = "electronic", amount = 10}}, manufactureTime = 5000},

                                {name = "weapon_microsmg", label = "Micro SMG", type = "WEAPON", ammo = 30, ingredients = {
                                                                            { name = "phone", amount = 5},
                                                                            { name = "plastic", amount = 2},
                                                                            { name = "electronic", amount = 10}}, manufactureTime = 5000},

                                {name = "smgammo", label = "SMG Ammo", type = "AMMO", w_type = "weapon_microsmg", ammo = 30, ingredients = {
                                                                                { name = "iron", amount = 5}}, manufactureTime = 5000},
                                                                    
                                {name = "bread", label = "Bread", type = "ITEM", ingredients = {
                                                                            { name = "water", amount = 5}}, manufactureTime = 5000}}