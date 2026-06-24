extends Panel

@export var motivate_button: Button 
@export var employee_name: Label
@export var employee_production: Label

var offer : EmployeeOffer = null
var time_hbox : HBoxContainer = null
var wheel : Node2D = null
var motivation_boost = false

func _ready() -> void:
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	wheel = get_tree().get_first_node_in_group("Wheel")
	
	time_hbox.hour_end.connect(_on_hour_end)
	motivate_button.pressed.connect(_on_motivate)
	time_hbox.day_end.connect(reset_motivation_boost)

func set_employee(employee_offer : EmployeeOffer):
	employee_name.text = employee_offer.employee_name
	employee_production.text = str(floor(employee_offer.employee_production * 100) / 100) + "W/h"
	offer = employee_offer
	
func _on_hour_end(hour : float):
	if hour < 6 or hour > 20: return
	wheel.wattage += offer.employee_production 
	if motivation_boost:
		wheel.wattage += offer.employee_production
	wheel.update_screen()
	
func _on_motivate():
	employee_production.text = str(floor(offer.employee_production * 2 * 100) / 100) + "W/h"
	GameManager.social_amount -= offer.motivation_needed
	motivate_button.disabled = true
	
func reset_motivation_boost():
	employee_production.text = str(floor(offer.employee_production * 100) / 100) + "W/h"
	motivate_button.disabled = false
	motivation_boost = false
	
