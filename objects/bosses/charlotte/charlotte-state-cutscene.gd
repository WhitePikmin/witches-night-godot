extends CharlotteState_Idle
class_name CharlotteState_Cutscene

const TARGET = Vector2(1700.0,1080.0 / 2.0);

func moveTowardsKeyPoint(pointIndex):
	boss.position += boss.position.direction_to(TARGET) * boss.MAX_SPEED;

func incrementPosition():
	boss.positionPointer = 0;
