class_name DeckCard

var key: String
var resource: Resource
var card: ActionCard

func _init(_key: String, _resource: Resource, _card: ActionCard) -> void:
	self.key = _key
	self.resource = _resource
	self.card = _card
