extends Enemy

const SHOOT_FREQUENCY = 60.0 * 0.8;
const MID_POINT = 540;
const BULLET_COUNT = 8;
const BULLET_ITER = (PI / BULLET_COUNT) * 2;

var shootCounter = 120.0;
var moving = true;
var shootIteration = 0;

const BULLET_PATH = "res://objects/bullet-patterns/complex-patterns/big_ghost_spell_1.tscn"
@onready var onScreenNotifier = $VisibleOnScreenNotifier2D;

var bulletPattern : Node = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	setSprite($AnimatedSprite2D);
	sprite.play("default",1.0,false);
	direction = Vector2(-1.0,0.0).normalized();
	HP = 30;
	shootCounter = SHOOT_FREQUENCY;
	speed = 15.0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	
	if (moving):
		if (speed <= 0):
			speed = 0;
			moving = false;
		else:
			speed -= 0.5;
	else:
		if (bulletPattern == null):
			bulletPattern = Utils.createObject(BULLET_PATH,position + Vector2(-95.0,-10.0));
	move();
	


func die():
	if bulletPattern != null:
		bulletPattern.queue_free();
	spawnStars(12);
	super();
	
	
func destroy():
	if bulletPattern != null:
		bulletPattern.queue_free();
	queue_free();
