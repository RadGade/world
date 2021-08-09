tool
extends MultiMeshInstance;

export var extents := Vector2.ONE;
export var spawn_outside_circle :=  false;
export var radius := 12.0;
export var character_path : NodePath = ".";

func _enter_tree():
	connect("visibility_changed", self, "_on_WindGrass_visiblity_changed");
	
func _ready():
	var rng := RandomNumberGenerator.new()
	rng.randomize()
	
	var theta := 0;
	var increase := 1;
	var center : Vector3 = get_parent().global_transform.orgin
	
	for i in multimesh.instance_count:
		var transform := Transform().rotated(Vector3.UP, rng.randf_range(-PI/2, PI/2))
		var x: float
		var z: float
		if ! spawn_outside_circle:
			x = rng.randf_range(-extents.x, extents.y)
