extends Node

var player_pos : Vector2
var bullet_damage: float

var total_astrynite : float = 0

var runtime : float = 0

var wave : int
var time : float
var spawn_Boss : bool
var boss_isAlive : bool
var boss_checker: int = 0

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
	total_astrynite += amount
