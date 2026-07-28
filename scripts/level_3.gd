extends Node2D

@onready var rule_label: Label = $UI/RuleLabel
@onready var final_zone: Area2D = $FinalReveal

func _ready() -> void:
	rule_label.text = "This is the end. But an ending must be proven, not announced."
	final_zone.true_exit_reached.connect(_on_final_reveal)

func _on_final_reveal() -> void:
	rule_label.text = "CONGRATULATIONS. You understood: every rule here was a lie. Thanks for playing."
	GameManager.timer_active = false
