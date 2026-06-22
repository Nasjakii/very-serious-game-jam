extends Control


@export var exit_button: TextureButton
@export var spin_box: SpinBox

var bar_container_manager : Control = null

func _ready() -> void:
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	spin_box.value_changed.connect(_on_spin_box_value_changed)


func _on_exit_button_pressed():
	hide()

func _on_spin_box_value_changed(val : int):
	var test_amount = 10
	bar_container_manager.set_below_values(test_amount * val, test_amount * val, 0, 0)
	bar_container_manager.set_above_values(0, 0, -test_amount * val, -test_amount * val)
