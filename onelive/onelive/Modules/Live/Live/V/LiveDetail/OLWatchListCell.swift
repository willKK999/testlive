
import UIKit


class OLWatchListHeaderView: UIView {
    
    var model: OLLiveGuardModel! {
        didSet {
            if let url = URL(string: model?.avatar ?? "") {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            nameLabel.text = model?.nickName
            
            if let url = URL(string: model?.levelIcon ?? "") {
                levelImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            fireLabel.text = "上周贡献\(model?.firepower ?? "0"))火力"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(11)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 48, height: 48))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        addSubview(imageBGView)
        imageBGView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 66, height: 16))
        }
        
        addSubview(fireLabel)
        fireLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageBGView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_user_avatar"))
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(12)
        label.textColor = UIColor(hexString: "#000000")
        label.textAlignment = .center
        label.text = "残风"
        return label
    }()
    
    lazy var imageBGView: UIView = {
        let view = UIView(frame:CGRect(x: 0, y: 0, width: 66, height: 16))
        view.addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 37, height: 17))
        }
        view.addSubview(watchImageView)
        watchImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(levelImageView.snp.right)
            make.size.equalTo(CGSize(width: 20, height: 18))
        }
        return view
    }()
    
    lazy var watchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_watch"))
        return imageView
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level_w")
        return imageView
    }()
    
    lazy var fireLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#666666")
        label.textAlignment = .center
        label.text = "上周贡献5212火力"
        return label
    }()
}


class OLWatchListCell: UITableViewCell {

    var model: OLLiveGuardModel! {
        didSet {
            if let url = URL(string: model?.avatar ?? "") {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            nameLabel.text = model?.nickName
            
            if let url = URL(string: model?.levelIcon ?? "") {
                levelImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            fireLabel.text = "上周贡献\(model?.firepower ?? "0")火力"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(avatarImageView.snp.right).offset(6)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(12)
        }
        
        addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.left.equalTo(avatarImageView.snp.right).offset(6)
            make.size.equalTo(CGSize(width: 37, height: 17))
        }
        addSubview(watchImageView)
        watchImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.left.equalTo(levelImageView.snp.right)
            make.size.equalTo(CGSize(width: 16, height: 14))
        }
        
        addSubview(fireLabel)
        fireLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_user_avatar"))
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(12)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "卢本伟牛逼"
        return label
    }()
    
    lazy var watchImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_watch"))
        return imageView
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level_w")
        return imageView
    }()
    
    lazy var fireLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#666666")
        label.textAlignment = .center
        label.text = "上周贡献5212火力"
        return label
    }()
}

