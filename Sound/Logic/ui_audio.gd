extends AudioStreamPlayer

const CLICK = preload("uid://dua7loswafptk")
const WHOOSH = preload("uid://cwngijxkhsnik")
const FAINT_SOUND = preload("uid://dgkp4du22scgr")

func _ready() -> void:
	GameManager.fainting.connect(_on_fainting)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var randomizer = AudioStreamRandomizer.new()
		randomizer.add_stream(0, CLICK, 1)
		randomizer.random_volume_offset_db = 5
		randomizer.random_pitch_semitones = 0.1
		stream = randomizer
		volume_db = 0
		play()


func toggle_shop():
	stream = WHOOSH
	volume_db = -5
	play()

func _on_fainting():
	stream = FAINT_SOUND
	play()
