import Foundation
import SpriteKit

class GameScene: SKScene {
    //add image for player
    var player : SKSpriteNode = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 10.0, height: 10.0))
    //add image for coins
    var coin : SKSpriteNode = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 10.0, height: 10.0))
    //add image for flowers
    var flower : SKSpriteNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10.0, height: 10.0))
    override func sceneDidLoad() {
        player.run(SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2), duration: 0.0))
            addChild(player)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        if touchLocation.x < size.width / 2 {
            player.run(SKAction.moveTo(x: size.width / 6, duration: 0.1))
        } else {
            player.run(SKAction.moveTo(x: 5 * size.width / 6, duration: 0.1))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        player.run(SKAction.moveTo(x: size.width / 2, duration: 0.1))
    }
}
