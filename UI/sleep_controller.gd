extends Control


signal sleep_started


@export var exit_button: TextureButton
@export var spin_box: SpinBox
@export var sleep_button: TextureButton


var bar_container_manager : Control = null
var reset = false
var sleeping = false
var time_hbox : Control
var end_time = 0
var skip_amount = 0
var hour = 0


func _ready() -> void:
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	exit_button.pressed.connect(_on_exit_button_pressed)
	spin_box.value_changed.connect(_on_spin_box_value_changed)
	sleep_button.pressed.connect(_on_sleep_pressed)
	
	hour = time_hbox.half_day_length / 12
	
	hide()


func _on_exit_button_pressed():
	if sleeping: return
	hide()
	reset_selection()
	GameManager.hamster_busy = false

func _on_spin_box_value_changed(val : int):
	reset_selection()
	skip_amount = val
	
	
	bar_container_manager.set_below_values(GameManager.sleep_social_increase * val * hour, GameManager.sleep_energy_increase * val * hour, 0, 0)
	bar_container_manager.set_above_values(0, 0, -GameManager.water_loss * val * hour, -GameManager.food_loss * val * hour)

func _process(delta: float) -> void:
	
	if not sleeping and visible:
		reset = false
		bar_container_manager.set_below_values(GameManager.sleep_social_increase * skip_amount * hour, GameManager.sleep_energy_increase * skip_amount * hour, 0, 0)
		bar_container_manager.set_above_values(0, 0, -GameManager.water_loss * skip_amount * hour, -GameManager.food_loss * skip_amount * hour)
	elif reset == false:
		reset = true
		reset_selection()
	
	spin_box.editable = not sleeping
	

func _on_sleep_pressed():
	if sleeping: return
	reset_selection()
	sleeping = true
	sleep_started.emit()
	GameManager.sleep(skip_amount)
	
func reset_selection():
	bar_container_manager.set_below_values(-100, -100, -100, -100)
	bar_container_manager.set_above_values(-100, -100, -100, -100)
	
