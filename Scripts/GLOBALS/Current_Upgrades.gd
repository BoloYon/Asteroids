extends Node

#All current upgrades
var upgrades := {
	"Bullet Upgrades":{
		"Penetration":{
			"name": "Increases bullet penetration",
			"level": 0,
			"base_cost": 10.0,
			"cost_multiplier": 1.7,
			"effect_per_level": 1
		},
		"Damage":{
			"name": "Increases bullet damage",
			"level": 0,
			"base_cost": 0.12,
			"cost_multiplier": 1.4,
			"effect_per_level": 3.5
		},
		"Speed":{
			"name": "Increases bullet speed",
			"level": 0,
			"base_cost": 0.50,
			"cost_multiplier": 1.2,
			"effect_per_level": 10
		},
	},
	"Player Upgrades":{
		"Speed": {
			"name": "Increases player speed",
			"level": 0,
			"base_cost": 0.25,
			"cost_multiplier": 1.4,
			"effect_per_level": 5.0
		},
		"Health":{
			"name": "Increases player health",
			"level": 0,
			"base_cost": 0.25,
			"cost_multiplier": 1.4,
			"effect_per_level": 5.0
		}
	}
}

func reset():
	for category in upgrades:
		for upgrade in upgrades[category]:
			upgrades[category][upgrade]["level"] = 0
