extends "res://cutscene/code/character.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	X_OFFSET     = 64
	_init()
	pass # Replace with function body.


func _setdefaultPos():
	var width = texture.get_width()
	defaultPos = Vector2(1920 - (MARGIN + width),0)
