extends Control


@export var exit_button: TextureButton
@export var spin_box: SpinBox
@export var sleep_button: TextureButton


var bar_container_manager : Control = null
var reset = false
var sleeping = false
var time_hbox : Control
var end_time = 0
var skip_amount = 0

func _ready() -> void:
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	spin_box.value_changed.connect(_on_spin_box_value_changed)
	sleep_button.pressed.connect(_on_sleep_pressed)


func _on_exit_button_pressed():
	if sleeping: return
	hide()
	GameManager.hamster_busy = false

func _on_spin_box_value_changed(val : int):
	skip_amount = val
	

func _on_sleep_pressed():
	if sleeping: return
	sleeping = true
	GameManager.sleep(skip_amount)
	
