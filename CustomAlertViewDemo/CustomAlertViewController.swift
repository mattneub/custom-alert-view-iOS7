
import UIKit

class CustomAlertViewController : UIViewController {
    var transitioner : CAVTransitioner
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.transitioner = CAVTransitioner()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init() {
        self.init(nibName:"CustomAlertViewController", bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    @IBAction func doDismiss(sender:AnyObject?) {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
}