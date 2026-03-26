@tool
extends EditorScript

var NPCs = [ResourceLoader.load('res://scenes/characters/npcs/bart/bart.tscn')]

func _run():
	var npc : NPC = EditorInterface.get_edited_scene_root()
	print("migrating ", npc.name)
	npc.__migrate__()