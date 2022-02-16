

import UIKit

class OLOnlineAudienceViewController: UIViewController {

    var live: OLLiveItemModel!
    var roomDetail: OLRoomDetailModel!
    var onlineList: [OLOnlineModel] = []
    
    var onlineUsersCount: Int? {
        didSet {
            titleLabel.text = "在线人数(" + String(onlineUsersCount!) + ")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(430.0 + oSafeAreaBottomHeight())
        }
        
        OLAPIManager.shared.onlineUsersCount(studioNum: live.studioNum!) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let data = result.data {
                    self.onlineUsersCount = data
                }
            }
        }
        
        OLAPIManager.shared.onlineUsers(studioNum: live.studioNum!) { [weak self]  result in
            guard let self = self else {return}
            if result.isSuccess {
                if let data = result.data {
                    self.onlineList = data
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 430.0 + oSafeAreaBottomHeight()))
        view.backgroundColor = UIColor(hexString: "#000000", alpha: 0.6)
        view.roundCorners([.topLeft, .topRight], radius: 6)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(23)
            make.centerX.equalToSuperview()
            make.height.equalTo(14)
        }
        view.addSubview(titleBottomLine)
        titleBottomLine.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 16, height: 2))
        }
        view.addSubview(openContentView)
        openContentView.snp.makeConstraints { (make) in
            make.top.equalTo(titleBottomLine.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: oScreenWidth - 24, height: 32))
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(openContentView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: oScreenWidth - 24, height: 294))
        }
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(39)
        }
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
        if !contentView.frame.contains(touchesPoint){
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    lazy var titleLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontMedium(14)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "在线人数(" + self.roomDetail.onlineNum! + ")"
        return label
    }()
    
    lazy var titleBottomLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 2))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 1
        view.addGradient([UIColor(hexString: "#FF68B2").cgColor,UIColor(hexString: "#FFB1B0").cgColor],startPoint:  CGPoint(x: 0.09, y: 0.13),endPoint: CGPoint(x: 0.94, y: 0.13))
        return view
    }()
    
    lazy var openContentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: oScreenWidth - 24, height: 32))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 16
//        view.addGradient([UIColor(hexString: "#FF54EE").cgColor,UIColor(hexString: "#FFD7B9").cgColor],startPoint:  CGPoint(x: -0.05, y: 0.13),endPoint:  CGPoint(x: 0.95, y: 0.13))
        view.backgroundColor = UIColor(hexString: "#191919")
        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
        }
        view.addSubview(openButton)
        openButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 24))
        }
        return view
    }()
    
    lazy var textLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .fontRegular(13)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "加入贵族，享受独一无二的豪华特权"
        return label
    }()
    
    lazy var openButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("立即开通", for: .normal)
        button.setTitleColor(UIColor(hexString: "#FFFFFF"), for: .normal)
        button.titleLabel?.font = UIFont.fontRegular(10)
        button.layer.borderColor = UIColor(hexString: "#FFFFFF").cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
//        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OLOnlineAudienceCell.self, forCellReuseIdentifier: OLOnlineAudienceCell.description())
        return tableView
    }()
    
    lazy var bottomView: UIView = {
        let view = OLOnlineAudienceBottomLine(frame: CGRect(x: 0, y: 0, width: oScreenWidth, height: 39))
        view.backgroundColor = .clear
        return view
    }()
}

extension OLOnlineAudienceViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.onlineList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OLOnlineAudienceCell.description(), for: indexPath) as! OLOnlineAudienceCell
        cell.model = self.onlineList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class OLOnlineAudienceCell: UITableViewCell {
    
    var model: OLOnlineModel! {
        didSet {
            if let url = URL(string: model.avatar ?? "") {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "user_avatar_icon"))
            }
            if let url = URL(string: model.levelIcon ?? "") {
                levelImageView.kf.setImage(with: url, placeholder: UIImage(named: "icon_level"))
            }
            nameLabel.text = model.nickName
            sexImageView.image = model.sex == 1 ? UIImage(named: "icon_man") : UIImage(named: "icon_woman")
        }
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.size.height -= 1
            super.frame = frame
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(9)
            make.left.equalTo(avatarImageView.snp.right).offset(7)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(12)
        }
        
        addSubview(sexImageView)
        sexImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
            make.left.equalTo(avatarImageView.snp.right).offset(7)
            make.size.equalTo(CGSize(width: 8, height: 8))
        }
        addSubview(levelImageView)
        levelImageView.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(sexImageView.snp.right).offset(5)
            make.size.equalTo(CGSize(width: 28, height: 13))
        }
        
    }
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let  label = UILabel()
        label.font = UIFont.fontRegular(12)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "赫莲娜绿"
        return label
    }()
    
    lazy var sexImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_woman"))
        return imageView
    }()
    
    lazy var levelImageView: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 28, height: 13))
        imageView.image = UIImage(named: "icon_level")
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class OLOnlineAudienceBottomLine: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 123, height: 17))
        }
        
        addSubview(leftLine)
        leftLine.snp.makeConstraints { (make) in
            make.right.equalTo(textLabel.snp.left).offset(-5)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 1))
        }
        
        addSubview(rightLine)
        rightLine.snp.makeConstraints { (make) in
            make.left.equalTo(textLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 1))
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var textLabel: UILabel =  {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .fontRegular(12)
        label.textColor = UIColor(hexString: "#FFFFFF")
        label.text = "仅显示前50个在线用户"
        return label
    }()
    
    lazy var leftLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 1))
        view.backgroundColor = UIColor(hexString: "#999999")
        return view
    }()
    
    lazy var rightLine: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 1))
        view.backgroundColor = UIColor(hexString: "#999999")
        return view
    }()
}
