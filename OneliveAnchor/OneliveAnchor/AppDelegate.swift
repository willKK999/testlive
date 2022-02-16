

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var mainPageNavController: OLNavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        showLogin()
        self.window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showRoleNotificationClick), name: RoleNotification, object: nil)
        
        return true
    }
    
    @objc func showRoleNotificationClick(notification : Notification) {
        if let userInfo = notification.userInfo {
            if userInfo["role"] as! String == "anchor" {
                showAnchor()
            }else {
                showManager()
            }
        }
    }
    //登录页
    func showLogin() {
        self.mainPageNavController = OLNavigationController(rootViewController:  OLLoginViewController())
        self.window?.rootViewController = self.mainPageNavController
    }
    //主播
    func showAnchor() {
        self.mainPageNavController = OLNavigationController(rootViewController:  OLAnchorTabBarController())
        self.window?.rootViewController = self.mainPageNavController
    }
    //家族长
    func showManager() {
        self.mainPageNavController = OLNavigationController(rootViewController:  OLManagerViewController())
        self.window?.rootViewController = self.mainPageNavController
    }


}
