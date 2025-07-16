extends Node

@export var multiplier : float

func _on_astrynite_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		GameManager.add_currency("Astrynite", multiplier)
		#Tween animation!
		queue_free()


func _on_astryite_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
