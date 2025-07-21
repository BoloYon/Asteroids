extends Node2D

@export var lifetime: float
@export var size: float
@export var health: float
@export var Asteroid_Scene : PackedScene = preload("res://Scenes/Asteroids/Asteroid_Default.tscn")
@export var DropAmount: int

var margin : int

var accel : float

#Get Viewport size
var rect
	
#Define the sides (edges) for easier understanding
var left : float
var right : float
var up : float
var down : float

func _ready():
	scale = Vector2(size, size)
	
	#DONT REMOVE
	var rect = get_viewport().get_visible_rect()
	
#Define the sides (edges) for easier understanding
	left = rect.position.x
	right = rect.position.x + rect.size.x
	up = rect.position.y
	down = rect.position.y + rect.size.y
	
	
func _physics_process(delta: float) -> void:
	move_asteroid(delta)
	if is_in_group("regular asteroid") or is_in_group("BabyAsteroid"):
		is_out_of_view()
	else:
		wrap_screen()
	
func move_asteroid(delta: float):
	position += Vector2.RIGHT.rotated(rotation) * accel * delta

func _on_asteroid_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		health -= GameManager.bullet_damage
		if health <= 0:
			break_asteroid()
		
func break_asteroid():
	var parent = get_parent()
	ItemDrop.drop_astrynite(self.position, DropAmount, parent, accel, self.rotation)
	asteroid_break_logic()
	


func asteroid_break_logic():
	if (is_in_group("Boss")):
		break_Boss()
	if (is_in_group("MiniBoss")):
		break_MiniBoss()
	if (is_in_group("BabyBoss")):
		break_BabyBoss()
	if is_in_group("regular asteroid") and self.size >= 0.06:
		break_Asteroid()
	elif is_in_group("regular asteroid") and self.size <0.06:
		queue_free()
		
	if is_in_group("BabyAsteroid"):
		break_Baby()
	
	
func is_out_of_view():
	if self.position.x < left - 350: #if the player's position goes passed the left size...
		queue_free()#... teleport the player to the right with the same y axis
	if self.position.x > right + 350:
		queue_free()
	if self.position.y < up - 350:
		queue_free()
	if self.position.y > down + 350:
		queue_free()

func wrap_screen():
	if is_in_group("Boss"):
		margin = 400
	elif is_in_group("MiniBoss"):
		margin = 300
	elif is_in_group("BabyBoss"):
		margin = 200
	#Get the viewport's visibility rectangle
	var rect = get_viewport().get_visible_rect()
	
	#Define the sides (edges) for easier understanding
	var left = rect.position.x - margin
	var right = rect.position.x + rect.size.x + margin
	var up = rect.position.y - margin
	var down = rect.position.y + rect.size.y + margin
	
	#Define the player's positios
	var pos = self.position
	
	#Actual screen wrapping code
	if pos.x < left: #if the player's position goes passed the left size...
		pos.x = right #... teleport the player to the right with the same y axis
	if pos.x > right:
		pos.x = left
	if pos.y < up:
		pos.y = down
	if pos.y > down:
		pos.y = up
		
	#Set the position
	self.position = pos





func break_Boss():
	for i in range(randi_range(4,7)):
		GameManager.boss_checker += 1 #Adds x to boss checker
		var miniBoss = Asteroid_Scene.instantiate()
		miniBoss.health = self.health * .75
		miniBoss.position = self.position
		miniBoss.rotation = randf_range(0, 360)
		miniBoss.accel = self.accel
		miniBoss.size = self.size * randf_range(0.5, 0.7)
		miniBoss.add_to_group("MiniBoss")
		get_parent().add_child(miniBoss)
		queue_free()
	GameManager.boss_checker -= 1 #Removes big boss's count
	pass

func break_MiniBoss():
	#Make a function that breaks a miniboss into babyboss (so it can screenwrap)
	for i in range(randi_range(4,7)):
		GameManager.boss_checker += 1 #Adds x to boss checker
		var babyBoss = Asteroid_Scene.instantiate()
		babyBoss.health = self.health * .75
		babyBoss.position = self.position
		babyBoss.rotation = randf_range(0, 360)
		babyBoss.accel = self.accel
		babyBoss.size = self.size * randf_range(0.5, 0.7)
		babyBoss.add_to_group("BabyBoss")
		get_parent().add_child(babyBoss)
		queue_free()
	GameManager.boss_checker -= 1 #Removes mini boss's count
	pass

func break_BabyBoss():
	#Make a function that if a babyboss is broken, free this from queue when broken.
	GameManager.boss_checker -= 1 #Removes the baby boss count when destroyed
	queue_free()
	pass

func break_Asteroid():
	for i in range(randi_range(2, 3)):
		var new_asteroid = Asteroid_Scene.instantiate()
		new_asteroid.health = self.health * 0.25
		new_asteroid.position = self.position
		new_asteroid.rotation = randf_range(0, 360)
		new_asteroid.accel = self.accel
		new_asteroid.size = self.size - randf_range(0.02, 0.04)
		new_asteroid.add_to_group("BabyAsteroid")
		get_parent().add_child(new_asteroid)
		queue_free()
	pass

func break_Baby():
	queue_free()
	pass
