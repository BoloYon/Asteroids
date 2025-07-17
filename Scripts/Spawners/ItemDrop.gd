extends Node

@export var Astrynite : PackedScene = preload("res://Scenes/Items Drops/Astrynite.tscn")
@export var Glintcore : PackedScene

func drop_astrynite(pos: Vector2, amount: int, parent: Node2D, accel: float, rotation: float):
	for i in range(amount):
		var ast = Astrynite.instantiate()
		ast.position = pos
		ast.rotation = randf_range(0,360)
		ast.accel = accel
		parent.add_child(ast)
	
