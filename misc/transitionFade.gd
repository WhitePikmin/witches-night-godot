class_name TransitionFade extends ColorRect

var nextLevel : String;
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.transitionFade = self;
	visible = true;
	animationPlayer.current_animation = "fade-in";
	animationPlayer.play("fade-in");
	print("Fade in")
	pass # Replace with function body.


func endAnimation(anim_name: StringName):
	if(anim_name == "fade-out"):
		print("Next level");
		get_tree().change_scene_to_file(nextLevel);
	else:
		visible = false;

func fadeOut(target:String):
	nextLevel = target;
	animationPlayer.play("fade-out");
	visible = true;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
