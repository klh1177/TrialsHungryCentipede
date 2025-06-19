extends Node2D


func _ready():
	#SET ALL LOCATIONS
	$Head.position = Vector2(96,960)
	$Body1.position = Vector2(160,960)
	$Body2.position = Vector2(224,960)
	$Body3.position = Vector2(288,960)
	$Body4.position = Vector2(352,960)
	$Body5.position = Vector2(416,960)
	$Body6.position = Vector2(480,960)
	$Body7.position = Vector2(544,960)
	$Body8.position = Vector2(608,960)
	$Body9.position = Vector2(672,960)
	$Body10.position = Vector2(736,960)
	$Body11.position = Vector2(800,960)
	$Body12.position = Vector2(864,960)
	$Body13.position = Vector2(928,960)
	$Body14.position = Vector2(992,960)
	$Body15.position = Vector2(1056,960)
	$Body16.position = Vector2(1120,960)
	$Body17.position = Vector2(1120,896)
	$Body18.position = Vector2(1120,832)
	$Body19.position = Vector2(1120,768)

func BeginMove():
	#BEGIN TIMER
	$"../MoveTimer".wait_time = $"..".GetCurrentTime()
	$"../MoveTimer".start()

func _on_level_timer_timeout():
	#reset locations again
	$"../MoveTimer".stop()
	_ready()
