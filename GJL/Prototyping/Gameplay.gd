extends Node2D
#Variables -Sounds
var collectSound = preload("res://Prototyping/collect.wav")

#Variables - Location
var offScreen = Vector2(-200,-22)
var loc = [Vector2(240, 17), Vector2(191,611), Vector2(768,800), Vector2(675,517), Vector2(578,255), Vector2(975,80), Vector2(946,-177), Vector2(862,-130), Vector2(1010,-337), Vector2(430,48), Vector2(336,-272), Vector2(495,-369), Vector2(335,-432), Vector2(688,-433), Vector2(667,-95), Vector2(239,208), Vector2(867,254), Vector2(496,518), Vector2(961,527) ]
var mapOffScreen = Vector2(-2500,-2500)
var mapOnScreen = Vector2(0,0)
var currentMap

#Variables - Scoring
var playerScore;
var fruitCollected;
var fruitTarget;
var level;
const COL_MIN = 10 #Minimum score offered for collecting and returning an orb

#Variables - Timing
const FIRST_TIMER = 150
var mins
var secs
var milsecs
var timers = [30, 60, 90, 120, 150, 180, 240] #TIMES CASE CHOOSE FROM AFTER CERTIAN NUM LEVELS
var currentTime
var playing

#VARIABLES - TRACKING
var totalCollected
var totalTime

#SIGNALS
signal start_centipede

# Called when the node enters the scene tree for the first time.
func _ready():
	totalTime = 0
	#Set right map location
	$Maps/Map1.position = mapOnScreen
	$Maps/Map2.position = mapOffScreen
	$Maps/Map3.position = mapOffScreen
	$Maps/Map4.position = mapOffScreen
	$Maps/Map5.position = mapOffScreen
	#make collectible ready
	$Collectible.position = Vector2(191,611) #Start with a close one to gauge how to play
	$Collectible/AudioStreamPlayer2D.play()
	#make sure homebase is stopped
	$HomeBase/AudioStreamPlayer2D.stop()
	#reset player
	$Player.SetSpeed(300)
	playerScore = 0
	fruitCollected = 0
	totalCollected = 0
	fruitTarget = 4 #Starting point
	currentMap = 1
	level = 1
	#Update UI
	$UI/Fruit_txt2.text = "Fruit: " + str(fruitCollected) + "/" + str(fruitTarget)
	$UI/Score_txt.text = "Score: " + str(playerScore)
	$LevelTimer.wait_time = FIRST_TIMER
	currentTime = 150
	$LevelTimer.start()
	playing = true
	start_centipede.connect(_moveCentipede)
	start_centipede.connect($Centipede.BeginMove)
	start_centipede.connect($Centipede/Head.BeginMove)
	start_centipede.connect($Centipede/Body1.BeginMove)
	start_centipede.connect($Centipede/Body2.BeginMove)
	start_centipede.connect($Centipede/Body3.BeginMove)
	start_centipede.connect($Centipede/Body4.BeginMove)
	start_centipede.connect($Centipede/Body5.BeginMove)
	start_centipede.connect($Centipede/Body6.BeginMove)
	start_centipede.connect($Centipede/Body7.BeginMove)
	start_centipede.connect($Centipede/Body8.BeginMove)
	start_centipede.connect($Centipede/Body9.BeginMove)
	start_centipede.connect($Centipede/Body10.BeginMove)
	start_centipede.connect($Centipede/Body11.BeginMove)
	start_centipede.connect($Centipede/Body12.BeginMove)
	start_centipede.connect($Centipede/Body13.BeginMove)
	start_centipede.connect($Centipede/Body14.BeginMove)
	start_centipede.connect($Centipede/Body15.BeginMove)
	start_centipede.connect($Centipede/Body16.BeginMove)
	start_centipede.connect($Centipede/Body17.BeginMove)
	start_centipede.connect($Centipede/Body18.BeginMove)
	start_centipede.connect($Centipede/Body19.BeginMove)
	start_centipede.emit()

func GetCurrentTime():
	return currentTime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Update timer
	#minutes
	if $LevelTimer.time_left >= 60:
		mins = roundi($LevelTimer.time_left)/60
	else:
		mins = 0
	#seconds
	secs = roundi($LevelTimer.time_left - (mins * 60))
	#miliseconds
	milsecs = roundi(($LevelTimer.time_left - int($LevelTimer.time_left))*100)
	
	if secs < 10 and milsecs < 10:
		$UI/Time_txt3.text = "Time: " + str(mins) + ":0" + str(secs) + ":0" + str(milsecs)
	elif secs < 10:
		$UI/Time_txt3.text = "Time: " + str(mins) + ":0" + str(secs) + ":" + str(milsecs)
	elif milsecs < 10:
		$UI/Time_txt3.text = "Time: " + str(mins) + ":" + str(secs) + ":0" + str(milsecs)
	else:
		$UI/Time_txt3.text = "Time: " + str(mins) + ":" + str(secs) + ":" + str(milsecs)
	#$UI/Time_txt3.text = "Time: " + str(snapped($LevelTimer.time_left, 0.01))
	#Add to total time
	if playing:
		totalTime = totalTime + delta

