

import Foundation
import UIKit

class OLNavigationManager {
    static let shared = { OLNavigationManager() }()
    
    func getMainPageNavController() -> UINavigationController? {
        let nav = (UIApplication.shared.delegate as? AppDelegate)?.mainPageNavController
        return nav
    }
    
    func getCurrentPageNavController() -> UINavigationController? {
        var nav = (UIApplication.shared.delegate as? AppDelegate)?.mainPageNavController
        for controller in nav!.viewControllers {
            if controller is UINavigationController {
                nav = (controller  as! OLNavigationController)
                return nav
            }else if controller is UITabBarController {
                let tabBarController: UITabBarController = controller as! UITabBarController
                if tabBarController.selectedViewController is UINavigationController {
                    nav = (tabBarController.selectedViewController  as! OLNavigationController)
                    return nav
                }
            }
        }
        if nav?.presentedViewController != nil && (nav?.presentedViewController is UINavigationController) {
            return nav?.presentedViewController as? UINavigationController
        }
        return nav
    }
    
    func mainNavControllerPushVC(_ vc: UIViewController?, animated: Bool) {
        let navController = getMainPageNavController()
        if let vc = vc {
            navController?.pushViewController(vc, animated: animated)
        }
    }
    
    func pushVC(_ vc: UIViewController?, animated: Bool) {
        let navController = getCurrentPageNavController()
        if let vc = vc {
            navController?.pushViewController(vc, animated: animated)
        }
    }
    
}


extension OLNavigationManager {
    
    func currentPagePopVC(_ animated: Bool = true) {
        let navController = getCurrentPageNavController()
        navController?.popViewController(animated: animated)
    }
    
    func currentPagePushToLanguageVC() {
        let languageVC = OLLanguageViewController()
        self.pushVC(languageVC, animated: true)
    }
    
}
