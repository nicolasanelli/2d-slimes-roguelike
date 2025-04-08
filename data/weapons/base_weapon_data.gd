class_name BaseWeaponData
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
		Rarity.MYTHIC: return Color.SKY_BLUE
		Rarity.LEGENDARY: return Color.ORANGE
		Rarity.EPIC: return Color.PURPLE
		Rarity.RARE: return Color.DODGER_BLUE	
		Rarity.UNCOMMON: return Color.GREEN
		Rarity.COMMON, _: return Color.GRAY

func get_rarity() -> int:
	return rarity

func get_next_rarity() -> int:
	return rarity
#endregion

@export var is_special: bool

@export var texture: Texture
@export var item_rotation_degree: float 
