extends Node2D

@export var lifetime: float
@export var size: float

var accel : float

func _ready():
	scale = Vector2(size, size)
func _physics_process(delta: float) -> void:
	move_asteroid(delta)
	
func move_asteroid(delta: float):
	position += Vector2.RIGHT.rotated(rotation) * accel * delta
	await get_tree().create_timer(15).timeout
	self.queue_free()
