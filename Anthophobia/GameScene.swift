import Foundation
import SpriteKit

class GameScene: SKScene {
    //add image for player
    var player : SKSpriteNode = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 10, height: 10))
    //add image for coins
    var coin : SKSpriteNode = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 10, height: 10))
    //add image for flowers
    var flower : SKSpriteNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10, height: 10))
    override func sceneDidLoad() {
        addChild(player)
    }
}
