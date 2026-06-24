extends Control

const FOOD_BUTTON = preload("uid://hnf588011k0d")
const WATER_BUTTON = preload("uid://cnappbbnr0uuh")

@export var food_h_box_container: HBoxContainer
@export var exit_button: TextureButton
@export var food_action_button : TextureButton

var energy_count = 0
var food_buttons : Array[TextureButton]
var food_selected : Consumable = null
var food_button_selected : TextureButton

var bar_container_manager : Control = null

var food_count_dictionary : Dictionary
var food_button_dictionary : Dictionary

func _ready() -> void:
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	food_action_button.pressed.connect(_on_food_action_pressed)
	


func _on_exit_button_pressed():
	reset_selection()
	hide()
	GameManager.hamster_busy = false


func _on_food_select(food_button : TextureButton, food_resource : Consumable):
	reset_selection()
	food_button.material.set("shader_parameter/color", Color.WHITE)

	food_selected = food_resource
	food_button_selected = food_button

func _process(_delta: float) -> void:
	if food_selected != null:
		bar_container_manager.set_below_values(food_selected.consumable_effect_social, food_selected.consumable_effect_energy, food_selected.consumable_effect_drink, food_selected.consumable_effect_food)
		
	
func add_food(food_resource : Consumable):

	if not food_count_dictionary.has(food_resource.consumable_name):
		
		food_count_dictionary[food_resource.consumable_name] = 1 #init count with 1
		
		#create food button
		var food_button = FOOD_BUTTON.instantiate()
		food_button.texture_normal = food_resource.consumable_texture
		food_button.pressed.connect(_on_food_select.bind(food_button, food_resource))
		food_button.set_count(1)
		food_h_box_container.add_child(food_button)
		food_button_dictionary[food_resource.consumable_name] = food_button
		food_buttons.append(food_button)
	else:
		var old_count = food_count_dictionary[food_resource.consumable_name]
		food_count_dictionary[food_resource.consumable_name] = old_count + 1 
		food_button_dictionary[food_resource.consumable_name].set_count(old_count + 1)
		
		

func reset_selection():
	food_selected = null
	food_button_selected = null
	bar_container_manager.set_below_values(-100, -100, -100, -100)
	
	for food_button in food_buttons:
		food_button.material.set("shader_parameter/color", Color.TRANSPARENT)
		
func _on_food_action_pressed():
	if food_selected == null: return
	if food_count_dictionary[food_selected.consumable_name] <= 0: return
	
	food_count_dictionary[food_selected.consumable_name] -= 1
	food_button_selected.set_count(food_count_dictionary[food_selected.consumable_name])
	
	GameManager.energy_amount += food_selected.consumable_effect_energy
	GameManager.food_amount += food_selected.consumable_effect_food
	GameManager.water_amount += food_selected.consumable_effect_drink
	GameManager.social_amount += food_selected.consumable_effect_social
