extends Node2D


const RUN_BUTTON = preload("uid://bj02jneehe67b")
const STOP_BUTTON = preload("uid://dt8psn66g00uv")


@export var run_texture_button: TextureButton
@export var wheel_sprite_2d: AnimatedSprite2D
@export var hamster_animated_sprite_2d: AnimatedSprite2D
@export var rich_text_label: RichTextLabel
@export var wheel_area_2d: Area2D
@export var display_area_2d: Area2D



var running = false

var speed = 0.0
var speed_max = 1.0
var time_until_max_speed = 10.0
var wattage = 0.0
var distance = 0.0
var wattage_per_second = 0.0

var update_timer = 0.0
var update_interval = 1.0

var wheel_hovered = false
var display_hovered = false

func _ready() -> void:
	run_texture_button.pressed.connect(run_pressed)
	wheel_area_2d.mouse_entered.connect(func(): wheel_hovered = true)
	wheel_area_2d.mouse_entered.connect(func(): wheel_hovered = false)
	display_area_2d.mouse_entered.connect(func(): display_hovered = true)
	display_area_2d.mouse_entered.connect(func(): display_hovered = false)
	update_screen()
	
func run_pressed():
	
	if running:
		run_texture_button.texture_normal = RUN_BUTTON
		wheel_sprite_2d.stop()
		hamster_animated_sprite_2d.hide()
		
		speed = 0
		
	else:
		run_texture_button.texture_normal = STOP_BUTTON
		wheel_sprite_2d.play("default")
		hamster_animated_sprite_2d.play()
		hamster_animated_sprite_2d.show()
		
		var tween = get_tree().create_tween()
		tween.tween_property(self, "speed", speed_max, time_until_max_speed)
		var tween2 = get_tree().create_tween()
		tween2.tween_property(hamster_animated_sprite_2d, "speed_scale", 1.0, time_until_max_speed).from(0.0)
		var tween3 = get_tree().create_tween()
		tween3.tween_property(wheel_sprite_2d, "speed_scale", 1.0, time_until_max_speed).from(0.0)
	
	running = not running
	
func _process(delta: float) -> void:
	
	
	if running:
		update_timer += delta
		if update_timer >= update_interval:
			update_timer -= update_interval
			
			distance += speed / 100
			wattage_per_second = speed
			wattage += wattage_per_second
			
			
			update_screen()
		

func update_screen():
	rich_text_label.text = "Speed: " + str(floor(speed * 100) / 100) + "cm/s" + "\n"
	rich_text_label.text += "Distance: " + str(floor(distance * 100) / 100) + "m" + "\n"
	rich_text_label.text += "Production: " + str(floor(wattage_per_second * 100) / 100) + "KWh"  + "\n"
	rich_text_label.text += "Energy: " + str(floor(wattage*100)/100) + "W"

		
