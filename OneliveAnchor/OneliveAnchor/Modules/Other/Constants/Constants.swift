

import Foundation
import UIKit

//UI设计图基准（iPhone6）
public let oDesignResolutionWidth: CGFloat = 375.0
public let oDesignResolutionHeight: CGFloat = 667.0

//MARK: 设备相关
/// 系统版本
public let oSysVersion = UIDevice.current.systemVersion


/// 是否手机
public let oIsIPhone = UIDevice.current.userInterfaceIdiom == .phone

/// 是否刘海屏（利用safeAreaInsets.bottom > 0 来判断是否是iPhoneX系列）
public func oIsIPhoneX() -> Bool {
    guard let window = UIApplication.shared.delegate?.window else {
        return false
    }
    guard #available(iOS 11.0, *) else {
        return false
    }
    return window!.safeAreaInsets.bottom > 0.0
}


//MARK: 视图相关

/// 屏幕bounds
public var oScreenBounds = UIScreen.main.bounds

/// 屏幕size
public var oScreenSize = UIScreen.main.bounds.size

/// 屏幕宽
public var oScreenWidth = UIScreen.main.bounds.size.width

/// 屏幕高
public var oScreenHeight = UIScreen.main.bounds.size.height

/// 状态栏高
public let oStatusBarHeight = UIApplication.shared.statusBarFrame.size.height

/// 导航栏高
public let oNavBarHeight = CGFloat(44.0)

/// 状态栏+导航栏的高度
public let oStatusAndNavBarHeight = (oStatusBarHeight + oNavBarHeight)

/// 底部菜单栏高度
public let oTabBarHeight = oIsIPhoneX() ? CGFloat(83.0) : CGFloat(49.0)

/// 通用工具栏高度
public let oToolbarHeight = CGFloat(40.0)

/// keyWindow
public func oKeyWindow() -> UIWindow? {
    return UIApplication.shared.windows.first { $0.isKeyWindow }
}

/// 顶部安全区域高
public func oSafeAreaTopHeight() -> CGFloat {
    if #available(iOS 11.0, *) { //47
        if let height = UIApplication.shared.keyWindow?.safeAreaInsets.top {
            return height
        }
    }
    return 20.0;
}

/// 底部安全区域高
public func oSafeAreaBottomHeight() -> CGFloat {
    if #available(iOS 11.0, *) { //34
        if let height = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            return height
        }
    }
    return 0.0;
}

/// 键盘高
public let oKeyboardHeight = CGFloat(252.0)

/// 键盘最小高度
public let oKeyboardMinHeight = CGFloat(216.0)

/// 不同屏幕相对于设计图适配宽度比例
public let oScreenWidthRatio = UIScreen.main.bounds.size.width / oDesignResolutionWidth

/// 不同屏幕相对于设计图适配高度比例
public let oScreenHeightRatio = UIScreen.main.bounds.size.height / oDesignResolutionHeight

/// 返回自适应的宽度大小
public func oScaleWidth(size: CGFloat) -> CGFloat {
    return size * oScreenWidthRatio;
}

/// 返回自适应的高度大小
public func oScaleHeight(size: CGFloat) -> CGFloat {
    return size * oScreenHeightRatio;
}

/// 返回自适应的字体大小
public func oScaleFontSize(size: CGFloat) -> CGFloat {
    return size * oScreenWidthRatio;
}



/// 调试方法打印输出
public func debugPrint<T>(_ message: T, filePath: String = #file, function:String = #function, rowCount: Int = #line) {
#if DEBUG
    let fileName = (filePath as NSString).lastPathComponent
    print("<" + fileName + ":" + "\(rowCount)" + "> " + "\(function)" + ": \(message)")
#endif
}

public func oPrint<T>(_ message: T) {
#if DEBUG
    print(message)
#endif
}



//MARK: 图片相关

public func reSizeImage(_ image: UIImage?, to reSize: CGSize) -> UIImage? {
    UIGraphicsBeginImageContext(CGSize(width: reSize.width, height: reSize.height))
    image?.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
    let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return reSizeImage
}
