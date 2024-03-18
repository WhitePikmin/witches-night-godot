extends MovableArea
class_name Bullet

var visibilityNotifier: VisibleOnScreenNotifier2D;
var damage: int = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	
	delta = 1/Global.FPS_CAP;
	direction = direction.normalized();
	visibilityNotifier = $VisibleOnScreenNotifier2D;
	animate();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	
	var bodies: Array[Node2D] = get_overlapping_bodies();
	
	if bodies.size() > 0:
		for b in bodies:
			if b.has_method("takeAHit"):
				b.takeAHit(damage);
				impact();
	
	if(visibilityNotifier.is_on_screen()):
		move();
	else:
		queue_free();

func impact():
	destroy();

func destroy():
	queue_free();
