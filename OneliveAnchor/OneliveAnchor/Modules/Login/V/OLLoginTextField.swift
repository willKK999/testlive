

import UIKit

class OLLoginTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        font = OLFont.PingFang_Regular16
        textColor = OLColors.hex_333333
        setLayerCorner(radius: 5, corners: .allCorners, width: 1, color: OLColors.hexa_363636CC.cgColor)
        //left
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
