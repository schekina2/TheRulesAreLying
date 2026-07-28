extends Node2D

@onready var rule_label: Label = $UI/RuleBox/RuleLabel
@onready var final_zone: Area2D = $FinalReveal

func _ready() -> void:
	rule_label.text = "Ceci est la fin. Mais une fin, ça se prouve, ça ne s'annonce pas."
	final_zone.true_exit_reached.connect(_on_final_reveal)
	Transition.fade_in()

func _on_final_reveal() -> void:
	rule_label.text = "MENSONGE. Il n'y a jamais eu de fin. Recommence, et regarde mieux."
	await get_tree().create_timer(2.5).timeout
	Transition.change_scene("res://level_1.tscn")
