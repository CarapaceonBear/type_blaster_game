extends Node2D

var thisColour
var wordDelay
var health
var speed
var direction = 1
onready var alienSprite = $Alien_Sprite

func _ready():
	get_parent().get_parent().connect("change_direction", self, "change_direction")
	get_parent().get_parent().connect("alien_killed", self, "die")

func setColour(colour):
	thisColour = colour

func initVariables():
	match thisColour:
		"beige":
			alienSprite.play("beige")
			wordDelay = 5
			health = 5
			speed = 2
		"green":
			alienSprite.play("green")
			wordDelay = 4
			health = 30
			speed = 3
		"pink":
			alienSprite.play("pink")
			wordDelay = 3
			health = 50
			speed = 4
		"blue":
			alienSprite.play("blue")
			wordDelay = 2
			health = 50
			speed = 6
		"yellow":
			alienSprite.play("yellow")
			wordDelay = 2
			health = 80
			speed = 8

func identify():
	print(thisColour)
	print(wordDelay)
	print(health)

func _process(delta):
	translate(Vector2((speed * direction), 0))

func change_direction():
	direction = -direction

func die():
#	temp
	queue_free()
