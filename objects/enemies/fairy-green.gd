extends Enemy

const SHOOT_FREQUENCY = 60.0 * 0.8;
const MID_POINT = 540;
const BULLET_COUNT = 8;
const BULLET_ITER = (PI / BULLET_COUNT) * 2;

var shootCounter = 120.0;
var moving = true;
var shootIteration = 0;

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
	
	if (moving):
		if (speed <= 0):
			speed = 0;
			moving = false;
		else:
			speed -= 0.5;
	else:
		shootCounter += delta;
		if shootCounter >= SHOOT_FREQUENCY:
			shootCounter -= SHOOT_FREQUENCY;
			var cycle = ((shootIteration % 2) * (BULLET_ITER / 2)) + (BULLET_ITER / 3);
			for i in range(0,BULLET_COUNT):
				var bulletInstance : Bullet = Utils.createObject("res://objects/projectiles/bullet.tscn",position + Vector2(0.0,0.0));
				var x1 = (i * BULLET_ITER) + cycle;
				bulletInstance.setSpeed(6.0);
				bulletInstance.setDirection(Vector2(sin(x1),cos(x1)));
					
				get_tree().root.add_child(bulletInstance);
			shootIteration += 1;
	move();
	


func die():
	spawnStars(6);
	super();
	
	
func destroy():
	queue_free();
