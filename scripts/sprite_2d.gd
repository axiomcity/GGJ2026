extends Sprite2D

@export var player: NodePath
@export var scroll_speed := 0.5

var last_player_x := 0.0
var player_node: Node2D

func _ready():
	player_node = get_node_or_null(player)
	if player_node == null:
		push_error("Player node not assigned or path is incorrect!")
		return
	
	last_player_x = player_node.position.x

func _process(delta):
	if player_node == null:
		return  # nothing to do if player is missing
	
	var delta_x = player_node.position.x - last_player_x
	position.x -= delta_x * scroll_speed
	last_player_x = player_node.position.x
