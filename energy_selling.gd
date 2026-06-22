extends Control

@export var h_box_container: HBoxContainer 
@export var exit_button: TextureButton
@export var sell_label: Label 

var progress_bars : Array[ProgressBar]

func _ready() -> void:
	hide()
	
	for child in h_box_container.get_children():
		progress_bars.append(child)
	
	var last_val = 0
	for bar in progress_bars:
		bar.max_value = 200
		bar.value = randi_range(0, 200)
		last_val = bar.value
	
	sell_label.text = str(int(last_val)) + "HB/W"
	
	exit_button.pressed.connect(_on_exit_button_pressed)
	
func _on_exit_button_pressed():
	hide()
