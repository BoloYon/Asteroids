extends Node2D

@export var lifetime: float
@export var size: float
@export var health: float
@export var Asteroid_Scene : PackedScene = preload("res://Scenes/Asteroids/Asteroid_Default.tscn")
@export var DropAmount: int


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
	var rect = get_viewport().get_visible_rect()
	
#Define the sides (edges) for easier understanding
	left = rect.position.x
	right = rect.position.x + rect.size.x
	up = rect.position.y
	down = rect.position.y + rect.size.y
	
	
func _physics_process(delta: float) -> void:
	move_asteroid(delta)
	is_out_of_view()
	
func move_asteroid(delta: float):
	position += Vector2.RIGHT.rotated(rotation) * accel * delta
	await get_tree().create_timer(15).timeout
	self.queue_free()

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
	if self.size >= 0.06 and not is_in_group("BabyAsteroid"):
		for i in range(randi_range(2, 3)):
			var new_asteroid = Asteroid_Scene.instantiate()
			new_asteroid.position = self.position
			new_asteroid.rotation = randf_range(0, 360)
			new_asteroid.accel = self.accel
			new_asteroid.size = self.size - randf_range(0.02, 0.04)
			new_asteroid.add_to_group("BabyAsteroid")
			get_parent().add_child(new_asteroid)
			queue_free()
	else:
		queue_free()

func is_out_of_view():
	if self.position.x < left - 350: #if the player's position goes passed the left size...
		queue_free()#... teleport the player to the right with the same y axis
	if self.position.x > right + 350:
		queue_free()
	if self.position.y < up - 350:
		queue_free()
	if self.position.y > down + 350:
		queue_free()
	
