@tool
extends EditorScript


const MIGRATE_METHOD_NAME := &"__migrate__"


func _run() -> void:
    print("Migrating resources")
    var resource_files := get_all_file_paths("res://", [".tres"])
    for resource_file: String in resource_files:
        var resource := ResourceLoader.load(resource_file)
        migrate_resource(resource)
        ResourceSaver.save(resource, resource_file)
    print("Done")


func migrate_resource(variant: Variant) -> void:
    if variant is not Resource:
        return

    var resource := variant as Resource
    if resource.has_method(MIGRATE_METHOD_NAME):
        prints("Migrating", resource.get_script().get_global_name())
        resource.call(MIGRATE_METHOD_NAME)
    for prop in resource.get_property_list():
        var type := prop[&"type"] as int
        var name := prop[&"name"] as StringName
        match type:
            Variant.Type.TYPE_OBJECT:
                migrate_resource(resource[name])
            Variant.Type.TYPE_ARRAY:
                migrate_array(resource[name])
            Variant.Type.TYPE_DICTIONARY:
                migrate_dictionary(resource[name])


func migrate_array(array: Array) -> void:
    for item in array:
        if item is Resource:
            migrate_resource(item)


func migrate_dictionary(dictionary: Dictionary) -> void:
    for key in dictionary.keys():
        var item = dictionary[key]
        if item is Array:
            migrate_array(item)
        elif item is Dictionary:
            migrate_dictionary(item)
        else:
            migrate_resource(item)


func get_all_file_paths(path: String, extensions: Array[String]) -> Array[String]:
    var file_paths: Array[String] = []
    var directory := DirAccess.open(path)
    directory.list_dir_begin()
    var file_name := directory.get_next()
    while file_name != "":
        var file_path := path + file_name if path.ends_with("/") else path + "/" + file_name
        if directory.current_is_dir():
            file_paths.append_array(get_all_file_paths(file_path, extensions))
        else:
            for extension in extensions:
                if file_name.ends_with(extension):
                    file_paths.append(file_path)
        file_name = directory.get_next()
    return file_paths