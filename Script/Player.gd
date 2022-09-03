extends KinematicBody2D


signal _after_teleport

export var camera_path: NodePath
export var speed: float = 400

onready var camera = get_node(camera_path)

var velocity: Vector2 = Vector2(0.0, 0.0)


func _ready() -> void:
  connect("_after_teleport", self, "_on_Player_teleport")

func _on_Player_teleport() -> void:
  camera.emit_signal("_on_Player_teleport", global_position)

func _process(_delta: float) -> void:
  var h = Input.get_axis("ui_left", "ui_right")
  var v = Input.get_axis("ui_up", "ui_down")

  velocity = speed * Vector2(h, v).normalized()

  if not is_zero_approx(h):
    $Sprite.flip_h = h > 0

  if is_zero_approx(h) and is_zero_approx(v):
    $Sprite.stop()
  elif not $Sprite.is_playing():
    $Sprite.play("walk")


func _physics_process(delta: float) -> void:
  velocity = move_and_slide(velocity)

  $Sprite.z_index = max(global_position.y, 0)
