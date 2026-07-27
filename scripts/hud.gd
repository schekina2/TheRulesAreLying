extends CanvasLayer

@onready var score_label: Label = $HUDLayout/ScoreLabel
@onready var time_label: Label = $HUDLayout/TimeLabel

func _ready() -> void:
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.time_changed.connect(_on_time_changed)
	_on_score_changed(GameManager.score)
	_on_time_changed(GameManager.time_left)

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score : %d" % new_score

func _on_time_changed(new_time: float) -> void:
	var m := int(new_time) / 60
	var s := int(new_time) % 60
	time_label.text = "Temps : %02d:%02d" % [m, s]
