extends HBoxContainer

signal day_end
signal hour_end

@export var day_rich_text_label: RichTextLabel
@export var hour_label: Label
@export var minute_label: Label

var timer : float = 0
var half_day_length : float = 150
var stop_timer : bool = false

var day : int = 0
var hour : float = 0
var hour_before : float = 0
var minute : float = 0

func _process(delta: float) -> void:
	if not stop_timer:
		timer += delta
		
	hour = floor(timer / half_day_length * 12)  
	if hour != hour_before:
		hour_before = hour
		hour_end.emit(hour)
	if hour < 10 || (hour >= 12 and hour < 22):
		hour_label.text = "0"
	else:
		hour_label.text = ""
		
	
	
	if hour < 12:
		hour_label.text += str(int(hour)) + ":" 
	else:
		hour_label.text += str(int(hour) - 12) + ":" 
	
	
	minute = (timer - hour * (half_day_length / 12)) / (half_day_length / 12) * 60
	
	if minute < 10:
		minute_label.text = "0"
	else:
		minute_label.text = ""
	
	minute_label.text += str(int(floor(minute)))  
	
	if hour < 12:
		minute_label.text += "am"
	else:
		minute_label.text += "pm"
	
	
	if timer >= half_day_length * 2:
		timer -= half_day_length * 2
		day += 1
		day_end.emit()
	
