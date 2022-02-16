
import UIKit

class OLPasswordTextField: OLLoginTextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //right
        let rightView = UIImageView(frame: CGRect(x: 0, y: 7, width: 18, height: 18))
        rightView.image = OLImage.open_eyes
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

}
