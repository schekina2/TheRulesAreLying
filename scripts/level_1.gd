extends Node2D

@onready var rule_label: Label = $UI/RuleLabel
@onready var player: CharacterBody2D = $Player
@onready var fake_door: Area2D = $Door
@onready var real_door: Area2D = $RealDoor

var lie_revealed := false
var start_position: Vector2

func _ready() -> void:
	start_position = player.global_position
	rule_label.text = "RÈGLE : Cette porte est la sortie."

	real_door.visible = false
	real_door.monitoring = false
	real_door.monitorable = false

	fake_door.lie_discovered.connect(_on_lie_discovered)
	real_door.true_exit_reached.connect(_on_true_exit_reached)

func _on_lie_discovered() -> void:
	if lie_revealed:
		return
	lie_revealed = true
	rule_label.text = "MENSONGE. Ce n'était pas la sortie. Cherche encore."
	player.global_position = start_position
	real_door.visible = true
	real_door.monitoring = true
	real_door.monitorable = true

func _on_true_exit_reached() -> void:
	rule_label.text = "Tu as trouvé la vraie sortie."
