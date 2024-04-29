extends PlayerState

class_name PlayerState_Damaged


func process(d):
	player.delta = d * Global.FPS_CAP;
	clampf(player.delta,1.0,2.0);

	player.direction = Vector2(-0.5,0.5);
	player.speed = 12.0;
	player.damageCounter -= player.delta;
	if player.damageCounter <= 0.0:
		player.changeSpriteFrame("default");
		player.damageCooldownTimer = player.DAMAGE_COOLDOWN_TIME;
		player.changeState(PlayerState_Normal.new());
	
	player.move();
	
	player.constantCounter += 1;
	
func takeAHit(hpLoss: int):
	pass
