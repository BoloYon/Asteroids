extends Node

func _process(delta):
	if get_parent().get_node("DeathScreen").is_visible_in_tree() and GameManager.total_astrynite > 0:
		$"Panel/Astrynite/AstNum".text = "%.2f" % GameManager.total_astrynite


func _on_new_run_pressed() -> void:
	get_tree().paused = false
	set_UI_on_reset()
	reset_astrynite()
	GameManager.resources["Astrynite"] = 0
	CUps.reset()
	get_parent().get_tree().reload_current_scene()

func set_UI_on_reset():
	get_parent().get_node("DeathScreen").hide()
	get_parent().get_node("InGameButtonUpgrades").show()
	get_parent().get_node("MaterialList").show()


func reset_astrynite():
	GameManager.resources["astrynite"] = 0
	GameManager.total_astrynite = 0
