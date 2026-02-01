extends CharacterBody2D
const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@onready var animation = $AnimatedSprite2D

func _ready():
	animation.connect("animation_finished", self, "_on_finished")
	
func _input(event):
	# Attack
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			animation.play("attack")

# finish animation
func _on_finished(name: String):
	print("Finished ", name)
	
#func _physics_process(delta: float) -> void:
func _process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor(): 
		velocity += get_gravity() * delta
		animation.play("idle")
	# JUMP
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("jump") 
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
		if not animation.animation_looped:
			animation.play("idle")

	move_and_slide()
