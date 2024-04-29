extends Enemy

const SHOOT_FREQUENCY = 60.0 * 3;
const MID_POINT = 540;

var shootCounter = 120.0;
var x = 0;

const BULLET_PATH = "res://objects/bullet.tscn"
@onready var onScreenNotifier = $VisibleOnScreenNotifier2D;

# Called when the node enters the scene tree for the first time.
func _ready():
	setSprite($AnimatedSprite2D);
	sprite.play("default",1.0,false);
	direction = Vector2(-1,-0).normalized();
	x = PI / 2;
	speed = 4.0;
	HP = 15;
	#spawnOrbittingBullets();
	
func spawnOrbittingBullets():
	for i in range(0,4):
		var bullet = Utils.createObject("res://objects/projectiles/bulletGhost.tscn",Vector2(0,0),Utils.CreateAt.NONE);
		bullet.angle = i * 90;
		self.add_child(bullet);
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	super._process(d);
	
	direction = Vector2(-1.5,sin(x)).normalized();
	x += (d / Global.FPS_CAP) / 0.01;
	move();


func die():
	spawnStars(6);
	super();
	
	
func destroy():
	queue_free();
