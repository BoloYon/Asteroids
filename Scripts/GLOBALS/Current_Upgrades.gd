extends Node


var upgrades := {
	"Speed": {
		"name": "Increase Speed",
		"level": 0,
		"base_cost": 0.25,
		"cost_multiplier": 1.4,
		"effect_per_level": 5.0
		
	},
	"Penetration":{
		"name": "Increase Speed",
		"level": 0,
		"base_cost": 10.0,
		"cost_multiplier": 1.7,
		"effect_per_level": 1
	}
}

func reset():
	for key in upgrades:
		upgrades[key]["level"] = 0
