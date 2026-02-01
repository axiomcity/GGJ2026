extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var anim_player: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal input
	var direction := Input.get_axis("ui_left", "ui_right")

	# Horizontal movement
	if direction != 0:
		velocity.x = direction * SPEED
		anim_player.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# --- Animation State Logic ---
	if not is_on_floor():
		if velocity.y < 0:
			if anim_player.animation != "jump":
				anim_player.play("jump")
		else:
			if anim_player.animation != "fall":
				anim_player.play("fall")
	elif direction != 0:
		if anim_player.animation != "run":
			anim_player.play("run")
	else:
		if anim_player.animation != "idle":
			anim_player.play("idle")

	# Move character
	move_and_slide()
