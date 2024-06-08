extends LineEdit

var currentConsoleHistory: int = Global.consoleHistory.size();
var consoleHistoryPointer: int = Global.consoleHistory.size();

# Called when the node enters the scene tree for the first time.
func _ready():
	set_deselect_on_focus_loss_enabled(false);
	set_focus_mode(FOCUS_ALL);
	grab_focus();
	Global.consoleHistory.append("");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
			consoleHistoryPointer -= 1;
			fetchHistory();
	
	if Input.is_action_just_pressed("ui_down"):
			consoleHistoryPointer += 1;
			fetchHistory();
	
	pass

func fetchHistory():
	consoleHistoryPointer = clamp(consoleHistoryPointer,0,Global.consoleHistory.size() - 1);
	text = Global.consoleHistory[consoleHistoryPointer];

func updateConsoleHistory(text:String):
	Global.consoleHistory[currentConsoleHistory] = text;

func executeCommand(command:String,param:String):
	match command:
		"kill":
			Global.PlayerHP = 0
			Global.Player.die();
		"kill_boss":
			if (Global.Boss != null):
				Global.Boss.HP = 0;
		"set_lives":
			var lives;
			if param.length() != 0:
				var l = float(param)
				Global.Lives = l;
		"refill_hp":
			Global.PlayerHP = Global.PLAYER_HP_MAX;
		"toggle_damage":
			Global.Player.invincible = ! Global.Player.invincible;
		"set_damage":
			if param == "on":
				Global.Player.invincible = false;
			elif param == "off":
				Global.Player.invincible = true;
		"start_cutscene":
			Utils.destroyAllEnemies();
			Global.Player.startCutscene();
	pass

func readConsole(text):
	if text == "":
		Global.consoleHistory.pop_back();
		Global.endConsole();
		return;
		
	var regex = RegEx.new();
	const PATTERN = "^(?<command>([a-z]|[A-Z]|[0-9]|_)+)(?<param> +([a-z]|[A-Z]|[0-9]|_)+)*";
	regex.compile(PATTERN);
	var result = regex.search(text);
	if result:
		var command = result.get_string("command");
		var param = result.get_string("param").replace(" ","");
			
		print(command);
		print(param);
		
		executeCommand(command,param);
	
	Global.endConsole();
