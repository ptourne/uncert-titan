extends Item

class_name UnstackableItem

var contains_item: bool

static func init() -> UnstackableItem:
	var item = UnstackableItem.new()
	item.contains_item = true
	return item

func remove() -> bool:
	contains_item = false
	return true

func is_emtpy() -> bool:
	return !contains_item
