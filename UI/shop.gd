extends Control

const SHOP_OFFER = preload("uid://dn2i0csms6cjk")

@export var toggle_shop_button : TextureButton
@export var shop_offer_vbox : VBoxContainer

@export var offer_list : Array[Offer]

var ui_canvas : CanvasLayer

func _ready() -> void:
	ui_canvas = get_tree().get_first_node_in_group("UI")
	
	toggle_shop_button.pressed.connect(ui_canvas.toggle_shop)
	
	for offer in offer_list:
		create_offer(offer)

func create_offer(offer : Offer):
	var offer_inst = SHOP_OFFER.instantiate()
	offer_inst.offer = offer
	shop_offer_vbox.add_child(offer_inst)
