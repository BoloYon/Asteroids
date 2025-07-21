extends Area2D

@export var bullet_speed : float
@export var lifetime: float
@export var penetration: int

var curr_pen

func _ready():
	curr_pen = penetration
	
	
func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * bullet_speed * delta
	await get_tree().create_timer(lifetime).timeout
	self.queue_free()
	


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Asteroid") or area.is_in_group("Enemy"):
		if curr_pen > 0:
			curr_pen -= 1
		else:
			queue_free()
