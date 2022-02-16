

import UIKit

class OLAnchorInfoViewController: UIViewController {

    var live: OLLiveItemModel!
    var roomDetail: OLRoomDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(310.0 + oSafeAreaBottomHeight())
        }
        
        view.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(-33)
            make.centerX.equalTo(contentView)
            make.size.equalTo(CGSize(width: 66, height:66))
        }
        OLAPIManager.shared.getUserDetailInfo(userId: roomDetail!.userId!) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let model = result.data {
                    self.userInfo = model
                }
            }
        }
       
    }
    
    var userInfo: OLUserModel! {
        didSet {
            if let url = URL(string: userInfo.avatar ?? "") {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "avatar"))
            }
            nameView.setTitle(userInfo.nickName, for: .normal)
            nameView.setImage(userInfo.sex == 1 ? UIImage(named: "icon_man") : UIImage(named: "icon_woman"), for: .normal)
            idLabel.text = "会员ID：" + String(userInfo.userId ?? 0)
            if let url = URL(string: userInfo.levelIcon ?? "") {
                levelImageView.kf.setImage(with: url, placeholder: UIImage(named: "icon_level"))
            }
            aboutLabel.text = userInfo.remark
            bottomView.followView.numLabel.text = String(userInfo.focusNum ?? 0)
            bottomView.fansView.numLabel.text = String(userInfo.focusNum ?? 0)
            bottomView.fireView.numLabel.text = userInfo.firepower
        }
    }
    
    // MARK: lazy
    lazy var avatarImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 66, height: 66))
        imageView.image = UIImage(named: "avatar")
        imageView.setLayerCorner(radius: 33, width: 2, color: UIColor.white.cgColor)
        return imageView
    }()
    
    lazy var avatarView: UIView = {
        let view =  UIView(frame: CGRect(x: 0, y: 0, width: 66, height: 66))
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 310.0 + oSafeAreaBottomHeight()))
        view.layer.backgroundColor = UIColor.white.cgColor
        view.roundCorners([.topLeft, .topRight], radius: 18)
        
        view.addSubview(reportButton)
        reportButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 28, height:18))
        }
        
        view.addSubview(nameView)
        nameView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(52)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 75, height:22))
        }
        
        view.addSubview(idLabel)
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
        
        view.addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.top.equalTo(idLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height:13))
        }
        
        view.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints { (make) in
            make.top.equalTo(levelImageView.snp.bottom).offset(19)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
        
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(aboutLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(133)
        }
        return view
    }()
    
    lazy var reportButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("举报", for: .normal)
        button.setTitleColor(UIColor(hexString: "#999999"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(13)
        return button
    }()
    
    lazy var nameView: UIButton = {
        let button = OLReLayoutButton(style: .text_Image, space: 4)
        button.setImage(UIImage(named: "icon_woman"), for: .normal)
        button.setTitle("西门吹雪", for: .normal)
        button.setTitleColor(UIColor(hexString: "#000000"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(16)
        return button
    }()
    
    lazy var idLabel: UILabel =  {
        let idLabel = UILabel()
        idLabel.textAlignment = .center
        idLabel.font = .fontRegular(12)
        idLabel.textColor = UIColor(hexString: "#666666")
        idLabel.text = "会员ID：6353828"
        return idLabel
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level")
        return imageView
    }()
    
    lazy var aboutLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontMedium(12)
        label.textColor = UIColor(hexString: "#666666")
        label.text = "主播好像忘记说什么了！"
        return label
    }()
    
    lazy var bottomView: BottomView = {
        let view = BottomView()
        return view
    }()
    
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



class BottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let itemWidth = (oScreenWidth - 24.0)/3
        addSubview(followView)
        followView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(itemWidth)
        }
        
        addSubview(fansView)
        fansView.snp.makeConstraints { (make) in
            make.left.equalTo(followView.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(itemWidth)
        }
        
        addSubview(fireView)
        fireView.snp.makeConstraints { (make) in
            make.left.equalTo(fansView.snp.right)
            make.top.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(itemWidth)
        }
        
        addSubview(topLine)
        topLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(63)
            make.left.right.equalToSuperview()
            make.height.equalTo(1.0)
        }
        addSubview(homeButton)
        homeButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.top.equalTo(topLine.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
        addSubview(linkButton)
        linkButton.snp.makeConstraints { (make) in
            make.left.equalTo(homeButton.snp.right)
            make.top.equalTo(topLine.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
        addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.left.equalTo(linkButton.snp.right)
            make.top.equalTo(topLine.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var followView: InfoBottomView = {
        let view = InfoBottomView()
        view.numLabel.text = "10"
        view.titleLabel.text = "关注"
        return view
    }()
    
    lazy var fansView: InfoBottomView = {
        let view = InfoBottomView()
        view.numLabel.text = "4532"
        view.titleLabel.text = "粉丝"
        return view
    }()
    
    lazy var fireView: InfoBottomView = {
        let view = InfoBottomView()
        view.numLabel.text = "4532"
        view.titleLabel.text = "火力"
        return view
    }()
    
    
    lazy var topLine: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(hexString: "#F5F5F5").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var homeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("主页", for: .normal)
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(16)
        let line = UIView()
        line.layer.borderColor = UIColor(hexString: "#F5F5F5").cgColor
        line.layer.borderWidth = 1
        button.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(22)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 1, height: 26))
        }
        return button
    }()
    
    lazy var linkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("@TA", for: .normal)
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(16)
        let line = UIView()
        line.layer.borderColor = UIColor(hexString: "#F5F5F5").cgColor
        line.layer.borderWidth = 1
        button.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(22)
            make.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 1, height: 26))
        }
        return button
    }()
    lazy var followButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("已关注", for: .normal)
        button.setTitleColor(UIColor(hexString: "#666666"), for: .normal)
        button.titleLabel?.font = UIFont.fontMedium(16)
        return button
    }()
}

class InfoBottomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(numLabel)
        numLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(17)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textColor = UIColor.black
        numLabel.font = UIFont.fontMedium(14)
        return numLabel
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hexString: "#666666")
        titleLabel.font = UIFont.fontRegular(12)
        return titleLabel
    }()
}
