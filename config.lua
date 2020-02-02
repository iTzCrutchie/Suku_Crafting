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

Config.Blueprints           = { { name = "wrench", label = "Phone Blueprint", itemToCraft = "phone", manufactureTime = 5000, img = "https://i.imgur.com/PIfiF1a.png"},
                                { name = "phone", label = "Noss Blueprint", itemToCraft = "nitrocannister", manufactureTime = 5000, img = "https://i.imgur.com/3mUcq7D.png"},
                                { name = "water", label = "Bread Blueprint", itemToCraft = "bread", manufactureTime = 5000, img = "https://i.imgur.com/cwmbjRY.png"}}

Config.Recipes              = { {name = "phone", label = "Phone", ingredients = {
                                                                        { name = "electronic", amount = 5},
                                                                        { name = "plastic", amount = 2}}, manufactureTime = 5000},

                                {name = "nitrocannister", label = "Nitro Cannister", ingredients = {
                                                                        { name = "phone", amount = 5},
                                                                        { name = "plastic", amount = 2},
                                                                        { name = "electronic", amount = 10}}, manufactureTime = 5000},
                                                                    
                                {name = "bread", label = "Bread", ingredients = {
                                                                            { name = "water", amount = 5}}, manufactureTime = 5000}}

                                                                            --<div class="card-body" style="background-image: url(\'img/' + data.schematics[i].name + '.png\'>


                                                                            --<img src="\img/`+ data.schematics[i].name +`.png\" class="card-img" alt="...">

                                                                            --style="background-image: url(\img/`+ data.schematics[i].name +`.png\)"


                                                                        