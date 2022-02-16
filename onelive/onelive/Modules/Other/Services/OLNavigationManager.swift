

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
    
    func currentPagePushToSearchVC() {
        let SearchVC = OLSearchViewController()
        self.pushVC(SearchVC, animated: true)
    }
    
    
    func mainPagePushToGuardianInstructionsVC() {
        let GuardianInstructionsVC = OLGuardianInstructionsController()
        self.mainNavControllerPushVC(GuardianInstructionsVC, animated: true)
    }
    
}

//MARK: 直播
extension OLNavigationManager {
    
    func pushToLiveDetailVC(model: OLLiveItemModel) {
        let liveDetailVC = OLLiveDetailParentViewController()
        liveDetailVC.currentLive = model
        self.mainNavControllerPushVC(liveDetailVC, animated: true)
    }
    
}

//MARK: 我的
extension OLNavigationManager {
    
    func pushToInformationVC() {
        let infoVC = OLMeInformationViewController()
        self.mainNavControllerPushVC(infoVC, animated: true)
    }
    
    func pushToEditInfoVC() {
        let editInfoVC = OLEditInfoViewController()
        self.mainNavControllerPushVC(editInfoVC, animated: true)
    }
    
    func pushToEditNicknameVC() {
        let editNicknameVC = OLEditNicknameViewController()
        self.mainNavControllerPushVC(editNicknameVC, animated: true)
    }
    
    func pushToEditSignatureVC() {
        let editSignatureVC = OLEditSignatureViewController()
        self.mainNavControllerPushVC(editSignatureVC, animated: true)
    }
    
    func pushToSettingVC() {
        let settingVC = OLMeSettingViewController()
        self.mainNavControllerPushVC(settingVC, animated: true)
    }
    
    func pushToAccountsAndSecurityVC() {
        let accountsAndSecurityVC = OLAccountsAndSecurityViewController()
        self.mainNavControllerPushVC(accountsAndSecurityVC, animated: true)
    }
    
    func pushToPhoneAuthenticationVC() {
        let phoneAuthenticationVC = OLPhoneAuthenticationViewController()
        self.mainNavControllerPushVC(phoneAuthenticationVC, animated: true)
    }
    
    func pushToSetupHideVC() {
        let setupHideVC = OLSetupHideViewController()
        self.mainNavControllerPushVC(setupHideVC, animated: true)
    }
    
    func pushToSetupLanguageVC() {
        let setupLanguageVC = OLSetupLanguageViewController()
        self.mainNavControllerPushVC(setupLanguageVC, animated: true)
    }
    
    func pushToSetupPayPasswordVC() {
        let setupPayPasswordVC = OLSetupPayPasswordViewController()
        self.mainNavControllerPushVC(setupPayPasswordVC, animated: true)
    }
    
    func pushToMineLevelVC() {
        let mineLevelVC = OLMineLevelViewController()
        self.mainNavControllerPushVC(mineLevelVC, animated: true)
    }
    
    func pushToMineWalletVC() {
        let mineWalletVC = OLMineWalletViewController()
        self.mainNavControllerPushVC(mineWalletVC, animated: true)
    }
    
    func pushToMineFollowVC() {
        let mineFollowVC = OLMineFollowViewController()
        self.mainNavControllerPushVC(mineFollowVC, animated: true)
    }
    
    func pushToMineFansVC() {
        let mineFansVC = OLMineFansViewController()
        self.mainNavControllerPushVC(mineFansVC, animated: true)
    }
    
    func pushToMineActivityVC() {
        let mineActivityVC = OLMineActivityViewController()
        self.mainNavControllerPushVC(mineActivityVC, animated: true)
    }
    
    func pushToMinePWRecordVC() {
        let minePWRecordVC = OLMinePWRecordViewController()
        self.mainNavControllerPushVC(minePWRecordVC, animated: true)
    }
    
    func pushToForDiamondVC() {
        let forDiamondVC = OLForDiamondViewController()
        self.mainNavControllerPushVC(forDiamondVC, animated: true)
    }
    
    func pushToMineMessageVC() {
        let mineMessageVC = OLMineMessageViewController()
        self.mainNavControllerPushVC(mineMessageVC, animated: true)
    }
    
    func pushToSystemMessageVC() {
        let systemMessageVC = OLSystemMessageViewController()
        self.mainNavControllerPushVC(systemMessageVC, animated: true)
    }
    
    func pushToMineNobleVC() {
        let mineNobleVC = OLMineNobleViewController()
        self.mainNavControllerPushVC(mineNobleVC, animated: true)
    }
    
    func pushToNobleProblemVC() {
        let nobleProblemVC = OLNobleProblemViewController()
        self.mainNavControllerPushVC(nobleProblemVC, animated: true)
    }
}
 
