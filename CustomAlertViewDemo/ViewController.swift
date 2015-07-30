import UIKit

class ViewController: UIViewController {
    @IBAction func doButton (sender:AnyObject!) {
        let vc = CustomAlertViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }


}
