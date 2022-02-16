

import UIKit

class OLContributionListHeaderView: UIView {
    
    var contributeList: [OLLiveContributeModel] = []{
        didSet {
            for (i, item) in contributeList.enumerated() {
                if i == 3 {
                    break
                }
                switch i {
                case 0:
                    centerView.model = item
                    addSubview(centerView)
                    centerView.snp.makeConstraints { (make) in
                        make.top.equalTo(typeView.snp.bottom).offset(6)
                        make.centerX.equalToSuperview().offset(-10)
                        make.width.equalTo(100)
                        make.bottom.equalToSuperview()
                    }
                case 1:
                    leftView.model = item
                    addSubview(leftView)
                    leftView.snp.makeConstraints { (make) in
                        make.top.equalTo(typeView.snp.bottom).offset(35)
                        make.right.equalTo(centerView.snp.left)
                        make.width.equalTo(100)
                        make.bottom.equalToSuperview()
                    }
                case 2:
                    rightView.model = item
                    addSubview(rightView)
                    rightView.snp.makeConstraints { (make) in
                        make.top.equalTo(typeView.snp.bottom).offset(50)
                        make.left.equalTo(centerView.snp.right)
                        make.width.equalTo(100)
                        make.bottom.equalToSuperview()
                    }
                default:
                    break
                }
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        addSubview(typeView)
        typeView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "contribute_head_bg"))
        return imageView
    }()
    
    lazy var typeView: OLListTypeView = {
        let view = OLListTypeView(style: .contribution)
        return view
    }()
    
    lazy var leftView: OLContributionTopView = {
        let view = OLContributionTopView(No: .two)
        return view
    }()
    
    lazy var centerView: OLContributionTopView = {
        let view = OLContributionTopView(No: .one)
        return view
    }()
    
    lazy var rightView: OLContributionTopView = {
        let view = OLContributionTopView(No: .three)
        return view
    }()

}

enum TopNo: Int {
    case one
    case two
    case three
}

class OLContributionTopView: UIView {
    
    var No: TopNo!
    
    var model: OLLiveContributeModel! {
        didSet {
            if let url = URL(string: model?.avatar ?? "") {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            nameLabel.text = model?.nickName
            
            if let url = URL(string: model?.levelIcon ?? "") {
                levelImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            if No != .one {
                fireLabel.text = "落后\(model?.firepower ?? "0")火力"
            }
        }
    }
   
    
    init(No:TopNo){
        super.init(frame: .zero)
        self.No = No
        var size = CGSize(width: 64, height: 64)
        var top = 25
        switch No {
        case .one:
            top  = 25
            size  = CGSize(width: 68, height: 68)
        case .two:
            top  = 15
            fireLabel.text = "落后32万火力"
        case .three:
            top  = 5
            fireLabel.text = "落后32万火力"
        }
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(size)
        }
                
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(top)
            make.centerX.equalToSuperview()
            make.height.equalTo(18)
        }
        
        addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 13))
        }
        
        addSubview(fireLabel)
        fireLabel.snp.makeConstraints { (make) in
            make.top.equalTo(levelImageView.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
//        bgLayerView.addSubview(followButton)
//        followButton.snp.makeConstraints { (make) in
//            make.top.equalTo(fireLabel.snp.bottom).offset(6)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize(width: 37, height: 24))
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_user_avatar"))
        return imageView
    }()
    
//    lazy var bgLayerView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: bgHeight))
//
//        let bgLayer = CAGradientLayer()
//        bgLayer.colors = [UIColor(hexString: "#6B69FF",alpha:0.0).cgColor, UIColor(hexString: "#FA7AFF").cgColor]
//        bgLayer.locations = [0, 1]
//        bgLayer.startPoint = CGPoint(x: 0.50, y: 0.89)
//        bgLayer.endPoint = CGPoint(x: 0.50, y: 0.00)
//        bgLayer.frame = view.bounds
//        let maskBGLayer = CAShapeLayer()
//        maskBGLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
//        bgLayer.mask = maskBGLayer
//        view.layer.addSublayer(bgLayer)
//
//        let borderLayer = CAGradientLayer()
//        borderLayer.colors = [UIColor(hexString: "#FDF4B4").cgColor, UIColor(hexString: "#FAE57D",alpha:0.0).cgColor]
//        borderLayer.locations = [0, 1]
//        borderLayer.frame = view.bounds
//        let maskLayer = CAShapeLayer()
//        maskLayer.lineWidth = 2.0
//        maskLayer.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 18, height: 18)).cgPath
//        maskLayer.fillColor = UIColor.clear.cgColor
//        maskLayer.strokeColor = UIColor.black.cgColor
//        borderLayer.mask = maskLayer
//        view.layer.addSublayer(borderLayer)
//
//        return view
//    }()
    
    lazy var NoLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(13)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.textAlignment = .center
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(12)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.textAlignment = .center
        label.text = "残风"
        return label
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level_w")
        return imageView
    }()
    
    lazy var fireLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(10)
        label.textColor = UIColor(hexString: "#FFFFFF")
        return label
    }()
    
    lazy var followButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "live_follow"), for: .normal)
        return button
    }()
}


class OLContributionListCell: UITableViewCell {
    
    var model: OLLiveContributeModel! {
        didSet {
            if let url = URL(string: model?.avatar ?? "") {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            nameLabel.text = model?.nickName
            
            if let url = URL(string: model?.levelIcon ?? "") {
                levelImageView.kf.setImage(with: url, placeholder: UIImage(named: "icon_level"))
            }
            fireLabel.text = "落后\(model?.firepower ?? "0")火力"
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
        addSubview(NoLabel)
        NoLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 14, height: 14))
        }
        
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.left.equalTo(NoLabel.snp.right).offset(6)
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
        
        addSubview(fireLabel)
        fireLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalTo(avatarImageView.snp.right).offset(6)
            make.height.equalTo(12)
        }
        
        addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-110)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 37, height: 17))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var NoLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(8)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.textAlignment = .center
        label.setLayerCorner(radius: 7)
        label.backgroundColor = UIColor(hexString: "#FF54A8")
        return label
    }()
    
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
    
    lazy var fireLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#999999")
        label.text = "落后32万火力"
        return label
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level_w")
        return imageView
    }()
    
}

