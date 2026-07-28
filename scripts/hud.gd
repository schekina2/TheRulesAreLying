extends CanvasLayer

@onready var score_label: Label = $HUDLayout/ScoreLabel
@onready var time_label: Label = $HUDLayout/TimeLabel
@onready var game_over_label: Label = $GameOverLabel

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	game_over_label.visible = false
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.time_changed.connect(_on_time_changed)
	GameManager.game_over_triggered.connect(_on_game_over)
	_on_score_changed(GameManager.score)
	_on_time_changed(GameManager.time_left)

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score : %d" % new_score

func _on_time_changed(new_time: float) -> void:
	var m := int(new_time / 60.0)
	var s := int(new_time) % 60
	time_label.text = "Temps : %02d:%02d" % [m, s]

func _on_game_over() -> void:
	game_over_label.text = "GAME OVER\nScore final : %d\n\nAppuie sur R pour recommencer\nou sur M pour le menu" % GameManager.score
	game_over_label.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if not game_over_label.visible:
		return
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_R:
			GameManager.reset_game()
			game_over_label.visible = false
			get_tree().paused = false
			get_tree().call_deferred("change_scene_to_file", "res://level_1.tscn")
		elif event.keycode == KEY_M:
			GameManager.reset_game()
			game_over_label.visible = false
			get_tree().paused = false
			get_tree().call_deferred("change_scene_to_file", "res://main_menu.tscn")
