extends Enemy

const SHOOT_FREQUENCY = 60.0 * 3;
const MID_POINT = 540;
const BULLET_COUNT = 8;
const BULLET_ITER = (PI / BULLET_COUNT) * 2;
const LEAVE_AFTER = 60.0 * 8;

var shootCounter = 120.0;
var moving = true;
var leaving = false;
var shootIteration = 0;
var leaveTimer = 0;


const BULLET_PATH = "res://objects/bullet.tscn"
@onready var onScreenNotifier = $VisibleOnScreenNotifier2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	setSprite($AnimatedSprite2D);
	sprite.play("default",1.0,false);
	direction = Vector2(-1.0,0.0).normalized();
	HP = 10;
	shootCounter = SHOOT_FREQUENCY;
	speed = 15.0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	
	if (leaving):
		speed += 0.3;
	else:
		if (moving):
			if (speed <= 0):
				speed = 0;
				moving = false;
			else:
				speed -= 0.5;
		else:
			leaveTimer += delta;
			if(leaveTimer >= LEAVE_AFTER):
				leaving = true;
				direction = Vector2(-1.0,0.0).normalized();
			shootCounter += delta;
			if shootCounter >= SHOOT_FREQUENCY:
				shootCounter -= SHOOT_FREQUENCY;
				Utils.createObject("res://objects/projectiles/laser-sine.tscn",position - Vector2(9.0,-9.0));
	move();
	


func die():
	spawnStars(6);
	super();
	
	
func destroy():
	queue_free();
