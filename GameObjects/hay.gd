extends Node2D

@export var hay_sprite_2d: Sprite2D
@export var hay_area_2d: Area2D
@export var hamster_animated_sprite_2d: AnimatedSprite2D
@export var audio_stream_player: AudioStreamPlayer

var hay_hovered = false
var sleep_controller : Control

func _ready() -> void:
	sleep_controller = get_tree().get_first_node_in_group("SleepController")
	sleep_controller.sleep_started.connect(_on_sleep_started)
	GameManager.finished_sleep.connect(_on_sleep_finished)
	
	hay_area_2d.mouse_entered.connect(func(): 
		hay_hovered = true
		hay_sprite_2d.material.set("shader_parameter/color", Color.WHITE)
		
		)
	hay_area_2d.mouse_exited.connect(func(): 
		hay_hovered = false
		hay_sprite_2d.material.set("shader_parameter/color", Color.TRANSPARENT)
		)
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if hay_hovered and not GameManager.hamster_busy:
			sleep_controller.show()
			GameManager.hamster_busy = true


func _on_sleep_started():
	hamster_animated_sprite_2d.play()
	hamster_animated_sprite_2d.show()
	
	audio_stream_player.play()


func _on_sleep_finished():
	hamster_animated_sprite_2d.stop()
	hamster_animated_sprite_2d.hide()
	
	var tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player, "volume_db", 0, 1)
	tween.tween_callback(audio_stream_player.stop)
	
