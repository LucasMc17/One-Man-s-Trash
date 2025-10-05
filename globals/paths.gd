extends Node

func get_material_path(material_name : String):
	return 'res:///assets/materials/' + material_name + '.tres'

func get_dialog_path(character_name : String, dialog_name : String, tree_name := "index"):
	return 'res://scenes/characters/npcs/' + character_name + '/dialog/' + dialog_name + '/' + tree_name + '.tres'