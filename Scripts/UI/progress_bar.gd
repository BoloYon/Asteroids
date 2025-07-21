extends Control

var wave_count : int
var boss_num : int


func _ready():
	wave_count = 0
	boss_num = 0
	set_process(true)
	

func _process(_delta: float) -> void:
	if get_parent().get_node("WaveManager").boss_spawned:
		$ProgressBar.value = 1
	
	update_wave_count()
	update_boss_count()
	
	
	var ratio = get_parent().get_node("WaveManager").time_accumulated / get_parent().get_node("WaveManager").wave_duration
	$ProgressBar.value = ratio
	

func update_wave_count():
	if GameManager.wave != wave_count:
		wave_count = GameManager.wave
		$ProgressBar/Control/WaveLabel.text = "Wave: %d" % wave_count
	
func update_boss_count():
	if GameManager.boss_checker != boss_num:
		boss_num = GameManager.boss_checker
		$ProgressBar/Control/NumOBossesLabel.text = "# of Bosses: %d" % boss_num
