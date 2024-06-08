extends BasePattern
class_name SpiralPattern1

@export var BULLET_ASSET : PackedScene = preload("res://objects/projectiles/bullet.tscn");

@export var INTERVAL : int = 10;
@export var MAX_BURST_COUNT : int = 30;
@export var BULLET_PER_BURST : int = 10;
@export var SPIN_SPEED : float = 10
@export var SWAYING : bool = false;

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
			var modifier
			if (SWAYING):
				modifier = sin((float(burstCount) / SPIN_SPEED) * PI * 0.5)
			else:
				modifier = (float(burstCount) / SPIN_SPEED)
			var factor = ((float(i) / float(BULLET_PER_BURST) ) * PI * 2) + modifier ;
				
			var dir = Vector2(cos(factor),sin(factor));
			print(dir)
			
			bulletInstance.maxSpeed = 6.0;
			bulletInstance.setSpeed(6.0);
			bulletInstance.setDirection(dir);
	
	if MAX_BURST_COUNT > -1 and burstCount >= MAX_BURST_COUNT:
		self.queue_free();

