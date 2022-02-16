

import UIKit

class OLWinningAnnounceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 340, height: 24))
        }
        addSubview(winningImageView)
        winningImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var winningImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_winning"))
        return imageView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: 340, height: 24))
        view.addGradient([UIColor(hexString: "#FFB3B2").cgColor,UIColor(hexString: "#FF54A8").cgColor], locations: [0,1], startPoint: CGPoint(x: 0.09, y: 0.13), endPoint: CGPoint(x: 0.85, y: 0.13))
        view.setLayerCorner(radius: 12)
        view.addSubview(textLabel)
        
        view.addSubview(watchButton)
        watchButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-3)
            make.size.equalTo(CGSize(width: 50, height: 20))
        }
        
        textLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(36)
            make.right.equalTo(watchButton.snp.left).offset(-6)
            make.height.equalTo(12)
        }
        return view
    }()
    
    lazy var textLabel: UILabel = {
        let  label = UILabel()
        label.textAlignment = .left
        let attrString = NSMutableAttributedString(string: "恭喜玩家卢本伟牛逼在分分时时彩赢得5000元")
        let strSubAttr1: [NSAttributedString.Key : Any] = [.font: UIFont.fontMedium(12),
        .foregroundColor: UIColor(hexString: "#FFFFFF"),
        ]
        attrString.addAttributes(strSubAttr1, range: NSRange(location: 0, length: 4))
        // attr2
        let strSubAttr2: [NSAttributedString.Key : Any] = [.font: UIFont.fontMedium(12),
        .foregroundColor: UIColor(hexString: "6BD8FF"),
        ]
        attrString.addAttributes(strSubAttr2, range: NSRange(location: 4, length: 5))
        // attr3
        let strSubAttr3: [NSAttributedString.Key : Any] = [.font: UIFont.fontMedium(12),
        .foregroundColor: UIColor(hexString: "#FFFFFF"),
        ]
        attrString.addAttributes(strSubAttr3, range: NSRange(location: 9, length: 8))
        // attr4
        let strSubAttr4: [NSAttributedString.Key : Any] = [.font: UIFont.fontMedium(12),
        .foregroundColor: UIColor(hexString: "#FFEFA4"),
        ]
        attrString.addAttributes(strSubAttr4, range: NSRange(location: 17, length: 5))
        label.attributedText = attrString
        return label
    }()
    
    lazy var watchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        button.backgroundColor = UIColor(hexString: "#FFFFFF")
        button.setTitle("去围观",  for: .normal)
        button.setTitleColor(UIColor(hexString: "#FF54A8"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(10)
        button.setLayerCorner(radius: 10)
        return button
    }()
}
