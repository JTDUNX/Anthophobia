import Foundation
import SpriteKit

class GameScene: SKScene {
    //add image for player
    var player : SKSpriteNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10, height: 10))
    override func sceneDidLoad() {
        addChild(player)
    }
}
