extends Node2D

@onready var EmptyBar = $Empty;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Global.Boss != null):
		if(!visible && Global.HUD.visible):
			EmptyBar.MAX_HEALTH = Global.Boss.HP;
			EmptyBar.health = 0;
			print(EmptyBar.health);
			visible = true;
	else:
		visible = false;
	pass
