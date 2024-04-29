extends PlayerState

class_name PlayerState_Damaged


func process(d):
	player.delta = d * Global.FPS_CAP;
	clampf(player.delta,1.0,2.0);

	player.direction = Vector2(-0.5,0.5);
	player.speed = 12.0;
	
	player.move();
	
	player.constantCounter += 1;
	
func takeAHit(hpLoss: int):
	pass

func unDamage():
	player.changeSpriteFrame("default");
	player.changeState(PlayerState_Grace.new());
	player.damageGraceTimer.start();
