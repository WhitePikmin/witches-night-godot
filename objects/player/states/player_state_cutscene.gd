extends PlayerState

class_name PlayerState_Cutscene

const TARGET = Vector2(200.0,500.0);

func process(d):

	player.delta = d * Global.FPS_CAP;
	clampf(player.delta,1.0,2.0);

	player.position.x = move_toward(player.position.x,TARGET.x,player.MAX_SPEED * player.delta);
	player.position.y = move_toward(player.position.y,TARGET.y,player.MAX_SPEED * player.delta);
	
	player.constantCounter += 1;