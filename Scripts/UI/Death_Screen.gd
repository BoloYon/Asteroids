extends Node

func _process(delta):
	if get_parent().get_node("DeathScreen").is_visible_in_tree():
		$"Panel/Astrynite/AstNum".text = "%.2f" % GameManager.total_astrynite
		$"Panel/WaveTitle/CurrentWave".text = "%d" % GameManager.wave
		$Panel/HighScoreTitle/HighestWave.text = "%d" % GameManager.highscore
		


func _on_new_run_pressed() -> void:
	get_tree().paused = false
	set_UI_on_reset()
	GameManager.soft_reset()
	CUps.reset()
	get_parent().get_tree().reload_current_scene()


func set_UI_on_reset():
	get_parent().get_node("DeathScreen").hide()
	get_parent().get_node("InGameButtonUpgrades").show()
	get_parent().get_node("MaterialList").show()
	get_parent().get_node("ProgressBar/ProgressBar/Control").show()
