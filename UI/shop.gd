extends Control

const SHOP_OFFER = preload("uid://dn2i0csms6cjk")

@export var toggle_shop_button : TextureButton
@export var food_offer_vbox : VBoxContainer
@export var drink_offer_vbox : VBoxContainer
@export var employee_offer_vbox : VBoxContainer
@export var upgrade_offer_vbox : VBoxContainer

@export var offer_list : Array[Offer]

var ui_canvas : CanvasLayer
var time_hbox : HBoxContainer 
var all_offers : Array[Offer]
var add_random_offers_daily : int = 2

func _ready() -> void:
	time_hbox = get_tree().get_first_node_in_group("TimeHBox")
	time_hbox.day_end.connect(_on_day_end)
	ui_canvas = get_tree().get_first_node_in_group("UI")
	
	toggle_shop_button.pressed.connect(ui_canvas.toggle_shop)

	for offer in offer_list:
		if offer is UpgradeOffer:
			if offer.needed_upgrade == UpgradeOffer.UPGRADE_TYPES.NONE:
				create_offer(offer)
		else:
			create_offer(offer)


func _on_day_end():
	
	for i in range(add_random_offers_daily):
		var rand_offer = offer_list[randi_range(0, offer_list.size() - 1)]
		if rand_offer is UpgradeOffer: continue
		var in_list = false
		for offer in all_offers:
			if offer == rand_offer:
				in_list = true
				break
		if not in_list:
			create_offer(rand_offer)

func _on_offer_deleted(delete_offer : Offer):
	
	if delete_offer is UpgradeOffer:
		for offer in offer_list:
			if not offer is UpgradeOffer: continue
			if offer.needed_upgrade == delete_offer.upgrade_type:
				create_offer(offer)
	
	all_offers.erase(delete_offer)

func create_offer(offer : Offer):
	var offer_inst = SHOP_OFFER.instantiate()
	offer_inst.offer = offer
	offer_inst.offer_deleted.connect(_on_offer_deleted)
	all_offers.append(offer)
	
	if offer is DrinkOffer:
		drink_offer_vbox.add_child(offer_inst)
	if offer is FoodOffer:
		food_offer_vbox.add_child(offer_inst)
	if offer is EmployeeOffer:
		employee_offer_vbox.add_child(offer_inst)
	if offer is UpgradeOffer:
		upgrade_offer_vbox.add_child(offer_inst)
