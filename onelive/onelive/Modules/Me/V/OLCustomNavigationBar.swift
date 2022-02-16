

import UIKit

class OLCustomNavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: lazy
    lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(rightView)
        rightView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.width.equalTo(30.0)
            make.height.equalTo(44.0)
        }
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView()
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        return view
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_me_setting"), for: UIControl.State.normal)
//        button.addTarget(self, action: #selector(searchButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
}
