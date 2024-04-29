extends AnimatedSprite2D

const SIZE = 3 * 16;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setChar(character:String):
	var c = character[0].to_upper().to_ascii_buffer()[0];
	if c > 32 and c < 91:
		visible = true;
		frame = c - 33;
	else:
		visible = false;
