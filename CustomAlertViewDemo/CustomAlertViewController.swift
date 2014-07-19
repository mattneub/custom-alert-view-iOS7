
import UIKit

class CustomAlertViewController : UIViewController {
    var transitioner : CAVTransitioner
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.transitioner = CAVTransitioner()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self.transitioner
    }
    
    @IBAction func doDismiss(sender:AnyObject?) {
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}