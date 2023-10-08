extends Item

class_name StackableItem

@export var max_items: int
var item_count: int

static func init() -> StackableItem:
	var item = StackableItem.new()
	item.item_count = 1
	return item

func could_append(item: int) -> bool:
	if item != self.id:
		return false
	
	if self.item_count + 1 >= max_items:
		return false
	
	self.item_count += 1
	return true

func remove() -> bool:
	self.item_count -= 1
	return true

func is_emtpy() -> bool:
	return true if self.item_count <= 0 else false
