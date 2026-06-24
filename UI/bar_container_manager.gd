extends Control

@export var bar_container_below : VBoxContainer
@export var bar_container : VBoxContainer
@export var bar_container_above : VBoxContainer


func _ready() -> void:
	set_above_values(-100,-100,-100,-100)
	set_below_values(-100,-100,-100,-100)


func set_above_values(social_bar_value : float, energy_bar_value : float, water_bar_value : float, food_bar_value : float):
	bar_container_above.social_bar.value = bar_container.social_bar.value + social_bar_value
	bar_container_above.energy_bar.value = bar_container.energy_bar.value + energy_bar_value
	bar_container_above.water_bar.value = bar_container.water_bar.value + water_bar_value
	bar_container_above.food_bar.value = bar_container.food_bar.value + food_bar_value

func set_below_values(social_bar_value : float, energy_bar_value : float, water_bar_value : float, food_bar_value : float):
	bar_container_below.social_bar.value = bar_container.social_bar.value + social_bar_value
	bar_container_below.energy_bar.value = bar_container.energy_bar.value + energy_bar_value
	bar_container_below.water_bar.value = bar_container.water_bar.value + water_bar_value
	bar_container_below.food_bar.value = bar_container.food_bar.value + food_bar_value

func set_values(social_bar_value : float, energy_bar_value : float, water_bar_value : float, food_bar_value : float):
	bar_container.social_bar.value = social_bar_value
	bar_container.energy_bar.value = energy_bar_value
	bar_container.water_bar.value = water_bar_value
	bar_container.food_bar.value = food_bar_value
