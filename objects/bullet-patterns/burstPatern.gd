extends BasePattern
class_name BurstPattern

@export var BULLET_ASSET : String = "res://objects/projectiles/bullet.tscn";

@export var INTERVAL = 3;
@export var MAX_BURST_COUNT = 12;
@export var BULLET_PER_BURST = 4;
@export var SPEED = 12.0;

var frameCount = 0;
var burstCount = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frameCount += 1;
	
	if(frameCount % INTERVAL == 0):
		shoot();

func shoot():
	burstCount += 1;
	var target = getTarget();
	
	for i in range(0,BULLET_PER_BURST):
			var bulletInstance : Bullet = Utils.createObject(BULLET_ASSET,
			position + Vector2(-5.0,0.0));
			var x = position.direction_to(target + Vector2(randf_range(-30,30),randf_range(-30,30)));
			
			bulletInstance.setMaxSpeed(SPEED);
			bulletInstance.setSpeed(SPEED);
			bulletInstance.setDirection(x);
	
	if MAX_BURST_COUNT > -1 and burstCount >= MAX_BURST_COUNT:
		self.queue_free();

