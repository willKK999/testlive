

import UIKit

class OLInformationHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "#FFFFFF")
        
        addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(228)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(145)
            make.left.equalTo(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(25)
        }
        
        addSubview(sexImageView)
        sexImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalTo(12)
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
        
        addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(sexImageView.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 46, height: 20))
        }
        
        addSubview(numView)
        numView.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(-20)
            make.left.right.equalToSuperview()
            make.height.equalTo(37)
        }
        
        addSubview(remarkView)
        remarkView.snp.makeConstraints { make in
            make.top.equalTo(numView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(67)
        }
        
        addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.equalTo(remarkView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(66)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "banner0"))
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(18)
        label.textColor = UIColor(hexString: "#FFFFFF")
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
    
    lazy var numView: InfoNumView = {
        let view = InfoNumView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 37))
       
        return view
    }()
    
    lazy var remarkView: InfoRemarkView = {
        let view = InfoRemarkView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 72))
        return view
    }()
    
    lazy var topView: InfoTopView = {
        let view = InfoTopView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 60))
        return view
    }()
    
}

class InfoNumView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "#FFFFFF")
        roundCorners([.topLeft,.topRight], radius: 12)
        
        addSubview(fansTitle)
        fansTitle.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
        
        addSubview(fansNum)
        fansNum.snp.makeConstraints { (make) in
            make.left.equalTo(fansTitle.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
        
        addSubview(followTitle)
        followTitle.snp.makeConstraints { (make) in
            make.left.equalTo(fansNum.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
        
        addSubview(followNum)
        followNum.snp.makeConstraints { (make) in
            make.left.equalTo(followTitle.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
        
        addSubview(giftTitle)
        giftTitle.snp.makeConstraints { (make) in
            make.left.equalTo(followNum.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
        
        addSubview(giftNum)
        giftNum.snp.makeConstraints { (make) in
            make.left.equalTo(giftTitle.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var fansTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#666666")
        titleLabel.font = UIFont.fontRegular(12)
        titleLabel.text = "粉丝"
        return titleLabel
    }()
    
    lazy var fansNum: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#333333")
        titleLabel.font = UIFont.fontMedium(12)
        titleLabel.text = "20"
        return titleLabel
    }()
    
    lazy var followTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#666666")
        titleLabel.font = UIFont.fontRegular(12)
        titleLabel.text = "关注"
        return titleLabel
    }()
    
    lazy var followNum: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#333333")
        titleLabel.font = UIFont.fontMedium(12)
        titleLabel.text = "2"
        return titleLabel
    }()
    
    lazy var giftTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#666666")
        titleLabel.font = UIFont.fontRegular(12)
        titleLabel.text = "送出礼物"
        return titleLabel
    }()
    
    lazy var giftNum: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#333333")
        titleLabel.font = UIFont.fontMedium(12)
        titleLabel.text = "5"
        return titleLabel
    }()
}


class InfoRemarkView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(-5)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(20)
            make.height.equalTo(20)
            make.width.equalTo(67)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .white
        titleLabel.textColor = UIColor(hexString: "#333333")
        titleLabel.font = UIFont.fontMedium(14)
        titleLabel.textAlignment = .center
        titleLabel.text = "关于TA"
        return titleLabel
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.setLayerCorner(radius: 5,width: 1,color: UIColor(hexString: "#CCCCCC").cgColor)
        view.addSubview(remarkLabel)
        remarkLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-15)
        }
        return view
    }()
    
    lazy var remarkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#999999")
        label.text = "TA好像忘记了签名了"
        return label
    }()
}


class InfoTopView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(52)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#FFE6F2")
        view.setLayerCorner(radius: 5)
        
        view.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(arrowView)
        arrowView.snp.makeConstraints({ make in
            make.right.equalTo(-6)
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.centerY.equalToSuperview()
        })
        
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalTo(arrowView.snp.left).offset(-5)
            make.centerY.equalToSuperview()
        }
        return view
    }()
    lazy var iconImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_user_contribute"))
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#FF54A8")
        label.text = "个人贡献榜"
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#E70172")
        titleLabel.font = UIFont.fontRegular(12)
        titleLabel.textAlignment = .right
        titleLabel.text = "Ta还未收到礼物"
        return titleLabel
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "arrow_right_E"))
        return view
    }()
}
