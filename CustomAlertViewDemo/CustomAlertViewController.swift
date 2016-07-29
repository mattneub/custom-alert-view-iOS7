
import UIKit

class CustomAlertViewController : UIViewController {
    var transitioner : CAVTransitioner
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.transitioner = CAVTransitioner()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init() {
        self.init(nibName:"CustomAlertViewController", bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    @IBAction func doDismiss(_ sender:AnyObject?) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
