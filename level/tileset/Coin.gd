extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Coin")

func _on_Coin_body_entered(body):
	if body.name == "SkeletalPlayer":
		if get_parent().name != "Level":
			get_parent().get_parent().get_node("GlobalAudio").play()
		else:
			get_parent().get_node("GlobalAudio").play()
		queue_free()
