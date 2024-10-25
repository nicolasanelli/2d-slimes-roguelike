class_name BaseWeapon
extends Resource

#region Rarity
@export var rarity: Rarity
enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
	MYTHIC,
}

func get_color() -> Color:
	match rarity:
		Rarity.COMMON, _: return Color.GRAY
		Rarity.UNCOMMON: return Color.GREEN
		Rarity.RARE: return Color.DODGER_BLUE	
		Rarity.EPIC: return Color.PURPLE
		Rarity.LEGENDARY: return Color.ORANGE
		Rarity.MYTHIC: return Color.SKY_BLUE

func get_level() -> int:
	return rarity
#endregion

@export var is_special: bool
