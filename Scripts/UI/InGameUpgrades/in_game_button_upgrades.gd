extends Control

func _ready():
	pass
	z_index = 1000
	z_as_relative = false

#Penetration
func _on_penetration_upgrade_pressed() -> void:
	#Get new prices and update upgrade information
	var new_price: float = upgradeManager("Bullet Upgrades", "Penetration")
	
	#Set the texts
	$PenLabel.text = "Penetration Upgrade:\nLevel: %d" % CUps.upgrades["Bullet Upgrades"]["Penetration"]["level"]
	$PenLabel/Penetration.text = "%.2f" % new_price

#Player speed
func _on_speed_upgrade_pressed() -> void:
	var new_price: float = upgradeManager("Player Upgrades", "Speed")
	$SpeedLabel.text = "Speed Upgrade:\nLevel: %d" % CUps.upgrades["Player Upgrades"]["Speed"]["level"]
	$SpeedLabel/Speed.text = "%.2f" % new_price







#Bullet damage
func _on_bullet_damage_pressed() -> void:
	var new_price: float = upgradeManager("Bullet Upgrades", "Damage")
	$BullDmgLabel.text = "Damage Upgrade:\nLevel: %d" % CUps.upgrades["Bullet Upgrades"]["Damage"]["level"]
	$BullDmgLabel/BulletDamage.text = "%.2f" % new_price
	
	#Update the bullet damage in game manager
	GameManager.set_bullet_damage(CUps.upgrades["Bullet Upgrades"]["Damage"]["level"] * CUps.upgrades["Bullet Upgrades"]["Damage"]["effect_per_level"])


#Bullet speed
func _on_bullet_speed_pressed() -> void:
	var new_price = upgradeManager("Bullet Upgrades", "Speed")
	$BullSpeed.text = "Bullet Speed Upgrade:\nLevel: %d" % CUps.upgrades["Bullet Upgrades"]["Speed"]["level"]
	$BullSpeed/BulletSpeed.text = "%.2f" % new_price


func upgradeManager(cat: String, upg: String) -> float:
	#Assign variables to be used
	var level = CUps.upgrades[cat][upg]["level"]
	var costMult = CUps.upgrades[cat][upg]["cost_multiplier"]
	var baseCost = CUps.upgrades[cat][upg]["base_cost"]
	var current_price = baseCost * pow(costMult, level)
	#var price_if_not = baseCost * pow(costMult, level - 1)
	
	#Check to see if astrynite is enough
	if GameManager.resources["Astrynite"] >= current_price:
		GameManager.resources["Astrynite"] -= current_price
		CUps.upgrades[cat][upg]["level"] += 1
		var new_level = CUps.upgrades[cat][upg]["level"]
		var new_price = baseCost * pow(costMult, new_level)
		return new_price
	return current_price
