extends ColorRect

signal finished

@export var day_label: Label 
@export var start_day_button: Button
@export var payday_label: Label

@export var stat_container : VBoxContainer
@export var sleep_label : Label
@export var wattage_label: Label
@export var money_label: Label
@export var loan_label: Label
@export var taxes_label: Label



func _ready() -> void:
	stat_container.hide()
	show()
	start_day_button.pressed.connect(_on_start_day_button)

func fade_in(duration_secocnds : float):
	modulate.a = 0.0
	show()
	start_day_button.show()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration_secocnds).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(finished.emit)
	
	
func fade_out(duration_secocnds : float):
	show()
	start_day_button.hide()
	modulate.a = 1.0
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, duration_secocnds).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): 
		finished.emit()
		hide()
	)
	
func set_sleep_label(text : String):
	sleep_label.text = text
	
func set_day(day : int):
	day_label.text = "Day: " + str(day)
	payday_label.text = "Days till payday: " + str(7 - day % 7)

func set_wattage(amount : float):
	wattage_label.text = "Wattage produced today: " + str(floor(amount * 100)/100) + "W"

func set_money(amount : int):
	money_label.text = "HamBucks earned today: " + str(amount) + "HB"

func set_tax_payback(amount : int):
	taxes_label.text = "Taxes to pay on day " + str(GameManager.week * 7) + ": " +  str(amount) + "HB"
	
func set_loan_payback(amount : int):
	loan_label.text = "Loan payback left: " + str(amount) + "(+1%/Week)"

func win_screen():
	sleep_label.text = "You payed off all your dept!"
	wattage_label.text = "We hope you enjoyed this small game"
	money_label.hide()
	taxes_label.text = "Keep spinning!"

func _on_start_day_button():
	fade_out(5)
	await get_tree().create_timer(5).timeout
	stat_container.show() #just hide on day 0
	GameManager.time_hbox.stop_timer = false
	
