extends Control

@onready var play_button: Button = $Layout/PlayButton
@onready var how_to_play_button: Button = $Layout/HowToPlayButton
@onready var quit_button: Button = $Layout/QuitButton
@onready var instructions_panel: PanelContainer = $InstructionsPanel
@onready var close_instructions_button: Button = $InstructionsPanel/VBoxContainer/CloseInstructionsButton
func _ready() -> void:
	instructions_panel.visible = false

	play_button.pressed.connect(_on_play_pressed)
	how_to_play_button.pressed.connect(_on_how_to_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	close_instructions_button.pressed.connect(_on_close_instructions_pressed)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")

func _on_how_to_play_pressed() -> void:
	instructions_panel.visible = true

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_close_instructions_pressed() -> void:
	instructions_panel.visible = false
