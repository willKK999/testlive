

import UIKit

class OLLiveDetailCenterMenuView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(gameButton)
        gameButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(CGSize(width: 42, height: 42))
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(gameButton.snp.bottom).offset(5)
            make.centerX.equalTo(gameButton)
            make.size.equalTo(CGSize(width: 40, height: 12))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var gameButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        button.setImage(UIImage(named: "live_game"), for: .normal)
        button.layer.backgroundColor = UIColor.white.cgColor
        button.layer.cornerRadius = 21
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var timeLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(11)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "59秒"
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50)
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        return label
    }()
}
