extends MovableArea
class_name Item

var visibilityNotifier: VisibleOnScreenNotifier2D;
var damage: int = 1;
var pickableTimer: float = 50.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	
	delta = 1/Global.FPS_CAP;
	direction = Vector2(-0.5,-1.0);
	speed = 8.0;
	maxSpeed = 8.0;
	direction = direction.normalized();
	visibilityNotifier = $VisibleOnScreenNotifier2D;
	animate();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	
	pickableTimer -= d * Global.FPS_CAP;
			
	var bodies: Array[Node2D] = get_overlapping_bodies();
	
	if pickableTimer <= 0:
		if Global.Player != null:
			if global_position.distance_to(Global.Player.global_position) < 200.0:
				direction = Global.Player.global_position - global_position;
				direction = direction.normalized();
				speed = 17.0;
				maxSpeed = speed;
			
		if bodies.size() > 0:
			if bodies[0].has_method("collect"):
				bodies[0].collect();
				getCollected();
	
	if(visibilityNotifier.is_on_screen()):
		if (direction.y != -1.0):
			direction += Vector2(0.0,0.01);
		move();
	else:
		queue_free();



func getCollected():
	Utils.playSound("res://sounds/assets/sfx/snd_collectible.wav",position);
	Global.starCount += 1;
	Utils.createObject("res://misc/collected_star.tscn",position);
	destroy();

func destroy():
	queue_free();
