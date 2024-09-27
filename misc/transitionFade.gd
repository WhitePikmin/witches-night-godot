class_name TransitionFade extends ColorRect

var nextLevel : String;
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(0,0);
	Global.transitionFade = self;
	visible = true;
	animationPlayer.play("transition-in");
	pass # Replace with function body.


func endAnimation(anim_name: StringName):
	if(anim_name == "transition-out"):
		get_tree().change_scene_to_file(nextLevel);
	else:
		visible = false;

func fadeOut(target:String):
	nextLevel = target;
	animationPlayer.play("transition-out");
	visible = true;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
