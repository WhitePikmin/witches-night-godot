extends Panel
var style

# Called when the node enters the scene tree for the first time.
func _ready():
	style = get_theme_stylebox("panel")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func roundLeftCorner(round):
	if round:
		style.corner_radius_top_left = 30
	else:
		style.corner_radius_top_left = 0
