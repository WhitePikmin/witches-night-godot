extends Node
class_name Background

var parallaxes: Array[ParallaxBackground];
var fadeEffect: CanvasLayer;

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.background = self;
	fadeEffect = $FadeEffect;
	
	var nodes = get_children();
	for n in nodes:
		if n is ParallaxBackground:
			parallaxes.push_back(n);

func moveBg(delta:Vector2):
	for p in parallaxes:
		p.scroll_base_offset += delta;

func setFadeEffect(vis:bool):
	fadeEffect.visible = vis;
