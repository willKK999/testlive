

import UIKit


extension UIFont {
    public enum PingFangSCFontName {
        static let Ultralight = "PingFangSC-Ultralight"
        static let Thin = "PingFangSC-Thin"
        static let Light = "PingFangSC-Light"
        static let Regular = "PingFangSC-Regular"
        static let Medium = "PingFangSC-Medium"
        static let Semibold = "PingFangSC-Semibold"
    }
    
    /// 常规体
    public static func fontRegular(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: UIFont.PingFangSCFontName.Regular, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: .light)
        }
    }
    
    /// 中黑体
    public static func fontMedium(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: UIFont.PingFangSCFontName.Medium, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: .light)
        }
    }
    
    ///中粗体
    public static func fontSemibold(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: UIFont.PingFangSCFontName.Semibold, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: .light)
        }
    }
    
    /// 细体
    public static func fontLight(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: UIFont.PingFangSCFontName.Light, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: .light)
        }
    }
    
    /// 纤细体
    public static func fontThin(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: UIFont.PingFangSCFontName.Thin, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: .light)
        }
    }
    
    /// 极细体
    public static func fontUltralight(_ fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: UIFont.PingFangSCFontName.Ultralight, size: fontSize) {
            return font
        } else {
            return UIFont.systemFont(ofSize: fontSize, weight: .light)
        }
    }
}
