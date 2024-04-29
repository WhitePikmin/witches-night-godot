extends Polygon2D

var fadeSpeed = 0.02
var opacity = 0
var targetOpacity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if targetOpacity != opacity:
		opacity += fadeSpeed * sign(targetOpacity - opacity)
		if opacity > 1:
			opacity = 1
		elif opacity < 0:
			opacity = 0
		color = Color(color.r,color.g,color.b,opacity)
	
func fadeInBlack():
	color = Color(0,0,0,0)
	opacity = 0
	targetOpacity = 1
	pass

func fadeOutBlack():
	color = Color(0,0,0,1)
	opacity = 1
	targetOpacity = 0
	pass

func finishedTransition():
	return targetOpacity == opacity
