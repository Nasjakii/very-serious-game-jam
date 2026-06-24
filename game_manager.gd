extends Node

var food_amount = 100 :
	set(value): 
		food_amount = min(value, food_amount_max)
		bar_container_manager.set_values(social_amount, energy_amount, water_amount, food_amount)
var food_amount_max = 100
var food_loss = 0.5

var energy_amount = 100 :
	set(value): 
		energy_amount = min(value, energy_amount_max)
		bar_container_manager.set_values(social_amount, energy_amount, water_amount, food_amount)
var energy_amount_max = 100
var energy_loss = 0.25

var water_amount = 100 :
	set(value): 
		water_amount = min(value, water_amount_max)
		bar_container_manager.set_values(social_amount, energy_amount, water_amount, food_amount)
var water_amount_max = 100
var water_loss = 0.75

var social_amount = 100 : 
	set(value): 
		social_amount = min(value, social_amount_max)
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
var sleep_control : Control
var sleep_duration = 0
var sleep_start = 0

func _ready() -> void:
	sleep_control = get_tree().get_first_node_in_group("SleepController")
	money_rich_text_label = get_tree().get_first_node_in_group("MoneyRichTextLabel")
	bar_container_manager = get_tree().get_first_node_in_group("BarContainerManager")
	energy_selling = get_tree().get_first_node_in_group("EnergySelling")
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	time_hbox.day_end.connect(_on_day_end)
	black_screen = get_tree().get_first_node_in_group("BlackScreen")
	wheel = get_tree().get_first_node_in_group("Wheel")
	money_rich_text_label.text = str(money)
	
func _on_day_end():
	time_hbox.stop_timer = true
	
	day += 1
	
	energy_selling.change_prices()
	
	black_screen.set_day(day)
	black_screen.fade_in(1)


func _process(delta: float) -> void:
	
	if time_hbox.stop_timer == false:
		if sleep_duration > 0:
			sleep_duration -= delta * 5
			update_timer += delta * 4 #4x speed
			time_hbox.timer += delta * 4
		elif sleep_control.sleeping:
			sleep_control.sleeping = false
			
		update_timer += delta
		
	if update_timer >= update_time:
		update_timer -= update_time
	
		food_amount -= food_loss
		
		energy_amount -= energy_loss
		if wheel.running:
			energy_amount -= energy_loss * 5
		if sleep_control.sleeping:
			energy_amount += energy_loss * 4
			social_amount += energy_loss * 3
			
		water_amount -= water_loss
	
		if energy_amount <= 0 || food_amount <= 0 || water_amount <= 0:
			faint()


func faint():
	time_hbox.stop_timer = true
	#fainting animation
	time_hbox.timer = time_hbox.half_day_length * 2
	energy_amount = 10
	food_amount = 10
	water_amount = 10
	social_amount = 10
	black_screen.sleep_label.text = "You fainted, and slept poorly..."
	
	#cancel sleep
	sleep_duration = 0
	sleep_control.sleeping = false
	
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lose_energy"):
		energy_amount -= 10
	if event.is_action_pressed("gain_money"):
		money += 10
	
func sleep(duration : int):
	var hour = time_hbox.half_day_length/12
	sleep_duration = duration * hour
	
func suit():
	print("here, have a suit")
	
	