func _on_collectible_body_entered(body):
	if body.is_in_group("Player") and $Collectible/AudioStreamPlayer2D.playing:
		#Affect Collectible
		$Collectible.position = offScreen
		$Collectible/AudioStreamPlayer2D.stop()
		#Affect home base
		$HomeBase/AudioStreamPlayer2D.play()
		#Affect score and UI
		playerScore = playerScore + COL_MIN
		$UI_Sound.stream = collectSound
		$UI_Sound.play()
		$UI/Score_txt.text = "Score: " + str(playerScore)

func _on_home_base_body_entered(body):
	if body.is_in_group("Player") and $HomeBase/AudioStreamPlayer2D.playing:
		#Affect the home base
		$HomeBase/AudioStreamPlayer2D.stop()
		#Affect the collectible
		$Collectible.position = loc.pick_random()
		$Collectible/AudioStreamPlayer2D.play()
		#Affect the UI and Score
		playerScore = playerScore + COL_MIN
		fruitCollected = fruitCollected + 1
		totalCollected = totalCollected + 1
		$UI_Sound.stream = collectSound
		$UI_Sound.play()
		$UI/Fruit_txt2.text = "Lvl: " + str(level) + " Fruit: " + str(fruitCollected) + "/" + str(fruitTarget)
		$UI/Score_txt.text = "Score: " + str(playerScore)
		#Affect the map
		_updateMaps()
		_updatePlayer()

func _updateTasks():
	#Called when timer runs out to change tasks
	match(level):
		#TIER ONE: 2:30 for 5-10 apples
		2:
			fruitTarget = 5
			$LevelTimer.wait_time = FIRST_TIMER
			currentTime = 150 
			$LevelTimer.start()
		3:
			fruitTarget = 7
			$LevelTimer.wait_time = FIRST_TIMER
			currentTime = 150        
			$LevelTimer.start()
		4:
			fruitTarget = 10
			$LevelTimer.wait_time = FIRST_TIMER
			currentTime = 150       
			$LevelTimer.start()
		#TIER TWO: 2:00 for 4-9 apples
		5:
			fruitTarget = 3
			$LevelTimer.wait_time = FIRST_TIMER - 30
			currentTime = 120
			$LevelTimer.start()
		6:
			fruitTarget = 5
			$LevelTimer.wait_time = FIRST_TIMER - 30
			currentTime = 120
			$LevelTimer.start()
		7:
			fruitTarget = 7
			$LevelTimer.wait_time = FIRST_TIMER - 30
			currentTime = 120
			$LevelTimer.start()
		8:
			fruitTarget = 9
			$LevelTimer.wait_time = FIRST_TIMER - 30
			currentTime = 120
			$LevelTimer.start()
		#TIER THREE: 1:30 for 3-8 apples
		9:
			fruitTarget = 2
			$LevelTimer.wait_time = FIRST_TIMER - 60
			currentTime = 90
			$LevelTimer.start()
		10:
			fruitTarget = 4
			$LevelTimer.wait_time = FIRST_TIMER - 60
			currentTime = 90
			$LevelTimer.start()
		11:
			fruitTarget = 6
			$LevelTimer.wait_time = FIRST_TIMER - 60
			currentTime = 90
			$LevelTimer.start()
		12:
			fruitTarget = 8
			$LevelTimer.wait_time = FIRST_TIMER - 60
			currentTime = 90
			$LevelTimer.start()
		#TIER FOUR: 1:00 for 2-7 apples
		13:
			fruitTarget = 1
			$LevelTimer.wait_time = FIRST_TIMER - 90
			currentTime = 60
			$LevelTimer.start()
		14:
			fruitTarget = 3
			$LevelTimer.wait_time = FIRST_TIMER - 90
			currentTime = 60
			$LevelTimer.start()
		15:
			fruitTarget = 5
			$LevelTimer.wait_time = FIRST_TIMER - 90
			currentTime = 60
			$LevelTimer.start()
		16:
			fruitTarget = 7
			$LevelTimer.wait_time = FIRST_TIMER - 90
			currentTime = 60
			$LevelTimer.start()
		#TIER FIVE: :30 for 1-6 apples
		17:
			fruitTarget = 1
			$LevelTimer.wait_time = FIRST_TIMER - 120
			currentTime = 30
			$LevelTimer.start()
		18:
			fruitTarget = 2
			$LevelTimer.wait_time = FIRST_TIMER - 120
			currentTime = 30
			$LevelTimer.start()
		19:
			fruitTarget = 4
			$LevelTimer.wait_time = FIRST_TIMER - 120
			currentTime = 30
			$LevelTimer.start()
		#TIER SIX: :15 for 1 apples
		20:
			fruitTarget = 1
			$LevelTimer.wait_time = FIRST_TIMER - 135
			currentTime = 15
			$LevelTimer.start()
	if level >= 21 and level < 50:
		currentTime = timers.pick_random()
		$LevelTimer.wait_time = currentTime
		#[30, 60, 90, 120, 150, 180, 240] TIMES CASE CHOOSE FROM AFTER CERTIAN NUM LEVELS
		match($LevelTimer.wait_time):
			30:
				fruitTarget = randi_range(1, 3)
			60:
				fruitTarget = randi_range(2, 6)
			90:
				fruitTarget = randi_range(3, 7)
			120:
				fruitTarget = randi_range(4, 8)
			150:
				fruitTarget = randi_range(5, 9)
			180:
				fruitTarget = randi_range(6, 10)
			240:
				fruitTarget = randi_range(7, 11)
		$LevelTimer.start()
	elif level >= 50:
		currentTime = timers.pick_random()
		$LevelTimer.wait_time = currentTime
		#[30, 60, 90, 120, 150, 180, 240] TIMES CASE CHOOSE FROM AFTER CERTIAN NUM LEVELS
		match($LevelTimer.wait_time):
			30:
				fruitTarget = 2
			60:
				fruitTarget = randi_range(4, 6)
			90:
				fruitTarget = randi_range(5, 7)
			120:
				fruitTarget = randi_range(6, 8)
			150:
				fruitTarget = randi_range(7, 9)
			180:
				fruitTarget = randi_range(8, 10)
			240:
				fruitTarget = randi_range(9, 11)
		$LevelTimer.start()
		#Trigger move for centipded
	start_centipede.emit()

