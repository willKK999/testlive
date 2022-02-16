

import UIKit

class OLMeHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userInfoView)
        userInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(78)
        }
        addSubview(numView)
        numView.snp.makeConstraints { (make) in
            make.top.equalTo(userInfoView.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(55)
        }
        addSubview(userMenuView)
        userMenuView.snp.makeConstraints { (make) in
            make.top.equalTo(numView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(85)
        }
        addSubview(userGamesView)
        userGamesView.snp.makeConstraints { (make) in
            make.top.equalTo(userMenuView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        addSubview(messageAndTopView)
        messageAndTopView.snp.makeConstraints { (make) in
            make.top.equalTo(userGamesView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var userInfoView: OLUserInfoView = {
        let view = OLUserInfoView()
        return view
    }()
    
    lazy var numView: UIView = {
        let view = UIView()
        let itemWidth = (oScreenWidth - 24.0)/2
        view.addSubview(followView)
        followView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(35)
            make.width.equalTo(itemWidth)
        }
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(16.0)
            make.width.equalTo(1.0)
        }
        view.addSubview(fansView)
        fansView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(35)
            make.width.equalTo(itemWidth)
        }
        return view
    }()
    
    lazy var followView: NumInfoView = {
        let view = NumInfoView()
        view.numLabel.text = "5"
        view.nameLabel.text = "关注"
        return view
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hexString: "#CCCCCC").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var fansView: NumInfoView = {
        let view = NumInfoView()
        view.numLabel.text = "5"
        view.nameLabel.text = "粉丝"
        return view
    }()
    
    
    lazy var userMenuView: OLMeMenuView = {
        let view = OLMeMenuView()
        return view
    }()
    
    lazy var userGamesView: OLMeGamesView = {
        let view = OLMeGamesView()
        return view
    }()
    
    lazy var messageAndTopView: OLMessageAndTopView = {
        let view = OLMessageAndTopView()
        return view
    }()
    
}

class OLUserInfoView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
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
            make.top.equalToSuperview()
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(15)
        }
        
        addSubview(sexImageView)
        sexImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(sexImageView.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 28, height: 13))
        }
        
        addSubview(idLabel)
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sexImageView.snp.bottom).offset(10)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.height.equalTo(12)
        }
        
        addSubview(remarkLabel)
        remarkLabel.snp.makeConstraints { (make) in
            make.top.equalTo(idLabel.snp.bottom).offset(5)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.height.equalTo(12)
        }

        
        addSubview(arrowView)
        arrowView.snp.makeConstraints({ make in
            make.right.equalTo(-8)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 12, y: 0, width: 68, height: 68))
        imageView.image = UIImage(named: "avatar")
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var editButton: UIButton = {
        let button = OLReLayoutButton(style: .text_Image, space: 3)
        button.setImage(UIImage(named: "icon_me_edit"), for: .normal)
        button.setTitle("编辑资料", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(9)
        button.backgroundColor = UIColor(hexString: "#000000", alpha: 0.4)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontSemibold(15)
        label.textColor = UIColor(hexString: "#333333")
        label.text = "风魔小太郎"
        return label
    }()
    
    lazy var sexImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_man"))
        return imageView
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level")
        return imageView
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(10)
        label.textColor = UIColor(hexString: "#999999")
        label.text = "会员ID：abc123456"
        return label
    }()
    
    lazy var remarkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(10)
        label.textColor = UIColor(hexString: "#999999")
        label.text = "TA好像忘记了签名了"
        return label
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right_6"))
        return view
    }()
}


class NumInfoView: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(numLabel)
        numLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textColor = UIColor(hexString: "#333333")
        numLabel.font = UIFont.fontMedium(12)
        return numLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#999999")
        label.font = UIFont.fontRegular(12)
        return label
    }()
}

