extends Sprite2D

var defaultPos : Vector2

var X_OFFSET     = -64
var Y_OFFSET     = 64
var COLOR_OFFSET = 0.5

var MARGIN = 16

var speaking
var targetPos
var targetColor
var speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	_init()
	scale.x = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var i = 0
	while targetPos != position:
		position += Vector2(sign(targetPos.x - position.x),sign(targetPos.y - position.y))
		i += 1
		if i >= speed:
			break

func _init():
	speaking = false
	setImage("")
	_setdefaultPos()
	stopSpeaking()
	position = targetPos

func _setdefaultPos():
	var width = texture.get_width()
	defaultPos = Vector2(MARGIN + width,0)

func setImage(path:String):
	if(path == ""):
		visible = false
	else:
		texture = load("res://images/characters/" + path + ".png")
		visible = true
	
func startSpeaking():
	targetPos = Vector2(defaultPos.x,defaultPos.y)
	modulate = Color(1,1,1)
	
func stopSpeaking():
	targetPos = Vector2(defaultPos.x + X_OFFSET,defaultPos.y + Y_OFFSET)
	modulate = Color(COLOR_OFFSET,COLOR_OFFSET,COLOR_OFFSET)
