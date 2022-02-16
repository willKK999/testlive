

import UIKit

class OLGamesBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topLine)
        topLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.top.equalToSuperview()
            
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 42, height: 20))
        }
        
        addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.left.equalTo(titleLabel.snp.right)
            make.height.equalTo(20)
        }
        
        addSubview(bettingButton)
        bettingButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 67, height: 30))
        }
        
        addSubview(arrowButton)
        arrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(bettingButton.snp.left).offset(-5)
            make.size.equalTo(CGSize(width: 45, height: 20))
        }
        
        addSubview(rechargeButton)
        rechargeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(arrowButton.snp.left).offset(-15)
            make.size.equalTo(CGSize(width: 67, height: 30))
        }
        
        addSubview(switchButton)
        switchButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(rechargeButton.snp.left).offset(-8)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var topLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hexString: "#F5F5F5").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(14)
        label.textColor = UIColor(hexString: "#666666")
        label.text = "余额："
        return label
    }()
    
    lazy var balanceLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(14)
        label.textColor = UIColor(hexString: "#FF54A8")
        label.text = "0"
        return label
    }()
    
    lazy var switchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_switch"), for: .normal)
        return button
    }()
    
    lazy var rechargeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 67, height: 30)
        button.setTitle("充值", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(14)
        button.setBackgroundImage(UIImage(named: "bet_button_bg"), for: .normal)
        button.setLayerCorner(radius: 15)
        return button
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView  = UIImageView(image: UIImage(named: "arrow_top_g"))
        return imageView
    }()
    lazy var chipImageView: UIImageView = {
        let imageView  = UIImageView(image: UIImage(named: "icon_chip"))
        return imageView
    }()
    lazy var arrowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 67, height: 30)
        button.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        button.addSubview(chipImageView)
        chipImageView.snp.makeConstraints { make in
            make.right.equalTo(arrowImageView.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
        return button
    }()
    
    lazy var bettingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 67, height: 30)
        button.setTitle("投注", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(14)
        button.setBackgroundImage(UIImage(named: "bet_button_bg"), for: .normal)
        button.setLayerCorner(radius: 15)
        return button
    }()
    
}
