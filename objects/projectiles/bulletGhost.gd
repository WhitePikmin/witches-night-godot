extends MovableArea
class_name GhostBullet

var damage: int = 1;
var angle: float = 0;
var maxDistance: float = 3.0 * 250;

var distance = 60;
var x = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	speed = 5.0;
	delta = 1/Global.FPS_CAP;
	direction = direction.normalized();
	animate();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	
	var bodies: Array[Node2D] = get_overlapping_bodies();
	
	if bodies.size() > 0:
		for b in bodies:
			if b.has_method("takeAHit"):
				b.takeAHit(damage);
	
	x += (d * Global.FPS_CAP) * 0.04;
	
	if distance >= maxDistance:
		distance = maxDistance;
	else:
		distance += (d * Global.FPS_CAP);
	move();

func destroy():
	queue_free();

func move():
	var a = x + deg_to_rad(angle);
	position = Vector2(sin(a) * distance,cos(a) * distance);
	
	pass
