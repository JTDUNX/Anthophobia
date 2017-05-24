import UIKit

class ViewController: UIViewController {
    @IBOutlet var highScoreLabel: UILabel!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        highScoreLabel.text = "High Score: \(userDefaults.integer(forKey: "highScore"))"
    }
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        highScoreLabel.text = "High Score: \(userDefaults.integer(forKey: "highScore"))"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

