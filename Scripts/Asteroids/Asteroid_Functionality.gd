extends Node2D

@export var lifetime: float
@export var size: float
@export var health: float
@export var Asteroid_Scene : PackedScene = preload("res://Scenes/Asteroids/Asteroid_Default.tscn")

var accel : float

func _ready():
	scale = Vector2(size, size)
	print(Asteroid_Scene)
	
func _physics_process(delta: float) -> void:
	move_asteroid(delta)
	
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
