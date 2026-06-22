extends Node2D


const RUN_BUTTON = preload("uid://bj02jneehe67b")
const STOP_BUTTON = preload("uid://dt8psn66g00uv")


@export var run_texture_button: TextureButton
@export var wheel_sprite_2d: AnimatedSprite2D
@export var hamster_animated_sprite_2d: AnimatedSprite2D

var running = false

func _ready() -> void:
	run_texture_button.pressed.connect(run_pressed)
	
	
func run_pressed():
	
	if running:
		run_texture_button.texture_normal = RUN_BUTTON
		wheel_sprite_2d.stop()
		hamster_animated_sprite_2d.hide()
	else:
		run_texture_button.texture_normal = STOP_BUTTON
		wheel_sprite_2d.play("default")
		hamster_animated_sprite_2d.play()
		hamster_animated_sprite_2d.show()
	
	running = not running
