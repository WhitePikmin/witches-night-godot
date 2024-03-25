extends Area2D
class_name MovableArea

@export var speed: float = 5.0;
@export var direction: Vector2 = Vector2(-1.0,0.0);
@export var acceleration: float = 0.0;

@export var maxSpeed: float = 5.0;

var velocity: Vector2;
var delta: float;

# Called when the node enters the scene tree for the first time.
func _ready():
	delta = 1/Global.FPS_CAP;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	delta = d * Global.FPS_CAP;

func move():
	velocity = direction * speed * delta;
	speed += acceleration;
	speed = minf(speed,maxSpeed);
	translate(velocity);

func animate():
	var spr = $AnimatedSprite2D;
	if spr != null:
		spr.play(spr.animation,1.0,false)

func setDirection(dir: Vector2):
	direction = dir.normalized();

func setSpeed(spd: float):
	speed = spd;
	
func setMaxSpeed(spd: float):
	maxSpeed = spd;
	
func setAcceleration(dir: float):
	acceleration = dir;
