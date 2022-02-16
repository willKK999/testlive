

import UIKit

class OLMineLevelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的等级"
        setupUI()
        
    }
    
    func setupUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(nobleImageView)
        nobleImageView.snp.makeConstraints({ make in
            make.top.equalTo(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 128, height: 128))
        })
        view.addSubview(nobleBottomImageView)
        nobleBottomImageView.snp.makeConstraints({ make in
            make.top.equalTo(111)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 210, height: 61))
        })
        view.addSubview(levelLabel)
        levelLabel.snp.makeConstraints({ make in
            make.top.equalTo(nobleImageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 28))
        })
        view.addSubview(percentageLabel)
        percentageLabel.snp.makeConstraints({ make in
            make.top.equalTo(levelLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        })
        view.addSubview(progressBGView)
        progressBGView.snp.makeConstraints({ make in
            make.top.equalTo(percentageLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(12)
        })
        view.addSubview(titleView)
        titleView.snp.makeConstraints({ make in
            make.top.equalTo(progressBGView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(17)
        })
        view.addSubview(upgradeView)
        upgradeView.snp.makeConstraints({ make in
            make.top.equalTo(titleView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
            make.width.equalTo(308)
            make.height.equalTo(147)
        })
    }

    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_level_bg"))
        return imageView
    }()
    
    lazy var nobleImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_level_noble"))
        return imageView
    }()

    lazy var nobleBottomImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_noble_bottom"))
        return imageView
    }()
    
    lazy var levelLabel: UILabel = {
        let  label = UILabel()
        label.backgroundColor = UIColor(hexString: "#FFFFFF")
        label.setLayerCorner(radius: 14)
        label.font = UIFont.fontMedium(18)
        label.textColor = UIColor(hexString: "#FF54A8")
        label.text = "LV.1"
        label.textAlignment = .center
        return label
    }()
    
    lazy var percentageLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "50%"
        return label
    }()
    
    var progress = 0.6
    
    lazy var progressView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300.0*progress, height: 12.0))
        view.addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFBCE0").cgColor,UIColor(hexString: "#FF63E8").cgColor] ,locations:[0, 0.54, 1], startPoint:CGPoint(x: 0.59, y: 1.00), endPoint: CGPoint(x: 0.59, y: 0.00))
        view.setLayerCorner(radius: 6)
        return view
    }()
    
    lazy var progressBGView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 12))
        view.backgroundColor = UIColor(hexString: "#FBD5F0")
        view.setLayerCorner(radius: 6)
        view.addSubview(progressView)
        progressView.snp.makeConstraints({ make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(300.0*progress)
            make.height.equalTo(12)
        })
        return view
    }()
    lazy var upgradeLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "距离升级：50"
        return label
    }()
    
    lazy var titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300.0, height: 17.0))
        let leftLabel = UILabel()
        leftLabel.font = .fontMedium(12)
        leftLabel.textColor = UIColor(hexString: "#FFFFFF")
        leftLabel.text = "经验值"
        view.addSubview(leftLabel)
        leftLabel.snp.makeConstraints({ make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        view.addSubview(upgradeLabel)
        upgradeLabel.snp.makeConstraints({ make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        return view
    }()
    
    lazy var upgradeView: UIView = {
        let view = UpgradeView()
        return view
    }()
}

class UpgradeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(22)
        }
        
        addSubview(videoView)
        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 51, height: 20))
            make.centerX.equalToSuperview()
        }
        addSubview(giftView)
        giftView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView)
            make.left.equalTo(35)
            make.size.equalTo(CGSize(width: 51, height: 20))

        }
        addSubview(shareView)
        shareView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView)
            make.right.equalTo(-35)
            make.size.equalTo(CGSize(width: 51, height: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_upgrade_bg"))
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#FFCEE6")
        titleLabel.font = .fontMedium(16)
        titleLabel.text = "如何升级"
        return titleLabel
    }()
    
    lazy var giftView: UIView = {
        let view = OLLevelImageTextView()
        view.iconImageView.image = UIImage(named: "icon_level_gift")
        view.titleLabel.text = "送礼"
        return view
    }()
    
    lazy var videoView: UIView = {
        let view = OLLevelImageTextView()
        view.iconImageView.image = UIImage(named: "icon_level_video")
        view.titleLabel.text = "看播"
        return view
    }()
    
    lazy var shareView: UIView = {
        let view = OLLevelImageTextView()
        view.iconImageView.image = UIImage(named: "icon_level_share")
        view.titleLabel.text = "分享"
        return view
    }()
}


class OLLevelImageTextView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(3)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(14)
        label.textColor = UIColor(hexString: "#333333")
        return label
    }()
}
