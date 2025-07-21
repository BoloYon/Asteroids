extends Node2D

@export var multiplier : float
@export var accel : float

func _ready():
	z_index = 100
	z_as_relative = false

func _physics_process(delta: float) -> void:
	if accel > 0:
		velocity_slow(delta)
		wrap_screen()

func _on_astrynite_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		GameManager.add_currency("Astrynite", multiplier)
		#Tween animation!
		queue_free()



func velocity_slow(delta):
	self.position += Vector2.RIGHT.rotated(rotation) * accel * delta
	accel -= 3

func wrap_screen():
	#Get the viewport's visibility rectangle
	var rect = get_viewport().get_visible_rect()
	
	#Define the sides (edges) for easier understanding
	var left = rect.position.x
	var right = rect.position.x + rect.size.x
	var up = rect.position.y
	var down = rect.position.y + rect.size.y
	
	#Define the player's positios
	var pos = self.position
	
	#Actual screen wrapping code
	if pos.x < left: #if the player's position goes passed the left size...
		pos.x = right#... teleport the player to the right with the same y axis
	if pos.x > right:
		pos.x = left
	if pos.y < up:
		pos.y = down
	if pos.y > down:
		pos.y = up
		
	#Set the position
	self.position = pos
