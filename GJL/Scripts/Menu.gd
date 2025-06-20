extends Control

var sceneName
var loadedScene
var instScene
var scoreArray

var fxButton = preload("res://Chiptone/Button.wav")
var fxStart = preload("res://Chiptone/StartGame.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Credits.visible = false
	$Stats.visible = false
	if StatsHolder.GetMusic():
		$TitleScreen/MusicIndicator.text = "MUSIC: ON"
	else:
		$TitleScreen/MusicIndicator.text = "MUSIC: OFF"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	$MenuPlayer.stream = fxButton
	$MenuPlayer.play()
	$Credits.visible = false

func _on_credits_button_pressed():
	$MenuPlayer.stream = fxButton
	$MenuPlayer.play()
	$Credits.visible = true

func _on_stat_back_button_pressed():
	$MenuPlayer.stream = fxButton
	$MenuPlayer.play()
	$Stats.visible = false

func _on_last_round_button_pressed():
	$MenuPlayer.stream = fxButton
	$MenuPlayer.play()
	$Stats.visible = true
	#UPDATE SCORES
	scoreArray = StatsHolder.GetScoreArray()
	$Stats/Score1.text = "#1: " + str(scoreArray[0])
	$Stats/Score2.text = "#2: " + str(scoreArray[1])
	$Stats/Score3.text = "#3: " + str(scoreArray[2])
	$Stats/Score4.text = "#4: " + str(scoreArray[3])
	$Stats/Score5.text = "#5: " + str(scoreArray[4])
	$Stats/Score6.text = "#6: " + str(scoreArray[5])
	$Stats/Score7.text = "#7: " + str(scoreArray[6])
	$Stats/Score8.text = "#8: " + str(scoreArray[7])
	$Stats/Score9.text = "#9: " + str(scoreArray[8])
	$Stats/Score10.text = "#10: " + str(scoreArray[9])
	#UPDATE SESSION
	$Stats/LastScore.text = "SCORE: " + str(StatsHolder.GetLastScore())
	$Stats/LastTime.text = "TOTAL TIME: " + str(StatsHolder.GetLastTimer())
	$Stats/LastFruit.text = "TOTAL FRUIT: " + str(StatsHolder.GetLastCollect())

func _on_play_button_pressed():
	$MenuPlayer.stream = fxStart
	$MenuPlayer.play()
	sceneName = "res://Scenes/Gameplay.tscn"
	loadedScene = load(sceneName)
	instScene = loadedScene.instantiate()
	add_child(instScene)


func _on_firefly_w_1_pressed():
	StatsHolder.SetMusic()
	if StatsHolder.GetMusic():
		$TitleScreen/MusicIndicator.text = "MUSIC: ON"
	else:
		$TitleScreen/MusicIndicator.text = "MUSIC: OFF"
