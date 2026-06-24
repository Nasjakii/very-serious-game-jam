extends Node

var food_amount = 100 :
	set(value): 
		food_amount = value
		bar_container_manager.set_values(social_amount, energy_amount, water_amount, food_amount)
var food_amount_max = 100
var food_loss = 0.5

var energy_amount = 100 :
	set(value): 
		energy_amount = value
		bar_container_manager.set_values(social_amount, energy_amount, water_amount, food_amount)
var energy_amount_max = 100
var energy_loss = 0.25

var water_amount = 100 :
	set(value): 
		water_amount = value
		bar_container_manager.set_values(social_amount, energy_amount, water_amount, food_amount)
var water_amount_max = 100
var water_loss = 0.75

var social_amount = 100 : 
	set(value): 
		social_amount = value
		bar_container_manager.set_values(social_amount, energy_amount, water_amount, food_amount)
var social_amount_max = 100
var social_loss = 0.0

var update_timer = 0
var update_time = 1

var money : int = 0 : 
	get: 
		return money 
	set(value): 
		money = value
		money_rich_text_label.text = str(value)


var day = 0

var black_screen : ColorRect
var time_hbox : HBoxContainer
var energy_selling : Control
var bar_container_manager : Control
var wheel : Node2D
var money_rich_text_label : RichTextLabel
var hamster_busy = false

func _ready() -> void:
	money_rich_text_label = get_tree().get_first_node_in_group("MoneyRichTextLabel")
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	energy_selling = get_tree().get_first_node_in_group("EnergySelling")
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	time_hbox.day_end.connect(_on_day_end)
	black_screen = get_tree().get_first_node_in_group("BlackScreen")
	wheel = get_tree().get_first_node_in_group("Wheel")
	#black_screen.fade_in(3)
	#await black_screen.finished
	money_rich_text_label.text = str(money)
	
func _on_day_end():
	time_hbox.stop_timer = true
	
	day += 1
	
	energy_selling.change_prices()
	
	#TODO Day finishing screen, with results and everything
	
	black_screen.set_day(day)
	black_screen.fade_in(1)
	await black_screen.finished
	
	
	time_hbox.stop_timer = false


func _process(delta: float) -> void:
	update_timer += delta
	if update_timer >= update_time:
		update_timer -= update_time
	
		food_amount -= food_loss
		
		energy_amount -= energy_loss
		if wheel.running:
			energy_amount -= energy_loss * 5
		
		water_amount -= water_loss
	
		if energy_amount <= 0 || food_amount <= 0 || water_amount <= 0:
			faint()


func faint():
	time_hbox.stop_timer = true
	#fainting animation
	await get_tree().create_timer(3).timeout
	
	
	
	
