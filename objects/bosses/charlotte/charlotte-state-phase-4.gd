extends BossState
class_name CharlotteState_Phase4

var stopped: bool = false;
var spell: Node = null;

const TARGET = Vector2(1700.0,1080.0 / 2.0);

var timer = 0;
const SHOOT_INTERVAL = 180;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveTowardsKeyPoint(boss.positionPointer);
	timer += 1;

func moveTowardsKeyPoint(pointIndex):
	if abs(TARGET - boss.position).length() > 3.0:
		stopped = false;
		boss.changeSpriteFrame("default");
		var dir = boss.position.direction_to(TARGET) * boss.MAX_SPEED;
		boss.position += dir;
	elif !stopped:
		boss.changeSpriteFrame("attacking");
		if(spell == null):
			spell = Utils.createObject("res://objects/bullet-patterns/complex-patterns/charlotte_spell_2.tscn",
			boss.position + Vector2(-95.0,-40.0));
		stopped = true;
		

func incrementPosition():
	pass
	
func _exit_tree():
	spell.queue_free();
