extends Node2D

func _ready():
	GameManager.time = 0
	GameManager.wave = 0 
	GameManager.soft_reset()
