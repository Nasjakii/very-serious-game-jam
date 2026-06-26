extends Control

const DRINK_BUTTON = preload("uid://civdvpkok4x7c")
const WATER_BUTTON = preload("uid://cnappbbnr0uuh")


@export var drink_h_box_container: HBoxContainer
@export var exit_button: TextureButton
@export var drink_action_button : TextureButton
@export var progress_bar: ProgressBar
@export var audio_stream_player : AudioStreamPlayer

var energy_count = 0
var drink_buttons : Array[TextureButton]
var drink_selected : Consumable = null
var drink_button_selected : TextureButton

var bar_container_manager : Control = null

var drink_count_dictionary : Dictionary
var drink_button_dictionary : Dictionary
var drinking = false
var drink_duration = 1.0

func _ready() -> void:
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	hide()
	exit_button.pressed.connect(_on_exit_button_pressed)
	drink_action_button.pressed.connect(_on_drink_action_pressed)
	
	var water = Consumable.new()
	water.consumable_effect_drink = 10
	water.consumable_name = "Water"
	water.consumable_texture = WATER_BUTTON
	add_drink(water)
	drink_count_dictionary["Water"] = 10000000
	


func _on_exit_button_pressed():
	if drinking: return
	reset_selection()
	hide()
	GameManager.hamster_busy = false


func _on_drink_select(drink_button : TextureButton, drink_resource : Consumable):
	reset_selection()
	drink_button.material.set("shader_parameter/color", Color.WHITE)

	drink_selected = drink_resource
	drink_button_selected = drink_button

func _process(_delta: float) -> void:
	if drink_selected != null:
		bar_container_manager.set_below_values(drink_selected.consumable_effect_social, drink_selected.consumable_effect_energy, drink_selected.consumable_effect_drink, drink_selected.consumable_effect_food)
		
	
func add_drink(drink_resource : Consumable):

	if not drink_count_dictionary.has(drink_resource.consumable_name):
		
		drink_count_dictionary[drink_resource.consumable_name] = 1 #init count with 1
		
		
		#create drink button
		var drink_button = DRINK_BUTTON.instantiate()
		drink_button.texture_normal = drink_resource.consumable_texture
		drink_button.pressed.connect(_on_drink_select.bind(drink_button, drink_resource))
		drink_button.set_count(1)
		if drink_resource.consumable_name == "Water":
			drink_button.set_infinite()
		drink_h_box_container.add_child(drink_button)
		drink_button_dictionary[drink_resource.consumable_name] = drink_button
		drink_buttons.append(drink_button)
	else:
		var old_count = drink_count_dictionary[drink_resource.consumable_name]
		drink_count_dictionary[drink_resource.consumable_name] = old_count + 1 
		drink_button_dictionary[drink_resource.consumable_name].set_count(old_count + 1)
		
		

func reset_selection():
	drink_selected = null
	drink_button_selected = null
	bar_container_manager.set_below_values(-100, -100, -100, -100)
	
	for drink_button in drink_buttons:
		drink_button.material.set("shader_parameter/color", Color.TRANSPARENT)
		
func _on_drink_action_pressed():
	if drink_selected == null: return
	if drink_count_dictionary[drink_selected.consumable_name] <= 0: return
	if drinking: return
	
	drink_count_dictionary[drink_selected.consumable_name] -= 1
	drink_button_selected.set_count(drink_count_dictionary[drink_selected.consumable_name])
	
	GameManager.energy_amount += drink_selected.consumable_effect_energy
	GameManager.food_amount += drink_selected.consumable_effect_food
	GameManager.water_amount += drink_selected.consumable_effect_drink
	GameManager.social_amount += drink_selected.consumable_effect_social
	
	drinking = true
	audio_stream_player.play()
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "value", 1.0, drink_duration)
	tween.tween_callback(func(): 
		progress_bar.value = 0
		drinking = false
		audio_stream_player.stop()
	)
