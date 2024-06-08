extends Boss
class_name Charlotte

const MAX_SPEED = 5.0;

var positionPointer: int = 0;
@onready var positionTimer: Timer = $PositionTimer;

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready();
	starCount = 25;
	setSprite($AnimatedSprite2D);
	sprite.play("default",1.0,false);
	HP = 175;
	MAX_HP = HP;
	createPhaseSections(4,MAX_HP);
	sectionIndex = phaseSections.size() - 1;
	
	state = CharlotteState_Cutscene.new();
	state.setup(self);
	add_child(state);
	positionTimer.start();

func incrementPosition():
	state.incrementPosition();

func startHostility():
	positionTimer.start();
	changeState(CharlotteState_Phase1.new());
