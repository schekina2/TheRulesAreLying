extends Control

@onready var play_button: Button = $Layout/PlayButton
@onready var how_to_play_button: Button = $Layout/HowToPlayButton
@onready var quit_button: Button = $Layout/QuitButton
@onready var instructions_panel: PanelContainer = $InstructionsPanel
@onready var close_instructions_button: Button = $InstructionsPanel/VBoxContainer/CloseInstructionsButton
@onready var title_label: Label = $Layout/TitleLabel

func _ready() -> void:
	instructions_panel.visible = false
	GameManager.reset_game()

	play_button.pressed.connect(_on_play_pressed)
	how_to_play_button.pressed.connect(_on_how_to_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	close_instructions_button.pressed.connect(_on_close_instructions_pressed)

	Transition.fade_in()
	_animate_title()

func _animate_title() -> void:
	var tween := create_tween()
	tween.set_loops()
	tween.tween_property(title_label, "modulate:a", 0.6, 1.4)
	tween.tween_property(title_label, "modulate:a", 1.0, 1.4)

func _on_play_pressed() -> void:
	SFX.play_click()
	Transition.change_scene("res://level_1.tscn")

func _on_how_to_play_pressed() -> void:
	SFX.play_click()
	instructions_panel.visible = true

func _on_quit_pressed() -> void:
	SFX.play_click()
	get_tree().quit()

func _on_close_instructions_pressed() -> void:
	SFX.play_click()
	instructions_panel.visible = false
