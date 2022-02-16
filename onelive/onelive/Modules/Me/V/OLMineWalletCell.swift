

import UIKit

class OLMineWalletCell: UITableViewCell {
    
    enum WalletStyles {
        case balance,
             diamond,
             other
    }
    
    init(style: WalletStyles) {
        super.init(style: .default, reuseIdentifier: OLMineWalletCell.description())
        selectionStyle = .none
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        textLabel?.font = .fontMedium(22)
        textLabel?.textColor = UIColor(hexString: "#FFFFFF")
        textLabel?.textAlignment = .center
        textLabel?.snp.makeConstraints({ make in
            make.top.equalTo(42)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        })
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(textLabel!.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
        }
        switch style {
        case .balance:
            backgroundImageView.image = UIImage(named: "bg_wallet_balance")
            contentView.addSubview(recordButton)
            recordButton.snp.makeConstraints { make in
                make.top.equalTo(12)
                make.right.equalTo(-20)
                make.size.equalTo(CGSize(width: 75, height: 20))
            }
            contentView.addSubview(rechargeAndWithdrawalView)
            rechargeAndWithdrawalView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 312, height: 32))
            }
        case .diamond:
            backgroundImageView.image = UIImage(named: "bg_wallet_diamond")
            contentView.addSubview(recordButton)
            recordButton.snp.makeConstraints { make in
                make.top.equalTo(12)
                make.right.equalTo(-20)
                make.size.equalTo(CGSize(width: 75, height: 20))
            }
            contentView.addSubview(exchangeButton)
            exchangeButton.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 146, height: 32))
            }
        case .other:
            backgroundImageView.image = UIImage(named: "bg_wallet_other")
            contentView.addSubview(exchangeButton)
            exchangeButton.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 146, height: 32))
            }
        }
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(16)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.textAlignment = .center
        return label
    }()
    
    lazy var recordButton: UIButton = {
        let button = OLReLayoutButton(style: .text_Image, space: 1)
        button.setImage(UIImage(named: "arrow_right_w"), for: .normal)
        button.setTitle("充提记录", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(14)
        return button
    }()
    
    lazy var rechargeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("充值", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(15)
        button.setLayerCorner(radius: 16, width: 1, color: UIColor(hexString: "#FFFFFF").cgColor)
        return button
    }()
    
    lazy var withdrawalButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("提现", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(15)
        button.setLayerCorner(radius: 16, width: 1, color: UIColor(hexString: "#FFFFFF").cgColor)
        return button
    }()
    
    lazy var rechargeAndWithdrawalView: UIView  = {
        let view = UIView()
        view.addSubview(rechargeButton)
        rechargeButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 146, height: 32))
        }
        view.addSubview(withdrawalButton)
        withdrawalButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 146, height: 32))
        }
        return view
    }()
    
    lazy var exchangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("兑换钻石", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(15)
        button.setLayerCorner(radius: 16, width: 1, color: UIColor(hexString: "#FFFFFF").cgColor)
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
