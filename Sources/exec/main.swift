import Foundation
import MySGBGame
import SwiftGodot
import SwiftGodotBuilder
import SwiftGodotKit

func loadScene(scene: SceneTree) {
    actions.install()
    let rootNode = gameScene.makeNode()
    scene.root?.addChild(node: rootNode)
}

func registerTypes(level: GDExtension.InitializationLevel) {
    if level != .scene { return }
    register(type: PongBall.self)
    register(type: PongPaddle.self)
}

guard let packPath = Bundle.module.path(forResource: "MySGBGame", ofType: "pck") else {
    fatalError("Could not load Pack")
}

runGodot(
    args: [
        "--main-pack", packPath,
    ],
    initHook: registerTypes,
    loadScene: loadScene,
    loadProjectSettings: { _ in }
)
