extends Node

####################################VARIABLES GLOBALES####################################

#Variables Gameplay
var score = 0
var multiplier = 1
var isMovingY = false
var isUp = true
const SPEED = 200

#Variables résolution/dimension
onready var viewport = get_viewport()
onready var name_OS = OS.get_name()
var minimum_size = Vector2(720, 1280)

#variables "sauvegarde" pour l'instant a voir ensuite 
var levelSelected = -1

#Variables globales internes
var isTutorial = false

var current_scene = null

####################################FONCTION DEMARRAGE####################################

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	
	viewport.connect("size_changed", self, "window_resize")
	var current_size = OS.get_window_size()
	if name_OS == "Windows":
		OS.set_window_size(current_size*0.9)
		window_center_position()
		OS.set_window_resizable(false)
	window_resize()

####################################FONCTIONS MAJ UI EN JEU####################################

func updateMultiplier(newMultiplier):
	multiplier=newMultiplier+multiplier

func updateScore(scorePoints):
	score=score+int(scorePoints*multiplier)
	
func resetMultiplier():
	multiplier=1

####################################FONCTIONS RESOLUTION ET DIMENSIONNEMENT####################################

# Appelée à chaque redimensionnement de la fenêtre de jeu
func window_resize():
	window_resize_UI()
	
# Permet de garder la taille des éléments de UI sur des résolutions différentes
func window_resize_UI():
	var current_size = OS.get_window_size()

	var scale_factor = minimum_size.y/current_size.y
	var new_size = Vector2(current_size.x*scale_factor, minimum_size.y)

	if new_size.y < minimum_size.y:
		scale_factor = minimum_size.y/new_size.y
		new_size = Vector2(new_size.x*scale_factor, minimum_size.y)
	if new_size.x < minimum_size.x:
		scale_factor = minimum_size.x/new_size.x
		new_size = Vector2(minimum_size.x, new_size.y*scale_factor)

	viewport.set_size_override(true, new_size)

# Centre la fenêtre selon l'axe X de l'écran
func window_center_position():
	var position = OS.get_window_position()
	var current_size = OS.get_window_size()
	var screen = OS.get_current_screen()
	var screen_size = OS.get_screen_size(screen)
	
	var new_x = screen_size.x/2
	new_x = new_x - current_size.x/2
	
	var new_y = screen_size.y/2
	new_y = new_y - current_size.y/2 * 1.1
	
	var new_position = Vector2(new_x,new_y)
	
	OS.set_window_position(new_position)
