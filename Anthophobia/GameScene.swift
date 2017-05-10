import Foundation
import SpriteKit

class GameScene: SKScene {
    var circleSize : Int = 0
    let player : SKSpriteNode = SKSpriteNode(imageNamed: "player")
    let pauseButton = SKSpriteNode(color: .green , size: CGSize(width: 80, height: 80))
    let restartButton = SKSpriteNode(color: .green , size: CGSize(width: 80, height: 80))
    var myView : SKView! = nil
    override func sceneDidLoad() {
        circleSize = Int(size.width / 12)
        player.size = CGSize(width: 60, height: 60)
        player.run(SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2), duration: 0.0))
        addChild(player)
        player.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addTopFlower),SKAction.wait(forDuration: 1.25)])))
        player.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addBottomFlower),SKAction.wait(forDuration: 1.25)])))
        addChild(pauseButton)
        addChild(restartButton)
        restartButton.isHidden = true
        pauseButton.zPosition = 1.0
        restartButton.zPosition = 1.0
        pauseButton.position = CGPoint(x: 40, y: 40)
        restartButton.position = CGPoint(x: (size.width / 2) - 80, y: size.height / 2)
        pauseButton.alpha = 0.75
    }
    func pausePressed() {
        if self.isPaused {
            self.isPaused = false
            restartButton.isHidden = true
            pauseButton.alpha = 0.75
        } else {
            self.isPaused = true
            restartButton.isHidden = false
            pauseButton.alpha = 1.0
        }
    }
    func restartPressed() {
        let newScene = GameScene(size: self.size)
        newScene.myView = self.myView
        myView.presentScene(newScene, transition: SKTransition())
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        if pauseButton.frame.contains(touchLocation) {
            pausePressed()
        } else if restartButton.frame.contains(touchLocation) && self.isPaused{
            restartPressed()
        } else if touchLocation.x < size.width / 2 {
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
        var fallingFlower : SKSpriteNode!
        let coinCheck = Int(arc4random_uniform(6))
        if coinCheck == 5 {
            fallingFlower = SKSpriteNode(imageNamed: "coin")
        } else {
           fallingFlower = SKSpriteNode(imageNamed: "redFlower")
        }
        fallingFlower.size = CGSize(width: 60, height: 60)
        let isle = Int(arc4random_uniform(3))
        if isle == 0 {
            fallingFlower.run(SKAction.moveBy(x: size.width / 6, y: size.height + (CGFloat)(circleSize), duration: 0.0))
        } else if isle == 1 {
            fallingFlower.run(SKAction.moveBy(x: size.width / 2, y: size.height + (CGFloat)(circleSize), duration: 0.0))
        } else {
            fallingFlower.run(SKAction.moveBy(x: 5 * size.width / 6, y: size.height + (CGFloat)(circleSize), duration: 0.0))
        }
        addChild(fallingFlower)
        let speed = TimeInterval(2 + Float(arc4random_uniform(4)) / 2)
        fallingFlower.run(SKAction.moveTo(y: -(CGFloat)(circleSize), duration: speed))
    }
    func addBottomFlower() {
        var risingFlower : SKSpriteNode!
        let coinCheck = Int(arc4random_uniform(6))
        if coinCheck == 5 {
            risingFlower = SKSpriteNode(imageNamed: "coin")
        } else {
            risingFlower = SKSpriteNode(imageNamed: "redFlower")
        }
        risingFlower.size = CGSize(width: 60, height: 60)
        let isle = Int(arc4random_uniform(3))
        if isle == 0 {
            risingFlower.run(SKAction.moveBy(x: size.width / 6, y: -(CGFloat)(circleSize), duration: 0.0))
        } else if isle == 1 {
            risingFlower.run(SKAction.moveBy(x: size.width / 2, y: -(CGFloat)(circleSize), duration: 0.0))
        } else {
            risingFlower.run(SKAction.moveBy(x: 5 * size.width / 6, y: -(CGFloat)(circleSize), duration: 0.0))
        }
        addChild(risingFlower)
        let speed = TimeInterval(2 + Float(arc4random_uniform(4)) / 2)
        risingFlower.run(SKAction.moveTo(y: size.height + (CGFloat)(circleSize), duration: speed))
    }
}
