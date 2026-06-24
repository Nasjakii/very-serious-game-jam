extends Control


@export var offer_name_label: RichTextLabel
@export var price_rich_text_label: RichTextLabel
@export var texture_button: TextureButton

@export var offer : Offer

var fridge_control : Control
var drink_control : Control
var employee_control : Control


func _ready() -> void:
	fridge_control = get_tree().get_first_node_in_group("FridgeSelection")
	drink_control = get_tree().get_first_node_in_group("DrinkSelection")
	employee_control = get_tree().get_first_node_in_group("MiniCageWindow")
	
	price_rich_text_label.text = str(offer.offer_price) + "HB"
	texture_button.pressed.connect(_on_buy_button_pressed) 
	offer_name_label.text = offer.offer_name

func _on_buy_button_pressed():
	if offer.offer_price <= GameManager.money:
		GameManager.money -= offer.offer_price
		effect()
		
		if not offer.offer_permanent:
			queue_free()



func effect():

	if offer is FoodOffer:
		fridge_control.add_food(offer.food_resource)
	elif offer is DrinkOffer:
		drink_control.add_drink(offer.drink_resource)
	elif offer is EmployeeOffer:
		employee_control.add_employee(offer.employee_name)
	elif offer is UpgradeOffer:
		offer.execute_upgrade()
		
