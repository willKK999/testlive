

import UIKit

fileprivate let separatorLineViewTag = 9999

class OLNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    /// 点击某个VC的返回按钮的回调
    var vcBackActionBlock: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactivePopGestureRecognizer?.delegate = self;
        
        configNormalNavBarAppearance()
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "arrow_left_back"), for: .normal)
            button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            button.sizeToFit()
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
            button.contentHorizontalAlignment = .left
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)

            button.frame = CGRect(x: 0, y: 0, width: (button.currentImage?.size.width)!+15, height: (button.currentImage?.size.height)!+5)
            viewController.navigationItem.leftBarButtonItem?.customView?.frame = button.frame

            viewController.hidesBottomBarWhenPushed = true
        }

        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func backAction() {
        if self.vcBackActionBlock != nil {
            vcBackActionBlock!()
        }else {
            self.popViewController(animated: true)
        }
    }
    
    
    /// 配置普通模式导航栏样式
    public func configNormalNavBarAppearance() {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            //重置背景和阴影属性为不透明
            appearance.configureWithOpaqueBackground()
            
            //设置导航栏背景色
            appearance.backgroundColor =  UIColor(hexString: "#FFFFFF")
            navigationBar.isTranslucent = false

            //设置导航栏标题字体颜色
            appearance.titleTextAttributes = [.foregroundColor: UIColor(hexString: "#333333"),
                                              .font: UIFont.fontMedium(18)]
           
            //设置导航栏按钮颜色
            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(hexString: "#666666"),
                                                           .font: UIFont.fontMedium(12),
                                                           .shadow: shadow]
            appearance.buttonAppearance = buttonAppearance
            
            //静止样式
            navigationBar.standardAppearance = appearance
            //滚动样式
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
            
            //设置导航栏底部分割线颜色
            setSeparatorHidden(isHidden: false)
        } else {
            //设置导航栏背景色
            navigationBar.barTintColor = UIColor(hexString: "#FFFFFF")
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(nil, for: .default)
            
            //设置导航栏标题字体颜色
            navigationBar.titleTextAttributes = [.foregroundColor: UIColor(hexString: "#333333"),
                                                 .font: UIFont.fontMedium(18)]

            //设置导航栏按钮颜色
            navigationBar.tintColor = UIColor(hexString: "#666666")

            //设置导航栏底部分割线颜色
            setSeparatorHidden(isHidden: false)
        }
    }
    /// 设置导航栏底部分割线 显示 / 隐藏
    public func setSeparatorHidden(isHidden: Bool) {
        if isHidden {
            if #available(iOS 13.0, *) {
                navigationBar.standardAppearance.shadowImage = UIImage()
            } else {
                navigationBar.shadowImage =  UIImage()
            }
            
            for (_, subview) in navigationBar.subviews.enumerated() {
                if subview.tag == separatorLineViewTag {
                    subview.removeFromSuperview()
                }
            }
        } else {
            if #available(iOS 13.0, *) {
                navigationBar.standardAppearance.shadowImage =  UIImage()
            } else {
                navigationBar.shadowImage =  UIImage()
            }

            let lineView = UIView(frame: CGRect(x: 0, y: oNavBarHeight-0.5, width: oScreenWidth, height: 0.5))
            lineView.tag = separatorLineViewTag
            lineView.backgroundColor = UIColor(hexString: "#F5F5F5")
            navigationBar.insertSubview(lineView, at: 0)
        }
    }
}
