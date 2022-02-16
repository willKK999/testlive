

import UIKit

class OLForDiamondHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(noticeBGView)
        noticeBGView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(32)
        }
        
        addSubview(walletView)
        walletView.snp.makeConstraints { (make) in
            make.top.equalTo(noticeBGView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(120)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var noticeBGView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth - 24, height: 32))
        view.backgroundColor = UIColor(hexString: "#F5F5F5")
        view.layer.cornerRadius = 16
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(11)
            make.centerY.equalToSuperview()
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(17)
        }
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        imageView.image = UIImage(named: "icon_notice")
        return imageView
    }()
    
    lazy var titleLabel: UILabel =  {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.fontRegular(12)
        titleLabel.textColor = UIColor(hexString: "#333333")
        titleLabel.text = "本平台将为你打造一个高端舒适的颜值社区"
        return titleLabel
    }()
    
    lazy var walletView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: oScreenWidth - 24, height: 120))
        view.addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFD7B9").cgColor] , startPoint: CGPoint(x: -0.05, y: 0.13), endPoint: CGPoint(x: 0.95, y: 0.13))
        view.setLayerCorner(radius: 6)
        view.addSubview(balanceTitleLabel)
        balanceTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(38)
            make.left.equalTo(44)
            make.height.equalTo(20)
        }
        view.addSubview(balanceNumLabel)
        balanceNumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(balanceTitleLabel.snp.bottom)
            make.centerX.equalTo(balanceTitleLabel)
        }
        view.addSubview(diamondTitleLabel)
        diamondTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(38)
            make.left.equalTo(balanceTitleLabel.snp.right).offset(55)
            make.height.equalTo(20)
        }
        view.addSubview(diamondNumLabel)
        diamondNumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(diamondTitleLabel.snp.bottom)
            make.centerX.equalTo(diamondTitleLabel)
        }
        
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-30)
            make.size.equalTo(CGSize(width: 64, height: 64))
        }
        view.addSubview(payButton)
        payButton.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(7)
            make.centerX.equalTo(avatarImageView)
            make.size.equalTo(CGSize(width: 50, height: 26))
        }
        return view
    }()
    
    lazy var balanceTitleLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.fontMedium(14)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "余额"
        return label
    }()
                                
    lazy var balanceNumLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.fontMedium(18)
        label.textColor = UIColor(hexString: "#FFD843")
        label.text = "134.32"
        return label
    }()
    
    lazy var diamondTitleLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.fontMedium(14)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "钻石"
        return label
    }()
    
    lazy var diamondNumLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.fontMedium(18)
        label.textColor = UIColor(hexString: "#FFD843")
        label.text = "56"
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 12, y: 0, width: 64, height: 64))
        imageView.image = UIImage(named: "avatar")
        imageView.setLayerCorner(radius: 32)
        return imageView
    }()
    
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "update_bg"), for: .normal)
        button.setTitle("充值", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = .fontRegular(14)
        return button
    }()
}
