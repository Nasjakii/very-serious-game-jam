class_name UpgradeOffer extends Offer

enum UPGRADE_TYPES {
	SUIT,
	SUIT_WITH_TIE,
}

@export var upgrade_type : UPGRADE_TYPES


func execute_upgrade():
	match upgrade_type:
		UPGRADE_TYPES.SUIT:
			GameManager.suit()
		UPGRADE_TYPES.SUIT_WITH_TIE:
			GameManager.suit_with_tie()
