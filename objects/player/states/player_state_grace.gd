extends PlayerState_Normal

class_name PlayerState_Grace


func process(d):

	super(d);
	player.sprite.visible = (floori((player.damageGraceTimer.time_left * Global.FPS_CAP)/ 3) % 2 == 0);

func takeAHit(hpLoss: int):
	pass

func removeGracePeriod():
	player.sprite.visible = true;
	player.changeState(PlayerState_Normal.new());
