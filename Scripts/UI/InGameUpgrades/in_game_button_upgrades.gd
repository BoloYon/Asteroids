extends Control

func _ready():
	pass
	z_index = 1000
	z_as_relative = false

func _on_penetration_upgrade_pressed() -> void:
	var base_cost :float = CUps.upgrades["Penetration"]["base_cost"]
	var cost_multiplier : float = CUps.upgrades["Penetration"]["cost_multiplier"]
	var level : int = CUps.upgrades["Penetration"]["level"]
	
	
	var current_price : float = base_cost * pow(cost_multiplier, level)
	
	
	if GameManager.resources["Astrynite"] >= current_price:
		GameManager.resources["Astrynite"] -= current_price
		CUps.upgrades["Penetration"]["level"] += 1
		
		var new_level = CUps.upgrades["Penetration"]["level"]
		var new_price = base_cost * pow(cost_multiplier, new_level)
		
		$PenLabel.text = "Penetration Upgrade:\nLevel: %d" % CUps.upgrades["Penetration"]["level"]
		$PenLabel/Penetration.text = "%.2f" % new_price

func _on_speed_upgrade_pressed() -> void:
	var base_cost :float = CUps.upgrades["Speed"]["base_cost"]
	var cost_multiplier : float = CUps.upgrades["Speed"]["cost_multiplier"]
	var level : int = CUps.upgrades["Speed"]["level"]
	
	
	var current_price : float = base_cost * pow(cost_multiplier, level)
	
	
	if GameManager.resources["Astrynite"] >= current_price:
		GameManager.resources["Astrynite"] -= current_price
		CUps.upgrades["Speed"]["level"] += 1
		
	
		var new_level = CUps.upgrades["Speed"]["level"]
		var new_price = base_cost * pow(cost_multiplier, new_level)
		
		$SpeedLabel.text = "Speed Upgrade:\nLevel: %d" % CUps.upgrades["Speed"]["level"]
		$SpeedLabel/Speed.text = "%.2f" % new_price
