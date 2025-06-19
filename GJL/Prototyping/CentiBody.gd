extends CharacterBody2D

#VARiables
var v15 = 343.0
var v30 = 172.0
var v60 = 85.5
var v90 = 57.0
var v120 = 43.0
var v150 = 34.0
var v180 = 28.0
var v240 = 21.0
var time
var origin

func _ready():
	origin = self.position

func _physics_process(delta):
	if self.position.x <= 32 and self.position.y == 960:
		self.position = Vector2(32,960)
		velocity.x = 0
		velocity.y = _getVelocity() * -1
	if self.position.x >= 1120 and self.position.y == -512:
		self.position = Vector2(1120,-512)
		velocity.x = 0
		velocity.y = _getVelocity()
	if self.position.x == 32 and self.position.y <= -512:
		self.position = Vector2(32,-512)
		velocity.x = _getVelocity()
		velocity.y = 0
	if self.position.x == 1120 and self.position.y >= 960:
		self.position = Vector2(1120,960)
		velocity.x = _getVelocity() * -1
		velocity.y = 0

	move_and_slide()

func BeginMove():
	self.position = origin
	time = $"../..".GetCurrentTime()
	if self.position.y == 960:
		velocity.x = _getVelocity() * -1
		velocity.y = 0
	elif self.position.x == 1120:
		velocity.x = 0
		velocity.y = _getVelocity()
	elif self.position.y == -512:
		velocity.x = _getVelocity()
		velocity.y = 0
	else:
		velocity.x = 0
		velocity.y = _getVelocity() * -1

func _getVelocity():
	match(time):
		15:
			return v15
		30:
			return v30
		60:
			return v60
		90:
			return v90
		120:
			return v120
		150:
			return v150
		180:
			return v180
		240:
			return v240

func _on_level_timer_timeout():
	velocity.x = 0
	velocity.y = 0
