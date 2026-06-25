extends Node2D


const RUN_BUTTON = preload("uid://bj02jneehe67b")
const STOP_BUTTON = preload("uid://dt8psn66g00uv")
const HAMSTER_SUIT_ANIMATED_SPRITEFRAMES = preload("uid://cqcex58wvifsl")
const HAMSTER_SUIT_WITH_TIE_ANIMATED_SPRITEFRAMES = preload("uid://byhyqyb26dxlt")
const WHEEL_2_SPRITEFRAMES = preload("uid://b0xr4ptx1c3wl")


@export var wheel_sprite_2d: AnimatedSprite2D
@export var hamster_animated_sprite_2d: AnimatedSprite2D
@export var rich_text_label: RichTextLabel
@export var wheel_area_2d: Area2D
@export var display_area_2d: Area2D
@export var wheel_display: Sprite2D

var energy_selling : Control

var running = false

var speed : float = 0.0
var speed_max = 1.0
var time_until_max_speed = 5.0
var wattage : float = 0.0 : 
	set(value):
		if value > wattage:
			GameManager.wattage_produced_today += value - wattage 
		wattage = value
		
	
var distance = 0.0
var wattage_per_second = 0.0

var update_timer = 0.0
var update_interval = 1.0

var wheel_hovered = false
var display_hovered = false
var hour = 0
var time_hbox : HBoxContainer

func _ready() -> void:
	energy_selling = get_tree().get_first_node_in_group("EnergySelling")
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	hour = time_hbox.half_day_length / 12
	
	wheel_area_2d.mouse_entered.connect(func(): 
		wheel_hovered = true
		wheel_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	wheel_area_2d.mouse_exited.connect(func(): 
		wheel_hovered = false
		wheel_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	display_area_2d.mouse_entered.connect(func(): 
		display_hovered = true
		wheel_display.material.set("shader_parameter/color", Color.WHITE)
		)
	display_area_2d.mouse_exited.connect(func(): 
		display_hovered = false
		wheel_display.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	update_screen()
	
func run_pressed():
	
	if running:
		
		var tween = get_tree().create_tween()
		var slow_down_time = time_until_max_speed * (speed/speed_max)
		tween.tween_property(self, "speed", 0, slow_down_time)
		tween.tween_callback(finished_running)
		var tween2 = get_tree().create_tween()
		tween2.tween_property(hamster_animated_sprite_2d, "speed_scale", 0.0, slow_down_time)
		var tween3 = get_tree().create_tween()
		tween3.tween_property(wheel_sprite_2d, "speed_scale", 0.0, slow_down_time)
		
	else:
		GameManager.hamster_busy = true
		wheel_sprite_2d.play("default")
		hamster_animated_sprite_2d.play()
		hamster_animated_sprite_2d.show()
		
		var tween = get_tree().create_tween()
		tween.tween_property(self, "speed", speed_max, time_until_max_speed)
		var tween2 = get_tree().create_tween()
		tween2.tween_property(hamster_animated_sprite_2d, "speed_scale", 1.0, time_until_max_speed).from(0.0)
		var tween3 = get_tree().create_tween()
		tween3.tween_property(wheel_sprite_2d, "speed_scale", 1.0, time_until_max_speed).from(0.0)
		
		running = true
	
	
	
func finished_running():
	GameManager.hamster_busy = false
	speed = 0
	update_screen()
	wheel_sprite_2d.stop()
	hamster_animated_sprite_2d.hide()
	running = false
	
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
	rich_text_label.text += "Production: " + str(floor(wattage_per_second * hour * 100) / 100) + "W/h"  + "\n"
	rich_text_label.text += "Energy: " + str(floor(wattage*100)/100) + "W"

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if wheel_hovered and (not GameManager.hamster_busy or running):
			run_pressed()
		if display_hovered and (not GameManager.hamster_busy or running):
			energy_selling.show()


func reset_wattage():
	var temp_val = wattage
	wattage = 0
	update_screen()
	return temp_val
	
func suit():
	hamster_animated_sprite_2d.sprite_frames = HAMSTER_SUIT_ANIMATED_SPRITEFRAMES
	if running: hamster_animated_sprite_2d.play()

func suit_with_tie():
	hamster_animated_sprite_2d.sprite_frames = HAMSTER_SUIT_WITH_TIE_ANIMATED_SPRITEFRAMES
	if running: hamster_animated_sprite_2d.play()
	
func wheel_upgrade():
	speed_max = 2.0
	time_until_max_speed = 7.5
	wheel_sprite_2d.sprite_frames = WHEEL_2_SPRITEFRAMES
	if running: wheel_sprite_2d.play()
	
