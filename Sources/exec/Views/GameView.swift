import SwiftGodot
import SwiftGodotBuilder

struct GameView: GView {
  var ballShape = RectangleShape2D()

  init() {
    ballShape.size = Vector2(x: 8, y: 8)
  }

  var body: some GView {
    Node2D$ {
      Sprite2D$()
        .texture("separator.png")
        .position(x: 320, y: 200)

      GNode<PongBall> {
        Sprite2D$()
          .texture("ball.png")
        CollisionShape2D$()
          .shape(ballShape)
      }
      .position(x: 160, y: 100)

      Wall()
        .position(x: 0, y: 200)

      Wall()
        .position(x: 630, y: 200)

      FloorCeiling(bounceDirection: 1)
        .position(x: 320, y: -10)

      FloorCeiling(bounceDirection: -1)
        .position(x: 320, y: 410)

      Paddle("Left")
        .modulate(r: 0, g: 1, b: 1, a: 1)
        .position(x: 70, y: 192)

      Paddle("Right")
        .modulate(r: 1, g: 0, b: 1, a: 1)
        .position(x: 580, y: 192)

      GNode<Camera2D>()
        .offset(x: 320, y: 200)
    }
  }
}

func Wall() -> GNode<Area2D> {
  let wallShape = RectangleShape2D()
  wallShape.size = Vector2(x: 32, y: 640)

  return Area2D$ {
    CollisionShape2D$().shape(wallShape)
  }
  .on("area_entered") { (area: Area2D) in
    if let area = area as? PongBall {
      area.reset()
    }
  }
}

func FloorCeiling(bounceDirection: Int) -> GNode<Area2D> {
  let floorShape = RectangleShape2D()
  floorShape.size = Vector2(x: 640, y: 32)

  return Area2D$ {
    CollisionShape2D$().shape(floorShape)
  }.on("area_entered") { (area: Area2D) in
    if let area = area as? PongBall {
      area.direction = (area.direction + Vector2(x: 0, y: Float(bounceDirection))).normalized()
    }
  }
}

func Paddle(_ name: String) -> GNode<PongPaddle> {
  let paddleShape = RectangleShape2D()
  paddleShape.size = Vector2(x: 8, y: 32)

  return
    GNode<PongPaddle>(name) {
      Sprite2D$().texture("paddle.png")
      CollisionShape2D$().shape(paddleShape)
    }
}
