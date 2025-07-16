extends Node

var player_pos : Vector2
var bullet_damage: float

var resources := {
	"Astrynite": 0
}

func current_player_pos(pos : Vector2):
	player_pos = pos
func set_bullet_damage(dmg: float):
	bullet_damage = dmg
	
func add_currency(name: String, amount: int):
	resources[name] += amount
	print("Added %d %s! Total amount: %d" % amount, name, resources[name])