func _updatePlayer():
	#Change Velocity - MIN [300] MAX [600]
	if playerScore > 6000:
		$Player.SetSpeed(600)
	if playerScore > 5500:
		$Player.SetSpeed(580)
	if playerScore > 5000:
		$Player.SetSpeed(560)
	elif playerScore > 4600:
		$Player.SetSpeed(540)
	elif playerScore > 4300:
		$Player.SetSpeed(520)
	elif playerScore > 4000:
		$Player.SetSpeed(500)
	elif playerScore > 3700:
		$Player.SetSpeed(480)
	elif playerScore > 3400:
		$Player.SetSpeed(460)
	elif playerScore > 3100:
		$Player.SetSpeed(440)
	elif playerScore > 2800:
		$Player.SetSpeed(420)
	elif playerScore > 2500:
		$Player.SetSpeed(400)
	elif playerScore > 2200:
		$Player.SetSpeed(380)
	elif playerScore > 1800:
		$Player.SetSpeed(360)
	elif playerScore > 1400:
		$Player.SetSpeed(340)
	elif playerScore > 1000:
		$Player.SetSpeed(330)
	elif playerScore > 600:
		$Player.SetSpeed(320)
	elif playerScore > 300:
		$Player.SetSpeed(310)

func _updateMaps():
	#Called after certain returns and scores to spice up gameplay
	#ADD: 5 New maps that only show up after 5000k points
	if playerScore >= 3200:
		#Remove prev map
		match(currentMap):
			1:
				$Maps/Map1.position = mapOffScreen
			2:
				$Maps/Map2.position = mapOffScreen
			3:
				$Maps/Map3.position = mapOffScreen
			4:
				$Maps/Map4.position = mapOffScreen
			5:
				$Maps/Map5.position = mapOffScreen
		currentMap = randi_range(1,5)
		#Get new map
		match(currentMap):
			1:
				$Maps/Map1.position = mapOnScreen
			2:
				$Maps/Map2.position = mapOnScreen
			3:
				$Maps/Map3.position = mapOnScreen
			4:
				$Maps/Map4.position = mapOnScreen
			5:
				$Maps/Map5.position = mapOnScreen
	elif playerScore >= 2300:
		#Update current map
		if currentMap >= 5:
			currentMap = 1
		else:
			currentMap = currentMap + 1
		match(currentMap):
			1:
				$Maps/Map5.position = mapOffScreen
				$Maps/Map1.position = mapOnScreen
			2:
				$Maps/Map1.position = mapOffScreen
				$Maps/Map2.position = mapOnScreen
			3:
				$Maps/Map2.position = mapOffScreen
				$Maps/Map3.position = mapOnScreen
			4:
				$Maps/Map3.position = mapOffScreen
				$Maps/Map4.position = mapOnScreen
			5:
				$Maps/Map4.position = mapOffScreen
				$Maps/Map5.position = mapOnScreen
	elif playerScore >= 2200:
		$Maps/Map4.position = mapOffScreen
		$Maps/Map5.position = mapOnScreen
		currentMap = 5
	elif playerScore >= 2100:
		$Maps/Map3.position = mapOffScreen
		$Maps/Map4.position = mapOnScreen
		currentMap = 4
	elif playerScore >= 2000:
		$Maps/Map2.position = mapOffScreen
		$Maps/Map3.position = mapOnScreen
		currentMap = 3
	elif playerScore >= 1900:
		$Maps/Map1.position = mapOffScreen
		$Maps/Map2.position = mapOnScreen
		currentMap = 2
	elif playerScore >= 1700:
		$Maps/Map5.position = mapOffScreen
		$Maps/Map1.position = mapOnScreen
		currentMap = 1
	elif playerScore >= 1400:
		$Maps/Map4.position = mapOffScreen
		$Maps/Map5.position = mapOnScreen
		currentMap = 5
	elif playerScore >= 1100:
		$Maps/Map3.position = mapOffScreen
		$Maps/Map4.position = mapOnScreen
		currentMap = 4
	elif playerScore >= 800:
		$Maps/Map2.position = mapOffScreen
		$Maps/Map3.position = mapOnScreen
		currentMap = 3
	elif playerScore >= 400:
		#Hide first map and show second
		$Maps/Map1.position = mapOffScreen
		$Maps/Map2.position = mapOnScreen
		currentMap = 2

