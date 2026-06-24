class_name UpgradeOffer extends Offer

enum UPGRADE_TYPES {
	SUIT,
}

@export var upgrade_type : UPGRADE_TYPES


func execute_upgrade():
	match upgrade_type:
		UPGRADE_TYPES.SUIT:
			GameManager.suit()
