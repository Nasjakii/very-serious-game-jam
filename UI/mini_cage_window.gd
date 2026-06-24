extends Control

const EMPLOYEE_PANEL = preload("uid://b8ab4tuporgcw")

@export var exit_button: TextureButton
@export var v_box_container: VBoxContainer

func _ready() -> void:

	hide()

	exit_button.pressed.connect(_on_exit_button_pressed)

func _on_exit_button_pressed():
	hide()
	GameManager.hamster_busy = false

func add_employee(employee_offer : EmployeeOffer):
	print(employee_offer.offer_name)
	var employee_panel = EMPLOYEE_PANEL.instantiate()
	employee_panel.set_employee(employee_offer)
	v_box_container.add_child(employee_panel)
