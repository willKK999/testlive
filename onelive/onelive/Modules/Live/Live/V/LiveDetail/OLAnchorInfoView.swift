

import UIKit

class OLAnchorInfoView: UIButton {
    
    var liveAnchor: OLAnchorModel? {
        didSet {
            if let url = URL(string: liveAnchor?.avatar ?? "") {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            nameLabel.text = liveAnchor?.nickName
            idLabel.text = "ID：" + String(liveAnchor?.userId ?? 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.3)
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(3)
            make.size.equalTo(CGSize(width: 26, height: 26))
        }
        
        addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.right.equalTo(-4)
            make.size.equalTo(CGSize(width: 37, height: 24))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(avatarImageView.snp.right).offset(4)
            make.right.equalTo(followButton.snp.left).offset(-4)
            make.height.equalTo(10)
        }
        addSubview(idLabel)
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.left.equalTo(avatarImageView.snp.right).offset(4)
            make.right.equalTo(followButton.snp.left).offset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 3, y: 3, width: 26, height: 26))
        imageView.image = UIImage(named: "avatar")
        imageView.layer.cornerRadius = 13
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(11)
        label.textColor = UIColor.white
        label.text = "花和尚鲁智深"
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(9)
        label.textColor = UIColor.white
        label.text = "ID：9999"
        return label
    }()
    
    lazy var followButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "live_follow"), for: .normal)
        return button
    }()
}
