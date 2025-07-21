extends Node

var player_pos : Vector2
var bullet_damage: float

var total_astrynite : float = 0
var runtime : float = 0
var wave : int
var time : float
var highscore : int
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
	total_astrynite += amount

func soft_reset():
	resources["Astrynite"] = 0
	wave = 0
	time = 0
	boss_checker = 0
	total_astrynite = 0
