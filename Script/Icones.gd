extends Spatial

func _on_Button_pressed() -> void:
	var building_name = $Building.get_children()[0].name
	
	$Camera.get_viewport().get_texture().get_data().save_png("D:/Downloads/Assets/POLYGON_Mini_Fantasy_Source_Files/IconsBuildings/" + building_name + ".png")
