import UIKit

class ViewController: UIViewController {
    
    @IBAction func doButton (_ sender:Any) {
        let vc = CustomAlertViewController()
        self.present(vc, animated: true)
    }


}
