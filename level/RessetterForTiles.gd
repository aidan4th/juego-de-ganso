extends Area2D
var startingX = 0
onready var player = get_node("SkeltalPlayer")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	startingX = position.x
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = startingX + get_parent().get_node("SkeletalPlayer").position.x
