class_name UpgradeOffer extends Offer

enum UPGRADE_TYPES {
	NONE,
	SUIT,
	SUIT_WITH_TIE,
	WHEEL,
	WHEEL2,
}

@export var upgrade_type : UPGRADE_TYPES
@export var needed_upgrade : UPGRADE_TYPES = UPGRADE_TYPES.NONE

func execute_upgrade():
	GameManager.upgrade(upgrade_type)
