extends CharacterBody2D

@export var speed = 200

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	add_to_group("player")

func _physics_process(_delta):

	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	if Input.is_action_pressed("ui_left"):
		direction.x -= 1

	if Input.is_action_pressed("ui_down"):
		direction.y += 1

	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	velocity = direction.normalized() * speed

	move_and_slide()

	_update_animation(direction)

func _update_animation(direction: Vector2) -> void:
	if direction.length() > 0:
		anim.play("walk")
		if direction.x != 0:
			anim.flip_h = direction.x < 0
	else:
		anim.play("idle")
