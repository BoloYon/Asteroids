extends Node2D

@export var Asteroid_Scene : PackedScene
@export var SpawnSpeed: float
@export var wave_manager: Node

var can_spawn = false


func _ready():
	#Connect the spawn boss signal from wave manager 
	get_parent().get_node("WaveManager").boss_spawn_requested.connect(_on_boss_spawn_requested)
	
	#Avoids same set location when starting game
	set_random_spawn_regular() 
	#Gives player a chance to see the scene
	await get_tree().create_timer(1).timeout 
	can_spawn = true

func _physics_process(delta: float) -> void:
	#Constantly get the player's position
	get_player_pos()
	#If cooldown is done, spawn asteroids and set a random spawn point
	if can_spawn:
		spawn_asteroid()
		set_random_spawn_regular()
	

func get_player_pos():
	look_at(GameManager.player_pos)

func set_random_spawn_regular():
	#Get the viewport's visibility rectangle
	var rect = get_viewport().get_visible_rect()
	
	#Define the sides (edges) for easier understanding
	var left = rect.position.x - 300
	var right = rect.position.x + rect.size.x + 300
	var up = rect.position.y - 300
	var down = rect.position.y + rect.size.y + 300
	
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

func set_random_spawn_boss():
	var margin : int = 400
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
	if(GameManager.boss_checker == 0):
		#Set boolean
		can_spawn = false
		
		var asteroid = Asteroid_Scene.instantiate()
		asteroid.position = self.position
		asteroid.max_health = 1.5 + 5 * pow(GameManager.wave, 1.25) #Base health * multiplier
		asteroid.size = randf_range(0.04, 0.12)
		asteroid.rotation = self.rotation + (randf_range(0,0.5)) #Slight and random offset to avoid constant targeting
		asteroid.accel = randf_range(100,340)
		asteroid.add_to_group("regular asteroid")
		get_parent().add_child(asteroid)
		
		#Spawn Cooldown
		await get_tree().create_timer(SpawnSpeed).timeout
		can_spawn = true
		decrease_spawn_speed()

func _on_boss_spawn_requested():
	set_random_spawn_boss()
	spawn_Boss_asteroid()

func spawn_Boss_asteroid():
	GameManager.boss_checker += 1
		
	var BossAsteroid = Asteroid_Scene.instantiate()
		
	BossAsteroid.position = self.position
	BossAsteroid.max_health = 10 + pow((GameManager.wave * 10),1.234);
	BossAsteroid.add_to_group("Boss")
	BossAsteroid.size = randf_range(0.30, 0.36)
	BossAsteroid.rotation = self.rotation + (randf_range(0,0.5)) #Slight and random offset to avoid constant targeting
	BossAsteroid.accel = randf_range(100,200)
	get_parent().add_child(BossAsteroid)
		
		

func decrease_spawn_speed():
	var min_speed = 0.25
	var multiplier = max(0.5, 0.98 - (GameManager.wave * 0.01))
	SpawnSpeed = max(min_speed, SpawnSpeed * multiplier)
		
