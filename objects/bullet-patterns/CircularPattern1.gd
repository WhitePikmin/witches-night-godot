extends BasePattern
class_name CircularPattern1

@export var BULLET_ASSET : PackedScene = preload("res://objects/projectiles/bullet.tscn");

@export var INTERVAL : int = 10;
@export var MAX_BURST_COUNT : int = 10;
@export var BULLET_PER_BURST : int = 10;

@export var bulletSpeed : float = 6.0;

@export var ALTERNATE : bool = false;

var frameCount = 0;
var burstCount = 0;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	frameCount += 1;
	
	if(frameCount % INTERVAL == 0):
		shoot();

func shoot():
	burstCount += 1;
	var posOffset = Vector2(0,0)
	if (Utils.railObject):
		posOffset = Utils.railObject.position;
		
	for i in range(0,BULLET_PER_BURST):
			var bulletInstance : Bullet = Utils.createObject(BULLET_ASSET.resource_path,
			global_position - posOffset);
			var factor = (float(i) / float(BULLET_PER_BURST) ) * PI * 2;
			if(ALTERNATE):
				if(burstCount % 2 == 1):
					factor += (0.5 / float(BULLET_PER_BURST) ) * PI * 2;
				
			var dir = Vector2(cos(factor),sin(factor));
			print(dir)
			
			bulletInstance.maxSpeed = bulletSpeed;
			bulletInstance.setSpeed(bulletSpeed);
			bulletInstance.setDirection(dir);
	
	if MAX_BURST_COUNT > -1 and burstCount >= MAX_BURST_COUNT:
		self.queue_free();

