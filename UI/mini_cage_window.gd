extends Control

const EMPLOYEE_PANEL = preload("uid://b8ab4tuporgcw")

@export var exit_button: TextureButton

func _ready() -> void:

	hide()

	exit_button.pressed.connect(_on_exit_button_pressed)

func _on_exit_button_pressed():
	hide()
	GameManager.hamster_busy = false

func add_employee(employee_name : String):
	print(employee_name)
