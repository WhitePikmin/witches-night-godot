extends Polygon2D

const TARGET_X_0 = -320
const TARGET_X_1 = -325

var STARTING_X_0;
var STARTING_X_1;

var DIFF_0;
var DIFF_1;

var health = 500;
var MAX_HEALTH;

# Called when the node enters the scene tree for the first time.
func _ready():
	STARTING_X_0 = polygon[0].x;
	STARTING_X_1 = polygon[1].x;
	
	DIFF_0 = STARTING_X_0 - TARGET_X_0;
	DIFF_1 = STARTING_X_1 - TARGET_X_1;
	
	MAX_HEALTH = health;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Global.Boss != null && visible):
		health = move_toward(health, float(Global.Boss.HP),1.0);
		updateBar();
	
func updateBar():
	var healthDisplay = clampf(health,0,MAX_HEALTH);
	polygon[0].x = TARGET_X_0 + (healthDisplay * ( DIFF_0 ) / MAX_HEALTH);
	polygon[1].x = TARGET_X_1 + (healthDisplay * ( DIFF_1 ) / MAX_HEALTH);
	
