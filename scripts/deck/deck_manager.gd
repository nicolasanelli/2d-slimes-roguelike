class_name DeckManager


const action_card = preload("res://components/cards/action_card.tscn")

var add_weapon_ps = preload("res://components/cards/add_weapon_card/add_weapon_card.tscn")
var upgrade_weapon_ps = preload("res://components/cards/upgrade_weapon_card/upgrade_weapon_card.tscn")
var heal_ps = preload("res://components/cards/heal_card/heal_card.tscn")
var magnet_ps = preload("res://components/cards/xp_magnet_card/xp_magnet_card.tscn")
var do_nothing_ps = preload("res://components/cards/do_nothing_card/do_nothing_card.tscn")


var options = {
	"gun": [
		preload("res://data/cards/weapon_cards/pistol/common_pistol_card.tres"),
		preload("res://data/cards/weapon_cards/pistol/uncommon_pistol_card.tres"),
		preload("res://data/cards/weapon_cards/pistol/rare_pistol_card.tres"),
		preload("res://data/cards/weapon_cards/pistol/epic_pistol_card.tres"),
		preload("res://data/cards/weapon_cards/pistol/legendary_pistol_card.tres"),
		preload("res://data/cards/weapon_cards/pistol/mythic_pistol_card.tres"),
	],
	"shotgun": [
		preload("res://data/cards/weapon_cards/shotgun/common_shotgun_card.tres"),
		preload("res://data/cards/weapon_cards/shotgun/uncommon_shotgun_card.tres"),
		preload("res://data/cards/weapon_cards/shotgun/rare_shotgun_card.tres"),
		preload("res://data/cards/weapon_cards/shotgun/epic_shotgun_card.tres"),
		preload("res://data/cards/weapon_cards/shotgun/legendary_shotgun_card.tres"),
		preload("res://data/cards/weapon_cards/shotgun/mythic_shotgun_card.tres"),
	],
	"csaw": [
		#preload("res://data/cards/add_weapon_cards/add_csaw_card.tres"),
		#preload("res://data/cards/upgrade_weapon_cards/upgrade_csaw_uncommon.tres"),
		#preload("res://data/cards/upgrade_weapon_cards/upgrade_csaw_rare.tres"),
		#preload("res://data/cards/upgrade_weapon_cards/upgrade_csaw_epic.tres"),
		#preload("res://data/cards/upgrade_weapon_cards/upgrade_csaw_legendary.tres"),
		#preload("res://data/cards/upgrade_weapon_cards/upgrade_csaw_mythic.tres"),
	],
	"heal": [
		#preload("res://data/cards/heal_cards/full_heal_card.tres"),
		preload("res://data/cards/consumable_cards/heal_25hp.tres")
	],
	"xpmagnet": [
		#preload("res://data/cards/xp_magnet_card/xp_magnet_card.tres"),
	]
}

var consumable_keys = ["gun", "shotgun", "csaw"]


func pick_cards(quantity: int) -> Array[DeckCard]:
	var deck_cards: Array[DeckCard] = [];
	
	var keys = _pick_unique_random_keys(quantity)
	
	for key in keys:
		var deck_card = pick_card(key)
		if deck_card:
			deck_cards.push_back(deck_card)
	
	
	if deck_cards.size() == 0:
		deck_cards.push_back(_do_nothing_card())
	
	return deck_cards

var first_pickup = true
func _pick_unique_random_keys(quantity: int) -> Array:
	if first_pickup: 
		first_pickup = false;
		return ["gun", "shotgun", "csaw"]
	
	var keys_available = options.keys()
	keys_available.shuffle()
	var keys = keys_available.slice(0, quantity)
	return keys


func pick_card(key: String) -> DeckCard:
	
	if ((options.get(key) as Array).size() == 0):
		return null
	
	var resource = options.get(key)[0]
	if _should_pop_and_push_by_key(key):
		options.get(key).remove_at(0)
	
	#var card: ActionCard
	#if (resource is AddWeaponCardResource):
		#card = (add_weapon_ps.instantiate() as AddWeaponCard)
		#card._resource = resource
	#
	#elif (resource is UpgradeWeaponCardResource):
		#card = (upgrade_weapon_ps.instantiate() as UpgradeWeaponCard)
		#card._resource = resource
	#
	#elif (resource is HealCardResource):
		#card = (heal_ps.instantiate() as HealCard)
		#card._resource = resource
	#
	#elif (resource is XpMagnetCardResource):
		#card = (magnet_ps.instantiate() as XpMagnetCard)
		#card._resource = resource
	var card := action_card.instantiate()
	card.set_resource(resource)
	
	return DeckCard.new(key, resource, card)


func _do_nothing_card() -> DeckCard:
	var resource = preload("res://data/cards/_do_nothing_card/do_nothing_card.tres")
	var card = (do_nothing_ps.instantiate() as DoNothingCard)
	card._resource = resource
	
	return DeckCard.new('', resource, card)


func requeue(deck_card: DeckCard) -> void:
	if _should_pop_and_push_by_key(deck_card.key):
		(options.get(deck_card.key) as Array).push_front(deck_card.resource)


func _should_pop_and_push_by_key(key: String) -> bool:
	return (consumable_keys.find(key) > -1)
