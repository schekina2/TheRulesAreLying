extends Node2D

@onready var rule_label: Label = $UI/RuleLabel
@onready var player: CharacterBody2D = $Player
@onready var fake_door: Area2D = $Door
@onready var real_door: Area2D = $RealDoor

var start_position: Vector2

func _ready() -> void:
	start_position = player.global_position
	rule_label.text = "Je suis de la couleur du ciel. Mais ne te fie pas à moi pour trouver la sortie."

	fake_door.lie_discovered.connect(_on_lie_discovered)
	real_door.true_exit_reached.connect(_on_true_exit_reached)

func _on_lie_discovered() -> void:
	rule_label.text = "MENSONGE. -100 points, -10s. Réessaie."
	player.global_position = start_position

func _on_true_exit_reached() -> void:
	rule_label.text = "Tu as trouvé la vraie sortie."
