extends Control

var counter : float
var boss_queued : bool 

func _ready():
	boss_queued = false 

#BOSS SPAWNING AND BREAKAGE IS FIXED AND IMPLEMENTED, FIX BOSS DETECTION

func _process(delta):
	CheckBossStatus()
	increaseTime(delta)
	updateProgressBar()
	call_NewWave()
	if counter >= 1 and not (GameManager.boss_isAlive) and not boss_queued: #if counter is 100% AND boss is not alive
		boss_queued = true
		call_BossSpawn()
	


func CheckBossStatus():
	if GameManager.boss_checker == 0:
		GameManager.boss_isAlive = false
	else:
		GameManager.boss_isAlive = true

func increaseTime(delta) -> void:
	GameManager.time += delta
	
func getRatio() -> float :
	counter = (GameManager.time/10) #1 Wave per 70 seconds
	return counter
	
func updateProgressBar() -> void:
	$ProgressBar.value = getRatio()

func call_BossSpawn() -> void:
	GameManager.spawn_Boss = true
func call_NewWave () -> void:
	if counter >= 1 and not GameManager.boss_isAlive:
		boss_queued = false #Rese
		GameManager.time = 0 #Reset time
		GameManager.wave +=1 #Increase wave count
