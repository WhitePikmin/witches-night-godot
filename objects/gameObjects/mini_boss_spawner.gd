extends Node2D

@export var miniBoss: PackedScene;

var miniBossInstance : Node2D = null;
var listeningToEvent : bool = false;

@onready var tryAgainTimer: Timer = $TryAgain_timer;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn_mini_boss():
	Global.moveBg = false;
	miniBossInstance = miniBoss.instantiate();
	get_tree().root.add_child(miniBossInstance);
	miniBossInstance.position = Vector2(Utils.getScreenEdge() + 40, 1080 / 2);
	miniBossInstance.set_process(true);
	
	miniBossInstance.tree_exited.connect(on_mini_boss_destroyed)
	miniBossInstance.tree_entered.connect(func():
		Global.Boss = miniBossInstance;
	)
	
func on_mini_boss_destroyed():
	if(listeningToEvent):
		Global.moveBg = true;
		queue_free();
	else:
		listeningToEvent = true;
