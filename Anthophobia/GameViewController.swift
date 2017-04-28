import Foundation
import UIKit
import SpriteKit
class GameViewController : UIViewController {
    var gameView : SKView? = nil
    override func viewDidLoad() {
        let screenSize : CGSize = self.view.frame.size
        gameView = SKView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        gameView?.presentScene(GameScene(size: screenSize))
    }
}
