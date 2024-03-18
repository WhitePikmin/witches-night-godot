extends Area2D
class_name HurtBox

var damage = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	var bodies: Array[Node2D] = get_overlapping_bodies();
	
	if bodies.size() > 0:
		if bodies[0].has_method("takeAHit"):
			bodies[0].takeAHit(damage);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
