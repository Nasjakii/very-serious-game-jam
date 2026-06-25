class_name UpgradeOffer extends Offer

enum UPGRADE_TYPES {
	SUIT,
	SUIT_WITH_TIE,
	WHEEL,
}

@export var upgrade_type : UPGRADE_TYPES


func execute_upgrade():
	GameManager.upgrade(upgrade_type)
