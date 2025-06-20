extends Node

var scores = []
var lastScore
var lastCollect
var lastTimer
var hasMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	#SET THIS NOW
	scores = [0,0,0,0,0,0,0,0,0,0]
	lastScore = 0
	lastCollect  = 0
	lastTimer = 0
	hasMusic = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SendNewScore(num):
	#ADD NEW NUM
	lastScore = num
	scores.append(num)
	#SORT
	scores.sort() #SORTS LOW TO HIGH!
	#REVERSE AND REMOVE LOWEST
	scores.pop_front()
	scores.reverse()

func SendResults(collected, time):
	lastCollect = collected
	lastTimer = snappedf(time, 0.01)

func GetScoreArray():
	return scores

func GetLastScore():
	return lastScore

func GetLastTimer():
	return lastTimer

func GetLastCollect():
	return lastCollect

func SetMusic():
	if hasMusic:
		hasMusic = false
	else:
		hasMusic = true

func GetMusic():
	return hasMusic
