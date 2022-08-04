extends Node2D

var rng = RandomNumberGenerator.new()
onready var wordHandler = $Word_Handler
onready var spawn1 = $Spawn_01
onready var spawn2 = $Spawn_02
onready var spawn3 = $Spawn_03
onready var wordFile = "res://word_lists/wordlist.10000.txt"
var wordArray = []
onready var timer = $Timer
var cycle_time = 2
onready var inputBox = $Control/Input_Box
var input = []
var score = 0
onready var scoreBox = $Control/Score_Box
enum gameStates {START, PLAYING, END}
var currentState = gameStates.START
onready var endScreen = $End_screen
var lives = 3
onready var livesBox = $Control/Lives_Box
var i_frames = false

func _ready():
	endScreen.visible = false
	rng.randomize()
	load_file(wordFile)

func cycle():
	timer.wait_time = cycle_time
	timer.start()

func _on_Timer_timeout():
	var selectedWord = pick_random(wordArray)
	spawn_word(selectedWord)

func _process(delta):
	var inputString = array_to_string(input)
	inputBox.text = inputString
	scoreBox.text = str(score)
	livesBox.text = str(lives)

func _input(event):
	if currentState == gameStates.PLAYING:
		if event.is_action_pressed("a"):
			input.append("a")
		elif event.is_action_pressed("b"):
			input.append("b")
		elif event.is_action_pressed("c"):
			input.append("c")
		elif event.is_action_pressed("d"):
			input.append("d")
		elif event.is_action_pressed("e"):
			input.append("e")
		elif event.is_action_pressed("f"):
			input.append("f")
		elif event.is_action_pressed("g"):
			input.append("g")
		elif event.is_action_pressed("h"):
			input.append("h")
		elif event.is_action_pressed("i"):
			input.append("i")
		elif event.is_action_pressed("j"):
			input.append("j")
		elif event.is_action_pressed("k"):
			input.append("k")
		elif event.is_action_pressed("l"):
			input.append("l")
		elif event.is_action_pressed("m"):
			input.append("m")
		elif event.is_action_pressed("n"):
			input.append("n")
		elif event.is_action_pressed("o"):
			input.append("o")
		elif event.is_action_pressed("p"):
			input.append("p")
		elif event.is_action_pressed("q"):
			input.append("q")
		elif event.is_action_pressed("r"):
			input.append("r")
		elif event.is_action_pressed("s"):
			input.append("s")
		elif event.is_action_pressed("t"):
			input.append("t")
		elif event.is_action_pressed("u"):
			input.append("u")
		elif event.is_action_pressed("v"):
			input.append("v")
		elif event.is_action_pressed("w"):
			input.append("w")
		elif event.is_action_pressed("x"):
			input.append("x")
		elif event.is_action_pressed("y"):
			input.append("y")
		elif event.is_action_pressed("z"):
			input.append("z")
		elif event.is_action_pressed("backspace"):
			input.remove(input.size() - 1)
		elif event.is_action_pressed("enter"):
			var inputString = array_to_string(input)
			check_words(inputString)
			input.clear()
		elif event.is_action_pressed("escape"):
			show_end_screen()

func array_to_string(array):
	var string = ""
	for letter in array:
		string += letter
	return string

func load_file(file):
	var f = File.new()
	f.open(file, File.READ)
	while not f.eof_reached():
		var word = f.get_line()
		wordArray.append(word)
	f.close()

func pick_random(array):
	var randomValue = rng.randi_range(0, array.size())
	return array[randomValue]

func spawn_word(whichWord):
	var newWord = Word.new(whichWord)
	wordHandler.add_child(newWord)
	newWord.connect("change_score", self, "change_score")
	
	var randomSpawn = rng.randi_range(1, 3)
	match randomSpawn:
		1:
			newWord.global_position = spawn1.global_position
		2:
			newWord.global_position = spawn2.global_position
		3:
			newWord.global_position = spawn3.global_position

func check_words(input):
	var currentWords = wordHandler.get_children()
	for currentWord in currentWords:
		currentWord.check_word(input)

func change_score(amount):
	score += amount

func _on_MenuButton_pressed():
	$Control/MenuButton.visible = false
	cycle()
	currentState = gameStates.PLAYING

func show_end_screen():
	timer.stop()
	currentState = gameStates.END
	endScreen.visible = true
	inputBox.visible = false
	$End_screen/Final_Score.text = str(score)

func _on_Restart_Button_pressed():
	endScreen.visible = false
	inputBox.visible = true
	score = 0
	lives = 3
	cycle()
	currentState = gameStates.PLAYING

func _on_Area2D_body_entered(body):
	if not i_frames:
		i_frames = true
		if lives > 0:
			lives -= 1
		if lives == 0:
			show_end_screen()
		yield(get_tree().create_timer(1), "timeout")
		i_frames = false
