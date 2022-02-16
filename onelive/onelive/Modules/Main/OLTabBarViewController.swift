

import UIKit

class OLTabBarViewController: UITabBarController {

    var liveTabItemList: [OLLiveTabItemModel] = []
    var viewControllerNames = [OLLiveViewController(),OLGamesViewController(),OLPayViewController(),OLMeViewController()]
    var titles = ["直播","游戏","充值","我的"]
    var images = ["tabbar_live_normal","tabbar_games_normal","tabbar_pay_normal","tabbar_me_normal"]
    var selectedImages = ["tabbar_live_selected","tabbar_games_selected","tabbar_pay_selected","tabbar_me_selected"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载数据
//        OLAPIManager.shared.getLiveTabItemList { [weak self]  result in
//            guard let self = self else {return}
//            if result.isSuccess {
//                if let list = result.data {
//                    self.liveTabItemList = list
//                    self.setSubViewControllerWithLiveTabItems(list: list)
//                }
//            }else {
//               
//            }
//        }
        
        self.setSubViewControllerWithTitles(titles: self.titles)
        
        self.tabBar.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        self.tabBar.unselectedItemTintColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        self.tabBar.backgroundColor = UIColor.white
        self.tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.tabBar.layer.shadowRadius = 2
        self.tabBar.layer.shadowOpacity = 0.5
        
        /// tabBarItem字体
        tabBarItem.setTitleTextAttributes([.font: UIFont.fontRegular(10)], for: .normal)
        tabBarItem.setTitleTextAttributes([.font: UIFont.fontRegular(10)], for: .selected)
        
        
        selectedIndex = 0
    }
    
    func setSubViewControllerWithLiveTabItems(list:[OLLiveTabItemModel]) {
        var viewControllers: [UIViewController] = []
        for item in list {
            switch item.iconCode {
            case "live":
                //首页 直播
                let vc  = setSubViewController(rootViewController: viewControllerNames[0], title: item.name, imageNamed: item.iconUnselectedUrl, selectedImageNamed: item.iconSelectedUrl, isLocal: false)
                viewControllers.append(vc)
            case "game":
                //游戏
                let vc = setSubViewController(rootViewController: viewControllerNames[1], title: item.name, imageNamed: item.iconUnselectedUrl, selectedImageNamed: item.iconSelectedUrl, isLocal: false)
                viewControllers.append(vc)
            case "recharge":
                //充值
                let vc = setSubViewController(rootViewController: viewControllerNames[2], title: item.name, imageNamed: item.iconUnselectedUrl, selectedImageNamed: item.iconSelectedUrl, isLocal: false)
                viewControllers.append(vc)
            case "my":
                //我的
                let vc = setSubViewController(rootViewController: viewControllerNames[3], title: item.name, imageNamed: item.iconUnselectedUrl, selectedImageNamed: item.iconSelectedUrl, isLocal: false)
                viewControllers.append(vc)
            default:
                break
            }
        }
        self.viewControllers = viewControllers;
    }
    
    func setSubViewControllerWithTitles(titles:[String]) {
        var viewControllers: [UIViewController] = []
        for i in 0...(titles.count-1) {
            let vc  = setSubViewController(rootViewController: viewControllerNames[i], title: titles[i], imageNamed: images[i], selectedImageNamed: selectedImages[i])
            viewControllers.append(vc)
        }
        self.viewControllers = viewControllers;
    }
    
    func setSubViewController(rootViewController: UIViewController, title: String, imageNamed: String, selectedImageNamed: String, isLocal: Bool = true) -> UIViewController {
        let viewController = OLNavigationController(rootViewController: rootViewController)
        viewController.tabBarItem.title = title
        if isLocal {
            viewController.tabBarItem.image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysOriginal)
            viewController.tabBarItem.selectedImage = UIImage(named: selectedImageNamed)?.withRenderingMode(.alwaysOriginal)
        }else {
            viewController.tabBarItem.image = loadImage(urlString: imageNamed)?.withRenderingMode(.alwaysOriginal)
            viewController.tabBarItem.selectedImage = loadImage(urlString: selectedImageNamed)?.withRenderingMode(.alwaysOriginal)
        }
        return viewController
    }

    func loadImage(urlString: String) -> UIImage? {
        let url = URL(string: urlString)!
        let data = try? Data(contentsOf: url)
        let image = UIImage(data: data!,scale: 1.0)
        return reSizeImage(image, to: CGSize(width: 25, height: 25)) 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
