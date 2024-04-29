extends AnimatedSprite2D



func _ready():
	play("default",1.0,false);

func destroy():
	print("end");
	queue_free();
