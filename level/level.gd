extends Node2D

var score = 0

func _ready():
	for child in get_children():
		if child is Player:
			var camera = child.get_node(@"Camera2D")
