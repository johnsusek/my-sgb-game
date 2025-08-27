import SwiftGodot

@Godot
public class PongBall: Area2D {
  static let DEFAULT_SPEED = 300
  var _speed = DEFAULT_SPEED
  var direction = Vector2.left

  override public func _process(delta: Double) {
    position.x += direction.x * Float(_speed) * Float(delta)
    position.y += direction.y * Float(_speed) * Float(delta)
  }

  func reset() {
    direction = Vector2.left
    position.x = 320
    position.y = 180
    _speed = PongBall.DEFAULT_SPEED
  }
}
