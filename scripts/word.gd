extends Node2D

class_name Word

var word
onready var letter = preload("res://scenes/letter.tscn")
var alive = true
var rng = RandomNumberGenerator.new()
signal change_score(amount)

func _init(givenWord):
	word = givenWord

func _ready():
	rng.randomize()
	var count = 0
	for character in word:
		spawn_letter(character, count)
		count += 1

func spawn_letter(whichLetter, index):
	var l = letter.instance()
	add_child(l)
	l.get_node("Label").text = whichLetter
	l.translate(Vector2((index * 20), 0))

func check_word(check):
	if check == word:
		alive = false
		var letters = get_children()
		for letter in letters:
			letter.get_node("Label").self_modulate = Color(1,0,0)
			letter.get_node("CollisionShape2D").disabled = true
			var randomForce = Vector2(rng.randf_range(-100, 100), rng.randf_range(-400, 0))
			letter.apply_central_impulse(randomForce)
		emit_signal("change_score", 20)
		yield(get_tree().create_timer(10), "timeout")
		queue_free()
