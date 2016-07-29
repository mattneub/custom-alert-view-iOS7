import UIKit

class ViewController: UIViewController {
    
    @IBAction func doButton (_ sender:AnyObject!) {
        let vc = CustomAlertViewController()
        self.present(vc, animated: true)
    }


}
