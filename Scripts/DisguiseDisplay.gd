extends ItemList



func update_disguises(num_disguises):
	clear()
	for i in range(num_disguises):
		add_icon_item(load(Global.box_sprite),false)