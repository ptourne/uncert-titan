class_name ItemId

enum {
	WindMill,
	Ice,
}

static func get_item_from_id(id: int) -> Item:
	match id:
		ItemId.Ice: return StackableItem.init()
		ItemId.WindMill: return UnstackableItem.init()
	return null # will never happend
