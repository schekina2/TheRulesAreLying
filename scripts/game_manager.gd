extends Node

signal score_changed(new_score: int)
signal time_changed(new_time: float)
signal game_over_triggered
signal penalty_applied
signal bonus_applied

var score: int = 1000
var time_left: float = 180.0
var game_over: bool = false
var timer_active: bool = false

func _process(delta: float) -> void:
	if game_over or not timer_active:
		return
	time_left = max(0.0, time_left - delta)
	time_changed.emit(time_left)
	if time_left <= 0.0 or score <= 0:
		trigger_game_over()

func apply_penalty(points: int, seconds: float) -> void:
	score = max(0, score - points)
	time_left = max(0.0, time_left - seconds)
	score_changed.emit(score)
	time_changed.emit(time_left)
	penalty_applied.emit()

func add_bonus(points: int) -> void:
	score += points
	score_changed.emit(score)
	bonus_applied.emit()

func trigger_game_over() -> void:
	if game_over:
		return
	game_over = true
	SFX.play_game_over()
	game_over_triggered.emit()
	get_tree().paused = true

func reset_game() -> void:
	score = 1000
	time_left = 180.0
	game_over = false
	timer_active = false
	get_tree().paused = false
