extends Enemy

const SHOOT_FREQUENCY = 60.0 * 3;
const MID_POINT = 540;

var shootCounter = 120.0;

const BULLET_PATH = "res://objects/bullet.tscn"
@onready var onScreenNotifier = $VisibleOnScreenNotifier2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	setSprite($AnimatedSprite2D);
	sprite.play("default",1.0,false);
	if global_position.y > MID_POINT:
		direction = Vector2(-0.8,-0.5).normalized();
	else:
		direction = Vector2(-0.8,0.5).normalized();
	speed = 4.0;
	HP = 5;
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	shootCounter += delta;
	if shootCounter >= SHOOT_FREQUENCY:
		shootCounter -= SHOOT_FREQUENCY;
		for i in range(0,4):
			var bulletInstance : Bullet = Utils.createObject("res://objects/projectiles/bullet.tscn",position + Vector2(-5.0,0.0));
			var x = deg_to_rad((i * 10) - 15);
			bulletInstance.setSpeed(6.0);
			bulletInstance.setDirection(Vector2(-cos(x),sin(x)));
	move();


func die():
	spawnStars(3);
	super();
	
	
func destroy():
	queue_free();
