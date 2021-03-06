import UIKit

// MARK: - SPCardTransitioningManager: Manages card-like presentation of a view controller
//
final class SPCardTransitioningManager: NSObject, UIViewControllerTransitioningDelegate {
    private weak var presentationController: SPCardPresentationController?

    /// Delegate for presentation (and dismissal) related events
    ///
    weak var presentationDelegate: SPCardPresentationControllerDelegate?

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = SPCardPresentationController(presentedViewController: presented,
                                                                  presenting: presenting)
        presentationController.presentationDelegate = presentationDelegate
        self.presentationController = presentationController
        return presentationController
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SPCardPresentationAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SPCardDismissalAnimator()
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return presentationController?.transitionInteractor
    }
}
