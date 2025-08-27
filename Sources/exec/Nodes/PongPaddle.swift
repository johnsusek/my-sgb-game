import SwiftGodot

@Godot
public class PongPaddle: Area2D {
  static let MOVE_SPEED = 200
  var _ball_dir = 0
  var _up = ""
  var _down = ""

  public var screenSizeY: Float = 0

  public convenience init(_ name: String) {
    self.init()
    self.name = StringName(name)
  }

  func onAreaEntered(area: Area2D) {
    if let area = area as? PongBall {
      area.direction = Vector2(x: Float(_ball_dir), y: Float.random(in: -1 ... 1)).normalized()
    }
  }

  override public func _ready() {
    areaEntered.connect(onAreaEntered)

    screenSizeY = getViewportRect().size.y
    let n = String(name).lowercased()
    _up = n + "_move_up"
    _down = n + "_move_down"
    if n == "left" {
      _ball_dir = 1
    } else {
      _ball_dir = -1
    }
  }

  override public func _process(delta: Double) {
    let input = Input.getActionStrength(action: StringName(_down)) - Input.getActionStrength(action: StringName(_up))
    let newPos = position.y + Float(input) * Float(PongPaddle.MOVE_SPEED) * Float(delta)
    position.y = newPos.clamped(16, screenSizeY - 16)
  }
}

private extension Comparable {
  func clamped(_ f: Self, _ t: Self) -> Self {
    var r = self
    if r < f { r = f }
    if r > t { r = t }
    return r
  }
}
