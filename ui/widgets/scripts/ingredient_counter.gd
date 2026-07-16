extends Label


func _ready() -> void:
	update()
	Inventory.inventory_modified.connect(check_update)


func check_update(item : Enums.ItemTypes) -> void:
	if item in Inventory.ingredients:
		update()


func update() -> void:
	var ct = Inventory.get_ingredient_count()
	var total = Inventory.ingredients.size()
	text = 'Ingredients: %d / %d' % [ct,total]
