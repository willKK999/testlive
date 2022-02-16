

import UIKit

class OLSearchTextField: UITextField {

    //左视图的位置和大小
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftRect = super.leftViewRect(forBounds: bounds)
        leftRect.origin.x = 12
        leftRect.size.height = 18
        leftRect.size.width = 18
        return leftRect
    }
    //右视图显示的位置和大小
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightRect = CGRect.zero
        rightRect.origin.x = bounds.size.width - 31
        rightRect.size.height = 18
        rightRect.origin.y = (bounds.size.height - rightRect.size.height) / 2
        rightRect.size.width = 18
        return rightRect
    }
    //可输入的字符的区域
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.textRect(forBounds: bounds)
        if leftView == nil {
            return textRect.insetBy(dx: 10, dy: 0)
        }
        let offset = 37 - textRect.origin.x
        textRect.origin.x = 37
        textRect.size.width = textRect.size.width - offset - 20
        return textRect
    }
    //编辑显示的区域
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.editingRect(forBounds: bounds)
        if leftView == nil {
            return textRect.insetBy(dx: 10, dy: 0)
        }
        let offset = 37 - textRect.origin.x
        textRect.origin.x = 37
        textRect.size.width = textRect.size.width - offset - 20
        return textRect
    }
}
