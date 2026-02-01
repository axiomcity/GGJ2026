extends CharacterBody2D
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@onready var animation = $AnimatedSprite2D

#func _ready():
#	printing.call()
	
func printing():
	var variable = "ABC_BCA"
	print("jean michel")
	print(1, 2, 3, variable)

func _input(event):
	# Vérifiez si l'événement est un clic de souris
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			print("Attack")
			animation.play("attack")
		
	
#func _physics_process(delta: float) -> void:
func _process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor(): 
		velocity += get_gravity() * delta
		animation.play("idle")
	# JUMP
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# LEFT / RIGHT
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var direction := Input.get_axis("ui_left", "ui_right")
	if left:
		$AnimatedSprite2D.flip_h = true
		animation.play("walk") 
	if right:
		$AnimatedSprite2D.flip_h = false
		animation.play("walk")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
		if not animation.is_playing():
			animation.play("idle")
	pass

	move_and_slide()
