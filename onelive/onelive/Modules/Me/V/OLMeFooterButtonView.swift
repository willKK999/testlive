 

import UIKit

class OLMeFooterButtonView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(footerButton)
        footerButton.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(frame.width - 24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var footerButton: UIButton = {
        let button = UIButton(type: .custom)
        let imageView = UIView(frame:CGRect(x: 0, y: 0, width: oScreenWidth - 24, height: 50))
        imageView.backgroundColor = UIColor(hexString: "#FF54A8")
        button.setBackgroundImage(imageView.asImage(), for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = .fontRegular(18)
        button.setLayerCorner(radius: 25)
        return button
    }()
    

}
