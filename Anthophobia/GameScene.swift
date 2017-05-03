import Foundation
import SpriteKit

class GameScene: SKScene {
    //add image for player
    let player : SKSpriteNode = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 10.0, height: 10.0))
    //add image for coins
    let coin : SKSpriteNode = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 10.0, height: 10.0))
    //add image for flowers
    let flower : SKSpriteNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10.0, height: 10.0))
    override func sceneDidLoad() {
        player.run(SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2), duration: 0.0))
            addChild(player)
        player.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addTopFlower),SKAction.wait(forDuration: 1.0)])))
        player.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addBottomFlower),SKAction.wait(forDuration: 1.0)])))
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
        guard touches.first != nil else {
            return
        }
        player.run(SKAction.moveTo(x: size.width / 2, duration: 0.1))
    }
    func addTopFlower() {
        let fallingFlower = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10.0, height: 10.0))
        addChild(fallingFlower)
        let isle = Int(arc4random_uniform(3))
        if isle == 0 {
            fallingFlower.run(SKAction.moveBy(x: size.width / 6, y: size.height + 20, duration: 0.0))
        } else if isle == 1 {
            fallingFlower.run(SKAction.moveBy(x: size.width / 2, y: size.height + 20, duration: 0.0))
        } else {
            fallingFlower.run(SKAction.moveBy(x: 5 * size.width / 6, y: size.height + 20, duration: 0.0))
        }
        let speed = TimeInterval(2 + Float(arc4random_uniform(4)) / 2)
        fallingFlower.run(SKAction.moveTo(y: -20, duration: speed))
    }
    func addBottomFlower() {
        let risingFlower = SKSpriteNode(color: UIColor.red, size: CGSize(width: 10.0, height: 10.0))
        addChild(risingFlower)
        let isle = Int(arc4random_uniform(3))
        if isle == 0 {
            risingFlower.run(SKAction.moveBy(x: size.width / 6, y: -20, duration: 0.0))
        } else if isle == 1 {
            risingFlower.run(SKAction.moveBy(x: size.width / 2, y: -20, duration: 0.0))
        } else {
            risingFlower.run(SKAction.moveBy(x: 5 * size.width / 6, y: -20, duration: 0.0))
        }
        let speed = TimeInterval(2 + Float(arc4random_uniform(4)) / 2)
        risingFlower.run(SKAction.moveTo(y: size.height + 20, duration: speed))
    }
}