func _on_level_timer_timeout():
	if fruitCollected >= fruitTarget:
		$UI_Sound.stream = collectSound
		$UI_Sound.play()
		#Subtract amount from collected to reset
		fruitCollected = fruitCollected - fruitTarget
		#Add Completion Score
		playerScore = playerScore + 10
		if fruitCollected >= (fruitTarget * 2):
			#player gets 10 completion points, plus 20 for triple+ bonus
			playerScore = playerScore + 40
		elif fruitCollected >= fruitTarget:
			#player gets 10 completion points, plus 10 for double bonus
			playerScore = playerScore + 20
		elif fruitCollected > 0:
			#player gets 10 completion points, plus 5 for having a few extra
			playerScore = playerScore + 15
		else:
			#player gets 10 completion points, nothing else
			playerScore = playerScore + 10
		#Add level score - multiples of five?
		_addLevelBonus()
		#UPDATE TARGETS IF NECESSARY
		level = level + 1
		_updateTasks()
		#Update UI
		$UI/Fruit_txt2.text = "Lvl: " + str(level) + " Fruit: " + str(fruitCollected) + "/" + str(fruitTarget)
		$UI/Score_txt.text = "Score: " + str(playerScore)
	else:
		#GAME OVER
		print("Game Over")

func _addLevelBonus():
	match(level):
		4:
			playerScore = playerScore + 20
		9:
			playerScore = playerScore + 40
		14:
			playerScore = playerScore + 60
		19:
			playerScore = playerScore + 80
		24:
			playerScore = playerScore + 100
		29:
			playerScore = playerScore + 120
		34:
			playerScore = playerScore + 140
		39:
			playerScore = playerScore + 160
		44:
			playerScore = playerScore + 180
		49:
			playerScore = playerScore + 200
		54:
			playerScore = playerScore + 225
		64:
			playerScore = playerScore + 250
		74:
			playerScore = playerScore + 275
		99:
			playerScore = playerScore + 300
		124:
			playerScore = playerScore + 350
		149:
			playerScore = playerScore + 400
		174:
			playerScore = playerScore + 450
		199:
			playerScore = playerScore + 500
	#IF MORE THAN THAT --> ADD BY MULTIPLES
	if level >= 300 and level % 50 == 0:
		playerScore = playerScore + 1000

func _moveCentipede():
	print("MOVE!")
	match(currentTime):
		15:
			pass
		30:
			pass
		60:
			pass
		90:
			pass
		120:
			pass 
		150:
			pass
		180: 
			pass
		240: 
			pass

func _resetCentipdede():
	#RESET CENTIPEDE LOCATIONS
	$Centipede/Head.position = Vector2(96, 960)
	$Centipede/Body1.position = Vector2(160, 960)
	$Centipede/Body2.position = Vector2(224, 960)

func _startCentipede(time):
	pass
