extends Node
class_name Background

var parallaxes: Array[ParallaxBackground];

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.background = self;
	
	var nodes = get_children();
	for n in nodes:
		if n is ParallaxBackground:
			parallaxes.push_back(n);

func moveBg(delta:Vector2):
	for p in parallaxes:
		p.scroll_base_offset += delta;
