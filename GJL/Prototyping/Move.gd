extends CharacterBody2D


var SPEED = 300.0
#const JUMP_VELOCITY = -400.0

var stopEven = preload("res://Entity_TileSets/FireflyF1.png")
var stopOdd = preload("res://Entity_TileSets/FireflyF2.png")
var upEven = preload("res://Entity_TileSets/FireflyW1.png")
var upOdd = preload("res://Entity_TileSets/FireflyW2.png")
var downEven = preload("res://Entity_TileSets/FireflyS1.png")
var downOdd = preload("res://Entity_TileSets/FireflyS2.png")
var leftEven = preload("res://Entity_TileSets/FireflyA1.png")
var leftOdd = preload("res://Entity_TileSets/FireflyA2.png")
var rightEven = preload("res://Entity_TileSets/FireflyD1.png")
var rightOdd = preload("res://Entity_TileSets/FireflyD2.png")
var even

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	SPEED = 300.0

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	var direction2 = Input.get_axis("up", "down")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction2:
		velocity.y = direction2 * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func SetSpeed(num):
	SPEED = num

func _process(delta):
	#THIS WORKS FOR DIRECTION CHANGE BUT ANIMATION DOESN"T WORK. KEEPING ANYWAY FOR NOW
	if velocity.y > 0:
		if posmod(snappedi($"../LevelTimer".wait_time, 1) , 4)  == 0:
			$Sprite2D.texture = downEven
		else:
			$Sprite2D.texture = downOdd
	elif velocity.y < 0:
		if posmod(snappedi($"../LevelTimer".wait_time, 1) , 4)  == 0:
			$Sprite2D.texture = upEven
		else:
			$Sprite2D.texture = upOdd
	elif velocity.x > 0:
		if posmod(snappedi($"../LevelTimer".wait_time, 1) , 4)  == 0:
			$Sprite2D.texture = rightEven
		else:
			$Sprite2D.texture = rightOdd
	elif velocity.x < 0:
		if posmod(snappedi($"../LevelTimer".wait_time, 1) , 4)  == 0:
			$Sprite2D.texture = leftEven
		else:
			$Sprite2D.texture = leftOdd
	else:
		if posmod(snappedi($"../LevelTimer".wait_time, 1) , 4)  == 0:
			$Sprite2D.texture = stopEven
		else:
			$Sprite2D.texture = stopOdd
