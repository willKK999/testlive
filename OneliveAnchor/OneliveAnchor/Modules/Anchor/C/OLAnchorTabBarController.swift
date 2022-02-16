

import UIKit

class OLAnchorTabBarController: UITabBarController {

    var viewControllerNames = [OLHomeViewController(),OLLiveViewController(),OLMeViewController()]
    var titles = ["首页","开播","我的"]
    var images = ["tabbar_home_normal", "tabbar_live_normal", "tabbar_me_normal"]
    var selectedImages = ["tabbar_home_selected", "tabbar_live_selected", "tabbar_me_selected"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubViewControllerWithTitles(titles: self.titles)
        
         tabBar.tintColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
        tabBar.unselectedItemTintColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
        tabBar.backgroundColor = UIColor.white
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 1)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowOpacity = 0.5
        
        /// tabBarItem字体
        tabBarItem.setTitleTextAttributes([.font: UIFont.fontRegular(10)], for: .normal)
        tabBarItem.setTitleTextAttributes([.font: UIFont.fontRegular(10)], for: .selected)
        selectedIndex = 0
        
    }
    
    func setSubViewControllerWithTitles(titles:[String]) {
       
        for i in 0...(titles.count-1) {
            let vc  = setSubViewController(childViewController: viewControllerNames[i], title: titles[i], imageNamed: images[i], selectedImageNamed: selectedImages[i])
            let nav = OLNavigationController(rootViewController: vc)
            addChild(nav)
        }
     
    }
    
    func setSubViewController(childViewController: UIViewController, title: String, imageNamed: String, selectedImageNamed: String, isLocal: Bool = true) -> UIViewController {
      
        childViewController.tabBarItem.title = title
        if isLocal {
            childViewController.tabBarItem.image = UIImage(named: imageNamed)?.withRenderingMode(.alwaysOriginal)
            childViewController.tabBarItem.selectedImage = UIImage(named: selectedImageNamed)?.withRenderingMode(.alwaysOriginal)
        }else {
            childViewController.tabBarItem.image = loadImage(urlString: imageNamed)?.withRenderingMode(.alwaysOriginal)
            childViewController.tabBarItem.selectedImage = loadImage(urlString: selectedImageNamed)?.withRenderingMode(.alwaysOriginal)
        }
        return  childViewController
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
