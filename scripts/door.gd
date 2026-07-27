extends Area2D

## Porte réutilisable pour toutes les salles.
## is_true_exit = false -> c'est un mensonge : elle ne mène nulle part
## is_true_exit = true  -> c'est la vraie sortie : elle change de niveau
@export var is_true_exit: bool = false
@export var next_level_path: String = ""

signal lie_discovered
signal true_exit_reached

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if is_true_exit:
		true_exit_reached.emit()
		if next_level_path != "":
			get_tree().change_scene_to_file(next_level_path)
	else:
		lie_discovered.emit()
