extends Node2D

@onready var rule_label: Label = $UI/RuleLabel
@onready var final_zone: Area2D = $FinalReveal

func _ready() -> void:
	rule_label.text = "RÈGLE : Ceci est la fin."
	final_zone.true_exit_reached.connect(_on_final_reveal)

func _on_final_reveal() -> void:
	rule_label.text = "MENSONGE. Il n'y a jamais eu de fin. Recommence, et regarde mieux."
	await get_tree().create_timer(3.0).timeout
	get_tree().call_deferred("change_scene_to_file", "res://level_1.tscn")
