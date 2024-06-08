extends Node2D
class_name BasePattern

const BASE_BULLET = "res://objects/projectiles/bullet.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot():
	pass
	
func getTarget():
	var target;
	if (Global.Player != null):
		target = Global.Player.position;
	else:
		target = Vector2(0.0,1080.0 / 2.0);
	return target;
