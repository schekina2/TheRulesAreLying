extends Area2D

@export var is_true_exit: bool = false
@export var next_level_path: String = ""
@export var penalty_points: int = 100
@export var penalty_time: float = 10.0
@export var bonus_points: int = 50

signal lie_discovered
signal true_exit_reached

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if is_true_exit:
		GameManager.add_bonus(bonus_points)
		SFX.play_success()
		true_exit_reached.emit()
		if next_level_path != "":
			Transition.change_scene(next_level_path)
	else:
		GameManager.apply_penalty(penalty_points, penalty_time)
		SFX.play_lie()
		lie_discovered.emit()
