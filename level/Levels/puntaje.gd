extends Label



var hold = 0
var alpha = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if hold > 0:
		modulate.a -= 0.1 * delta

