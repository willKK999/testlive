

import UIKit

class OLSecurityHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 144, height: 118))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 144, height: 118))
        imageView.image = UIImage(named: "icon_security")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(14)
        label.textColor = UIColor(hexString: "#FE625D")
        label.text = "安全等级-低"
        return label
    }()

}


class OLSecurityFooterView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
        }
        addSubview(certificationView)
        certificationView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(14)
        label.textColor = UIColor(hexString: "#666666")
        label.text = "实名认证手机号码将用于以下功能"
        return label
    }()
    
    lazy var certificationView: UIView = {
        let view  = OLSafetyCertificationView()
        return view
    }()
    
    
}


class OLSafetyCertificationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(phoneView)
        phoneView.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.size.equalTo(CGSize(width: 48, height: 55))
            make.bottom.equalToSuperview()
        }
        addSubview(safetyView)
        safetyView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 48, height: 55))
            make.bottom.equalToSuperview()
        }
        addSubview(earningsView)
        earningsView.snp.makeConstraints { (make) in
            make.right.equalTo(-50)
            make.size.equalTo(CGSize(width: 48, height: 55))
            make.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var phoneView: UIView = {
        let view = OLSecurityImageTextView()
        view.iconImageView.image = UIImage(named: "icon_phone_A")
        view.titleLabel.text = "手机认证"
        return view
    }()
    
    lazy var safetyView: UIView = {
        let view = OLSecurityImageTextView()
        view.iconImageView.image = UIImage(named: "icon_certification")
        view.titleLabel.text = "安全认证"
        return view
    }()
    
    lazy var earningsView: UIView = {
        let view = OLSecurityImageTextView()
        view.iconImageView.image = UIImage(named: "icon_earnings")
        view.titleLabel.text = "收益"
        return view
    }()
}

class OLSecurityImageTextView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 36, height: 36))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontMedium(12)
        label.textColor = UIColor(hexString: "#666666")
        return label
    }()
}
