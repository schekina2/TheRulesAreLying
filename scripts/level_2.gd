extends Node2D

@onready var rule_label: Label = $UI/RuleBox/RuleLabel
@onready var player: CharacterBody2D = $Player
@onready var fake_zone: Area2D = $SafeLookingZone
@onready var real_zone: Area2D = $RedZone

var start_position: Vector2

func _ready() -> void:
	start_position = player.global_position
	rule_label.text = "La zone rouge brûle à l'œil. Le calme n'a jamais été un gage de sécurité."

	fake_zone.lie_discovered.connect(_on_lie_discovered)
	real_zone.true_exit_reached.connect(_on_true_exit_reached)

	Transition.fade_in()

func _on_lie_discovered() -> void:
	rule_label.text = "MENSONGE. -100 points, -10s. Le calme cachait le piège."
	player.global_position = start_position

func _on_true_exit_reached() -> void:
	rule_label.text = "Tu as trouvé la vraie sortie. +50 points."
