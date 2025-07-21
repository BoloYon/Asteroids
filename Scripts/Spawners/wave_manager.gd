extends Node

#Make a signal that requests a boss spawn
signal boss_spawn_requested

#Make a wave duraion export to easily change it for debugging
@export var wave_duration : float = 10.0

#Make variables for total time and if the boss is spawned
var time_accumulated: float = 0.0
var boss_spawned: bool = false

#Interval in which the boss_check happens
@export var check_boss_alive_interval: float = 0.1
var boss_check_timer: float = 0.0



#Process this function every frame:
func _process(delta) -> void:
	#Checks to see if boss is spawned, if so, ever 0.1 seconds, check to see if all boss instances are dead
	if boss_spawned:
		boss_check_timer += delta
		if boss_check_timer >= check_boss_alive_interval:
			boss_check_timer = 0
			if GameManager.boss_checker <= 0:
				print("Boss Checker = 0")
				on_boss_defeated()
		return
	
	highscore()
	
	#Get time and check if exceeded wave duration
	time_accumulated += delta
	if time_accumulated >= wave_duration:
		#The boss will be spawned so emit the signal
		boss_spawned = true
		emit_signal("boss_spawn_requested")


#Called on boss's death
func on_boss_defeated() -> void:
	#When the boss dies
	time_accumulated = 0
	GameManager.wave += 1
	boss_spawned = false

func highscore():
	if GameManager.wave > GameManager.highscore:
		GameManager.highscore = GameManager.wave
