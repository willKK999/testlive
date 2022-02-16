

import UIKit

class OLSettingCell: UITableViewCell {

    enum Styles {
        case arrow,
             rightSwitch,
             rightText,
             update,
             rightTextArrow,
             rightImage,
             title,
             imageAccessory
        
    }
    
    init(style: Styles) {
        super.init(style: .default, reuseIdentifier: OLSettingCell.description())
        textLabel?.font = UIFont.fontRegular(16)
        textLabel?.textColor = UIColor(hexString: "#333333")
        textLabel?.snp.makeConstraints({ make in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        })
        switch style {
        case .arrow:
            contentView.addSubview(arrowView)
            arrowView.snp.makeConstraints({ make in
                make.right.equalTo(-8)
                make.size.equalTo(CGSize(width: 16, height: 16))
                make.centerY.equalToSuperview()
            })
        case .rightSwitch:
            selectionStyle = .none
            contentView.addSubview(switchView)
            switchView.snp.makeConstraints({ make in
                make.right.equalTo(-10)
                make.centerY.equalToSuperview()
            })
        case .rightText:
            contentView.addSubview(detailLabel)
            detailLabel.snp.makeConstraints({ make in
                make.right.equalTo(-12)
                make.centerY.equalToSuperview()
            })
        case .update:
            contentView.addSubview(updateButton)
            updateButton.snp.makeConstraints({ make in
                make.right.equalTo(-10)
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 50, height: 26))
            })
        case .rightTextArrow:
            addSubview(arrowView)
            arrowView.snp.makeConstraints({ make in
                make.right.equalTo(-8)
                make.size.equalTo(CGSize(width: 18, height: 18))
                make.centerY.equalToSuperview()
            })
            contentView.addSubview(detailLabel)
            detailLabel.snp.makeConstraints({ make in
                make.right.equalTo(arrowView.snp.left)
                make.centerY.equalToSuperview()
            })
        case .rightImage:
            contentView.addSubview(avatarImageView)
            avatarImageView.snp.makeConstraints({ make in
                make.right.equalTo(-12)
                make.size.equalTo(CGSize(width: 48, height: 48))
                make.centerY.equalToSuperview()
            })
        case .title:
            selectionStyle = .none
            textLabel?.font = UIFont.fontRegular(14)
            backgroundColor = UIColor(hexString: "#F9F9F9")
        case .imageAccessory:
            contentView.addSubview(rightImageView)
            rightImageView.snp.makeConstraints({ make in
                make.right.equalTo(-28)
                make.size.equalTo(CGSize(width: 18, height: 18))
                make.centerY.equalToSuperview()
            })
        }
    }
    
    var detailText: String? {
        didSet {
            detailLabel.text = detailText
        }
    }
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right_6"))
        return view
    }()
    
    lazy var rightImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_language_right"))
        view.isHidden = true
        return view
    }()
    
    lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.onTintColor = UIColor(hexString: "#FF54A8")
        view.backgroundColor = UIColor(hexString: "#666666")
        view.transform = CGAffineTransform.init(scaleX: 0.65, y: 0.65)
        view.setLayerCorner(radius: 15.5)
        return view
    }()
    
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.font = UIFont.fontRegular(14)
        detailLabel.textColor = UIColor(hexString: "#666666")
        return detailLabel
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "update_bg"), for: .normal)
        button.setTitle("更新", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = .fontRegular(14)
        return button
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 12, y: 0, width: 48, height: 48))
        imageView.image = UIImage(named: "avatar")
        imageView.setLayerCorner(radius: 24,width: 1,color: UIColor(hexString: "#FFCEE6").cgColor)
        return imageView
    }()
   
    
    func setSelected(_ selected: Bool) {
        rightImageView.isHidden = !selected
    }
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
