extends Area2D

@export var bullet_speed : float
@export var lifetime: float

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * bullet_speed * delta
	#Lifetime - 6 seconds
	await get_tree().create_timer(lifetime).timeout
	self.queue_free()
