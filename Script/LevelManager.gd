extends Node2D


export var player_path: NodePath

var player: Node2D = null


func spawn_player(pos: Vector2) -> void:
  player = get_node(player_path)
  player.position = pos

func _ready() -> void:
  spawn_player(Vector2(0, 0))
