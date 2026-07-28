extends Node2D

@onready var rule_label: Label = $UI/RuleBox/RuleLabel
@onready var player: CharacterBody2D = $Player
@onready var fake_zone: Area2D = $SafeLookingZone
@onready var real_zone: Area2D = $RedZone

var start_position: Vector2

func _ready() -> void:
	start_position = player.global_position
	rule_label.text = "The red zone burns the eye. Calm was never a guarantee of safety."

	fake_zone.lie_discovered.connect(_on_lie_discovered)
	real_zone.true_exit_reached.connect(_on_true_exit_reached)

	Transition.fade_in()

func _on_lie_discovered() -> void:
	rule_label.text = "LIE. -100 points, -10s. Calm was hiding the trap."
	player.global_position = start_position

func _on_true_exit_reached() -> void:
	rule_label.text = "You found the real exit. +50 points."
