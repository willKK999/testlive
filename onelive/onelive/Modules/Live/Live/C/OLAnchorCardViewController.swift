

import UIKit

class OLAnchorCardViewController: OLBaseViewController{

    var roomDetail: OLRoomDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        self.showLoading()
        OLAPIManager.shared.getAnchorDetailInfo(anchorId: roomDetail!.anchorId) { [weak self]  result in
            guard let self = self else {return}
            self.hideLoading()
            if result.isSuccess {
//                if let model = result.data {
//                    
//                }
                self.setUI()
            }else {
                self.showToast(result.msg!)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    var userInfo: OLUserModel! {
        didSet {
            if let url = URL(string: userInfo.avatar ?? "") {
                avatarView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            nameLabel.text = (userInfo.nickName ?? "") + "的名片"
            aboutLabel.text = userInfo.remark
            
        }
    }
    
    func setUI() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 280, height: 312))
        }
    }
    
    // MARK: lazy
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: 312))
        view.layer.backgroundColor = UIColor.white.cgColor
        view.setLayerCorner(radius: 12)
        
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.size.equalTo(CGSize(width: 18, height:18))
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        view.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height:60))
        }
        
        view.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
        
        view.addSubview(contactView)
        contactView.snp.makeConstraints { (make) in
            make.top.equalTo(aboutLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 233, height: 32))
        }
        
        view.addSubview(planLabel)
        planLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(34)
        }
        
        
        view.addSubview(hintLabel)
        hintLabel.snp.makeConstraints { (make) in
            make.top.equalTo(planLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(170)
            make.height.equalTo(28)
        }
        
        return view
    }()
    
    lazy var avatarView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        imageView.image = UIImage(named: "live_placeholder")
        imageView.setLayerCorner(radius: 30)
        return imageView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_cancel"), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontMedium(14)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "西门吹雪的名片"
        return label
    }()
    
    lazy var aboutLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontMedium(12)
        label.textColor = UIColor(hexString: "#666666")
        label.text = "主播好像忘记说什么了！"
        return label
    }()
    
    lazy var contactView: OLContactView = {
        let view = OLContactView(frame: CGRect(x: 0, y: 0, width: 233, height: 32))
        return view
    }()
    
    lazy var planLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontRegular(12)
        label.numberOfLines = 2
        label.textColor = UIColor(hexString: "#666666")
        label.text = "获取名片进度\n赠送礼物达到要求即可获取"
        return label
    }()
    
    lazy var hintLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .fontRegular(10)
        label.numberOfLines = 2
        label.textColor = UIColor(hexString: "#666666")
        label.text = "1.添加时请备注昵称避免主播无法区分\n2.联系方式如有虚假可通过客房投诉"
        return label
    }()
    
    @objc func cancelButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        let touchesPoint = touch.location(in: self.view)
        oPrint(touchesPoint)
        //判断是否点击到了不包含的view
        if !contentView.frame.contains(touchesPoint) && !avatarView.frame.contains(touchesPoint) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

class OLContactView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFD7B9").cgColor] , startPoint:CGPoint(x: -0.05, y: 0.13), endPoint: CGPoint(x: 0.95, y: 0.13))
        setLayerCorner(radius: 16)
        
        addSubview(weChatImageView)
        weChatImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(17)
        }
        
        addSubview(getButton)
        getButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 44, height: 24))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var weChatImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image = UIImage(named: "icon_weChat")
        return imageView
    }()

    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontMedium(12)
        label.textColor = UIColor(hexString: "#000000")
        label.text = "**************"
        return label
    }()
    
    lazy var getButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("获取", for: .normal)
        button.titleLabel?.font = .fontMedium(12)
        button.setTitleColor(UIColor(hexString: "#FF54A8"), for: .normal)
        button.backgroundColor = .white
        button.setLayerCorner(radius: 12)
        return button
    }()
}
