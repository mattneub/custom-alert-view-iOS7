
import UIKit
import QuartzCore

class CAVTransitioner : NSObject, UIViewControllerTransitioningDelegate {
    func presentationControllerForPresentedViewController(presented: UIViewController!, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController!) -> UIPresentationController! {
        return MyPresentationController(presentingViewController: presenting, presentedViewController: presented)
    }
}

class MyPresentationController : UIPresentationController {
    
    func decorateView(v:UIView) {
        v.layer.borderColor = UIColor.blueColor().CGColor
        v.layer.borderWidth = 2
        v.layer.cornerRadius = 8
        
        let m1 = UIInterpolatingMotionEffect(keyPath:"center.x", type:.TiltAlongHorizontalAxis)
        m1.maximumRelativeValue = 10.0
        m1.minimumRelativeValue = -10.0
        let m2 = UIInterpolatingMotionEffect(keyPath:"center.y", type:.TiltAlongVerticalAxis)
        m2.maximumRelativeValue = 10.0
        m2.minimumRelativeValue = -10.0
        let g = UIMotionEffectGroup()
        g.motionEffects = [m1,m2]
        v.addMotionEffect(g)
    }
    
    override func presentationTransitionWillBegin() {
        self.decorateView(self.presentedView())
        let vc = self.presentingViewController
        let v = vc.view
        let con = self.containerView
        let shadow = UIView(frame:con.bounds)
        shadow.backgroundColor = UIColor(white:0, alpha:0.4)
        shadow.alpha = 0
        con.insertSubview(shadow, atIndex: 0)
        shadow.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        let tc = vc.transitionCoordinator()
        tc.animateAlongsideTransition({
            _ in
            shadow.alpha = 1
            }, completion: {
                _ in
                v.tintAdjustmentMode = .Dimmed
            })
    }
    
    override func dismissalTransitionWillBegin() {
        let vc = self.presentingViewController
        let v = vc.view
        let con = self.containerView
        let shadow = (con.subviews as [UIView])[0]
        let tc = vc.transitionCoordinator()
        tc.animateAlongsideTransition({
            _ in
            shadow.alpha = 0
            }, completion: {
                _ in
                v.tintAdjustmentMode = .Automatic
            })
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        // we want to center the presented view at its "native" size
        // I can think of a lot of ways to do this,
        // but here we just assume that it *is* its native size
        let v = self.presentedView()
        let con = self.containerView
        v.center = CGPointMake(con.bounds.midX, con.bounds.midY)
        return v.frame.integerRect
    }
    
    override func containerViewWillLayoutSubviews() {
        // deal with future rotation
        // again, I can think of more than one approach
        let v = self.presentedView()
        v.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleLeftMargin | .FlexibleRightMargin
        v.setTranslatesAutoresizingMaskIntoConstraints(true)
    }
    
}

extension CAVTransitioner : UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return self
    }
}

extension CAVTransitioner : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning!)
        -> NSTimeInterval {
            return 0.25
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning!) {
        let vc1 = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let vc2 = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        let con = transitionContext.containerView()
        
        let r1start = transitionContext.initialFrameForViewController(vc1)
        let r2end = transitionContext.finalFrameForViewController(vc2)
        
        let v1 = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let v2 = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        // we are using the same object (self) as animation controller
        // for both presentation and dismissal
        // so we have to distinguish the two cases
        
        if v2 != nil { // presenting
            con.addSubview(v2)
            let scale = CGAffineTransformMakeScale(1.6,1.6)
            v2.transform = scale
            v2.alpha = 0
            UIView.animateWithDuration(0.25, animations: {
                v2.alpha = 1
                v2.transform = CGAffineTransformIdentity
                }, completion: {
                    _ in
                    transitionContext.completeTransition(true)
                })
        } else {
            UIView.animateWithDuration(0.25, animations: {
                v1.alpha = 0
                }, completion: {
                    _ in
                    transitionContext.completeTransition(true)
                })
        }
        
    }
    
}

