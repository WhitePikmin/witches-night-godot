extends Sprite2D

var n

# Called when the node enters the scene tree for the first time.
func _ready():
	n = 0
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		rotation_degrees = sin(n * 0.1) * 30
		n += 1
