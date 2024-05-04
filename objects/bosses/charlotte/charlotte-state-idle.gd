extends BossState
class_name CharlotteState_Idle

var keyPoints = [
	Vector2(1600.0,200.0),
	Vector2(1350.0,540.0),
	Vector2(1600.0,850.0),
	Vector2(1100.0,200.0),
	Vector2(950.0,540.0),
	Vector2(1100.0,850.0)
]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveTowardsKeyPoint(boss.positionPointer);

func moveTowardsKeyPoint(pointIndex):
	var TARGET = keyPoints[pointIndex];
	
	boss.position += boss.position.direction_to(TARGET) * boss.MAX_SPEED;

func incrementPosition():
	boss.positionPointer += 1;
	boss.positionPointer %= keyPoints.size();
