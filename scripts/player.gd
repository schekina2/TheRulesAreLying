extends CharacterBody2D

@export var speed = 200
var locked: bool = false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

func _ready():
	add_to_group("player")
	GameManager.penalty_applied.connect(_on_penalty_applied)

func _physics_process(_delta):
	if locked:
		velocity = Vector2.ZERO
		move_and_slide()
		_update_animation(Vector2.ZERO)
		return

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

func _on_penalty_applied() -> void:
	_shake_camera()

func _shake_camera() -> void:
	var tween := create_tween()
	var strength := 8.0
	for i in 6:
		var offset := Vector2(randf_range(-strength, strength), randf_range(-strength, strength))
		tween.tween_property(camera, "offset", offset, 0.03)
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.03)
