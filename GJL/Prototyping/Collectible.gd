extends Area2D

var collectSound = preload("res://Prototyping/collect.wav")
#LOCATIONS
var offScreen = Vector2(-200,-22)
var loc = [Vector2(240, 17), Vector2(191,611), Vector2(768,800), Vector2(675,517), Vector2(578,255), Vector2(975,80), Vector2(946,-177), Vector2(862,-130), Vector2(1010,-337), Vector2(430,48), Vector2(336,-272), Vector2(495,-369) ]

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = loc.pick_random()
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("Player") and $AudioStreamPlayer2D.playing:
		self.position = offScreen
		$"../UI_Sound".stream = collectSound
		$"../UI_Sound".play()
		$AudioStreamPlayer2D.stop()
		$"../HomeBase/AudioStreamPlayer2D".play()
