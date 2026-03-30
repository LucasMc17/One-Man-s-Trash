@tool
extends EditorScript

func _run():
	var npc : NPC = EditorInterface.get_edited_scene_root()
	print("migrating ", npc.name)
	npc.__migrate__()