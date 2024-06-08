extends BossState
class_name CharlotteState_Phase3

var stopped: bool = false;
var keyPoints = [
	Vector2(1600.0,200.0),
	Vector2(1350.0,540.0),
	Vector2(1600.0,850.0),
	Vector2(1100.0,200.0),
	Vector2(950.0,540.0),
	Vector2(1100.0,850.0)
]

var timer = 0;
const SHOOT_INTERVAL = 180;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveTowardsKeyPoint(boss.positionPointer);
	timer += 1;
	if(boss.HP < boss.phaseSections[boss.sectionIndex]):
		boss.sectionIndex -= 1;
		boss.changeState(CharlotteState_Phase4.new());
		pass
		

func moveTowardsKeyPoint(pointIndex):
	var TARGET = keyPoints[pointIndex];
	if abs(TARGET - boss.position).length() > 3.0:
		stopped = false;
		boss.changeSpriteFrame("default");
		var dir = boss.position.direction_to(TARGET) * boss.MAX_SPEED;
		boss.position += dir;
	elif !stopped:
		boss.changeSpriteFrame("attacking");
		var pattern = Utils.createObject("res://objects/bullet-patterns/circular_pattern_1.tscn",boss.position + Vector2(-95.0,-40.0));
		pattern.INTERVAL = 5;
		pattern.bulletSpeed = 9.0;
		stopped = true;
		

func incrementPosition():
	boss.positionPointer += 1;
	boss.positionPointer %= keyPoints.size();
