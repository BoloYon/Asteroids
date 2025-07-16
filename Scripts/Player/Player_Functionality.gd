extends Node2D

@export var speed : float = 300.0
@export var bullet_damage: float

var can_shoot = true

func _ready():
	GameManager.set_bullet_damage(bullet_damage)
##Basic Movement Functionality
func _physics_process(delta: float):
	#Move the player based on input
	move_player(delta)
	#Face the direction where the mouse is pointing at
	face_mouse()
	#Screen Wrapping functionality
	wrap_screen()
	#Shoot if shoot button is pressed
	if Input.is_action_pressed("Shoot") and can_shoot:
		shoot()
	GameManager.current_player_pos(self.position)
	
	

func move_player(delta: float) -> void :
	#Initializing Cardinal Directions
	var Up = Input.is_action_pressed("MoveUp")
	var Down = Input.is_action_pressed("MoveDown")
	var Right = Input.is_action_pressed("MoveRight")
	var Left = Input.is_action_pressed("MoveLeft")
	
	#Initilalizing Positions
	var pos := self.position
	
	#Initilalizing Speeds
	var accel := speed*delta
	var diag_accel := (sqrt(2 * pow(speed, 2)) * delta)/2
	
	#Initializing logic that detects if we are currently going diagonal
	var diag_active := false
	var three_buttons := false
	var count := 0
	
	#Bug Fix: Holding W,A, and D or another combo of 3 numbers causes combination and regular speed to add together
	#Error Fix
	###
	if Up:
		count +=1
	if Down:
		count +=1
	if Right:
		count +=1
	if Left:
		count +=1
		
	if count >= 3:
		three_buttons = true
	if not three_buttons:
		#Combination
		if Up and Right:
			pos.y -= diag_accel
			pos.x += diag_accel
			diag_active = true
		if Up and Left:
			pos.y -= diag_accel
			pos.x -= diag_accel
			diag_active = true
		if Down and Right:
			pos.y += diag_accel
			pos.x += diag_accel
			diag_active = true
		if Down and Left:
			pos.y += diag_accel
			pos.x -= diag_accel
			diag_active = true
	
	#Regular directions
	if not diag_active:
		if Up:
			pos.y -= accel #Pixels per second
		if Down:
			pos.y += accel
		if Right:
			pos.x += accel
		if Left:
			pos.x -= accel
	
	#Set position
	self.position = pos

func shoot():
	#Set boolean to false for cooldown
	can_shoot = false
	#Make the bullet exist. The bullet comes with a set speed, but can be tweaked
	var bullet = preload("res://Scenes/Player/Ship/Bullet Skins/Bullet_Default.tscn").instantiate()
	bullet.position = global_position
	bullet.rotation = rotation #Where the ship is actually facing
	bullet.lifetime = 5.0
	get_parent().add_child(bullet)
	
	#Cooldown
	await get_tree().create_timer(1).timeout
	can_shoot = true
	
	
func face_mouse():
	look_at(get_global_mouse_position())

func wrap_screen():
	#Get the viewport's visibility rectangle
	var rect = get_viewport().get_visible_rect()
	
	#Define the sides (edges) for easier understanding
	var left = rect.position.x
	var right = rect.position.x + rect.size.x
	var up = rect.position.y
	var down = rect.position.y + rect.size.y
	
	#Define the player's positios
	var player_pos = self.position
	
	#Actual screen wrapping code
	if player_pos.x < left: #if the player's position goes passed the left size...
		player_pos.x = right#... teleport the player to the right with the same y axis
	if player_pos.x > right:
		player_pos.x = left
	if player_pos.y < up:
		player_pos.y = down
	if player_pos.y > down:
		player_pos.y = up
		
	#Set the position
	self.position = player_pos
		
		


func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Asteroid"):
		print("COLLISION DETECTED, ", area)
		GameManager.resources["Astrynite"] = 0
		get_parent().get_tree().reload_current_scene()
		
