

import Foundation
import UIKit

/// 可重新排列UIButton图片、文字位置
///
open class OLReLayoutButton: UIButton {

    public enum LayoutStyle {
        /// 只有文字
        case text
        /// 左文字右图片
        case text_Image
        /// 右图片左文字
        case image_Text
        /// 只有图片
        case image
        /// 文字上图片下
        case text_Top_Image_Bottom
        /// 图片上文字下
        case image_Top_Text_Bottom
    }

    private var layoutStyle: LayoutStyle?
    private var space: CGFloat = 0

    public convenience init(style: LayoutStyle, space: CGFloat = 0) {
        self.init(type: .custom)
        self.layoutStyle = style
        self.space = space
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        if let layoutStyle = layoutStyle {
            switch layoutStyle {
            case .image:
                break
            case .text:
                break
            case .image_Text:
                titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: 0)
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
            case .text_Image:
                let image = self.image(for: .normal)!
                let titleSize = OLReLayoutButton.getTheSizeOfTitle(title: (self.titleLabel?.text!)!, font: (self.titleLabel?.font)!)

                let imageTop = (self.frame.size.height - image.size.height) * 0.5
                let titleTop = (self.frame.size.height - titleSize.height) * 0.5

                let titleLeft = (self.frame.size.width-image.size.width-titleSize.width-space)/2-image.size.width
                let imageLeft = (self.frame.size.width-image.size.width-titleSize.width-space)/2+titleSize.width+space

                self.contentHorizontalAlignment = .left
                self.contentVerticalAlignment = .top

                self.imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: 0, right: 0)
                self.titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: 0, right: 0)
            case .image_Top_Text_Bottom:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWidth = imageView?.bounds.width ?? 0
                let titleWidth = titleLabel?.bounds.width ?? 0
                let imageTop = (self.frame.size.height-titleHeight-imageHeight-space)/2
                let titleTop = imageTop+imageHeight+space
                let imageLeft = (self.frame.size.width-imageWidth)/2
                // 这里减了image.size.width，因为title的left是以image的left为参考
                let titleLeft = (self.frame.size.width-titleWidth)/2-imageWidth

                self.contentHorizontalAlignment = .left
                self.contentVerticalAlignment = .top

                imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: 0, right: 0)
                titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: 0, right: 0)
            case .text_Top_Image_Bottom:
                let titleHeight = titleLabel?.bounds.height ?? 0
                let imageHeight = imageView?.bounds.height ?? 0
                let imageWidth = imageView?.bounds.width ?? 0
                let titleWidth = titleLabel?.bounds.width ?? 0
                titleEdgeInsets = UIEdgeInsets(
                    top: -(titleHeight + space) * 0.5,
                    left: -imageWidth * 0.5,
                    bottom: space,
                    right: imageWidth * 0.5)
                imageEdgeInsets = UIEdgeInsets(
                    top: (imageHeight + space),
                    left: titleWidth * 0.5,
                    bottom: 0,
                    right: -titleWidth * 0.5)
            }
        }
    }
}

extension OLReLayoutButton {

    ///Gets the size of the title
    public class func getTheSizeOfTitle(title: String, font: UIFont) -> CGSize {
        let size: CGSize = CGSize.init(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        let rect: CGRect = title.boundingRect(
            with: size,
            options: NSStringDrawingOptions.usesFontLeading,
            attributes: [NSAttributedString.Key.font: font],
            context: nil)
        return rect.size
    }
}
