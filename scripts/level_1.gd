extends Node2D

@onready var rule_label: Label = $UI/RuleBox/RuleLabel
@onready var player: CharacterBody2D = $Player
@onready var fake_door: Area2D = $Door
@onready var real_door: Area2D = $RealDoor

var start_position: Vector2

func _ready() -> void:
	start_position = player.global_position
	rule_label.text = "I am the color of the sky. But don't trust me to find the exit."
	GameManager.timer_active = true

	fake_door.lie_discovered.connect(_on_lie_discovered)
	real_door.true_exit_reached.connect(_on_true_exit_reached)

	Transition.fade_in()

func _on_lie_discovered() -> void:
	rule_label.text = "LIE. -100 points, -10s. Try again."
	player.global_position = start_position

func _on_true_exit_reached() -> void:
	rule_label.text = "You found the real exit. +50 points."
