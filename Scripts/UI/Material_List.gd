extends Control

var ast_count: float

func _process(delta) -> void:
	if ast_count  != GameManager.resources["Astrynite"]:
		$Astrynite.text = "%.2f" % GameManager.resources["Astrynite"]
		ast_count = GameManager.resources["Astrynite"]
