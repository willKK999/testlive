
import UIKit

class OLUserHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 68, height: 68))
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(60)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 68, height: 16))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.top).offset(8)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.height.equalTo(15)
        }
        
        addSubview(accountLabel)
        accountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.top).offset(10)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.height.equalTo(12)
        }
        
        addSubview(familyLabel)
        familyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(accountLabel.snp.top).offset(6)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.height.equalTo(12)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 12, y: 0, width: 68, height: 68))
        imageView.setLayerCorner(radius: 34)
        imageView.image = OLImage.avatar
        return imageView
    }()
    
    lazy var editButton: UIButton = {
        let button = OLReLayoutButton(style: .text_Image, space: 3)
        button.setImage(OLImage.icon_edit, for: .normal)
        button.setTitle("编辑资料", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(9)
        button.backgroundColor = UIColor(hexString: "#000000", alpha: 0.4)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = OLFont.PingFang_Semibold15
        label.textColor = OLColors.hex_333333
        label.text = "Welcome"
        return label
    }()
    
    lazy var accountLabel: UILabel = {
        let  label = UILabel()
        label.font = OLFont.PingFang_Regular14
        label.textColor = OLColors.hex_333333
        label.text = "账号：abc123456"
        return label
    }()
    
    lazy var familyLabel: UILabel = {
        let  label = UILabel()
        label.font = OLFont.PingFang_Regular14
        label.textColor = OLColors.hex_333333
        label.text = "家族：vhhffbifo"
        return label
    }()

}
