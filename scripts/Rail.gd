extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Utils.railObject = self;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	var delta = Global.FPS_CAP * d;
	position.x += Global.SCREEN_SCROLL_SPEED * delta;
