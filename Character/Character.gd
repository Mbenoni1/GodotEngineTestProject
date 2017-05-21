extends Area

var SPEED_FORWARD = Global.SPEED
const SPEED_DEPTH = 1000
const SPEED_SIDE = 450
const SPRITE_SIZE = 50
const SIZE_MAP = 720
const DEPTH = 200

var side
var inputNode
var timer
var isDepthPossible = true
var areaNode
var timerCol
var allElements

func _ready():
	inputNode = get_node("../..")
	self.connect("area_enter", self, "on_area_enter")   #[BUG] Where signal is called

	#timer for not spamming depth level [NOT RELEVANT]
	timer = get_node("TimerDepth")
	timer.connect("timeout",self,"_on_timer_timeout")
	set_fixed_process(true)
	
func on_area_enter( area ):
	#[BUG]THIS IS WHERE TO LOOK
	if (area.get_groups()[0] == "Obstacles"):
		get_node("../Camera").shake(0.5,15,8)
		area._action()
	elif (area.get_groups()[0] == "End"):
		get_tree().change_scene("res://Menus/MainMenu/MainMenu.tscn")
	else:
		area._action()





##########################################################
###### [FOLLOWING ARE NOT RELEVANT FOR THE PROBLEM] ######
##########################################################

func _get_move():
	var move_SuperSolutec
	if((Input.is_action_pressed("gauche") == true) and Input.is_action_pressed("droite") == false):
		move_SuperSolutec = -1
	elif((Input.is_action_pressed("droite") == true) and Input.is_action_pressed("gauche") == false):
		move_SuperSolutec = 1
	else:
		move_SuperSolutec = 0
	return move_SuperSolutec

# CALLED FOR MOVING THE CHARACTER ON SCREEN.
func _fixed_process(delta):
	if(!Global.isMovingY && !Global.isTutorial):
		side = self._get_move()
		if(side == 2):
			side = 0
			if (isDepthPossible):
				isDepthPossible = false
				if(Global.isUp):
					Global.isMovingY = true
					Global.isUp = false
				else:
					Global.isMovingY = true
					Global.isUp = true
		if(self.get_transform().origin.x - SPRITE_SIZE < -SIZE_MAP/2): 
			if (side == -1):
				side = 0
		if(self.get_transform().origin.x + SPRITE_SIZE > SIZE_MAP/2):
			if(side == 1):
				side = 0
		self.translate(Vector3(side * SPEED_SIDE * delta, 0, -delta * SPEED_FORWARD))
	else:
		if(!Global.isUp):
			if(self.get_transform().origin.y > -DEPTH):
				global_translate(Vector3(0, -delta * SPEED_DEPTH, 0))
			else:
				Global.isMovingY = false
				timer.start()
		else:
			if(self.get_transform().origin.y < 0):
				global_translate(Vector3(0, delta * SPEED_DEPTH, 0))
			else:
				Global.isMovingY = false
				timer.start()

func _on_timer_timeout():
	isDepthPossible = true