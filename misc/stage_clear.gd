class_name StageClearLabel extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(1,1,1,0.0);
	visible = false;
	Global.stageClearLabel = self;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func startAnimation():
	$AnimationPlayer.play("stage-clear-animation");
	visible = true;

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.goto_next_level();
