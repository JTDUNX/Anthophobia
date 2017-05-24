import Foundation
import SpriteKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    var circleSize : Double = 0
    let player : SKSpriteNode = SKSpriteNode(imageNamed: "player")
    let pauseButton = SKSpriteNode(color: .green , size: CGSize(width: 80, height: 80))
    let restartButton = SKSpriteNode(color: .green , size: CGSize(width: 80, height: 80))
    let homeButton = SKSpriteNode(color: .green , size: CGSize(width: 80, height: 80))
    var myView : GameView! = nil
    var score : Int = 0
    var highScore : Int = 0
    let scoreLabel = SKLabelNode(text: "Score: 0")
    let highScoreLabel = SKLabelNode(text: "High Score: 0")
    
    let playerCategory : UInt32 = 0
    let flowerCategory : UInt32 = 1
    let coinCategory : UInt32 = 2
    
    override func sceneDidLoad() {
        scoreLabel.fontColor = UIColor.black
        scoreLabel.fontSize = 20
        scoreLabel.fontName = "Times New Roman"
        scoreLabel.position = CGPoint(x: 5, y: size.height - 80)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.zPosition = 1.0
        highScoreLabel.fontColor = UIColor.black
        highScoreLabel.fontSize = 20
        highScoreLabel.fontName = "Times New Roman"
        highScoreLabel.position = CGPoint(x: 5, y: size.height - 40)
        highScoreLabel.horizontalAlignmentMode = .left
        highScoreLabel.verticalAlignmentMode = .center
        highScoreLabel.zPosition = 1.0
        addChild(scoreLabel)
        addChild(highScoreLabel)
        self.backgroundColor = .white
        self.physicsWorld.contactDelegate = self
        let userDefaults = UserDefaults.standard
        highScore = userDefaults.integer(forKey: "highScore")
        highScoreLabel.text = "High Score: \(highScore)"
        pauseButton.texture = SKTexture(imageNamed: "pause")
        restartButton.texture = SKTexture(imageNamed: "restart")
        homeButton.texture = SKTexture(imageNamed: "home")
        circleSize = Double(size.width / 12)
        player.size = CGSize(width: circleSize, height: circleSize)
        player.run(SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2), duration: 0.0))
        addChild(player)
        player.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addTopFlower),SKAction.wait(forDuration: 1.25)])))
        player.run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addBottomFlower),SKAction.wait(forDuration: 1.25)])))
        addChild(pauseButton)
        addChild(restartButton)
        addChild(homeButton)
        restartButton.isHidden = true
        homeButton.isHidden = true
        pauseButton.zPosition = 1.0
        restartButton.zPosition = 1.0
        homeButton.zPosition = 1.0
        pauseButton.position = CGPoint(x: 40, y: 40)
        restartButton.position = CGPoint(x: (size.width / 2) - 80, y: size.height / 2)
        homeButton.position = CGPoint(x: (size.width / 2) + 80, y: size.height / 2)
        player.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(circleSize / 2))
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = flowerCategory | coinCategory
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.isDynamic = true

    }
    override func update(_ currentTime: TimeInterval) {
        scoreLabel.text = "Score: \(score)"
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyB.categoryBitMask == flowerCategory) &&
            (contact.bodyA.categoryBitMask == playerCategory) {
            homePressed()
        }
        if (contact.bodyA.categoryBitMask == playerCategory) &&
            (contact.bodyB.categoryBitMask == coinCategory) {
            contact.bodyB.node?.removeFromParent()
            score += 1
            scoreLabel.fontSize += 1
        }
    }
    func updateHighScore() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(score, forKey: "highScore")
        userDefaults.synchronize()
    }
    func pausePressed() {
        if self.isPaused {
            self.isPaused = false
            restartButton.isHidden = true
            homeButton.isHidden = true
        } else {
            self.isPaused = true
            restartButton.isHidden = false
            homeButton.isHidden = false
        }
    }
    func restartPressed() {
        if score > highScore{
            updateHighScore()
        }
        let newScene = GameScene(size: self.size)
        newScene.myView = self.myView
        myView.presentScene(newScene, transition: SKTransition())
    }
    func homePressed() {
        if score > highScore{
            updateHighScore()
        }
        myView.myViewController.goBackHome()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        if pauseButton.frame.contains(touchLocation) && pauseButton.isHidden == false{
            pausePressed()
        } else if restartButton.frame.contains(touchLocation) && self.isPaused{
            restartPressed()
        } else if homeButton.frame.contains(touchLocation) && self.isPaused{
            homePressed()
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
        let isle = Int(arc4random_uniform(3))
        if coinCheck == 5 {
            fallingFlower = SKSpriteNode(imageNamed: "coin")
            fallingFlower.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(circleSize))
            fallingFlower.physicsBody?.categoryBitMask = coinCategory
        } else {
            fallingFlower = SKSpriteNode(imageNamed: "redFlower")
            fallingFlower.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(circleSize * 0.8))
            fallingFlower.physicsBody?.categoryBitMask = flowerCategory
        }
        fallingFlower.physicsBody?.isDynamic = false
        fallingFlower.size = CGSize(width: 2 * circleSize, height: 2 * circleSize)
        if isle == 0 {
            fallingFlower.run(SKAction.moveBy(x: size.width / 6, y: size.height + (CGFloat)(circleSize), duration: 0.0))
        } else if isle == 1 {
            fallingFlower.run(SKAction.moveBy(x: size.width / 2, y: size.height + (CGFloat)(circleSize), duration: 0.0))
        } else {
            fallingFlower.run(SKAction.moveBy(x: 5 * size.width / 6, y: size.height + (CGFloat)(circleSize), duration: 0.0))
        }
        addChild(fallingFlower)
        let speed = TimeInterval(2 + Float(arc4random_uniform(4)) / 2)
        fallingFlower.run(SKAction.sequence([SKAction.moveTo(y: -(CGFloat)(circleSize), duration: speed),SKAction.removeFromParent()]))
    }
    func addBottomFlower() {
        var risingFlower : SKSpriteNode!
        let coinCheck = Int(arc4random_uniform(6))
        if coinCheck == 5 {
            risingFlower = SKSpriteNode(imageNamed: "coin")
            risingFlower.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(circleSize))
            risingFlower.physicsBody?.categoryBitMask = coinCategory
        } else {
            risingFlower = SKSpriteNode(imageNamed: "redFlower")
            risingFlower.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(circleSize * 0.8))
            risingFlower.physicsBody?.categoryBitMask = flowerCategory
        }
        risingFlower.physicsBody?.isDynamic = false
        risingFlower.size = CGSize(width: 2 * circleSize, height: 2 * circleSize)
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
        risingFlower.run(SKAction.sequence([SKAction.moveTo(y: size.height + (CGFloat)(circleSize), duration: speed),SKAction.removeFromParent()]))
    }
}
