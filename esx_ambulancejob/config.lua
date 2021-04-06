Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.0, y = 1.0, z = 1.0, r = 0, g = 255, b = 0, a = 25, rotate = true } -- pillbox

Config.ReviveReward               = 130  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 5 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 3 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 1000

Config.RespawnPoint = { coords = vector3(320.052, -593.575, 43.292), heading = 93.42} -- pillbox

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3( 297.895, -584.094, 43.261), --pillbox
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vector3(308.791, -602.528, 42.36)
		},

		Pharmacies = {
			vector3(307.515, -594.306, 42.36) --pillbox
		},

		Vehicles = {
			{
				Spawner = vector3(297.12,-587.512,43.261), --pillbox
				InsideShop = vector3(289.532,-584.539, 42.832), --pillbox
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = { -- all pillbox
					{ coords = vector3(292.516,-609.973,43.042), heading = 68.186, radius = 4.0 }, 
					{ coords = vector3(287.627,-589.442,42.813), heading = 342.019, radius = 4.0 },
					{ coords = vector3(291.625,-571.292, 42.853), heading = 69.296, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(317.5, -1449.5, 46.5),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(313.5, -1465.1, 46.5), heading = 142.7, radius = 10.0 },
					{ coords = vector3(299.5, -1453.2, 46.5), heading = 142.7, radius = 10.0 }
				}
			}
		},
		
		FastTravels = {
			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, rotate = false }
			},

			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, rotate = false }
			},

			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false }
			},

			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, rotate = false }
			},

			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, rotate = false }
			},

			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, rotate = false }
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(0, 0, 0),
				To = { coords = vector3(0, 0, 0), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, rotate = false },
				Prompt = _U('fast_travel')
			}
		}
		

	}
}

Config.AuthorizedVehicles = {

    ambulance = {
		{ model = 'ambulance', label = 'Ambulance', price = 40 },
		{ model = 'ambulance2', label = 'Ambulance 2', price = 40 },
		{ model = 'emscar', label = 'Car', price = 40 },
		{ model = 'emscar2', label = 'Car2', price = 40 },
		{ model = 'emssuv', label = 'SUV', price = 40 },
		{ model = 'emsvan', label = 'Van', price = 40 }
    },

	doctor = {
		{ model = 'ambulance', label = 'Ambulance', price = 40 },
		{ model = 'ambulance2', label = 'Ambulance 2', price = 40 },
		{ model = 'emscar', label = 'Car', price = 40 },
		{ model = 'emscar2', label = 'Car2', price = 40 },
		{ model = 'emssuv', label = 'SUV', price = 40 },
		{ model = 'emsvan', label = 'Van', price = 40 } },


	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance', price = 40 },
		{ model = 'ambulance2', label = 'Ambulance 2', price = 40 },
		{ model = 'emscar', label = 'Car', price = 40 },
		{ model = 'emscar2', label = 'Car2', price = 40 },
		{ model = 'emssuv', label = 'SUV', price = 40 },
		{ model = 'emsvan', label = 'Van', price = 40 } },


	boss = {
		{ model = 'ambulance', label = 'Ambulance', price = 40 },
		{ model = 'ambulance2', label = 'Ambulance 2', price = 40 },
		{ model = 'emscar', label = 'Car', price = 40 },
		{ model = 'emscar2', label = 'Car2', price = 40 },
		{ model = 'emssuv', label = 'SUV', price = 40 },
		{ model = 'emsvan', label = 'Van', price = 40 } },

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{
			model = 'buzzard2',
			label = 'Nagasaki Buzzard',
			price = 150000
		}
	},

	chief_doctor = {
		{
			model = 'buzzard2',
			label = 'Nagasaki Buzzard',
			price = 150000
		},

		{
			model = 'seasparrow',
			label = 'Sea Sparrow',
			price = 300000
		}
	},

	boss = {
		{
			model = 'buzzard2',
			label = 'Nagasaki Buzzard',
			price = 100000
		},

		{
			model = 'seasparrow',
			label = 'Sea Sparrow',
			price = 250000
		}
	}

}
