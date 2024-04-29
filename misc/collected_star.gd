extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var d = delta * Global.FPS_CAP;
	position.x = move_toward(position.x,Global.collectedStarTarget.x,30.0 * d);
	position.y = move_toward(position.y,Global.collectedStarTarget.y,30.0 * d);
	
	if abs(position.x - Global.collectedStarTarget.x) < 2.0:
		if abs(position.y - Global.collectedStarTarget.y) < 2.0:
			Global.starCount += 1;
			destroy();

func destroy():
	queue_free();
