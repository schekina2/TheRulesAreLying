extends Node2D

@onready var rule_label: Label = $UI/RuleLabel
@onready var player: CharacterBody2D = $Player
@onready var fake_zone: Area2D = $SafeLookingZone
@onready var real_zone: Area2D = $RedZone

var lie_revealed := false
var start_position: Vector2

func _ready() -> void:
	start_position = player.global_position
	rule_label.text = "RÈGLE : La zone rouge est dangereuse."

	real_zone.visible = false
	real_zone.monitoring = false
	real_zone.monitorable = false

	fake_zone.lie_discovered.connect(_on_lie_discovered)
	real_zone.true_exit_reached.connect(_on_true_exit_reached)

func _on_lie_discovered() -> void:
	if lie_revealed:
		return
	lie_revealed = true
	rule_label.text = "MENSONGE. Le sol normal était le piège."
	player.global_position = start_position
	real_zone.visible = true
	real_zone.monitoring = true
	real_zone.monitorable = true

func _on_true_exit_reached() -> void:
	rule_label.text = "..."
