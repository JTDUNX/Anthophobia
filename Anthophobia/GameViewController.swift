import Foundation
import UIKit
import SpriteKit
class GameViewController : UIViewController {
    var myGameView : GameView? = GameView()
    override func viewDidLoad() {
        let screenSize : CGSize = self.view.frame.size
        let myGame = GameScene(size: screenSize)
        myGameView = GameView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        myGame.myView = myGameView
        myGameView?.presentScene(myGame)
        myGameView?.myViewController = self
        myGame.myView = myGameView
        view.addSubview(myGameView!)
    }
    func goBackHome() {
        //go to the home view controller
        
    }
}
