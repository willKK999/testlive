

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var mainPageNavController: OLNavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        let tabBarVC = OLTabBarViewController()
        self.mainPageNavController = OLNavigationController(rootViewController: tabBarVC)
        window.rootViewController = self.mainPageNavController
        window.makeKeyAndVisible()
        self.window = window
        
        //检查是否登录
//        if !OLLoginManager.shared.isLogin() {
            //进行登录
//            OLAPIManager.shared.visitorLogin {  (result) in
//              [weak self] guard let self = self else {return}
//                if result.isSuccess {
//                    
//                }
//            }
//        }
        
        return true
    }



}

