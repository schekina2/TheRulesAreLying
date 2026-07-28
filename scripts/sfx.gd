extends Node

const MIX_RATE := 22050

func _make_tone(freq: float, duration: float, wave: String = "sine", volume: float = 0.5, fade_out: bool = true) -> AudioStreamWAV:
	var total_samples := int(MIX_RATE * duration)
	var data := PackedByteArray()
	data.resize(total_samples * 2)
	for i in total_samples:
		var t := float(i) / MIX_RATE
		var envelope := 1.0
		if fade_out:
			envelope = 1.0 - (float(i) / float(total_samples))
		var sample := 0.0
		match wave:
			"square":
				sample = 1.0 if sin(TAU * freq * t) >= 0.0 else -1.0
			"triangle":
				sample = asin(sin(TAU * freq * t)) * (2.0 / PI)
			_:
				sample = sin(TAU * freq * t)
		sample *= volume * envelope
		var value := int(clamp(sample, -1.0, 1.0) * 32767.0)
		data.encode_s16(i * 2, value)
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = MIX_RATE
	stream.stereo = false
	stream.data = data
	return stream

func _play_stream(stream: AudioStreamWAV, volume_db: float = 0.0) -> void:
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = volume_db
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)


func play_lie() -> void:
	_play_stream(_make_tone(180.0, 0.22, "square", 0.3), -4.0)


func play_success() -> void:
	_play_stream(_make_tone(523.0, 0.12, "sine", 0.4))
	await get_tree().create_timer(0.1).timeout
	_play_stream(_make_tone(784.0, 0.2, "sine", 0.4))

func play_game_over() -> void:
	_play_stream(_make_tone(220.0, 0.35, "triangle", 0.35))
	await get_tree().create_timer(0.2).timeout
	_play_stream(_make_tone(140.0, 0.5, "triangle", 0.35))

func play_click() -> void:
	_play_stream(_make_tone(660.0, 0.06, "sine", 0.25))
