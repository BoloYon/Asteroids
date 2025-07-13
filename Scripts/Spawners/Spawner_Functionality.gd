extends Node2D

@export var Asteroid_Scene : PackedScene
@export var margin : int = 300

var can_spawn = false

func _ready():
	#Avoids same set location when starting game
	set_random_spawn() 
	#Gives player a chance to see the scene
	await get_tree().create_timer(1).timeout 
	can_spawn = true

func _physics_process(delta: float) -> void:
	#Constantly get the player's position
	get_player_pos()
	#If cooldown is done, spawn asteroids and set a random spawn point
	if can_spawn:
		spawn_asteroid()
		set_random_spawn()
		
	
func get_player_pos():
	look_at(GameManager.player_pos)

func set_random_spawn():
	#Get the viewport's visibility rectangle
	var rect = get_viewport().get_visible_rect()
	
	#Define the sides (edges) for easier understanding
	var left = rect.position.x - margin
	var right = rect.position.x + rect.size.x + margin
	var up = rect.position.y - margin
	var down = rect.position.y + rect.size.y + margin
	
	#Make an array to randomly choose a number which corresponds to one of the directions
	var directions = ["left", "right", "up", "down"]
	var rand_picker = randi_range(0,3)
	match directions[rand_picker]:
		"left":
			var rand = randf_range(up, down)
			self.position = Vector2(left, rand)
		"right":
			var rand = randf_range(up, down)
			self.position = Vector2(right, rand)
		"up":
			var rand = randf_range(left, right)
			self.position = Vector2(rand, up)
		"down":
			var rand = randf_range(left, right)
			self.position = Vector2(rand, down)

func spawn_asteroid():
	#Set boolean
	can_spawn = false
	
	var asteroid = Asteroid_Scene.instantiate()
	asteroid.position = self.position
	asteroid.size = randf_range(0.04, 0.12)
	asteroid.rotation = self.rotation + (randf_range(0,0.5)) #Slight and random offset to avoid constant targeting
	asteroid.accel = randf_range(100,340)
	asteroid.lifetime = 10
	get_parent().add_child(asteroid)
	
	#Spawn Cooldown
	await get_tree().create_timer(0.57).timeout
	can_spawn = true
