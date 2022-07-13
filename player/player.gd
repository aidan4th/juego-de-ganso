class_name Player
extends KinematicBody2D

# Keep this in sync with the AnimationTree's state names and numbers.
enum States {
	IDLE = 0,
	WALK = 1,
	RUN = 2,
	FLY = 3,
	FALL = 4,
}

var speed = Vector2(120.0, 360.0)
var velocity = Vector2.ZERO
var falling_slow = false
var falling_fast = false
var no_move_horizontal_time = 0.0
var speedMod = 0
var modChange = 0.05
var speedM = 0
var screenTouched = false
var preloadedPlat = [preload("res://level/Levels/HasDip.tscn"), preload("res://level/Levels/Plain.tscn"), preload("res://level/Levels/VerticalLevl.tscn"), preload("res://level/Levels/ActuallyHardOne.tscn")]


onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		screenTouched = true
	else:
		screenTouched = false

func death():
	pass

func _ready():
	randomize()

func _physics_process(delta):
	velocity.y += gravity * delta
	if no_move_horizontal_time > 0.0:
		# After doing a hard fall, don't move for a short time.
		velocity.x = 0.0
		no_move_horizontal_time -= delta
	else:
		velocity.x = (1 + speedM) * speed.x
	#warning-ignore:return_value_discarded
	velocity = move_and_slide(velocity, Vector2.UP)
	# Calculate flipping and falling speed for animation purposes.
	if velocity.x > 0:
		pass
	elif velocity.x < 0:
		pass
	if velocity.y > 500:
		falling_fast = true
		falling_slow = false
	elif velocity.y > 300:
		falling_slow = true
	# Check if on floor and do mostly animation stuff based on it.
	if is_on_floor():
		if no_move_horizontal_time > 0:
			no_move_horizontal_time = no_move_horizontal_time -1
			if no_move_horizontal_time == 0:
				death()
		else:
			if velocity.x == 0:
				no_move_horizontal_time = 100ç
				
			if (Input.is_action_just_pressed("jump") or screenTouched):
				velocity.y = -speed.y
		if falling_fast:
			falling_fast = false
		elif falling_slow:
			falling_slow = false
		if abs(velocity.x) > 50:
			pass
		elif velocity.x:
			pass
		else:
			pass
	else:
		if velocity.y > 0:
			pass
		else:
			pass

func createNewLevel():
	var levelInstance = preloadedPlat[randi() % len(preloadedPlat)].instance()
	levelInstance.position = Vector2(get_parent().find_node("Ressetter").position.x + 1230,0)
	get_parent().call_deferred("add_child", levelInstance)
func _on_Ressetter_body_entered(body):
	if body.name == "SkeletalPlayer":
		createNewLevel()
		get_parent().find_node("Ressetter").translate(Vector2(830,0))
		speedMod = speedMod + modChange
		speedM = sqrt(speedMod)
		get_parent().get_node("CanvasLayer/Control/RichTextLabel").text = "puntaje: " + str(speedMod/modChange)


func _on_RessetterForTiles_body_exited(body):
	if body.name == "TileMap":
		body.queue_free()
