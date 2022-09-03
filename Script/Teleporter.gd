extends Area2D


signal _after_teleport

export var target_path: NodePath
# export var target_location: Vector2

onready var target: Node2D = get_node(target_path)

var ignore: bool = false


func _ready() -> void:
  connect("body_entered", self, "_on_teleport")
  connect("body_exited", self, "enable_teleport")
  connect("_after_teleport", self, "disable_teleport")

func _on_teleport(body: Node):
  if ignore:
    return

  if body.name != 'Player':
    return

  body.global_position = target.global_position
  body.emit_signal("_after_teleport")
  target.emit_signal("_after_teleport")

func enable_teleport(_body: Node) -> void:
  self.ignore = false

func disable_teleport() -> void:
  self.ignore = true