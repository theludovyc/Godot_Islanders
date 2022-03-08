extends Node

#:preload()

const packs = {}
const pack_icons = {}

func _ready() -> void:
	#load pack scene
	var dir = Directory.new()
	
	var dir_pack := "res://Scene/Pack"
	
	if dir.open(dir_pack) == OK:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		
		while !file_name.empty():
			if dir.current_is_dir() and file_name[0] != '.':
				
				var dir1 = Directory.new()
				
				if dir1.open(dir_pack + "/" + file_name) == OK:
					packs[file_name] = {}
					
					dir1.list_dir_begin()
					
					var file_name1 = dir1.get_next()
					
					while !file_name1.empty():
						if !dir1.current_is_dir():
							packs[file_name][file_name1.get_basename()] = load(dir1.get_current_dir() + "/" + file_name1)
							
						file_name1 = dir1.get_next()
				else:
					prints("Load", "Can't open directory", dir_pack + "/" + file_name)
				
			file_name = dir.get_next()
	else:
		prints("Load", "can't find directory Pack")
		
	#load icons
	if dir.open("res://Art/Icons/") == OK:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		
		while !file_name.empty():
			if !dir.current_is_dir() and file_name.get_extension() != "import":
				pack_icons[file_name.get_basename()] = load(dir.get_current_dir() + '/' + file_name)
			
			file_name = dir.get_next()
			
	prints("Load", pack_icons)
