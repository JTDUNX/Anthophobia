import Foundation
import UIKit
import SpriteKit
class GameViewController : UIViewController {
    var gameView : SKView? = nil
    override func viewDidLoad() {
        let screenSize : CGSize = self.view.frame.size
        let myGame = GameScene(size: screenSize)
        gameView = SKView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        myGame.myView = gameView
        gameView?.presentScene(myGame)
        view.addSubview(gameView!)
    }
}
