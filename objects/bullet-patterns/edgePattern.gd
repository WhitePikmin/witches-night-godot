extends BasePattern
class_name EdgePattern

@export var BULLET_ASSET : String = "res://objects/projectiles/bullet.tscn";

@export var INTERVAL = 25;
@export var MAX_BURST_COUNT = -1;
@export var BULLET_PER_BURST = 4;
@export var SPEED = 5.0;

@export var bulletFunc = func(cycle,bul): 
	return (((bul + ((cycle % 3) * 0.33) ) * 1080) / BULLET_PER_BURST) + 40.0;

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
	var screenEdge = Utils.getScreenEdge();
	
	for i in range(0,BULLET_PER_BURST):
			var y = bulletFunc.call(burstCount,i);
			var bulletInstance : Bullet = Utils.createObject(BULLET_ASSET,
			Vector2(screenEdge + 3.0,y),Utils.CreateAt.ROOT );
			var x = Vector2(-1.0,0.0);
			
			bulletInstance.setMaxSpeed(SPEED);
			bulletInstance.setSpeed(SPEED);
			bulletInstance.setDirection(x);
	
	if MAX_BURST_COUNT > -1 and burstCount >= MAX_BURST_COUNT:
		self.queue_free();

