class_name DeckManager
extends Node

var add_weapon_ps = preload("res://components/cards/add_weapon_card/add_weapon_card.tscn")
var upgrade_weapon_ps = preload("res://components/cards/upgrade_weapon_card/upgrade_weapon_card.tscn")
var heal_ps = preload("res://components/cards/heal_card/heal_card.tscn")

var options = {
	"gun": [
		preload("res://data/usable_card/add_weapon_cards/add_pistol_card.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_uncommon.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_rare.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_epic.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_legendary.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_mythic.tres"),
	],
	"csaw": [
		preload("res://data/usable_card/add_weapon_cards/add_csaw_card.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_uncommon.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_rare.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_epic.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_legendary.tres"),
		preload("res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_mythic.tres"),
	],
	"heal": [
		preload("res://data/usable_card/heal_cards/full_heal_card.tres"),
	]
}

var consumable_keys = ["gun", "csaw"]

func pick_cards() -> Array[DeckCard]:
	var deck_cards: Array[DeckCard] = [];
	
	var gun = pick_card("gun");
	var csaw = pick_card("csaw");
	var heal = pick_card("heal");
	
	if gun: deck_cards.push_back(gun)
	if csaw: deck_cards.push_back(csaw)
	if heal: deck_cards.push_back(heal)
	
	return deck_cards

func pick_card(key: String) -> DeckCard:
	
	if ((options.get(key) as Array).size() == 0):
		return null
	
	var resource = options.get(key)[0]
	if (consumable_keys.find(key) > -1):
		options.get(key).remove_at(0)
	
	var card: ActionCard
	if (resource is AddWeaponCardResource):
		card = (add_weapon_ps.instantiate() as AddWeaponCard)
		card._resource = resource
	
	elif (resource is UpgradeWeaponCardResource):
		card = (upgrade_weapon_ps.instantiate() as UpgradeWeaponCard)
		card._resource = resource
	
	elif (resource is HealCardResource):
		card = (heal_ps.instantiate() as HealCard)
		card._resource = resource
	
	return DeckCard.new(key, resource, card)


func requeue(deck_card: DeckCard) -> void:
	if (consumable_keys.find(deck_card.key) > -1):
		(options.get(deck_card.key) as Array).push_front(deck_card.resource)
