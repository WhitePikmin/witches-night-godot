extends RichTextLabel

var textRate = 1
var textTimer = 0
var run = true

@onready var parent: CanvasLayer = $"../../../.."
@onready var modulator: CanvasModulate = $"../../../CanvasModulate"
@onready var fadeOutTimer: Timer = $"../../../../FadeOutTimer"
@onready var fadeInTimer: Timer = $"../../../../FadeInTimer"

@onready var topBar: MeshInstance2D = $"../../../../TopBar";
@onready var bottomBar: MeshInstance2D = $"../../../../BottomBar";
var bottomBarY;
var topBarY;

var dataFile = "res://cutscene/script/testAct.json"
var nameText : RichTextLabel
var textPanel
var nameContainer
var data
var paragraphIndex = 0
var dialogueSystem : Control

var leftChar
var rightChar
var background
var starCursor
var musicPlayer
var fader
var parData : Dictionary

var transitionning = false
var trans_to_next = false



# Called when the node enters the scene tree for the first time.
func _ready():
	#DisplayServer.window_set_mode(4)
	visible_characters = 0
	nameText  = get_node("../../boxNameContainer/nameText")
	nameContainer = get_node("../../boxNameContainer")
	textPanel = get_node("../dialogueBox")
	starCursor = get_node("../StarCursor")
	
	leftChar 	= get_node("../../../stage/left_char")
	rightChar 	= get_node("../../../stage/right_char")
	background 	= get_node("../../../stage/background")
	musicPlayer = get_node("../../../stage/musicPlayer")
	fader       = get_node("../../../stage/fader")
	
	dialogueSystem = get_node("../../../dialogueSystem")
	
	var f = FileAccess.open(dataFile,FileAccess.READ)
	var jsonStr = f.get_as_text()
	
	data = JSON.parse_string(jsonStr)
	
	modulator.color = Color(1.0,1.0,1.0,0.0);
	fadeInTimer.start();
	
	topBarY = topBar.position.y;
	bottomBarY = bottomBar.position.y;
	
	
	_showNextParagraph()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !fadeInTimer.is_stopped():
		var opacity = (fadeInTimer.wait_time - fadeInTimer.time_left) / fadeInTimer.wait_time;
		modulator.color = Color(1.0,1.0,1.0,opacity);
		setBarsAnimation(opacity);
	
	if fadeOutTimer.is_stopped():
		if not transitionning:
			if (Input.is_action_just_pressed("shoot") || Input.is_action_pressed("skip_dialogue")):
				if visible_characters >= text.length():
					
					if 'trans_out' in parData.keys():
						if parData['trans_out'] == 'fade_black':
							fader.fadeInBlack()
							
						transitionning = true
						trans_to_next = true
						dialogueSystem.visible = false
					else:
						_showNextParagraph()
				else:
					visible_characters = text.length()
			
			if visible_characters >= text.length():
				starCursor.visible = true
			
			if run:
				textTimer += 1
				
				while textTimer >= textRate:
					textTimer -= textRate
					visible_characters += 1
		else:
			if fader.finishedTransition():
				if trans_to_next:
					_showNextParagraph()
					trans_to_next = false
				else:
					transitionning = false
					dialogueSystem.visible = true
	else:
		var opacity = fadeOutTimer.time_left / fadeOutTimer.wait_time;
		modulator.color = Color(1.0,1.0,1.0,opacity);
		setBarsAnimation(opacity);

func setBarsAnimation(value):
	var bottomMargin = get_viewport_rect().size.y - bottomBarY + (bottomBar.transform.get_scale().y / 2);
	topBar.position.y    = (topBar.transform.get_scale().y * value) - topBarY
	bottomBar.position.y = (bottomBarY + bottomMargin) - (bottomBar.transform.get_scale().y * value);
	

func _showNextParagraph():
	if paragraphIndex < data['dialogue'].size():
		parData = data['dialogue'][paragraphIndex]
		var parVals = parData.keys()
		starCursor.visible = false
		
		print(parVals)
		
		visible_characters = 0
		text = parData['message']
		
		if 'name' in parVals:
			_setupName(parData['name'])
		
		if 'left_char' in parVals:
			leftChar.setImage(parData['left_char'])
			
		if 'right_char' in parVals:
			rightChar.setImage(parData['right_char'])
		
		if 'trans_in' in parVals:
			if parData['trans_in'] == 'fade_black':
				fader.fadeOutBlack()

		#if 'back' in parVals:
		#		background.texture = load("res://images/backgrounds/" + parData['back'] + ".png")
		
		if 'speaker' in parVals:
			if parData['speaker'] == "left":
				leftChar.startSpeaking()
				rightChar.stopSpeaking()
			elif parData['speaker'] == "right":
				leftChar.stopSpeaking()
				rightChar.startSpeaking()
			else:
				leftChar.stopSpeaking()
				rightChar.stopSpeaking()
				
		if 'spawn_boss' in parVals:
			Utils.createBoss(parData['spawn_boss']);
			
		
		#if 'music' in parVals:
		#	if parData['music'] == "":
		#		musicPlayer.stopMusic()
		#	else:
		#		musicPlayer.setMusicPath("res://audio/music/" + parData['music'] + ".mp3")
		#		musicPlayer.playMusic()
		
		paragraphIndex += 1
	else:
		fadeOutTimer.start();


func _setupName(name):
	nameText.text = name
	if name.length() == 0:
		nameContainer.visible = false
		textPanel.roundLeftCorner(true)
		pass
	else:
		nameContainer.visible = true
		textPanel.roundLeftCorner(false)
		pass

func fadeOut():
	fadeOutTimer.start();
	pass

func endCutscene():
	Global.endCutscene();
	Utils.destroyFamily(parent);
	pass
