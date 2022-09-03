extends KinematicBody2D


export var path: PoolVector2Array
export var speed: float = 200

var origin: Vector2
var target_index: int = 0


func draw_circle_arc(center, radius, angle_from, angle_to, color):
  var nb_points = 32
  var points_arc = PoolVector2Array()

  for i in range(nb_points + 1):
      var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
      points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

  for index_point in range(nb_points):
      draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func _draw():
  for point in path:
    var target = point + origin

    draw_circle(target, 10.0, Color(255, 0, 255))

func _ready():
  origin = global_position

func _physics_process(delta: float) -> void:
  var target = path[target_index] + origin

  if is_zero_approx(global_position.distance_to(target)):
    # print('transition: ', target_index, ' -> ', (target_index + 1) % len(paths))
    target_index = (target_index + 1) % len(path)
    target = path[target_index] + origin

    print('target_index ', target_index)
    print('target ', target)

  # print('origin ', origin)
  # print('target_index ', target_index)
  # print('target ', target)

  var velocity = speed * (target - position).normalized()
  move_and_collide(velocity * delta)

  if not is_zero_approx(velocity.x):
    $Sprite.flip_h = velocity.x > 0
    $Sprite.play('walk')

  $Sprite.z_index = max(global_position.y, 0)
