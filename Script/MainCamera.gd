extends KinematicBody2D

signal _on_Player_teleport(target_pos)


export var target_path: NodePath
# export var rect: Rect2 = Rect2(-100, -100, +100, +100)
export var speed: float = 200

onready var target: Node2D = get_node(target_path)


func move_to(target_pos: Vector2) -> void:
  global_position = target_pos

func _ready() -> void:
  connect("_on_Player_teleport", self, "move_to")

func _physics_process(delta) -> void:
  var dp = target.position - self.position
  var s = clamp(speed, 0, dp.length()) / delta
  var dir: Vector2 = dp.normalized()
  var velocity: Vector2 = s * dir

  move_and_slide(velocity * delta)
