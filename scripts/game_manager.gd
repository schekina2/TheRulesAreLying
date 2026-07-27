extends Node

signal score_changed(new_score: int)
signal time_changed(new_time: float)

var score: int = 1000
var time_left: float = 180.0
var game_over: bool = false

func _process(delta: float) -> void:
	if game_over:
		return
	time_left = max(0.0, time_left - delta)
	time_changed.emit(time_left)
	if time_left <= 0.0:
		game_over = true

func apply_penalty(points: int, seconds: float) -> void:
	score = max(0, score - points)
	time_left = max(0.0, time_left - seconds)
	score_changed.emit(score)
	time_changed.emit(time_left)

func add_bonus(points: int) -> void:
	score += points
	score_changed.emit(score)
